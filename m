Return-Path: <B25806@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8EF582C009B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2013 19:38:02 +1100 (EST)
Received: from mail220-co9 (localhost [127.0.0.1])	by
 mail220-co9-R.bigfish.com (Postfix) with ESMTP id 251814C0095	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2013 08:37:58 +0000 (UTC)
Received: from CO9EHSMHS007.bigfish.com (unknown [10.236.132.248])	by
 mail220-co9.bigfish.com (Postfix) with ESMTP id 98890380046	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2013 08:37:55 +0000 (UTC)
From: Chunhe Lan <Chunhe.Lan@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2] edac/85xx: Add PCIe error interrupt edac support
Date: Thu, 14 Mar 2013 16:41:13 +0800
Message-ID: <1363250473-30652-1-git-send-email-Chunhe.Lan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: kumar.gala@freescale.com, Chunhe Lan <Chunhe.Lan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adding pcie error interrupt edac support for mpc85xx, p3041, p4080,
and p5020. The mpc85xx uses the legacy interrupt report mechanism -
the error interrupts are reported directly to mpic. While, the p3041/
p4080/p5020 attaches the most of error interrupts to interrupt zero.
And report error interrupts to mpic via interrupt 0.

This patch can handle both of them.

Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
---
 drivers/edac/mpc85xx_edac.c |   94 ++++++++++++++++++++++++++++++++++++------
 drivers/edac/mpc85xx_edac.h |    5 ++
 2 files changed, 85 insertions(+), 14 deletions(-)

diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index 42a840d..68aa9e7 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -1,5 +1,6 @@
 /*
  * Freescale MPC85xx Memory Controller kenel module
+ * Copyright (c) 2013 Freescale Semiconductor, Inc.
  *
  * Author: Dave Jiang <djiang@mvista.com>
  *
@@ -196,6 +197,42 @@ static void mpc85xx_pci_check(struct edac_pci_ctl_info *pci)
 		edac_pci_handle_npe(pci, pci->ctl_name);
 }
 
+static void mpc85xx_pcie_check(struct edac_pci_ctl_info *pci)
+{
+	struct mpc85xx_pci_pdata *pdata = pci->pvt_info;
+	u32 err_detect;
+
+	err_detect = in_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_DR);
+
+	pr_err("PCIE error(s) detected\n");
+	pr_err("PCIE ERR_DR register: 0x%08x\n", err_detect);
+	pr_err("PCIE ERR_CAP_STAT register: 0x%08x\n",
+			in_be32(pdata->pci_vbase + MPC85XX_PCI_GAS_TIMR));
+	pr_err("PCIE ERR_CAP_R0 register: 0x%08x\n",
+			in_be32(pdata->pci_vbase + MPC85XX_PCIE_ERR_CAP_R0));
+	pr_err("PCIE ERR_CAP_R1 register: 0x%08x\n",
+			in_be32(pdata->pci_vbase + MPC85XX_PCIE_ERR_CAP_R1));
+	pr_err("PCIE ERR_CAP_R2 register: 0x%08x\n",
+			in_be32(pdata->pci_vbase + MPC85XX_PCIE_ERR_CAP_R2));
+	pr_err("PCIE ERR_CAP_R3 register: 0x%08x\n",
+			in_be32(pdata->pci_vbase + MPC85XX_PCIE_ERR_CAP_R3));
+
+	/* clear error bits */
+	out_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_DR, err_detect);
+}
+
+static int mpc85xx_pcie_find_capability(struct device_node *np)
+{
+	struct pci_controller *hose;
+
+	if (!np)
+		return -EINVAL;
+
+	hose = pci_find_hose_for_OF_device(np);
+
+	return early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP);
+}
+
 static irqreturn_t mpc85xx_pci_isr(int irq, void *dev_id)
 {
 	struct edac_pci_ctl_info *pci = dev_id;
@@ -207,7 +244,10 @@ static irqreturn_t mpc85xx_pci_isr(int irq, void *dev_id)
 	if (!err_detect)
 		return IRQ_NONE;
 
-	mpc85xx_pci_check(pci);
+	if (pdata->is_pcie)
+		mpc85xx_pcie_check(pci);
+	else
+		mpc85xx_pci_check(pci);
 
 	return IRQ_HANDLED;
 }
@@ -239,14 +279,23 @@ int mpc85xx_pci_err_probe(struct platform_device *op)
 	pdata = pci->pvt_info;
 	pdata->name = "mpc85xx_pci_err";
 	pdata->irq = NO_IRQ;
+	if (mpc85xx_pcie_find_capability(op->dev.of_node) > 0)
+		pdata->is_pcie = 1;
+	else
+		pdata->is_pcie = 0;
+
 	dev_set_drvdata(&op->dev, pci);
 	pci->dev = &op->dev;
 	pci->mod_name = EDAC_MOD_STR;
 	pci->ctl_name = pdata->name;
 	pci->dev_name = dev_name(&op->dev);
 
-	if (edac_op_state == EDAC_OPSTATE_POLL)
-		pci->edac_check = mpc85xx_pci_check;
+	if (edac_op_state == EDAC_OPSTATE_POLL) {
+		if (pdata->is_pcie)
+			pci->edac_check = mpc85xx_pcie_check;
+		else
+			pci->edac_check = mpc85xx_pci_check;
+	}
 
 	pdata->edac_idx = edac_pci_idx++;
 
@@ -275,16 +324,26 @@ int mpc85xx_pci_err_probe(struct platform_device *op)
 		goto err;
 	}
 
-	orig_pci_err_cap_dr =
-	    in_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_CAP_DR);
+	if (pdata->is_pcie) {
+		orig_pci_err_cap_dr =
+		    in_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_ADDR);
+		out_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_ADDR, ~0);
+		orig_pci_err_en =
+		    in_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_EN);
+		out_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_EN, 0);
+	} else {
+		orig_pci_err_cap_dr =
+		    in_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_CAP_DR);
 
-	/* PCI master abort is expected during config cycles */
-	out_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_CAP_DR, 0x40);
+		/* PCI master abort is expected during config cycles */
+		out_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_CAP_DR, 0x40);
 
-	orig_pci_err_en = in_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_EN);
+		orig_pci_err_en =
+		    in_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_EN);
 
-	/* disable master abort reporting */
-	out_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_EN, ~0x40);
+		/* disable master abort reporting */
+		out_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_EN, ~0x40);
+	}
 
 	/* clear error bits */
 	out_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_DR, ~0);
@@ -297,7 +356,8 @@ int mpc85xx_pci_err_probe(struct platform_device *op)
 	if (edac_op_state == EDAC_OPSTATE_INT) {
 		pdata->irq = irq_of_parse_and_map(op->dev.of_node, 0);
 		res = devm_request_irq(&op->dev, pdata->irq,
-				       mpc85xx_pci_isr, IRQF_DISABLED,
+				       mpc85xx_pci_isr,
+				       IRQF_DISABLED | IRQF_SHARED,
 				       "[EDAC] PCI err", pci);
 		if (res < 0) {
 			printk(KERN_ERR
@@ -312,6 +372,12 @@ int mpc85xx_pci_err_probe(struct platform_device *op)
 		       pdata->irq);
 	}
 
+	if (pdata->is_pcie) {
+		/* enable all pcie error interrupt & error detect */
+		out_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_EN, ~0);
+		out_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_ADDR, 0);
+	}
+
 	devres_remove_group(&op->dev, mpc85xx_pci_err_probe);
 	edac_dbg(3, "success\n");
 	printk(KERN_INFO EDAC_MOD_STR " PCI err registered\n");
diff --git a/drivers/edac/mpc85xx_edac.h b/drivers/edac/mpc85xx_edac.h
index 932016f..9b46ea6 100644
--- a/drivers/edac/mpc85xx_edac.h
+++ b/drivers/edac/mpc85xx_edac.h
@@ -141,6 +141,10 @@
 #define MPC85XX_PCI_ERR_DH		0x001c
 #define MPC85XX_PCI_GAS_TIMR		0x0020
 #define MPC85XX_PCI_PCIX_TIMR		0x0024
+#define MPC85XX_PCIE_ERR_CAP_R0		0x0028
+#define MPC85XX_PCIE_ERR_CAP_R1		0x002c
+#define MPC85XX_PCIE_ERR_CAP_R2		0x0030
+#define MPC85XX_PCIE_ERR_CAP_R3		0x0034
 
 struct mpc85xx_mc_pdata {
 	char *name;
@@ -158,6 +162,7 @@ struct mpc85xx_l2_pdata {
 
 struct mpc85xx_pci_pdata {
 	char *name;
+	char is_pcie;
 	int edac_idx;
 	void __iomem *pci_vbase;
 	int irq;
-- 
1.7.6.5
