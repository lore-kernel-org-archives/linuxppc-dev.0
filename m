Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3srFff1l4rzDrPL
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Oct 2016 03:42:00 +1100 (AEDT)
Subject: [PATCH 1/7] PCI: layerscape: Name private struct pointer "ls"
 consistently
To: Minghuan Lian <minghuan.Lian@freescale.com>,
 Mingkai Hu <mingkai.hu@freescale.com>, Roy Zang <tie-fei.zang@freescale.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri, 07 Oct 2016 11:41:49 -0500
Message-ID: <20161007164149.26341.87049.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use a device-specific name, "ls", for struct ls_pcie pointers
to hint that this is device-specific information.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-layerscape.c |   86 +++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index 114ba81..a1dccb0 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -55,47 +55,47 @@ struct ls_pcie {
 
 #define to_ls_pcie(x)	container_of(x, struct ls_pcie, pp)
 
-static bool ls_pcie_is_bridge(struct ls_pcie *pcie)
+static bool ls_pcie_is_bridge(struct ls_pcie *ls)
 {
 	u32 header_type;
 
-	header_type = ioread8(pcie->dbi + PCI_HEADER_TYPE);
+	header_type = ioread8(ls->dbi + PCI_HEADER_TYPE);
 	header_type &= 0x7f;
 
 	return header_type == PCI_HEADER_TYPE_BRIDGE;
 }
 
 /* Clear multi-function bit */
-static void ls_pcie_clear_multifunction(struct ls_pcie *pcie)
+static void ls_pcie_clear_multifunction(struct ls_pcie *ls)
 {
-	iowrite8(PCI_HEADER_TYPE_BRIDGE, pcie->dbi + PCI_HEADER_TYPE);
+	iowrite8(PCI_HEADER_TYPE_BRIDGE, ls->dbi + PCI_HEADER_TYPE);
 }
 
 /* Fix class value */
-static void ls_pcie_fix_class(struct ls_pcie *pcie)
+static void ls_pcie_fix_class(struct ls_pcie *ls)
 {
-	iowrite16(PCI_CLASS_BRIDGE_PCI, pcie->dbi + PCI_CLASS_DEVICE);
+	iowrite16(PCI_CLASS_BRIDGE_PCI, ls->dbi + PCI_CLASS_DEVICE);
 }
 
 /* Drop MSG TLP except for Vendor MSG */
-static void ls_pcie_drop_msg_tlp(struct ls_pcie *pcie)
+static void ls_pcie_drop_msg_tlp(struct ls_pcie *ls)
 {
 	u32 val;
 
-	val = ioread32(pcie->dbi + PCIE_STRFMR1);
+	val = ioread32(ls->dbi + PCIE_STRFMR1);
 	val &= 0xDFFFFFFF;
-	iowrite32(val, pcie->dbi + PCIE_STRFMR1);
+	iowrite32(val, ls->dbi + PCIE_STRFMR1);
 }
 
 static int ls1021_pcie_link_up(struct pcie_port *pp)
 {
+	struct ls_pcie *ls = to_ls_pcie(pp);
 	u32 state;
-	struct ls_pcie *pcie = to_ls_pcie(pp);
 
-	if (!pcie->scfg)
+	if (!ls->scfg)
 		return 0;
 
-	regmap_read(pcie->scfg, SCFG_PEXMSCPORTSR(pcie->index), &state);
+	regmap_read(ls->scfg, SCFG_PEXMSCPORTSR(ls->index), &state);
 	state = (state >> LTSSM_STATE_SHIFT) & LTSSM_STATE_MASK;
 
 	if (state < LTSSM_PCIE_L0)
@@ -106,36 +106,36 @@ static int ls1021_pcie_link_up(struct pcie_port *pp)
 
 static void ls1021_pcie_host_init(struct pcie_port *pp)
 {
-	struct ls_pcie *pcie = to_ls_pcie(pp);
+	struct ls_pcie *ls = to_ls_pcie(pp);
 	u32 index[2];
 
-	pcie->scfg = syscon_regmap_lookup_by_phandle(pp->dev->of_node,
-						     "fsl,pcie-scfg");
-	if (IS_ERR(pcie->scfg)) {
+	ls->scfg = syscon_regmap_lookup_by_phandle(pp->dev->of_node,
+						   "fsl,pcie-scfg");
+	if (IS_ERR(ls->scfg)) {
 		dev_err(pp->dev, "No syscfg phandle specified\n");
-		pcie->scfg = NULL;
+		ls->scfg = NULL;
 		return;
 	}
 
 	if (of_property_read_u32_array(pp->dev->of_node,
 				       "fsl,pcie-scfg", index, 2)) {
-		pcie->scfg = NULL;
+		ls->scfg = NULL;
 		return;
 	}
-	pcie->index = index[1];
+	ls->index = index[1];
 
 	dw_pcie_setup_rc(pp);
 
-	ls_pcie_drop_msg_tlp(pcie);
+	ls_pcie_drop_msg_tlp(ls);
 }
 
 static int ls_pcie_link_up(struct pcie_port *pp)
 {
-	struct ls_pcie *pcie = to_ls_pcie(pp);
+	struct ls_pcie *ls = to_ls_pcie(pp);
 	u32 state;
 
-	state = (ioread32(pcie->lut + PCIE_LUT_DBG) >>
-		 pcie->drvdata->ltssm_shift) &
+	state = (ioread32(ls->lut + PCIE_LUT_DBG) >>
+		 ls->drvdata->ltssm_shift) &
 		 LTSSM_STATE_MASK;
 
 	if (state < LTSSM_PCIE_L0)
@@ -146,13 +146,13 @@ static int ls_pcie_link_up(struct pcie_port *pp)
 
 static void ls_pcie_host_init(struct pcie_port *pp)
 {
-	struct ls_pcie *pcie = to_ls_pcie(pp);
+	struct ls_pcie *ls = to_ls_pcie(pp);
 
-	iowrite32(1, pcie->dbi + PCIE_DBI_RO_WR_EN);
-	ls_pcie_fix_class(pcie);
-	ls_pcie_clear_multifunction(pcie);
-	ls_pcie_drop_msg_tlp(pcie);
-	iowrite32(0, pcie->dbi + PCIE_DBI_RO_WR_EN);
+	iowrite32(1, ls->dbi + PCIE_DBI_RO_WR_EN);
+	ls_pcie_fix_class(ls);
+	ls_pcie_clear_multifunction(ls);
+	ls_pcie_drop_msg_tlp(ls);
+	iowrite32(0, ls->dbi + PCIE_DBI_RO_WR_EN);
 }
 
 static int ls_pcie_msi_host_init(struct pcie_port *pp,
@@ -216,11 +216,11 @@ static int __init ls_add_pcie_port(struct pcie_port *pp,
 				   struct platform_device *pdev)
 {
 	int ret;
-	struct ls_pcie *pcie = to_ls_pcie(pp);
+	struct ls_pcie *ls = to_ls_pcie(pp);
 
 	pp->dev = &pdev->dev;
-	pp->dbi_base = pcie->dbi;
-	pp->ops = pcie->drvdata->ops;
+	pp->dbi_base = ls->dbi;
+	pp->ops = ls->drvdata->ops;
 
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
@@ -234,7 +234,7 @@ static int __init ls_add_pcie_port(struct pcie_port *pp,
 static int __init ls_pcie_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
-	struct ls_pcie *pcie;
+	struct ls_pcie *ls;
 	struct resource *dbi_base;
 	int ret;
 
@@ -242,28 +242,28 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 	if (!match)
 		return -ENODEV;
 
-	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
-	if (!pcie)
+	ls = devm_kzalloc(&pdev->dev, sizeof(*ls), GFP_KERNEL);
+	if (!ls)
 		return -ENOMEM;
 
 	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
-	pcie->dbi = devm_ioremap_resource(&pdev->dev, dbi_base);
-	if (IS_ERR(pcie->dbi)) {
+	ls->dbi = devm_ioremap_resource(&pdev->dev, dbi_base);
+	if (IS_ERR(ls->dbi)) {
 		dev_err(&pdev->dev, "missing *regs* space\n");
-		return PTR_ERR(pcie->dbi);
+		return PTR_ERR(ls->dbi);
 	}
 
-	pcie->drvdata = match->data;
-	pcie->lut = pcie->dbi + pcie->drvdata->lut_offset;
+	ls->drvdata = match->data;
+	ls->lut = ls->dbi + ls->drvdata->lut_offset;
 
-	if (!ls_pcie_is_bridge(pcie))
+	if (!ls_pcie_is_bridge(ls))
 		return -ENODEV;
 
-	ret = ls_add_pcie_port(&pcie->pp, pdev);
+	ret = ls_add_pcie_port(&ls->pp, pdev);
 	if (ret < 0)
 		return ret;
 
-	platform_set_drvdata(pdev, pcie);
+	platform_set_drvdata(pdev, ls);
 
 	return 0;
 }
