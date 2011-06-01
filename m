Return-Path: <dbaryshkov@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AEF5FB6F80
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Jun 2011 22:28:21 +1000 (EST)
Received: by wyg36 with SMTP id 36so4558336wyg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 01 Jun 2011 05:28:17 -0700 (PDT)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: bluesmoke-devel@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/2] mpc85xx_edac: adapt to ppc/85xx changes for
	mpc85xx_pci_err
Date: Wed,  1 Jun 2011 16:28:12 +0400
Message-Id: <1306931292-2313-2-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1306931292-2313-1-git-send-email-dbaryshkov@gmail.com>
References: <1306931292-2313-1-git-send-email-dbaryshkov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently mpc85xx_edac fails to bind to PCI host device node. Adapt it
to bind to special platform device mpc85xx_pci_err.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/edac/mpc85xx_edac.c |   33 ++++++++++++---------------------
 1 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index c42e483..e91e8fb 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -204,7 +204,7 @@ static int __devinit mpc85xx_pci_err_probe(struct platform_device *op)
 {
 	struct edac_pci_ctl_info *pci;
 	struct mpc85xx_pci_pdata *pdata;
-	struct resource r;
+	struct resource *r;
 	int res = 0;
 
 	if (!devres_open_group(&op->dev, mpc85xx_pci_err_probe, GFP_KERNEL))
@@ -228,17 +228,15 @@ static int __devinit mpc85xx_pci_err_probe(struct platform_device *op)
 
 	pdata->edac_idx = edac_pci_idx++;
 
-	res = of_address_to_resource(op->dev.of_node, 0, &r);
-	if (res) {
+	r = platform_get_resource(op, IORESOURCE_MEM, 0);
+	if (!r) {
 		printk(KERN_ERR "%s: Unable to get resource for "
 		       "PCI err regs\n", __func__);
+		res = -ENODEV;
 		goto err;
 	}
 
-	/* we only need the error registers */
-	r.start += 0xe00;
-
-	if (!devm_request_mem_region(&op->dev, r.start, resource_size(&r),
+	if (!devm_request_mem_region(&op->dev, r->start, resource_size(r),
 					pdata->name)) {
 		printk(KERN_ERR "%s: Error while requesting mem region\n",
 		       __func__);
@@ -246,7 +244,7 @@ static int __devinit mpc85xx_pci_err_probe(struct platform_device *op)
 		goto err;
 	}
 
-	pdata->pci_vbase = devm_ioremap(&op->dev, r.start, resource_size(&r));
+	pdata->pci_vbase = devm_ioremap(&op->dev, r->start, resource_size(r));
 	if (!pdata->pci_vbase) {
 		printk(KERN_ERR "%s: Unable to setup PCI err regs\n", __func__);
 		res = -ENOMEM;
@@ -273,7 +271,11 @@ static int __devinit mpc85xx_pci_err_probe(struct platform_device *op)
 	}
 
 	if (edac_op_state == EDAC_OPSTATE_INT) {
-		pdata->irq = irq_of_parse_and_map(op->dev.of_node, 0);
+		res =  platform_get_irq(op, 0);
+		if (res >= 0)
+			pdata->irq = res;
+		else
+			goto err2;
 		res = devm_request_irq(&op->dev, pdata->irq,
 				       mpc85xx_pci_isr, IRQF_DISABLED,
 				       "[EDAC] PCI err", pci);
@@ -281,7 +283,6 @@ static int __devinit mpc85xx_pci_err_probe(struct platform_device *op)
 			printk(KERN_ERR
 			       "%s: Unable to requiest irq %d for "
 			       "MPC85xx PCI err\n", __func__, pdata->irq);
-			irq_dispose_mapping(pdata->irq);
 			res = -ENODEV;
 			goto err2;
 		}
@@ -326,16 +327,7 @@ static int mpc85xx_pci_err_remove(struct platform_device *op)
 	return 0;
 }
 
-static struct of_device_id mpc85xx_pci_err_of_match[] = {
-	{
-	 .compatible = "fsl,mpc8540-pcix",
-	 },
-	{
-	 .compatible = "fsl,mpc8540-pci",
-	},
-	{},
-};
-MODULE_DEVICE_TABLE(of, mpc85xx_pci_err_of_match);
+MODULE_ALIAS("platform:mpc85xx_pci_err");
 
 static struct platform_driver mpc85xx_pci_err_driver = {
 	.probe = mpc85xx_pci_err_probe,
@@ -343,7 +335,6 @@ static struct platform_driver mpc85xx_pci_err_driver = {
 	.driver = {
 		.name = "mpc85xx_pci_err",
 		.owner = THIS_MODULE,
-		.of_match_table = mpc85xx_pci_err_of_match,
 	},
 };
 
-- 
1.7.4.4
