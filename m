Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id DAE4BDDE1F
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 04:03:17 +1100 (EST)
Date: Tue, 4 Dec 2007 20:07:19 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
Subject: [PATCH v2 2/4] [libata] pata_of_platform: OF-Platform PATA device
	driver
Message-ID: <20071204170719.GB15599@localhost.localdomain>
References: <20071204170442.GA10460@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071204170442.GA10460@localhost.localdomain>
Cc: Jeff Garzik <jeff@garzik.org>, Arnd Bergmann <arnd@arndb.de>,
	Paul Mundt <lethal@linux-sh.org>, Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This driver nicely wraps around pata_platform library functions,
and provides OF platform bus bindings to the PATA devices.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/ata/Kconfig            |   10 ++++
 drivers/ata/Makefile           |    1 +
 drivers/ata/pata_of_platform.c |  102 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+), 0 deletions(-)
 create mode 100644 drivers/ata/pata_of_platform.c

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index ba63619..5a492fa 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -614,6 +614,16 @@ config PATA_PLATFORM
 
 	  If unsure, say N.
 
+config PATA_OF_PLATFORM
+	tristate "OpenFirmware platform device PATA support"
+	depends on PATA_PLATFORM && PPC_OF
+	help
+	  This option enables support for generic directly connected ATA
+	  devices commonly found on embedded systems with OpenFirmware
+	  bindings.
+
+	  If unsure, say N.
+
 config PATA_ICSIDE
 	tristate "Acorn ICS PATA support"
 	depends on ARM && ARCH_ACORN
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index b13feb2..ebcee64 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_PATA_IXP4XX_CF)	+= pata_ixp4xx_cf.o
 obj-$(CONFIG_PATA_SCC)		+= pata_scc.o
 obj-$(CONFIG_PATA_BF54X)	+= pata_bf54x.o
 obj-$(CONFIG_PATA_PLATFORM)	+= pata_platform.o
+obj-$(CONFIG_PATA_OF_PLATFORM)	+= pata_of_platform.o
 obj-$(CONFIG_PATA_ICSIDE)	+= pata_icside.o
 # Should be last but two libata driver
 obj-$(CONFIG_PATA_ACPI)		+= pata_acpi.o
diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
new file mode 100644
index 0000000..738f9e0
--- /dev/null
+++ b/drivers/ata/pata_of_platform.c
@@ -0,0 +1,102 @@
+/*
+ * OF-platform PATA driver
+ *
+ * Copyright (c) 2007  MontaVista Software, Inc.
+ *                     Anton Vorontsov <avorontsov@ru.mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License (Version 2) as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/pata_platform.h>
+
+static int __devinit pata_of_platform_probe(struct of_device *ofdev,
+					    const struct of_device_id *match)
+{
+	int ret;
+	struct device_node *dn = ofdev->node;
+	struct resource io_res;
+	struct resource ctl_res;
+	struct resource irq_res;
+	unsigned int reg_shift = 0;
+	int pio_mode = 0;
+	int pio_mask;
+	const u32 *prop;
+
+	ret = of_address_to_resource(dn, 0, &io_res);
+	if (ret) {
+		dev_err(&ofdev->dev, "can't get IO address from "
+			"device tree\n");
+		return -EINVAL;
+	}
+
+	ret = of_address_to_resource(dn, 1, &ctl_res);
+	if (ret) {
+		dev_err(&ofdev->dev, "can't get CTL address from "
+			"device tree\n");
+		return -EINVAL;
+	}
+
+	ret = of_irq_to_resource(dn, 0, &irq_res);
+	if (ret == NO_IRQ)
+		irq_res.start = irq_res.end = -1;
+	else
+		irq_res.flags = 0;
+
+	prop = (u32 *)of_get_property(dn, "reg-shift", NULL);
+	if (prop)
+		reg_shift = *prop;
+
+	prop = (u32 *)of_get_property(dn, "pio-mode", NULL);
+	if (prop) {
+		pio_mode = *prop;
+		if (pio_mode > 6) {
+			dev_err(&ofdev->dev, "invalid pio-mode\n");
+			return -EINVAL;
+		}
+	} else {
+		dev_info(&ofdev->dev, "pio-mode unspecified, assuming PIO0\n");
+	}
+
+	pio_mask = 1 << pio_mode;
+	pio_mask |= (1 << pio_mode) - 1;
+
+	return __pata_platform_probe(&ofdev->dev, &io_res, &ctl_res, &irq_res,
+				     reg_shift, pio_mask);
+}
+
+static int __devexit pata_of_platform_remove(struct of_device *ofdev)
+{
+	return __pata_platform_remove(&ofdev->dev);
+}
+
+static struct of_device_id pata_of_platform_match[] = {
+	{ .compatible = "ata-generic", },
+};
+
+static struct of_platform_driver pata_of_platform_driver = {
+	.name		= "pata_of_platform",
+	.match_table	= pata_of_platform_match,
+	.probe		= pata_of_platform_probe,
+	.remove		= __devexit_p(pata_of_platform_remove),
+};
+
+static int __init pata_of_platform_init(void)
+{
+	return of_register_platform_driver(&pata_of_platform_driver);
+}
+module_init(pata_of_platform_init);
+
+static void __exit pata_of_platform_exit(void)
+{
+	of_unregister_platform_driver(&pata_of_platform_driver);
+}
+module_exit(pata_of_platform_exit);
+
+MODULE_DESCRIPTION("OF-platform PATA driver");
+MODULE_AUTHOR("Anton Vorontsov <avorontsov@ru.mvista.com>");
+MODULE_LICENSE("GPL");
-- 
1.5.2.2
