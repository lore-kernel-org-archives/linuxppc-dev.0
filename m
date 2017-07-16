Return-Path: <bjorn.andersson@linaro.org>
Received: from mail-pg0-x232.google.com (mail-pg0-x232.google.com
 [IPv6:2607:f8b0:400e:c05::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x9Gxn1kdhzDr34
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Jul 2017 16:39:56 +1000 (AEST)
Received: by mail-pg0-x232.google.com with SMTP id k14so64331722pgr.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jul 2017 23:39:56 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Kishon Vijay Abraham I <kishon@ti.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
 Murali Karicheri <m-karicheri2@ti.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Mingkai Hu <mingkai.hu@freescale.com>,
 Roy Zang <tie-fei.zang@freescale.com>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Niklas Cassel <niklas.cassel@axis.com>,
 Jesper Nilsson <jesper.nilsson@axis.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>,
 Xiaowei Song <songxiaowei@hisilicon.com>,
 Binghui Wang <wangbinghui@hisilicon.com>,
 Stanimir Varbanov <svarbanov@mm-sol.com>,
 Pratyush Anand <pratyush.anand@gmail.com>
Cc: linux-omap@vger.kernel.org (open list:PCI DRIVER FOR TI DRA7XX),
 linux-pci@vger.kernel.org (open list:PCI DRIVER FOR TI DRA7XX),
 linux-kernel@vger.kernel.org (open list),
 linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR SAMSUNG
 EXYNOS),
 linux-samsung-soc@vger.kernel.org (moderated list:PCI DRIVER FOR SAMSUNG
 EXYNOS),
 linuxppc-dev@lists.ozlabs.org (open list:PCI DRIVER FOR FREESCALE LAYERSCAPE),
 linux-arm-kernel@axis.com (open list:PCIE DRIVER FOR AXIS ARTPEC),
 linux-arm-msm@vger.kernel.org (open list:PCIE DRIVER FOR QUALCOMM MSM)
Subject: [PATCH 1/3] PCI: dwc: Handle host_init failures
Date: Sat, 15 Jul 2017 23:39:45 -0700
Message-Id: <20170716063947.3272-1-bjorn.andersson@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In several dwc based drivers host_init can fail, so make sure to
propagate and handle this to avoid continuing operation of a driver or
hardware in an invalid state.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/pci/dwc/pci-dra7xx.c           |  4 +++-
 drivers/pci/dwc/pci-exynos.c           |  4 +++-
 drivers/pci/dwc/pci-imx6.c             |  4 +++-
 drivers/pci/dwc/pci-keystone.c         |  4 +++-
 drivers/pci/dwc/pci-layerscape.c       | 14 ++++++++++----
 drivers/pci/dwc/pcie-armada8k.c        |  4 +++-
 drivers/pci/dwc/pcie-artpec6.c         |  4 +++-
 drivers/pci/dwc/pcie-designware-host.c |  7 +++++--
 drivers/pci/dwc/pcie-designware-plat.c |  4 +++-
 drivers/pci/dwc/pcie-designware.h      |  2 +-
 drivers/pci/dwc/pcie-kirin.c           |  4 +++-
 drivers/pci/dwc/pcie-qcom.c            |  6 ++++--
 drivers/pci/dwc/pcie-spear13xx.c       |  4 +++-
 13 files changed, 47 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index f2fc5f47064e..e8c13bb76169 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -195,7 +195,7 @@ static void dra7xx_pcie_enable_interrupts(struct dra7xx_pcie *dra7xx)
 	dra7xx_pcie_enable_msi_interrupts(dra7xx);
 }
 
-static void dra7xx_pcie_host_init(struct pcie_port *pp)
+static int dra7xx_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
@@ -206,6 +206,8 @@ static void dra7xx_pcie_host_init(struct pcie_port *pp)
 	dw_pcie_wait_for_link(pci);
 	dw_pcie_msi_init(pp);
 	dra7xx_pcie_enable_interrupts(dra7xx);
+
+	return 0;
 }
 
 static const struct dw_pcie_host_ops dra7xx_pcie_host_ops = {
diff --git a/drivers/pci/dwc/pci-exynos.c b/drivers/pci/dwc/pci-exynos.c
index c78c06552590..f77f872e8b78 100644
--- a/drivers/pci/dwc/pci-exynos.c
+++ b/drivers/pci/dwc/pci-exynos.c
@@ -581,13 +581,15 @@ static int exynos_pcie_link_up(struct dw_pcie *pci)
 	return 0;
 }
 
-static void exynos_pcie_host_init(struct pcie_port *pp)
+static int exynos_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct exynos_pcie *ep = to_exynos_pcie(pci);
 
 	exynos_pcie_establish_link(ep);
 	exynos_pcie_enable_interrupts(ep);
+
+	return 0;
 }
 
 static const struct dw_pcie_host_ops exynos_pcie_host_ops = {
diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c
index bf5c3616e344..20aae4469ee4 100644
--- a/drivers/pci/dwc/pci-imx6.c
+++ b/drivers/pci/dwc/pci-imx6.c
@@ -636,7 +636,7 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 	return ret;
 }
 
-static void imx6_pcie_host_init(struct pcie_port *pp)
+static int imx6_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
@@ -649,6 +649,8 @@ static void imx6_pcie_host_init(struct pcie_port *pp)
 
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		dw_pcie_msi_init(pp);
+
+	return 0;
 }
 
 static int imx6_pcie_link_up(struct dw_pcie *pci)
diff --git a/drivers/pci/dwc/pci-keystone.c b/drivers/pci/dwc/pci-keystone.c
index 4783cec1f78d..3ad3f8aa27b0 100644
--- a/drivers/pci/dwc/pci-keystone.c
+++ b/drivers/pci/dwc/pci-keystone.c
@@ -261,7 +261,7 @@ static int keystone_pcie_fault(unsigned long addr, unsigned int fsr,
 	return 0;
 }
 
-static void __init ks_pcie_host_init(struct pcie_port *pp)
+static int __init ks_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
@@ -289,6 +289,8 @@ static void __init ks_pcie_host_init(struct pcie_port *pp)
 	 */
 	hook_fault_code(17, keystone_pcie_fault, SIGBUS, 0,
 			"Asynchronous external abort");
+
+	return 0;
 }
 
 static const struct dw_pcie_host_ops keystone_pcie_host_ops = {
diff --git a/drivers/pci/dwc/pci-layerscape.c b/drivers/pci/dwc/pci-layerscape.c
index fd861289ad8b..7581490f007c 100644
--- a/drivers/pci/dwc/pci-layerscape.c
+++ b/drivers/pci/dwc/pci-layerscape.c
@@ -108,31 +108,35 @@ static int ls1021_pcie_link_up(struct dw_pcie *pci)
 	return 1;
 }
 
-static void ls1021_pcie_host_init(struct pcie_port *pp)
+static int ls1021_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct ls_pcie *pcie = to_ls_pcie(pci);
 	struct device *dev = pci->dev;
 	u32 index[2];
+	int ret;
 
 	pcie->scfg = syscon_regmap_lookup_by_phandle(dev->of_node,
 						     "fsl,pcie-scfg");
 	if (IS_ERR(pcie->scfg)) {
+		ret = PTR_ERR(pcie->scfg);
 		dev_err(dev, "No syscfg phandle specified\n");
 		pcie->scfg = NULL;
-		return;
+		return ret;
 	}
 
 	if (of_property_read_u32_array(dev->of_node,
 				       "fsl,pcie-scfg", index, 2)) {
 		pcie->scfg = NULL;
-		return;
+		return -EINVAL;
 	}
 	pcie->index = index[1];
 
 	dw_pcie_setup_rc(pp);
 
 	ls_pcie_drop_msg_tlp(pcie);
+
+	return 0;
 }
 
 static int ls_pcie_link_up(struct dw_pcie *pci)
@@ -150,7 +154,7 @@ static int ls_pcie_link_up(struct dw_pcie *pci)
 	return 1;
 }
 
-static void ls_pcie_host_init(struct pcie_port *pp)
+static int ls_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct ls_pcie *pcie = to_ls_pcie(pci);
@@ -160,6 +164,8 @@ static void ls_pcie_host_init(struct pcie_port *pp)
 	ls_pcie_clear_multifunction(pcie);
 	ls_pcie_drop_msg_tlp(pcie);
 	iowrite32(0, pci->dbi_base + PCIE_DBI_RO_WR_EN);
+
+	return 0;
 }
 
 static int ls_pcie_msi_host_init(struct pcie_port *pp,
diff --git a/drivers/pci/dwc/pcie-armada8k.c b/drivers/pci/dwc/pcie-armada8k.c
index ea8f34af6a85..017a727a68db 100644
--- a/drivers/pci/dwc/pcie-armada8k.c
+++ b/drivers/pci/dwc/pcie-armada8k.c
@@ -134,13 +134,15 @@ static void armada8k_pcie_establish_link(struct armada8k_pcie *pcie)
 		dev_err(pci->dev, "Link not up after reconfiguration\n");
 }
 
-static void armada8k_pcie_host_init(struct pcie_port *pp)
+static int armada8k_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct armada8k_pcie *pcie = to_armada8k_pcie(pci);
 
 	dw_pcie_setup_rc(pp);
 	armada8k_pcie_establish_link(pcie);
+
+	return 0;
 }
 
 static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
diff --git a/drivers/pci/dwc/pcie-artpec6.c b/drivers/pci/dwc/pcie-artpec6.c
index 01c6f7823672..5d81f1d884e3 100644
--- a/drivers/pci/dwc/pcie-artpec6.c
+++ b/drivers/pci/dwc/pcie-artpec6.c
@@ -175,13 +175,15 @@ static void artpec6_pcie_enable_interrupts(struct artpec6_pcie *artpec6_pcie)
 		dw_pcie_msi_init(pp);
 }
 
-static void artpec6_pcie_host_init(struct pcie_port *pp)
+static int artpec6_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct artpec6_pcie *artpec6_pcie = to_artpec6_pcie(pci);
 
 	artpec6_pcie_establish_link(artpec6_pcie);
 	artpec6_pcie_enable_interrupts(artpec6_pcie);
+
+	return 0;
 }
 
 static const struct dw_pcie_host_ops artpec6_pcie_host_ops = {
diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
index d29c020da082..157621175147 100644
--- a/drivers/pci/dwc/pcie-designware-host.c
+++ b/drivers/pci/dwc/pcie-designware-host.c
@@ -401,8 +401,11 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		}
 	}
 
-	if (pp->ops->host_init)
-		pp->ops->host_init(pp);
+	if (pp->ops->host_init) {
+		ret = pp->ops->host_init(pp);
+		if (ret)
+			goto error;
+	}
 
 	pp->root_bus_nr = pp->busn->start;
 
diff --git a/drivers/pci/dwc/pcie-designware-plat.c b/drivers/pci/dwc/pcie-designware-plat.c
index 091b4e7ad059..168e2380f493 100644
--- a/drivers/pci/dwc/pcie-designware-plat.c
+++ b/drivers/pci/dwc/pcie-designware-plat.c
@@ -35,7 +35,7 @@ static irqreturn_t dw_plat_pcie_msi_irq_handler(int irq, void *arg)
 	return dw_handle_msi_irq(pp);
 }
 
-static void dw_plat_pcie_host_init(struct pcie_port *pp)
+static int dw_plat_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
@@ -44,6 +44,8 @@ static void dw_plat_pcie_host_init(struct pcie_port *pp)
 
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		dw_pcie_msi_init(pp);
+
+	return 0;
 }
 
 static const struct dw_pcie_host_ops dw_plat_pcie_host_ops = {
diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
index b4d2a89f8e58..7366c8167404 100644
--- a/drivers/pci/dwc/pcie-designware.h
+++ b/drivers/pci/dwc/pcie-designware.h
@@ -134,7 +134,7 @@ struct dw_pcie_host_ops {
 			     unsigned int devfn, int where, int size, u32 *val);
 	int (*wr_other_conf)(struct pcie_port *pp, struct pci_bus *bus,
 			     unsigned int devfn, int where, int size, u32 val);
-	void (*host_init)(struct pcie_port *pp);
+	int (*host_init)(struct pcie_port *pp);
 	void (*msi_set_irq)(struct pcie_port *pp, int irq);
 	void (*msi_clear_irq)(struct pcie_port *pp, int irq);
 	phys_addr_t (*get_msi_addr)(struct pcie_port *pp);
diff --git a/drivers/pci/dwc/pcie-kirin.c b/drivers/pci/dwc/pcie-kirin.c
index 33fddb9f6739..0b0eb67f2658 100644
--- a/drivers/pci/dwc/pcie-kirin.c
+++ b/drivers/pci/dwc/pcie-kirin.c
@@ -430,9 +430,11 @@ static int kirin_pcie_establish_link(struct pcie_port *pp)
 	return 0;
 }
 
-static void kirin_pcie_host_init(struct pcie_port *pp)
+static int kirin_pcie_host_init(struct pcie_port *pp)
 {
 	kirin_pcie_establish_link(pp);
+
+	return 0;
 }
 
 static struct dw_pcie_ops kirin_dw_pcie_ops = {
diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
index 68c5f2ab5bc8..d15657dc3990 100644
--- a/drivers/pci/dwc/pcie-qcom.c
+++ b/drivers/pci/dwc/pcie-qcom.c
@@ -891,7 +891,7 @@ static int qcom_pcie_link_up(struct dw_pcie *pci)
 	return !!(val & PCI_EXP_LNKSTA_DLLLA);
 }
 
-static void qcom_pcie_host_init(struct pcie_port *pp)
+static int qcom_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
@@ -921,12 +921,14 @@ static void qcom_pcie_host_init(struct pcie_port *pp)
 	if (ret)
 		goto err;
 
-	return;
+	return 0;
 err:
 	qcom_ep_reset_assert(pcie);
 	phy_power_off(pcie->phy);
 err_deinit:
 	pcie->ops->deinit(pcie);
+
+	return ret;
 }
 
 static int qcom_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
diff --git a/drivers/pci/dwc/pcie-spear13xx.c b/drivers/pci/dwc/pcie-spear13xx.c
index 80897291e0fb..52000bc34600 100644
--- a/drivers/pci/dwc/pcie-spear13xx.c
+++ b/drivers/pci/dwc/pcie-spear13xx.c
@@ -177,13 +177,15 @@ static int spear13xx_pcie_link_up(struct dw_pcie *pci)
 	return 0;
 }
 
-static void spear13xx_pcie_host_init(struct pcie_port *pp)
+static int spear13xx_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct spear13xx_pcie *spear13xx_pcie = to_spear13xx_pcie(pci);
 
 	spear13xx_pcie_establish_link(spear13xx_pcie);
 	spear13xx_pcie_enable_interrupts(spear13xx_pcie);
+
+	return 0;
 }
 
 static const struct dw_pcie_host_ops spear13xx_pcie_host_ops = {
-- 
2.12.0
