Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qrRkx2vdMzDqgZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 04:15:53 +1000 (AEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Christian Lamparter <chunkeey@googlemail.com>,
 =?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>,
 Julian Margetson <runaway@candw.ms>
Subject: [PATCH v1 09/23] ata: sata_dwc_460ex: use "dmas" DT property to find
 dma channel
Date: Thu, 21 Apr 2016 21:15:30 +0300
Message-Id: <1461262544-115408-10-git-send-email-andriy.shevchenko@linux.intel.com>
In-Reply-To: <1461262544-115408-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1461262544-115408-1-git-send-email-andriy.shevchenko@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mans Rullgard <mans@mansr.com>

Currently this driver only works with a DesignWare DMA engine which it
registers manually using the second "reg" address range and interrupt
number from the DT node.

This patch makes the driver instead use the "dmas" property if present,
otherwise optionally falling back on the old way so existing device
trees can continue to work.

With this change, there is no longer any reason to depend on the 460EX
machine type so drop that from Kconfig.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/ata/Kconfig          |  11 ++-
 drivers/ata/sata_dwc_460ex.c | 198 ++++++++++++++++++++++++++++---------------
 2 files changed, 138 insertions(+), 71 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 7c6e43a..ede126d 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -313,14 +313,21 @@ config ATA_PIIX
 
 config SATA_DWC
 	tristate "DesignWare Cores SATA support"
-	depends on 460EX
-	select DW_DMAC_CORE
 	help
 	  This option enables support for the on-chip SATA controller of the
 	  AppliedMicro processor 460EX.
 
 	  If unsure, say N.
 
+config SATA_DWC_OLD_DMA
+	bool "Support old device trees"
+	depends on SATA_DWC
+	select DW_DMAC_CORE
+	default y if 460EX
+	help
+	  This option enables support for old device trees without the
+	  "dmas" property.
+
 config SATA_DWC_DEBUG
 	bool "Debugging driver version"
 	depends on SATA_DWC
diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 845c35d..daaa8a6 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -30,6 +30,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/device.h>
+#include <linux/dmaengine.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
@@ -42,10 +43,6 @@
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
 
-/* Supported DMA engine drivers */
-#include <linux/platform_data/dma-dw.h>
-#include <linux/dma/dw.h>
-
 /* These two are defined in "libata.h" */
 #undef	DRV_NAME
 #undef	DRV_VERSION
@@ -148,7 +145,9 @@ struct sata_dwc_device {
 	struct ata_host		*host;
 	u8 __iomem		*reg_base;
 	struct sata_dwc_regs	*sata_dwc_regs;	/* DW Synopsys SATA specific */
+#ifdef CONFIG_SATA_DWC_OLD_DMA
 	struct dw_dma_chip	*dma;
+#endif
 };
 
 #define SATA_DWC_QCMD_MAX	32
@@ -159,7 +158,6 @@ struct sata_dwc_device_port {
 	int			dma_pending[SATA_DWC_QCMD_MAX];
 
 	/* DMA info */
-	struct dw_dma_slave		*dws;
 	struct dma_chan			*chan;
 	struct dma_async_tx_descriptor	*desc[SATA_DWC_QCMD_MAX];
 	u32				dma_interrupt_count;
@@ -198,13 +196,6 @@ struct sata_dwc_host_priv {
 
 static struct sata_dwc_host_priv host_pvt;
 
-static struct dw_dma_slave sata_dwc_dma_dws = {
-	.src_id = 0,
-	.dst_id = 0,
-	.m_master = 1,
-	.p_master = 0,
-};
-
 /*
  * Prototypes
  */
@@ -215,6 +206,99 @@ static void sata_dwc_dma_xfer_complete(struct ata_port *ap, u32 check_status);
 static void sata_dwc_port_stop(struct ata_port *ap);
 static void sata_dwc_clear_dmacr(struct sata_dwc_device_port *hsdevp, u8 tag);
 
+#ifdef CONFIG_SATA_DWC_OLD_DMA
+
+#include <linux/platform_data/dma-dw.h>
+#include <linux/dma/dw.h>
+
+static struct dw_dma_slave sata_dwc_dma_dws = {
+	.src_id = 0,
+	.dst_id = 0,
+	.m_master = 1,
+	.p_master = 0,
+};
+
+static bool sata_dwc_dma_filter(struct dma_chan *chan, void *param)
+{
+	struct dw_dma_slave *dws = &sata_dwc_dma_dws;
+
+	if (dws->dma_dev != chan->device->dev)
+		return false;
+
+	chan->private = dws;
+	return true;
+}
+
+static int sata_dwc_dma_get_channel_old(struct sata_dwc_device_port *hsdevp)
+{
+	struct sata_dwc_device *hsdev = hsdevp->hsdev;
+	struct dw_dma_slave *dws = &sata_dwc_dma_dws;
+	dma_cap_mask_t mask;
+
+	dws->dma_dev = hsdev->dev;
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	/* Acquire DMA channel */
+	hsdevp->chan = dma_request_channel(mask, sata_dwc_dma_filter, hsdevp);
+	if (!hsdevp->chan) {
+		dev_err(hsdev->dev, "%s: dma channel unavailable\n",
+			 __func__);
+		return -EAGAIN;
+	}
+
+	return 0;
+}
+
+static int sata_dwc_dma_init_old(struct platform_device *pdev,
+				 struct sata_dwc_device *hsdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	int err;
+
+	hsdev->dma = devm_kzalloc(&pdev->dev, sizeof(*hsdev->dma), GFP_KERNEL);
+	if (!hsdev->dma)
+		return -ENOMEM;
+
+	hsdev->dma->dev = &pdev->dev;
+
+	/* Get SATA DMA interrupt number */
+	hsdev->dma->irq = irq_of_parse_and_map(np, 1);
+	if (hsdev->dma->irq == NO_IRQ) {
+		dev_err(&pdev->dev, "no SATA DMA irq\n");
+		return -ENODEV;
+	}
+
+	/* Get physical SATA DMA register base address */
+	hsdev->dma->regs = of_iomap(np, 1);
+	if (!hsdev->dma->regs) {
+		dev_err(&pdev->dev,
+			"ioremap failed for AHBDMA register address\n");
+		return -ENODEV;
+	}
+
+	/* Initialize AHB DMAC */
+	err = dw_dma_probe(hsdev->dma);
+	if (err) {
+		iounmap(hsdev->dma->regs);
+		return err;
+	}
+
+	return 0;
+}
+
+static void sata_dwc_dma_exit_old(struct sata_dwc_device *hsdev)
+{
+	if (!hsdev->dma)
+		return;
+
+	dw_dma_remove(hsdev->dma);
+	iounmap(hsdev->dma->regs);
+}
+
+#endif
+
 static const char *get_prot_descript(u8 protocol)
 {
 	switch ((enum ata_tf_protocols)protocol) {
@@ -783,18 +867,6 @@ static void sata_dwc_enable_interrupts(struct sata_dwc_device *hsdev)
 		in_le32(&hsdev->sata_dwc_regs->errmr));
 }
 
-static bool sata_dwc_dma_filter(struct dma_chan *chan, void *param)
-{
-	struct sata_dwc_device_port *hsdevp = param;
-	struct dw_dma_slave *dws = hsdevp->dws;
-
-	if (dws->dma_dev != chan->device->dev)
-		return false;
-
-	chan->private = dws;
-	return true;
-}
-
 static void sata_dwc_setup_port(struct ata_ioports *port, unsigned long base)
 {
 	port->cmd_addr = (void __iomem *)base + 0x00;
@@ -817,6 +889,26 @@ static void sata_dwc_setup_port(struct ata_ioports *port, unsigned long base)
 	port->ctl_addr = (void __iomem *)base + 0x20;
 }
 
+static int sata_dwc_dma_get_channel(struct sata_dwc_device_port *hsdevp)
+{
+	struct sata_dwc_device *hsdev = hsdevp->hsdev;
+	struct device *dev = hsdev->dev;
+
+#ifdef CONFIG_SATA_DWC_OLD_DMA
+	if (!of_find_property(dev->of_node, "dmas", NULL))
+		return sata_dwc_dma_get_channel_old(hsdevp);
+#endif
+
+	hsdevp->chan = dma_request_chan(dev, "sata-dma");
+	if (IS_ERR(hsdevp->chan)) {
+		dev_err(dev, "failed to allocate dma channel: %ld\n",
+			PTR_ERR(hsdevp->chan));
+		return PTR_ERR(hsdevp->chan);
+	}
+
+	return 0;
+}
+
 /*
  * Function : sata_dwc_port_start
  * arguments : struct ata_ioports *port
@@ -829,7 +921,6 @@ static int sata_dwc_port_start(struct ata_port *ap)
 	struct sata_dwc_device *hsdev;
 	struct sata_dwc_device_port *hsdevp = NULL;
 	struct device *pdev;
-	dma_cap_mask_t mask;
 	int i;
 
 	hsdev = HSDEV_FROM_AP(ap);
@@ -853,20 +944,9 @@ static int sata_dwc_port_start(struct ata_port *ap)
 	}
 	hsdevp->hsdev = hsdev;
 
-	hsdevp->dws = &sata_dwc_dma_dws;
-	hsdevp->dws->dma_dev = hsdev->dev;
-
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-
-	/* Acquire DMA channel */
-	hsdevp->chan = dma_request_channel(mask, sata_dwc_dma_filter, hsdevp);
-	if (!hsdevp->chan) {
-		dev_err(hsdev->dev, "%s: dma channel unavailable\n",
-			 __func__);
-		err = -EAGAIN;
+	err = sata_dwc_dma_get_channel(hsdevp);
+	if (err)
 		goto CLEANUP_ALLOC;
-	}
 
 	for (i = 0; i < SATA_DWC_QCMD_MAX; i++)
 		hsdevp->cmd_issued[i] = SATA_DWC_CMD_ISSUED_NOT;
@@ -1221,33 +1301,9 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	dev_notice(&ofdev->dev, "id %d, controller version %c.%c%c\n",
 		   idr, ver[0], ver[1], ver[2]);
 
-	/* Get SATA DMA interrupt number */
-	hsdev->dma->irq = irq_of_parse_and_map(np, 1);
-	if (hsdev->dma->irq == NO_IRQ) {
-		dev_err(&ofdev->dev, "no SATA DMA irq\n");
-		err = -ENODEV;
-		goto error_iomap;
-	}
-
-	/* Get physical SATA DMA register base address */
-	hsdev->dma->regs = of_iomap(np, 1);
-	if (!hsdev->dma->regs) {
-		dev_err(&ofdev->dev,
-			"ioremap failed for AHBDMA register address\n");
-		err = -ENODEV;
-		goto error_iomap;
-	}
-
 	/* Save dev for later use in dev_xxx() routines */
 	hsdev->dev = &ofdev->dev;
 
-	hsdev->dma->dev = &ofdev->dev;
-
-	/* Initialize AHB DMAC */
-	err = dw_dma_probe(hsdev->dma);
-	if (err)
-		goto error_dma_iomap;
-
 	/* Enable SATA Interrupts */
 	sata_dwc_enable_interrupts(hsdev);
 
@@ -1259,6 +1315,14 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 		goto error_out;
 	}
 
+#ifdef CONFIG_SATA_DWC_OLD_DMA
+	if (!of_find_property(np, "dmas", NULL)) {
+		err = sata_dwc_dma_init_old(ofdev, hsdev);
+		if (err)
+			goto error_out;
+	}
+#endif
+
 	/*
 	 * Now, register with libATA core, this will also initiate the
 	 * device discovery process, invoking our port_start() handler &
@@ -1272,11 +1336,6 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	return 0;
 
 error_out:
-	/* Free SATA DMA resources */
-	dw_dma_remove(hsdev->dma);
-error_dma_iomap:
-	iounmap(hsdev->dma->regs);
-error_iomap:
 	iounmap(base);
 	return err;
 }
@@ -1289,10 +1348,11 @@ static int sata_dwc_remove(struct platform_device *ofdev)
 
 	ata_host_detach(host);
 
+#ifdef CONFIG_SATA_DWC_OLD_DMA
 	/* Free SATA DMA resources */
-	dw_dma_remove(hsdev->dma);
+	sata_dwc_dma_exit_old(hsdev);
+#endif
 
-	iounmap(hsdev->dma->regs);
 	iounmap(hsdev->reg_base);
 	dev_dbg(&ofdev->dev, "done\n");
 	return 0;
-- 
2.8.0.rc3
