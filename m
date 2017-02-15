Return-Path: <kishon@ti.com>
Received: from fllnx210.ext.ti.com (fllnx210.ext.ti.com [198.47.19.17])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNfyM625YzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 00:19:23 +1100 (AEDT)
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@axis.com>
CC: <nsekhar@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Murali Karicheri
 <m-karicheri2@ti.com>, Joao Pinto <Joao.Pinto@synopsys.com>, Stanimir
 Varbanov <svarbanov@mm-sol.com>, Pratyush Anand <pratyush.anand@gmail.com>
Subject: [PATCH 03/10] PCI: dwc: *all*: Rename cfg_read/cfg_write to read/write
Date: Wed, 15 Feb 2017 18:48:12 +0530
Message-ID: <1487164699-30708-4-git-send-email-kishon@ti.com>
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

No functional change. dw_pcie_cfg_read/dw_pcie_cfg_write doesn't do
anything specific to access configuration space. It can be just renamed
to dw_pcie_read/dw_pcie_write and used to read/write data to dbi space.

Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Murali Karicheri <m-karicheri2@ti.com>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: Pratyush Anand <pratyush.anand@gmail.com>
Reviewed-By: Joao Pinto <jpinto@synopsys.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/dwc/pci-dra7xx.c      |   16 ++++++++--------
 drivers/pci/dwc/pci-exynos.c      |    4 ++--
 drivers/pci/dwc/pci-keystone-dw.c |    4 ++--
 drivers/pci/dwc/pcie-designware.c |   12 ++++++------
 drivers/pci/dwc/pcie-designware.h |    4 ++--
 drivers/pci/dwc/pcie-qcom.c       |    2 +-
 drivers/pci/dwc/pcie-spear13xx.c  |   24 ++++++++++++------------
 7 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index d1cd476..4b9b1e1 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -109,22 +109,22 @@ static int dra7xx_pcie_establish_link(struct dra7xx_pcie *dra7xx)
 	}
 
 	if (dra7xx->link_gen == 1) {
-		dw_pcie_cfg_read(pp->dbi_base + exp_cap_off + PCI_EXP_LNKCAP,
-				 4, &reg);
+		dw_pcie_read(pp->dbi_base + exp_cap_off + PCI_EXP_LNKCAP,
+			     4, &reg);
 		if ((reg & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
 			reg &= ~((u32)PCI_EXP_LNKCAP_SLS);
 			reg |= PCI_EXP_LNKCAP_SLS_2_5GB;
-			dw_pcie_cfg_write(pp->dbi_base + exp_cap_off +
-					  PCI_EXP_LNKCAP, 4, reg);
+			dw_pcie_write(pp->dbi_base + exp_cap_off +
+				      PCI_EXP_LNKCAP, 4, reg);
 		}
 
-		dw_pcie_cfg_read(pp->dbi_base + exp_cap_off + PCI_EXP_LNKCTL2,
-				 2, &reg);
+		dw_pcie_read(pp->dbi_base + exp_cap_off + PCI_EXP_LNKCTL2,
+			     2, &reg);
 		if ((reg & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
 			reg &= ~((u32)PCI_EXP_LNKCAP_SLS);
 			reg |= PCI_EXP_LNKCAP_SLS_2_5GB;
-			dw_pcie_cfg_write(pp->dbi_base + exp_cap_off +
-					  PCI_EXP_LNKCTL2, 2, reg);
+			dw_pcie_write(pp->dbi_base + exp_cap_off +
+				      PCI_EXP_LNKCTL2, 2, reg);
 		}
 	}
 
diff --git a/drivers/pci/dwc/pci-exynos.c b/drivers/pci/dwc/pci-exynos.c
index c179e7a..e3fbff4 100644
--- a/drivers/pci/dwc/pci-exynos.c
+++ b/drivers/pci/dwc/pci-exynos.c
@@ -429,7 +429,7 @@ static int exynos_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
 	int ret;
 
 	exynos_pcie_sideband_dbi_r_mode(exynos_pcie, true);
-	ret = dw_pcie_cfg_read(pp->dbi_base + where, size, val);
+	ret = dw_pcie_read(pp->dbi_base + where, size, val);
 	exynos_pcie_sideband_dbi_r_mode(exynos_pcie, false);
 	return ret;
 }
@@ -441,7 +441,7 @@ static int exynos_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
 	int ret;
 
 	exynos_pcie_sideband_dbi_w_mode(exynos_pcie, true);
-	ret = dw_pcie_cfg_write(pp->dbi_base + where, size, val);
+	ret = dw_pcie_write(pp->dbi_base + where, size, val);
 	exynos_pcie_sideband_dbi_w_mode(exynos_pcie, false);
 	return ret;
 }
diff --git a/drivers/pci/dwc/pci-keystone-dw.c b/drivers/pci/dwc/pci-keystone-dw.c
index 9397c46..4875334 100644
--- a/drivers/pci/dwc/pci-keystone-dw.c
+++ b/drivers/pci/dwc/pci-keystone-dw.c
@@ -444,7 +444,7 @@ int ks_dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 
 	addr = ks_pcie_cfg_setup(ks_pcie, bus_num, devfn);
 
-	return dw_pcie_cfg_read(addr + where, size, val);
+	return dw_pcie_read(addr + where, size, val);
 }
 
 int ks_dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
@@ -456,7 +456,7 @@ int ks_dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 
 	addr = ks_pcie_cfg_setup(ks_pcie, bus_num, devfn);
 
-	return dw_pcie_cfg_write(addr + where, size, val);
+	return dw_pcie_write(addr + where, size, val);
 }
 
 /**
diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-designware.c
index d0e4904..de143ea 100644
--- a/drivers/pci/dwc/pcie-designware.c
+++ b/drivers/pci/dwc/pcie-designware.c
@@ -33,7 +33,7 @@
 
 static struct pci_ops dw_pcie_ops;
 
-int dw_pcie_cfg_read(void __iomem *addr, int size, u32 *val)
+int dw_pcie_read(void __iomem *addr, int size, u32 *val)
 {
 	if ((uintptr_t)addr & (size - 1)) {
 		*val = 0;
@@ -54,7 +54,7 @@ int dw_pcie_cfg_read(void __iomem *addr, int size, u32 *val)
 	return PCIBIOS_SUCCESSFUL;
 }
 
-int dw_pcie_cfg_write(void __iomem *addr, int size, u32 val)
+int dw_pcie_write(void __iomem *addr, int size, u32 val)
 {
 	if ((uintptr_t)addr & (size - 1))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
@@ -108,7 +108,7 @@ static int dw_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
 	if (pp->ops->rd_own_conf)
 		return pp->ops->rd_own_conf(pp, where, size, val);
 
-	return dw_pcie_cfg_read(pp->dbi_base + where, size, val);
+	return dw_pcie_read(pp->dbi_base + where, size, val);
 }
 
 static int dw_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
@@ -117,7 +117,7 @@ static int dw_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
 	if (pp->ops->wr_own_conf)
 		return pp->ops->wr_own_conf(pp, where, size, val);
 
-	return dw_pcie_cfg_write(pp->dbi_base + where, size, val);
+	return dw_pcie_write(pp->dbi_base + where, size, val);
 }
 
 static void dw_pcie_prog_outbound_atu(struct pcie_port *pp, int index,
@@ -635,7 +635,7 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
 				  type, cpu_addr,
 				  busdev, cfg_size);
-	ret = dw_pcie_cfg_read(va_cfg_base + where, size, val);
+	ret = dw_pcie_read(va_cfg_base + where, size, val);
 	if (pp->num_viewport <= 2)
 		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
 					  PCIE_ATU_TYPE_IO, pp->io_base,
@@ -673,7 +673,7 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
 				  type, cpu_addr,
 				  busdev, cfg_size);
-	ret = dw_pcie_cfg_write(va_cfg_base + where, size, val);
+	ret = dw_pcie_write(va_cfg_base + where, size, val);
 	if (pp->num_viewport <= 2)
 		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
 					  PCIE_ATU_TYPE_IO, pp->io_base,
diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
index b5226d4..5b71b57 100644
--- a/drivers/pci/dwc/pcie-designware.h
+++ b/drivers/pci/dwc/pcie-designware.h
@@ -145,8 +145,8 @@ struct pcie_host_ops {
 
 u32 dw_pcie_readl_rc(struct pcie_port *pp, u32 reg);
 void dw_pcie_writel_rc(struct pcie_port *pp, u32 reg, u32 val);
-int dw_pcie_cfg_read(void __iomem *addr, int size, u32 *val);
-int dw_pcie_cfg_write(void __iomem *addr, int size, u32 val);
+int dw_pcie_read(void __iomem *addr, int size, u32 *val);
+int dw_pcie_write(void __iomem *addr, int size, u32 val);
 irqreturn_t dw_handle_msi_irq(struct pcie_port *pp);
 void dw_pcie_msi_init(struct pcie_port *pp);
 int dw_pcie_wait_for_link(struct pcie_port *pp);
diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
index 3f525cb..ac27b67 100644
--- a/drivers/pci/dwc/pcie-qcom.c
+++ b/drivers/pci/dwc/pcie-qcom.c
@@ -621,7 +621,7 @@ static int qcom_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
 		return PCIBIOS_SUCCESSFUL;
 	}
 
-	return dw_pcie_cfg_read(pp->dbi_base + where, size, val);
+	return dw_pcie_read(pp->dbi_base + where, size, val);
 }
 
 static struct pcie_host_ops qcom_pcie_dw_ops = {
diff --git a/drivers/pci/dwc/pcie-spear13xx.c b/drivers/pci/dwc/pcie-spear13xx.c
index 5970566..7acf91e 100644
--- a/drivers/pci/dwc/pcie-spear13xx.c
+++ b/drivers/pci/dwc/pcie-spear13xx.c
@@ -91,34 +91,34 @@ static int spear13xx_pcie_establish_link(struct spear13xx_pcie *spear13xx_pcie)
 	 * default value in capability register is 512 bytes. So force
 	 * it to 128 here.
 	 */
-	dw_pcie_cfg_read(pp->dbi_base + exp_cap_off + PCI_EXP_DEVCTL, 2, &val);
+	dw_pcie_read(pp->dbi_base + exp_cap_off + PCI_EXP_DEVCTL, 2, &val);
 	val &= ~PCI_EXP_DEVCTL_READRQ;
-	dw_pcie_cfg_write(pp->dbi_base + exp_cap_off + PCI_EXP_DEVCTL, 2, val);
+	dw_pcie_write(pp->dbi_base + exp_cap_off + PCI_EXP_DEVCTL, 2, val);
 
-	dw_pcie_cfg_write(pp->dbi_base + PCI_VENDOR_ID, 2, 0x104A);
-	dw_pcie_cfg_write(pp->dbi_base + PCI_DEVICE_ID, 2, 0xCD80);
+	dw_pcie_write(pp->dbi_base + PCI_VENDOR_ID, 2, 0x104A);
+	dw_pcie_write(pp->dbi_base + PCI_DEVICE_ID, 2, 0xCD80);
 
 	/*
 	 * if is_gen1 is set then handle it, so that some buggy card
 	 * also works
 	 */
 	if (spear13xx_pcie->is_gen1) {
-		dw_pcie_cfg_read(pp->dbi_base + exp_cap_off + PCI_EXP_LNKCAP,
-					4, &val);
+		dw_pcie_read(pp->dbi_base + exp_cap_off + PCI_EXP_LNKCAP,
+			     4, &val);
 		if ((val & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
 			val &= ~((u32)PCI_EXP_LNKCAP_SLS);
 			val |= PCI_EXP_LNKCAP_SLS_2_5GB;
-			dw_pcie_cfg_write(pp->dbi_base + exp_cap_off +
-				PCI_EXP_LNKCAP, 4, val);
+			dw_pcie_write(pp->dbi_base + exp_cap_off +
+				      PCI_EXP_LNKCAP, 4, val);
 		}
 
-		dw_pcie_cfg_read(pp->dbi_base + exp_cap_off + PCI_EXP_LNKCTL2,
-					2, &val);
+		dw_pcie_read(pp->dbi_base + exp_cap_off + PCI_EXP_LNKCTL2,
+			     2, &val);
 		if ((val & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
 			val &= ~((u32)PCI_EXP_LNKCAP_SLS);
 			val |= PCI_EXP_LNKCAP_SLS_2_5GB;
-			dw_pcie_cfg_write(pp->dbi_base + exp_cap_off +
-					PCI_EXP_LNKCTL2, 2, val);
+			dw_pcie_write(pp->dbi_base + exp_cap_off +
+				      PCI_EXP_LNKCTL2, 2, val);
 		}
 	}
 
-- 
1.7.9.5
