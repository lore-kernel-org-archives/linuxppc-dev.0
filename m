Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id B4A6DDDD0A
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 14:23:26 +1100 (EST)
Date: Thu, 29 Nov 2007 21:26:45 -0600
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] [POWERPC] Consolidate compatible-to-i2c_boardinfo
	mapping code
Message-ID: <20071130032645.GA25580@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[POWERPC] Consolidate compatible-to-i2c_boardinfo mapping code

Move the mapping from device tree compatible field to i2c_boardinfo
structures for powerpc, since several platforms now use this.

Signed-off-by: Olof Johansson <olof@lixom.net>

---

 arch/powerpc/sysdev/Makefile         |    1 
 arch/powerpc/sysdev/fsl_soc.c        |   38 ---------------------
 arch/powerpc/sysdev/i2c_of_mapping.c |   61 +++++++++++++++++++++++++++++++++++
 include/asm-powerpc/i2c_of.h         |   14 ++++++++
 4 files changed, 77 insertions(+), 37 deletions(-)


Index: 2.6.24/arch/powerpc/sysdev/Makefile
===================================================================
--- 2.6.24.orig/arch/powerpc/sysdev/Makefile
+++ 2.6.24/arch/powerpc/sysdev/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_MV64X60)		+= $(mv64x60-y) m
 				   mv64x60_udbg.o
 obj-$(CONFIG_RTC_DRV_CMOS)	+= rtc_cmos_setup.o
 obj-$(CONFIG_AXON_RAM)		+= axonram.o
+obj-$(CONFIG_I2C_BOARDINFO)	+= i2c_of_mapping.o
 
 ifeq ($(CONFIG_PPC_MERGE),y)
 obj-$(CONFIG_PPC_INDIRECT_PCI)	+= indirect_pci.o
Index: 2.6.24/arch/powerpc/sysdev/i2c_of_mapping.c
===================================================================
--- /dev/null
+++ 2.6.24/arch/powerpc/sysdev/i2c_of_mapping.c
@@ -0,0 +1,61 @@
+/*
+ * Parts based on arch/powerpc/sysdev/fsl_soc.c:
+ *
+ * 2006 (c) MontaVista Software, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/i2c.h>
+#include <asm/i2c_of.h>
+
+struct i2c_driver_device {
+	char    *of_device;
+	char    *i2c_driver;
+	char    *i2c_type;
+};
+
+
+/* This table is used to map from device tree compat fields to
+ * the driver and model used by the i2c board info structures.
+ *
+ * Add new mappings as needed.
+ */
+
+static struct i2c_driver_device i2c_devices[] __initdata = {
+	{"ricoh,rs5c372a", "rtc-rs5c372", "rs5c372a",},
+	{"ricoh,rs5c372b", "rtc-rs5c372", "rs5c372b",},
+	{"ricoh,rv5c386",  "rtc-rs5c372", "rv5c386",},
+	{"ricoh,rv5c387a", "rtc-rs5c372", "rv5c387a",},
+	{"dallas,ds1307",  "rtc-ds1307",  "ds1307",},
+	{"dallas,ds1337",  "rtc-ds1307",  "ds1337",},
+	{"dallas,ds1338",  "rtc-ds1307",  "ds1338",},
+	{"dallas,ds1339",  "rtc-ds1307",  "ds1339",},
+	{"dallas,ds1340",  "rtc-ds1307",  "ds1340",},
+	{"stm,m41t00",     "rtc-ds1307",  "m41t00"},
+	{"dallas,ds1374",  "rtc-ds1374",  "rtc-ds1374",},
+};
+
+int __init of_fill_i2c_info(struct device_node *node,
+			    struct i2c_board_info *info)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(i2c_devices); i++) {
+		if (!of_device_is_compatible(node, i2c_devices[i].of_device))
+			continue;
+		if (strlcpy(info->driver_name, i2c_devices[i].i2c_driver,
+			    KOBJ_NAME_LEN) >= KOBJ_NAME_LEN ||
+		    strlcpy(info->type, i2c_devices[i].i2c_type,
+			    I2C_NAME_SIZE) >= I2C_NAME_SIZE)
+			return -ENOMEM;
+		return 0;
+	}
+	return -ENODEV;
+}
Index: 2.6.24/include/asm-powerpc/i2c_of.h
===================================================================
--- /dev/null
+++ 2.6.24/include/asm-powerpc/i2c_of.h
@@ -0,0 +1,14 @@
+/*
+ * Functions to map device tree compatible fields to values used by i2c
+ * board info structures
+ */
+
+#ifndef POWERPC_I2C_OF_H
+#define POWERPC_I2C_OF_H
+
+#ifdef CONFIG_I2C_BOARDINFO
+extern int __init of_fill_i2c_info(struct device_node *node,
+				   struct i2c_board_info *info);
+#endif
+
+#endif
Index: 2.6.24/arch/powerpc/sysdev/fsl_soc.c
===================================================================
--- 2.6.24.orig/arch/powerpc/sysdev/fsl_soc.c
+++ 2.6.24/arch/powerpc/sysdev/fsl_soc.c
@@ -320,43 +320,7 @@ arch_initcall(gfar_of_init);
 
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
+#include <asm/i2c_of.h>
 
 static void __init of_register_i2c_devices(struct device_node *adap_node,
 					   int bus_num)
