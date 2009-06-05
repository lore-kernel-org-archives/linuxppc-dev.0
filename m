Return-Path: <w.sang@pengutronix.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D396FB76EA
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  5 Jun 2009 22:07:04 +1000 (EST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id EB125DDD0C
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Jun 2009 22:07:03 +1000 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH V2 2/2] mtd/maps/mtd-ram: add an of-platform driver
Date: Fri,  5 Jun 2009 14:05:14 +0200
Message-Id: <1244203514-12516-3-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1244203514-12516-1-git-send-email-w.sang@pengutronix.de>
References: <1244203514-12516-1-git-send-email-w.sang@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: devicetree-discuss@ozlabs.org, albrecht.dress@arcor.de,
	linux-mtd@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Create an of-aware driver using the now exported generic functions from
plat-ram.c. Also add the documentation for the binding. Partitions are
not yet supported. Tested on a phyCORE-MPC5200B-IO.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Albrecht Dreß <albrecht.dress@arcor.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: linuxppc-dev@ozlabs.org
Cc: devicetree-discuss@ozlabs.org
Cc: linux-mtd@lists.infradead.org
---
Changes in V2:

- added binding documentation
- added __devinit & friends
- put struct resource on stack during probe
- simplified getting the name of the of-device
- made error path more readable & add check for valid bank-width-pointer
- rename driver to "of-mtd-ram"

 Documentation/powerpc/dts-bindings/mtd-ram.txt |   18 ++++
 drivers/mtd/maps/Kconfig                       |    7 ++
 drivers/mtd/maps/Makefile                      |    1 +
 drivers/mtd/maps/of-ram.c                      |  102 ++++++++++++++++++++++++
 4 files changed, 128 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/powerpc/dts-bindings/mtd-ram.txt
 create mode 100644 drivers/mtd/maps/of-ram.c

diff --git a/Documentation/powerpc/dts-bindings/mtd-ram.txt b/Documentation/powerpc/dts-bindings/mtd-ram.txt
new file mode 100644
index 0000000..a2e9932
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/mtd-ram.txt
@@ -0,0 +1,18 @@
+RAM emulating an MTD
+
+An external RAM like SRAM or FRAM can also be treated as an MTD.
+
+ - compatible : should contain the specific model of the RAM chip
+   used, if known, followed by "mtd-ram".
+ - reg : Address range of the RAM chip
+ - bank-width : Width (in bytes) of the RAM bank.
+
+Partitions are not yet supported.
+
+Example:
+
+	sram@2,0 {
+		compatible = "samsung,k6f1616u6a", "mtd-ram";
+		reg = <2 0 0x00200000>;
+		bank-width = <2>;
+	};
diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
index 82923bd..bdd9ebc 100644
--- a/drivers/mtd/maps/Kconfig
+++ b/drivers/mtd/maps/Kconfig
@@ -551,6 +551,13 @@ config MTD_PLATRAM
 
 	  This selection automatically selects the map_ram driver.
 
+config MTD_OFRAM
+	tristate "Map driver for of-device RAM (of-mtd-ram)"
+	depends on MTD_PLATRAM && OF
+	help
+	  Map driver for RAM areas described via the of-device
+	  system.
+
 config MTD_VMU
 	tristate "Map driver for Dreamcast VMU"
 	depends on MAPLE
diff --git a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
index 2dbc1be..a7a2db3 100644
--- a/drivers/mtd/maps/Makefile
+++ b/drivers/mtd/maps/Makefile
@@ -57,6 +57,7 @@ obj-$(CONFIG_MTD_IXP2000)	+= ixp2000.o
 obj-$(CONFIG_MTD_WRSBC8260)	+= wr_sbc82xx_flash.o
 obj-$(CONFIG_MTD_DMV182)	+= dmv182.o
 obj-$(CONFIG_MTD_PLATRAM)	+= plat-ram.o
+obj-$(CONFIG_MTD_OFRAM)		+= of-ram.o
 obj-$(CONFIG_MTD_OMAP_NOR)	+= omap_nor.o
 obj-$(CONFIG_MTD_INTEL_VR_NOR)	+= intel_vr_nor.o
 obj-$(CONFIG_MTD_BFIN_ASYNC)	+= bfin-async-flash.o
diff --git a/drivers/mtd/maps/of-ram.c b/drivers/mtd/maps/of-ram.c
new file mode 100644
index 0000000..e2f4476
--- /dev/null
+++ b/drivers/mtd/maps/of-ram.c
@@ -0,0 +1,102 @@
+/*
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
+static __devinit int of_ram_probe(struct of_device *op,
+			const struct of_device_id *match)
+{
+	struct platdata_mtd_ram *pdata;
+	struct resource res;
+	const u32 *bankwidth;
+	int ret = -ENOENT;
+
+	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+	op->dev.platform_data = pdata;
+
+	ret = of_address_to_resource(op->node, 0, &res);
+	if (ret) {
+		dev_dbg(&op->dev, "could not create resource (%d)\n", ret);
+		goto out_free;
+	}
+
+	bankwidth = of_get_property(op->node, "bank-width", NULL);
+	if (!bankwidth || *bankwidth == 0) {
+		dev_dbg(&op->dev, "bank width not set\n");
+		goto out_free;
+	}
+	pdata->bankwidth = *bankwidth;
+
+	ret = __platram_probe(&op->dev, op->node->name, &res, pdata);
+	if (ret) {
+		dev_dbg(&op->dev, "error probing device (%d)\n", ret);
+		goto out_free;
+	}
+
+	return 0;
+
+out_free:
+	op->dev.platform_data = NULL;
+	kfree(pdata);
+	return ret;
+}
+
+static __devexit int of_ram_remove(struct of_device *op)
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
+static const struct of_device_id __devinitconst of_ram_match[] = {
+	{ .compatible = "mtd-ram", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_ram_match);
+
+static struct of_platform_driver of_ram_driver = {
+	.owner = THIS_MODULE,
+	.name = "of-mtd-ram",
+	.match_table = of_ram_match,
+	.probe = of_ram_probe,
+	.remove = __devexit_p(of_ram_remove),
+};
+
+static int __init of_ram_init(void)
+{
+	return of_register_platform_driver(&of_ram_driver);
+}
+module_init(of_ram_init);
+
+static void __exit of_ram_exit(void)
+{
+	of_unregister_platform_driver(&of_ram_driver);
+}
+module_exit(of_ram_exit);
+
+MODULE_AUTHOR("Wolfram Sang");
+MODULE_DESCRIPTION("OF-MTD-RAM map driver");
+MODULE_LICENSE("GPL v2");
-- 
1.6.2
