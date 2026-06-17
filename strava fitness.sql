create database fitness_analysis;
USE fitness_analysis;
SELECT DATABASE();
-- 1. Total Number of Records in Each Table

SELECT COUNT(*) AS total_daily_activity_records
FROM dailyactivity_merged;

SELECT COUNT(*) AS total_sleep_records
FROM sleepday_merged;

SELECT COUNT(*) AS total_hourly_step_records
FROM hourlysteps_merged;

 -- 2. Average Daily Steps
 SELECT 
ROUND(AVG(TotalSteps),2) AS avg_daily_steps
FROM dailyactivity_merged;

-- 3. Average Calories Burned
-- ----------------------------------------

SELECT
ROUND(AVG(Calories),2) AS avg_calories_burned
FROM dailyactivity_merged;

-- 4. Most Active Users (Top 10)
-- ----------------------------------------

SELECT
Id,
ROUND(AVG(TotalSteps),2) AS avg_steps
FROM dailyactivity_merged
GROUP BY Id
ORDER BY avg_steps DESC
LIMIT 10;

--  5. Least Active Users
-- ----------------------------------------

SELECT
Id,
ROUND(AVG(TotalSteps),2) AS avg_steps
FROM dailyactivity_merged
GROUP BY Id
ORDER BY avg_steps ASC
LIMIT 10;

--  6. Activity Level Classification
-- ----------------------------------------

SELECT
CASE
WHEN TotalSteps < 5000 THEN 'Sedentary'
WHEN TotalSteps BETWEEN 5000 AND 7499 THEN 'Low Active'
WHEN TotalSteps BETWEEN 7500 AND 9999 THEN 'Moderately Active'
ELSE 'Highly Active'
END AS activity_level,
COUNT(*) AS number_of_days
FROM dailyactivity_merged
GROUP BY activity_level
ORDER BY number_of_days DESC;

 -- 7. Average Sleep Duration (Hours)
-- ----------------------------------------

SELECT
ROUND(AVG(TotalMinutesAsleep)/60,2) AS avg_sleep_hours
FROM sleepday_merged;

-- 8. Average Time Spent in Bed
-- ----------------------------------------

SELECT
ROUND(AVG(TotalTimeInBed)/60,2) AS avg_time_in_bed_hours
FROM sleepday_merged;

 -- 9. Sleep vs Time in Bed Comparison
-- ----------------------------------------

SELECT
ROUND(AVG(TotalMinutesAsleep)/60,2) AS avg_sleep_hours,
ROUND(AVG(TotalTimeInBed)/60,2) AS avg_time_in_bed_hours
FROM sleepday_merged;

-- 10. Peak Activity Hour
-- ----------------------------------------

SELECT
HOUR(ActivityHour) AS hour_of_day,
ROUND(AVG(StepTotal),2) AS avg_steps
FROM hourlysteps_merged
GROUP BY hour_of_day
ORDER BY avg_steps DESC;

-- 11. Average Steps by Hour
-- ----------------------------------------

SELECT
HOUR(ActivityHour) AS hour_of_day,
ROUND(AVG(StepTotal),2) AS avg_steps
FROM hourlysteps_merged
GROUP BY hour_of_day
ORDER BY hour_of_day;


-- ----------------------------------------
-- 12. Total Steps by User
-- ----------------------------------------

SELECT
Id,
SUM(TotalSteps) AS total_steps
FROM dailyactivity_merged
GROUP BY Id
ORDER BY total_steps DESC;


-- ----------------------------------------
-- 13. Highest Single-Day Activity
-- ----------------------------------------

SELECT
Id,
ActivityDate,
TotalSteps
FROM dailyactivity_merged
ORDER BY TotalSteps DESC
LIMIT 10;


-- ----------------------------------------
-- 14. Average Sedentary Time
-- ----------------------------------------

SELECT
ROUND(AVG(SedentaryMinutes),2) AS avg_sedentary_minutes
FROM dailyactivity_merged;


-- ----------------------------------------
-- 15. Average Active Minutes
-- ----------------------------------------

SELECT
ROUND(AVG(VeryActiveMinutes),2) AS avg_very_active_minutes,
ROUND(AVG(FairlyActiveMinutes),2) AS avg_fairly_active_minutes,
ROUND(AVG(LightlyActiveMinutes),2) AS avg_lightly_active_minutes
FROM dailyactivity_merged;
