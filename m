Return-Path: <jonsmirl@gmail.com>
Received: from vms173003pub.verizon.net (vms173003pub.verizon.net
	[206.46.173.3]) by ozlabs.org (Postfix) with ESMTP id 35133DDEEC
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 01:42:30 +1100 (EST)
Received: from terra.home ([96.233.72.204]) by vms173003.mailsrvcs.net
	(Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
	with ESMTPA id <0JVC00DKNZDQ3P02@vms173003.mailsrvcs.net> for
	linuxppc-dev@ozlabs.org; Mon, 28 Jan 2008 08:39:28 -0600 (CST)
Date: Mon, 28 Jan 2008 09:42:07 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH 2/3] Convert PowerPC MPC i2c to of_platform_driver from
	platform_driver
In-reply-to: <20080128144202.8410.14647.stgit@terra.home>
To: i2c@lm-sensors.org, linuxppc-dev@ozlabs.org
Message-id: <20080128144206.8410.2505.stgit@terra.home>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20080128144202.8410.14647.stgit@terra.home>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Convert MPC i2c driver from a platform_driver to a of_platform_driver. Add the ability to dynamically load i2c drivers based on device tree names. Routine names were changed from fsl_ to mpc_ to make them match the file name. Common code moved to powerpc-common.* Orginal ppc driver left intact for deletion when ppc arch is removed.

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
---

 arch/powerpc/sysdev/fsl_soc.c       |  125 ---------------------------
 drivers/i2c/busses/Makefile         |    2 
 drivers/i2c/busses/i2c-mpc-drv.c    |  164 ++++++++++++++++++++++++++++++++---
 drivers/i2c/busses/powerpc-common.c |   81 +++++++++++++++++
 drivers/i2c/busses/powerpc-common.h |   23 +++++
 include/linux/mod_devicetable.h     |    9 ++
 6 files changed, 263 insertions(+), 141 deletions(-)
 create mode 100644 drivers/i2c/busses/powerpc-common.c
 create mode 100644 drivers/i2c/busses/powerpc-common.h


diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index e4b14a5..d6ef264 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -318,131 +318,6 @@ err:
 
 arch_initcall(gfar_of_init);
 
-#ifdef CONFIG_I2C_BOARDINFO
-#include <linux/i2c.h>
-struct i2c_driver_device {
-	char	*of_device;
-	char	*i2c_type;
-};
-
-static struct i2c_driver_device i2c_devices[] __initdata = {
-	{"ricoh,rs5c372a", "rs5c372a",},
-	{"ricoh,rs5c372b", "rs5c372b",},
-	{"ricoh,rv5c386",  "rv5c386",},
-	{"ricoh,rv5c387a", "rv5c387a",},
-	{"dallas,ds1307",  "ds1307",},
-	{"dallas,ds1337",  "ds1337",},
-	{"dallas,ds1338",  "ds1338",},
-	{"dallas,ds1339",  "ds1339",},
-	{"dallas,ds1340",  "ds1340",},
-	{"stm,m41t00",     "m41t00"},
-	{"dallas,ds1374",  "rtc-ds1374",},
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
-		if (strlcpy(info->type, i2c_devices[i].i2c_type,
-			    I2C_NAME_SIZE) >= I2C_NAME_SIZE)
-			return -ENOMEM;
-		return 0;
-	}
-	return -ENODEV;
-}
-
-static void __init of_register_i2c_devices(struct device_node *adap_node,
-					   int bus_num)
-{
-	struct device_node *node = NULL;
-
-	while ((node = of_get_next_child(adap_node, node))) {
-		struct i2c_board_info info = {};
-		const u32 *addr;
-		int len;
-
-		addr = of_get_property(node, "reg", &len);
-		if (!addr || len < sizeof(int) || *addr > (1 << 10) - 1) {
-			printk(KERN_WARNING "fsl_soc.c: invalid i2c device entry\n");
-			continue;
-		}
-
-		info.irq = irq_of_parse_and_map(node, 0);
-		if (info.irq == NO_IRQ)
-			info.irq = -1;
-
-		if (of_find_i2c_driver(node, &info) < 0)
-			continue;
-
-		info.addr = *addr;
-
-		i2c_register_board_info(bus_num, &info, 1);
-	}
-}
-
-static int __init fsl_i2c_of_init(void)
-{
-	struct device_node *np;
-	unsigned int i;
-	struct platform_device *i2c_dev;
-	int ret;
-
-	for (np = NULL, i = 0;
-	     (np = of_find_compatible_node(np, "i2c", "fsl-i2c")) != NULL;
-	     i++) {
-		struct resource r[2];
-		struct fsl_i2c_platform_data i2c_data;
-		const unsigned char *flags = NULL;
-
-		memset(&r, 0, sizeof(r));
-		memset(&i2c_data, 0, sizeof(i2c_data));
-
-		ret = of_address_to_resource(np, 0, &r[0]);
-		if (ret)
-			goto err;
-
-		of_irq_to_resource(np, 0, &r[1]);
-
-		i2c_dev = platform_device_register_simple("fsl-i2c", i, r, 2);
-		if (IS_ERR(i2c_dev)) {
-			ret = PTR_ERR(i2c_dev);
-			goto err;
-		}
-
-		i2c_data.device_flags = 0;
-		flags = of_get_property(np, "dfsrr", NULL);
-		if (flags)
-			i2c_data.device_flags |= FSL_I2C_DEV_SEPARATE_DFSRR;
-
-		flags = of_get_property(np, "fsl5200-clocking", NULL);
-		if (flags)
-			i2c_data.device_flags |= FSL_I2C_DEV_CLOCK_5200;
-
-		ret =
-		    platform_device_add_data(i2c_dev, &i2c_data,
-					     sizeof(struct
-						    fsl_i2c_platform_data));
-		if (ret)
-			goto unreg;
-
-		of_register_i2c_devices(np, i);
-	}
-
-	return 0;
-
-unreg:
-	platform_device_unregister(i2c_dev);
-err:
-	return ret;
-}
-
-arch_initcall(fsl_i2c_of_init);
-#endif
-
 #ifdef CONFIG_PPC_83xx
 static int __init mpc83xx_wdt_init(void)
 {
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 171800d..e94241f 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the i2c bus drivers.
 #
 
-i2c-mpc-objs	:= i2c-mpc-drv.o
+i2c-mpc-objs	:= i2c-mpc-drv.o powerpc-common.o
 
 obj-$(CONFIG_I2C_ALI1535)	+= i2c-ali1535.o
 obj-$(CONFIG_I2C_ALI1563)	+= i2c-ali1563.o
diff --git a/drivers/i2c/busses/i2c-mpc-drv.c b/drivers/i2c/busses/i2c-mpc-drv.c
index d20959d..ac1febf 100644
--- a/drivers/i2c/busses/i2c-mpc-drv.c
+++ b/drivers/i2c/busses/i2c-mpc-drv.c
@@ -18,6 +18,7 @@
 #include <linux/sched.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/of_platform.h>
 
 #include <asm/io.h>
 #include <linux/fsl_devices.h>
@@ -25,13 +26,15 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 
-#define MPC_I2C_ADDR  0x00
+#include "powerpc-common.h"
+
+#define DRV_NAME "mpc-i2c"
+
 #define MPC_I2C_FDR 	0x04
 #define MPC_I2C_CR	0x08
 #define MPC_I2C_SR	0x0c
 #define MPC_I2C_DR	0x10
 #define MPC_I2C_DFSRR 0x14
-#define MPC_I2C_REGION 0x20
 
 #define CCR_MEN  0x80
 #define CCR_MIEN 0x40
@@ -57,7 +60,7 @@ struct mpc_i2c {
 	u32 flags;
 };
 
-static __inline__ void writeccr(struct mpc_i2c *i2c, u32 x)
+static inline void writeccr(struct mpc_i2c *i2c, u32 x)
 {
 	writeb(x, i2c->base + MPC_I2C_CR);
 }
@@ -99,8 +102,7 @@ static int i2c_wait(struct mpc_i2c *i2c, unsigned timeout, int writing)
 	u32 x;
 	int result = 0;
 
-	if (i2c->irq == NO_IRQ)
-	{
+	if (i2c->irq == NO_IRQ) {
 		while (!(readb(i2c->base + MPC_I2C_SR) & CSR_MIF)) {
 			schedule();
 			if (time_after(jiffies, orig_jiffies + timeout)) {
@@ -178,7 +180,7 @@ static void mpc_i2c_stop(struct mpc_i2c *i2c)
 }
 
 static int mpc_write(struct mpc_i2c *i2c, int target,
-		     const u8 * data, int length, int restart)
+		     const u8 *data, int length, int restart)
 {
 	int i, result;
 	unsigned timeout = i2c->adap.timeout;
@@ -209,7 +211,7 @@ static int mpc_write(struct mpc_i2c *i2c, int target,
 }
 
 static int mpc_read(struct mpc_i2c *i2c, int target,
-		    u8 * data, int length, int restart)
+		    u8 *data, int length, int restart)
 {
 	unsigned timeout = i2c->adap.timeout;
 	int i, result;
@@ -315,6 +317,137 @@ static struct i2c_adapter mpc_ops = {
 	.timeout = 1,
 };
 
+#ifdef CONFIG_PPC_MERGE
+
+struct i2c_driver_device {
+	char	*of_device;
+	char	*i2c_driver;
+	char	*i2c_type;
+};
+
+static int mpc_i2c_probe(struct of_device *op, const struct of_device_id *match)
+{
+	int result = 0;
+	struct mpc_i2c *i2c;
+
+	i2c = kzalloc(sizeof(*i2c), GFP_KERNEL);
+	if (!i2c)
+		return -ENOMEM;
+
+	if (of_get_property(op->node, "dfsrr", NULL))
+		i2c->flags |= FSL_I2C_DEV_SEPARATE_DFSRR;
+
+	if (of_device_is_compatible(op->node, "mpc5200-i2c"))
+		i2c->flags |= FSL_I2C_DEV_CLOCK_5200;
+
+	init_waitqueue_head(&i2c->queue);
+
+	i2c->base = of_iomap(op->node, 0);
+	if (!i2c->base) {
+		printk(KERN_ERR "i2c-mpc - failed to map controller\n");
+		result = -ENOMEM;
+		goto fail_map;
+	}
+
+	i2c->irq = irq_of_parse_and_map(op->node, 0);
+	if (i2c->irq == NO_IRQ) {
+		result = -ENXIO;
+		goto fail_irq;
+	}
+
+	result = request_irq(i2c->irq, mpc_i2c_isr,
+						IRQF_SHARED, "i2c-mpc", i2c);
+	if (result < 0) {
+		printk(KERN_ERR "i2c-mpc - failed to attach interrupt\n");
+		goto fail_request;
+	}
+
+	mpc_i2c_setclock(i2c);
+
+	dev_set_drvdata(&op->dev, i2c);
+
+	i2c->adap = mpc_ops;
+	i2c_set_adapdata(&i2c->adap, i2c);
+	i2c->adap.dev.parent = &op->dev;
+
+	result = i2c_add_adapter(&i2c->adap);
+	if (result < 0) {
+		printk(KERN_ERR "i2c-mpc - failed to add adapter\n");
+		goto fail_add;
+	}
+
+	of_register_i2c_devices(&i2c->adap, op->node);
+
+	return result;
+
+ fail_add:
+	dev_set_drvdata(&op->dev, NULL);
+	free_irq(i2c->irq, i2c);
+ fail_request:
+	irq_dispose_mapping(i2c->irq);
+ fail_irq:
+	iounmap(i2c->base);
+ fail_map:
+	kfree(i2c);
+	return result;
+};
+
+static int mpc_i2c_remove(struct of_device *op)
+{
+	struct mpc_i2c *i2c = dev_get_drvdata(&op->dev);
+
+	i2c_del_adapter(&i2c->adap);
+	dev_set_drvdata(&op->dev, NULL);
+
+	if (i2c->irq != NO_IRQ)
+		free_irq(i2c->irq, i2c);
+
+	irq_dispose_mapping(i2c->irq);
+	iounmap(i2c->base);
+	kfree(i2c);
+	return 0;
+};
+
+static const struct of_device_id mpc_i2c_of_match[] = {
+	{
+		.compatible	= "fsl-i2c",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, mpc_i2c_of_match);
+
+
+/* Structure for a device driver */
+static struct of_platform_driver mpc_i2c_driver = {
+	.match_table	= mpc_i2c_of_match,
+	.probe		= mpc_i2c_probe,
+	.remove		= __devexit_p(mpc_i2c_remove),
+	.driver		= {
+		.owner	= THIS_MODULE,
+		.name	= DRV_NAME,
+	},
+};
+
+static int __init mpc_i2c_init(void)
+{
+	int rv;
+
+	rv = of_register_platform_driver(&mpc_i2c_driver);
+	if (rv)
+		printk(KERN_ERR DRV_NAME " of_register_platform_driver failed (%i)\n", rv);
+	return rv;
+}
+
+static void __exit mpc_i2c_exit(void)
+{
+	of_unregister_platform_driver(&mpc_i2c_driver);
+}
+
+module_init(mpc_i2c_init);
+module_exit(mpc_i2c_exit);
+
+#else
+
 static int fsl_i2c_probe(struct platform_device *pdev)
 {
 	int result = 0;
@@ -345,8 +478,8 @@ static int fsl_i2c_probe(struct platform_device *pdev)
 	}
 
 	if (i2c->irq != NO_IRQ)
-		if ((result = request_irq(i2c->irq, mpc_i2c_isr,
-					  IRQF_SHARED, "i2c-mpc", i2c)) < 0) {
+		result = request_irq(i2c->irq, mpc_i2c_isr, IRQF_SHARED, "i2c-mpc", i2c);
+		if (result < 0) {
 			printk(KERN_ERR
 			       "i2c-mpc - failed to attach interrupt\n");
 			goto fail_irq;
@@ -359,20 +492,21 @@ static int fsl_i2c_probe(struct platform_device *pdev)
 	i2c->adap.nr = pdev->id;
 	i2c_set_adapdata(&i2c->adap, i2c);
 	i2c->adap.dev.parent = &pdev->dev;
-	if ((result = i2c_add_numbered_adapter(&i2c->adap)) < 0) {
+	result = i2c_add_numbered_adapter(&i2c->adap);
+	if (result < 0) {
 		printk(KERN_ERR "i2c-mpc - failed to add adapter\n");
 		goto fail_add;
 	}
 
 	return result;
 
-      fail_add:
+ fail_add:
 	if (i2c->irq != NO_IRQ)
 		free_irq(i2c->irq, i2c);
-      fail_irq:
+ fail_irq:
 	iounmap(i2c->base);
-      fail_map:
-      fail_get_irq:
+ fail_map:
+ fail_get_irq:
 	kfree(i2c);
 	return result;
 };
@@ -415,6 +549,8 @@ static void __exit fsl_i2c_exit(void)
 module_init(fsl_i2c_init);
 module_exit(fsl_i2c_exit);
 
+#endif
+
 MODULE_AUTHOR("Adrian Cox <adrian@humboldt.co.uk>");
 MODULE_DESCRIPTION
     ("I2C-Bus adapter for MPC107 bridge and MPC824x/85xx/52xx processors");
diff --git a/drivers/i2c/busses/powerpc-common.c b/drivers/i2c/busses/powerpc-common.c
new file mode 100644
index 0000000..51b039f
--- /dev/null
+++ b/drivers/i2c/busses/powerpc-common.c
@@ -0,0 +1,81 @@
+/*
+ * powerpc-common.c - routines common to device tree parsing for all
+ *                    powerpc based i2c hosts
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * (C) Copyright 2008 Jon Smirl <jonsmirl@gmail.com>
+ *
+ */
+
+#include <linux/interrupt.h>
+#include <linux/i2c.h>
+#include <linux/of_platform.h>
+
+#include "powerpc-common.h"
+
+#ifdef CONFIG_PPC_MERGE
+
+void of_register_i2c_devices(struct i2c_adapter *adap, struct device_node *adap_node)
+{
+	void *result;
+	struct device_node *node = NULL;
+
+	while ((node = of_get_next_child(adap_node, node))) {
+		struct i2c_board_info info;
+		const u32 *addr;
+		const char *compatible;
+		int len;
+
+		compatible = of_get_property(node, "compatible", NULL);
+		if (!compatible) {
+			printk(KERN_ERR "i2c-mpc.c: missing compatible attribute\n");
+			continue;
+		}
+
+		addr = of_get_property(node, "reg", &len);
+		if (!addr || len < sizeof(int) || *addr > (1 << 10) - 1) {
+			printk(KERN_ERR "i2c-mpc.c: missing reg attribute for %s\n", compatible);
+			continue;
+		}
+
+		info.irq = irq_of_parse_and_map(node, 0);
+		if (info.irq < NO_IRQ) {
+			printk(KERN_ERR "i2c-mpc.c: invalid irq attribute for %s\n", compatible);
+			continue;
+		}
+
+		/* need full alias i2c:OF,vendor,device */
+		strcpy(info.type, I2C_OF_MODULE_PREFIX);
+		strncat(info.type, compatible, sizeof(info.type));
+		request_module(info.type);
+
+		/* need module alias OF,vendor,device */
+		strcpy(info.type, OF_PREFIX);
+		strncat(info.type, compatible, sizeof(info.type));
+
+		info.platform_data = NULL;
+		info.addr = *addr;
+
+		result = PTR_ERR(i2c_new_device(adap, &info));
+		if (result == NULL) {
+			printk(KERN_ERR "i2c-mpc.c: Failed to load driver for %s, err %d\n", compatible);
+			irq_dispose_mapping(info.irq);
+			continue;
+		}
+	}
+}
+
+#endif
diff --git a/drivers/i2c/busses/powerpc-common.h b/drivers/i2c/busses/powerpc-common.h
new file mode 100644
index 0000000..95f1347
--- /dev/null
+++ b/drivers/i2c/busses/powerpc-common.h
@@ -0,0 +1,23 @@
+/*
+ * powerpc-common.h - routines common to device tree parsing for all
+ *                    powerpc based i2c hosts
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * (C) Copyright 2008 Jon Smirl <jonsmirl@gmail.com>
+ *
+ */
+
+void of_register_i2c_devices(struct i2c_adapter *adap, struct device_node *adap_node);
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index d1488a0..2e53b39 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -371,8 +371,15 @@ struct virtio_device_id {
 
 /* These defines are used to separate PowerPC open firmware
  * drivers into their own namespace */
-#define I2C_NAME_SIZE	20
+#define I2C_NAME_SIZE	48  /* Needs to be large enough to hold device tree style names */
 #define I2C_MODULE_PREFIX "i2c:"
+#ifdef CONFIG_OF
+#define OF_PREFIX "OF," /* Used to put OF device tree names into their own namespace */
+#define I2C_OF_MODULE_PREFIX I2C_MODULE_PREFIX OF_PREFIX
+#define OF_ID(s, d) { OF_PREFIX s, (d) },
+#else
+#define OF_ID(s, d)
+#endif
 
 struct i2c_device_id {
 	char name[I2C_NAME_SIZE];
