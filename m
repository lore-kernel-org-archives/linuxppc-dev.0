Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3srFgB4j8MzDrSP
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Oct 2016 03:42:30 +1100 (AEDT)
Subject: [PATCH 5/7] PCI: layerscape: Add local struct device pointers
To: Minghuan Lian <minghuan.Lian@freescale.com>,
 Mingkai Hu <mingkai.hu@freescale.com>, Roy Zang <tie-fei.zang@freescale.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri, 07 Oct 2016 11:42:25 -0500
Message-ID: <20161007164225.26341.18734.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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

Use a local "struct device *dev" for brevity and consistency with other
drivers.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-layerscape.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index 8d10665..bf1ce11 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -105,18 +105,19 @@ static int ls1021_pcie_link_up(struct pcie_port *pp)
 
 static void ls1021_pcie_host_init(struct pcie_port *pp)
 {
+	struct device *dev = pp->dev;
 	struct ls_pcie *ls = to_ls_pcie(pp);
 	u32 index[2];
 
-	ls->scfg = syscon_regmap_lookup_by_phandle(pp->dev->of_node,
+	ls->scfg = syscon_regmap_lookup_by_phandle(dev->of_node,
 						   "fsl,pcie-scfg");
 	if (IS_ERR(ls->scfg)) {
-		dev_err(pp->dev, "No syscfg phandle specified\n");
+		dev_err(dev, "No syscfg phandle specified\n");
 		ls->scfg = NULL;
 		return;
 	}
 
-	if (of_property_read_u32_array(pp->dev->of_node,
+	if (of_property_read_u32_array(dev->of_node,
 				       "fsl,pcie-scfg", index, 2)) {
 		ls->scfg = NULL;
 		return;
@@ -231,23 +232,24 @@ static int __init ls_add_pcie_port(struct ls_pcie *ls,
 
 static int __init ls_pcie_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	const struct of_device_id *match;
 	struct ls_pcie *ls;
 	struct resource *dbi_base;
 	int ret;
 
-	match = of_match_device(ls_pcie_of_match, &pdev->dev);
+	match = of_match_device(ls_pcie_of_match, dev);
 	if (!match)
 		return -ENODEV;
 
-	ls = devm_kzalloc(&pdev->dev, sizeof(*ls), GFP_KERNEL);
+	ls = devm_kzalloc(dev, sizeof(*ls), GFP_KERNEL);
 	if (!ls)
 		return -ENOMEM;
 
 	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
-	ls->pp.dbi_base = devm_ioremap_resource(&pdev->dev, dbi_base);
+	ls->pp.dbi_base = devm_ioremap_resource(dev, dbi_base);
 	if (IS_ERR(ls->pp.dbi_base)) {
-		dev_err(&pdev->dev, "missing *regs* space\n");
+		dev_err(dev, "missing *regs* space\n");
 		return PTR_ERR(ls->pp.dbi_base);
 	}
 
