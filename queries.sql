SELECT COUNT(*) AS total_transaction,
SUM(amount) AS total_amount 
FROM bank_transaction;

SELECT transaction_type,
COUNT(*) AS total,
SUM(amount) AS total_amount
FROM bank_transaction
GROUP BY transaction_type;

SELECT city,
COUNT(*) AS total_transaction,
SUM(amount) AS total_amount
FROM bank_transaction
GROUP BY city 
ORDER BY total_amount DESC;

SELECT account_id,
SUM(CASE 
    WHEN transaction_type = 'Credit' THEN amount
    ELSE -amount
END) AS balance
FROM bank_transaction
GROUP BY account_id;

SELECT account_id,
SUM(CASE
    WHEN transaction_type = 'Credit' THEN amount
    ELSE -amount
END) AS balance 
FROM bank_transaction
GROUP BY account_id
ORDER BY balance DESC 
LIMIT 5;

SELECT account_id, amount
FROM bank_transaction
WHERE transaction_type = 'Debit'
AND amount > 50000
LIMIT 10;

SELECT MONTH(transaction_date) AS month,
SUM(amount) AS total 
FROM bank_transaction
GROUP BY month 
ORDER BY month;

SELECT city, MAX(amount) AS highest
FROM bank_transaction 
GROUP BY city
ORDER BY highest DESC;

SELECT city, amount, rnk
FROM (
    SELECT city, amount,
    DENSE_RANK() OVER (PARTITION BY city ORDER BY amount DESC) AS rnk
    FROM bank_transaction
) t
WHERE rnk <= 3;