Return-Path: <b32167@lc1106.zin33.ap.freescale.net>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CCE92B6FA7
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 May 2011 17:05:24 +1000 (EST)
From: Priyanka Jain <Priyanka.Jain@freescale.com>
To: <akpm@linux-foundation.org>, <w.sang@pengutronix.de>,
	<rtc-linux@googlegroups.com>, <linuxppc-dev@lists.ozlabs.org>,
	<a.zummo@towertech.it>, <p_gortmaker@yahoo.com>
Subject: [PATCH] Add support for pt7c4338 (rtc device) in rtc-ds1307 driver
Date: Thu, 26 May 2011 12:33:29 +0530
Message-ID: <1306393409-16153-1-git-send-email-Priyanka.Jain@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Priyanka Jain <Priyanka.Jain@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PT7C4338 chip is being manufactured by Pericom Technology Inc.
It is a serial real-time clock which provides:
1)Low-power clock/calendar.
2)Programmable square-wave output.
It has 56 bytes of nonvolatile RAM.
Its register set is same as that of rtc device: DS1307.

Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
---
 Changes :
	 This patch will supersede patch:
		"RTC driver(Linux) for PT7C4338 chip"
	 Incorporting Wolfram Sang's comments to reuse ds1307 driver.

 drivers/rtc/Kconfig      |    6 +++---
 drivers/rtc/rtc-ds1307.c |    7 +++++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index b8f4e9e..c6045dd 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -126,13 +126,13 @@ comment "I2C RTC drivers"
 if I2C
 
 config RTC_DRV_DS1307
-	tristate "Dallas/Maxim DS1307/37/38/39/40, ST M41T00, EPSON RX-8025"
+	tristate "Dallas/Maxim DS1307/37/38/39/40, ST M41T00, EPSON RX-8025, PT7C4338"
 	help
 	  If you say yes here you get support for various compatible RTC
 	  chips (often with battery backup) connected with I2C. This driver
 	  should handle DS1307, DS1337, DS1338, DS1339, DS1340, ST M41T00,
-	  EPSON RX-8025 and probably other chips. In some cases the RTC
-	  must already have been initialized (by manufacturing or a
+	  EPSON RX-8025, PT7C4338 and probably other chips. In some cases
+	  the RTC must already have been initialized (by manufacturing or a
 	  bootloader).
 
 	  The first seven registers on these chips hold an RTC, and other
diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 4724ba3..8436f16 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -4,6 +4,8 @@
  *  Copyright (C) 2005 James Chapman (ds1337 core)
  *  Copyright (C) 2006 David Brownell
  *  Copyright (C) 2009 Matthias Fuchs (rx8025 support)
+ *  Copyright (C) 2011 Priyanka Jain (Priyanka.Jain@freescale.com)
+ *                                   (pt7c4338 support)
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -34,6 +36,7 @@ enum ds_type {
 	ds_1388,
 	ds_3231,
 	m41t00,
+	pt7c4338,
 	rx_8025,
 	// rs5c372 too?  different address...
 };
@@ -137,6 +140,8 @@ static const struct chip_desc chips[] = {
 },
 [m41t00] = {
 },
+[pt7c4338] = {
+},
 [rx_8025] = {
 }, };
 
@@ -149,6 +154,7 @@ static const struct i2c_device_id ds1307_id[] = {
 	{ "ds1340", ds_1340 },
 	{ "ds3231", ds_3231 },
 	{ "m41t00", m41t00 },
+	{ "pt7c4338", pt7c4338 },
 	{ "rx8025", rx_8025 },
 	{ }
 };
@@ -769,6 +775,7 @@ read_rtc:
 	switch (ds1307->type) {
 	case ds_1307:
 	case m41t00:
+	case pt7c4338:
 		/* clock halted?  turn it on, so clock can tick. */
 		if (tmp & DS1307_BIT_CH) {
 			i2c_smbus_write_byte_data(client, DS1307_REG_SECS, 0);
-- 
1.6.5.6
