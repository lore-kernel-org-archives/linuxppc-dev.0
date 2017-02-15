Return-Path: <kishon@ti.com>
Received: from lelnx193.ext.ti.com (lelnx193.ext.ti.com [198.47.27.77])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNfyc2FcqzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 00:19:35 +1100 (AEDT)
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@axis.com>
CC: <nsekhar@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 07/10] PCI: dwc: designware: Fix style errors in
 pcie-designware.c
Date: Wed, 15 Feb 2017 18:48:16 +0530
Message-ID: <1487164699-30708-8-git-send-email-kishon@ti.com>
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

No functional change. Fix all checkpatch warnings and check errors
in pcie-designware.c

Acked-By: Joao Pinto <jpinto@synopsys.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/dwc/pcie-designware.c |   42 ++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-designware.c
index 237da48..622d416 100644
--- a/drivers/pci/dwc/pcie-designware.c
+++ b/drivers/pci/dwc/pcie-designware.c
@@ -40,13 +40,13 @@ int dw_pcie_read(void __iomem *addr, int size, u32 *val)
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 	}
 
-	if (size == 4)
+	if (size == 4) {
 		*val = readl(addr);
-	else if (size == 2)
+	} else if (size == 2) {
 		*val = readw(addr);
-	else if (size == 1)
+	} else if (size == 1) {
 		*val = readb(addr);
-	else {
+	} else {
 		*val = 0;
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 	}
@@ -200,16 +200,15 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
 
 	for (i = 0; i < MAX_MSI_CTRLS; i++) {
 		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_STATUS + i * 12, 4,
-				(u32 *)&val);
+				    (u32 *)&val);
 		if (val) {
 			ret = IRQ_HANDLED;
 			pos = 0;
 			while ((pos = find_next_bit(&val, 32, pos)) != 32) {
 				irq = irq_find_mapping(pp->irq_domain,
-						i * 32 + pos);
-				dw_pcie_wr_own_conf(pp,
-						PCIE_MSI_INTR0_STATUS + i * 12,
-						4, 1 << pos);
+						       i * 32 + pos);
+				dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS +
+						    i * 12, 4, 1 << pos);
 				generic_handle_irq(irq);
 				pos++;
 			}
@@ -275,8 +274,9 @@ static void dw_pcie_msi_set_irq(struct pcie_port *pp, int irq)
 static int assign_irq(int no_irqs, struct msi_desc *desc, int *pos)
 {
 	int irq, pos0, i;
-	struct pcie_port *pp = (struct pcie_port *) msi_desc_to_pci_sysdata(desc);
+	struct pcie_port *pp;
 
+	pp  = (struct pcie_port *)msi_desc_to_pci_sysdata(desc);
 	pos0 = bitmap_find_free_region(pp->msi_irq_in_use, MAX_MSI_IRQS,
 				       order_base_2(no_irqs));
 	if (pos0 < 0)
@@ -338,7 +338,7 @@ static void dw_msi_setup_msg(struct pcie_port *pp, unsigned int irq, u32 pos)
 }
 
 static int dw_msi_setup_irq(struct msi_controller *chip, struct pci_dev *pdev,
-			struct msi_desc *desc)
+			    struct msi_desc *desc)
 {
 	int irq, pos;
 	struct pcie_port *pp = pdev->bus->sysdata;
@@ -386,7 +386,7 @@ static void dw_msi_teardown_irq(struct msi_controller *chip, unsigned int irq)
 {
 	struct irq_data *data = irq_get_irq_data(irq);
 	struct msi_desc *msi = irq_data_get_msi_desc(data);
-	struct pcie_port *pp = (struct pcie_port *) msi_desc_to_pci_sysdata(msi);
+	struct pcie_port *pp = (struct pcie_port *)msi_desc_to_pci_sysdata(msi);
 
 	clear_irq_range(pp, irq, 1, data->hwirq);
 }
@@ -428,7 +428,7 @@ int dw_pcie_link_up(struct dw_pcie *pci)
 }
 
 static int dw_pcie_msi_map(struct irq_domain *domain, unsigned int irq,
-			irq_hw_number_t hwirq)
+			   irq_hw_number_t hwirq)
 {
 	irq_set_chip_and_handler(irq, &dw_msi_irq_chip, handle_simple_irq);
 	irq_set_chip_data(irq, domain->host_data);
@@ -465,8 +465,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
 
 	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
 	if (cfg_res) {
-		pp->cfg0_size = resource_size(cfg_res)/2;
-		pp->cfg1_size = resource_size(cfg_res)/2;
+		pp->cfg0_size = resource_size(cfg_res) / 2;
+		pp->cfg1_size = resource_size(cfg_res) / 2;
 		pp->cfg0_base = cfg_res->start;
 		pp->cfg1_base = cfg_res->start + pp->cfg0_size;
 	} else if (!pp->va_cfg0_base) {
@@ -505,8 +505,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			break;
 		case 0:
 			pp->cfg = win->res;
-			pp->cfg0_size = resource_size(pp->cfg)/2;
-			pp->cfg1_size = resource_size(pp->cfg)/2;
+			pp->cfg0_size = resource_size(pp->cfg) / 2;
+			pp->cfg1_size = resource_size(pp->cfg) / 2;
 			pp->cfg0_base = pp->cfg->start;
 			pp->cfg1_base = pp->cfg->start + pp->cfg0_size;
 			break;
@@ -612,7 +612,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 }
 
 static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
-		u32 devfn, int where, int size, u32 *val)
+				 u32 devfn, int where, int size, u32 *val)
 {
 	int ret, type;
 	u32 busdev, cfg_size;
@@ -651,7 +651,7 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 }
 
 static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
-		u32 devfn, int where, int size, u32 val)
+				 u32 devfn, int where, int size, u32 val)
 {
 	int ret, type;
 	u32 busdev, cfg_size;
@@ -708,7 +708,7 @@ static int dw_pcie_valid_device(struct pcie_port *pp, struct pci_bus *bus,
 }
 
 static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
-			int size, u32 *val)
+			   int size, u32 *val)
 {
 	struct pcie_port *pp = bus->sysdata;
 
@@ -724,7 +724,7 @@ static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 }
 
 static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
-			int where, int size, u32 val)
+			   int where, int size, u32 val)
 {
 	struct pcie_port *pp = bus->sysdata;
 
-- 
1.7.9.5
