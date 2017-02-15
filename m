Return-Path: <kishon@ti.com>
Received: from lelnx194.ext.ti.com (lelnx194.ext.ti.com [198.47.27.80])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNfyL2NWhzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 00:19:20 +1100 (AEDT)
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@axis.com>
CC: <nsekhar@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 04/10] PCI: dwc: designware: Get device pointer at the start
 of dw_pcie_host_init
Date: Wed, 15 Feb 2017 18:48:13 +0530
Message-ID: <1487164699-30708-5-git-send-email-kishon@ti.com>
In-Reply-To: <1487164699-30708-1-git-send-email-kishon@ti.com>
References: <1487164699-30708-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

No functional change. Get device pointer at the beginning of
dw_pcie_host_init instead of getting it all over dw_pcie_host_init.
This is in preparation for splitting struct pcie_port into host and
core structures (Once split pcie_port will not have device pointer).

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/dwc/pcie-designware.c |   33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-designware.c
index de143ea..6e95291 100644
--- a/drivers/pci/dwc/pcie-designware.c
+++ b/drivers/pci/dwc/pcie-designware.c
@@ -446,8 +446,9 @@ static u8 dw_pcie_iatu_unroll_enabled(struct pcie_port *pp)
 
 int dw_pcie_host_init(struct pcie_port *pp)
 {
-	struct device_node *np = pp->dev->of_node;
-	struct platform_device *pdev = to_platform_device(pp->dev);
+	struct device *dev = pp->dev;
+	struct device_node *np = dev->of_node;
+	struct platform_device *pdev = to_platform_device(dev);
 	struct pci_bus *bus, *child;
 	struct resource *cfg_res;
 	int i, ret;
@@ -461,14 +462,14 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		pp->cfg0_base = cfg_res->start;
 		pp->cfg1_base = cfg_res->start + pp->cfg0_size;
 	} else if (!pp->va_cfg0_base) {
-		dev_err(pp->dev, "missing *config* reg space\n");
+		dev_err(dev, "missing *config* reg space\n");
 	}
 
 	ret = of_pci_get_host_bridge_resources(np, 0, 0xff, &res, &pp->io_base);
 	if (ret)
 		return ret;
 
-	ret = devm_request_pci_bus_resources(&pdev->dev, &res);
+	ret = devm_request_pci_bus_resources(dev, &res);
 	if (ret)
 		goto error;
 
@@ -478,7 +479,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		case IORESOURCE_IO:
 			ret = pci_remap_iospace(win->res, pp->io_base);
 			if (ret) {
-				dev_warn(pp->dev, "error %d: failed to map resource %pR\n",
+				dev_warn(dev, "error %d: failed to map resource %pR\n",
 					 ret, win->res);
 				resource_list_destroy_entry(win);
 			} else {
@@ -508,10 +509,10 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	}
 
 	if (!pp->dbi_base) {
-		pp->dbi_base = devm_ioremap(pp->dev, pp->cfg->start,
+		pp->dbi_base = devm_ioremap(dev, pp->cfg->start,
 					resource_size(pp->cfg));
 		if (!pp->dbi_base) {
-			dev_err(pp->dev, "error with ioremap\n");
+			dev_err(dev, "error with ioremap\n");
 			ret = -ENOMEM;
 			goto error;
 		}
@@ -520,20 +521,20 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	pp->mem_base = pp->mem->start;
 
 	if (!pp->va_cfg0_base) {
-		pp->va_cfg0_base = devm_ioremap(pp->dev, pp->cfg0_base,
+		pp->va_cfg0_base = devm_ioremap(dev, pp->cfg0_base,
 						pp->cfg0_size);
 		if (!pp->va_cfg0_base) {
-			dev_err(pp->dev, "error with ioremap in function\n");
+			dev_err(dev, "error with ioremap in function\n");
 			ret = -ENOMEM;
 			goto error;
 		}
 	}
 
 	if (!pp->va_cfg1_base) {
-		pp->va_cfg1_base = devm_ioremap(pp->dev, pp->cfg1_base,
+		pp->va_cfg1_base = devm_ioremap(dev, pp->cfg1_base,
 						pp->cfg1_size);
 		if (!pp->va_cfg1_base) {
-			dev_err(pp->dev, "error with ioremap\n");
+			dev_err(dev, "error with ioremap\n");
 			ret = -ENOMEM;
 			goto error;
 		}
@@ -549,11 +550,11 @@ int dw_pcie_host_init(struct pcie_port *pp)
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		if (!pp->ops->msi_host_init) {
-			pp->irq_domain = irq_domain_add_linear(pp->dev->of_node,
+			pp->irq_domain = irq_domain_add_linear(dev->of_node,
 						MAX_MSI_IRQS, &msi_domain_ops,
 						&dw_pcie_msi_chip);
 			if (!pp->irq_domain) {
-				dev_err(pp->dev, "irq domain init failed\n");
+				dev_err(dev, "irq domain init failed\n");
 				ret = -ENXIO;
 				goto error;
 			}
@@ -572,12 +573,12 @@ int dw_pcie_host_init(struct pcie_port *pp)
 
 	pp->root_bus_nr = pp->busn->start;
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		bus = pci_scan_root_bus_msi(pp->dev, pp->root_bus_nr,
+		bus = pci_scan_root_bus_msi(dev, pp->root_bus_nr,
 					    &dw_pcie_ops, pp, &res,
 					    &dw_pcie_msi_chip);
-		dw_pcie_msi_chip.dev = pp->dev;
+		dw_pcie_msi_chip.dev = dev;
 	} else
-		bus = pci_scan_root_bus(pp->dev, pp->root_bus_nr, &dw_pcie_ops,
+		bus = pci_scan_root_bus(dev, pp->root_bus_nr, &dw_pcie_ops,
 					pp, &res);
 	if (!bus) {
 		ret = -ENOMEM;
-- 
1.7.9.5
