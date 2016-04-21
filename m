Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qrRl15LDbzDqh4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 04:15:57 +1000 (AEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Christian Lamparter <chunkeey@googlemail.com>,
 =?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>,
 Julian Margetson <runaway@candw.ms>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 21/23] ata: sata_dwc_460ex: use devm_ioremap
Date: Thu, 21 Apr 2016 21:15:42 +0300
Message-Id: <1461262544-115408-22-git-send-email-andriy.shevchenko@linux.intel.com>
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

This simplifies error handling and cleanup by using devm to manage
IO mappings.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/ata/sata_dwc_460ex.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 0ef72e4..44dca8c 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -139,7 +139,6 @@ struct sata_dwc_device {
 	struct device		*dev;		/* generic device struct */
 	struct ata_probe_ent	*pe;		/* ptr to probe-ent */
 	struct ata_host		*host;
-	u8 __iomem		*reg_base;
 	struct sata_dwc_regs __iomem *sata_dwc_regs;	/* DW SATA specific */
 	u32			sactive_issued;
 	u32			sactive_queued;
@@ -242,7 +241,7 @@ static int sata_dwc_dma_init_old(struct platform_device *pdev,
 				 struct sata_dwc_device *hsdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	int err;
+	struct resource *res;
 
 	hsdev->dma = devm_kzalloc(&pdev->dev, sizeof(*hsdev->dma), GFP_KERNEL);
 	if (!hsdev->dma)
@@ -258,21 +257,16 @@ static int sata_dwc_dma_init_old(struct platform_device *pdev,
 	}
 
 	/* Get physical SATA DMA register base address */
-	hsdev->dma->regs = of_iomap(np, 1);
-	if (!hsdev->dma->regs) {
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	hsdev->dma->regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(hsdev->dma->regs)) {
 		dev_err(&pdev->dev,
 			"ioremap failed for AHBDMA register address\n");
-		return -ENODEV;
+		return PTR_ERR(hsdev->dma->regs);
 	}
 
 	/* Initialize AHB DMAC */
-	err = dw_dma_probe(hsdev->dma);
-	if (err) {
-		iounmap(hsdev->dma->regs);
-		return err;
-	}
-
-	return 0;
+	return dw_dma_probe(hsdev->dma);
 }
 
 static void sata_dwc_dma_exit_old(struct sata_dwc_device *hsdev)
@@ -281,7 +275,6 @@ static void sata_dwc_dma_exit_old(struct sata_dwc_device *hsdev)
 		return;
 
 	dw_dma_remove(hsdev->dma);
-	iounmap(hsdev->dma->regs);
 }
 
 #endif
@@ -1221,6 +1214,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	struct ata_port_info pi = sata_dwc_port_info[0];
 	const struct ata_port_info *ppi[] = { &pi, NULL };
 	struct device_node *np = ofdev->dev.of_node;
+	struct resource *res;
 
 	/* Allocate DWC SATA device */
 	host = ata_host_alloc_pinfo(&ofdev->dev, ppi, SATA_DWC_MAX_PORTS);
@@ -1231,13 +1225,13 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	host->private_data = hsdev;
 
 	/* Ioremap SATA registers */
-	base = of_iomap(np, 0);
-	if (!base) {
+	res = platform_get_resource(ofdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&ofdev->dev, res);
+	if (IS_ERR(base)) {
 		dev_err(&ofdev->dev,
 			"ioremap failed for SATA register address\n");
-		return -ENODEV;
+		return PTR_ERR(base);
 	}
-	hsdev->reg_base = base;
 	dev_dbg(&ofdev->dev, "ioremap done for SATA register address\n");
 
 	/* Synopsys DWC SATA specific Registers */
@@ -1302,7 +1296,6 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 
 error_out:
 	phy_exit(hsdev->phy);
-	iounmap(base);
 	return err;
 }
 
@@ -1321,7 +1314,6 @@ static int sata_dwc_remove(struct platform_device *ofdev)
 	sata_dwc_dma_exit_old(hsdev);
 #endif
 
-	iounmap(hsdev->reg_base);
 	dev_dbg(&ofdev->dev, "done\n");
 	return 0;
 }
-- 
2.8.0.rc3
