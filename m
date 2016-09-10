Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sWTy46xntzDsPv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Sep 2016 19:57:16 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: dougthompson@xmission.com, bp@alien8.de, mchehab@kernel.org,
 linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org,
	arnd@arndb.de
Subject: [PATCH] drivers/edac: NO_IRQ removal from powerpc-only drivers
Date: Sat, 10 Sep 2016 19:57:08 +1000
Message-Id: <1473501428-8217-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We'd like to eventually remove NO_IRQ on powerpc, so remove usages of it
from powerpc-only drivers.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/edac/mpc85xx_edac.c | 6 +++---
 drivers/edac/mv64x60_edac.c | 8 ++++----
 drivers/edac/ppc4xx_edac.c  | 6 +++---
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index ca63d0da8889..e12b8e166a53 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -267,7 +267,7 @@ static int mpc85xx_pci_err_probe(struct platform_device *op)
 
 	pdata = pci->pvt_info;
 	pdata->name = "mpc85xx_pci_err";
-	pdata->irq = NO_IRQ;
+	pdata->irq = 0;
 
 	plat_data = op->dev.platform_data;
 	if (!plat_data) {
@@ -588,7 +588,7 @@ static int mpc85xx_l2_err_probe(struct platform_device *op)
 
 	pdata = edac_dev->pvt_info;
 	pdata->name = "mpc85xx_l2_err";
-	pdata->irq = NO_IRQ;
+	pdata->irq = 0;
 	edac_dev->dev = &op->dev;
 	dev_set_drvdata(edac_dev->dev, edac_dev);
 	edac_dev->ctl_name = pdata->name;
@@ -1058,7 +1058,7 @@ static int mpc85xx_mc_err_probe(struct platform_device *op)
 
 	pdata = mci->pvt_info;
 	pdata->name = "mpc85xx_mc_err";
-	pdata->irq = NO_IRQ;
+	pdata->irq = 0;
 	mci->pdev = &op->dev;
 	pdata->edac_idx = edac_mc_idx++;
 	dev_set_drvdata(mci->pdev, mci);
diff --git a/drivers/edac/mv64x60_edac.c b/drivers/edac/mv64x60_edac.c
index 6c54127e6eae..69c559189490 100644
--- a/drivers/edac/mv64x60_edac.c
+++ b/drivers/edac/mv64x60_edac.c
@@ -118,7 +118,7 @@ static int mv64x60_pci_err_probe(struct platform_device *pdev)
 
 	pdata->pci_hose = pdev->id;
 	pdata->name = "mpc85xx_pci_err";
-	pdata->irq = NO_IRQ;
+	pdata->irq = 0;
 	platform_set_drvdata(pdev, pci);
 	pci->dev = &pdev->dev;
 	pci->dev_name = dev_name(&pdev->dev);
@@ -291,7 +291,7 @@ static int mv64x60_sram_err_probe(struct platform_device *pdev)
 
 	pdata = edac_dev->pvt_info;
 	pdata->name = "mv64x60_sram_err";
-	pdata->irq = NO_IRQ;
+	pdata->irq = 0;
 	edac_dev->dev = &pdev->dev;
 	platform_set_drvdata(pdev, edac_dev);
 	edac_dev->dev_name = dev_name(&pdev->dev);
@@ -459,7 +459,7 @@ static int mv64x60_cpu_err_probe(struct platform_device *pdev)
 
 	pdata = edac_dev->pvt_info;
 	pdata->name = "mv64x60_cpu_err";
-	pdata->irq = NO_IRQ;
+	pdata->irq = 0;
 	edac_dev->dev = &pdev->dev;
 	platform_set_drvdata(pdev, edac_dev);
 	edac_dev->dev_name = dev_name(&pdev->dev);
@@ -727,7 +727,7 @@ static int mv64x60_mc_err_probe(struct platform_device *pdev)
 	mci->pdev = &pdev->dev;
 	platform_set_drvdata(pdev, mci);
 	pdata->name = "mv64x60_mc_err";
-	pdata->irq = NO_IRQ;
+	pdata->irq = 0;
 	mci->dev_name = dev_name(&pdev->dev);
 	pdata->edac_idx = edac_mc_idx++;
 
diff --git a/drivers/edac/ppc4xx_edac.c b/drivers/edac/ppc4xx_edac.c
index d3a64ba61fa3..ee84343f660f 100644
--- a/drivers/edac/ppc4xx_edac.c
+++ b/drivers/edac/ppc4xx_edac.c
@@ -1029,8 +1029,8 @@ static int ppc4xx_edac_mc_init(struct mem_ctl_info *mci,
 	pdata			= mci->pvt_info;
 
 	pdata->dcr_host		= *dcr_host;
-	pdata->irqs.sec		= NO_IRQ;
-	pdata->irqs.ded		= NO_IRQ;
+	pdata->irqs.sec		= 0;
+	pdata->irqs.ded		= 0;
 
 	/* Initialize controller capabilities and configuration */
 
@@ -1111,7 +1111,7 @@ static int ppc4xx_edac_register_irq(struct platform_device *op,
 	ded_irq = irq_of_parse_and_map(np, INTMAP_ECCDED_INDEX);
 	sec_irq = irq_of_parse_and_map(np, INTMAP_ECCSEC_INDEX);
 
-	if (ded_irq == NO_IRQ || sec_irq == NO_IRQ) {
+	if (!ded_irq || !sec_irq) {
 		ppc4xx_edac_mc_printk(KERN_ERR, mci,
 				      "Unable to map interrupts.\n");
 		status = -ENODEV;
-- 
2.7.4
