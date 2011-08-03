Return-Path: <B21989@freescale.com>
Received: from DB3EHSOBE005.bigfish.com (db3ehsobe005.messaging.microsoft.com
	[213.199.154.143])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 59530B71E5
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  3 Aug 2011 19:59:09 +1000 (EST)
From: Xie Shaohui-B21989 <B21989@freescale.com>
To: Xie Shaohui-B21989 <B21989@freescale.com>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH 4/4] edac/85xx: PCI/PCIE error interrupt edac support.
Date: Wed, 3 Aug 2011 09:58:46 +0000
Message-ID: <267A3B246C22C34A8E574051858E077011958B@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1311244404-4463-1-git-send-email-Shaohui.Xie@freescale.com> 
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "mm-commits@vger.kernel.org" <mm-commits@vger.kernel.org>,
	"avorontsov@mvista.com" <avorontsov@mvista.com>,
	Jiang Kai-B18973 <B18973@freescale.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"davem@davemloft.net" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

Any concerns of this patch?


Best Regards,=20
Shaohui Xie=20


>-----Original Message-----
>From: Xie Shaohui-B21989
>Sent: Tuesday, July 26, 2011 2:52 PM
>To: linuxppc-dev@lists.ozlabs.org; Kumar Gala
>Cc: mm-commits@vger.kernel.org; avorontsov@mvista.com; davem@davemloft.net=
;
>grant.likely@secretlab.ca; akpm@linux-foundation.org; Jiang Kai-B18973
>Subject: RE: [PATCH 4/4] edac/85xx: PCI/PCIE error interrupt edac support.
>
>I've verified this patch can apply for galak/powerpc.git 'next' branch
>with no change.
>
>
>Best Regards,
>Shaohui Xie
>
>
>>-----Original Message-----
>>From: Xie Shaohui-B21989
>>Sent: Thursday, July 21, 2011 6:33 PM
>>To: linuxppc-dev@lists.ozlabs.org
>>Cc: Gala Kumar-B11780; mm-commits@vger.kernel.org; avorontsov@mvista.com;
>>davem@davemloft.net; grant.likely@secretlab.ca; akpm@linux-foundation.org=
;
>>Jiang Kai-B18973; Kumar Gala; Xie Shaohui-B21989
>>Subject: [PATCH 4/4] edac/85xx: PCI/PCIE error interrupt edac support.
>>
>>From: Kai.Jiang <Kai.Jiang@freescale.com>
>>
>>Add pcie error interrupt edac support for mpc85xx and p4080.
>>mpc85xx uses the legacy interrupt report mechanism - the error interrupts
>>are reported directly to mpic. While, p4080 attaches most of error
>>interrupts to interrupt 0. And report error interrupt to mpic via
>>interrupt 0. This patch can handle both of them.
>>
>>
>>Due to the error management register offset and definition
>>
>>difference between pci and pcie, use ccsr_pci structure to merge pci and
>>pcie edac code into one.
>>
>>Signed-off-by: Kai.Jiang <Kai.Jiang@freescale.com>
>>Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>>Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
>>---
>> drivers/edac/mpc85xx_edac.c |  239 ++++++++++++++++++++++++++++++++-----
>-
>>----
>> drivers/edac/mpc85xx_edac.h |   17 +--
>> 2 files changed, 188 insertions(+), 68 deletions(-)
>>
>>diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
>>index b048a5f..dde156f 100644
>>--- a/drivers/edac/mpc85xx_edac.c
>>+++ b/drivers/edac/mpc85xx_edac.c
>>@@ -1,5 +1,6 @@
>> /*
>>  * Freescale MPC85xx Memory Controller kenel module
>>+ * Copyright (c) 2011 Freescale Semiconductor, Inc.
>>  *
>>  * Author: Dave Jiang <djiang@mvista.com>
>>  *
>>@@ -21,6 +22,8 @@
>>
>> #include <linux/of_platform.h>
>> #include <linux/of_device.h>
>>+#include <include/asm/pci.h>
>>+#include <sysdev/fsl_pci.h>
>> #include "edac_module.h"
>> #include "edac_core.h"
>> #include "mpc85xx_edac.h"
>>@@ -34,14 +37,6 @@ static int edac_mc_idx;  static u32
>>orig_ddr_err_disable;  static u32 orig_ddr_err_sbe;
>>
>>-/*
>>- * PCI Err defines
>>- */
>>-#ifdef CONFIG_PCI
>>-static u32 orig_pci_err_cap_dr;
>>-static u32 orig_pci_err_en;
>>-#endif
>>-
>> static u32 orig_l2_err_disable;
>> #ifdef CONFIG_FSL_SOC_BOOKE
>> static u32 orig_hid1[2];
>>@@ -151,37 +146,52 @@ static void mpc85xx_pci_check(struct
>>edac_pci_ctl_info *pci)  {
>> 	struct mpc85xx_pci_pdata *pdata =3D pci->pvt_info;
>> 	u32 err_detect;
>>+	struct ccsr_pci *reg =3D pdata->pci_reg;
>>+
>>+	err_detect =3D in_be32(&pdata->pci_reg->pex_err_dr);
>>+
>>+	if (pdata->pcie_flag) {
>>+		printk(KERN_ERR "PCIE error(s) detected\n");
>>+		printk(KERN_ERR "PCIE ERR_DR register: 0x%08x\n", err_detect);
>>+		printk(KERN_ERR "PCIE ERR_CAP_STAT register: 0x%08x\n",
>>+			in_be32(&reg->pex_err_cap_stat));
>>+		printk(KERN_ERR "PCIE ERR_CAP_R0 register: 0x%08x\n",
>>+			in_be32(&reg->pex_err_cap_r0));
>>+		printk(KERN_ERR "PCIE ERR_CAP_R1 register: 0x%08x\n",
>>+			in_be32(&reg->pex_err_cap_r1));
>>+		printk(KERN_ERR "PCIE ERR_CAP_R2 register: 0x%08x\n",
>>+			in_be32(&reg->pex_err_cap_r2));
>>+		printk(KERN_ERR "PCIE ERR_CAP_R3 register: 0x%08x\n",
>>+			in_be32(&reg->pex_err_cap_r3));
>>+	} else {
>>+		/* master aborts can happen during PCI config cycles */
>>+		if (!(err_detect & ~(PCI_EDE_MULTI_ERR | PCI_EDE_MST_ABRT))) {
>>+			out_be32(&reg->pex_err_dr, err_detect);
>>+			return;
>>+		}
>>
>>-	err_detect =3D in_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_DR);
>>-
>>-	/* master aborts can happen during PCI config cycles */
>>-	if (!(err_detect & ~(PCI_EDE_MULTI_ERR | PCI_EDE_MST_ABRT))) {
>>-		out_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_DR, err_detect);
>>-		return;
>>+		printk(KERN_ERR "PCI error(s) detected\n");
>>+		printk(KERN_ERR "PCI/X ERR_DR register: 0x%08x\n", err_detect);
>>+		printk(KERN_ERR "PCI/X ERR_ATTRIB register: 0x%08x\n",
>>+		       in_be32(&reg->pex_err_attrib));
>>+		printk(KERN_ERR "PCI/X ERR_ADDR register: 0x%08x\n",
>>+		       in_be32(&reg->pex_err_disr));
>>+		printk(KERN_ERR "PCI/X ERR_EXT_ADDR register: 0x%08x\n",
>>+		       in_be32(&reg->pex_err_ext_addr));
>>+		printk(KERN_ERR "PCI/X ERR_DL register: 0x%08x\n",
>>+		       in_be32(&reg->pex_err_dl));
>>+		printk(KERN_ERR "PCI/X ERR_DH register: 0x%08x\n",
>>+		       in_be32(&reg->pex_err_dh));
>>+
>>+		if (err_detect & PCI_EDE_PERR_MASK)
>>+			edac_pci_handle_pe(pci, pci->ctl_name);
>>+
>>+		if ((err_detect & ~PCI_EDE_MULTI_ERR) & ~PCI_EDE_PERR_MASK)
>>+			edac_pci_handle_npe(pci, pci->ctl_name);
>> 	}
>>
>>-	printk(KERN_ERR "PCI error(s) detected\n");
>>-	printk(KERN_ERR "PCI/X ERR_DR register: %#08x\n", err_detect);
>>-
>>-	printk(KERN_ERR "PCI/X ERR_ATTRIB register: %#08x\n",
>>-	       in_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_ATTRIB));
>>-	printk(KERN_ERR "PCI/X ERR_ADDR register: %#08x\n",
>>-	       in_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_ADDR));
>>-	printk(KERN_ERR "PCI/X ERR_EXT_ADDR register: %#08x\n",
>>-	       in_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_EXT_ADDR));
>>-	printk(KERN_ERR "PCI/X ERR_DL register: %#08x\n",
>>-	       in_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_DL));
>>-	printk(KERN_ERR "PCI/X ERR_DH register: %#08x\n",
>>-	       in_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_DH));
>>-
>> 	/* clear error bits */
>>-	out_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_DR, err_detect);
>>-
>>-	if (err_detect & PCI_EDE_PERR_MASK)
>>-		edac_pci_handle_pe(pci, pci->ctl_name);
>>-
>>-	if ((err_detect & ~PCI_EDE_MULTI_ERR) & ~PCI_EDE_PERR_MASK)
>>-		edac_pci_handle_npe(pci, pci->ctl_name);
>>+	out_be32(&reg->pex_err_dr, err_detect);
>> }
>>
>> static irqreturn_t mpc85xx_pci_isr(int irq, void *dev_id) @@ -190,7
>>+200,7 @@ static irqreturn_t mpc85xx_pci_isr(int irq, void *dev_id)
>> 	struct mpc85xx_pci_pdata *pdata =3D pci->pvt_info;
>> 	u32 err_detect;
>>
>>-	err_detect =3D in_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_DR);
>>+	err_detect =3D in_be32(&pdata->pci_reg->pex_err_dr);
>>
>> 	if (!err_detect)
>> 		return IRQ_NONE;
>>@@ -200,11 +210,99 @@ static irqreturn_t mpc85xx_pci_isr(int irq, void
>>*dev_id)
>> 	return IRQ_HANDLED;
>> }
>>
>>+#define MPC85XX_MPIC_EIMR0	0x3910
>>+/*
>>+ * This function is for error interrupt ORed mechanism.
>>+ * This mechanism attaches most functions' error interrupts to interrupt
>>0.
>>+ * And report error interrupt to mpic via interrupt 0.
>>+ * EIMR0 - Error Interrupt Mask Register 0.
>>+ *
>>+ * This function check whether the device support error interrupt ORed
>>+ * mechanism via device tree. If supported, umask pcie error interrupt
>>+ * bit in EIMR0.
>>+ */
>>+static int mpc85xx_err_int_en(struct device *op) {
>>+	u32 *int_cell =3D NULL;
>>+	struct device_node *np =3D NULL;
>>+	void __iomem *mpic_base =3D NULL;
>>+	u32 reg_tmp =3D 0;
>>+	u32 int_len =3D 0;
>>+	struct resource r;
>>+	int res =3D 0;
>>+
>>+	if (!op->of_node)
>>+		return -EINVAL;
>>+	/*
>>+	 * Unmask pcie error interrupt bit in EIMR0
>>+	 * extend interrupt specifier has 4 cells. For the 3rd cell:
>>+	 * 0 -- normal interrupt; 1 -- error interrupt.
>>+	 */
>>+	int_cell =3D (u32 *)of_get_property(op->of_node, "interrupts",
>>&int_len);
>>+	if ((int_len/sizeof(u32)) =3D=3D 4) {
>>+		/* soc has error interrupt integration handling mechanism */
>>+		if (*(int_cell + 2) =3D=3D 1) {
>>+			np =3D of_find_node_by_type(NULL, "open-pic");
>>+
>>+			if (of_address_to_resource(np, 0, &r)) {
>>+				printk(KERN_ERR
>>+				"%s:Failed to map mpic regs\n", __func__);
>>+				of_node_put(np);
>>+				res =3D -ENOMEM;
>>+				goto err;
>>+			}
>>+
>>+			if (!request_mem_region(r.start,
>>+						r.end - r.start + 1, "mpic")) {
>>+				printk(KERN_ERR
>>+				"%s:Error while requesting mem region\n",
>>+					 __func__);
>>+				res =3D -EBUSY;
>>+				goto err;
>>+			}
>>+
>>+			mpic_base =3D ioremap(r.start, r.end - r.start + 1);
>>+			if (!mpic_base) {
>>+				printk(KERN_ERR
>>+				"%s:Unable to map mpic regs\n", __func__);
>>+				res =3D -ENOMEM;
>>+				goto err_ioremap;
>>+			}
>>+
>>+			reg_tmp =3D in_be32(mpic_base + MPC85XX_MPIC_EIMR0);
>>+			out_be32(mpic_base + MPC85XX_MPIC_EIMR0,
>>+				reg_tmp & ~(1 << (31 - *(int_cell + 3))));
>>+			iounmap(mpic_base);
>>+			release_mem_region(r.start, r.end - r.start + 1);
>>+			of_node_put(np);
>>+		}
>>+	}
>>+
>>+	return 0;
>>+err_ioremap:
>>+	release_mem_region(r.start, r.end - r.start + 1);
>>+err:
>>+
>>+	return res;
>>+}
>>+
>>+static int mpc85xx_pcie_find_capability(struct device_node *np) {
>>+	struct pci_controller *hose;
>>+	if (!np)
>>+		return -EINVAL;
>>+
>>+	hose =3D pci_find_hose_for_OF_device(np);
>>+	return early_find_capability(hose, hose->bus->number,
>>+				     0, PCI_CAP_ID_EXP);
>>+}
>>+
>> static int __devinit mpc85xx_pci_err_probe(struct platform_device *op)
>{
>> 	struct edac_pci_ctl_info *pci;
>> 	struct mpc85xx_pci_pdata *pdata;
>> 	struct resource r;
>>+	struct ccsr_pci *reg =3D NULL;
>> 	int res =3D 0;
>>
>> 	if (!devres_open_group(&op->dev, mpc85xx_pci_err_probe, GFP_KERNEL))
>>@@ -217,6 +315,10 @@ static int __devinit mpc85xx_pci_err_probe(struct
>>platform_device *op)
>> 	pdata =3D pci->pvt_info;
>> 	pdata->name =3D "mpc85xx_pci_err";
>> 	pdata->irq =3D NO_IRQ;
>>+
>>+	if (mpc85xx_pcie_find_capability(op->dev.of_node) > 0)
>>+		pdata->pcie_flag =3D 1;
>>+
>> 	dev_set_drvdata(&op->dev, pci);
>> 	pci->dev =3D &op->dev;
>> 	pci->mod_name =3D EDAC_MOD_STR;
>>@@ -235,37 +337,40 @@ static int __devinit mpc85xx_pci_err_probe(struct
>>platform_device *op)
>> 		goto err;
>> 	}
>>
>>-	/* we only need the error registers */
>>-	r.start +=3D 0xe00;
>>-
>> 	if (!devm_request_mem_region(&op->dev, r.start, resource_size(&r),
>> 					pdata->name)) {
>>-		printk(KERN_ERR "%s: Error while requesting mem region\n",
>>-		       __func__);
>>+		printk(KERN_ERR
>>+		"%s:Error while requesting mem region\n", __func__);
>> 		res =3D -EBUSY;
>> 		goto err;
>> 	}
>>
>>-	pdata->pci_vbase =3D devm_ioremap(&op->dev, r.start,
>>resource_size(&r));
>>-	if (!pdata->pci_vbase) {
>>+	pdata->pci_reg =3D devm_ioremap(&op->dev, r.start, resource_size(&r));
>>+	if (!pdata->pci_reg) {
>> 		printk(KERN_ERR "%s: Unable to setup PCI err regs\n",
>>__func__);
>> 		res =3D -ENOMEM;
>> 		goto err;
>> 	}
>>
>>-	orig_pci_err_cap_dr =3D
>>-	    in_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_CAP_DR);
>>-
>>-	/* PCI master abort is expected during config cycles */
>>-	out_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_CAP_DR, 0x40);
>>+	if (mpc85xx_err_int_en(&op->dev) < 0)
>>+		goto err;
>>
>>-	orig_pci_err_en =3D in_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_EN);
>>+	reg =3D pdata->pci_reg;
>>+	/* disable pci/pcie error detect */
>>+	if (pdata->pcie_flag) {
>>+		pdata->orig_pci_err_dr =3D  in_be32(&reg->pex_err_disr);
>>+		out_be32(&reg->pex_err_disr, ~0);
>>+	} else {
>>+		pdata->orig_pci_err_dr =3D  in_be32(&reg->pex_err_cap_dr);
>>+		out_be32(&reg->pex_err_cap_dr, ~0);
>>+	}
>>
>>-	/* disable master abort reporting */
>>-	out_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_EN, ~0x40);
>>+	/* disable all pcie error interrupt */
>>+	pdata->orig_pci_err_en =3D in_be32(&reg->pex_err_en);
>>+	out_be32(&reg->pex_err_en, 0);
>>
>>-	/* clear error bits */
>>-	out_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_DR, ~0);
>>+	/* clear all error bits */
>>+	out_be32(&reg->pex_err_dr, ~0);
>>
>> 	if (edac_pci_add_device(pci, pdata->edac_idx) > 0) {
>> 		debugf3("%s(): failed edac_pci_add_device()\n", __func__); @@
>>-275,7 +380,7 @@ static int __devinit mpc85xx_pci_err_probe(struct
>>platform_device *op)
>> 	if (edac_op_state =3D=3D EDAC_OPSTATE_INT) {
>> 		pdata->irq =3D irq_of_parse_and_map(op->dev.of_node, 0);
>> 		res =3D devm_request_irq(&op->dev, pdata->irq,
>>-				       mpc85xx_pci_isr, IRQF_DISABLED,
>>+				       mpc85xx_pci_isr, IRQF_SHARED,
>> 				       "[EDAC] PCI err", pci);
>> 		if (res < 0) {
>> 			printk(KERN_ERR
>>@@ -290,6 +395,17 @@ static int __devinit mpc85xx_pci_err_probe(struct
>>platform_device *op)
>> 		       pdata->irq);
>> 	}
>>
>>+	if (pdata->pcie_flag) {
>>+		/* enable all pcie error interrupt & error detect */
>>+		out_be32(&reg->pex_err_en, ~0);
>>+		out_be32(&reg->pex_err_disr, 0);
>>+	} else {
>>+		/* PCI master abort is expected during config cycles */
>>+		out_be32(&reg->pex_err_cap_dr, PCI_ERR_CAP_DR_DIS_MST);
>>+		/* disable master abort reporting */
>>+		out_be32(&reg->pex_err_en, PCI_ERR_EN_DIS_MST);
>>+	}
>>+
>> 	devres_remove_group(&op->dev, mpc85xx_pci_err_probe);
>> 	debugf3("%s(): success\n", __func__);
>> 	printk(KERN_INFO EDAC_MOD_STR " PCI err registered\n"); @@ -311,10
>>+427,13 @@ static int mpc85xx_pci_err_remove(struct platform_device *op)
>>
>> 	debugf0("%s()\n", __func__);
>>
>>-	out_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_CAP_DR,
>>-		 orig_pci_err_cap_dr);
>>+	if (pdata->pcie_flag)
>>+		out_be32(&pdata->pci_reg->pex_err_disr, pdata-
>>>orig_pci_err_dr);
>>+	else
>>+		out_be32(&pdata->pci_reg->pex_err_cap_dr,
>>+					pdata->orig_pci_err_dr);
>>
>>-	out_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_EN, orig_pci_err_en);
>>+	out_be32(&pdata->pci_reg->pex_err_en, pdata->orig_pci_err_en);
>>
>> 	edac_pci_del_device(pci->dev);
>>
>>@@ -333,6 +452,12 @@ static struct of_device_id mpc85xx_pci_err_of_match[=
]
>>=3D {
>> 	{
>> 	 .compatible =3D "fsl,mpc8540-pci",
>> 	},
>>+	{
>>+	 .compatible =3D "fsl,mpc8548-pcie",
>>+	},
>>+	{
>>+	 .compatible =3D "fsl,p4080-pcie",
>>+	},
>> 	{},
>> };
>> MODULE_DEVICE_TABLE(of, mpc85xx_pci_err_of_match); diff --git
>>a/drivers/edac/mpc85xx_edac.h b/drivers/edac/mpc85xx_edac.h index
>>932016f..d0e7b11 100644
>>--- a/drivers/edac/mpc85xx_edac.h
>>+++ b/drivers/edac/mpc85xx_edac.h
>>@@ -131,16 +131,8 @@
>> #define PCI_EDE_PERR_MASK	(PCI_EDE_TGT_PERR | PCI_EDE_MST_PERR | \
>> 				PCI_EDE_ADDR_PERR)
>>
>>-#define MPC85XX_PCI_ERR_DR		0x0000
>>-#define MPC85XX_PCI_ERR_CAP_DR		0x0004
>>-#define MPC85XX_PCI_ERR_EN		0x0008
>>-#define MPC85XX_PCI_ERR_ATTRIB		0x000c
>>-#define MPC85XX_PCI_ERR_ADDR		0x0010
>>-#define MPC85XX_PCI_ERR_EXT_ADDR	0x0014
>>-#define MPC85XX_PCI_ERR_DL		0x0018
>>-#define MPC85XX_PCI_ERR_DH		0x001c
>>-#define MPC85XX_PCI_GAS_TIMR		0x0020
>>-#define MPC85XX_PCI_PCIX_TIMR		0x0024
>>+#define PCI_ERR_CAP_DR_DIS_MST         0x40
>>+#define PCI_ERR_EN_DIS_MST             (~0x40)
>>
>> struct mpc85xx_mc_pdata {
>> 	char *name;
>>@@ -159,8 +151,11 @@ struct mpc85xx_l2_pdata {  struct mpc85xx_pci_pdata
>{
>> 	char *name;
>> 	int edac_idx;
>>-	void __iomem *pci_vbase;
>> 	int irq;
>>+	struct ccsr_pci *pci_reg;
>>+	u8 pcie_flag;
>>+	u32 orig_pci_err_dr;
>>+	u32 orig_pci_err_en;
>> };
>>
>> #endif
>>--
>>1.6.4
