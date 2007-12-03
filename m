Return-Path: <jonsmirl@gmail.com>
Received: from vms173001pub.verizon.net (vms173001pub.verizon.net
	[206.46.173.1]) by ozlabs.org (Postfix) with ESMTP id 3CB57DDF27
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 09:21:44 +1100 (EST)
Received: from terra.home ([96.233.72.204]) by vms173001.mailsrvcs.net
	(Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
	with ESMTPA id <0JSH00I8NS7YDC60@vms173001.mailsrvcs.net> for
	linuxppc-dev@ozlabs.org; Mon, 03 Dec 2007 15:11:59 -0600 (CST)
Date: Mon, 03 Dec 2007 16:20:36 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH 2/4] Modify several rtc drivers to use the alias names list
	property of i2c
In-reply-to: <20071203212032.23543.3453.stgit@terra.home>
To: i2c@lm-sensors.org, linuxppc-dev@ozlabs.org
Message-id: <20071203212036.23543.3457.stgit@terra.home>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20071203212032.23543.3453.stgit@terra.home>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch modifies the ds1307, ds1374, and rs5c372 i2c drivers to support
device tree names using the new i2c mod alias support
---

 arch/powerpc/sysdev/fsl_soc.c |   46 ++++++-----------------------------------
 drivers/rtc/rtc-ds1307.c      |   38 ++++++++++++++++++----------------
 drivers/rtc/rtc-ds1374.c      |   11 +++++++++-
 drivers/rtc/rtc-rs5c372.c     |   31 +++++++++++++++-------------
 4 files changed, 54 insertions(+), 72 deletions(-)


diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 3ace747..e4c766e 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -320,48 +320,12 @@ arch_initcall(gfar_of_init);
 
 #ifdef CONFIG_I2C_BOARDINFO
 #include <linux/i2c.h>
-struct i2c_driver_device {
-	char	*of_device;
-	char	*i2c_driver;
-	char	*i2c_type;
-};
-
-static struct i2c_driver_device i2c_devices[] __initdata = {
-	{"ricoh,rs5c372a", "rtc-rs5c372", "rs5c372a",},
-	{"ricoh,rs5c372b", "rtc-rs5c372", "rs5c372b",},
-	{"ricoh,rv5c386",  "rtc-rs5c372", "rv5c386",},
-	{"ricoh,rv5c387a", "rtc-rs5c372", "rv5c387a",},
-	{"dallas,ds1307",  "rtc-ds1307",  "ds1307",},
-	{"dallas,ds1337",  "rtc-ds1307",  "ds1337",},
-	{"dallas,ds1338",  "rtc-ds1307",  "ds1338",},
-	{"dallas,ds1339",  "rtc-ds1307",  "ds1339",},
-	{"dallas,ds1340",  "rtc-ds1307",  "ds1340",},
-	{"stm,m41t00",     "rtc-ds1307",  "m41t00"},
-	{"dallas,ds1374",  "rtc-ds1374",  "rtc-ds1374",},
-};
-
-static int __init of_find_i2c_driver(struct device_node *node,
-				     struct i2c_board_info *info)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(i2c_devices); i++) {
-		if (!of_device_is_compatible(node, i2c_devices[i].of_device))
-			continue;
-		if (strlcpy(info->driver_name, i2c_devices[i].i2c_driver,
-			    KOBJ_NAME_LEN) >= KOBJ_NAME_LEN ||
-		    strlcpy(info->type, i2c_devices[i].i2c_type,
-			    I2C_NAME_SIZE) >= I2C_NAME_SIZE)
-			return -ENOMEM;
-		return 0;
-	}
-	return -ENODEV;
-}
 
 static void __init of_register_i2c_devices(struct device_node *adap_node,
 					   int bus_num)
 {
 	struct device_node *node = NULL;
+	const char *compatible;
 
 	while ((node = of_get_next_child(adap_node, node))) {
 		struct i2c_board_info info = {};
@@ -378,9 +342,13 @@ static void __init of_register_i2c_devices(struct device_node *adap_node,
 		if (info.irq == NO_IRQ)
 			info.irq = -1;
 
-		if (of_find_i2c_driver(node, &info) < 0)
+		compatible = of_get_property(node, "compatible", &len);
+		if (!compatible) {
+			printk(KERN_WARNING "i2c-mpc.c: invalid entry, missing compatible attribute\n");
 			continue;
-
+		}
+		strncpy(info.driver_name, compatible, sizeof(info.driver_name));
+		
 		info.addr = *addr;
 
 		i2c_register_board_info(bus_num, &info, 1);
diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index bc1c7fe..a4dec4b 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -99,45 +99,46 @@ struct ds1307 {
 };
 
 struct chip_desc {
-	char			name[9];
 	unsigned		nvram56:1;
 	unsigned		alarm:1;
 	enum ds_type		type;
 };
 
 static const struct chip_desc chips[] = { {
-	.name		= "ds1307",
 	.type		= ds_1307,
 	.nvram56	= 1,
 }, {
-	.name		= "ds1337",
 	.type		= ds_1337,
 	.alarm		= 1,
 }, {
-	.name		= "ds1338",
 	.type		= ds_1338,
 	.nvram56	= 1,
 }, {
-	.name		= "ds1339",
 	.type		= ds_1339,
 	.alarm		= 1,
 }, {
-	.name		= "ds1340",
 	.type		= ds_1340,
 }, {
-	.name		= "m41t00",
 	.type		= m41t00,
 }, };
 
-static inline const struct chip_desc *find_chip(const char *s)
-{
-	unsigned i;
-
-	for (i = 0; i < ARRAY_SIZE(chips); i++)
-		if (strnicmp(s, chips[i].name, sizeof chips[i].name) == 0)
-			return &chips[i];
-	return NULL;
-}
+static struct i2c_device_id ds1307_id[] = {
+	{"rtc-ds1307", ds_1307},
+	{"ds1307", ds_1307},
+	{"ds1337", ds_1337},
+	{"ds1338", ds_1338},
+	{"ds1339", ds_1339},
+	{"ds1340", ds_1340},
+	{"m41t00", m41t00},
+	{"dallas,ds1307", ds_1307},
+	{"dallas,ds1337", ds_1337},
+	{"dallas,ds1338", ds_1338},
+	{"dallas,ds1339", ds_1339},
+	{"dallas,ds1340", ds_1340},
+	{"stm,m41t00", m41t00},
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, ds1307_id);
 
 static int ds1307_get_time(struct device *dev, struct rtc_time *t)
 {
@@ -326,7 +327,7 @@ static struct bin_attribute nvram = {
 
 static struct i2c_driver ds1307_driver;
 
-static int __devinit ds1307_probe(struct i2c_client *client)
+static int __devinit ds1307_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	struct ds1307		*ds1307;
 	int			err = -ENODEV;
@@ -334,7 +335,7 @@ static int __devinit ds1307_probe(struct i2c_client *client)
 	const struct chip_desc	*chip;
 	struct i2c_adapter	*adapter = to_i2c_adapter(client->dev.parent);
 
-	chip = find_chip(client->name);
+	chip = &chips[id->driver_data];
 	if (!chip) {
 		dev_err(&client->dev, "unknown chip type '%s'\n",
 				client->name);
@@ -537,6 +538,7 @@ static struct i2c_driver ds1307_driver = {
 	},
 	.probe		= ds1307_probe,
 	.remove		= __devexit_p(ds1307_remove),
+	.id_table	= ds1307_id,
 };
 
 static int __init ds1307_init(void)
diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
index 45bda18..2b852f3 100644
--- a/drivers/rtc/rtc-ds1374.c
+++ b/drivers/rtc/rtc-ds1374.c
@@ -41,6 +41,14 @@
 #define DS1374_REG_SR_AF	0x01 /* Alarm Flag */
 #define DS1374_REG_TCR		0x09 /* Trickle Charge */
 
+static struct i2c_device_id ds1374_id[] = {
+	{"rtc-ds1374", 0},
+	{"ds1374", 0},
+	{"dallas,ds1374", 0},
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, ds1374_id);
+
 struct ds1374 {
 	struct i2c_client *client;
 	struct rtc_device *rtc;
@@ -355,7 +363,7 @@ static const struct rtc_class_ops ds1374_rtc_ops = {
 	.ioctl = ds1374_ioctl,
 };
 
-static int ds1374_probe(struct i2c_client *client)
+static int ds1374_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	struct ds1374 *ds1374;
 	int ret;
@@ -429,6 +437,7 @@ static struct i2c_driver ds1374_driver = {
 	},
 	.probe = ds1374_probe,
 	.remove = __devexit_p(ds1374_remove),
+	.id_table = ds1374_id,
 };
 
 static int __init ds1374_init(void)
diff --git a/drivers/rtc/rtc-rs5c372.c b/drivers/rtc/rtc-rs5c372.c
index 6b67b50..de0d458 100644
--- a/drivers/rtc/rtc-rs5c372.c
+++ b/drivers/rtc/rtc-rs5c372.c
@@ -62,13 +62,26 @@
 
 
 enum rtc_type {
-	rtc_undef = 0,
 	rtc_rs5c372a,
 	rtc_rs5c372b,
 	rtc_rv5c386,
 	rtc_rv5c387a,
 };
 
+static struct i2c_device_id rs5c372_id[] = {
+	{"rtc-rs5c372", rtc_rs5c372a},
+	{"rs5c372a", rtc_rs5c372a},
+	{"rs5c372b", rtc_rs5c372b},
+	{"rv5c386", rtc_rv5c386},
+	{"rv5c387a", rtc_rv5c387a},
+	{"ricoh,rs5c372a", rtc_rs5c372a},
+	{"ricoh,rs5c372b", rtc_rs5c372b},
+	{"ricoh,rv5c386", rtc_rv5c386},
+	{"ricoh,rv5c387a", rtc_rv5c387a},
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, rs5c372_id);
+
 /* REVISIT:  this assumes that:
  *  - we're in the 21st century, so it's safe to ignore the century
  *    bit for rv5c38[67] (REG_MONTH bit 7);
@@ -494,7 +507,7 @@ static void rs5c_sysfs_unregister(struct device *dev)
 
 static struct i2c_driver rs5c372_driver;
 
-static int rs5c372_probe(struct i2c_client *client)
+static int rs5c372_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	int err = 0;
 	struct rs5c372 *rs5c372;
@@ -522,18 +535,7 @@ static int rs5c372_probe(struct i2c_client *client)
 	if (err < 0)
 		goto exit_kfree;
 
-	if (strcmp(client->name, "rs5c372a") == 0)
-		rs5c372->type = rtc_rs5c372a;
-	else if (strcmp(client->name, "rs5c372b") == 0)
-		rs5c372->type = rtc_rs5c372b;
-	else if (strcmp(client->name, "rv5c386") == 0)
-		rs5c372->type = rtc_rv5c386;
-	else if (strcmp(client->name, "rv5c387a") == 0)
-		rs5c372->type = rtc_rv5c387a;
-	else {
-		rs5c372->type = rtc_rs5c372b;
-		dev_warn(&client->dev, "assuming rs5c372b\n");
-	}
+	rs5c372->type = id->driver_data;
 
 	/* clock may be set for am/pm or 24 hr time */
 	switch (rs5c372->type) {
@@ -651,6 +653,7 @@ static struct i2c_driver rs5c372_driver = {
 	},
 	.probe		= rs5c372_probe,
 	.remove		= rs5c372_remove,
+	.id_table	= rs5c372_id,
 };
 
 static __init int rs5c372_init(void)
