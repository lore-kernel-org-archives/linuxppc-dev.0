Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sXjx62f2mzDrcD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 20:00:42 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: bp@alien8.de
Cc: dougthompson@xmission.com, mchehab@kernel.org, linux-edac@vger.kernel.org,
 linuxppc-dev@ozlabs.org, arnd@arndb.de
Subject: [PATCH v2] drivers/edac: NO_IRQ removal from powerpc-only drivers
Date: Mon, 12 Sep 2016 20:00:36 +1000
Message-Id: <1473674436-19467-1-git-send-email-mpe@ellerman.id.au>
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

The pdata structs are kzalloc'ed, so we don't need to initialise those
to 0, we can just drop the assignments entirely.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
v2: Don't initialise pdata fields to 0, the entire struct is kzalloc'ed.

mpc85xx_edac.c is not shared with arm64. It is built together with
fsl_ddr_edac.c on powerpc to form mpc85xx_edac. On arm64 fsl_ddr_edac.c is
built with layerscape_edac.c to form layerscape_edac. So changing
mpc85xx_edac.c has no dependency on arm64 changes.


 drivers/edac/mpc85xx_edac.c | 2 --
 drivers/edac/mv64x60_edac.c | 4 ----
 drivers/edac/ppc4xx_edac.c  | 4 +---
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index 0a4020923684..ff0567526ee3 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -170,7 +170,6 @@ static int mpc85xx_pci_err_probe(struct platform_device *op)
 
 	pdata = pci->pvt_info;
 	pdata->name = "mpc85xx_pci_err";
-	pdata->irq = NO_IRQ;
 
 	plat_data = op->dev.platform_data;
 	if (!plat_data) {
@@ -491,7 +490,6 @@ static int mpc85xx_l2_err_probe(struct platform_device *op)
 
 	pdata = edac_dev->pvt_info;
 	pdata->name = "mpc85xx_l2_err";
-	pdata->irq = NO_IRQ;
 	edac_dev->dev = &op->dev;
 	dev_set_drvdata(edac_dev->dev, edac_dev);
 	edac_dev->ctl_name = pdata->name;
diff --git a/drivers/edac/mv64x60_edac.c b/drivers/edac/mv64x60_edac.c
index 6c54127e6eae..cb9b8577acbc 100644
--- a/drivers/edac/mv64x60_edac.c
+++ b/drivers/edac/mv64x60_edac.c
@@ -118,7 +118,6 @@ static int mv64x60_pci_err_probe(struct platform_device *pdev)
 
 	pdata->pci_hose = pdev->id;
 	pdata->name = "mpc85xx_pci_err";
-	pdata->irq = NO_IRQ;
 	platform_set_drvdata(pdev, pci);
 	pci->dev = &pdev->dev;
 	pci->dev_name = dev_name(&pdev->dev);
@@ -291,7 +290,6 @@ static int mv64x60_sram_err_probe(struct platform_device *pdev)
 
 	pdata = edac_dev->pvt_info;
 	pdata->name = "mv64x60_sram_err";
-	pdata->irq = NO_IRQ;
 	edac_dev->dev = &pdev->dev;
 	platform_set_drvdata(pdev, edac_dev);
 	edac_dev->dev_name = dev_name(&pdev->dev);
@@ -459,7 +457,6 @@ static int mv64x60_cpu_err_probe(struct platform_device *pdev)
 
 	pdata = edac_dev->pvt_info;
 	pdata->name = "mv64x60_cpu_err";
-	pdata->irq = NO_IRQ;
 	edac_dev->dev = &pdev->dev;
 	platform_set_drvdata(pdev, edac_dev);
 	edac_dev->dev_name = dev_name(&pdev->dev);
@@ -727,7 +724,6 @@ static int mv64x60_mc_err_probe(struct platform_device *pdev)
 	mci->pdev = &pdev->dev;
 	platform_set_drvdata(pdev, mci);
 	pdata->name = "mv64x60_mc_err";
-	pdata->irq = NO_IRQ;
 	mci->dev_name = dev_name(&pdev->dev);
 	pdata->edac_idx = edac_mc_idx++;
 
diff --git a/drivers/edac/ppc4xx_edac.c b/drivers/edac/ppc4xx_edac.c
index d3a64ba61fa3..691ce25e9010 100644
--- a/drivers/edac/ppc4xx_edac.c
+++ b/drivers/edac/ppc4xx_edac.c
@@ -1029,8 +1029,6 @@ static int ppc4xx_edac_mc_init(struct mem_ctl_info *mci,
 	pdata			= mci->pvt_info;
 
 	pdata->dcr_host		= *dcr_host;
-	pdata->irqs.sec		= NO_IRQ;
-	pdata->irqs.ded		= NO_IRQ;
 
 	/* Initialize controller capabilities and configuration */
 
@@ -1111,7 +1109,7 @@ static int ppc4xx_edac_register_irq(struct platform_device *op,
 	ded_irq = irq_of_parse_and_map(np, INTMAP_ECCDED_INDEX);
 	sec_irq = irq_of_parse_and_map(np, INTMAP_ECCSEC_INDEX);
 
-	if (ded_irq == NO_IRQ || sec_irq == NO_IRQ) {
+	if (!ded_irq || !sec_irq) {
 		ppc4xx_edac_mc_printk(KERN_ERR, mci,
 				      "Unable to map interrupts.\n");
 		status = -ENODEV;
-- 
2.7.4
