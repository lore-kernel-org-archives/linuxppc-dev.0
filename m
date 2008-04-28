Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4A335DDE28
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 19:53:40 +1000 (EST)
Date: Mon, 28 Apr 2008 11:53:15 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Linux I2C <i2c@lm-sensors.org>
Subject: [PATCH 2/2] i2c: Convert most new-style drivers to use module aliasing
Message-ID: <20080428115315.06a82ad7@hyperion.delvare>
In-Reply-To: <20080428113052.6d024bda@hyperion.delvare>
References: <20080428113052.6d024bda@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Laurent, Sievers <kay.sievers@vrfy.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mundt <lethal@linux-sh.org>, Scott Wood <scottwood@freescale.com>, Kay
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Based on earlier work by Jon Smirl and Jochen Friedrich.

Update most new-style i2c drivers to use standard module aliasing
instead of the old driver_name/type driver matching scheme. I've
left the video drivers apart (except for SoC camera drivers) as
they're a bit more diffcult to deal with, they'll have their own
patch later.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Jon Smirl <jonsmirl@gmail.com>
Cc: Jochen Friedrich <jochen@scram.de>
Cc: Kay Sievers <kay.sievers@vrfy.org>
---
 arch/arm/mach-at91/board-csb337.c         |    3 -
 arch/arm/mach-at91/board-dk.c             |    3 -
 arch/arm/mach-at91/board-eb9200.c         |    3 -
 arch/arm/mach-iop32x/em7210.c             |    3 -
 arch/arm/mach-iop32x/glantank.c           |    4 -
 arch/arm/mach-iop32x/n2100.c              |    4 -
 arch/arm/mach-ixp4xx/dsmg600-setup.c      |    2 
 arch/arm/mach-ixp4xx/nas100d-setup.c      |    2 
 arch/arm/mach-ixp4xx/nslu2-setup.c        |    2 
 arch/arm/mach-omap1/board-h2.c            |    2 
 arch/arm/mach-omap1/board-h3.c            |    3 -
 arch/arm/mach-omap1/board-osk.c           |    1 
 arch/arm/mach-orion5x/db88f5281-setup.c   |    4 -
 arch/arm/mach-orion5x/dns323-setup.c      |    7 --
 arch/arm/mach-orion5x/kurobox_pro-setup.c |    4 -
 arch/arm/mach-orion5x/rd88f5182-setup.c   |    4 -
 arch/arm/mach-orion5x/ts209-setup.c       |    3 -
 arch/arm/mach-pxa/pcm990-baseboard.c      |    5 -
 arch/blackfin/mach-bf533/boards/stamp.c   |    3 -
 arch/blackfin/mach-bf537/boards/stamp.c   |    3 -
 arch/blackfin/mach-bf548/boards/ezkit.c   |    2 
 arch/powerpc/sysdev/fsl_soc.c             |   27 ++++------
 arch/sh/boards/renesas/migor/setup.c      |    3 -
 arch/sh/boards/renesas/r7780rp/setup.c    |    3 -
 drivers/gpio/pca953x.c                    |   23 +-------
 drivers/gpio/pcf857x.c                    |   33 +++++++-----
 drivers/hwmon/f75375s.c                   |   23 ++++----
 drivers/i2c/busses/i2c-taos-evm.c         |    3 -
 drivers/i2c/chips/ds1682.c                |    7 ++
 drivers/i2c/chips/menelaus.c              |    7 ++
 drivers/i2c/chips/tps65010.c              |   29 ++++------
 drivers/i2c/chips/tsl2550.c               |    7 ++
 drivers/media/video/mt9m001.c             |    7 ++
 drivers/media/video/mt9v022.c             |    7 ++
 drivers/rtc/rtc-ds1307.c                  |   63 +++++++++--------------
 drivers/rtc/rtc-ds1374.c                  |    7 ++
 drivers/rtc/rtc-m41t80.c                  |   78 +++++++----------------------
 drivers/rtc/rtc-rs5c372.c                 |   24 ++++----
 drivers/rtc/rtc-s35390a.c                 |    7 ++
 include/linux/i2c.h                       |   12 ++--
 40 files changed, 190 insertions(+), 247 deletions(-)

--- linux-2.6.26-rc0.orig/arch/arm/mach-at91/board-csb337.c	2008-04-27 22:07:12.000000000 +0200
+++ linux-2.6.26-rc0/arch/arm/mach-at91/board-csb337.c	2008-04-27 22:09:48.000000000 +0200
@@ -79,8 +79,7 @@ static struct at91_udc_data __initdata c
 
 static struct i2c_board_info __initdata csb337_i2c_devices[] = {
 	{
-		I2C_BOARD_INFO("rtc-ds1307", 0x68),
-		.type	= "ds1307",
+		I2C_BOARD_INFO("ds1307", 0x68),
 	},
 };
 
--- linux-2.6.26-rc0.orig/arch/arm/mach-at91/board-dk.c	2008-04-27 22:04:59.000000000 +0200
+++ linux-2.6.26-rc0/arch/arm/mach-at91/board-dk.c	2008-04-27 22:09:48.000000000 +0200
@@ -132,8 +132,7 @@ static struct i2c_board_info __initdata 
 		I2C_BOARD_INFO("x9429", 0x28),
 	},
 	{
-		I2C_BOARD_INFO("at24c", 0x50),
-		.type	= "24c1024",
+		I2C_BOARD_INFO("24c1024", 0x50),
 	}
 };
 
--- linux-2.6.26-rc0.orig/arch/arm/mach-at91/board-eb9200.c	2008-04-27 22:04:59.000000000 +0200
+++ linux-2.6.26-rc0/arch/arm/mach-at91/board-eb9200.c	2008-04-27 22:09:48.000000000 +0200
@@ -93,8 +93,7 @@ static struct at91_mmc_data __initdata e
 
 static struct i2c_board_info __initdata eb9200_i2c_devices[] = {
 	{
-		I2C_BOARD_INFO("at24c", 0x50),
-		.type	= "24c512",
+		I2C_BOARD_INFO("24c512", 0x50),
 	},
 };
 
--- linux-2.6.26-rc0.orig/arch/arm/mach-iop32x/em7210.c	2008-04-27 22:04:59.000000000 +0200
+++ linux-2.6.26-rc0/arch/arm/mach-iop32x/em7210.c	2008-04-27 22:09:48.000000000 +0200
@@ -50,8 +50,7 @@ static struct sys_timer em7210_timer = {
  */
 static struct i2c_board_info __initdata em7210_i2c_devices[] = {
 	{
-		I2C_BOARD_INFO("rtc-rs5c372", 0x32),
-		.type = "rs5c372a",
+		I2C_BOARD_INFO("rs5c372a", 0x32),
 	},
 };
 
--- linux-2.6.26-rc0.orig/arch/arm/mach-iop32x/glantank.c	2008-04-27 22:04:59.000000000 +0200
+++ linux-2.6.26-rc0/arch/arm/mach-iop32x/glantank.c	2008-04-27 22:09:48.000000000 +0200
@@ -176,12 +176,10 @@ static struct f75375s_platform_data glan
 
 static struct i2c_board_info __initdata glantank_i2c_devices[] = {
 	{
-		I2C_BOARD_INFO("rtc-rs5c372", 0x32),
-		.type = "rs5c372a",
+		I2C_BOARD_INFO("rs5c372a", 0x32),
 	},
 	{
 		I2C_BOARD_INFO("f75375", 0x2e),
-		.type = "f75375",
 		.platform_data = &glantank_f75375s,
 	},
 };
--- linux-2.6.26-rc0.orig/arch/arm/mach-iop32x/n2100.c	2008-04-27 22:04:59.000000000 +0200
+++ linux-2.6.26-rc0/arch/arm/mach-iop32x/n2100.c	2008-04-27 22:09:48.000000000 +0200
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
--- linux-2.6.26-rc0.orig/arch/arm/mach-ixp4xx/dsmg600-setup.c	2008-04-27 22:04:59.000000000 +0200
+++ linux-2.6.26-rc0/arch/arm/mach-ixp4xx/dsmg600-setup.c	2008-04-27 22:09:48.000000000 +0200
@@ -65,7 +65,7 @@ static struct platform_device dsmg600_i2
 
 static struct i2c_board_info __initdata dsmg600_i2c_board_info [] = {
 	{
-		I2C_BOARD_INFO("rtc-pcf8563", 0x51),
+		I2C_BOARD_INFO("pcf8563", 0x51),
 	},
 };
 
--- linux-2.6.26-rc0.orig/arch/arm/mach-ixp4xx/nas100d-setup.c	2008-04-27 22:04:59.000000000 +0200
+++ linux-2.6.26-rc0/arch/arm/mach-ixp4xx/nas100d-setup.c	2008-04-27 22:09:48.000000000 +0200
@@ -54,7 +54,7 @@ static struct platform_device nas100d_fl
 
 static struct i2c_board_info __initdata nas100d_i2c_board_info [] = {
 	{
-		I2C_BOARD_INFO("rtc-pcf8563", 0x51),
+		I2C_BOARD_INFO("pcf8563", 0x51),
 	},
 };
 
--- linux-2.6.26-rc0.orig/arch/arm/mach-ixp4xx/nslu2-setup.c	2008-04-27 22:04:59.000000000 +0200
+++ linux-2.6.26-rc0/arch/arm/mach-ixp4xx/nslu2-setup.c	2008-04-27 22:09:48.000000000 +0200
@@ -57,7 +57,7 @@ static struct i2c_gpio_platform_data nsl
 
 static struct i2c_board_info __initdata nslu2_i2c_board_info [] = {
 	{
-		I2C_BOARD_INFO("rtc-x1205", 0x6f),
+		I2C_BOARD_INFO("x1205", 0x6f),
 	},
 };
 
--- linux-2.6.26-rc0.orig/arch/arm/mach-omap1/board-h2.c	2008-04-27 22:04:59.000000000 +0200
+++ linux-2.6.26-rc0/arch/arm/mach-omap1/board-h2.c	2008-04-27 22:09:48.000000000 +0200
@@ -351,11 +351,9 @@ static void __init h2_init_smc91x(void)
 static struct i2c_board_info __initdata h2_i2c_board_info[] = {
 	{
 		I2C_BOARD_INFO("tps65010", 0x48),
-		.type           = "tps65010",
 		.irq            = OMAP_GPIO_IRQ(58),
 	}, {
 		I2C_BOARD_INFO("isp1301_omap", 0x2d),
-		.type		= "isp1301_omap",
 		.irq		= OMAP_GPIO_IRQ(2),
 	},
 };
--- linux-2.6.26-rc0.orig/arch/arm/mach-omap1/board-h3.c	2008-04-27 22:04:59.000000000 +0200
+++ linux-2.6.26-rc0/arch/arm/mach-omap1/board-h3.c	2008-04-27 22:09:48.000000000 +0200
@@ -473,8 +473,7 @@ static struct omap_board_config_kernel h
 
 static struct i2c_board_info __initdata h3_i2c_board_info[] = {
        {
-               I2C_BOARD_INFO("tps65010", 0x48),
-               .type           = "tps65013",
+		I2C_BOARD_INFO("tps65013", 0x48),
                /* .irq         = OMAP_GPIO_IRQ(??), */
        },
 };
--- linux-2.6.26-rc0.orig/arch/arm/mach-omap1/board-osk.c	2008-04-27 22:07:12.000000000 +0200
+++ linux-2.6.26-rc0/arch/arm/mach-omap1/board-osk.c	2008-04-27 22:09:48.000000000 +0200
@@ -254,7 +254,6 @@ static struct tps65010_board tps_board =
 static struct i2c_board_info __initdata osk_i2c_board_info[] = {
 	{
 		I2C_BOARD_INFO("tps65010", 0x48),
-		.type		= "tps65010",
 		.irq		= OMAP_GPIO_IRQ(OMAP_MPUIO(1)),
 		.platform_data	= &tps_board,
 
--- linux-2.6.26-rc0.orig/arch/arm/mach-orion5x/db88f5281-setup.c	2008-04-27 22:07:12.000000000 +0200
+++ linux-2.6.26-rc0/arch/arm/mach-orion5x/db88f5281-setup.c	2008-04-27 22:57:29.000000000 +0200
@@ -292,9 +292,7 @@ static struct mv643xx_eth_platform_data 
  * RTC DS1339 on I2C bus
  ****************************************************************************/
 static struct i2c_board_info __initdata db88f5281_i2c_rtc = {
-	.driver_name	= "rtc-ds1307",
-	.type		= "ds1339",
-	.addr		= 0x68,
+	I2C_BOARD_INFO("ds1339", 0x68),
 };
 
 /*****************************************************************************
--- linux-2.6.26-rc0.orig/arch/arm/mach-orion5x/dns323-setup.c	2008-04-27 22:07:12.000000000 +0200
+++ linux-2.6.26-rc0/arch/arm/mach-orion5x/dns323-setup.c	2008-04-27 22:09:48.000000000 +0200
@@ -220,19 +220,16 @@ static struct platform_device *dns323_pl
 static struct i2c_board_info __initdata dns323_i2c_devices[] = {
 	{
 		I2C_BOARD_INFO("g760a", 0x3e),
-		.type = "g760a",
 	},
 #if 0
 	/* this entry requires the new-style driver model lm75 driver,
 	 * for the meantime "insmod lm75.ko force_lm75=0,0x48" is needed */
 	{
-		I2C_BOARD_INFO("lm75", 0x48),
-		.type = "g751",
+		I2C_BOARD_INFO("g751", 0x48),
 	},
 #endif
 	{
-		I2C_BOARD_INFO("rtc-m41t80", 0x68),
-		.type = "m41t80",
+		I2C_BOARD_INFO("m41t80", 0x68),
 	}
 };
 
--- linux-2.6.26-rc0.orig/arch/arm/mach-orion5x/kurobox_pro-setup.c	2008-04-27 22:07:12.000000000 +0200
+++ linux-2.6.26-rc0/arch/arm/mach-orion5x/kurobox_pro-setup.c	2008-04-27 22:56:59.000000000 +0200
@@ -162,9 +162,7 @@ static struct mv643xx_eth_platform_data 
  * RTC 5C372a on I2C bus
  ****************************************************************************/
 static struct i2c_board_info __initdata kurobox_pro_i2c_rtc = {
-       .driver_name    = "rtc-rs5c372",
-       .type           = "rs5c372a",
-       .addr           = 0x32,
+	I2C_BOARD_INFO("rs5c372a", 0x32),
 };
 
 /*****************************************************************************
--- linux-2.6.26-rc0.orig/arch/arm/mach-orion5x/rd88f5182-setup.c	2008-04-27 22:07:12.000000000 +0200
+++ linux-2.6.26-rc0/arch/arm/mach-orion5x/rd88f5182-setup.c	2008-04-27 22:58:02.000000000 +0200
@@ -224,9 +224,7 @@ static struct mv643xx_eth_platform_data 
  * RTC DS1338 on I2C bus
  ****************************************************************************/
 static struct i2c_board_info __initdata rd88f5182_i2c_rtc = {
-	.driver_name	= "rtc-ds1307",
-	.type		= "ds1338",
-	.addr		= 0x68,
+	I2C_BOARD_INFO("ds1338", 0x68),
 };
 
 /*****************************************************************************
--- linux-2.6.26-rc0.orig/arch/arm/mach-orion5x/ts209-setup.c	2008-04-27 22:07:12.000000000 +0200
+++ linux-2.6.26-rc0/arch/arm/mach-orion5x/ts209-setup.c	2008-04-27 22:58:52.000000000 +0200
@@ -276,8 +276,7 @@ static void __init ts209_find_mac_addr(v
 #define TS209_RTC_GPIO	3
 
 static struct i2c_board_info __initdata qnap_ts209_i2c_rtc = {
-       .driver_name = "rtc-s35390a",
-       .addr        = 0x30,
+	I2C_BOARD_INFO("s35390a", 0x30),
        .irq         = 0,
 };
 
--- linux-2.6.26-rc0.orig/arch/arm/mach-pxa/pcm990-baseboard.c	2008-04-27 22:07:12.000000000 +0200
+++ linux-2.6.26-rc0/arch/arm/mach-pxa/pcm990-baseboard.c	2008-04-27 22:09:48.000000000 +0200
@@ -320,16 +320,13 @@ static struct soc_camera_link iclink[] =
 static struct i2c_board_info __initdata pcm990_i2c_devices[] = {
 	{
 		/* Must initialize before the camera(s) */
-		I2C_BOARD_INFO("pca953x", 0x41),
-		.type = "pca9536",
+		I2C_BOARD_INFO("pca9536", 0x41),
 		.platform_data = &pca9536_data,
 	}, {
 		I2C_BOARD_INFO("mt9v022", 0x48),
-		.type = "mt9v022",
 		.platform_data = &iclink[0], /* With extender */
 	}, {
 		I2C_BOARD_INFO("mt9m001", 0x5d),
-		.type = "mt9m001",
 		.platform_data = &iclink[0], /* With extender */
 	},
 };
--- linux-2.6.26-rc0.orig/arch/blackfin/mach-bf533/boards/stamp.c	2008-04-27 22:07:12.000000000 +0200
+++ linux-2.6.26-rc0/arch/blackfin/mach-bf533/boards/stamp.c	2008-04-27 22:09:48.000000000 +0200
@@ -499,20 +499,17 @@ static struct i2c_board_info __initdata 
 #if defined(CONFIG_JOYSTICK_AD7142) || defined(CONFIG_JOYSTICK_AD7142_MODULE)
 	{
 		I2C_BOARD_INFO("ad7142_joystick", 0x2C),
-		.type = "ad7142_joystick",
 		.irq = 39,
 	},
 #endif
 #if defined(CONFIG_TWI_LCD) || defined(CONFIG_TWI_LCD_MODULE)
 	{
 		I2C_BOARD_INFO("pcf8574_lcd", 0x22),
-		.type = "pcf8574_lcd",
 	},
 #endif
 #if defined(CONFIG_TWI_KEYPAD) || defined(CONFIG_TWI_KEYPAD_MODULE)
 	{
 		I2C_BOARD_INFO("pcf8574_keypad", 0x27),
-		.type = "pcf8574_keypad",
 		.irq = 39,
 	},
 #endif
--- linux-2.6.26-rc0.orig/arch/blackfin/mach-bf537/boards/stamp.c	2008-04-27 22:07:12.000000000 +0200
+++ linux-2.6.26-rc0/arch/blackfin/mach-bf537/boards/stamp.c	2008-04-27 22:09:48.000000000 +0200
@@ -751,20 +751,17 @@ static struct i2c_board_info __initdata 
 #if defined(CONFIG_JOYSTICK_AD7142) || defined(CONFIG_JOYSTICK_AD7142_MODULE)
 	{
 		I2C_BOARD_INFO("ad7142_joystick", 0x2C),
-		.type = "ad7142_joystick",
 		.irq = 55,
 	},
 #endif
 #if defined(CONFIG_TWI_LCD) || defined(CONFIG_TWI_LCD_MODULE)
 	{
 		I2C_BOARD_INFO("pcf8574_lcd", 0x22),
-		.type = "pcf8574_lcd",
 	},
 #endif
 #if defined(CONFIG_TWI_KEYPAD) || defined(CONFIG_TWI_KEYPAD_MODULE)
 	{
 		I2C_BOARD_INFO("pcf8574_keypad", 0x27),
-		.type = "pcf8574_keypad",
 		.irq = 72,
 	},
 #endif
--- linux-2.6.26-rc0.orig/arch/blackfin/mach-bf548/boards/ezkit.c	2008-04-27 22:07:12.000000000 +0200
+++ linux-2.6.26-rc0/arch/blackfin/mach-bf548/boards/ezkit.c	2008-04-27 22:09:48.000000000 +0200
@@ -641,13 +641,11 @@ static struct i2c_board_info __initdata 
 #if defined(CONFIG_TWI_LCD) || defined(CONFIG_TWI_LCD_MODULE)
 	{
 		I2C_BOARD_INFO("pcf8574_lcd", 0x22),
-		.type = "pcf8574_lcd",
 	},
 #endif
 #if defined(CONFIG_TWI_KEYPAD) || defined(CONFIG_TWI_KEYPAD_MODULE)
 	{
 		I2C_BOARD_INFO("pcf8574_keypad", 0x27),
-		.type = "pcf8574_keypad",
 		.irq = 212,
 	},
 #endif
--- linux-2.6.26-rc0.orig/arch/powerpc/sysdev/fsl_soc.c	2008-04-27 22:07:13.000000000 +0200
+++ linux-2.6.26-rc0/arch/powerpc/sysdev/fsl_soc.c	2008-04-27 22:09:48.000000000 +0200
@@ -418,22 +418,21 @@ arch_initcall(gfar_of_init);
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
+	{"ricoh,rs5c372a", "rs5c372a"},
+	{"ricoh,rs5c372b", "rs5c372b"},
+	{"ricoh,rv5c386",  "rv5c386"},
+	{"ricoh,rv5c387a", "rv5c387a"},
+	{"dallas,ds1307",  "ds1307"},
+	{"dallas,ds1337",  "ds1337"},
+	{"dallas,ds1338",  "ds1338"},
+	{"dallas,ds1339",  "ds1339"},
+	{"dallas,ds1340",  "ds1340"},
+	{"stm,m41t00",     "m41t00"},
+	{"dallas,ds1374",  "rtc-ds1374"},
 };
 
 static int __init of_find_i2c_driver(struct device_node *node,
@@ -444,9 +443,7 @@ static int __init of_find_i2c_driver(str
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
--- linux-2.6.26-rc0.orig/arch/sh/boards/renesas/migor/setup.c	2008-04-27 22:07:13.000000000 +0200
+++ linux-2.6.26-rc0/arch/sh/boards/renesas/migor/setup.c	2008-04-27 22:09:48.000000000 +0200
@@ -199,8 +199,7 @@ static struct platform_device *migor_dev
 
 static struct i2c_board_info __initdata migor_i2c_devices[] = {
 	{
-		I2C_BOARD_INFO("rtc-rs5c372", 0x32),
-		.type   = "rs5c372b",
+		I2C_BOARD_INFO("rs5c372b", 0x32),
 	},
 	{
 		I2C_BOARD_INFO("migor_ts", 0x51),
--- linux-2.6.26-rc0.orig/arch/sh/boards/renesas/r7780rp/setup.c	2008-04-27 22:07:13.000000000 +0200
+++ linux-2.6.26-rc0/arch/sh/boards/renesas/r7780rp/setup.c	2008-04-27 22:09:48.000000000 +0200
@@ -199,8 +199,7 @@ static struct platform_device smbus_devi
 
 static struct i2c_board_info __initdata highlander_i2c_devices[] = {
 	{
-		I2C_BOARD_INFO("rtc-rs5c372", 0x32),
-		.type	= "r2025sd",
+		I2C_BOARD_INFO("r2025sd", 0x32),
 	},
 };
 
--- linux-2.6.26-rc0.orig/drivers/gpio/pca953x.c	2008-04-27 22:09:29.000000000 +0200
+++ linux-2.6.26-rc0/drivers/gpio/pca953x.c	2008-04-27 22:09:48.000000000 +0200
@@ -23,13 +23,7 @@
 #define PCA953X_INVERT         2
 #define PCA953X_DIRECTION      3
 
-/* This is temporary - in 2.6.26 i2c_driver_data should replace it. */
-struct pca953x_desc {
-	char		name[I2C_NAME_SIZE];
-	unsigned long	driver_data;
-};
-
-static const struct pca953x_desc pca953x_descs[] = {
+static const struct i2c_device_id pca953x_id[] = {
 	{ "pca9534", 8, },
 	{ "pca9535", 16, },
 	{ "pca9536", 4, },
@@ -37,7 +31,9 @@ static const struct pca953x_desc pca953x
 	{ "pca9538", 8, },
 	{ "pca9539", 16, },
 	/* REVISIT several pca955x parts should work here too */
+	{ }
 };
+MODULE_DEVICE_TABLE(i2c, pca953x_id);
 
 struct pca953x_chip {
 	unsigned gpio_start;
@@ -192,26 +188,16 @@ static void pca953x_setup_gpio(struct pc
 }
 
 static int __devinit pca953x_probe(struct i2c_client *client,
-				   const struct i2c_device_id *did)
+				   const struct i2c_device_id *id)
 {
 	struct pca953x_platform_data *pdata;
 	struct pca953x_chip *chip;
 	int ret, i;
-	const struct pca953x_desc *id = NULL;
 
 	pdata = client->dev.platform_data;
 	if (pdata == NULL)
 		return -ENODEV;
 
-	/* this loop vanishes when we get i2c_device_id */
-	for (i = 0; i < ARRAY_SIZE(pca953x_descs); i++)
-		if (!strcmp(pca953x_descs[i].name, client->name)) {
-			id = pca953x_descs + i;
-			break;
-		}
-	if (!id)
-		return -ENODEV;
-
 	chip = kzalloc(sizeof(struct pca953x_chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
@@ -291,6 +277,7 @@ static struct i2c_driver pca953x_driver 
 	},
 	.probe		= pca953x_probe,
 	.remove		= pca953x_remove,
+	.id_table	= pca953x_id,
 };
 
 static int __init pca953x_init(void)
--- linux-2.6.26-rc0.orig/drivers/gpio/pcf857x.c	2008-04-27 22:09:29.000000000 +0200
+++ linux-2.6.26-rc0/drivers/gpio/pcf857x.c	2008-04-27 22:09:48.000000000 +0200
@@ -26,6 +26,21 @@
 #include <asm/gpio.h>
 
 
+static const struct i2c_device_id pcf857x_id[] = {
+	{ "pcf8574", 8 },
+	{ "pca8574", 8 },
+	{ "pca9670", 8 },
+	{ "pca9672", 8 },
+	{ "pca9674", 8 },
+	{ "pcf8575", 16 },
+	{ "pca8575", 16 },
+	{ "pca9671", 16 },
+	{ "pca9673", 16 },
+	{ "pca9675", 16 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, pcf857x_id);
+
 /*
  * The pcf857x, pca857x, and pca967x chips only expose one read and one
  * write register.  Writing a "one" bit (to match the reset state) lets
@@ -172,13 +187,8 @@ static int pcf857x_probe(struct i2c_clie
 	 *
 	 * NOTE: we don't distinguish here between *4 and *4a parts.
 	 */
-	if (strcmp(client->name, "pcf8574") == 0
-			|| strcmp(client->name, "pca8574") == 0
-			|| strcmp(client->name, "pca9670") == 0
-			|| strcmp(client->name, "pca9672") == 0
-			|| strcmp(client->name, "pca9674") == 0
-			) {
-		gpio->chip.ngpio = 8;
+	gpio->chip.ngpio = id->driver_data;
+	if (gpio->chip.ngpio == 8) {
 		gpio->chip.direction_input = pcf857x_input8;
 		gpio->chip.get = pcf857x_get8;
 		gpio->chip.direction_output = pcf857x_output8;
@@ -198,13 +208,7 @@ static int pcf857x_probe(struct i2c_clie
 	 *
 	 * NOTE: we don't distinguish here between '75 and '75c parts.
 	 */
-	} else if (strcmp(client->name, "pcf8575") == 0
-			|| strcmp(client->name, "pca8575") == 0
-			|| strcmp(client->name, "pca9671") == 0
-			|| strcmp(client->name, "pca9673") == 0
-			|| strcmp(client->name, "pca9675") == 0
-			) {
-		gpio->chip.ngpio = 16;
+	} else if (gpio->chip.ngpio == 16) {
 		gpio->chip.direction_input = pcf857x_input16;
 		gpio->chip.get = pcf857x_get16;
 		gpio->chip.direction_output = pcf857x_output16;
@@ -313,6 +317,7 @@ static struct i2c_driver pcf857x_driver 
 	},
 	.probe	= pcf857x_probe,
 	.remove	= pcf857x_remove,
+	.id_table = pcf857x_id,
 };
 
 static int __init pcf857x_init(void)
--- linux-2.6.26-rc0.orig/drivers/hwmon/f75375s.c	2008-04-27 22:09:29.000000000 +0200
+++ linux-2.6.26-rc0/drivers/hwmon/f75375s.c	2008-04-27 22:09:48.000000000 +0200
@@ -129,12 +129,20 @@ static struct i2c_driver f75375_legacy_d
 	.detach_client = f75375_detach_client,
 };
 
+static const struct i2c_device_id f75375_id[] = {
+	{ "f75373", f75373 },
+	{ "f75375", f75375 },
+	{ }
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
@@ -645,15 +653,7 @@ static int f75375_probe(struct i2c_clien
 	i2c_set_clientdata(client, data);
 	data->client = client;
 	mutex_init(&data->update_lock);
-
-	if (strcmp(client->name, "f75375") == 0)
-		data->kind = f75375;
-	else if (strcmp(client->name, "f75373") == 0)
-		data->kind = f75373;
-	else {
-		dev_err(&client->dev, "Unsupported device: %s\n", client->name);
-		return -ENODEV;
-	}
+	data->kind = id->driver_data;
 
 	if ((err = sysfs_create_group(&client->dev.kobj, &f75375_group)))
 		goto exit_free;
@@ -714,6 +714,7 @@ static int f75375_detect(struct i2c_adap
 	u8 version = 0;
 	int err = 0;
 	const char *name = "";
+	struct i2c_device_id id;
 
 	if (!(client = kzalloc(sizeof(*client), GFP_KERNEL))) {
 		err = -ENOMEM;
@@ -750,7 +751,9 @@ static int f75375_detect(struct i2c_adap
 	if ((err = i2c_attach_client(client)))
 		goto exit_free;
 
-	if ((err = f75375_probe(client, NULL)) < 0)
+	strlcpy(id.name, name, I2C_NAME_SIZE);
+	id.driver_data = kind;
+	if ((err = f75375_probe(client, &id)) < 0)
 		goto exit_detach;
 
 	return 0;
--- linux-2.6.26-rc0.orig/drivers/i2c/busses/i2c-taos-evm.c	2008-04-27 22:04:59.000000000 +0200
+++ linux-2.6.26-rc0/drivers/i2c/busses/i2c-taos-evm.c	2008-04-27 22:09:48.000000000 +0200
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
 
--- linux-2.6.26-rc0.orig/drivers/i2c/chips/ds1682.c	2008-04-27 22:09:29.000000000 +0200
+++ linux-2.6.26-rc0/drivers/i2c/chips/ds1682.c	2008-04-27 22:09:48.000000000 +0200
@@ -235,12 +235,19 @@ static int ds1682_remove(struct i2c_clie
 	return 0;
 }
 
+static const struct i2c_device_id ds1682_id[] = {
+	{ "ds1682", 0 },
+	{ }
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
--- linux-2.6.26-rc0.orig/drivers/i2c/chips/menelaus.c	2008-04-27 22:09:29.000000000 +0200
+++ linux-2.6.26-rc0/drivers/i2c/chips/menelaus.c	2008-04-27 22:09:48.000000000 +0200
@@ -1243,12 +1243,19 @@ static int __exit menelaus_remove(struct
 	return 0;
 }
 
+static const struct i2c_device_id menelaus_id[] = {
+	{ "menelaus", 0 },
+	{ }
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
--- linux-2.6.26-rc0.orig/drivers/i2c/chips/tps65010.c	2008-04-27 22:09:29.000000000 +0200
+++ linux-2.6.26-rc0/drivers/i2c/chips/tps65010.c	2008-04-27 22:09:48.000000000 +0200
@@ -64,7 +64,6 @@ static struct i2c_driver tps65010_driver
  * as part of board setup by a bootloader.
  */
 enum tps_model {
-	TPS_UNKNOWN = 0,
 	TPS65010,
 	TPS65011,
 	TPS65012,
@@ -554,20 +553,7 @@ static int tps65010_probe(struct i2c_cli
 	mutex_init(&tps->lock);
 	INIT_DELAYED_WORK(&tps->work, tps65010_work);
 	tps->client = client;
-
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
+	tps->model = id->driver_data;
 
 	/* the IRQ is active low, but many gpio lines can't support that
 	 * so this driver uses falling-edge triggers instead.
@@ -596,9 +582,6 @@ static int tps65010_probe(struct i2c_cli
 	case TPS65012:
 		tps->por = 1;
 		break;
-	case TPS_UNKNOWN:
-		printk(KERN_WARNING "%s: unknown TPS chip\n", DRIVER_NAME);
-		break;
 	/* else CHGCONFIG.POR is replaced by AUA, enabling a WAIT mode */
 	}
 	tps->chgconf = i2c_smbus_read_byte_data(client, TPS_CHGCONFIG);
@@ -685,12 +668,22 @@ fail1:
 	return status;
 }
 
+static const struct i2c_device_id tps65010_id[] = {
+	{ "tps65010", TPS65010 },
+	{ "tps65011", TPS65011 },
+	{ "tps65012", TPS65012 },
+	{ "tps65013", TPS65013 },
+	{ }
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
--- linux-2.6.26-rc0.orig/drivers/i2c/chips/tsl2550.c	2008-04-27 22:09:29.000000000 +0200
+++ linux-2.6.26-rc0/drivers/i2c/chips/tsl2550.c	2008-04-27 22:09:48.000000000 +0200
@@ -452,6 +452,12 @@ static int tsl2550_resume(struct i2c_cli
 
 #endif /* CONFIG_PM */
 
+static const struct i2c_device_id tsl2550_id[] = {
+	{ "tsl2550", 0 },
+	{ }
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
--- linux-2.6.26-rc0.orig/drivers/media/video/mt9m001.c	2008-04-27 22:09:29.000000000 +0200
+++ linux-2.6.26-rc0/drivers/media/video/mt9m001.c	2008-04-27 22:09:48.000000000 +0200
@@ -697,12 +697,19 @@ static int mt9m001_remove(struct i2c_cli
 	return 0;
 }
 
+static const struct i2c_device_id mt9m001_id[] = {
+	{ "mt9m001", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, mt9m001_id);
+
 static struct i2c_driver mt9m001_i2c_driver = {
 	.driver = {
 		.name = "mt9m001",
 	},
 	.probe		= mt9m001_probe,
 	.remove		= mt9m001_remove,
+	.id_table	= mt9m001_id,
 };
 
 static int __init mt9m001_mod_init(void)
--- linux-2.6.26-rc0.orig/drivers/media/video/mt9v022.c	2008-04-27 22:09:29.000000000 +0200
+++ linux-2.6.26-rc0/drivers/media/video/mt9v022.c	2008-04-27 22:09:48.000000000 +0200
@@ -819,12 +819,19 @@ static int mt9v022_remove(struct i2c_cli
 	return 0;
 }
 
+static const struct i2c_device_id mt9v022_id[] = {
+	{ "mt9v022", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, mt9v022_id);
+
 static struct i2c_driver mt9v022_i2c_driver = {
 	.driver = {
 		.name = "mt9v022",
 	},
 	.probe		= mt9v022_probe,
 	.remove		= mt9v022_remove,
+	.id_table	= mt9v022_id,
 };
 
 static int __init mt9v022_mod_init(void)
--- linux-2.6.26-rc0.orig/drivers/rtc/rtc-ds1307.c	2008-04-27 22:09:29.000000000 +0200
+++ linux-2.6.26-rc0/drivers/rtc/rtc-ds1307.c	2008-04-28 09:26:39.000000000 +0200
@@ -99,45 +99,38 @@ struct ds1307 {
 };
 
 struct chip_desc {
-	char			name[9];
 	unsigned		nvram56:1;
 	unsigned		alarm:1;
-	enum ds_type		type;
 };
 
-static const struct chip_desc chips[] = { {
-	.name		= "ds1307",
-	.type		= ds_1307,
+static const struct chip_desc chips[] = {
+[ds_1307] = {
 	.nvram56	= 1,
-}, {
-	.name		= "ds1337",
-	.type		= ds_1337,
+},
+[ds_1337] = {
 	.alarm		= 1,
-}, {
-	.name		= "ds1338",
-	.type		= ds_1338,
+},
+[ds_1338] = {
 	.nvram56	= 1,
-}, {
-	.name		= "ds1339",
-	.type		= ds_1339,
+},
+[ds_1339] = {
 	.alarm		= 1,
-}, {
-	.name		= "ds1340",
-	.type		= ds_1340,
-}, {
-	.name		= "m41t00",
-	.type		= m41t00,
+},
+[ds_1340] = {
+},
+[m41t00] = {
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
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ds1307_id);
 
 static int ds1307_get_time(struct device *dev, struct rtc_time *t)
 {
@@ -332,16 +325,9 @@ static int __devinit ds1307_probe(struct
 	struct ds1307		*ds1307;
 	int			err = -ENODEV;
 	int			tmp;
-	const struct chip_desc	*chip;
+	const struct chip_desc	*chip = &chips[id->driver_data];
 	struct i2c_adapter	*adapter = to_i2c_adapter(client->dev.parent);
 
-	chip = find_chip(client->name);
-	if (!chip) {
-		dev_err(&client->dev, "unknown chip type '%s'\n",
-				client->name);
-		return -ENODEV;
-	}
-
 	if (!i2c_check_functionality(adapter,
 			I2C_FUNC_I2C | I2C_FUNC_SMBUS_WRITE_BYTE_DATA))
 		return -EIO;
@@ -362,7 +348,7 @@ static int __devinit ds1307_probe(struct
 	ds1307->msg[1].len = sizeof(ds1307->regs);
 	ds1307->msg[1].buf = ds1307->regs;
 
-	ds1307->type = chip->type;
+	ds1307->type = id->driver_data;
 
 	switch (ds1307->type) {
 	case ds_1337:
@@ -551,6 +537,7 @@ static struct i2c_driver ds1307_driver =
 	},
 	.probe		= ds1307_probe,
 	.remove		= __devexit_p(ds1307_remove),
+	.id_table	= ds1307_id,
 };
 
 static int __init ds1307_init(void)
--- linux-2.6.26-rc0.orig/drivers/rtc/rtc-ds1374.c	2008-04-27 22:09:29.000000000 +0200
+++ linux-2.6.26-rc0/drivers/rtc/rtc-ds1374.c	2008-04-27 22:09:48.000000000 +0200
@@ -41,6 +41,12 @@
 #define DS1374_REG_SR_AF	0x01 /* Alarm Flag */
 #define DS1374_REG_TCR		0x09 /* Trickle Charge */
 
+static const struct i2c_device_id ds1374_id[] = {
+	{ "ds1374", 0 },
+	{ }
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
--- linux-2.6.26-rc0.orig/drivers/rtc/rtc-m41t80.c	2008-04-27 22:09:29.000000000 +0200
+++ linux-2.6.26-rc0/drivers/rtc/rtc-m41t80.c	2008-04-27 22:09:48.000000000 +0200
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
+	{ }
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
--- linux-2.6.26-rc0.orig/drivers/rtc/rtc-rs5c372.c	2008-04-27 22:09:29.000000000 +0200
+++ linux-2.6.26-rc0/drivers/rtc/rtc-rs5c372.c	2008-04-27 22:09:48.000000000 +0200
@@ -69,6 +69,15 @@ enum rtc_type {
 	rtc_rv5c387a,
 };
 
+static const struct i2c_device_id rs5c372_id[] = {
+	{ "rs5c372a", rtc_rs5c372a },
+	{ "rs5c372b", rtc_rs5c372b },
+	{ "rv5c386", rtc_rv5c386 },
+	{ "rv5c387a", rtc_rv5c387a },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, rs5c372_id);
+
 /* REVISIT:  this assumes that:
  *  - we're in the 21st century, so it's safe to ignore the century
  *    bit for rv5c38[67] (REG_MONTH bit 7);
@@ -517,25 +526,13 @@ static int rs5c372_probe(struct i2c_clie
 	rs5c372->regs=&rs5c372->buf[1];
 
 	rs5c372->client = client;
+	rs5c372->type = id->driver_data;
 	i2c_set_clientdata(client, rs5c372);
 
 	err = rs5c_get_regs(rs5c372);
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
-
 	/* clock may be set for am/pm or 24 hr time */
 	switch (rs5c372->type) {
 	case rtc_rs5c372a:
@@ -652,6 +649,7 @@ static struct i2c_driver rs5c372_driver 
 	},
 	.probe		= rs5c372_probe,
 	.remove		= rs5c372_remove,
+	.id_table	= rs5c372_id,
 };
 
 static __init int rs5c372_init(void)
--- linux-2.6.26-rc0.orig/drivers/rtc/rtc-s35390a.c	2008-04-27 22:09:29.000000000 +0200
+++ linux-2.6.26-rc0/drivers/rtc/rtc-s35390a.c	2008-04-28 08:44:20.000000000 +0200
@@ -34,6 +34,12 @@
 #define S35390A_FLAG_RESET	0x80
 #define S35390A_FLAG_TEST	0x01
 
+static const struct i2c_device_id s35390a_id[] = {
+	{ "s35390a", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, s35390a_id);
+
 struct s35390a {
 	struct i2c_client *client[8];
 	struct rtc_device *rtc;
@@ -297,6 +303,7 @@ static struct i2c_driver s35390a_driver 
 	},
 	.probe		= s35390a_probe,
 	.remove		= s35390a_remove,
+	.id_table	= s35390a_id,
 };
 
 static int __init s35390a_rtc_init(void)
--- linux-2.6.26-rc0.orig/include/linux/i2c.h	2008-04-27 22:09:29.000000000 +0200
+++ linux-2.6.26-rc0/include/linux/i2c.h	2008-04-28 08:44:20.000000000 +0200
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
