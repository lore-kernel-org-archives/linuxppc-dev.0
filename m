Return-Path: <kishon@ti.com>
Received: from fllnx209.ext.ti.com (fllnx209.ext.ti.com [198.47.19.16])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzkYz6QNtzDqVH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 22:49:11 +1100 (AEDT)
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@axis.com>, <linux-arm-msm@vger.kernel.org>,
 <nsekhar@ti.com>, <kishon@ti.com>
Subject: [PATCH 07/37] PCI: dwc: designware: Get device pointer at the start
 of dw_pcie_host_init
Date: Thu, 12 Jan 2017 15:55:56 +0530
Message-ID: <1484216786-17292-8-git-send-email-kishon@ti.com>
In-Reply-To: <1484216786-17292-1-git-send-email-kishon@ti.com>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
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
index d0ea310..330596b 100644
--- a/drivers/pci/dwc/pcie-designware.c
+++ b/drivers/pci/dwc/pcie-designware.c
@@ -449,8 +449,9 @@ static u8 dw_pcie_iatu_unroll_enabled(struct pcie_port *pp)
 
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
@@ -464,14 +465,14 @@ int dw_pcie_host_init(struct pcie_port *pp)
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
 
@@ -481,7 +482,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		case IORESOURCE_IO:
 			ret = pci_remap_iospace(win->res, pp->io_base);
 			if (ret) {
-				dev_warn(pp->dev, "error %d: failed to map resource %pR\n",
+				dev_warn(dev, "error %d: failed to map resource %pR\n",
 					 ret, win->res);
 				resource_list_destroy_entry(win);
 			} else {
@@ -511,10 +512,10 @@ int dw_pcie_host_init(struct pcie_port *pp)
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
@@ -523,20 +524,20 @@ int dw_pcie_host_init(struct pcie_port *pp)
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
@@ -552,11 +553,11 @@ int dw_pcie_host_init(struct pcie_port *pp)
 
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
@@ -575,12 +576,12 @@ int dw_pcie_host_init(struct pcie_port *pp)
 
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
