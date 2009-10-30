Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 4634DB7BF2
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Oct 2009 06:44:43 +1100 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: spi-devel-general@lists.sourceforge.net
Date: Fri, 30 Oct 2009 20:44:12 +0100
Message-Id: <1256931852-13255-1-git-send-email-w.sang@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: [PATCH] mpc52xx-psc-spi: refactor probe and remove to make use of
	of_register_spi_devices()
Cc: =?utf-8?q?K=C3=A1ri=20Dav=C3=AD=C3=B0sson?= <kari.davidsson@marel.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This driver has a generic part for the probe/remove routines which probably
used to be called from a platform driver and an of_platform driver. Meanwhile,
the driver is of_platform only, so there is no need for the generic part
anymore. Unifying probe/remove finally enables us to call
of_register_spi_devices(), so spi-device nodes from the device tree will be
parsed. This was also mentioned by:
http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-June/073273.html

On the way, some patterns have been changed to current best practices (like
using '!ptr' and 'struct resource'). Also, an older, yet uncommented, patch
from me has been incorporated to improve the checks if the selected PSC is
valid:

http://patchwork.ozlabs.org/patch/36780/

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Kári Davíðsson <kari.davidsson@marel.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/spi/mpc52xx_psc_spi.c |  110 +++++++++++++++++++---------------------
 1 files changed, 52 insertions(+), 58 deletions(-)

diff --git a/drivers/spi/mpc52xx_psc_spi.c b/drivers/spi/mpc52xx_psc_spi.c
index 1b74d5c..3fa8c78 100644
--- a/drivers/spi/mpc52xx_psc_spi.c
+++ b/drivers/spi/mpc52xx_psc_spi.c
@@ -17,6 +17,7 @@
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/of_platform.h>
+#include <linux/of_spi.h>
 #include <linux/workqueue.h>
 #include <linux/completion.h>
 #include <linux/io.h>
@@ -27,6 +28,7 @@
 #include <asm/mpc52xx.h>
 #include <asm/mpc52xx_psc.h>
 
+#define DRIVER_NAME "mpc52xx-psc-spi"
 #define MCLK 20000000 /* PSC port MClk in hz */
 
 struct mpc52xx_psc_spi {
@@ -358,32 +360,54 @@ static irqreturn_t mpc52xx_psc_spi_isr(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
-/* bus_num is used only for the case dev->platform_data == NULL */
-static int __init mpc52xx_psc_spi_do_probe(struct device *dev, u32 regaddr,
-				u32 size, unsigned int irq, s16 bus_num)
+static int __init mpc52xx_psc_spi_of_probe(struct of_device *op,
+	const struct of_device_id *match)
 {
-	struct fsl_spi_platform_data *pdata = dev->platform_data;
+	struct fsl_spi_platform_data *pdata = op->dev.platform_data;
 	struct mpc52xx_psc_spi *mps;
 	struct spi_master *master;
+	struct resource mem;
+	s16 id = -1;
 	int ret;
 
-	master = spi_alloc_master(dev, sizeof *mps);
-	if (master == NULL)
+	/* get PSC id (only 1,2,3,6 can do SPI) */
+	if (!pdata) {
+		const u32 *psc_nump;
+
+		psc_nump = of_get_property(op->node, "cell-index", NULL);
+		if (!psc_nump || (*psc_nump > 2 && *psc_nump != 5)) {
+			dev_err(&op->dev, "PSC can't do SPI\n");
+			return -EINVAL;
+		}
+		id = *psc_nump + 1;
+	}
+
+	ret = of_address_to_resource(op->node, 0, &mem);
+	if (ret)
+		return ret;
+
+	master = spi_alloc_master(&op->dev, sizeof *mps);
+	if (!master)
 		return -ENOMEM;
 
-	dev_set_drvdata(dev, master);
+	if (!request_mem_region(mem.start, resource_size(&mem), DRIVER_NAME)) {
+		ret = -ENOMEM;
+		goto free_master;
+	}
+
+	dev_set_drvdata(&op->dev, master);
 	mps = spi_master_get_devdata(master);
 
 	/* the spi->mode bits understood by this driver: */
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
 
-	mps->irq = irq;
-	if (pdata == NULL) {
-		dev_warn(dev, "probe called without platform data, no "
+	mps->irq = irq_of_parse_and_map(op->node, 0);
+	if (!pdata) {
+		dev_info(&op->dev, "probe called without platform data, no "
 				"cs_control function will be called\n");
 		mps->cs_control = NULL;
 		mps->sysclk = 0;
-		master->bus_num = bus_num;
+		master->bus_num = id;
 		master->num_chipselect = 255;
 	} else {
 		mps->cs_control = pdata->cs_control;
@@ -395,19 +419,18 @@ static int __init mpc52xx_psc_spi_do_probe(struct device *dev, u32 regaddr,
 	master->transfer = mpc52xx_psc_spi_transfer;
 	master->cleanup = mpc52xx_psc_spi_cleanup;
 
-	mps->psc = ioremap(regaddr, size);
+	mps->psc = ioremap(mem.start, resource_size(&mem));
 	if (!mps->psc) {
-		dev_err(dev, "could not ioremap I/O port range\n");
+		dev_err(&op->dev, "could not ioremap I/O port range\n");
 		ret = -EFAULT;
-		goto free_master;
+		goto free_unmap;
 	}
 	/* On the 5200, fifo regs are immediately ajacent to the psc regs */
 	mps->fifo = ((void __iomem *)mps->psc) + sizeof(struct mpc52xx_psc);
 
-	ret = request_irq(mps->irq, mpc52xx_psc_spi_isr, 0, "mpc52xx-psc-spi",
-				mps);
+	ret = request_irq(mps->irq, mpc52xx_psc_spi_isr, 0, DRIVER_NAME, mps);
 	if (ret)
-		goto free_master;
+		goto free_unmap;
 
 	ret = mpc52xx_psc_spi_port_config(master->bus_num, mps);
 	if (ret < 0)
@@ -429,24 +452,29 @@ static int __init mpc52xx_psc_spi_do_probe(struct device *dev, u32 regaddr,
 	if (ret < 0)
 		goto unreg_master;
 
+	of_register_spi_devices(master, op->node);
+
 	return ret;
 
 unreg_master:
 	destroy_workqueue(mps->workqueue);
 free_irq:
 	free_irq(mps->irq, mps);
-free_master:
+free_unmap:
 	if (mps->psc)
 		iounmap(mps->psc);
+	release_mem_region(mem.start, resource_size(&mem));
+free_master:
 	spi_master_put(master);
 
 	return ret;
 }
 
-static int __exit mpc52xx_psc_spi_do_remove(struct device *dev)
+static int __exit mpc52xx_psc_spi_of_remove(struct of_device *op)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
+	struct spi_master *master = dev_get_drvdata(&op->dev);
 	struct mpc52xx_psc_spi *mps = spi_master_get_devdata(master);
+	struct resource mem;
 
 	flush_workqueue(mps->workqueue);
 	destroy_workqueue(mps->workqueue);
@@ -454,46 +482,12 @@ static int __exit mpc52xx_psc_spi_do_remove(struct device *dev)
 	free_irq(mps->irq, mps);
 	if (mps->psc)
 		iounmap(mps->psc);
+	if (of_address_to_resource(op->node, 0, &mem) == 0)
+		release_mem_region(mem.start, resource_size(&mem));
 
 	return 0;
 }
 
-static int __init mpc52xx_psc_spi_of_probe(struct of_device *op,
-	const struct of_device_id *match)
-{
-	const u32 *regaddr_p;
-	u64 regaddr64, size64;
-	s16 id = -1;
-
-	regaddr_p = of_get_address(op->node, 0, &size64, NULL);
-	if (!regaddr_p) {
-		printk(KERN_ERR "Invalid PSC address\n");
-		return -EINVAL;
-	}
-	regaddr64 = of_translate_address(op->node, regaddr_p);
-
-	/* get PSC id (1..6, used by port_config) */
-	if (op->dev.platform_data == NULL) {
-		const u32 *psc_nump;
-
-		psc_nump = of_get_property(op->node, "cell-index", NULL);
-		if (!psc_nump || *psc_nump > 5) {
-			printk(KERN_ERR "mpc52xx_psc_spi: Device node %s has invalid "
-					"cell-index property\n", op->node->full_name);
-			return -EINVAL;
-		}
-		id = *psc_nump + 1;
-	}
-
-	return mpc52xx_psc_spi_do_probe(&op->dev, (u32)regaddr64, (u32)size64,
-					irq_of_parse_and_map(op->node, 0), id);
-}
-
-static int __exit mpc52xx_psc_spi_of_remove(struct of_device *op)
-{
-	return mpc52xx_psc_spi_do_remove(&op->dev);
-}
-
 static struct of_device_id mpc52xx_psc_spi_of_match[] = {
 	{ .compatible = "fsl,mpc5200-psc-spi", },
 	{ .compatible = "mpc5200-psc-spi", }, /* old */
@@ -504,12 +498,12 @@ MODULE_DEVICE_TABLE(of, mpc52xx_psc_spi_of_match);
 
 static struct of_platform_driver mpc52xx_psc_spi_of_driver = {
 	.owner = THIS_MODULE,
-	.name = "mpc52xx-psc-spi",
+	.name = DRIVER_NAME,
 	.match_table = mpc52xx_psc_spi_of_match,
 	.probe = mpc52xx_psc_spi_of_probe,
 	.remove = __exit_p(mpc52xx_psc_spi_of_remove),
 	.driver = {
-		.name = "mpc52xx-psc-spi",
+		.name = DRIVER_NAME,
 		.owner = THIS_MODULE,
 	},
 };
-- 
1.6.3.3
