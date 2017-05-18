Return-Path: <chrisp@alliedtelesis.co.nz>
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [IPv6:2001:df5:b000:5::4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wT4QX6G0RzDqM0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 May 2017 18:40:52 +1000 (AEST)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: bp@alien8.de,
	mchehab@kernel.org,
	linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au, Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 3/3] EDAC: mv64x60: replace in_le32/out_le32 with
 readl/writel
Date: Thu, 18 May 2017 20:31:35 +1200
Message-Id: <20170518083135.28048-4-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20170518083135.28048-1-chris.packham@alliedtelesis.co.nz>
References: <20170518083135.28048-1-chris.packham@alliedtelesis.co.nz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To allow this driver to be used on non-powerpc platforms it needs to use
io accessors suitable for all platforms.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v2:
    - use readl/writel as suggested.

 drivers/edac/mv64x60_edac.c | 84 ++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/edac/mv64x60_edac.c b/drivers/edac/mv64x60_edac.c
index ddc5082f7577..d38538242e9c 100644
--- a/drivers/edac/mv64x60_edac.c
+++ b/drivers/edac/mv64x60_edac.c
@@ -32,21 +32,21 @@ static void mv64x60_pci_check(struct edac_pci_ctl_info *pci)
 	struct mv64x60_pci_pdata *pdata = pci->pvt_info;
 	u32 cause;
 
-	cause = in_le32(pdata->pci_vbase + MV64X60_PCI_ERROR_CAUSE);
+	cause = readl(pdata->pci_vbase + MV64X60_PCI_ERROR_CAUSE);
 	if (!cause)
 		return;
 
 	printk(KERN_ERR "Error in PCI %d Interface\n", pdata->pci_hose);
 	printk(KERN_ERR "Cause register: 0x%08x\n", cause);
 	printk(KERN_ERR "Address Low: 0x%08x\n",
-	       in_le32(pdata->pci_vbase + MV64X60_PCI_ERROR_ADDR_LO));
+	       readl(pdata->pci_vbase + MV64X60_PCI_ERROR_ADDR_LO));
 	printk(KERN_ERR "Address High: 0x%08x\n",
-	       in_le32(pdata->pci_vbase + MV64X60_PCI_ERROR_ADDR_HI));
+	       readl(pdata->pci_vbase + MV64X60_PCI_ERROR_ADDR_HI));
 	printk(KERN_ERR "Attribute: 0x%08x\n",
-	       in_le32(pdata->pci_vbase + MV64X60_PCI_ERROR_ATTR));
+	       readl(pdata->pci_vbase + MV64X60_PCI_ERROR_ATTR));
 	printk(KERN_ERR "Command: 0x%08x\n",
-	       in_le32(pdata->pci_vbase + MV64X60_PCI_ERROR_CMD));
-	out_le32(pdata->pci_vbase + MV64X60_PCI_ERROR_CAUSE, ~cause);
+	       readl(pdata->pci_vbase + MV64X60_PCI_ERROR_CMD));
+	writel(~cause, pdata->pci_vbase + MV64X60_PCI_ERROR_CAUSE);
 
 	if (cause & MV64X60_PCI_PE_MASK)
 		edac_pci_handle_pe(pci, pci->ctl_name);
@@ -61,7 +61,7 @@ static irqreturn_t mv64x60_pci_isr(int irq, void *dev_id)
 	struct mv64x60_pci_pdata *pdata = pci->pvt_info;
 	u32 val;
 
-	val = in_le32(pdata->pci_vbase + MV64X60_PCI_ERROR_CAUSE);
+	val = readl(pdata->pci_vbase + MV64X60_PCI_ERROR_CAUSE);
 	if (!val)
 		return IRQ_NONE;
 
@@ -93,7 +93,7 @@ static int __init mv64x60_pci_fixup(struct platform_device *pdev)
 	if (!pci_serr)
 		return -ENOMEM;
 
-	out_le32(pci_serr, in_le32(pci_serr) & ~0x1);
+	writel(readl(pci_serr) & ~0x1, pci_serr);
 	iounmap(pci_serr);
 
 	return 0;
@@ -161,10 +161,10 @@ static int mv64x60_pci_err_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	out_le32(pdata->pci_vbase + MV64X60_PCI_ERROR_CAUSE, 0);
-	out_le32(pdata->pci_vbase + MV64X60_PCI_ERROR_MASK, 0);
-	out_le32(pdata->pci_vbase + MV64X60_PCI_ERROR_MASK,
-		 MV64X60_PCIx_ERR_MASK_VAL);
+	writel(0, pdata->pci_vbase + MV64X60_PCI_ERROR_CAUSE);
+	writel(0, pdata->pci_vbase + MV64X60_PCI_ERROR_MASK);
+	writel(MV64X60_PCIx_ERR_MASK_VAL,
+		  pdata->pci_vbase + MV64X60_PCI_ERROR_MASK);
 
 	if (edac_pci_add_device(pci, pdata->edac_idx) > 0) {
 		edac_dbg(3, "failed edac_pci_add_device()\n");
@@ -233,23 +233,23 @@ static void mv64x60_sram_check(struct edac_device_ctl_info *edac_dev)
 	struct mv64x60_sram_pdata *pdata = edac_dev->pvt_info;
 	u32 cause;
 
-	cause = in_le32(pdata->sram_vbase + MV64X60_SRAM_ERR_CAUSE);
+	cause = readl(pdata->sram_vbase + MV64X60_SRAM_ERR_CAUSE);
 	if (!cause)
 		return;
 
 	printk(KERN_ERR "Error in internal SRAM\n");
 	printk(KERN_ERR "Cause register: 0x%08x\n", cause);
 	printk(KERN_ERR "Address Low: 0x%08x\n",
-	       in_le32(pdata->sram_vbase + MV64X60_SRAM_ERR_ADDR_LO));
+	       readl(pdata->sram_vbase + MV64X60_SRAM_ERR_ADDR_LO));
 	printk(KERN_ERR "Address High: 0x%08x\n",
-	       in_le32(pdata->sram_vbase + MV64X60_SRAM_ERR_ADDR_HI));
+	       readl(pdata->sram_vbase + MV64X60_SRAM_ERR_ADDR_HI));
 	printk(KERN_ERR "Data Low: 0x%08x\n",
-	       in_le32(pdata->sram_vbase + MV64X60_SRAM_ERR_DATA_LO));
+	       readl(pdata->sram_vbase + MV64X60_SRAM_ERR_DATA_LO));
 	printk(KERN_ERR "Data High: 0x%08x\n",
-	       in_le32(pdata->sram_vbase + MV64X60_SRAM_ERR_DATA_HI));
+	       readl(pdata->sram_vbase + MV64X60_SRAM_ERR_DATA_HI));
 	printk(KERN_ERR "Parity: 0x%08x\n",
-	       in_le32(pdata->sram_vbase + MV64X60_SRAM_ERR_PARITY));
-	out_le32(pdata->sram_vbase + MV64X60_SRAM_ERR_CAUSE, 0);
+	       readl(pdata->sram_vbase + MV64X60_SRAM_ERR_PARITY));
+	writel(0, pdata->sram_vbase + MV64X60_SRAM_ERR_CAUSE);
 
 	edac_device_handle_ue(edac_dev, 0, 0, edac_dev->ctl_name);
 }
@@ -260,7 +260,7 @@ static irqreturn_t mv64x60_sram_isr(int irq, void *dev_id)
 	struct mv64x60_sram_pdata *pdata = edac_dev->pvt_info;
 	u32 cause;
 
-	cause = in_le32(pdata->sram_vbase + MV64X60_SRAM_ERR_CAUSE);
+	cause = readl(pdata->sram_vbase + MV64X60_SRAM_ERR_CAUSE);
 	if (!cause)
 		return IRQ_NONE;
 
@@ -322,7 +322,7 @@ static int mv64x60_sram_err_probe(struct platform_device *pdev)
 	}
 
 	/* setup SRAM err registers */
-	out_le32(pdata->sram_vbase + MV64X60_SRAM_ERR_CAUSE, 0);
+	writel(0, pdata->sram_vbase + MV64X60_SRAM_ERR_CAUSE);
 
 	edac_dev->mod_name = EDAC_MOD_STR;
 	edac_dev->ctl_name = pdata->name;
@@ -398,7 +398,7 @@ static void mv64x60_cpu_check(struct edac_device_ctl_info *edac_dev)
 	struct mv64x60_cpu_pdata *pdata = edac_dev->pvt_info;
 	u32 cause;
 
-	cause = in_le32(pdata->cpu_vbase[1] + MV64x60_CPU_ERR_CAUSE) &
+	cause = readl(pdata->cpu_vbase[1] + MV64x60_CPU_ERR_CAUSE) &
 	    MV64x60_CPU_CAUSE_MASK;
 	if (!cause)
 		return;
@@ -406,16 +406,16 @@ static void mv64x60_cpu_check(struct edac_device_ctl_info *edac_dev)
 	printk(KERN_ERR "Error on CPU interface\n");
 	printk(KERN_ERR "Cause register: 0x%08x\n", cause);
 	printk(KERN_ERR "Address Low: 0x%08x\n",
-	       in_le32(pdata->cpu_vbase[0] + MV64x60_CPU_ERR_ADDR_LO));
+	       readl(pdata->cpu_vbase[0] + MV64x60_CPU_ERR_ADDR_LO));
 	printk(KERN_ERR "Address High: 0x%08x\n",
-	       in_le32(pdata->cpu_vbase[0] + MV64x60_CPU_ERR_ADDR_HI));
+	       readl(pdata->cpu_vbase[0] + MV64x60_CPU_ERR_ADDR_HI));
 	printk(KERN_ERR "Data Low: 0x%08x\n",
-	       in_le32(pdata->cpu_vbase[1] + MV64x60_CPU_ERR_DATA_LO));
+	       readl(pdata->cpu_vbase[1] + MV64x60_CPU_ERR_DATA_LO));
 	printk(KERN_ERR "Data High: 0x%08x\n",
-	       in_le32(pdata->cpu_vbase[1] + MV64x60_CPU_ERR_DATA_HI));
+	       readl(pdata->cpu_vbase[1] + MV64x60_CPU_ERR_DATA_HI));
 	printk(KERN_ERR "Parity: 0x%08x\n",
-	       in_le32(pdata->cpu_vbase[1] + MV64x60_CPU_ERR_PARITY));
-	out_le32(pdata->cpu_vbase[1] + MV64x60_CPU_ERR_CAUSE, 0);
+	       readl(pdata->cpu_vbase[1] + MV64x60_CPU_ERR_PARITY));
+	writel(0, pdata->cpu_vbase[1] + MV64x60_CPU_ERR_CAUSE);
 
 	edac_device_handle_ue(edac_dev, 0, 0, edac_dev->ctl_name);
 }
@@ -426,7 +426,7 @@ static irqreturn_t mv64x60_cpu_isr(int irq, void *dev_id)
 	struct mv64x60_cpu_pdata *pdata = edac_dev->pvt_info;
 	u32 cause;
 
-	cause = in_le32(pdata->cpu_vbase[1] + MV64x60_CPU_ERR_CAUSE) &
+	cause = readl(pdata->cpu_vbase[1] + MV64x60_CPU_ERR_CAUSE) &
 	    MV64x60_CPU_CAUSE_MASK;
 	if (!cause)
 		return IRQ_NONE;
@@ -515,9 +515,9 @@ static int mv64x60_cpu_err_probe(struct platform_device *pdev)
 	}
 
 	/* setup CPU err registers */
-	out_le32(pdata->cpu_vbase[1] + MV64x60_CPU_ERR_CAUSE, 0);
-	out_le32(pdata->cpu_vbase[1] + MV64x60_CPU_ERR_MASK, 0);
-	out_le32(pdata->cpu_vbase[1] + MV64x60_CPU_ERR_MASK, 0x000000ff);
+	writel(0, pdata->cpu_vbase[1] + MV64x60_CPU_ERR_CAUSE);
+	writel(0, pdata->cpu_vbase[1] + MV64x60_CPU_ERR_MASK);
+	writel(0x000000ff, pdata->cpu_vbase[1] + MV64x60_CPU_ERR_MASK);
 
 	edac_dev->mod_name = EDAC_MOD_STR;
 	edac_dev->ctl_name = pdata->name;
@@ -596,13 +596,13 @@ static void mv64x60_mc_check(struct mem_ctl_info *mci)
 	u32 comp_ecc;
 	u32 syndrome;
 
-	reg = in_le32(pdata->mc_vbase + MV64X60_SDRAM_ERR_ADDR);
+	reg = readl(pdata->mc_vbase + MV64X60_SDRAM_ERR_ADDR);
 	if (!reg)
 		return;
 
 	err_addr = reg & ~0x3;
-	sdram_ecc = in_le32(pdata->mc_vbase + MV64X60_SDRAM_ERR_ECC_RCVD);
-	comp_ecc = in_le32(pdata->mc_vbase + MV64X60_SDRAM_ERR_ECC_CALC);
+	sdram_ecc = readl(pdata->mc_vbase + MV64X60_SDRAM_ERR_ECC_RCVD);
+	comp_ecc = readl(pdata->mc_vbase + MV64X60_SDRAM_ERR_ECC_CALC);
 	syndrome = sdram_ecc ^ comp_ecc;
 
 	/* first bit clear in ECC Err Reg, 1 bit error, correctable by HW */
@@ -620,7 +620,7 @@ static void mv64x60_mc_check(struct mem_ctl_info *mci)
 				     mci->ctl_name, "");
 
 	/* clear the error */
-	out_le32(pdata->mc_vbase + MV64X60_SDRAM_ERR_ADDR, 0);
+	writel(0, pdata->mc_vbase + MV64X60_SDRAM_ERR_ADDR);
 }
 
 static irqreturn_t mv64x60_mc_isr(int irq, void *dev_id)
@@ -629,7 +629,7 @@ static irqreturn_t mv64x60_mc_isr(int irq, void *dev_id)
 	struct mv64x60_mc_pdata *pdata = mci->pvt_info;
 	u32 reg;
 
-	reg = in_le32(pdata->mc_vbase + MV64X60_SDRAM_ERR_ADDR);
+	reg = readl(pdata->mc_vbase + MV64X60_SDRAM_ERR_ADDR);
 	if (!reg)
 		return IRQ_NONE;
 
@@ -664,7 +664,7 @@ static void mv64x60_init_csrows(struct mem_ctl_info *mci,
 
 	get_total_mem(pdata);
 
-	ctl = in_le32(pdata->mc_vbase + MV64X60_SDRAM_CONFIG);
+	ctl = readl(pdata->mc_vbase + MV64X60_SDRAM_CONFIG);
 
 	csrow = mci->csrows[0];
 	dimm = csrow->channels[0]->dimm;
@@ -753,7 +753,7 @@ static int mv64x60_mc_err_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	ctl = in_le32(pdata->mc_vbase + MV64X60_SDRAM_CONFIG);
+	ctl = readl(pdata->mc_vbase + MV64X60_SDRAM_CONFIG);
 	if (!(ctl & MV64X60_SDRAM_ECC)) {
 		/* Non-ECC RAM? */
 		printk(KERN_WARNING "%s: No ECC DIMMs discovered\n", __func__);
@@ -779,10 +779,10 @@ static int mv64x60_mc_err_probe(struct platform_device *pdev)
 	mv64x60_init_csrows(mci, pdata);
 
 	/* setup MC registers */
-	out_le32(pdata->mc_vbase + MV64X60_SDRAM_ERR_ADDR, 0);
-	ctl = in_le32(pdata->mc_vbase + MV64X60_SDRAM_ERR_ECC_CNTL);
+	writel(0, pdata->mc_vbase + MV64X60_SDRAM_ERR_ADDR);
+	ctl = readl(pdata->mc_vbase + MV64X60_SDRAM_ERR_ECC_CNTL);
 	ctl = (ctl & 0xff00ffff) | 0x10000;
-	out_le32(pdata->mc_vbase + MV64X60_SDRAM_ERR_ECC_CNTL, ctl);
+	writel(ctl, pdata->mc_vbase + MV64X60_SDRAM_ERR_ECC_CNTL);
 
 	res = edac_mc_add_mc(mci);
 	if (res) {
-- 
2.11.0.24.ge6920cf
