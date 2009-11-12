Return-Path: <richard.rojfors@mocean-labs.com>
Received: from av7-1-sn3.vrr.skanova.net (av7-1-sn3.vrr.skanova.net
	[81.228.9.181]) by ozlabs.org (Postfix) with ESMTP id C8D12B7B6C
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 01:26:43 +1100 (EST)
Message-ID: <4AFC1B1E.60304@mocean-labs.com>
Date: Thu, 12 Nov 2009 15:26:38 +0100
From: =?ISO-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors@mocean-labs.com>
MIME-Version: 1.0
To: spi-devel-general@lists.sourceforge.net
Subject: [PATCH v2 1/4] xilinx_spi: Split into of driver and generic part.
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

This patch splits the xilinx_spi driver into a generic part and a
OF driver part.

The reason for this is to later add in a platform driver as well.

Signed-off-by: Richard Röjfors <richard.rojfors@mocean-labs.com>
---
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 4b6f7cb..e60b264 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -236,7 +236,7 @@ config SPI_TXX9

 config SPI_XILINX
 	tristate "Xilinx SPI controller"
-	depends on (XILINX_VIRTEX || MICROBLAZE) && EXPERIMENTAL
+	depends on EXPERIMENTAL
 	select SPI_BITBANG
 	help
 	  This exposes the SPI controller IP from the Xilinx EDK.
@@ -244,6 +244,12 @@ config SPI_XILINX
 	  See the "OPB Serial Peripheral Interface (SPI) (v1.00e)"
 	  Product Specification document (DS464) for hardware details.

+config SPI_XILINX_OF
+	tristate "Xilinx SPI controller OF device"
+	depends on SPI_XILINX && (XILINX_VIRTEX || MICROBLAZE)
+	help
+	  This is the OF driver for the SPI controller IP from the Xilinx EDK.
+
 #
 # Add new SPI master controllers in alphabetical order above this line
 #
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 21a1182..97dee8f 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_SPI_S3C24XX_GPIO)		+= spi_s3c24xx_gpio.o
 obj-$(CONFIG_SPI_S3C24XX)		+= spi_s3c24xx.o
 obj-$(CONFIG_SPI_TXX9)			+= spi_txx9.o
 obj-$(CONFIG_SPI_XILINX)		+= xilinx_spi.o
+obj-$(CONFIG_SPI_XILINX_OF)		+= xilinx_spi_of.o
 obj-$(CONFIG_SPI_SH_SCI)		+= spi_sh_sci.o
 obj-$(CONFIG_SPI_STMP3XXX)		+= spi_stmp.o
 # 	... add above this line ...
diff --git a/drivers/spi/xilinx_spi.c b/drivers/spi/xilinx_spi.c
index 46b8c5c..5761a4c 100644
--- a/drivers/spi/xilinx_spi.c
+++ b/drivers/spi/xilinx_spi.c
@@ -14,16 +14,14 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
-#include <linux/platform_device.h>
-
-#include <linux/of_platform.h>
-#include <linux/of_device.h>
-#include <linux/of_spi.h>

 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
 #include <linux/io.h>

+#include "xilinx_spi.h"
+#include <linux/spi/xilinx_spi.h>
+
 #define XILINX_SPI_NAME "xilinx_spi"

 /* Register definitions as per "OPB Serial Peripheral Interface (SPI) (v1.00e)
@@ -78,7 +76,7 @@ struct xilinx_spi {
 	/* bitbang has to be first */
 	struct spi_bitbang bitbang;
 	struct completion done;
-
+	struct resource mem; /* phys mem */
 	void __iomem	*regs;	/* virt. address of the control registers */

 	u32		irq;
@@ -283,40 +281,22 @@ static irqreturn_t xilinx_spi_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }

-static int __init xilinx_spi_of_probe(struct of_device *ofdev,
-					const struct of_device_id *match)
+struct spi_master *xilinx_spi_init(struct device *dev, struct resource *mem,
+	u32 irq, s16 bus_num)
 {
 	struct spi_master *master;
 	struct xilinx_spi *xspi;
-	struct resource r_irq_struct;
-	struct resource r_mem_struct;
-
-	struct resource *r_irq = &r_irq_struct;
-	struct resource *r_mem = &r_mem_struct;
-	int rc = 0;
-	const u32 *prop;
-	int len;
-
-	/* Get resources(memory, IRQ) associated with the device */
-	master = spi_alloc_master(&ofdev->dev, sizeof(struct xilinx_spi));
+	struct xspi_platform_data *pdata = dev->platform_data;
+	int ret;

-	if (master == NULL) {
-		return -ENOMEM;
-	}
-
-	dev_set_drvdata(&ofdev->dev, master);
-
-	rc = of_address_to_resource(ofdev->node, 0, r_mem);
-	if (rc) {
-		dev_warn(&ofdev->dev, "invalid address\n");
-		goto put_master;
+	if (!pdata) {
+		dev_err(dev, "No platform data attached\n");
+		return NULL;
 	}

-	rc = of_irq_to_resource(ofdev->node, 0, r_irq);
-	if (rc == NO_IRQ) {
-		dev_warn(&ofdev->dev, "no IRQ found\n");
-		goto put_master;
-	}
+	master = spi_alloc_master(dev, sizeof(struct xilinx_spi));
+	if (!master)
+		return NULL;

 	/* the spi->mode bits understood by this driver: */
 	master->mode_bits = SPI_CPOL | SPI_CPHA;
@@ -329,128 +309,67 @@ static int __init xilinx_spi_of_probe(struct of_device *ofdev,
 	xspi->bitbang.master->setup = xilinx_spi_setup;
 	init_completion(&xspi->done);

-	xspi->irq = r_irq->start;
-
-	if (!request_mem_region(r_mem->start,
-			r_mem->end - r_mem->start + 1, XILINX_SPI_NAME)) {
-		rc = -ENXIO;
-		dev_warn(&ofdev->dev, "memory request failure\n");
+	if (!request_mem_region(mem->start, resource_size(mem),
+		XILINX_SPI_NAME))
 		goto put_master;
-	}

-	xspi->regs = ioremap(r_mem->start, r_mem->end - r_mem->start + 1);
+	xspi->regs = ioremap(mem->start, resource_size(mem));
 	if (xspi->regs == NULL) {
-		rc = -ENOMEM;
-		dev_warn(&ofdev->dev, "ioremap failure\n");
-		goto release_mem;
+		dev_warn(dev, "ioremap failure\n");
+		goto map_failed;
 	}
-	xspi->irq = r_irq->start;

-	/* dynamic bus assignment */
-	master->bus_num = -1;
+	master->bus_num = bus_num;
+	master->num_chipselect = pdata->num_chipselect;

-	/* number of slave select bits is required */
-	prop = of_get_property(ofdev->node, "xlnx,num-ss-bits", &len);
-	if (!prop || len < sizeof(*prop)) {
-		dev_warn(&ofdev->dev, "no 'xlnx,num-ss-bits' property\n");
-		goto unmap_io;
-	}
-	master->num_chipselect = *prop;
+	xspi->mem = *mem;
+	xspi->irq = irq;

 	/* SPI controller initializations */
 	xspi_init_hw(xspi->regs);

 	/* Register for SPI Interrupt */
-	rc = request_irq(xspi->irq, xilinx_spi_irq, 0, XILINX_SPI_NAME, xspi);
-	if (rc != 0) {
-		dev_warn(&ofdev->dev, "irq request failure: %d\n", xspi->irq);
+	ret = request_irq(xspi->irq, xilinx_spi_irq, 0, XILINX_SPI_NAME, xspi);
+	if (ret)
 		goto unmap_io;
-	}

-	rc = spi_bitbang_start(&xspi->bitbang);
-	if (rc != 0) {
-		dev_err(&ofdev->dev, "spi_bitbang_start FAILED\n");
+	ret = spi_bitbang_start(&xspi->bitbang);
+	if (ret) {
+		dev_err(dev, "spi_bitbang_start FAILED\n");
 		goto free_irq;
 	}

-	dev_info(&ofdev->dev, "at 0x%08X mapped to 0x%08X, irq=%d\n",
-			(unsigned int)r_mem->start, (u32)xspi->regs, xspi->irq);
-
-	/* Add any subnodes on the SPI bus */
-	of_register_spi_devices(master, ofdev->node);
-
-	return rc;
+	dev_info(dev, "at 0x%08X mapped to 0x%08X, irq=%d\n",
+		(u32)mem->start, (u32)xspi->regs, xspi->irq);
+	return master;

 free_irq:
 	free_irq(xspi->irq, xspi);
 unmap_io:
 	iounmap(xspi->regs);
-release_mem:
-	release_mem_region(r_mem->start, resource_size(r_mem));
+map_failed:
+	release_mem_region(mem->start, resource_size(mem));
 put_master:
 	spi_master_put(master);
-	return rc;
+	return NULL;
 }
+EXPORT_SYMBOL(xilinx_spi_init);

-static int __devexit xilinx_spi_remove(struct of_device *ofdev)
+void xilinx_spi_deinit(struct spi_master *master)
 {
 	struct xilinx_spi *xspi;
-	struct spi_master *master;
-	struct resource r_mem;

-	master = platform_get_drvdata(ofdev);
 	xspi = spi_master_get_devdata(master);

 	spi_bitbang_stop(&xspi->bitbang);
 	free_irq(xspi->irq, xspi);
 	iounmap(xspi->regs);
-	if (!of_address_to_resource(ofdev->node, 0, &r_mem))
-		release_mem_region(r_mem.start, resource_size(&r_mem));
-	dev_set_drvdata(&ofdev->dev, 0);
-	spi_master_put(xspi->bitbang.master);
-
-	return 0;
-}
-
-/* work with hotplug and coldplug */
-MODULE_ALIAS("platform:" XILINX_SPI_NAME);
-
-static int __exit xilinx_spi_of_remove(struct of_device *op)
-{
-	return xilinx_spi_remove(op);
-}

-static struct of_device_id xilinx_spi_of_match[] = {
-	{ .compatible = "xlnx,xps-spi-2.00.a", },
-	{ .compatible = "xlnx,xps-spi-2.00.b", },
-	{}
-};
-
-MODULE_DEVICE_TABLE(of, xilinx_spi_of_match);
-
-static struct of_platform_driver xilinx_spi_of_driver = {
-	.owner = THIS_MODULE,
-	.name = "xilinx-xps-spi",
-	.match_table = xilinx_spi_of_match,
-	.probe = xilinx_spi_of_probe,
-	.remove = __exit_p(xilinx_spi_of_remove),
-	.driver = {
-		.name = "xilinx-xps-spi",
-		.owner = THIS_MODULE,
-	},
-};
-
-static int __init xilinx_spi_init(void)
-{
-	return of_register_platform_driver(&xilinx_spi_of_driver);
+	release_mem_region(xspi->mem.start, resource_size(&xspi->mem));
+	spi_master_put(xspi->bitbang.master);
 }
-module_init(xilinx_spi_init);
+EXPORT_SYMBOL(xilinx_spi_deinit);

-static void __exit xilinx_spi_exit(void)
-{
-	of_unregister_platform_driver(&xilinx_spi_of_driver);
-}
-module_exit(xilinx_spi_exit);
 MODULE_AUTHOR("MontaVista Software, Inc. <source@mvista.com>");
 MODULE_DESCRIPTION("Xilinx SPI driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/spi/xilinx_spi.h b/drivers/spi/xilinx_spi.h
new file mode 100644
index 0000000..d211acc
--- /dev/null
+++ b/drivers/spi/xilinx_spi.h
@@ -0,0 +1,32 @@
+/*
+ * Xilinx SPI device driver API and platform data header file
+ *
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
+#ifndef _XILINX_SPI_H_
+#define _XILINX_SPI_H_
+
+#include <linux/spi/spi.h>
+#include <linux/spi/spi_bitbang.h>
+
+#define XILINX_SPI_NAME "xilinx_spi"
+
+struct spi_master *xilinx_spi_init(struct device *dev, struct resource *mem,
+	u32 irq, s16 bus_num);
+
+void xilinx_spi_deinit(struct spi_master *master);
+#endif
diff --git a/drivers/spi/xilinx_spi_of.c b/drivers/spi/xilinx_spi_of.c
new file mode 100644
index 0000000..8c3fb54
--- /dev/null
+++ b/drivers/spi/xilinx_spi_of.c
@@ -0,0 +1,136 @@
+/*
+ * Xilinx SPI OF device driver
+ *
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
+ * Xilinx SPI devices as OF devices
+ *
+ * Inspired by xilinx_spi.c, 2002-2007 (c) MontaVista Software, Inc.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+
+#include <linux/of_platform.h>
+#include <linux/of_device.h>
+#include <linux/of_spi.h>
+
+#include <linux/spi/xilinx_spi.h>
+#include "xilinx_spi.h"
+
+
+static int __init xilinx_spi_of_probe(struct of_device *ofdev,
+					const struct of_device_id *match)
+{
+	struct resource r_irq_struct;
+	struct resource r_mem_struct;
+	struct spi_master *master;
+
+	struct resource *r_irq = &r_irq_struct;
+	struct resource *r_mem = &r_mem_struct;
+	int rc = 0;
+	const u32 *prop;
+	int len;
+
+	rc = of_address_to_resource(ofdev->node, 0, r_mem);
+	if (rc) {
+		dev_warn(&ofdev->dev, "invalid address\n");
+		return rc;
+	}
+
+	rc = of_irq_to_resource(ofdev->node, 0, r_irq);
+	if (rc == NO_IRQ) {
+		dev_warn(&ofdev->dev, "no IRQ found\n");
+		return -ENODEV;
+	}
+
+	if (!ofdev->dev.platform_data) {
+		ofdev->dev.platform_data =
+			kzalloc(sizeof(struct xspi_platform_data), GFP_KERNEL);
+		if (!ofdev->dev.platform_data)
+			return -ENOMEM;
+	}
+
+	/* number of slave select bits is required */
+	prop = of_get_property(ofdev->node, "xlnx,num-ss-bits", &len);
+	if (!prop || len < sizeof(*prop)) {
+		dev_warn(&ofdev->dev, "no 'xlnx,num-ss-bits' property\n");
+		return -EINVAL;
+	}
+	ofdev->dev.platform_data->num_chipselect = *prop;
+	master = xilinx_spi_init(&ofdev->dev, r_mem, r_irq->start, -1);
+	if (!master)
+		return -ENODEV;
+
+	dev_set_drvdata(&ofdev->dev, master);
+
+	/* Add any subnodes on the SPI bus */
+	of_register_spi_devices(master, ofdev->node);
+
+	return 0;
+}
+
+static int __devexit xilinx_spi_remove(struct of_device *ofdev)
+{
+	xilinx_spi_deinit(dev_get_drvdata(&ofdev->dev));
+	dev_set_drvdata(&ofdev->dev, 0);
+	return 0;
+}
+
+static int __exit xilinx_spi_of_remove(struct of_device *op)
+{
+	return xilinx_spi_remove(op);
+}
+
+static struct of_device_id xilinx_spi_of_match[] = {
+	{ .compatible = "xlnx,xps-spi-2.00.a", },
+	{ .compatible = "xlnx,xps-spi-2.00.b", },
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, xilinx_spi_of_match);
+
+static struct of_platform_driver xilinx_spi_of_driver = {
+	.owner = THIS_MODULE,
+	.name = "xilinx-xps-spi",
+	.match_table = xilinx_spi_of_match,
+	.probe = xilinx_spi_of_probe,
+	.remove = __exit_p(xilinx_spi_of_remove),
+	.driver = {
+		.name = "xilinx-xps-spi",
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init xilinx_spi_of_init(void)
+{
+	return of_register_platform_driver(&xilinx_spi_of_driver);
+}
+module_init(xilinx_spi_of_init);
+
+static void __exit xilinx_spi_of_exit(void)
+{
+	of_unregister_platform_driver(&xilinx_spi_of_driver);
+}
+module_exit(xilinx_spi_of_exit);
+
+MODULE_AUTHOR("Mocean Laboratories <info@mocean-labs.com>");
+MODULE_DESCRIPTION("Xilinx SPI platform driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/spi/xilinx_spi.h b/include/linux/spi/xilinx_spi.h
new file mode 100644
index 0000000..06df0ab
--- /dev/null
+++ b/include/linux/spi/xilinx_spi.h
@@ -0,0 +1,16 @@
+#ifndef __LINUX_SPI_XILINX_SPI_H
+#define __LINUX_SPI_XILINX_SPI_H
+
+/**
+ * struct xspi_platform_data - Platform data of the Xilinx SPI driver
+ * @num_chipselect:	Number of chip select by the IP
+ * @devices:		Devices to add when the driver is probed.
+ * @num_devices:	Number of devices in the devices array.
+ */
+struct xspi_platform_data {
+	u16 num_chipselect;
+	struct spi_board_info *devices;
+	u8 num_devices;
+};
+
+#endif /* __LINUX_SPI_XILINX_SPI_H */
