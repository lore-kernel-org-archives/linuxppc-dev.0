Return-Path: <richard.rojfors@mocean-labs.com>
Received: from av7-2-sn3.vrr.skanova.net (av7-2-sn3.vrr.skanova.net
	[81.228.9.182]) by ozlabs.org (Postfix) with ESMTP id 03A2DB70B0
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Nov 2009 01:40:35 +1100 (EST)
Message-ID: <4AFACCDE.7050802@mocean-labs.com>
Date: Wed, 11 Nov 2009 15:40:30 +0100
From: =?ISO-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors@mocean-labs.com>
MIME-Version: 1.0
To: spi-devel-general@lists.sourceforge.net
Subject: [PATCH 4/4] xilinx_spi: add a platform driver using the xilinx_spi
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
diff --git a/drivers/spi/xilinx_spi_pltfm.c b/drivers/spi/xilinx_spi_pltfm.c
new file mode 100644
index 0000000..f28a48e
--- /dev/null
+++ b/drivers/spi/xilinx_spi_pltfm.c
@@ -0,0 +1,101 @@
+/*
+ * xilinx_spi_pltfm.c Support for Xilinx SPI platform devices
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
+#include <linux/spi/xilinx_spi.h>
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
+	if (pdata == NULL)
+		return -ENODEV;
+
+	r = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	if (r == NULL)
+		return -ENODEV;
+
+	irq = platform_get_irq(dev, 0);
+	if (irq < 0)
+		return -ENXIO;
+
+	master = xilinx_spi_init(&dev->dev, r, irq, dev->id,
+		pdata->num_chipselect, false, pdata->bits_per_word);
+	if (IS_ERR(master))
+		return PTR_ERR(master);
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
+
diff --git a/include/linux/spi/xilinx_spi.h b/include/linux/spi/xilinx_spi.h
new file mode 100644
index 0000000..03e1301
--- /dev/null
+++ b/include/linux/spi/xilinx_spi.h
@@ -0,0 +1,19 @@
+#ifndef __LINUX_SPI_XILINX_SPI_H
+#define __LINUX_SPI_XILINX_SPI_H
+
+/**
+ * struct xspi_platform_data - Platform data of the Xilinx SPI driver
+ * @num_chipselect:	Number of chip select by the IP
+ * @bits_per_word:	Number of bits per word. 8/16/32, Note that the DS464
+ *			only support 8bit SPI.
+ * @devices:		Devices to add when the driver is probed.
+ * @num_devices:	Number of devices in the devices array.
+ */
+struct xspi_platform_data {
+	u16 num_chipselect;
+	u8 bits_per_word;
+	struct spi_board_info *devices;
+	u8 num_devices;
+};
+
+#endif /* __LINUX_SPI_XILINX_SPI_H */
