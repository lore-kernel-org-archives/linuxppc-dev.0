Return-Path: <jonsmirl@gmail.com>
Received: from vms040pub.verizon.net (vms040pub.verizon.net [206.46.252.40])
	by ozlabs.org (Postfix) with ESMTP id B2DD8DDE38
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 13:09:44 +1100 (EST)
Received: from terra.home ([96.233.72.204])
	by vms040.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01
	(built Apr
	3 2006)) with ESMTPA id <0JV200BY9RENDY97@vms040.mailsrvcs.net> for
	linuxppc-dev@ozlabs.org; Tue, 22 Jan 2008 20:11:11 -0600 (CST)
Date: Tue, 22 Jan 2008 21:09:16 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH 3/3] Add device tree compatible aliases to i2c drivers
In-reply-to: <20080123020912.31675.48787.stgit@terra.home>
To: i2c@lm-sensors.org, linuxppc-dev@ozlabs.org
Message-id: <20080123020916.31675.98481.stgit@terra.home>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20080123020912.31675.48787.stgit@terra.home>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

PowerPC device trees use a different naming convention than the Linux kernel.  Provide alias names for i2c drivers in order to allow them to be loaded by device tree name. The OF_ID macro ensures that the aliases are only present in powerpc builds and separated into their own namespace.

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
---

 drivers/hwmon/f75375s.c      |    2 ++
 drivers/i2c/chips/ds1682.c   |    1 +
 drivers/i2c/chips/menelaus.c |    1 +
 drivers/i2c/chips/tps65010.c |    4 ++++
 drivers/i2c/chips/tsl2550.c  |    1 +
 drivers/rtc/rtc-ds1307.c     |    6 ++++++
 drivers/rtc/rtc-ds1374.c     |    1 +
 drivers/rtc/rtc-m41t80.c     |    8 ++++++++
 drivers/rtc/rtc-pcf8563.c    |    2 ++
 drivers/rtc/rtc-rs5c372.c    |    4 ++++
 10 files changed, 30 insertions(+), 0 deletions(-)


diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
index 4cb4db4..dd548e7 100644
--- a/drivers/hwmon/f75375s.c
+++ b/drivers/hwmon/f75375s.c
@@ -132,6 +132,8 @@ static struct i2c_driver f75375_legacy_driver = {
 static const struct i2c_device_id f75375_id[] = {
 	{ "f75373", f75373 },
 	{ "f75375", f75375 },
+	OF_ID("fintek,f75373", f75373)
+	OF_ID("fintek,f75375", f75375)
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, f75375_id);
diff --git a/drivers/i2c/chips/ds1682.c b/drivers/i2c/chips/ds1682.c
index 51ff518..817ad1f 100644
--- a/drivers/i2c/chips/ds1682.c
+++ b/drivers/i2c/chips/ds1682.c
@@ -237,6 +237,7 @@ static int ds1682_remove(struct i2c_client *client)
 
 static const struct i2c_device_id ds1682_id[] = {
 	{ "ds1682", 0 },
+	OF_ID("dallas,ds1682", 0)
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, ds1682_id);
diff --git a/drivers/i2c/chips/menelaus.c b/drivers/i2c/chips/menelaus.c
index 1f9ac5e..ba7d619 100644
--- a/drivers/i2c/chips/menelaus.c
+++ b/drivers/i2c/chips/menelaus.c
@@ -1245,6 +1245,7 @@ static int __exit menelaus_remove(struct i2c_client *client)
 
 static const struct i2c_device_id menelaus_id[] = {
 	{ "menelaus", 0 },
+	OF_ID("ti,twl92330", 0)
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, menelaus_id);
diff --git a/drivers/i2c/chips/tps65010.c b/drivers/i2c/chips/tps65010.c
index e07274d..67fd30f 100644
--- a/drivers/i2c/chips/tps65010.c
+++ b/drivers/i2c/chips/tps65010.c
@@ -571,6 +571,10 @@ static const struct i2c_device_id tps65010_id[] = {
 	{ "tps65011", TPS65011 },
 	{ "tps65012", TPS65012 },
 	{ "tps65013", TPS65013 },
+	OF_ID("ti,tps65010", TPS65010)
+	OF_ID("ti,tps65011", TPS65011)
+	OF_ID("ti,tps65012", TPS65012)
+	OF_ID("ri,tps65013", TPS65013)
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, tps65010_id);
diff --git a/drivers/i2c/chips/tsl2550.c b/drivers/i2c/chips/tsl2550.c
index 2add8be..8071d6d 100644
--- a/drivers/i2c/chips/tsl2550.c
+++ b/drivers/i2c/chips/tsl2550.c
@@ -454,6 +454,7 @@ static int tsl2550_resume(struct i2c_client *client)
 
 static const struct i2c_device_id tsl2550_id[] = {
 	{ "tsl2550", 0 },
+	OF_ID("taos,tsl2550", 0)
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, tsl2550_id);
diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index a5614ab..e363a5f 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -129,6 +129,12 @@ static const struct i2c_device_id ds1307_id[] = {
 	{ "ds1339", ds_1339 },
 	{ "ds1340", ds_1340 },
 	{ "m41t00", m41t00 },
+	OF_ID("dallas,ds1307", ds_1307)
+	OF_ID("dallas,ds1337", ds_1337)
+	OF_ID("dallas,ds1338", ds_1338)
+	OF_ID("dallas,ds1339", ds_1339)
+	OF_ID("dallas,ds1340", ds_1340)
+	OF_ID("stm,m41t00", m41t00)
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, ds1307_id);
diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
index 376ceeb..e4f680a 100644
--- a/drivers/rtc/rtc-ds1374.c
+++ b/drivers/rtc/rtc-ds1374.c
@@ -43,6 +43,7 @@
 
 static const struct i2c_device_id ds1374_id[] = {
 	{ "ds1374", 0 },
+	OF_ID("dallas,ds1374", 0)
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, ds1374_id);
diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index c672557..663f8b5 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -69,6 +69,14 @@ static const struct i2c_device_id m41t80_id[] = {
 	{ "m41st84", M41T80_FEATURE_HT | M41T80_FEATURE_BL },
 	{ "m41st85", M41T80_FEATURE_HT | M41T80_FEATURE_BL },
 	{ "m41st87", M41T80_FEATURE_HT | M41T80_FEATURE_BL },
+	OF_ID("stm,m41t80", 0)
+	OF_ID("stm,m41t81", M41T80_FEATURE_HT)
+	OF_ID("stm,m41t81s", M41T80_FEATURE_HT | M41T80_FEATURE_BL)
+	OF_ID("stm,m41t82", M41T80_FEATURE_HT | M41T80_FEATURE_BL)
+	OF_ID("stm,m41t83", M41T80_FEATURE_HT | M41T80_FEATURE_BL)
+	OF_ID("stm,m41st84", M41T80_FEATURE_HT | M41T80_FEATURE_BL)
+	OF_ID("stm,m41st85", M41T80_FEATURE_HT | M41T80_FEATURE_BL)
+	OF_ID("stm,m41st87", M41T80_FEATURE_HT | M41T80_FEATURE_BL)
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, m41t80_id);
diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index 8eff549..51d7471 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -263,6 +263,8 @@ static int pcf8563_remove(struct i2c_client *client)
 static struct i2c_device_id pcf8563_id[] = {
 	{"pcf8563", 0},
 	{"rtc8564", 0},
+	OF_ID("phillips,pcf8563", 0)
+	OF_ID("epson,rtc8564", 0)
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, pcf8563_id);
diff --git a/drivers/rtc/rtc-rs5c372.c b/drivers/rtc/rtc-rs5c372.c
index a3e4f8d..cdd26c3 100644
--- a/drivers/rtc/rtc-rs5c372.c
+++ b/drivers/rtc/rtc-rs5c372.c
@@ -74,6 +74,10 @@ static const struct i2c_device_id rs5c372_id[] = {
 	{ "rs5c372b", rtc_rs5c372b },
 	{ "rv5c386", rtc_rv5c386 },
 	{ "rv5c387a", rtc_rv5c387a },
+	OF_ID("ricoh,rs5c372a", rtc_rs5c372a)
+	OF_ID("ricoh,rs5c372b", rtc_rs5c372b)
+	OF_ID("ricoh,rv5c386", rtc_rv5c386)
+	OF_ID("ricoh,rv5c387a", rtc_rv5c387a)
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, rs5c372_id);
