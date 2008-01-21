Return-Path: <khali@linux-fr.org>
Received: from kraid.nerim.net (smtp-101-monday.nerim.net [62.4.16.101])
	by ozlabs.org (Postfix) with ESMTP id D30E6DDDFC
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jan 2008 21:41:41 +1100 (EST)
Date: Mon, 21 Jan 2008 11:41:39 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Linux I2C <i2c@lm-sensors.org>
Subject: [PATCH 2/3] i2c: Convert all new-style drivers to use module aliasing
Message-ID: <20080121114139.3aaa111a@hyperion.delvare>
In-Reply-To: <20080121112517.6fe35a89@hyperion.delvare>
References: <20080121112517.6fe35a89@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Based on earlier work by Jon Smirl.

Update all the new-style i2c drivers to use standard module aliasing
instead of the old driver_name/type driver matching scheme.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Jon Smirl <jonsmirl@gmail.com>
---
 arch/arm/mach-at91/board-csb337.c |    3 -
 arch/arm/mach-at91/board-dk.c     |    3 -
 arch/arm/mach-at91/board-eb9200.c |    3 -
 arch/arm/mach-iop32x/em7210.c     |    3 -
 arch/arm/mach-iop32x/n2100.c      |    4 -
 arch/arm/mach-omap1/board-h2.c    |    1 
 arch/arm/mach-omap1/board-h3.c    |    3 -
 arch/arm/mach-omap1/board-osk.c   |    1 
 arch/powerpc/sysdev/fsl_soc.c     |   27 +++++-------
 drivers/hwmon/f75375s.c           |   22 +++++-----
 drivers/i2c/busses/i2c-taos-evm.c |    3 -
 drivers/i2c/chips/ds1682.c        |    7 +++
 drivers/i2c/chips/menelaus.c      |    7 +++
 drivers/i2c/chips/tps65010.c      |   28 ++++---------
 drivers/i2c/chips/tsl2550.c       |    7 +++
 drivers/rtc/rtc-ds1307.c          |   36 ++++++-----------
 drivers/rtc/rtc-ds1374.c          |    7 +++
 drivers/rtc/rtc-m41t80.c          |   78 +++++++++----------------------------
 drivers/rtc/rtc-rs5c372.c         |   14 ++++++
 include/linux/i2c.h               |   12 ++---
 20 files changed, 120 insertions(+), 149 deletions(-)

--- linux-2.6.24-rc8.orig/arch/arm/mach-at91/board-csb337.c	2007-12-04 08:56:17.000000000 +0100
+++ linux-2.6.24-rc8/arch/arm/mach-at91/board-csb337.c	2008-01-20 18:08:16.000000000 +0100
@@ -85,8 +85,7 @@ static struct at91_udc_data __initdata c
 
 static struct i2c_board_info __initdata csb337_i2c_devices[] = {
 	{
-		I2C_BOARD_INFO("rtc-ds1307", 0x68),
-		.type	= "ds1307",
+		I2C_BOARD_INFO("ds1307", 0x68),
 	},
 };
 
--- linux-2.6.24-rc8.orig/arch/arm/mach-at91/board-dk.c	2007-12-04 08:56:17.000000000 +0100
+++ linux-2.6.24-rc8/arch/arm/mach-at91/board-dk.c	2008-01-20 18:08:35.000000000 +0100
@@ -132,8 +132,7 @@ static struct i2c_board_info __initdata 
 		I2C_BOARD_INFO("x9429", 0x28),
 	},
 	{
-		I2C_BOARD_INFO("at24c", 0x50),
-		.type	= "24c1024",
+		I2C_BOARD_INFO("24c1024", 0x50),
 	}
 };
 
--- linux-2.6.24-rc8.orig/arch/arm/mach-at91/board-eb9200.c	2007-12-04 08:56:17.000000000 +0100
+++ linux-2.6.24-rc8/arch/arm/mach-at91/board-eb9200.c	2008-01-20 18:08:05.000000000 +0100
@@ -93,8 +93,7 @@ static struct at91_mmc_data __initdata e
 
 static struct i2c_board_info __initdata eb9200_i2c_devices[] = {
 	{
-		I2C_BOARD_INFO("at24c", 0x50),
-		.type	= "24c512",
+		I2C_BOARD_INFO("24c512", 0x50),
 	},
 };
 
--- linux-2.6.24-rc8.orig/arch/arm/mach-iop32x/em7210.c	2007-10-10 09:58:10.000000000 +0200
+++ linux-2.6.24-rc8/arch/arm/mach-iop32x/em7210.c	2008-01-20 18:07:15.000000000 +0100
@@ -50,8 +50,7 @@ static struct sys_timer em7210_timer = {
  */
 static struct i2c_board_info __initdata em7210_i2c_devices[] = {
 	{
-		I2C_BOARD_INFO("rtc-rs5c372", 0x32),
-		.type = "rs5c372a",
+		I2C_BOARD_INFO("rs5c372a", 0x32),
 	},
 };
 
--- linux-2.6.24-rc8.orig/arch/arm/mach-iop32x/n2100.c	2007-11-17 10:26:25.000000000 +0100
+++ linux-2.6.24-rc8/arch/arm/mach-iop32x/n2100.c	2008-01-20 18:07:00.000000000 +0100
@@ -208,12 +208,10 @@ static struct f75375s_platform_data n210
 
 static struct i2c_board_info __initdata n2100_i2c_devices[] = {
 	{
-		I2C_BOARD_INFO("rtc-rs5c372", 0x32),
-		.type = "rs5c372b",
+		I2C_BOARD_INFO("rs5c372b", 0x32),
 	},
 	{
 		I2C_BOARD_INFO("f75375", 0x2e),
-		.type = "f75375",
 		.platform_data = &n2100_f75375s,
 	},
 };
--- linux-2.6.24-rc8.orig/arch/arm/mach-omap1/board-h2.c	2008-01-19 12:16:45.000000000 +0100
+++ linux-2.6.24-rc8/arch/arm/mach-omap1/board-h2.c	2008-01-20 18:07:37.000000000 +0100
@@ -347,7 +347,6 @@ static struct platform_device *h2_device
 static struct i2c_board_info __initdata h2_i2c_board_info[] = {
 	{
 		I2C_BOARD_INFO("tps65010", 0x48),
-		.type		= "tps65010",
 		.irq		= OMAP_GPIO_IRQ(58),
 	},
 	/* TODO when driver support is ready:
--- linux-2.6.24-rc8.orig/arch/arm/mach-omap1/board-h3.c	2008-01-19 12:16:45.000000000 +0100
+++ linux-2.6.24-rc8/arch/arm/mach-omap1/board-h3.c	2008-01-20 18:07:43.000000000 +0100
@@ -459,8 +459,7 @@ static struct omap_board_config_kernel h
 
 static struct i2c_board_info __initdata h3_i2c_board_info[] = {
 	{
-		I2C_BOARD_INFO("tps65010", 0x48),
-		.type		= "tps65013",
+		I2C_BOARD_INFO("tps65013", 0x48),
 		/* .irq		= OMAP_GPIO_IRQ(??), */
 	},
 	/* TODO when driver support is ready:
--- linux-2.6.24-rc8.orig/arch/arm/mach-omap1/board-osk.c	2008-01-19 12:16:45.000000000 +0100
+++ linux-2.6.24-rc8/arch/arm/mach-omap1/board-osk.c	2008-01-20 18:07:30.000000000 +0100
@@ -187,7 +187,6 @@ static struct platform_device *osk5912_d
 static struct i2c_board_info __initdata osk_i2c_board_info[] = {
 	{
 		I2C_BOARD_INFO("tps65010", 0x48),
-		.type		= "tps65010",
 		.irq		= OMAP_GPIO_IRQ(OMAP_MPUIO(1)),
 	},
 	/* TODO when driver support is ready:
--- linux-2.6.24-rc8.orig/arch/powerpc/sysdev/fsl_soc.c	2008-01-20 17:28:17.000000000 +0100
+++ linux-2.6.24-rc8/arch/powerpc/sysdev/fsl_soc.c	2008-01-20 17:29:13.000000000 +0100
@@ -322,22 +322,21 @@ arch_initcall(gfar_of_init);
 #include <linux/i2c.h>
 struct i2c_driver_device {
 	char	*of_device;
-	char	*i2c_driver;
 	char	*i2c_type;
 };
 
 static struct i2c_driver_device i2c_devices[] __initdata = {
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
+	{"ricoh,rs5c372a", "rs5c372a",},
+	{"ricoh,rs5c372b", "rs5c372b",},
+	{"ricoh,rv5c386",  "rv5c386",},
+	{"ricoh,rv5c387a", "rv5c387a",},
+	{"dallas,ds1307",  "ds1307",},
+	{"dallas,ds1337",  "ds1337",},
+	{"dallas,ds1338",  "ds1338",},
+	{"dallas,ds1339",  "ds1339",},
+	{"dallas,ds1340",  "ds1340",},
+	{"stm,m41t00",     "m41t00"},
+	{"dallas,ds1374",  "rtc-ds1374",},
 };
 
 static int __init of_find_i2c_driver(struct device_node *node,
@@ -348,9 +347,7 @@ static int __init of_find_i2c_driver(str
 	for (i = 0; i < ARRAY_SIZE(i2c_devices); i++) {
 		if (!of_device_is_compatible(node, i2c_devices[i].of_device))
 			continue;
-		if (strlcpy(info->driver_name, i2c_devices[i].i2c_driver,
-			    KOBJ_NAME_LEN) >= KOBJ_NAME_LEN ||
-		    strlcpy(info->type, i2c_devices[i].i2c_type,
+		if (strlcpy(info->type, i2c_devices[i].i2c_type,
 			    I2C_NAME_SIZE) >= I2C_NAME_SIZE)
 			return -ENOMEM;
 		return 0;
--- linux-2.6.24-rc8.orig/drivers/hwmon/f75375s.c	2008-01-20 14:43:34.000000000 +0100
+++ linux-2.6.24-rc8/drivers/hwmon/f75375s.c	2008-01-20 18:55:18.000000000 +0100
@@ -129,12 +129,20 @@ static struct i2c_driver f75375_legacy_d
 	.detach_client = f75375_detach_client,
 };
 
+static const struct i2c_device_id f75375_id[] = {
+	{ "f75373", f75373 },
+	{ "f75375", f75375 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, f75375_id);
+
 static struct i2c_driver f75375_driver = {
 	.driver = {
 		.name = "f75375",
 	},
 	.probe = f75375_probe,
 	.remove = f75375_remove,
+	.id_table = f75375_id,
 };
 
 static inline int f75375_read8(struct i2c_client *client, u8 reg)
@@ -646,15 +654,6 @@ static int f75375_probe(struct i2c_clien
 	data->client = client;
 	mutex_init(&data->update_lock);
 
-	if (strcmp(client->name, "f75375") == 0)
-		data->kind = f75375;
-	else if (strcmp(client->name, "f75373") == 0)
-		data->kind = f75373;
-	else {
-		dev_err(&client->dev, "Unsupported device: %s\n", client->name);
-		return -ENODEV;
-	}
-
 	if ((err = sysfs_create_group(&client->dev.kobj, &f75375_group)))
 		goto exit_free;
 
@@ -714,6 +713,7 @@ static int f75375_detect(struct i2c_adap
 	u8 version = 0;
 	int err = 0;
 	const char *name = "";
+	struct i2c_device_id id;
 
 	if (!(client = kzalloc(sizeof(*client), GFP_KERNEL))) {
 		err = -ENOMEM;
@@ -750,7 +750,9 @@ static int f75375_detect(struct i2c_adap
 	if ((err = i2c_attach_client(client)))
 		goto exit_free;
 
-	if ((err = f75375_probe(client, NULL)) < 0)
+	strlcpy(id.name, name, I2C_NAME_SIZE);
+	id.driver_data = kind;
+	if ((err = f75375_probe(client, &id)) < 0)
 		goto exit_detach;
 
 	return 0;
--- linux-2.6.24-rc8.orig/drivers/i2c/busses/i2c-taos-evm.c	2007-10-10 09:58:24.000000000 +0200
+++ linux-2.6.24-rc8/drivers/i2c/busses/i2c-taos-evm.c	2008-01-20 19:38:20.000000000 +0100
@@ -51,7 +51,6 @@ struct taos_data {
 /* TAOS TSL2550 EVM */
 static struct i2c_board_info tsl2550_info = {
 	I2C_BOARD_INFO("tsl2550", 0x39),
-	.type	= "tsl2550",
 };
 
 /* Instantiate i2c devices based on the adapter name */
@@ -59,7 +58,7 @@ static struct i2c_client *taos_instantia
 {
 	if (!strncmp(adapter->name, "TAOS TSL2550 EVM", 16)) {
 		dev_info(&adapter->dev, "Instantiating device %s at 0x%02x\n",
-			tsl2550_info.driver_name, tsl2550_info.addr);
+			tsl2550_info.type, tsl2550_info.addr);
 		return i2c_new_device(adapter, &tsl2550_info);
 	}
 
--- linux-2.6.24-rc8.orig/drivers/i2c/chips/ds1682.c	2008-01-20 14:41:23.000000000 +0100
+++ linux-2.6.24-rc8/drivers/i2c/chips/ds1682.c	2008-01-20 18:49:07.000000000 +0100
@@ -235,12 +235,19 @@ static int ds1682_remove(struct i2c_clie
 	return 0;
 }
 
+static const struct i2c_device_id ds1682_id[] = {
+	{ "ds1682", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, ds1682_id);
+
 static struct i2c_driver ds1682_driver = {
 	.driver = {
 		.name = "ds1682",
 	},
 	.probe = ds1682_probe,
 	.remove = ds1682_remove,
+	.id_table = ds1682_id,
 };
 
 static int __init ds1682_init(void)
--- linux-2.6.24-rc8.orig/drivers/i2c/chips/menelaus.c	2008-01-20 14:49:40.000000000 +0100
+++ linux-2.6.24-rc8/drivers/i2c/chips/menelaus.c	2008-01-20 18:49:25.000000000 +0100
@@ -1243,12 +1243,19 @@ static int __exit menelaus_remove(struct
 	return 0;
 }
 
+static const struct i2c_device_id menelaus_id[] = {
+	{ "menelaus", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, menelaus_id);
+
 static struct i2c_driver menelaus_i2c_driver = {
 	.driver = {
 		.name		= DRIVER_NAME,
 	},
 	.probe		= menelaus_probe,
 	.remove		= __exit_p(menelaus_remove),
+	.id_table	= menelaus_id,
 };
 
 static int __init menelaus_init(void)
--- linux-2.6.24-rc8.orig/drivers/i2c/chips/tps65010.c	2008-01-20 14:41:09.000000000 +0100
+++ linux-2.6.24-rc8/drivers/i2c/chips/tps65010.c	2008-01-20 18:49:34.000000000 +0100
@@ -60,7 +60,6 @@ static struct i2c_driver tps65010_driver
  * as part of board setup by a bootloader.
  */
 enum tps_model {
-	TPS_UNKNOWN = 0,
 	TPS65010,
 	TPS65011,
 	TPS65012,
@@ -487,20 +486,6 @@ static int tps65010_probe(struct i2c_cli
 	INIT_DELAYED_WORK(&tps->work, tps65010_work);
 	tps->client = client;
 
-	if (strcmp(client->name, "tps65010") == 0)
-		tps->model = TPS65010;
-	else if (strcmp(client->name, "tps65011") == 0)
-		tps->model = TPS65011;
-	else if (strcmp(client->name, "tps65012") == 0)
-		tps->model = TPS65012;
-	else if (strcmp(client->name, "tps65013") == 0)
-		tps->model = TPS65013;
-	else {
-		dev_warn(&client->dev, "unknown chip '%s'\n", client->name);
-		status = -ENODEV;
-		goto fail1;
-	}
-
 	/* the IRQ is active low, but many gpio lines can't support that
 	 * so this driver uses falling-edge triggers instead.
 	 */
@@ -528,9 +513,6 @@ static int tps65010_probe(struct i2c_cli
 	case TPS65012:
 		tps->por = 1;
 		break;
-	case TPS_UNKNOWN:
-		printk(KERN_WARNING "%s: unknown TPS chip\n", DRIVER_NAME);
-		break;
 	/* else CHGCONFIG.POR is replaced by AUA, enabling a WAIT mode */
 	}
 	tps->chgconf = i2c_smbus_read_byte_data(client, TPS_CHGCONFIG);
@@ -584,12 +566,22 @@ fail1:
 	return status;
 }
 
+static const struct i2c_device_id tps65010_id[] = {
+	{ "tps65010", TPS65010 },
+	{ "tps65011", TPS65011 },
+	{ "tps65012", TPS65012 },
+	{ "tps65013", TPS65013 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, tps65010_id);
+
 static struct i2c_driver tps65010_driver = {
 	.driver = {
 		.name	= "tps65010",
 	},
 	.probe	= tps65010_probe,
 	.remove	= __exit_p(tps65010_remove),
+	.id_table = tps65010_id,
 };
 
 /*-------------------------------------------------------------------------*/
--- linux-2.6.24-rc8.orig/drivers/i2c/chips/tsl2550.c	2008-01-20 14:40:51.000000000 +0100
+++ linux-2.6.24-rc8/drivers/i2c/chips/tsl2550.c	2008-01-20 18:49:19.000000000 +0100
@@ -452,6 +452,12 @@ static int tsl2550_resume(struct i2c_cli
 
 #endif /* CONFIG_PM */
 
+static const struct i2c_device_id tsl2550_id[] = {
+	{ "tsl2550", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, tsl2550_id);
+
 static struct i2c_driver tsl2550_driver = {
 	.driver = {
 		.name	= TSL2550_DRV_NAME,
@@ -461,6 +467,7 @@ static struct i2c_driver tsl2550_driver 
 	.resume	= tsl2550_resume,
 	.probe	= tsl2550_probe,
 	.remove	= __devexit_p(tsl2550_remove),
+	.id_table = tsl2550_id,
 };
 
 static int __init tsl2550_init(void)
--- linux-2.6.24-rc8.orig/drivers/rtc/rtc-ds1307.c	2008-01-20 17:26:58.000000000 +0100
+++ linux-2.6.24-rc8/drivers/rtc/rtc-ds1307.c	2008-01-20 19:03:48.000000000 +0100
@@ -102,42 +102,36 @@ struct chip_desc {
 	char			name[9];
 	unsigned		nvram56:1;
 	unsigned		alarm:1;
-	enum ds_type		type;
 };
 
 static const struct chip_desc chips[] = { {
 	.name		= "ds1307",
-	.type		= ds_1307,
 	.nvram56	= 1,
 }, {
 	.name		= "ds1337",
-	.type		= ds_1337,
 	.alarm		= 1,
 }, {
 	.name		= "ds1338",
-	.type		= ds_1338,
 	.nvram56	= 1,
 }, {
 	.name		= "ds1339",
-	.type		= ds_1339,
 	.alarm		= 1,
 }, {
 	.name		= "ds1340",
-	.type		= ds_1340,
 }, {
 	.name		= "m41t00",
-	.type		= m41t00,
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
+static const struct i2c_device_id ds1307_id[] = {
+	{ "ds1307", ds_1307 },
+	{ "ds1337", ds_1337 },
+	{ "ds1338", ds_1338 },
+	{ "ds1339", ds_1339 },
+	{ "ds1340", ds_1340 },
+	{ "m41t00", m41t00 },
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, ds1307_id);
 
 static int ds1307_get_time(struct device *dev, struct rtc_time *t)
 {
@@ -335,12 +329,7 @@ static int __devinit ds1307_probe(struct
 	const struct chip_desc	*chip;
 	struct i2c_adapter	*adapter = to_i2c_adapter(client->dev.parent);
 
-	chip = find_chip(client->name);
-	if (!chip) {
-		dev_err(&client->dev, "unknown chip type '%s'\n",
-				client->name);
-		return -ENODEV;
-	}
+	chip = &chips[id->driver_data];
 
 	if (!i2c_check_functionality(adapter,
 			I2C_FUNC_I2C | I2C_FUNC_SMBUS_WRITE_BYTE_DATA))
@@ -362,7 +351,7 @@ static int __devinit ds1307_probe(struct
 	ds1307->msg[1].len = sizeof(ds1307->regs);
 	ds1307->msg[1].buf = ds1307->regs;
 
-	ds1307->type = chip->type;
+	ds1307->type = id->driver_data;
 
 	switch (ds1307->type) {
 	case ds_1337:
@@ -538,6 +527,7 @@ static struct i2c_driver ds1307_driver =
 	},
 	.probe		= ds1307_probe,
 	.remove		= __devexit_p(ds1307_remove),
+	.id_table	= ds1307_id,
 };
 
 static int __init ds1307_init(void)
--- linux-2.6.24-rc8.orig/drivers/rtc/rtc-ds1374.c	2008-01-20 17:26:58.000000000 +0100
+++ linux-2.6.24-rc8/drivers/rtc/rtc-ds1374.c	2008-01-20 19:04:10.000000000 +0100
@@ -41,6 +41,12 @@
 #define DS1374_REG_SR_AF	0x01 /* Alarm Flag */
 #define DS1374_REG_TCR		0x09 /* Trickle Charge */
 
+static const struct i2c_device_id ds1374_id[] = {
+	{ "ds1374", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, ds1374_id);
+
 struct ds1374 {
 	struct i2c_client *client;
 	struct rtc_device *rtc;
@@ -430,6 +436,7 @@ static struct i2c_driver ds1374_driver =
 	},
 	.probe = ds1374_probe,
 	.remove = __devexit_p(ds1374_remove),
+	.id_table = ds1374_id,
 };
 
 static int __init ds1374_init(void)
--- linux-2.6.24-rc8.orig/drivers/rtc/rtc-m41t80.c	2008-01-20 17:26:58.000000000 +0100
+++ linux-2.6.24-rc8/drivers/rtc/rtc-m41t80.c	2008-01-20 19:09:09.000000000 +0100
@@ -60,48 +60,21 @@
 
 #define DRV_VERSION "0.05"
 
-struct m41t80_chip_info {
-	const char *name;
-	u8 features;
-};
-
-static const struct m41t80_chip_info m41t80_chip_info_tbl[] = {
-	{
-		.name		= "m41t80",
-		.features	= 0,
-	},
-	{
-		.name		= "m41t81",
-		.features	= M41T80_FEATURE_HT,
-	},
-	{
-		.name		= "m41t81s",
-		.features	= M41T80_FEATURE_HT | M41T80_FEATURE_BL,
-	},
-	{
-		.name		= "m41t82",
-		.features	= M41T80_FEATURE_HT | M41T80_FEATURE_BL,
-	},
-	{
-		.name		= "m41t83",
-		.features	= M41T80_FEATURE_HT | M41T80_FEATURE_BL,
-	},
-	{
-		.name		= "m41st84",
-		.features	= M41T80_FEATURE_HT | M41T80_FEATURE_BL,
-	},
-	{
-		.name		= "m41st85",
-		.features	= M41T80_FEATURE_HT | M41T80_FEATURE_BL,
-	},
-	{
-		.name		= "m41st87",
-		.features	= M41T80_FEATURE_HT | M41T80_FEATURE_BL,
-	},
+static const struct i2c_device_id m41t80_id[] = {
+	{ "m41t80", 0 },
+	{ "m41t81", M41T80_FEATURE_HT },
+	{ "m41t81s", M41T80_FEATURE_HT | M41T80_FEATURE_BL },
+	{ "m41t82", M41T80_FEATURE_HT | M41T80_FEATURE_BL },
+	{ "m41t83", M41T80_FEATURE_HT | M41T80_FEATURE_BL },
+	{ "m41st84", M41T80_FEATURE_HT | M41T80_FEATURE_BL },
+	{ "m41st85", M41T80_FEATURE_HT | M41T80_FEATURE_BL },
+	{ "m41st87", M41T80_FEATURE_HT | M41T80_FEATURE_BL },
+	{},
 };
+MODULE_DEVICE_TABLE(i2c, m41t80_id);
 
 struct m41t80_data {
-	const struct m41t80_chip_info *chip;
+	u8 features;
 	struct rtc_device *rtc;
 };
 
@@ -208,7 +181,7 @@ static int m41t80_rtc_proc(struct device
 	struct m41t80_data *clientdata = i2c_get_clientdata(client);
 	u8 reg;
 
-	if (clientdata->chip->features & M41T80_FEATURE_BL) {
+	if (clientdata->features & M41T80_FEATURE_BL) {
 		reg = i2c_smbus_read_byte_data(client, M41T80_REG_FLAGS);
 		seq_printf(seq, "battery\t\t: %s\n",
 			   (reg & M41T80_FLAGS_BATT_LOW) ? "exhausted" : "ok");
@@ -759,10 +732,9 @@ static struct notifier_block wdt_notifie
 static int m41t80_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
-	int i, rc = 0;
+	int rc = 0;
 	struct rtc_device *rtc = NULL;
 	struct rtc_time tm;
-	const struct m41t80_chip_info *chip;
 	struct m41t80_data *clientdata = NULL;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C
@@ -774,19 +746,6 @@ static int m41t80_probe(struct i2c_clien
 	dev_info(&client->dev,
 		 "chip found, driver version " DRV_VERSION "\n");
 
-	chip = NULL;
-	for (i = 0; i < ARRAY_SIZE(m41t80_chip_info_tbl); i++) {
-		if (!strcmp(m41t80_chip_info_tbl[i].name, client->name)) {
-			chip = &m41t80_chip_info_tbl[i];
-			break;
-		}
-	}
-	if (!chip) {
-		dev_err(&client->dev, "%s is not supported\n", client->name);
-		rc = -ENODEV;
-		goto exit;
-	}
-
 	clientdata = kzalloc(sizeof(*clientdata), GFP_KERNEL);
 	if (!clientdata) {
 		rc = -ENOMEM;
@@ -802,7 +761,7 @@ static int m41t80_probe(struct i2c_clien
 	}
 
 	clientdata->rtc = rtc;
-	clientdata->chip = chip;
+	clientdata->features = id->driver_data;
 	i2c_set_clientdata(client, clientdata);
 
 	/* Make sure HT (Halt Update) bit is cleared */
@@ -811,7 +770,7 @@ static int m41t80_probe(struct i2c_clien
 		goto ht_err;
 
 	if (rc & M41T80_ALHOUR_HT) {
-		if (chip->features & M41T80_FEATURE_HT) {
+		if (clientdata->features & M41T80_FEATURE_HT) {
 			m41t80_get_datetime(client, &tm);
 			dev_info(&client->dev, "HT bit was set!\n");
 			dev_info(&client->dev,
@@ -843,7 +802,7 @@ static int m41t80_probe(struct i2c_clien
 		goto exit;
 
 #ifdef CONFIG_RTC_DRV_M41T80_WDT
-	if (chip->features & M41T80_FEATURE_HT) {
+	if (clientdata->features & M41T80_FEATURE_HT) {
 		rc = misc_register(&wdt_dev);
 		if (rc)
 			goto exit;
@@ -879,7 +838,7 @@ static int m41t80_remove(struct i2c_clie
 	struct rtc_device *rtc = clientdata->rtc;
 
 #ifdef CONFIG_RTC_DRV_M41T80_WDT
-	if (clientdata->chip->features & M41T80_FEATURE_HT) {
+	if (clientdata->features & M41T80_FEATURE_HT) {
 		misc_deregister(&wdt_dev);
 		unregister_reboot_notifier(&wdt_notifier);
 	}
@@ -897,6 +856,7 @@ static struct i2c_driver m41t80_driver =
 	},
 	.probe = m41t80_probe,
 	.remove = m41t80_remove,
+	.id_table = m41t80_id,
 };
 
 static int __init m41t80_rtc_init(void)
--- linux-2.6.24-rc8.orig/drivers/rtc/rtc-rs5c372.c	2008-01-20 17:26:58.000000000 +0100
+++ linux-2.6.24-rc8/drivers/rtc/rtc-rs5c372.c	2008-01-20 19:04:22.000000000 +0100
@@ -69,6 +69,15 @@ enum rtc_type {
 	rtc_rv5c387a,
 };
 
+static const struct i2c_device_id rs5c372_id[] = {
+	{ "rs5c372a", rtc_rs5c372a },
+	{ "rs5c372b", rtc_rs5c372b },
+	{ "rv5c386", rtc_rv5c386 },
+	{ "rv5c387a", rtc_rv5c387a },
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, rs5c372_id);
+
 /* REVISIT:  this assumes that:
  *  - we're in the 21st century, so it's safe to ignore the century
  *    bit for rv5c38[67] (REG_MONTH bit 7);
@@ -523,7 +532,9 @@ static int rs5c372_probe(struct i2c_clie
 	if (err < 0)
 		goto exit_kfree;
 
-	if (strcmp(client->name, "rs5c372a") == 0)
+	if (id)
+		rs5c372->type = id->driver_data;
+	else if (strcmp(client->name, "rs5c372a") == 0)
 		rs5c372->type = rtc_rs5c372a;
 	else if (strcmp(client->name, "rs5c372b") == 0)
 		rs5c372->type = rtc_rs5c372b;
@@ -652,6 +663,7 @@ static struct i2c_driver rs5c372_driver 
 	},
 	.probe		= rs5c372_probe,
 	.remove		= rs5c372_remove,
+	.id_table	= rs5c372_id,
 };
 
 static __init int rs5c372_init(void)
--- linux-2.6.24-rc8.orig/include/linux/i2c.h	2008-01-20 17:40:20.000000000 +0100
+++ linux-2.6.24-rc8/include/linux/i2c.h	2008-01-21 08:26:40.000000000 +0100
@@ -229,17 +229,17 @@ struct i2c_board_info {
 };
 
 /**
- * I2C_BOARD_INFO - macro used to list an i2c device and its driver
- * @driver: identifies the driver to use with the device
+ * I2C_BOARD_INFO - macro used to list an i2c device and its address
+ * @dev_type: identifies the device type
  * @dev_addr: the device's address on the bus.
  *
  * This macro initializes essential fields of a struct i2c_board_info,
  * declaring what has been provided on a particular board.  Optional
- * fields (such as the chip type, its associated irq, or device-specific
- * platform_data) are provided using conventional syntax.
+ * fields (such as associated irq, or device-specific platform_data)
+ * are provided using conventional syntax.
  */
-#define I2C_BOARD_INFO(driver,dev_addr) \
-	.driver_name = (driver), .addr = (dev_addr)
+#define I2C_BOARD_INFO(dev_type,dev_addr) \
+	.type = (dev_type), .addr = (dev_addr)
 
 
 /* Add-on boards should register/unregister their devices; e.g. a board

-- 
Jean Delvare
