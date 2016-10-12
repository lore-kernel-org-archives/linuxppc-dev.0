Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3svFmv4D4lzDswr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 00:57:51 +1100 (AEDT)
Subject: [PATCH v2 3/7] PCI: layerscape: Remove redundant struct ls_pcie.dbi
To: Minghuan Lian <minghuan.Lian@freescale.com>,
 Mingkai Hu <mingkai.hu@freescale.com>, Roy Zang <tie-fei.zang@freescale.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 12 Oct 2016 08:57:46 -0500
Message-ID: <20161012135746.29815.52124.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012135413.29815.75484.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012135413.29815.75484.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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
index ebed415..bdafe55 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -45,7 +45,6 @@ struct ls_pcie_drvdata {
 };
 
 struct ls_pcie {
-	void __iomem *dbi;
 	void __iomem *lut;
 	struct regmap *scfg;
 	struct pcie_port pp;
@@ -59,7 +58,7 @@ static bool ls_pcie_is_bridge(struct ls_pcie *pcie)
 {
 	u32 header_type;
 
-	header_type = ioread8(pcie->dbi + PCI_HEADER_TYPE);
+	header_type = ioread8(pcie->pp.dbi_base + PCI_HEADER_TYPE);
 	header_type &= 0x7f;
 
 	return header_type == PCI_HEADER_TYPE_BRIDGE;
@@ -68,13 +67,13 @@ static bool ls_pcie_is_bridge(struct ls_pcie *pcie)
 /* Clear multi-function bit */
 static void ls_pcie_clear_multifunction(struct ls_pcie *pcie)
 {
-	iowrite8(PCI_HEADER_TYPE_BRIDGE, pcie->dbi + PCI_HEADER_TYPE);
+	iowrite8(PCI_HEADER_TYPE_BRIDGE, pcie->pp.dbi_base + PCI_HEADER_TYPE);
 }
 
 /* Fix class value */
 static void ls_pcie_fix_class(struct ls_pcie *pcie)
 {
-	iowrite16(PCI_CLASS_BRIDGE_PCI, pcie->dbi + PCI_CLASS_DEVICE);
+	iowrite16(PCI_CLASS_BRIDGE_PCI, pcie->pp.dbi_base + PCI_CLASS_DEVICE);
 }
 
 /* Drop MSG TLP except for Vendor MSG */
@@ -82,9 +81,9 @@ static void ls_pcie_drop_msg_tlp(struct ls_pcie *pcie)
 {
 	u32 val;
 
-	val = ioread32(pcie->dbi + PCIE_STRFMR1);
+	val = ioread32(pcie->pp.dbi_base + PCIE_STRFMR1);
 	val &= 0xDFFFFFFF;
-	iowrite32(val, pcie->dbi + PCIE_STRFMR1);
+	iowrite32(val, pcie->pp.dbi_base + PCIE_STRFMR1);
 }
 
 static int ls1021_pcie_link_up(struct pcie_port *pp)
@@ -149,11 +148,11 @@ static void ls_pcie_host_init(struct pcie_port *pp)
 {
 	struct ls_pcie *pcie = to_ls_pcie(pp);
 
-	iowrite32(1, pcie->dbi + PCIE_DBI_RO_WR_EN);
+	iowrite32(1, pcie->pp.dbi_base + PCIE_DBI_RO_WR_EN);
 	ls_pcie_fix_class(pcie);
 	ls_pcie_clear_multifunction(pcie);
 	ls_pcie_drop_msg_tlp(pcie);
-	iowrite32(0, pcie->dbi + PCIE_DBI_RO_WR_EN);
+	iowrite32(0, pcie->pp.dbi_base + PCIE_DBI_RO_WR_EN);
 }
 
 static int ls_pcie_msi_host_init(struct pcie_port *pp,
@@ -222,7 +221,6 @@ static int __init ls_add_pcie_port(struct pcie_port *pp,
 	struct ls_pcie *pcie = to_ls_pcie(pp);
 
 	pp->dev = dev;
-	pp->dbi_base = pcie->dbi;
 	pp->ops = pcie->drvdata->ops;
 
 	ret = dw_pcie_host_init(pp);
@@ -251,14 +249,14 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
-	pcie->dbi = devm_ioremap_resource(dev, dbi_base);
-	if (IS_ERR(pcie->dbi)) {
+	pcie->pp.dbi_base = devm_ioremap_resource(dev, dbi_base);
+	if (IS_ERR(pcie->pp.dbi_base)) {
 		dev_err(dev, "missing *regs* space\n");
-		return PTR_ERR(pcie->dbi);
+		return PTR_ERR(pcie->pp.dbi_base);
 	}
 
 	pcie->drvdata = match->data;
-	pcie->lut = pcie->dbi + pcie->drvdata->lut_offset;
+	pcie->lut = pcie->pp.dbi_base + pcie->drvdata->lut_offset;
 
 	if (!ls_pcie_is_bridge(pcie))
 		return -ENODEV;
