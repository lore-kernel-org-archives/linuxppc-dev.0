Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id A03DDDDE31
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 04:41:33 +1100 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-mtd@lists.infradead.org
Subject: [PATCH 2/2] maps/mtd-ram: add an of-platform driver
Date: Wed, 21 Jan 2009 18:41:25 +0100
Message-Id: <1232559685-2268-3-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1232559685-2268-1-git-send-email-w.sang@pengutronix.de>
References: <1232559685-2268-1-git-send-email-w.sang@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, ben-linux@fluff.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Create an of-aware driver using the now exported generic functions from
plat-ram.c. A typical oftree snipplet for it looks like this:

sram@04e00000 {
	compatible = "mtd-ram";
	reg = <0x04e00000 0x00200000>;
	bank-width = <2>;
};

Partitions on this device are not yet supported.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/mtd/maps/Kconfig  |    6 ++
 drivers/mtd/maps/Makefile |    1 +
 drivers/mtd/maps/of-ram.c |  120 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mtd/maps/of-ram.c

diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
index 0225cbb..b238b6d 100644
--- a/drivers/mtd/maps/Kconfig
+++ b/drivers/mtd/maps/Kconfig
@@ -551,5 +551,11 @@ config MTD_PLATRAM
 
 	  This selection automatically selects the map_ram driver.
 
+config MTD_OFRAM
+	tristate "Map driver for of-device RAM (mtd-ram)"
+	depends on MTD_PLATRAM && OF
+	help
+	  Map driver for RAM areas described via the of-device
+	  system.
 endmenu
 
diff --git a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
index 6d9ba35..f8e3908 100644
--- a/drivers/mtd/maps/Makefile
+++ b/drivers/mtd/maps/Makefile
@@ -58,6 +58,7 @@ obj-$(CONFIG_MTD_WRSBC8260)	+= wr_sbc82xx_flash.o
 obj-$(CONFIG_MTD_DMV182)	+= dmv182.o
 obj-$(CONFIG_MTD_SHARP_SL)	+= sharpsl-flash.o
 obj-$(CONFIG_MTD_PLATRAM)	+= plat-ram.o
+obj-$(CONFIG_MTD_OFRAM)		+= of-ram.o
 obj-$(CONFIG_MTD_OMAP_NOR)	+= omap_nor.o
 obj-$(CONFIG_MTD_INTEL_VR_NOR)	+= intel_vr_nor.o
 obj-$(CONFIG_MTD_BFIN_ASYNC)	+= bfin-async-flash.o
diff --git a/drivers/mtd/maps/of-ram.c b/drivers/mtd/maps/of-ram.c
new file mode 100644
index 0000000..4d334a9
--- /dev/null
+++ b/drivers/mtd/maps/of-ram.c
@@ -0,0 +1,120 @@
+/*
+ * drivers/mtd/maps/of-ram.c
+ *
+ * Generic of device based RAM map
+ *
+ * Copyright (C) 2009 Wolfram Sang, Pengutronix
+ *
+ * Using plat-ram.c by Ben Dooks
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/mtd/plat-ram.h>
+
+static int of_ram_probe(struct of_device *op, const struct of_device_id *match)
+{
+	struct platdata_mtd_ram *pdata;
+	struct resource *resource;
+	const char *name;
+	const u32 *bankwidth;
+	int ret = -ENOMEM;
+
+	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		goto bad0;
+	op->dev.platform_data = pdata;
+
+	name = of_get_property(op->node, "name", NULL);
+	if (!name) {
+		ret = -ENOENT;
+		dev_dbg(&op->dev, "could not get node name\n");
+		goto bad1;
+	}
+
+	resource = kzalloc(sizeof(struct resource), GFP_KERNEL);
+	if (!resource)
+		goto bad1;
+
+	if (of_address_to_resource(op->node, 0, resource)) {
+		ret = -ENXIO;
+		dev_dbg(&op->dev, "could not create resource\n");
+		goto bad2;
+	}
+
+	bankwidth = of_get_property(op->node, "bank-width", NULL);
+	if (*bankwidth == 0) {
+		ret = -ENOENT;
+		dev_dbg(&op->dev, "bank width not set\n");
+		goto bad2;
+	}
+	pdata->bankwidth = *bankwidth;
+
+	ret = __platram_probe(&op->dev, name, resource, pdata);
+	kfree(resource);
+
+	if (ret)
+		goto bad1;
+
+	return 0;
+
+ bad2:
+	kfree(resource);
+ bad1:
+	op->dev.platform_data = NULL;
+	kfree(pdata);
+ bad0:
+	return ret;
+}
+
+static int of_ram_remove(struct of_device *op)
+{
+	int ret;
+	struct platdata_mtd_ram *pdata = op->dev.platform_data;
+
+	ret = __platram_remove(&op->dev);
+	op->dev.platform_data = NULL;
+	kfree(pdata);
+	return ret;
+}
+
+static struct of_device_id of_ram_match[] = {
+	{ .compatible = "mtd-ram", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_ram_match);
+
+static struct of_platform_driver of_ram_driver = {
+	.owner = THIS_MODULE,
+	.name = "of-ram",
+	.match_table = of_ram_match,
+	.probe = of_ram_probe,
+	.remove = of_ram_remove,
+};
+
+static int __init of_ram_init(void)
+{
+	return of_register_platform_driver(&of_ram_driver);
+}
+
+static void __exit of_ram_exit(void)
+{
+	of_unregister_platform_driver(&of_ram_driver);
+}
+
+module_init(of_ram_init);
+module_exit(of_ram_exit);
+
+MODULE_AUTHOR("Wolfram Sang");
+MODULE_DESCRIPTION("MTD OF RAM map driver");
+MODULE_LICENSE("GPL v2");
-- 
1.5.6.5
