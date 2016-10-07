Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3srFfv0hQxzDrPL
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Oct 2016 03:42:15 +1100 (AEDT)
Subject: [PATCH 3/7] PCI: layerscape: Remove redundant struct ls_pcie.dbi
To: Minghuan Lian <minghuan.Lian@freescale.com>,
 Mingkai Hu <mingkai.hu@freescale.com>, Roy Zang <tie-fei.zang@freescale.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri, 07 Oct 2016 11:42:09 -0500
Message-ID: <20161007164209.26341.61199.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007164149.26341.87049.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007164149.26341.87049.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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

Remove the struct ls_pcie.dbi member, which is a duplicate of the generic
pp.dbi_base member.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-layerscape.c |   24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index 85a90f1e..d69614c 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -45,7 +45,6 @@ struct ls_pcie_drvdata {
 };
 
 struct ls_pcie {
-	void __iomem *dbi;
 	void __iomem *lut;
 	struct regmap *scfg;
 	struct pcie_port pp;
@@ -59,7 +58,7 @@ static bool ls_pcie_is_bridge(struct ls_pcie *ls)
 {
 	u32 header_type;
 
-	header_type = ioread8(ls->dbi + PCI_HEADER_TYPE);
+	header_type = ioread8(ls->pp.dbi_base + PCI_HEADER_TYPE);
 	header_type &= 0x7f;
 
 	return header_type == PCI_HEADER_TYPE_BRIDGE;
@@ -68,13 +67,13 @@ static bool ls_pcie_is_bridge(struct ls_pcie *ls)
 /* Clear multi-function bit */
 static void ls_pcie_clear_multifunction(struct ls_pcie *ls)
 {
-	iowrite8(PCI_HEADER_TYPE_BRIDGE, ls->dbi + PCI_HEADER_TYPE);
+	iowrite8(PCI_HEADER_TYPE_BRIDGE, ls->pp.dbi_base + PCI_HEADER_TYPE);
 }
 
 /* Fix class value */
 static void ls_pcie_fix_class(struct ls_pcie *ls)
 {
-	iowrite16(PCI_CLASS_BRIDGE_PCI, ls->dbi + PCI_CLASS_DEVICE);
+	iowrite16(PCI_CLASS_BRIDGE_PCI, ls->pp.dbi_base + PCI_CLASS_DEVICE);
 }
 
 /* Drop MSG TLP except for Vendor MSG */
@@ -82,9 +81,9 @@ static void ls_pcie_drop_msg_tlp(struct ls_pcie *ls)
 {
 	u32 val;
 
-	val = ioread32(ls->dbi + PCIE_STRFMR1);
+	val = ioread32(ls->pp.dbi_base + PCIE_STRFMR1);
 	val &= 0xDFFFFFFF;
-	iowrite32(val, ls->dbi + PCIE_STRFMR1);
+	iowrite32(val, ls->pp.dbi_base + PCIE_STRFMR1);
 }
 
 static int ls1021_pcie_link_up(struct pcie_port *pp)
@@ -148,11 +147,11 @@ static void ls_pcie_host_init(struct pcie_port *pp)
 {
 	struct ls_pcie *ls = to_ls_pcie(pp);
 
-	iowrite32(1, ls->dbi + PCIE_DBI_RO_WR_EN);
+	iowrite32(1, ls->pp.dbi_base + PCIE_DBI_RO_WR_EN);
 	ls_pcie_fix_class(ls);
 	ls_pcie_clear_multifunction(ls);
 	ls_pcie_drop_msg_tlp(ls);
-	iowrite32(0, ls->dbi + PCIE_DBI_RO_WR_EN);
+	iowrite32(0, ls->pp.dbi_base + PCIE_DBI_RO_WR_EN);
 }
 
 static int ls_pcie_msi_host_init(struct pcie_port *pp,
@@ -219,7 +218,6 @@ static int __init ls_add_pcie_port(struct ls_pcie *ls,
 	int ret;
 
 	pp->dev = &pdev->dev;
-	pp->dbi_base = ls->dbi;
 	pp->ops = ls->drvdata->ops;
 
 	ret = dw_pcie_host_init(pp);
@@ -247,14 +245,14 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
-	ls->dbi = devm_ioremap_resource(&pdev->dev, dbi_base);
-	if (IS_ERR(ls->dbi)) {
+	ls->pp.dbi_base = devm_ioremap_resource(&pdev->dev, dbi_base);
+	if (IS_ERR(ls->pp.dbi_base)) {
 		dev_err(&pdev->dev, "missing *regs* space\n");
-		return PTR_ERR(ls->dbi);
+		return PTR_ERR(ls->pp.dbi_base);
 	}
 
 	ls->drvdata = match->data;
-	ls->lut = ls->dbi + ls->drvdata->lut_offset;
+	ls->lut = ls->pp.dbi_base + ls->drvdata->lut_offset;
 
 	if (!ls_pcie_is_bridge(ls))
 		return -ENODEV;
