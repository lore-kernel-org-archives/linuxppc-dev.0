Return-Path: <>
Received: from WA2EHSNDR006.bigfish.com (unknown [204.231.192.41])
	by ozlabs.org (Postfix) with ESMTP id D0FF5DDE04
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 04:15:05 +1100 (EST)
From: John Linn <john.linn@xilinx.com>
To: linuxppc-dev@ozlabs.org, jwboyer@linux.vnet.ibm.com,
	grant.likely@secretlab.ca
Subject: [PATCH] [powerpc] Xilinx: SPI: updated driver for device tree
Date: Wed, 19 Nov 2008 09:14:51 -0800
Message-ID: <20081119171456.E619BD10073@mail32-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: John Linn <john.linn@xilinx.com>
Reply-To: linnj@wolfgang-pc.public.xilinx.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The driver was updated to use the device tree rather than the platform data.

Signed-off-by: John Linn <john.linn@xilinx.com>
---
 drivers/spi/xilinx_spi.c |  137 +++++++++++++++++++++++++++-------------------
 1 files changed, 81 insertions(+), 56 deletions(-)

diff --git a/drivers/spi/xilinx_spi.c b/drivers/spi/xilinx_spi.c
index 68d6f49..fe7e5f3 100644
--- a/drivers/spi/xilinx_spi.c
+++ b/drivers/spi/xilinx_spi.c
@@ -15,12 +15,15 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
+
+#include <linux/of_platform.h>
+#include <linux/of_device.h>
+#include <linux/of_spi.h>
+
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
 #include <linux/io.h>
 
-#include <syslib/virtex_devices.h>
-
 #define XILINX_SPI_NAME "xilinx_spi"
 
 /* Register definitions as per "OPB Serial Peripheral Interface (SPI) (v1.00e)
@@ -144,23 +147,14 @@ static int xilinx_spi_setup_transfer(struct spi_device *spi,
 		struct spi_transfer *t)
 {
 	u8 bits_per_word;
-	u32 hz;
-	struct xilinx_spi *xspi = spi_master_get_devdata(spi->master);
 
 	bits_per_word = (t) ? t->bits_per_word : spi->bits_per_word;
-	hz = (t) ? t->speed_hz : spi->max_speed_hz;
 	if (bits_per_word != 8) {
 		dev_err(&spi->dev, "%s, unsupported bits_per_word=%d\n",
 			__func__, bits_per_word);
 		return -EINVAL;
 	}
 
-	if (hz && xspi->speed_hz > hz) {
-		dev_err(&spi->dev, "%s, unsupported clock rate %uHz\n",
-			__func__, hz);
-		return -EINVAL;
-	}
-
 	return 0;
 }
 
@@ -304,32 +298,38 @@ static irqreturn_t xilinx_spi_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __init xilinx_spi_probe(struct platform_device *dev)
+static int __init xilinx_spi_of_probe(struct of_device *ofdev,
+					const struct of_device_id *match)
 {
-	int ret = 0;
 	struct spi_master *master;
 	struct xilinx_spi *xspi;
-	struct xspi_platform_data *pdata;
-	struct resource *r;
+	struct resource r_irq_struct;
+	struct resource r_mem_struct;
+
+	struct resource *r_irq = &r_irq_struct;
+	struct resource *r_mem = &r_mem_struct;
+	int rc = 0;
+	const u32 *prop;
+	int len;
 
 	/* Get resources(memory, IRQ) associated with the device */
-	master = spi_alloc_master(&dev->dev, sizeof(struct xilinx_spi));
+	master = spi_alloc_master(&ofdev->dev, sizeof(struct xilinx_spi));
 
 	if (master == NULL) {
 		return -ENOMEM;
 	}
 
-	platform_set_drvdata(dev, master);
-	pdata = dev->dev.platform_data;
+	dev_set_drvdata(&ofdev->dev, master);
 
-	if (pdata == NULL) {
-		ret = -ENODEV;
+	rc = of_address_to_resource(ofdev->node, 0, r_mem);
+	if (rc) {
+		dev_warn(&ofdev->dev, "invalid address\n");
 		goto put_master;
 	}
 
-	r = platform_get_resource(dev, IORESOURCE_MEM, 0);
-	if (r == NULL) {
-		ret = -ENODEV;
+	rc = of_irq_to_resource(ofdev->node, 0, r_irq);
+	if (rc == NO_IRQ) {
+		dev_warn(&ofdev->dev, "no IRQ found\n");
 		goto put_master;
 	}
 
@@ -341,47 +341,57 @@ static int __init xilinx_spi_probe(struct platform_device *dev)
 	xspi->bitbang.master->setup = xilinx_spi_setup;
 	init_completion(&xspi->done);
 
-	if (!request_mem_region(r->start,
-			r->end - r->start + 1, XILINX_SPI_NAME)) {
-		ret = -ENXIO;
+	xspi->irq = r_irq->start;
+
+	if (!request_mem_region(r_mem->start,
+			r_mem->end - r_mem->start + 1, XILINX_SPI_NAME)) {
+		rc = -ENXIO;
+		dev_warn(&ofdev->dev, "memory request failure\n");
 		goto put_master;
 	}
 
-	xspi->regs = ioremap(r->start, r->end - r->start + 1);
+	xspi->regs = ioremap(r_mem->start, r_mem->end - r_mem->start + 1);
 	if (xspi->regs == NULL) {
-		ret = -ENOMEM;
+		rc = -ENOMEM;
+		dev_warn(&ofdev->dev, "ioremap failure\n");
 		goto put_master;
 	}
+	xspi->irq = r_irq->start;
 
-	ret = platform_get_irq(dev, 0);
-	if (ret < 0) {
-		ret = -ENXIO;
-		goto unmap_io;
-	}
-	xspi->irq = ret;
+	/* dynamic bus assignment */
+	master->bus_num = -1;
 
-	master->bus_num = pdata->bus_num;
-	master->num_chipselect = pdata->num_chipselect;
-	xspi->speed_hz = pdata->speed_hz;
+	/* number of slave select bits is required */
+	prop = of_get_property(ofdev->node, "xlnx,num-ss-bits", &len);
+	if (!prop || len < sizeof(*prop)) {
+		dev_warn(&ofdev->dev, "no 'xlnx,num-ss-bits' property\n");
+		goto put_master;
+	}
+	master->num_chipselect = *prop;
 
 	/* SPI controller initializations */
 	xspi_init_hw(xspi->regs);
 
 	/* Register for SPI Interrupt */
-	ret = request_irq(xspi->irq, xilinx_spi_irq, 0, XILINX_SPI_NAME, xspi);
-	if (ret != 0)
+	rc = request_irq(xspi->irq, xilinx_spi_irq, 0, XILINX_SPI_NAME, xspi);
+	if (rc != 0) {
+		dev_warn(&ofdev->dev, "irq request failure: %d\n", xspi->irq);
 		goto unmap_io;
+	}
 
-	ret = spi_bitbang_start(&xspi->bitbang);
-	if (ret != 0) {
-		dev_err(&dev->dev, "spi_bitbang_start FAILED\n");
+	rc = spi_bitbang_start(&xspi->bitbang);
+	if (rc != 0) {
+		dev_err(&ofdev->dev, "spi_bitbang_start FAILED\n");
 		goto free_irq;
 	}
 
-	dev_info(&dev->dev, "at 0x%08X mapped to 0x%08X, irq=%d\n",
-			r->start, (u32)xspi->regs, xspi->irq);
+	dev_info(&ofdev->dev, "at 0x%08X mapped to 0x%08X, irq=%d\n",
+			(unsigned int)r_mem->start, (u32)xspi->regs, xspi->irq);
 
-	return ret;
+	/* Add any subnodes on the SPI bus */
+	of_register_spi_devices(master, ofdev->node);
+
+	return rc;
 
 free_irq:
 	free_irq(xspi->irq, xspi);
@@ -389,21 +399,21 @@ unmap_io:
 	iounmap(xspi->regs);
 put_master:
 	spi_master_put(master);
-	return ret;
+	return rc;
 }
 
-static int __devexit xilinx_spi_remove(struct platform_device *dev)
+static int __devexit xilinx_spi_remove(struct of_device *ofdev)
 {
 	struct xilinx_spi *xspi;
 	struct spi_master *master;
 
-	master = platform_get_drvdata(dev);
+	master = platform_get_drvdata(ofdev);
 	xspi = spi_master_get_devdata(master);
 
 	spi_bitbang_stop(&xspi->bitbang);
 	free_irq(xspi->irq, xspi);
 	iounmap(xspi->regs);
-	platform_set_drvdata(dev, 0);
+	dev_set_drvdata(&ofdev->dev, 0);
 	spi_master_put(xspi->bitbang.master);
 
 	return 0;
@@ -412,27 +422,42 @@ static int __devexit xilinx_spi_remove(struct platform_device *dev)
 /* work with hotplug and coldplug */
 MODULE_ALIAS("platform:" XILINX_SPI_NAME);
 
-static struct platform_driver xilinx_spi_driver = {
-	.probe	= xilinx_spi_probe,
-	.remove	= __devexit_p(xilinx_spi_remove),
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
 	.driver = {
-		.name = XILINX_SPI_NAME,
+		.name = "xilinx-xps-spi",
 		.owner = THIS_MODULE,
 	},
 };
 
 static int __init xilinx_spi_init(void)
 {
-	return platform_driver_register(&xilinx_spi_driver);
+	return of_register_platform_driver(&xilinx_spi_of_driver);
 }
 module_init(xilinx_spi_init);
 
 static void __exit xilinx_spi_exit(void)
 {
-	platform_driver_unregister(&xilinx_spi_driver);
+	of_unregister_platform_driver(&xilinx_spi_of_driver);
 }
 module_exit(xilinx_spi_exit);
-
 MODULE_AUTHOR("MontaVista Software, Inc. <source@mvista.com>");
 MODULE_DESCRIPTION("Xilinx SPI driver");
 MODULE_LICENSE("GPL");
-- 
1.5.2.1



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
