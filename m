Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3svFmb5dZSzDsxR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 00:57:35 +1100 (AEDT)
Subject: [PATCH v2 1/7] PCI: layerscape: Add local struct device pointers
To: Minghuan Lian <minghuan.Lian@freescale.com>,
 Mingkai Hu <mingkai.hu@freescale.com>, Roy Zang <tie-fei.zang@freescale.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 12 Oct 2016 08:57:30 -0500
Message-ID: <20161012135730.29815.5926.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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

Use a local "struct device *dev" for brevity and consistency with other
drivers.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-layerscape.c |   26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index 114ba81..08b511e 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -106,18 +106,19 @@ static int ls1021_pcie_link_up(struct pcie_port *pp)
 
 static void ls1021_pcie_host_init(struct pcie_port *pp)
 {
+	struct device *dev = pp->dev;
 	struct ls_pcie *pcie = to_ls_pcie(pp);
 	u32 index[2];
 
-	pcie->scfg = syscon_regmap_lookup_by_phandle(pp->dev->of_node,
+	pcie->scfg = syscon_regmap_lookup_by_phandle(dev->of_node,
 						     "fsl,pcie-scfg");
 	if (IS_ERR(pcie->scfg)) {
-		dev_err(pp->dev, "No syscfg phandle specified\n");
+		dev_err(dev, "No syscfg phandle specified\n");
 		pcie->scfg = NULL;
 		return;
 	}
 
-	if (of_property_read_u32_array(pp->dev->of_node,
+	if (of_property_read_u32_array(dev->of_node,
 				       "fsl,pcie-scfg", index, 2)) {
 		pcie->scfg = NULL;
 		return;
@@ -158,8 +159,9 @@ static void ls_pcie_host_init(struct pcie_port *pp)
 static int ls_pcie_msi_host_init(struct pcie_port *pp,
 				 struct msi_controller *chip)
 {
+	struct device *dev = pp->dev;
+	struct device_node *np = dev->of_node;
 	struct device_node *msi_node;
-	struct device_node *np = pp->dev->of_node;
 
 	/*
 	 * The MSI domain is set by the generic of_msi_configure().  This
@@ -169,7 +171,7 @@ static int ls_pcie_msi_host_init(struct pcie_port *pp,
 	 */
 	msi_node = of_parse_phandle(np, "msi-parent", 0);
 	if (!msi_node) {
-		dev_err(pp->dev, "failed to find msi-parent\n");
+		dev_err(dev, "failed to find msi-parent\n");
 		return -EINVAL;
 	}
 
@@ -215,16 +217,17 @@ static const struct of_device_id ls_pcie_of_match[] = {
 static int __init ls_add_pcie_port(struct pcie_port *pp,
 				   struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	int ret;
 	struct ls_pcie *pcie = to_ls_pcie(pp);
 
-	pp->dev = &pdev->dev;
+	pp->dev = dev;
 	pp->dbi_base = pcie->dbi;
 	pp->ops = pcie->drvdata->ops;
 
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
-		dev_err(pp->dev, "failed to initialize host\n");
+		dev_err(dev, "failed to initialize host\n");
 		return ret;
 	}
 
@@ -233,23 +236,24 @@ static int __init ls_add_pcie_port(struct pcie_port *pp,
 
 static int __init ls_pcie_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	const struct of_device_id *match;
 	struct ls_pcie *pcie;
 	struct resource *dbi_base;
 	int ret;
 
-	match = of_match_device(ls_pcie_of_match, &pdev->dev);
+	match = of_match_device(ls_pcie_of_match, dev);
 	if (!match)
 		return -ENODEV;
 
-	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
+	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
 		return -ENOMEM;
 
 	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
-	pcie->dbi = devm_ioremap_resource(&pdev->dev, dbi_base);
+	pcie->dbi = devm_ioremap_resource(dev, dbi_base);
 	if (IS_ERR(pcie->dbi)) {
-		dev_err(&pdev->dev, "missing *regs* space\n");
+		dev_err(dev, "missing *regs* space\n");
 		return PTR_ERR(pcie->dbi);
 	}
 
