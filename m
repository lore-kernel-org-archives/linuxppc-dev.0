Return-Path: <richard.rojfors@mocean-labs.com>
Received: from av9-2-sn3.vrr.skanova.net (av9-2-sn3.vrr.skanova.net
	[81.228.9.186]) by ozlabs.org (Postfix) with ESMTP id 30937B7B96
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 01:28:43 +1100 (EST)
Message-ID: <4AFC1B99.1090004@mocean-labs.com>
Date: Thu, 12 Nov 2009 15:28:41 +0100
From: =?ISO-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors@mocean-labs.com>
MIME-Version: 1.0
To: spi-devel-general@lists.sourceforge.net
Subject: [PATCH v2 4/4] xilinx_spi: add a platform driver using the xilinx_spi
	common module.
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	dbrownell@users.sourceforge.net, John Linn <John.Linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds in a platform device driver using the xilinx_spi common module.

Signed-off-by: Richard Röjfors <richard.rojfors@mocean-labs.com>
---
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index b956284..d1f8ee3 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -252,6 +252,13 @@ config SPI_XILINX_OF
 	help
 	  This is the OF driver for the SPI controller IP from the Xilinx EDK.

+config SPI_XILINX_PLTFM
+	tristate "Xilinx SPI controller platform device"
+	depends on SPI_XILINX
+	help
+	  This is the platform driver for the SPI controller IP
+	  from the Xilinx EDK.
+
 #
 # Add new SPI master controllers in alphabetical order above this line
 #
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 97dee8f..d8b0e4c 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_SPI_S3C24XX)		+= spi_s3c24xx.o
 obj-$(CONFIG_SPI_TXX9)			+= spi_txx9.o
 obj-$(CONFIG_SPI_XILINX)		+= xilinx_spi.o
 obj-$(CONFIG_SPI_XILINX_OF)		+= xilinx_spi_of.o
+obj-$(CONFIG_SPI_XILINX_PLTFM)		+= xilinx_spi_pltfm.o
 obj-$(CONFIG_SPI_SH_SCI)		+= spi_sh_sci.o
 obj-$(CONFIG_SPI_STMP3XXX)		+= spi_stmp.o
 # 	... add above this line ...
diff --git a/drivers/spi/xilinx_spi_pltfm.c b/drivers/spi/xilinx_spi_pltfm.c
new file mode 100644
index 0000000..24debac
--- /dev/null
+++ b/drivers/spi/xilinx_spi_pltfm.c
@@ -0,0 +1,102 @@
+/*
+ * Support for Xilinx SPI platform devices
+ * Copyright (c) 2009 Intel Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+/* Supports:
+ * Xilinx SPI devices as platform devices
+ *
+ * Inspired by xilinx_spi.c, 2002-2007 (c) MontaVista Software, Inc.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+
+#include <linux/spi/spi.h>
+#include <linux/spi/spi_bitbang.h>
+#include <linux/spi/xilinx_spi.h>
+
+#include "xilinx_spi.h"
+
+static int __devinit xilinx_spi_probe(struct platform_device *dev)
+{
+	struct xspi_platform_data *pdata;
+	struct resource *r;
+	int irq;
+	struct spi_master *master;
+	u8 i;
+
+	pdata = dev->dev.platform_data;
+	if (!pdata)
+		return -ENODEV;
+
+	r = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	if (!r)
+		return -ENODEV;
+
+	irq = platform_get_irq(dev, 0);
+	if (irq < 0)
+		return -ENXIO;
+
+	master = xilinx_spi_init(&dev->dev, r, irq, dev->id);
+	if (!master)
+		return -ENODEV;
+
+	for (i = 0; i < pdata->num_devices; i++)
+		spi_new_device(master, pdata->devices + i);
+
+	platform_set_drvdata(dev, master);
+	return 0;
+}
+
+static int __devexit xilinx_spi_remove(struct platform_device *dev)
+{
+	xilinx_spi_deinit(platform_get_drvdata(dev));
+	platform_set_drvdata(dev, 0);
+
+	return 0;
+}
+
+/* work with hotplug and coldplug */
+MODULE_ALIAS("platform:" XILINX_SPI_NAME);
+
+static struct platform_driver xilinx_spi_driver = {
+	.probe	= xilinx_spi_probe,
+	.remove	= __devexit_p(xilinx_spi_remove),
+	.driver = {
+		.name = XILINX_SPI_NAME,
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init xilinx_spi_pltfm_init(void)
+{
+	return platform_driver_register(&xilinx_spi_driver);
+}
+module_init(xilinx_spi_pltfm_init);
+
+static void __exit xilinx_spi_pltfm_exit(void)
+{
+	platform_driver_unregister(&xilinx_spi_driver);
+}
+module_exit(xilinx_spi_pltfm_exit);
+
+MODULE_AUTHOR("Mocean Laboratories <info@mocean-labs.com>");
+MODULE_DESCRIPTION("Xilinx SPI platform driver");
+MODULE_LICENSE("GPL v2");
