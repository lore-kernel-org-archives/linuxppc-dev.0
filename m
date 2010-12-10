Return-Path: <b25806@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 74571B70DA
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Dec 2010 21:46:09 +1100 (EST)
Received: from mail189-tx2 (localhost.localdomain [127.0.0.1])	by
	mail189-tx2-R.bigfish.com (Postfix) with ESMTP id A3C1FE98608	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 10 Dec 2010 10:45:49 +0000 (UTC)
Received: from TX2EHSMHS007.bigfish.com (unknown [10.9.14.243])	by
	mail189-tx2.bigfish.com (Postfix) with ESMTP id A925337C0056	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 10 Dec 2010 10:45:48 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	oBAAjlY5013181	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 10 Dec 2010 03:45:47 -0700 (MST)
Received: from zch01exm28.fsl.freescale.net ([10.192.129.225])	by
	de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id oBAB42xG010912	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 10 Dec 2010 05:04:02 -0600 (CST)
From: Lan Chunhe <b25806@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/3 v2] edac/85xx: PCI/PCIE error interrupt edac support
Date: Fri, 10 Dec 2010 18:52:07 +0800
Message-ID: <1291978327-15913-1-git-send-email-b25806@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Lan Chunhe <b25806@freescale.com>, "Kai.Jiang" <Kai.Jiang@freescale.com>,
	dougthompson@xmission.com, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add pcie error interrupt edac support for mpc85xx and p4080.
mpc85xx uses the legacy interrupt report mechanism - the error
interrupts are reported directly to mpic. While, p4080 attaches
most of error interrupts to interrupt 0. And report error interrupt
to mpic via interrupt 0. This patch can handle both of them.

Signed-off-by: Kai.Jiang <Kai.Jiang@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
Signed-off-by: Lan Chunhe <b25806@freescale.com>
---
 drivers/edac/mpc85xx_edac.c |  240 +++++++++++++++++++++++++++++++++---------
 1 files changed, 188 insertions(+), 52 deletions(-)

diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index 4bdf384..793d605 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -1,6 +1,8 @@
 /*
  * Freescale MPC85xx Memory Controller kenel module
  *
+ * Copyright (c) 2010 Freescale Semiconductor, Inc.
+ *
  * Author: Dave Jiang <djiang@mvista.com>
  *
  * 2006-2007 (c) MontaVista Software, Inc. This file is licensed under
@@ -21,6 +23,7 @@
 
 #include <linux/of_platform.h>
 #include <linux/of_device.h>
+#include <sysdev/fsl_pci.h>
 #include "edac_module.h"
 #include "edac_core.h"
 #include "mpc85xx_edac.h"
@@ -35,7 +38,7 @@ static u32 orig_ddr_err_disable;
 static u32 orig_ddr_err_sbe;
 
 static u32 orig_l2_err_disable;
-#ifdef CONFIG_FSL_SOC_BOOKE
+#if defined(CONFIG_FSL_SOC_BOOKE) && !defined(CONFIG_PPC_E500MC)
 static u32 orig_hid1[2];
 #endif
 
@@ -143,37 +146,52 @@ static void mpc85xx_pci_check(struct edac_pci_ctl_info *pci)
 {
 	struct mpc85xx_pci_pdata *pdata = pci->pvt_info;
 	u32 err_detect;
+	struct ccsr_pci *reg = pdata->pci_reg;
+
+	err_detect = in_be32(&pdata->pci_reg->pex_err_dr);
+
+	if (pdata->pcie_flag) {
+		printk(KERN_ERR "PCIE error(s) detected\n");
+		printk(KERN_ERR "PCIE ERR_DR register: 0x%08x\n", err_detect);
+		printk(KERN_ERR "PCIE ERR_CAP_STAT register: 0x%08x\n",
+				in_be32(&reg->pex_err_cap_stat));
+		printk(KERN_ERR "PCIE ERR_CAP_R0 register: 0x%08x\n",
+				in_be32(&reg->pex_err_cap_r0));
+		printk(KERN_ERR "PCIE ERR_CAP_R1 register: 0x%08x\n",
+				in_be32(&reg->pex_err_cap_r1));
+		printk(KERN_ERR "PCIE ERR_CAP_R2 register: 0x%08x\n",
+				in_be32(&reg->pex_err_cap_r2));
+		printk(KERN_ERR "PCIE ERR_CAP_R3 register: 0x%08x\n",
+				in_be32(&reg->pex_err_cap_r3));
+	} else {
+		/* master aborts can happen during PCI config cycles */
+		if (!(err_detect & ~(PCI_EDE_MULTI_ERR | PCI_EDE_MST_ABRT))) {
+			out_be32(&reg->pex_err_dr, err_detect);
+			return;
+		}
 
-	err_detect = in_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_DR);
-
-	/* master aborts can happen during PCI config cycles */
-	if (!(err_detect & ~(PCI_EDE_MULTI_ERR | PCI_EDE_MST_ABRT))) {
-		out_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_DR, err_detect);
-		return;
+		printk(KERN_ERR "PCI error(s) detected\n");
+		printk(KERN_ERR "PCI/X ERR_DR register: 0x%08x\n", err_detect);
+		printk(KERN_ERR "PCI/X ERR_ATTRIB register: 0x%08x\n",
+				in_be32(&reg->pex_err_attrib));
+		printk(KERN_ERR "PCI/X ERR_ADDR register: 0x%08x\n",
+				in_be32(&reg->pex_err_disr));
+		printk(KERN_ERR "PCI/X ERR_EXT_ADDR register: 0x%08x\n",
+				in_be32(&reg->pex_err_ext_addr));
+		printk(KERN_ERR "PCI/X ERR_DL register: 0x%08x\n",
+				in_be32(&reg->pex_err_dl));
+		printk(KERN_ERR "PCI/X ERR_DH register: 0x%08x\n",
+				in_be32(&reg->pex_err_dh));
+
+		if (err_detect & PCI_EDE_PERR_MASK)
+			edac_pci_handle_pe(pci, pci->ctl_name);
+
+		if (err_detect & ~(PCI_EDE_MULTI_ERR | PCI_EDE_PERR_MASK))
+			edac_pci_handle_npe(pci, pci->ctl_name);
 	}
 
-	printk(KERN_ERR "PCI error(s) detected\n");
-	printk(KERN_ERR "PCI/X ERR_DR register: %#08x\n", err_detect);
-
-	printk(KERN_ERR "PCI/X ERR_ATTRIB register: %#08x\n",
-	       in_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_ATTRIB));
-	printk(KERN_ERR "PCI/X ERR_ADDR register: %#08x\n",
-	       in_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_ADDR));
-	printk(KERN_ERR "PCI/X ERR_EXT_ADDR register: %#08x\n",
-	       in_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_EXT_ADDR));
-	printk(KERN_ERR "PCI/X ERR_DL register: %#08x\n",
-	       in_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_DL));
-	printk(KERN_ERR "PCI/X ERR_DH register: %#08x\n",
-	       in_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_DH));
-
 	/* clear error bits */
-	out_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_DR, err_detect);
-
-	if (err_detect & PCI_EDE_PERR_MASK)
-		edac_pci_handle_pe(pci, pci->ctl_name);
-
-	if ((err_detect & ~PCI_EDE_MULTI_ERR) & ~PCI_EDE_PERR_MASK)
-		edac_pci_handle_npe(pci, pci->ctl_name);
+	out_be32(&reg->pex_err_dr, err_detect);
 }
 
 static irqreturn_t mpc85xx_pci_isr(int irq, void *dev_id)
@@ -182,7 +200,7 @@ static irqreturn_t mpc85xx_pci_isr(int irq, void *dev_id)
 	struct mpc85xx_pci_pdata *pdata = pci->pvt_info;
 	u32 err_detect;
 
-	err_detect = in_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_DR);
+	err_detect = in_be32(&pdata->pci_reg->pex_err_dr);
 
 	if (!err_detect)
 		return IRQ_NONE;
@@ -192,12 +210,103 @@ static irqreturn_t mpc85xx_pci_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+/**
+ * This function is for error interrupt ORed mechanism.
+ * This mechanism attaches most functions' error interrupts to interrupt 0.
+ * And report error interrupt to mpic via interrupt 0.
+ * EIMR0 - Error Interrupt Mask Register 0.
+ *
+ * This function check whether the device support error interrupt ORed
+ * mechanism via device tree. If supported, umask pcie error interrupt
+ * bit in EIMR0.
+ */
+static int mpc85xx_err_int_en(struct platform_device *op)
+{
+	u32 *int_cell;
+	struct device_node *np;
+	void __iomem *mpic_base;
+	u32 reg_tmp;
+	u32 int_len;
+	struct resource r;
+	int res;
+
+	if (!op->dev.of_node)
+		return -EINVAL;
+
+	/*
+	 * Unmask pcie error interrupt bit in EIMR0.
+	 * Extend interrupt specifier has 4 cells.
+	 * For the 3rd cell:
+	 *	0 -- normal interrupt;
+	 *	1 -- error interrupt.
+	 */
+	int_cell = (u32 *)of_get_property(op->dev.of_node, "interrupts",
+								&int_len);
+	if ((int_len/sizeof(u32)) == 4) {
+		/* soc has error interrupt integration handling mechanism */
+		if (*(int_cell + 2) == 1) {
+			np = of_find_node_by_type(NULL, "open-pic");
+
+			if (of_address_to_resource(np, 0, &r)) {
+				printk(KERN_ERR "%s: Failed to map mpic regs\n",
+						__func__);
+				of_node_put(np);
+				res = -ENOMEM;
+				goto err;
+			}
+
+			if (!request_mem_region(r.start, r.end - r.start + 1,
+						"mpic")) {
+				printk(KERN_ERR "%s: Error while requesting "
+						"mem region\n", __func__);
+				res = -EBUSY;
+				goto err;
+			}
+
+			mpic_base = ioremap(r.start, r.end - r.start + 1);
+			if (!mpic_base) {
+				printk(KERN_ERR "%s: Unable to map mpic regs\n",
+						__func__);
+				res = -ENOMEM;
+				goto err_ioremap;
+			}
+
+			reg_tmp = in_be32(mpic_base + MPC85XX_MPIC_EIMR0);
+			out_be32(mpic_base + MPC85XX_MPIC_EIMR0,
+				reg_tmp & ~(1 << (31 - *(int_cell + 3))));
+			iounmap(mpic_base);
+			release_mem_region(r.start, r.end - r.start + 1);
+			of_node_put(np);
+		}
+	}
+
+	return 0;
+
+err_ioremap:
+	release_mem_region(r.start, r.end - r.start + 1);
+err:
+	return res;
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
+	return early_find_capability(hose, hose->bus->number, 0,
+					PCI_CAP_ID_EXP);
+}
+
 static int __devinit mpc85xx_pci_err_probe(struct platform_device *op,
 					   const struct of_device_id *match)
 {
 	struct edac_pci_ctl_info *pci;
 	struct mpc85xx_pci_pdata *pdata;
 	struct resource r;
+	struct ccsr_pci *reg;
 	int res = 0;
 
 	if (!devres_open_group(&op->dev, mpc85xx_pci_err_probe, GFP_KERNEL))
@@ -210,6 +319,9 @@ static int __devinit mpc85xx_pci_err_probe(struct platform_device *op,
 	pdata = pci->pvt_info;
 	pdata->name = "mpc85xx_pci_err";
 	pdata->irq = NO_IRQ;
+	if (mpc85xx_pcie_find_capability(op->dev.of_node) > 0)
+		pdata->pcie_flag = 1;
+
 	dev_set_drvdata(&op->dev, pci);
 	pci->dev = &op->dev;
 	pci->mod_name = EDAC_MOD_STR;
@@ -228,9 +340,6 @@ static int __devinit mpc85xx_pci_err_probe(struct platform_device *op,
 		goto err;
 	}
 
-	/* we only need the error registers */
-	r.start += 0xe00;
-
 	if (!devm_request_mem_region(&op->dev, r.start, resource_size(&r),
 					pdata->name)) {
 		printk(KERN_ERR "%s: Error while requesting mem region\n",
@@ -239,26 +348,32 @@ static int __devinit mpc85xx_pci_err_probe(struct platform_device *op,
 		goto err;
 	}
 
-	pdata->pci_vbase = devm_ioremap(&op->dev, r.start, resource_size(&r));
-	if (!pdata->pci_vbase) {
+	pdata->pci_reg = devm_ioremap(&op->dev, r.start, resource_size(&r));
+	if (!pdata->pci_reg) {
 		printk(KERN_ERR "%s: Unable to setup PCI err regs\n", __func__);
 		res = -ENOMEM;
 		goto err;
 	}
 
-	orig_pci_err_cap_dr =
-	    in_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_CAP_DR);
-
-	/* PCI master abort is expected during config cycles */
-	out_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_CAP_DR, 0x40);
+	if (mpc85xx_err_int_en(op) < 0)
+		goto err;
 
-	orig_pci_err_en = in_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_EN);
+	reg = pdata->pci_reg;
+	/* disable pci/pcie error detect */
+	if (pdata->pcie_flag) {
+		pdata->orig_pci_err_cap_dr =  in_be32(&reg->pex_err_disr);
+		out_be32(&reg->pex_err_disr, ~0);
+	} else {
+		pdata->orig_pci_err_cap_dr =  in_be32(&reg->pex_err_cap_dr);
+		out_be32(&reg->pex_err_cap_dr, ~0);
+	}
 
-	/* disable master abort reporting */
-	out_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_EN, ~0x40);
+	/* disable all pcie error interrupt */
+	pdata->orig_pci_err_en = in_be32(&reg->pex_err_en);
+	out_be32(&reg->pex_err_en, 0);
 
-	/* clear error bits */
-	out_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_DR, ~0);
+	/* clear all error bits */
+	out_be32(&reg->pex_err_dr, ~0);
 
 	if (edac_pci_add_device(pci, pdata->edac_idx) > 0) {
 		debugf3("%s(): failed edac_pci_add_device()\n", __func__);
@@ -268,7 +383,7 @@ static int __devinit mpc85xx_pci_err_probe(struct platform_device *op,
 	if (edac_op_state == EDAC_OPSTATE_INT) {
 		pdata->irq = irq_of_parse_and_map(op->dev.of_node, 0);
 		res = devm_request_irq(&op->dev, pdata->irq,
-				       mpc85xx_pci_isr, IRQF_DISABLED,
+				       mpc85xx_pci_isr, IRQF_SHARED,
 				       "[EDAC] PCI err", pci);
 		if (res < 0) {
 			printk(KERN_ERR
@@ -283,6 +398,17 @@ static int __devinit mpc85xx_pci_err_probe(struct platform_device *op,
 		       pdata->irq);
 	}
 
+	if (pdata->pcie_flag) {
+		/* enable all pcie error interrupt & error detect */
+		out_be32(&reg->pex_err_en, ~0);
+		out_be32(&reg->pex_err_disr, 0);
+	} else {
+		/* PCI master abort is expected during config cycles */
+		out_be32(&reg->pex_err_cap_dr, PCI_ERR_CAP_DR_DIS_MST);
+		/* disable master abort reporting */
+		out_be32(&reg->pex_err_en, PCI_ERR_EN_DIS_MST);
+	}
+
 	devres_remove_group(&op->dev, mpc85xx_pci_err_probe);
 	debugf3("%s(): success\n", __func__);
 	printk(KERN_INFO EDAC_MOD_STR " PCI err registered\n");
@@ -304,10 +430,14 @@ static int mpc85xx_pci_err_remove(struct platform_device *op)
 
 	debugf0("%s()\n", __func__);
 
-	out_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_CAP_DR,
-		 orig_pci_err_cap_dr);
+	if (pdata->pcie_flag)
+		out_be32(&pdata->pci_reg->pex_err_disr,
+						pdata->orig_pci_err_cap_dr);
+	else
+		out_be32(&pdata->pci_reg->pex_err_cap_dr,
+						pdata->orig_pci_err_cap_dr);
 
-	out_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_EN, orig_pci_err_en);
+	out_be32(&pdata->pci_reg->pex_err_en, pdata->orig_pci_err_en);
 
 	edac_pci_del_device(pci->dev);
 
@@ -326,6 +456,12 @@ static struct of_device_id mpc85xx_pci_err_of_match[] = {
 	{
 	 .compatible = "fsl,mpc8540-pci",
 	},
+	{
+	 .compatible = "fsl,mpc8548-pcie",
+	},
+	{
+	 .compatible = "fsl,p4080-pcie",
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, mpc85xx_pci_err_of_match);
@@ -1138,7 +1274,7 @@ static struct of_platform_driver mpc85xx_mc_err_driver = {
 	},
 };
 
-#ifdef CONFIG_FSL_SOC_BOOKE
+#if defined(CONFIG_FSL_SOC_BOOKE) && !defined(CONFIG_PPC_E500MC)
 static void __init mpc85xx_mc_clear_rfxe(void *data)
 {
 	orig_hid1[smp_processor_id()] = mfspr(SPRN_HID1);
@@ -1177,7 +1313,7 @@ static int __init mpc85xx_mc_init(void)
 		printk(KERN_WARNING EDAC_MOD_STR "PCI fails to register\n");
 #endif
 
-#ifdef CONFIG_FSL_SOC_BOOKE
+#if defined(CONFIG_FSL_SOC_BOOKE) && !defined(CONFIG_PPC_E500MC)
 	/*
 	 * need to clear HID1[RFXE] to disable machine check int
 	 * so we can catch it
@@ -1191,7 +1327,7 @@ static int __init mpc85xx_mc_init(void)
 
 module_init(mpc85xx_mc_init);
 
-#ifdef CONFIG_FSL_SOC_BOOKE
+#if defined(CONFIG_FSL_SOC_BOOKE) && !defined(CONFIG_PPC_E500MC)
 static void __exit mpc85xx_mc_restore_hid1(void *data)
 {
 	mtspr(SPRN_HID1, orig_hid1[smp_processor_id()]);
@@ -1200,7 +1336,7 @@ static void __exit mpc85xx_mc_restore_hid1(void *data)
 
 static void __exit mpc85xx_mc_exit(void)
 {
-#ifdef CONFIG_FSL_SOC_BOOKE
+#if defined(CONFIG_FSL_SOC_BOOKE) && !defined(CONFIG_PPC_E500MC)
 	on_each_cpu(mpc85xx_mc_restore_hid1, NULL, 0);
 #endif
 #ifdef CONFIG_PCI
-- 
1.5.4.5
