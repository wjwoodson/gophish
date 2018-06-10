
-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied
ALTER TABLE users ADD COLUMN role varchar(255);
UPDATE users SET role = "CampaignAdmin";
UPDATE users SET role = "GlobalAdmin" where username = "admin";

-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back
ALTER TABLE users RENAME TO users_temp;

CREATE TABLE users (
  id integer primary key autoincrement,
  username varchar(255) NOT NULL UNIQUE,
  hash varchar(255),
  api_key varchar(255) NOT NULL UNIQUE
);

INSERT INTO users SELECT id, username, hash, api_key FROM users_temp;

DROP TABLE users_temp;

