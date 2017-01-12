Return-Path: <kishon@ti.com>
Received: from lelnx194.ext.ti.com (lelnx194.ext.ti.com [198.47.27.80])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzm3s0VyBzDqmb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 23:56:40 +1100 (AEDT)
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@axis.com>, <linux-arm-msm@vger.kernel.org>,
 <nsekhar@ti.com>, <kishon@ti.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>,
 Murali Karicheri <m-karicheri2@ti.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>, Mingkai Hu
 <mingkai.hu@freescale.com>, Roy Zang <tie-fei.zang@freescale.com>, Thomas
 Petazzoni <thomas.petazzoni@free-electrons.com>, Niklas Cassel
 <niklas.cassel@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>,
 Zhou Wang <wangzhou1@hisilicon.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Stanimir Varbanov <svarbanov@mm-sol.com>, Pratyush Anand
 <pratyush.anand@gmail.com>
Subject: [RFT PATCH 08/37] PCI: dwc: Split *struct pcie_port* into host only
 and core structures
Date: Thu, 12 Jan 2017 15:55:57 +0530
Message-ID: <1484216786-17292-9-git-send-email-kishon@ti.com>
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

Keep only the host specific members in *struct pcie_port* and
move the common members (i.e common to both host and endpoint)
to *struct dw_pcie*. This is in preparation for adding endpoint
mode support to designware driver.

While at that also fix checkpatch warnings.

Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Murali Karicheri <m-karicheri2@ti.com>
Cc: Minghuan Lian <minghuan.Lian@freescale.com>
Cc: Mingkai Hu <mingkai.hu@freescale.com>
Cc: Roy Zang <tie-fei.zang@freescale.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Niklas Cassel <niklas.cassel@axis.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Zhou Wang <wangzhou1@hisilicon.com>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: Pratyush Anand <pratyush.anand@gmail.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
I've pushed the series to
git://git.ti.com/linux-phy/linux-phy.git pci_ep_v1

I have access to only dra7 based boards, so I was able to test only
that. Testing in other plaforms would be highly appreciated.

 drivers/pci/dwc/pci-dra7xx.c           |   76 +++++++-----
 drivers/pci/dwc/pci-exynos.c           |   78 +++++++-----
 drivers/pci/dwc/pci-imx6.c             |  128 ++++++++++----------
 drivers/pci/dwc/pci-keystone-dw.c      |   83 +++++++------
 drivers/pci/dwc/pci-keystone.c         |   54 +++++----
 drivers/pci/dwc/pci-keystone.h         |    4 +-
 drivers/pci/dwc/pci-layerscape.c       |   91 +++++++++-----
 drivers/pci/dwc/pcie-armada8k.c        |   85 +++++++------
 drivers/pci/dwc/pcie-artpec6.c         |   48 ++++----
 drivers/pci/dwc/pcie-designware-plat.c |   27 +++--
 drivers/pci/dwc/pcie-designware.c      |  203 +++++++++++++++++---------------
 drivers/pci/dwc/pcie-designware.h      |   69 ++++++-----
 drivers/pci/dwc/pcie-hisi.c            |   55 +++++----
 drivers/pci/dwc/pcie-qcom.c            |   70 +++++++----
 drivers/pci/dwc/pcie-spear13xx.c       |   74 +++++++-----
 15 files changed, 665 insertions(+), 480 deletions(-)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index 38b0c9a..3c525b0 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -67,7 +67,7 @@
 #define EXP_CAP_ID_OFFSET				0x70
 
 struct dra7xx_pcie {
-	struct pcie_port	pp;
+	struct dw_pcie		*pci;
 	void __iomem		*base;		/* DT ti_conf */
 	int			phy_count;	/* DT phy-names count */
 	struct phy		**phy;
@@ -75,7 +75,7 @@ struct dra7xx_pcie {
 	struct irq_domain	*irq_domain;
 };
 
-#define to_dra7xx_pcie(x)	container_of((x), struct dra7xx_pcie, pp)
+#define to_dra7xx_pcie(x)	dev_get_drvdata((x)->dev)
 
 static inline u32 dra7xx_pcie_readl(struct dra7xx_pcie *pcie, u32 offset)
 {
@@ -93,9 +93,9 @@ static u64 dra7xx_pcie_cpu_addr_fixup(u64 pci_addr)
 	return pci_addr & DRA7XX_CPU_TO_BUS_ADDR;
 }
 
-static int dra7xx_pcie_link_up(struct pcie_port *pp)
+static int dra7xx_pcie_link_up(struct dw_pcie *pci)
 {
-	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pp);
+	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
 	u32 reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_PHY_CS);
 
 	return !!(reg & LINK_UP);
@@ -103,32 +103,32 @@ static int dra7xx_pcie_link_up(struct pcie_port *pp)
 
 static int dra7xx_pcie_establish_link(struct dra7xx_pcie *dra7xx)
 {
-	struct pcie_port *pp = &dra7xx->pp;
-	struct device *dev = pp->dev;
+	struct dw_pcie *pci = dra7xx->pci;
+	struct device *dev = pci->dev;
 	u32 reg;
 	u32 exp_cap_off = EXP_CAP_ID_OFFSET;
 
-	if (dw_pcie_link_up(pp)) {
+	if (dw_pcie_link_up(pci)) {
 		dev_err(dev, "link is already up\n");
 		return 0;
 	}
 
 	if (dra7xx->link_gen == 1) {
-		dw_pcie_read(pp->dbi_base + exp_cap_off + PCI_EXP_LNKCAP,
+		dw_pcie_read(pci->dbi_base + exp_cap_off + PCI_EXP_LNKCAP,
 			     4, &reg);
 		if ((reg & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
 			reg &= ~((u32)PCI_EXP_LNKCAP_SLS);
 			reg |= PCI_EXP_LNKCAP_SLS_2_5GB;
-			dw_pcie_write(pp->dbi_base + exp_cap_off +
+			dw_pcie_write(pci->dbi_base + exp_cap_off +
 				      PCI_EXP_LNKCAP, 4, reg);
 		}
 
-		dw_pcie_read(pp->dbi_base + exp_cap_off + PCI_EXP_LNKCTL2,
+		dw_pcie_read(pci->dbi_base + exp_cap_off + PCI_EXP_LNKCTL2,
 			     2, &reg);
 		if ((reg & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
 			reg &= ~((u32)PCI_EXP_LNKCAP_SLS);
 			reg |= PCI_EXP_LNKCAP_SLS_2_5GB;
-			dw_pcie_write(pp->dbi_base + exp_cap_off +
+			dw_pcie_write(pci->dbi_base + exp_cap_off +
 				      PCI_EXP_LNKCTL2, 2, reg);
 		}
 	}
@@ -137,7 +137,7 @@ static int dra7xx_pcie_establish_link(struct dra7xx_pcie *dra7xx)
 	reg |= LTSSM_EN;
 	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD, reg);
 
-	return dw_pcie_wait_for_link(pp);
+	return dw_pcie_wait_for_link(pci);
 }
 
 static void dra7xx_pcie_enable_interrupts(struct dra7xx_pcie *dra7xx)
@@ -154,7 +154,8 @@ static void dra7xx_pcie_enable_interrupts(struct dra7xx_pcie *dra7xx)
 
 static void dra7xx_pcie_host_init(struct pcie_port *pp)
 {
-	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pp);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
 
 	dw_pcie_setup_rc(pp);
 
@@ -163,9 +164,7 @@ static void dra7xx_pcie_host_init(struct pcie_port *pp)
 	dra7xx_pcie_enable_interrupts(dra7xx);
 }
 
-static struct pcie_host_ops dra7xx_pcie_host_ops = {
-	.cpu_addr_fixup = dra7xx_pcie_cpu_addr_fixup,
-	.link_up = dra7xx_pcie_link_up,
+static struct dw_pcie_host_ops dra7xx_pcie_host_ops = {
 	.host_init = dra7xx_pcie_host_init,
 };
 
@@ -184,8 +183,9 @@ static int dra7xx_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
 
 static int dra7xx_pcie_init_irq_domain(struct pcie_port *pp)
 {
-	struct device *dev = pp->dev;
-	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pp);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct device *dev = pci->dev;
+	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
 	struct device_node *node = dev->of_node;
 	struct device_node *pcie_intc_node =  of_get_next_child(node, NULL);
 
@@ -207,7 +207,8 @@ static int dra7xx_pcie_init_irq_domain(struct pcie_port *pp)
 static irqreturn_t dra7xx_pcie_msi_irq_handler(int irq, void *arg)
 {
 	struct dra7xx_pcie *dra7xx = arg;
-	struct pcie_port *pp = &dra7xx->pp;
+	struct dw_pcie *pci = dra7xx->pci;
+	struct pcie_port *pp = &pci->pp;
 	u32 reg;
 
 	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI);
@@ -234,7 +235,8 @@ static irqreturn_t dra7xx_pcie_msi_irq_handler(int irq, void *arg)
 static irqreturn_t dra7xx_pcie_irq_handler(int irq, void *arg)
 {
 	struct dra7xx_pcie *dra7xx = arg;
-	struct device *dev = dra7xx->pp.dev;
+	struct dw_pcie *pci = dra7xx->pci;
+	struct device *dev = pci->dev;
 	u32 reg;
 
 	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN);
@@ -292,9 +294,9 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
 	struct pcie_port *pp;
 	struct resource *res;
 	struct device *dev = &pdev->dev;
+	struct dw_pcie *pci = dra7xx->pci;
 
-	pp = &dra7xx->pp;
-	pp->dev = dev;
+	pp = &pci->pp;
 	pp->ops = &dra7xx_pcie_host_ops;
 
 	pp->irq = platform_get_irq(pdev, 1);
@@ -316,8 +318,8 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
 		return ret;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rc_dbics");
-	pp->dbi_base = devm_ioremap(dev, res->start, resource_size(res));
-	if (!pp->dbi_base)
+	pci->dbi_base = devm_ioremap(dev, res->start, resource_size(res));
+	if (!pci->dbi_base)
 		return -ENOMEM;
 
 	ret = dw_pcie_host_init(pp);
@@ -329,6 +331,11 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
 	return 0;
 }
 
+static const struct dw_pcie_ops dw_pcie_ops = {
+	.cpu_addr_fixup = dra7xx_pcie_cpu_addr_fixup,
+	.link_up = dra7xx_pcie_link_up,
+};
+
 static void dra7xx_pcie_disable_phy(struct dra7xx_pcie *dra7xx)
 {
 	int phy_count = dra7xx->phy_count;
@@ -378,6 +385,7 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	struct phy **phy;
 	void __iomem *base;
 	struct resource *res;
+	struct dw_pcie *pci;
 	struct dra7xx_pcie *dra7xx;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
@@ -388,6 +396,13 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	if (!dra7xx)
 		return -ENOMEM;
 
+	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
+	if (!pci)
+		return -ENOMEM;
+
+	pci->dev = dev;
+	pci->ops = &dw_pcie_ops;
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(dev, "missing IRQ resource\n");
@@ -425,6 +440,7 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 
 	dra7xx->base = base;
 	dra7xx->phy = phy;
+	dra7xx->pci = pci;
 	dra7xx->phy_count = phy_count;
 
 	ret = dra7xx_pcie_enable_phy(dra7xx);
@@ -477,13 +493,13 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 static int dra7xx_pcie_suspend(struct device *dev)
 {
 	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
-	struct pcie_port *pp = &dra7xx->pp;
+	struct dw_pcie *pci = dra7xx->pci;
 	u32 val;
 
 	/* clear MSE */
-	val = dw_pcie_readl_rc(pp, PCI_COMMAND);
+	val = dw_pcie_readl_dbi(pci, PCI_COMMAND);
 	val &= ~PCI_COMMAND_MEMORY;
-	dw_pcie_writel_rc(pp, PCI_COMMAND, val);
+	dw_pcie_writel_dbi(pci, PCI_COMMAND, val);
 
 	return 0;
 }
@@ -491,13 +507,13 @@ static int dra7xx_pcie_suspend(struct device *dev)
 static int dra7xx_pcie_resume(struct device *dev)
 {
 	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
-	struct pcie_port *pp = &dra7xx->pp;
+	struct dw_pcie *pci = dra7xx->pci;
 	u32 val;
 
 	/* set MSE */
-	val = dw_pcie_readl_rc(pp, PCI_COMMAND);
+	val = dw_pcie_readl_dbi(pci, PCI_COMMAND);
 	val |= PCI_COMMAND_MEMORY;
-	dw_pcie_writel_rc(pp, PCI_COMMAND, val);
+	dw_pcie_writel_dbi(pci, PCI_COMMAND, val);
 
 	return 0;
 }
diff --git a/drivers/pci/dwc/pci-exynos.c b/drivers/pci/dwc/pci-exynos.c
index e3fbff4..0295ec9 100644
--- a/drivers/pci/dwc/pci-exynos.c
+++ b/drivers/pci/dwc/pci-exynos.c
@@ -26,10 +26,10 @@
 
 #include "pcie-designware.h"
 
-#define to_exynos_pcie(x)	container_of(x, struct exynos_pcie, pp)
+#define to_exynos_pcie(x)	dev_get_drvdata((x)->dev)
 
 struct exynos_pcie {
-	struct pcie_port	pp;
+	struct dw_pcie		*pci;
 	void __iomem		*elbi_base;	/* DT 0th resource */
 	void __iomem		*phy_base;	/* DT 1st resource */
 	void __iomem		*block_base;	/* DT 2nd resource */
@@ -297,8 +297,8 @@ static void exynos_pcie_init_phy(struct exynos_pcie *exynos_pcie)
 
 static void exynos_pcie_assert_reset(struct exynos_pcie *exynos_pcie)
 {
-	struct pcie_port *pp = &exynos_pcie->pp;
-	struct device *dev = pp->dev;
+	struct dw_pcie *pci = exynos_pcie->pci;
+	struct device *dev = pci->dev;
 
 	if (exynos_pcie->reset_gpio >= 0)
 		devm_gpio_request_one(dev, exynos_pcie->reset_gpio,
@@ -307,11 +307,12 @@ static void exynos_pcie_assert_reset(struct exynos_pcie *exynos_pcie)
 
 static int exynos_pcie_establish_link(struct exynos_pcie *exynos_pcie)
 {
-	struct pcie_port *pp = &exynos_pcie->pp;
-	struct device *dev = pp->dev;
+	struct dw_pcie *pci = exynos_pcie->pci;
+	struct pcie_port *pp = &pci->pp;
+	struct device *dev = pci->dev;
 	u32 val;
 
-	if (dw_pcie_link_up(pp)) {
+	if (dw_pcie_link_up(pci)) {
 		dev_err(dev, "Link already up\n");
 		return 0;
 	}
@@ -336,7 +337,7 @@ static int exynos_pcie_establish_link(struct exynos_pcie *exynos_pcie)
 			  PCIE_APP_LTSSM_ENABLE);
 
 	/* check if the link is up or not */
-	if (!dw_pcie_wait_for_link(pp))
+	if (!dw_pcie_wait_for_link(pci))
 		return 0;
 
 	while (exynos_phy_readl(exynos_pcie, PCIE_PHY_PLL_LOCKED) == 0) {
@@ -376,14 +377,16 @@ static irqreturn_t exynos_pcie_irq_handler(int irq, void *arg)
 static irqreturn_t exynos_pcie_msi_irq_handler(int irq, void *arg)
 {
 	struct exynos_pcie *exynos_pcie = arg;
-	struct pcie_port *pp = &exynos_pcie->pp;
+	struct dw_pcie *pci = exynos_pcie->pci;
+	struct pcie_port *pp = &pci->pp;
 
 	return dw_handle_msi_irq(pp);
 }
 
 static void exynos_pcie_msi_init(struct exynos_pcie *exynos_pcie)
 {
-	struct pcie_port *pp = &exynos_pcie->pp;
+	struct dw_pcie *pci = exynos_pcie->pci;
+	struct pcie_port *pp = &pci->pp;
 	u32 val;
 
 	dw_pcie_msi_init(pp);
@@ -402,34 +405,35 @@ static void exynos_pcie_enable_interrupts(struct exynos_pcie *exynos_pcie)
 		exynos_pcie_msi_init(exynos_pcie);
 }
 
-static u32 exynos_pcie_readl_rc(struct pcie_port *pp, u32 reg)
+static u32 exynos_pcie_readl_dbi(struct dw_pcie *pci, u32 reg)
 {
-	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
+	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pci);
 	u32 val;
 
 	exynos_pcie_sideband_dbi_r_mode(exynos_pcie, true);
-	val = readl(pp->dbi_base + reg);
+	val = readl(pci->dbi_base + reg);
 	exynos_pcie_sideband_dbi_r_mode(exynos_pcie, false);
 	return val;
 }
 
-static void exynos_pcie_writel_rc(struct pcie_port *pp, u32 reg, u32 val)
+static void exynos_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
 {
-	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
+	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pci);
 
 	exynos_pcie_sideband_dbi_w_mode(exynos_pcie, true);
-	writel(val, pp->dbi_base + reg);
+	writel(val, pci->dbi_base + reg);
 	exynos_pcie_sideband_dbi_w_mode(exynos_pcie, false);
 }
 
 static int exynos_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
 				u32 *val)
 {
-	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pci);
 	int ret;
 
 	exynos_pcie_sideband_dbi_r_mode(exynos_pcie, true);
-	ret = dw_pcie_read(pp->dbi_base + where, size, val);
+	ret = dw_pcie_read(pci->dbi_base + where, size, val);
 	exynos_pcie_sideband_dbi_r_mode(exynos_pcie, false);
 	return ret;
 }
@@ -437,18 +441,19 @@ static int exynos_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
 static int exynos_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
 				u32 val)
 {
-	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pci);
 	int ret;
 
 	exynos_pcie_sideband_dbi_w_mode(exynos_pcie, true);
-	ret = dw_pcie_write(pp->dbi_base + where, size, val);
+	ret = dw_pcie_write(pci->dbi_base + where, size, val);
 	exynos_pcie_sideband_dbi_w_mode(exynos_pcie, false);
 	return ret;
 }
 
-static int exynos_pcie_link_up(struct pcie_port *pp)
+static int exynos_pcie_link_up(struct dw_pcie *pci)
 {
-	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
+	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pci);
 	u32 val;
 
 	val = exynos_elb_readl(exynos_pcie, PCIE_ELBI_RDLH_LINKUP);
@@ -460,26 +465,25 @@ static int exynos_pcie_link_up(struct pcie_port *pp)
 
 static void exynos_pcie_host_init(struct pcie_port *pp)
 {
-	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pci);
 
 	exynos_pcie_establish_link(exynos_pcie);
 	exynos_pcie_enable_interrupts(exynos_pcie);
 }
 
-static struct pcie_host_ops exynos_pcie_host_ops = {
-	.readl_rc = exynos_pcie_readl_rc,
-	.writel_rc = exynos_pcie_writel_rc,
+static struct dw_pcie_host_ops exynos_pcie_host_ops = {
 	.rd_own_conf = exynos_pcie_rd_own_conf,
 	.wr_own_conf = exynos_pcie_wr_own_conf,
-	.link_up = exynos_pcie_link_up,
 	.host_init = exynos_pcie_host_init,
 };
 
 static int __init exynos_add_pcie_port(struct exynos_pcie *exynos_pcie,
 				       struct platform_device *pdev)
 {
-	struct pcie_port *pp = &exynos_pcie->pp;
-	struct device *dev = pp->dev;
+	struct dw_pcie *pci = exynos_pcie->pci;
+	struct pcie_port *pp = &pci->pp;
+	struct device *dev = &pdev->dev;
 	int ret;
 
 	pp->irq = platform_get_irq(pdev, 1);
@@ -523,11 +527,17 @@ static int __init exynos_add_pcie_port(struct exynos_pcie *exynos_pcie,
 	return 0;
 }
 
+static const struct dw_pcie_ops dw_pcie_ops = {
+	.readl_dbi = exynos_pcie_readl_dbi,
+	.writel_dbi = exynos_pcie_writel_dbi,
+	.link_up = exynos_pcie_link_up,
+};
+
 static int __init exynos_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct dw_pcie *pci;
 	struct exynos_pcie *exynos_pcie;
-	struct pcie_port *pp;
 	struct device_node *np = dev->of_node;
 	struct resource *elbi_base;
 	struct resource *phy_base;
@@ -538,8 +548,12 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
 	if (!exynos_pcie)
 		return -ENOMEM;
 
-	pp = &exynos_pcie->pp;
-	pp->dev = dev;
+	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
+	if (!pci)
+		return -ENOMEM;
+
+	pci->dev = dev;
+	pci->ops = &dw_pcie_ops;
 
 	exynos_pcie->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
 
diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c
index 6e5d06f..70fa380 100644
--- a/drivers/pci/dwc/pci-imx6.c
+++ b/drivers/pci/dwc/pci-imx6.c
@@ -30,7 +30,7 @@
 
 #include "pcie-designware.h"
 
-#define to_imx6_pcie(x)	container_of(x, struct imx6_pcie, pp)
+#define to_imx6_pcie(x)	dev_get_drvdata((x)->dev)
 
 enum imx6_pcie_variants {
 	IMX6Q,
@@ -39,7 +39,7 @@ enum imx6_pcie_variants {
 };
 
 struct imx6_pcie {
-	struct pcie_port	pp;	/* pp.dbi_base is DT 0th resource */
+	struct dw_pcie		*pci;
 	int			reset_gpio;
 	bool			gpio_active_high;
 	struct clk		*pcie_bus;
@@ -97,13 +97,13 @@ struct imx6_pcie {
 
 static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, int exp_val)
 {
-	struct pcie_port *pp = &imx6_pcie->pp;
+	struct dw_pcie *pci = imx6_pcie->pci;
 	u32 val;
 	u32 max_iterations = 10;
 	u32 wait_counter = 0;
 
 	do {
-		val = dw_pcie_readl_rc(pp, PCIE_PHY_STAT);
+		val = dw_pcie_readl_dbi(pci, PCIE_PHY_STAT);
 		val = (val >> PCIE_PHY_STAT_ACK_LOC) & 0x1;
 		wait_counter++;
 
@@ -118,22 +118,22 @@ static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, int exp_val)
 
 static int pcie_phy_wait_ack(struct imx6_pcie *imx6_pcie, int addr)
 {
-	struct pcie_port *pp = &imx6_pcie->pp;
+	struct dw_pcie *pci = imx6_pcie->pci;
 	u32 val;
 	int ret;
 
 	val = addr << PCIE_PHY_CTRL_DATA_LOC;
-	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, val);
+	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, val);
 
 	val |= (0x1 << PCIE_PHY_CTRL_CAP_ADR_LOC);
-	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, val);
+	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, val);
 
 	ret = pcie_phy_poll_ack(imx6_pcie, 1);
 	if (ret)
 		return ret;
 
 	val = addr << PCIE_PHY_CTRL_DATA_LOC;
-	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, val);
+	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, val);
 
 	return pcie_phy_poll_ack(imx6_pcie, 0);
 }
@@ -141,7 +141,7 @@ static int pcie_phy_wait_ack(struct imx6_pcie *imx6_pcie, int addr)
 /* Read from the 16-bit PCIe PHY control registers (not memory-mapped) */
 static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, int *data)
 {
-	struct pcie_port *pp = &imx6_pcie->pp;
+	struct dw_pcie *pci = imx6_pcie->pci;
 	u32 val, phy_ctl;
 	int ret;
 
@@ -151,24 +151,24 @@ static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, int *data)
 
 	/* assert Read signal */
 	phy_ctl = 0x1 << PCIE_PHY_CTRL_RD_LOC;
-	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, phy_ctl);
+	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, phy_ctl);
 
 	ret = pcie_phy_poll_ack(imx6_pcie, 1);
 	if (ret)
 		return ret;
 
-	val = dw_pcie_readl_rc(pp, PCIE_PHY_STAT);
+	val = dw_pcie_readl_dbi(pci, PCIE_PHY_STAT);
 	*data = val & 0xffff;
 
 	/* deassert Read signal */
-	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, 0x00);
+	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, 0x00);
 
 	return pcie_phy_poll_ack(imx6_pcie, 0);
 }
 
 static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 {
-	struct pcie_port *pp = &imx6_pcie->pp;
+	struct dw_pcie *pci = imx6_pcie->pci;
 	u32 var;
 	int ret;
 
@@ -179,11 +179,11 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 		return ret;
 
 	var = data << PCIE_PHY_CTRL_DATA_LOC;
-	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, var);
+	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
 
 	/* capture data */
 	var |= (0x1 << PCIE_PHY_CTRL_CAP_DAT_LOC);
-	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, var);
+	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
 
 	ret = pcie_phy_poll_ack(imx6_pcie, 1);
 	if (ret)
@@ -191,7 +191,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 
 	/* deassert cap data */
 	var = data << PCIE_PHY_CTRL_DATA_LOC;
-	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, var);
+	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
 
 	/* wait for ack de-assertion */
 	ret = pcie_phy_poll_ack(imx6_pcie, 0);
@@ -200,7 +200,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 
 	/* assert wr signal */
 	var = 0x1 << PCIE_PHY_CTRL_WR_LOC;
-	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, var);
+	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
 
 	/* wait for ack */
 	ret = pcie_phy_poll_ack(imx6_pcie, 1);
@@ -209,14 +209,14 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 
 	/* deassert wr signal */
 	var = data << PCIE_PHY_CTRL_DATA_LOC;
-	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, var);
+	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
 
 	/* wait for ack de-assertion */
 	ret = pcie_phy_poll_ack(imx6_pcie, 0);
 	if (ret)
 		return ret;
 
-	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, 0x0);
+	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, 0x0);
 
 	return 0;
 }
@@ -247,7 +247,7 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
 
 static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 {
-	struct pcie_port *pp = &imx6_pcie->pp;
+	struct dw_pcie *pci = imx6_pcie->pci;
 	u32 val, gpr1, gpr12;
 
 	switch (imx6_pcie->variant) {
@@ -284,10 +284,10 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 
 		if ((gpr1 & IMX6Q_GPR1_PCIE_REF_CLK_EN) &&
 		    (gpr12 & IMX6Q_GPR12_PCIE_CTL_2)) {
-			val = dw_pcie_readl_rc(pp, PCIE_PL_PFLR);
+			val = dw_pcie_readl_dbi(pci, PCIE_PL_PFLR);
 			val &= ~PCIE_PL_PFLR_LINK_STATE_MASK;
 			val |= PCIE_PL_PFLR_FORCE_LINK;
-			dw_pcie_writel_rc(pp, PCIE_PL_PFLR, val);
+			dw_pcie_writel_dbi(pci, PCIE_PL_PFLR, val);
 
 			regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 					   IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
@@ -303,8 +303,8 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 
 static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 {
-	struct pcie_port *pp = &imx6_pcie->pp;
-	struct device *dev = pp->dev;
+	struct dw_pcie *pci = imx6_pcie->pci;
+	struct device *dev = pci->dev;
 	int ret = 0;
 
 	switch (imx6_pcie->variant) {
@@ -340,8 +340,8 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 
 static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 {
-	struct pcie_port *pp = &imx6_pcie->pp;
-	struct device *dev = pp->dev;
+	struct dw_pcie *pci = imx6_pcie->pci;
+	struct device *dev = pci->dev;
 	int ret;
 
 	ret = clk_prepare_enable(imx6_pcie->pcie_phy);
@@ -440,28 +440,28 @@ static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 
 static int imx6_pcie_wait_for_link(struct imx6_pcie *imx6_pcie)
 {
-	struct pcie_port *pp = &imx6_pcie->pp;
-	struct device *dev = pp->dev;
+	struct dw_pcie *pci = imx6_pcie->pci;
+	struct device *dev = pci->dev;
 
 	/* check if the link is up or not */
-	if (!dw_pcie_wait_for_link(pp))
+	if (!dw_pcie_wait_for_link(pci))
 		return 0;
 
 	dev_dbg(dev, "DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
-		dw_pcie_readl_rc(pp, PCIE_PHY_DEBUG_R0),
-		dw_pcie_readl_rc(pp, PCIE_PHY_DEBUG_R1));
+		dw_pcie_readl_dbi(pci, PCIE_PHY_DEBUG_R0),
+		dw_pcie_readl_dbi(pci, PCIE_PHY_DEBUG_R1));
 	return -ETIMEDOUT;
 }
 
 static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
 {
-	struct pcie_port *pp = &imx6_pcie->pp;
-	struct device *dev = pp->dev;
+	struct dw_pcie *pci = imx6_pcie->pci;
+	struct device *dev = pci->dev;
 	u32 tmp;
 	unsigned int retries;
 
 	for (retries = 0; retries < 200; retries++) {
-		tmp = dw_pcie_readl_rc(pp, PCIE_LINK_WIDTH_SPEED_CONTROL);
+		tmp = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
 		/* Test if the speed change finished. */
 		if (!(tmp & PORT_LOGIC_SPEED_CHANGE))
 			return 0;
@@ -475,15 +475,16 @@ static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
 static irqreturn_t imx6_pcie_msi_handler(int irq, void *arg)
 {
 	struct imx6_pcie *imx6_pcie = arg;
-	struct pcie_port *pp = &imx6_pcie->pp;
+	struct dw_pcie *pci = imx6_pcie->pci;
+	struct pcie_port *pp = &pci->pp;
 
 	return dw_handle_msi_irq(pp);
 }
 
 static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 {
-	struct pcie_port *pp = &imx6_pcie->pp;
-	struct device *dev = pp->dev;
+	struct dw_pcie *pci = imx6_pcie->pci;
+	struct device *dev = pci->dev;
 	u32 tmp;
 	int ret;
 
@@ -492,10 +493,10 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 	 * started in Gen2 mode, there is a possibility the devices on the
 	 * bus will not be detected at all.  This happens with PCIe switches.
 	 */
-	tmp = dw_pcie_readl_rc(pp, PCIE_RC_LCR);
+	tmp = dw_pcie_readl_dbi(pci, PCIE_RC_LCR);
 	tmp &= ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
 	tmp |= PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1;
-	dw_pcie_writel_rc(pp, PCIE_RC_LCR, tmp);
+	dw_pcie_writel_dbi(pci, PCIE_RC_LCR, tmp);
 
 	/* Start LTSSM. */
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
@@ -509,10 +510,10 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 
 	if (imx6_pcie->link_gen == 2) {
 		/* Allow Gen2 mode after the link is up. */
-		tmp = dw_pcie_readl_rc(pp, PCIE_RC_LCR);
+		tmp = dw_pcie_readl_dbi(pci, PCIE_RC_LCR);
 		tmp &= ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
 		tmp |= PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN2;
-		dw_pcie_writel_rc(pp, PCIE_RC_LCR, tmp);
+		dw_pcie_writel_dbi(pci, PCIE_RC_LCR, tmp);
 	} else {
 		dev_info(dev, "Link: Gen2 disabled\n");
 	}
@@ -521,9 +522,9 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 	 * Start Directed Speed Change so the best possible speed both link
 	 * partners support can be negotiated.
 	 */
-	tmp = dw_pcie_readl_rc(pp, PCIE_LINK_WIDTH_SPEED_CONTROL);
+	tmp = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
 	tmp |= PORT_LOGIC_SPEED_CHANGE;
-	dw_pcie_writel_rc(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
+	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
 
 	ret = imx6_pcie_wait_for_speed_change(imx6_pcie);
 	if (ret) {
@@ -538,21 +539,22 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 		goto err_reset_phy;
 	}
 
-	tmp = dw_pcie_readl_rc(pp, PCIE_RC_LCSR);
+	tmp = dw_pcie_readl_dbi(pci, PCIE_RC_LCSR);
 	dev_info(dev, "Link up, Gen%i\n", (tmp >> 16) & 0xf);
 	return 0;
 
 err_reset_phy:
 	dev_dbg(dev, "PHY DEBUG_R0=0x%08x DEBUG_R1=0x%08x\n",
-		dw_pcie_readl_rc(pp, PCIE_PHY_DEBUG_R0),
-		dw_pcie_readl_rc(pp, PCIE_PHY_DEBUG_R1));
+		dw_pcie_readl_dbi(pci, PCIE_PHY_DEBUG_R0),
+		dw_pcie_readl_dbi(pci, PCIE_PHY_DEBUG_R1));
 	imx6_pcie_reset_phy(imx6_pcie);
 	return ret;
 }
 
 static void imx6_pcie_host_init(struct pcie_port *pp)
 {
-	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
 
 	imx6_pcie_assert_core_reset(imx6_pcie);
 	imx6_pcie_init_phy(imx6_pcie);
@@ -564,22 +566,22 @@ static void imx6_pcie_host_init(struct pcie_port *pp)
 		dw_pcie_msi_init(pp);
 }
 
-static int imx6_pcie_link_up(struct pcie_port *pp)
+static int imx6_pcie_link_up(struct dw_pcie *pci)
 {
-	return dw_pcie_readl_rc(pp, PCIE_PHY_DEBUG_R1) &
+	return dw_pcie_readl_dbi(pci, PCIE_PHY_DEBUG_R1) &
 			PCIE_PHY_DEBUG_R1_XMLH_LINK_UP;
 }
 
-static struct pcie_host_ops imx6_pcie_host_ops = {
-	.link_up = imx6_pcie_link_up,
+static struct dw_pcie_host_ops imx6_pcie_host_ops = {
 	.host_init = imx6_pcie_host_init,
 };
 
 static int __init imx6_add_pcie_port(struct imx6_pcie *imx6_pcie,
 				     struct platform_device *pdev)
 {
-	struct pcie_port *pp = &imx6_pcie->pp;
-	struct device *dev = pp->dev;
+	struct dw_pcie *pci = imx6_pcie->pci;
+	struct pcie_port *pp = &pci->pp;
+	struct device *dev = &pdev->dev;
 	int ret;
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
@@ -611,11 +613,15 @@ static int __init imx6_add_pcie_port(struct imx6_pcie *imx6_pcie,
 	return 0;
 }
 
+static const struct dw_pcie_ops dw_pcie_ops = {
+	.link_up = imx6_pcie_link_up,
+};
+
 static int __init imx6_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct dw_pcie *pci;
 	struct imx6_pcie *imx6_pcie;
-	struct pcie_port *pp;
 	struct resource *dbi_base;
 	struct device_node *node = dev->of_node;
 	int ret;
@@ -624,8 +630,12 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 	if (!imx6_pcie)
 		return -ENOMEM;
 
-	pp = &imx6_pcie->pp;
-	pp->dev = dev;
+	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
+	if (!pci)
+		return -ENOMEM;
+
+	pci->dev = dev;
+	pci->ops = &dw_pcie_ops;
 
 	imx6_pcie->variant =
 		(enum imx6_pcie_variants)of_device_get_match_data(dev);
@@ -635,9 +645,9 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 		"imprecise external abort");
 
 	dbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pp->dbi_base = devm_ioremap_resource(dev, dbi_base);
-	if (IS_ERR(pp->dbi_base))
-		return PTR_ERR(pp->dbi_base);
+	pci->dbi_base = devm_ioremap_resource(dev, dbi_base);
+	if (IS_ERR(pci->dbi_base))
+		return PTR_ERR(pci->dbi_base);
 
 	/* Fetch GPIOs */
 	imx6_pcie->reset_gpio = of_get_named_gpio(node, "reset-gpio", 0);
diff --git a/drivers/pci/dwc/pci-keystone-dw.c b/drivers/pci/dwc/pci-keystone-dw.c
index 4875334..6b396f6 100644
--- a/drivers/pci/dwc/pci-keystone-dw.c
+++ b/drivers/pci/dwc/pci-keystone-dw.c
@@ -72,7 +72,7 @@
 /* Config space registers */
 #define DEBUG0				0x728
 
-#define to_keystone_pcie(x)	container_of(x, struct keystone_pcie, pp)
+#define to_keystone_pcie(x)	dev_get_drvdata((x)->dev)
 
 static inline void update_reg_offset_bit_pos(u32 offset, u32 *reg_offset,
 					     u32 *bit_pos)
@@ -83,7 +83,8 @@ static inline void update_reg_offset_bit_pos(u32 offset, u32 *reg_offset,
 
 phys_addr_t ks_dw_pcie_get_msi_addr(struct pcie_port *pp)
 {
-	struct keystone_pcie *ks_pcie = to_keystone_pcie(pp);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
 
 	return ks_pcie->app.start + MSI_IRQ;
 }
@@ -100,8 +101,9 @@ static void ks_dw_app_writel(struct keystone_pcie *ks_pcie, u32 offset, u32 val)
 
 void ks_dw_pcie_handle_msi_irq(struct keystone_pcie *ks_pcie, int offset)
 {
-	struct pcie_port *pp = &ks_pcie->pp;
-	struct device *dev = pp->dev;
+	struct dw_pcie *pci = ks_pcie->pci;
+	struct pcie_port *pp = &pci->pp;
+	struct device *dev = pci->dev;
 	u32 pending, vector;
 	int src, virq;
 
@@ -128,10 +130,12 @@ static void ks_dw_pcie_msi_irq_ack(struct irq_data *d)
 	struct keystone_pcie *ks_pcie;
 	struct msi_desc *msi;
 	struct pcie_port *pp;
+	struct dw_pcie *pci;
 
 	msi = irq_data_get_msi_desc(d);
 	pp = (struct pcie_port *) msi_desc_to_pci_sysdata(msi);
-	ks_pcie = to_keystone_pcie(pp);
+	pci = to_dw_pcie_from_pp(pp);
+	ks_pcie = to_keystone_pcie(pci);
 	offset = d->irq - irq_linear_revmap(pp->irq_domain, 0);
 	update_reg_offset_bit_pos(offset, &reg_offset, &bit_pos);
 
@@ -143,7 +147,8 @@ static void ks_dw_pcie_msi_irq_ack(struct irq_data *d)
 void ks_dw_pcie_msi_set_irq(struct pcie_port *pp, int irq)
 {
 	u32 reg_offset, bit_pos;
-	struct keystone_pcie *ks_pcie = to_keystone_pcie(pp);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
 
 	update_reg_offset_bit_pos(irq, &reg_offset, &bit_pos);
 	ks_dw_app_writel(ks_pcie, MSI0_IRQ_ENABLE_SET + (reg_offset << 4),
@@ -153,7 +158,8 @@ void ks_dw_pcie_msi_set_irq(struct pcie_port *pp, int irq)
 void ks_dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
 {
 	u32 reg_offset, bit_pos;
-	struct keystone_pcie *ks_pcie = to_keystone_pcie(pp);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
 
 	update_reg_offset_bit_pos(irq, &reg_offset, &bit_pos);
 	ks_dw_app_writel(ks_pcie, MSI0_IRQ_ENABLE_CLR + (reg_offset << 4),
@@ -165,11 +171,13 @@ static void ks_dw_pcie_msi_irq_mask(struct irq_data *d)
 	struct keystone_pcie *ks_pcie;
 	struct msi_desc *msi;
 	struct pcie_port *pp;
+	struct dw_pcie *pci;
 	u32 offset;
 
 	msi = irq_data_get_msi_desc(d);
 	pp = (struct pcie_port *) msi_desc_to_pci_sysdata(msi);
-	ks_pcie = to_keystone_pcie(pp);
+	pci = to_dw_pcie_from_pp(pp);
+	ks_pcie = to_keystone_pcie(pci);
 	offset = d->irq - irq_linear_revmap(pp->irq_domain, 0);
 
 	/* Mask the end point if PVM implemented */
@@ -186,11 +194,13 @@ static void ks_dw_pcie_msi_irq_unmask(struct irq_data *d)
 	struct keystone_pcie *ks_pcie;
 	struct msi_desc *msi;
 	struct pcie_port *pp;
+	struct dw_pcie *pci;
 	u32 offset;
 
 	msi = irq_data_get_msi_desc(d);
 	pp = (struct pcie_port *) msi_desc_to_pci_sysdata(msi);
-	ks_pcie = to_keystone_pcie(pp);
+	pci = to_dw_pcie_from_pp(pp);
+	ks_pcie = to_keystone_pcie(pci);
 	offset = d->irq - irq_linear_revmap(pp->irq_domain, 0);
 
 	/* Mask the end point if PVM implemented */
@@ -225,8 +235,9 @@ static int ks_dw_pcie_msi_map(struct irq_domain *domain, unsigned int irq,
 
 int ks_dw_pcie_msi_host_init(struct pcie_port *pp, struct msi_controller *chip)
 {
-	struct keystone_pcie *ks_pcie = to_keystone_pcie(pp);
-	struct device *dev = pp->dev;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
+	struct device *dev = pci->dev;
 	int i;
 
 	pp->irq_domain = irq_domain_add_linear(ks_pcie->msi_intc_np,
@@ -254,8 +265,8 @@ void ks_dw_pcie_enable_legacy_irqs(struct keystone_pcie *ks_pcie)
 
 void ks_dw_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie, int offset)
 {
-	struct pcie_port *pp = &ks_pcie->pp;
-	struct device *dev = pp->dev;
+	struct dw_pcie *pci = ks_pcie->pci;
+	struct device *dev = pci->dev;
 	u32 pending;
 	int virq;
 
@@ -285,7 +296,7 @@ irqreturn_t ks_dw_pcie_handle_error_irq(struct keystone_pcie *ks_pcie)
 		return IRQ_NONE;
 
 	if (status & ERR_FATAL_IRQ)
-		dev_err(ks_pcie->pp.dev, "fatal error (status %#010x)\n",
+		dev_err(ks_pcie->pci->dev, "fatal error (status %#010x)\n",
 			status);
 
 	/* Ack the IRQ; status bits are RW1C */
@@ -366,15 +377,16 @@ static void ks_dw_pcie_clear_dbi_mode(struct keystone_pcie *ks_pcie)
 
 void ks_dw_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
 {
-	struct pcie_port *pp = &ks_pcie->pp;
+	struct dw_pcie *pci = ks_pcie->pci;
+	struct pcie_port *pp = &pci->pp;
 	u32 start = pp->mem->start, end = pp->mem->end;
 	int i, tr_size;
 	u32 val;
 
 	/* Disable BARs for inbound access */
 	ks_dw_pcie_set_dbi_mode(ks_pcie);
-	dw_pcie_writel_rc(pp, PCI_BASE_ADDRESS_0, 0);
-	dw_pcie_writel_rc(pp, PCI_BASE_ADDRESS_1, 0);
+	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0);
+	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_1, 0);
 	ks_dw_pcie_clear_dbi_mode(ks_pcie);
 
 	/* Set outbound translation size per window division */
@@ -415,11 +427,12 @@ static void __iomem *ks_pcie_cfg_setup(struct keystone_pcie *ks_pcie, u8 bus,
 				       unsigned int devfn)
 {
 	u8 device = PCI_SLOT(devfn), function = PCI_FUNC(devfn);
-	struct pcie_port *pp = &ks_pcie->pp;
+	struct dw_pcie *pci = ks_pcie->pci;
+	struct pcie_port *pp = &pci->pp;
 	u32 regval;
 
 	if (bus == 0)
-		return pp->dbi_base;
+		return pci->dbi_base;
 
 	regval = (bus << 16) | (device << 8) | function;
 
@@ -438,7 +451,8 @@ static void __iomem *ks_pcie_cfg_setup(struct keystone_pcie *ks_pcie, u8 bus,
 int ks_dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 			     unsigned int devfn, int where, int size, u32 *val)
 {
-	struct keystone_pcie *ks_pcie = to_keystone_pcie(pp);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
 	u8 bus_num = bus->number;
 	void __iomem *addr;
 
@@ -450,7 +464,8 @@ int ks_dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 int ks_dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 			     unsigned int devfn, int where, int size, u32 val)
 {
-	struct keystone_pcie *ks_pcie = to_keystone_pcie(pp);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
 	u8 bus_num = bus->number;
 	void __iomem *addr;
 
@@ -466,14 +481,15 @@ int ks_dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
  */
 void ks_dw_pcie_v3_65_scan_bus(struct pcie_port *pp)
 {
-	struct keystone_pcie *ks_pcie = to_keystone_pcie(pp);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
 
 	/* Configure and set up BAR0 */
 	ks_dw_pcie_set_dbi_mode(ks_pcie);
 
 	/* Enable BAR0 */
-	dw_pcie_writel_rc(pp, PCI_BASE_ADDRESS_0, 1);
-	dw_pcie_writel_rc(pp, PCI_BASE_ADDRESS_0, SZ_4K - 1);
+	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 1);
+	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, SZ_4K - 1);
 
 	ks_dw_pcie_clear_dbi_mode(ks_pcie);
 
@@ -481,17 +497,17 @@ void ks_dw_pcie_v3_65_scan_bus(struct pcie_port *pp)
 	  * For BAR0, just setting bus address for inbound writes (MSI) should
 	  * be sufficient.  Use physical address to avoid any conflicts.
 	  */
-	dw_pcie_writel_rc(pp, PCI_BASE_ADDRESS_0, ks_pcie->app.start);
+	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, ks_pcie->app.start);
 }
 
 /**
  * ks_dw_pcie_link_up() - Check if link up
  */
-int ks_dw_pcie_link_up(struct pcie_port *pp)
+int ks_dw_pcie_link_up(struct dw_pcie *pci)
 {
 	u32 val;
 
-	val = dw_pcie_readl_rc(pp, DEBUG0);
+	val = dw_pcie_readl_dbi(pci, DEBUG0);
 	return (val & LTSSM_STATE_MASK) == LTSSM_STATE_L0;
 }
 
@@ -519,22 +535,23 @@ void ks_dw_pcie_initiate_link_train(struct keystone_pcie *ks_pcie)
 int __init ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie,
 				struct device_node *msi_intc_np)
 {
-	struct pcie_port *pp = &ks_pcie->pp;
-	struct device *dev = pp->dev;
+	struct dw_pcie *pci = ks_pcie->pci;
+	struct pcie_port *pp = &pci->pp;
+	struct device *dev = pci->dev;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct resource *res;
 
 	/* Index 0 is the config reg. space address */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pp->dbi_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(pp->dbi_base))
-		return PTR_ERR(pp->dbi_base);
+	pci->dbi_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(pci->dbi_base))
+		return PTR_ERR(pci->dbi_base);
 
 	/*
 	 * We set these same and is used in pcie rd/wr_other_conf
 	 * functions
 	 */
-	pp->va_cfg0_base = pp->dbi_base + SPACE0_REMOTE_CFG_OFFSET;
+	pp->va_cfg0_base = pci->dbi_base + SPACE0_REMOTE_CFG_OFFSET;
 	pp->va_cfg1_base = pp->va_cfg0_base;
 
 	/* Index 1 is the application reg. space address */
diff --git a/drivers/pci/dwc/pci-keystone.c b/drivers/pci/dwc/pci-keystone.c
index 4c7ba35..8dc6640 100644
--- a/drivers/pci/dwc/pci-keystone.c
+++ b/drivers/pci/dwc/pci-keystone.c
@@ -44,7 +44,7 @@
 #define PCIE_RC_K2E		0xb009
 #define PCIE_RC_K2L		0xb00a
 
-#define to_keystone_pcie(x)	container_of(x, struct keystone_pcie, pp)
+#define to_keystone_pcie(x)	dev_get_drvdata((x)->dev)
 
 static void quirk_limit_mrrs(struct pci_dev *dev)
 {
@@ -88,13 +88,14 @@ static void quirk_limit_mrrs(struct pci_dev *dev)
 
 static int ks_pcie_establish_link(struct keystone_pcie *ks_pcie)
 {
-	struct pcie_port *pp = &ks_pcie->pp;
-	struct device *dev = pp->dev;
+	struct dw_pcie *pci = ks_pcie->pci;
+	struct pcie_port *pp = &pci->pp;
+	struct device *dev = pci->dev;
 	unsigned int retries;
 
 	dw_pcie_setup_rc(pp);
 
-	if (dw_pcie_link_up(pp)) {
+	if (dw_pcie_link_up(pci)) {
 		dev_err(dev, "Link already up\n");
 		return 0;
 	}
@@ -102,7 +103,7 @@ static int ks_pcie_establish_link(struct keystone_pcie *ks_pcie)
 	/* check if the link is up or not */
 	for (retries = 0; retries < 5; retries++) {
 		ks_dw_pcie_initiate_link_train(ks_pcie);
-		if (!dw_pcie_wait_for_link(pp))
+		if (!dw_pcie_wait_for_link(pci))
 			return 0;
 	}
 
@@ -115,8 +116,8 @@ static void ks_pcie_msi_irq_handler(struct irq_desc *desc)
 	unsigned int irq = irq_desc_get_irq(desc);
 	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
 	u32 offset = irq - ks_pcie->msi_host_irqs[0];
-	struct pcie_port *pp = &ks_pcie->pp;
-	struct device *dev = pp->dev;
+	struct dw_pcie *pci = ks_pcie->pci;
+	struct device *dev = pci->dev;
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 
 	dev_dbg(dev, "%s, irq %d\n", __func__, irq);
@@ -143,8 +144,8 @@ static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
 {
 	unsigned int irq = irq_desc_get_irq(desc);
 	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
-	struct pcie_port *pp = &ks_pcie->pp;
-	struct device *dev = pp->dev;
+	struct dw_pcie *pci = ks_pcie->pci;
+	struct device *dev = pci->dev;
 	u32 irq_offset = irq - ks_pcie->legacy_host_irqs[0];
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 
@@ -164,7 +165,7 @@ static int ks_pcie_get_irq_controller_info(struct keystone_pcie *ks_pcie,
 					   char *controller, int *num_irqs)
 {
 	int temp, max_host_irqs, legacy = 1, *host_irqs;
-	struct device *dev = ks_pcie->pp.dev;
+	struct device *dev = ks_pcie->pci->dev;
 	struct device_node *np_pcie = dev->of_node, **np_temp;
 
 	if (!strcmp(controller, "msi-interrupt-controller"))
@@ -262,24 +263,25 @@ static int keystone_pcie_fault(unsigned long addr, unsigned int fsr,
 
 static void __init ks_pcie_host_init(struct pcie_port *pp)
 {
-	struct keystone_pcie *ks_pcie = to_keystone_pcie(pp);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
 	u32 val;
 
 	ks_pcie_establish_link(ks_pcie);
 	ks_dw_pcie_setup_rc_app_regs(ks_pcie);
 	ks_pcie_setup_interrupts(ks_pcie);
 	writew(PCI_IO_RANGE_TYPE_32 | (PCI_IO_RANGE_TYPE_32 << 8),
-			pp->dbi_base + PCI_IO_BASE);
+			pci->dbi_base + PCI_IO_BASE);
 
 	/* update the Vendor ID */
-	writew(ks_pcie->device_id, pp->dbi_base + PCI_DEVICE_ID);
+	writew(ks_pcie->device_id, pci->dbi_base + PCI_DEVICE_ID);
 
 	/* update the DEV_STAT_CTRL to publish right mrrs */
-	val = readl(pp->dbi_base + PCIE_CAP_BASE + PCI_EXP_DEVCTL);
+	val = readl(pci->dbi_base + PCIE_CAP_BASE + PCI_EXP_DEVCTL);
 	val &= ~PCI_EXP_DEVCTL_READRQ;
 	/* set the mrrs to 256 bytes */
 	val |= BIT(12);
-	writel(val, pp->dbi_base + PCIE_CAP_BASE + PCI_EXP_DEVCTL);
+	writel(val, pci->dbi_base + PCIE_CAP_BASE + PCI_EXP_DEVCTL);
 
 	/*
 	 * PCIe access errors that result into OCP errors are caught by ARM as
@@ -289,10 +291,9 @@ static void __init ks_pcie_host_init(struct pcie_port *pp)
 			"Asynchronous external abort");
 }
 
-static struct pcie_host_ops keystone_pcie_host_ops = {
+static struct dw_pcie_host_ops keystone_pcie_host_ops = {
 	.rd_other_conf = ks_dw_pcie_rd_other_conf,
 	.wr_other_conf = ks_dw_pcie_wr_other_conf,
-	.link_up = ks_dw_pcie_link_up,
 	.host_init = ks_pcie_host_init,
 	.msi_set_irq = ks_dw_pcie_msi_set_irq,
 	.msi_clear_irq = ks_dw_pcie_msi_clear_irq,
@@ -311,8 +312,9 @@ static irqreturn_t pcie_err_irq_handler(int irq, void *priv)
 static int __init ks_add_pcie_port(struct keystone_pcie *ks_pcie,
 			 struct platform_device *pdev)
 {
-	struct pcie_port *pp = &ks_pcie->pp;
-	struct device *dev = pp->dev;
+	struct dw_pcie *pci = ks_pcie->pci;
+	struct pcie_port *pp = &pci->pp;
+	struct device *dev = &pdev->dev;
 	int ret;
 
 	ret = ks_pcie_get_irq_controller_info(ks_pcie,
@@ -365,6 +367,10 @@ static int __init ks_add_pcie_port(struct keystone_pcie *ks_pcie,
 	{ },
 };
 
+static const struct dw_pcie_ops dw_pcie_ops = {
+	.link_up = ks_dw_pcie_link_up,
+};
+
 static int __exit ks_pcie_remove(struct platform_device *pdev)
 {
 	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
@@ -377,8 +383,8 @@ static int __exit ks_pcie_remove(struct platform_device *pdev)
 static int __init ks_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct dw_pcie *pci;
 	struct keystone_pcie *ks_pcie;
-	struct pcie_port *pp;
 	struct resource *res;
 	void __iomem *reg_p;
 	struct phy *phy;
@@ -388,8 +394,12 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	if (!ks_pcie)
 		return -ENOMEM;
 
-	pp = &ks_pcie->pp;
-	pp->dev = dev;
+	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
+	if (!pci)
+		return -ENOMEM;
+
+	pci->dev = dev;
+	pci->ops = &dw_pcie_ops;
 
 	/* initialize SerDes Phy if present */
 	phy = devm_phy_get(dev, "pcie-phy");
diff --git a/drivers/pci/dwc/pci-keystone.h b/drivers/pci/dwc/pci-keystone.h
index bc54baf..74c5825 100644
--- a/drivers/pci/dwc/pci-keystone.h
+++ b/drivers/pci/dwc/pci-keystone.h
@@ -17,7 +17,7 @@
 #define MAX_LEGACY_HOST_IRQS		4
 
 struct keystone_pcie {
-	struct	pcie_port	pp;		/* pp.dbi_base is DT 0th res */
+	struct dw_pcie		*pci;
 	struct	clk		*clk;
 	/* PCI Device ID */
 	u32			device_id;
@@ -54,10 +54,10 @@ int ks_dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 int ks_dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 		unsigned int devfn, int where, int size, u32 *val);
 void ks_dw_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie);
-int ks_dw_pcie_link_up(struct pcie_port *pp);
 void ks_dw_pcie_initiate_link_train(struct keystone_pcie *ks_pcie);
 void ks_dw_pcie_msi_set_irq(struct pcie_port *pp, int irq);
 void ks_dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq);
 void ks_dw_pcie_v3_65_scan_bus(struct pcie_port *pp);
 int ks_dw_pcie_msi_host_init(struct pcie_port *pp,
 		struct msi_controller *chip);
+int ks_dw_pcie_link_up(struct dw_pcie *pci);
diff --git a/drivers/pci/dwc/pci-layerscape.c b/drivers/pci/dwc/pci-layerscape.c
index 89e8817..f69d2fe 100644
--- a/drivers/pci/dwc/pci-layerscape.c
+++ b/drivers/pci/dwc/pci-layerscape.c
@@ -39,24 +39,26 @@ struct ls_pcie_drvdata {
 	u32 lut_offset;
 	u32 ltssm_shift;
 	u32 lut_dbg;
-	struct pcie_host_ops *ops;
+	struct dw_pcie_host_ops *ops;
+	const struct dw_pcie_ops *dw_pcie_ops;
 };
 
 struct ls_pcie {
-	struct pcie_port pp;		/* pp.dbi_base is DT regs */
+	struct dw_pcie *pci;
 	void __iomem *lut;
 	struct regmap *scfg;
 	const struct ls_pcie_drvdata *drvdata;
 	int index;
 };
 
-#define to_ls_pcie(x)	container_of(x, struct ls_pcie, pp)
+#define to_ls_pcie(x)	dev_get_drvdata((x)->dev)
 
 static bool ls_pcie_is_bridge(struct ls_pcie *pcie)
 {
+	struct dw_pcie *pci = pcie->pci;
 	u32 header_type;
 
-	header_type = ioread8(pcie->pp.dbi_base + PCI_HEADER_TYPE);
+	header_type = ioread8(pci->dbi_base + PCI_HEADER_TYPE);
 	header_type &= 0x7f;
 
 	return header_type == PCI_HEADER_TYPE_BRIDGE;
@@ -65,29 +67,34 @@ static bool ls_pcie_is_bridge(struct ls_pcie *pcie)
 /* Clear multi-function bit */
 static void ls_pcie_clear_multifunction(struct ls_pcie *pcie)
 {
-	iowrite8(PCI_HEADER_TYPE_BRIDGE, pcie->pp.dbi_base + PCI_HEADER_TYPE);
+	struct dw_pcie *pci = pcie->pci;
+
+	iowrite8(PCI_HEADER_TYPE_BRIDGE, pci->dbi_base + PCI_HEADER_TYPE);
 }
 
 /* Fix class value */
 static void ls_pcie_fix_class(struct ls_pcie *pcie)
 {
-	iowrite16(PCI_CLASS_BRIDGE_PCI, pcie->pp.dbi_base + PCI_CLASS_DEVICE);
+	struct dw_pcie *pci = pcie->pci;
+
+	iowrite16(PCI_CLASS_BRIDGE_PCI, pci->dbi_base + PCI_CLASS_DEVICE);
 }
 
 /* Drop MSG TLP except for Vendor MSG */
 static void ls_pcie_drop_msg_tlp(struct ls_pcie *pcie)
 {
 	u32 val;
+	struct dw_pcie *pci = pcie->pci;
 
-	val = ioread32(pcie->pp.dbi_base + PCIE_STRFMR1);
+	val = ioread32(pci->dbi_base + PCIE_STRFMR1);
 	val &= 0xDFFFFFFF;
-	iowrite32(val, pcie->pp.dbi_base + PCIE_STRFMR1);
+	iowrite32(val, pci->dbi_base + PCIE_STRFMR1);
 }
 
-static int ls1021_pcie_link_up(struct pcie_port *pp)
+static int ls1021_pcie_link_up(struct dw_pcie *pci)
 {
 	u32 state;
-	struct ls_pcie *pcie = to_ls_pcie(pp);
+	struct ls_pcie *pcie = to_ls_pcie(pci);
 
 	if (!pcie->scfg)
 		return 0;
@@ -103,8 +110,9 @@ static int ls1021_pcie_link_up(struct pcie_port *pp)
 
 static void ls1021_pcie_host_init(struct pcie_port *pp)
 {
-	struct device *dev = pp->dev;
-	struct ls_pcie *pcie = to_ls_pcie(pp);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct ls_pcie *pcie = to_ls_pcie(pci);
+	struct device *dev = pci->dev;
 	u32 index[2];
 
 	pcie->scfg = syscon_regmap_lookup_by_phandle(dev->of_node,
@@ -127,9 +135,9 @@ static void ls1021_pcie_host_init(struct pcie_port *pp)
 	ls_pcie_drop_msg_tlp(pcie);
 }
 
-static int ls_pcie_link_up(struct pcie_port *pp)
+static int ls_pcie_link_up(struct dw_pcie *pci)
 {
-	struct ls_pcie *pcie = to_ls_pcie(pp);
+	struct ls_pcie *pcie = to_ls_pcie(pci);
 	u32 state;
 
 	state = (ioread32(pcie->lut + pcie->drvdata->lut_dbg) >>
@@ -144,19 +152,21 @@ static int ls_pcie_link_up(struct pcie_port *pp)
 
 static void ls_pcie_host_init(struct pcie_port *pp)
 {
-	struct ls_pcie *pcie = to_ls_pcie(pp);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct ls_pcie *pcie = to_ls_pcie(pci);
 
-	iowrite32(1, pcie->pp.dbi_base + PCIE_DBI_RO_WR_EN);
+	iowrite32(1, pci->dbi_base + PCIE_DBI_RO_WR_EN);
 	ls_pcie_fix_class(pcie);
 	ls_pcie_clear_multifunction(pcie);
 	ls_pcie_drop_msg_tlp(pcie);
-	iowrite32(0, pcie->pp.dbi_base + PCIE_DBI_RO_WR_EN);
+	iowrite32(0, pci->dbi_base + PCIE_DBI_RO_WR_EN);
 }
 
 static int ls_pcie_msi_host_init(struct pcie_port *pp,
 				 struct msi_controller *chip)
 {
-	struct device *dev = pp->dev;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct device *dev = pci->dev;
 	struct device_node *np = dev->of_node;
 	struct device_node *msi_node;
 
@@ -175,20 +185,27 @@ static int ls_pcie_msi_host_init(struct pcie_port *pp,
 	return 0;
 }
 
-static struct pcie_host_ops ls1021_pcie_host_ops = {
-	.link_up = ls1021_pcie_link_up,
+static struct dw_pcie_host_ops ls1021_pcie_host_ops = {
 	.host_init = ls1021_pcie_host_init,
 	.msi_host_init = ls_pcie_msi_host_init,
 };
 
-static struct pcie_host_ops ls_pcie_host_ops = {
-	.link_up = ls_pcie_link_up,
+static struct dw_pcie_host_ops ls_pcie_host_ops = {
 	.host_init = ls_pcie_host_init,
 	.msi_host_init = ls_pcie_msi_host_init,
 };
 
+static const struct dw_pcie_ops dw_ls1021_pcie_ops = {
+	.link_up = ls1021_pcie_link_up,
+};
+
+static const struct dw_pcie_ops dw_ls_pcie_ops = {
+	.link_up = ls_pcie_link_up,
+};
+
 static struct ls_pcie_drvdata ls1021_drvdata = {
 	.ops = &ls1021_pcie_host_ops,
+	.dw_pcie_ops = &dw_ls1021_pcie_ops,
 };
 
 static struct ls_pcie_drvdata ls1043_drvdata = {
@@ -196,6 +213,7 @@ static int ls_pcie_msi_host_init(struct pcie_port *pp,
 	.ltssm_shift = 24,
 	.lut_dbg = 0x7fc,
 	.ops = &ls_pcie_host_ops,
+	.dw_pcie_ops = &dw_ls_pcie_ops,
 };
 
 static struct ls_pcie_drvdata ls1046_drvdata = {
@@ -203,6 +221,7 @@ static int ls_pcie_msi_host_init(struct pcie_port *pp,
 	.ltssm_shift = 24,
 	.lut_dbg = 0x407fc,
 	.ops = &ls_pcie_host_ops,
+	.dw_pcie_ops = &dw_ls_pcie_ops,
 };
 
 static struct ls_pcie_drvdata ls2080_drvdata = {
@@ -210,6 +229,7 @@ static int ls_pcie_msi_host_init(struct pcie_port *pp,
 	.ltssm_shift = 0,
 	.lut_dbg = 0x7fc,
 	.ops = &ls_pcie_host_ops,
+	.dw_pcie_ops = &dw_ls_pcie_ops,
 };
 
 static const struct of_device_id ls_pcie_of_match[] = {
@@ -223,10 +243,13 @@ static int ls_pcie_msi_host_init(struct pcie_port *pp,
 
 static int __init ls_add_pcie_port(struct ls_pcie *pcie)
 {
-	struct pcie_port *pp = &pcie->pp;
-	struct device *dev = pp->dev;
+	struct dw_pcie *pci = pcie->pci;
+	struct pcie_port *pp = &pci->pp;
+	struct device *dev = pci->dev;
 	int ret;
 
+	pp->ops = pcie->drvdata->ops;
+
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
 		dev_err(dev, "failed to initialize host\n");
@@ -240,8 +263,8 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	const struct of_device_id *match;
+	struct dw_pcie *pci;
 	struct ls_pcie *pcie;
-	struct pcie_port *pp;
 	struct resource *dbi_base;
 	int ret;
 
@@ -253,17 +276,21 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 	if (!pcie)
 		return -ENOMEM;
 
-	pp = &pcie->pp;
-	pp->dev = dev;
+	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
+	if (!pci)
+		return -ENOMEM;
+
 	pcie->drvdata = match->data;
-	pp->ops = pcie->drvdata->ops;
+
+	pci->dev = dev;
+	pci->ops = pcie->drvdata->dw_pcie_ops;
 
 	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
-	pcie->pp.dbi_base = devm_ioremap_resource(dev, dbi_base);
-	if (IS_ERR(pcie->pp.dbi_base))
-		return PTR_ERR(pcie->pp.dbi_base);
+	pci->dbi_base = devm_ioremap_resource(dev, dbi_base);
+	if (IS_ERR(pci->dbi_base))
+		return PTR_ERR(pci->dbi_base);
 
-	pcie->lut = pcie->pp.dbi_base + pcie->drvdata->lut_offset;
+	pcie->lut = pci->dbi_base + pcie->drvdata->lut_offset;
 
 	if (!ls_pcie_is_bridge(pcie))
 		return -ENODEV;
diff --git a/drivers/pci/dwc/pcie-armada8k.c b/drivers/pci/dwc/pcie-armada8k.c
index 5a28dcb..66bac6f 100644
--- a/drivers/pci/dwc/pcie-armada8k.c
+++ b/drivers/pci/dwc/pcie-armada8k.c
@@ -29,7 +29,7 @@
 #include "pcie-designware.h"
 
 struct armada8k_pcie {
-	struct pcie_port pp;		/* pp.dbi_base is DT ctrl */
+	struct dw_pcie *pci;
 	struct clk *clk;
 };
 
@@ -67,76 +67,77 @@ struct armada8k_pcie {
 #define AX_USER_DOMAIN_MASK		0x3
 #define AX_USER_DOMAIN_SHIFT		4
 
-#define to_armada8k_pcie(x)	container_of(x, struct armada8k_pcie, pp)
+#define to_armada8k_pcie(x)	dev_get_drvdata((x)->dev)
 
-static int armada8k_pcie_link_up(struct pcie_port *pp)
+static int armada8k_pcie_link_up(struct dw_pcie *pci)
 {
 	u32 reg;
 	u32 mask = PCIE_GLB_STS_RDLH_LINK_UP | PCIE_GLB_STS_PHY_LINK_UP;
 
-	reg = dw_pcie_readl_rc(pp, PCIE_GLOBAL_STATUS_REG);
+	reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_STATUS_REG);
 
 	if ((reg & mask) == mask)
 		return 1;
 
-	dev_dbg(pp->dev, "No link detected (Global-Status: 0x%08x).\n", reg);
+	dev_dbg(pci->dev, "No link detected (Global-Status: 0x%08x).\n", reg);
 	return 0;
 }
 
 static void armada8k_pcie_establish_link(struct armada8k_pcie *pcie)
 {
-	struct pcie_port *pp = &pcie->pp;
+	struct dw_pcie *pci = pcie->pci;
 	u32 reg;
 
-	if (!dw_pcie_link_up(pp)) {
+	if (!dw_pcie_link_up(pci)) {
 		/* Disable LTSSM state machine to enable configuration */
-		reg = dw_pcie_readl_rc(pp, PCIE_GLOBAL_CONTROL_REG);
+		reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_CONTROL_REG);
 		reg &= ~(PCIE_APP_LTSSM_EN);
-		dw_pcie_writel_rc(pp, PCIE_GLOBAL_CONTROL_REG, reg);
+		dw_pcie_writel_dbi(pci, PCIE_GLOBAL_CONTROL_REG, reg);
 	}
 
 	/* Set the device to root complex mode */
-	reg = dw_pcie_readl_rc(pp, PCIE_GLOBAL_CONTROL_REG);
+	reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_CONTROL_REG);
 	reg &= ~(PCIE_DEVICE_TYPE_MASK << PCIE_DEVICE_TYPE_SHIFT);
 	reg |= PCIE_DEVICE_TYPE_RC << PCIE_DEVICE_TYPE_SHIFT;
-	dw_pcie_writel_rc(pp, PCIE_GLOBAL_CONTROL_REG, reg);
+	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_CONTROL_REG, reg);
 
 	/* Set the PCIe master AxCache attributes */
-	dw_pcie_writel_rc(pp, PCIE_ARCACHE_TRC_REG, ARCACHE_DEFAULT_VALUE);
-	dw_pcie_writel_rc(pp, PCIE_AWCACHE_TRC_REG, AWCACHE_DEFAULT_VALUE);
+	dw_pcie_writel_dbi(pci, PCIE_ARCACHE_TRC_REG, ARCACHE_DEFAULT_VALUE);
+	dw_pcie_writel_dbi(pci, PCIE_AWCACHE_TRC_REG, AWCACHE_DEFAULT_VALUE);
 
 	/* Set the PCIe master AxDomain attributes */
-	reg = dw_pcie_readl_rc(pp, PCIE_ARUSER_REG);
+	reg = dw_pcie_readl_dbi(pci, PCIE_ARUSER_REG);
 	reg &= ~(AX_USER_DOMAIN_MASK << AX_USER_DOMAIN_SHIFT);
 	reg |= DOMAIN_OUTER_SHAREABLE << AX_USER_DOMAIN_SHIFT;
-	dw_pcie_writel_rc(pp, PCIE_ARUSER_REG, reg);
+	dw_pcie_writel_dbi(pci, PCIE_ARUSER_REG, reg);
 
-	reg = dw_pcie_readl_rc(pp, PCIE_AWUSER_REG);
+	reg = dw_pcie_readl_dbi(pci, PCIE_AWUSER_REG);
 	reg &= ~(AX_USER_DOMAIN_MASK << AX_USER_DOMAIN_SHIFT);
 	reg |= DOMAIN_OUTER_SHAREABLE << AX_USER_DOMAIN_SHIFT;
-	dw_pcie_writel_rc(pp, PCIE_AWUSER_REG, reg);
+	dw_pcie_writel_dbi(pci, PCIE_AWUSER_REG, reg);
 
 	/* Enable INT A-D interrupts */
-	reg = dw_pcie_readl_rc(pp, PCIE_GLOBAL_INT_MASK1_REG);
+	reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_MASK1_REG);
 	reg |= PCIE_INT_A_ASSERT_MASK | PCIE_INT_B_ASSERT_MASK |
 	       PCIE_INT_C_ASSERT_MASK | PCIE_INT_D_ASSERT_MASK;
-	dw_pcie_writel_rc(pp, PCIE_GLOBAL_INT_MASK1_REG, reg);
+	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_MASK1_REG, reg);
 
-	if (!dw_pcie_link_up(pp)) {
+	if (!dw_pcie_link_up(pci)) {
 		/* Configuration done. Start LTSSM */
-		reg = dw_pcie_readl_rc(pp, PCIE_GLOBAL_CONTROL_REG);
+		reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_CONTROL_REG);
 		reg |= PCIE_APP_LTSSM_EN;
-		dw_pcie_writel_rc(pp, PCIE_GLOBAL_CONTROL_REG, reg);
+		dw_pcie_writel_dbi(pci, PCIE_GLOBAL_CONTROL_REG, reg);
 	}
 
 	/* Wait until the link becomes active again */
-	if (dw_pcie_wait_for_link(pp))
-		dev_err(pp->dev, "Link not up after reconfiguration\n");
+	if (dw_pcie_wait_for_link(pci))
+		dev_err(pci->dev, "Link not up after reconfiguration\n");
 }
 
 static void armada8k_pcie_host_init(struct pcie_port *pp)
 {
-	struct armada8k_pcie *pcie = to_armada8k_pcie(pp);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct armada8k_pcie *pcie = to_armada8k_pcie(pci);
 
 	dw_pcie_setup_rc(pp);
 	armada8k_pcie_establish_link(pcie);
@@ -145,7 +146,7 @@ static void armada8k_pcie_host_init(struct pcie_port *pp)
 static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
 {
 	struct armada8k_pcie *pcie = arg;
-	struct pcie_port *pp = &pcie->pp;
+	struct dw_pcie *pci = pcie->pci;
 	u32 val;
 
 	/*
@@ -153,21 +154,21 @@ static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
 	 * PCI device. However, they are also latched into the PCIe
 	 * controller, so we simply discard them.
 	 */
-	val = dw_pcie_readl_rc(pp, PCIE_GLOBAL_INT_CAUSE1_REG);
-	dw_pcie_writel_rc(pp, PCIE_GLOBAL_INT_CAUSE1_REG, val);
+	val = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_CAUSE1_REG);
+	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_CAUSE1_REG, val);
 
 	return IRQ_HANDLED;
 }
 
-static struct pcie_host_ops armada8k_pcie_host_ops = {
-	.link_up = armada8k_pcie_link_up,
+static struct dw_pcie_host_ops armada8k_pcie_host_ops = {
 	.host_init = armada8k_pcie_host_init,
 };
 
 static int armada8k_add_pcie_port(struct armada8k_pcie *pcie,
 				  struct platform_device *pdev)
 {
-	struct pcie_port *pp = &pcie->pp;
+	struct dw_pcie *pci = pcie->pci;
+	struct pcie_port *pp = &pci->pp;
 	struct device *dev = &pdev->dev;
 	int ret;
 
@@ -196,10 +197,14 @@ static int armada8k_add_pcie_port(struct armada8k_pcie *pcie,
 	return 0;
 }
 
+static const struct dw_pcie_ops dw_pcie_ops = {
+	.link_up = armada8k_pcie_link_up,
+};
+
 static int armada8k_pcie_probe(struct platform_device *pdev)
 {
+	struct dw_pcie *pci;
 	struct armada8k_pcie *pcie;
-	struct pcie_port *pp;
 	struct device *dev = &pdev->dev;
 	struct resource *base;
 	int ret;
@@ -208,21 +213,25 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 	if (!pcie)
 		return -ENOMEM;
 
+	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
+	if (!pci)
+		return -ENOMEM;
+
+	pci->dev = dev;
+	pci->ops = &dw_pcie_ops;
+
 	pcie->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(pcie->clk))
 		return PTR_ERR(pcie->clk);
 
 	clk_prepare_enable(pcie->clk);
 
-	pp = &pcie->pp;
-	pp->dev = dev;
-
 	/* Get the dw-pcie unit configuration/control registers base. */
 	base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctrl");
-	pp->dbi_base = devm_ioremap_resource(dev, base);
-	if (IS_ERR(pp->dbi_base)) {
+	pci->dbi_base = devm_ioremap_resource(dev, base);
+	if (IS_ERR(pci->dbi_base)) {
 		dev_err(dev, "couldn't remap regs base %p\n", base);
-		ret = PTR_ERR(pp->dbi_base);
+		ret = PTR_ERR(pci->dbi_base);
 		goto fail;
 	}
 
diff --git a/drivers/pci/dwc/pcie-artpec6.c b/drivers/pci/dwc/pcie-artpec6.c
index 187a98d..59ecc9e 100644
--- a/drivers/pci/dwc/pcie-artpec6.c
+++ b/drivers/pci/dwc/pcie-artpec6.c
@@ -24,10 +24,10 @@
 
 #include "pcie-designware.h"
 
-#define to_artpec6_pcie(x)	container_of(x, struct artpec6_pcie, pp)
+#define to_artpec6_pcie(x)	dev_get_drvdata((x)->dev)
 
 struct artpec6_pcie {
-	struct pcie_port	pp;		/* pp.dbi_base is DT dbi */
+	struct dw_pcie		*pci;
 	struct regmap		*regmap;	/* DT axis,syscon-pcie */
 	void __iomem		*phy_base;	/* DT phy */
 };
@@ -80,7 +80,8 @@ static void artpec6_pcie_writel(struct artpec6_pcie *artpec6_pcie, u32 offset, u
 
 static int artpec6_pcie_establish_link(struct artpec6_pcie *artpec6_pcie)
 {
-	struct pcie_port *pp = &artpec6_pcie->pp;
+	struct dw_pcie *pci = artpec6_pcie->pci;
+	struct pcie_port *pp = &pci->pp;
 	u32 val;
 	unsigned int retries;
 
@@ -139,7 +140,7 @@ static int artpec6_pcie_establish_link(struct artpec6_pcie *artpec6_pcie)
 	 * Enable writing to config regs. This is required as the Synopsys
 	 * driver changes the class code. That register needs DBI write enable.
 	 */
-	dw_pcie_writel_rc(pp, MISC_CONTROL_1_OFF, DBI_RO_WR_EN);
+	dw_pcie_writel_dbi(pci, MISC_CONTROL_1_OFF, DBI_RO_WR_EN);
 
 	pp->io_base &= ARTPEC6_CPU_TO_BUS_ADDR;
 	pp->mem_base &= ARTPEC6_CPU_TO_BUS_ADDR;
@@ -155,19 +156,20 @@ static int artpec6_pcie_establish_link(struct artpec6_pcie *artpec6_pcie)
 	artpec6_pcie_writel(artpec6_pcie, PCIECFG, val);
 
 	/* check if the link is up or not */
-	if (!dw_pcie_wait_for_link(pp))
+	if (!dw_pcie_wait_for_link(pci))
 		return 0;
 
-	dev_dbg(pp->dev, "DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
-		dw_pcie_readl_rc(pp, PCIE_PHY_DEBUG_R0),
-		dw_pcie_readl_rc(pp, PCIE_PHY_DEBUG_R1));
+	dev_dbg(pci->dev, "DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
+		dw_pcie_readl_dbi(pci, PCIE_PHY_DEBUG_R0),
+		dw_pcie_readl_dbi(pci, PCIE_PHY_DEBUG_R1));
 
 	return -ETIMEDOUT;
 }
 
 static void artpec6_pcie_enable_interrupts(struct artpec6_pcie *artpec6_pcie)
 {
-	struct pcie_port *pp = &artpec6_pcie->pp;
+	struct dw_pcie *pci = artpec6_pcie->pci;
+	struct pcie_port *pp = &pci->pp;
 
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		dw_pcie_msi_init(pp);
@@ -175,20 +177,22 @@ static void artpec6_pcie_enable_interrupts(struct artpec6_pcie *artpec6_pcie)
 
 static void artpec6_pcie_host_init(struct pcie_port *pp)
 {
-	struct artpec6_pcie *artpec6_pcie = to_artpec6_pcie(pp);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct artpec6_pcie *artpec6_pcie = to_artpec6_pcie(pci);
 
 	artpec6_pcie_establish_link(artpec6_pcie);
 	artpec6_pcie_enable_interrupts(artpec6_pcie);
 }
 
-static struct pcie_host_ops artpec6_pcie_host_ops = {
+static struct dw_pcie_host_ops artpec6_pcie_host_ops = {
 	.host_init = artpec6_pcie_host_init,
 };
 
 static irqreturn_t artpec6_pcie_msi_handler(int irq, void *arg)
 {
 	struct artpec6_pcie *artpec6_pcie = arg;
-	struct pcie_port *pp = &artpec6_pcie->pp;
+	struct dw_pcie *pci = artpec6_pcie->pci;
+	struct pcie_port *pp = &pci->pp;
 
 	return dw_handle_msi_irq(pp);
 }
@@ -196,8 +200,9 @@ static irqreturn_t artpec6_pcie_msi_handler(int irq, void *arg)
 static int artpec6_add_pcie_port(struct artpec6_pcie *artpec6_pcie,
 				 struct platform_device *pdev)
 {
-	struct pcie_port *pp = &artpec6_pcie->pp;
-	struct device *dev = pp->dev;
+	struct dw_pcie *pci = artpec6_pcie->pci;
+	struct pcie_port *pp = &pci->pp;
+	struct device *dev = pci->dev;
 	int ret;
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
@@ -232,8 +237,8 @@ static int artpec6_add_pcie_port(struct artpec6_pcie *artpec6_pcie,
 static int artpec6_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct dw_pcie *pci;
 	struct artpec6_pcie *artpec6_pcie;
-	struct pcie_port *pp;
 	struct resource *dbi_base;
 	struct resource *phy_base;
 	int ret;
@@ -242,13 +247,16 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
 	if (!artpec6_pcie)
 		return -ENOMEM;
 
-	pp = &artpec6_pcie->pp;
-	pp->dev = dev;
+	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
+	if (!pci)
+		return -ENOMEM;
+
+	pci->dev = dev;
 
 	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
-	pp->dbi_base = devm_ioremap_resource(dev, dbi_base);
-	if (IS_ERR(pp->dbi_base))
-		return PTR_ERR(pp->dbi_base);
+	pci->dbi_base = devm_ioremap_resource(dev, dbi_base);
+	if (IS_ERR(pci->dbi_base))
+		return PTR_ERR(pci->dbi_base);
 
 	phy_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy");
 	artpec6_pcie->phy_base = devm_ioremap_resource(dev, phy_base);
diff --git a/drivers/pci/dwc/pcie-designware-plat.c b/drivers/pci/dwc/pcie-designware-plat.c
index bb58540..65250f6 100644
--- a/drivers/pci/dwc/pcie-designware-plat.c
+++ b/drivers/pci/dwc/pcie-designware-plat.c
@@ -25,7 +25,7 @@
 #include "pcie-designware.h"
 
 struct dw_plat_pcie {
-	struct pcie_port	pp;	/* pp.dbi_base is DT 0th resource */
+	struct dw_pcie		*pci;
 };
 
 static irqreturn_t dw_plat_pcie_msi_irq_handler(int irq, void *arg)
@@ -37,21 +37,23 @@ static irqreturn_t dw_plat_pcie_msi_irq_handler(int irq, void *arg)
 
 static void dw_plat_pcie_host_init(struct pcie_port *pp)
 {
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+
 	dw_pcie_setup_rc(pp);
-	dw_pcie_wait_for_link(pp);
+	dw_pcie_wait_for_link(pci);
 
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		dw_pcie_msi_init(pp);
 }
 
-static struct pcie_host_ops dw_plat_pcie_host_ops = {
+static struct dw_pcie_host_ops dw_plat_pcie_host_ops = {
 	.host_init = dw_plat_pcie_host_init,
 };
 
 static int dw_plat_add_pcie_port(struct pcie_port *pp,
 				 struct platform_device *pdev)
 {
-	struct device *dev = pp->dev;
+	struct device *dev = &pdev->dev;
 	int ret;
 
 	pp->irq = platform_get_irq(pdev, 1);
@@ -88,7 +90,7 @@ static int dw_plat_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct dw_plat_pcie *dw_plat_pcie;
-	struct pcie_port *pp;
+	struct dw_pcie *pci;
 	struct resource *res;  /* Resource from DT */
 	int ret;
 
@@ -96,17 +98,20 @@ static int dw_plat_pcie_probe(struct platform_device *pdev)
 	if (!dw_plat_pcie)
 		return -ENOMEM;
 
-	pp = &dw_plat_pcie->pp;
-	pp->dev = dev;
+	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
+	if (!pci)
+		return -ENOMEM;
+
+	pci->dev = dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pp->dbi_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(pp->dbi_base))
-		return PTR_ERR(pp->dbi_base);
+	pci->dbi_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(pci->dbi_base))
+		return PTR_ERR(pci->dbi_base);
 
 	platform_set_drvdata(pdev, dw_plat_pcie);
 
-	ret = dw_plat_add_pcie_port(pp, pdev);
+	ret = dw_plat_add_pcie_port(&pci->pp, pdev);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-designware.c
index 330596b..00a0fdc 100644
--- a/drivers/pci/dwc/pcie-designware.c
+++ b/drivers/pci/dwc/pcie-designware.c
@@ -71,93 +71,100 @@ int dw_pcie_write(void __iomem *addr, int size, u32 val)
 	return PCIBIOS_SUCCESSFUL;
 }
 
-u32 dw_pcie_readl_rc(struct pcie_port *pp, u32 reg)
+u32 dw_pcie_readl_dbi(struct dw_pcie *pci, u32 reg)
 {
-	if (pp->ops->readl_rc)
-		return pp->ops->readl_rc(pp, reg);
+	if (pci->ops->readl_dbi)
+		return pci->ops->readl_dbi(pci, reg);
 
-	return readl(pp->dbi_base + reg);
+	return readl(pci->dbi_base + reg);
 }
 
-void dw_pcie_writel_rc(struct pcie_port *pp, u32 reg, u32 val)
+void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
 {
-	if (pp->ops->writel_rc)
-		pp->ops->writel_rc(pp, reg, val);
+	if (pci->ops->writel_dbi)
+		pci->ops->writel_dbi(pci, reg, val);
 	else
-		writel(val, pp->dbi_base + reg);
+		writel(val, pci->dbi_base + reg);
 }
 
-static u32 dw_pcie_readl_unroll(struct pcie_port *pp, u32 index, u32 reg)
+static u32 dw_pcie_readl_unroll(struct dw_pcie *pci, u32 index, u32 reg)
 {
 	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
 
-	return dw_pcie_readl_rc(pp, offset + reg);
+	return dw_pcie_readl_dbi(pci, offset + reg);
 }
 
-static void dw_pcie_writel_unroll(struct pcie_port *pp, u32 index, u32 reg,
+static void dw_pcie_writel_unroll(struct dw_pcie *pci, u32 index, u32 reg,
 				  u32 val)
 {
 	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
 
-	dw_pcie_writel_rc(pp, offset + reg, val);
+	dw_pcie_writel_dbi(pci, offset + reg, val);
 }
 
 static int dw_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
 			       u32 *val)
 {
+	struct dw_pcie *pci;
+
 	if (pp->ops->rd_own_conf)
 		return pp->ops->rd_own_conf(pp, where, size, val);
 
-	return dw_pcie_read(pp->dbi_base + where, size, val);
+	pci = to_dw_pcie_from_pp(pp);
+	return dw_pcie_read(pci->dbi_base + where, size, val);
 }
 
 static int dw_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
 			       u32 val)
 {
+	struct dw_pcie *pci;
+
 	if (pp->ops->wr_own_conf)
 		return pp->ops->wr_own_conf(pp, where, size, val);
 
-	return dw_pcie_write(pp->dbi_base + where, size, val);
+	pci = to_dw_pcie_from_pp(pp);
+	return dw_pcie_write(pci->dbi_base + where, size, val);
 }
 
-static void dw_pcie_prog_outbound_atu(struct pcie_port *pp, int index,
-		int type, u64 cpu_addr, u64 pci_addr, u32 size)
+static void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
+				      int type, u64 cpu_addr, u64 pci_addr,
+				      u32 size)
 {
 	u32 retries, val;
 
-	if (pp->ops->cpu_addr_fixup)
-		cpu_addr = pp->ops->cpu_addr_fixup(cpu_addr);
-
-	if (pp->iatu_unroll_enabled) {
-		dw_pcie_writel_unroll(pp, index, PCIE_ATU_UNR_LOWER_BASE,
-			lower_32_bits(cpu_addr));
-		dw_pcie_writel_unroll(pp, index, PCIE_ATU_UNR_UPPER_BASE,
-			upper_32_bits(cpu_addr));
-		dw_pcie_writel_unroll(pp, index, PCIE_ATU_UNR_LIMIT,
-			lower_32_bits(cpu_addr + size - 1));
-		dw_pcie_writel_unroll(pp, index, PCIE_ATU_UNR_LOWER_TARGET,
-			lower_32_bits(pci_addr));
-		dw_pcie_writel_unroll(pp, index, PCIE_ATU_UNR_UPPER_TARGET,
-			upper_32_bits(pci_addr));
-		dw_pcie_writel_unroll(pp, index, PCIE_ATU_UNR_REGION_CTRL1,
-			type);
-		dw_pcie_writel_unroll(pp, index, PCIE_ATU_UNR_REGION_CTRL2,
-			PCIE_ATU_ENABLE);
+	if (pci->ops->cpu_addr_fixup)
+		cpu_addr = pci->ops->cpu_addr_fixup(cpu_addr);
+
+	if (pci->iatu_unroll_enabled) {
+		dw_pcie_writel_unroll(pci, index, PCIE_ATU_UNR_LOWER_BASE,
+				      lower_32_bits(cpu_addr));
+		dw_pcie_writel_unroll(pci, index, PCIE_ATU_UNR_UPPER_BASE,
+				      upper_32_bits(cpu_addr));
+		dw_pcie_writel_unroll(pci, index, PCIE_ATU_UNR_LIMIT,
+				      lower_32_bits(cpu_addr + size - 1));
+		dw_pcie_writel_unroll(pci, index, PCIE_ATU_UNR_LOWER_TARGET,
+				      lower_32_bits(pci_addr));
+		dw_pcie_writel_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
+				      upper_32_bits(pci_addr));
+		dw_pcie_writel_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1,
+				      type);
+		dw_pcie_writel_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
+				      PCIE_ATU_ENABLE);
 	} else {
-		dw_pcie_writel_rc(pp, PCIE_ATU_VIEWPORT,
-				  PCIE_ATU_REGION_OUTBOUND | index);
-		dw_pcie_writel_rc(pp, PCIE_ATU_LOWER_BASE,
-				  lower_32_bits(cpu_addr));
-		dw_pcie_writel_rc(pp, PCIE_ATU_UPPER_BASE,
-				  upper_32_bits(cpu_addr));
-		dw_pcie_writel_rc(pp, PCIE_ATU_LIMIT,
-				  lower_32_bits(cpu_addr + size - 1));
-		dw_pcie_writel_rc(pp, PCIE_ATU_LOWER_TARGET,
-				  lower_32_bits(pci_addr));
-		dw_pcie_writel_rc(pp, PCIE_ATU_UPPER_TARGET,
-				  upper_32_bits(pci_addr));
-		dw_pcie_writel_rc(pp, PCIE_ATU_CR1, type);
-		dw_pcie_writel_rc(pp, PCIE_ATU_CR2, PCIE_ATU_ENABLE);
+		dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT,
+				   PCIE_ATU_REGION_OUTBOUND | index);
+		dw_pcie_writel_dbi(pci, PCIE_ATU_LOWER_BASE,
+				   lower_32_bits(cpu_addr));
+		dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_BASE,
+				   upper_32_bits(cpu_addr));
+		dw_pcie_writel_dbi(pci, PCIE_ATU_LIMIT,
+				   lower_32_bits(cpu_addr + size - 1));
+		dw_pcie_writel_dbi(pci, PCIE_ATU_LOWER_TARGET,
+				   lower_32_bits(pci_addr));
+		dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_TARGET,
+				   upper_32_bits(pci_addr));
+		dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, type);
+		dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, PCIE_ATU_ENABLE);
 	}
 
 	/*
@@ -165,18 +172,18 @@ static void dw_pcie_prog_outbound_atu(struct pcie_port *pp, int index,
 	 * and I/O accesses.
 	 */
 	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
-		if (pp->iatu_unroll_enabled)
-			val = dw_pcie_readl_unroll(pp, index,
+		if (pci->iatu_unroll_enabled)
+			val = dw_pcie_readl_unroll(pci, index,
 						   PCIE_ATU_UNR_REGION_CTRL2);
 		else
-			val = dw_pcie_readl_rc(pp, PCIE_ATU_CR2);
+			val = dw_pcie_readl_dbi(pci, PCIE_ATU_CR2);
 
 		if (val == PCIE_ATU_ENABLE)
 			return;
 
 		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
 	}
-	dev_err(pp->dev, "iATU is not being enabled\n");
+	dev_err(pci->dev, "iATU is not being enabled\n");
 }
 
 static struct irq_chip dw_msi_irq_chip = {
@@ -393,32 +400,32 @@ static void dw_msi_teardown_irq(struct msi_controller *chip, unsigned int irq)
 	.teardown_irq = dw_msi_teardown_irq,
 };
 
-int dw_pcie_wait_for_link(struct pcie_port *pp)
+int dw_pcie_wait_for_link(struct dw_pcie *pci)
 {
 	int retries;
 
 	/* check if the link is up or not */
 	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
-		if (dw_pcie_link_up(pp)) {
-			dev_info(pp->dev, "link up\n");
+		if (dw_pcie_link_up(pci)) {
+			dev_info(pci->dev, "link up\n");
 			return 0;
 		}
 		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
 	}
 
-	dev_err(pp->dev, "phy link never came up\n");
+	dev_err(pci->dev, "phy link never came up\n");
 
 	return -ETIMEDOUT;
 }
 
-int dw_pcie_link_up(struct pcie_port *pp)
+int dw_pcie_link_up(struct dw_pcie *pci)
 {
 	u32 val;
 
-	if (pp->ops->link_up)
-		return pp->ops->link_up(pp);
+	if (pci->ops->link_up)
+		return pci->ops->link_up(pci);
 
-	val = readl(pp->dbi_base + PCIE_PHY_DEBUG_R1);
+	val = readl(pci->dbi_base + PCIE_PHY_DEBUG_R1);
 	return ((val & PCIE_PHY_DEBUG_R1_LINK_UP) &&
 		(!(val & PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING)));
 }
@@ -436,11 +443,11 @@ static int dw_pcie_msi_map(struct irq_domain *domain, unsigned int irq,
 	.map = dw_pcie_msi_map,
 };
 
-static u8 dw_pcie_iatu_unroll_enabled(struct pcie_port *pp)
+static u8 dw_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
 {
 	u32 val;
 
-	val = dw_pcie_readl_rc(pp, PCIE_ATU_VIEWPORT);
+	val = dw_pcie_readl_dbi(pci, PCIE_ATU_VIEWPORT);
 	if (val == 0xffffffff)
 		return 1;
 
@@ -449,7 +456,8 @@ static u8 dw_pcie_iatu_unroll_enabled(struct pcie_port *pp)
 
 int dw_pcie_host_init(struct pcie_port *pp)
 {
-	struct device *dev = pp->dev;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct device *dev = pci->dev;
 	struct device_node *np = dev->of_node;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct pci_bus *bus, *child;
@@ -543,13 +551,13 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		}
 	}
 
-	ret = of_property_read_u32(np, "num-lanes", &pp->lanes);
+	ret = of_property_read_u32(np, "num-lanes", &pci->lanes);
 	if (ret)
-		pp->lanes = 0;
+		pci->lanes = 0;
 
-	ret = of_property_read_u32(np, "num-viewport", &pp->num_viewport);
+	ret = of_property_read_u32(np, "num-viewport", &pci->num_viewport);
 	if (ret)
-		pp->num_viewport = 2;
+		pci->num_viewport = 2;
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		if (!pp->ops->msi_host_init) {
@@ -617,6 +625,7 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 	u32 busdev, cfg_size;
 	u64 cpu_addr;
 	void __iomem *va_cfg_base;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
 	if (pp->ops->rd_other_conf)
 		return pp->ops->rd_other_conf(pp, bus, devfn, where, size, val);
@@ -636,12 +645,12 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 		va_cfg_base = pp->va_cfg1_base;
 	}
 
-	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
+	dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX1,
 				  type, cpu_addr,
 				  busdev, cfg_size);
 	ret = dw_pcie_read(va_cfg_base + where, size, val);
-	if (pp->num_viewport <= 2)
-		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
+	if (pci->num_viewport <= 2)
+		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX1,
 					  PCIE_ATU_TYPE_IO, pp->io_base,
 					  pp->io_bus_addr, pp->io_size);
 
@@ -655,6 +664,7 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 	u32 busdev, cfg_size;
 	u64 cpu_addr;
 	void __iomem *va_cfg_base;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
 	if (pp->ops->wr_other_conf)
 		return pp->ops->wr_other_conf(pp, bus, devfn, where, size, val);
@@ -674,12 +684,12 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 		va_cfg_base = pp->va_cfg1_base;
 	}
 
-	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
+	dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX1,
 				  type, cpu_addr,
 				  busdev, cfg_size);
 	ret = dw_pcie_write(va_cfg_base + where, size, val);
-	if (pp->num_viewport <= 2)
-		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
+	if (pci->num_viewport <= 2)
+		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX1,
 					  PCIE_ATU_TYPE_IO, pp->io_base,
 					  pp->io_bus_addr, pp->io_size);
 
@@ -689,9 +699,11 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 static int dw_pcie_valid_device(struct pcie_port *pp, struct pci_bus *bus,
 				int dev)
 {
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+
 	/* If there is no link, then there is no device */
 	if (bus->number != pp->root_bus_nr) {
-		if (!dw_pcie_link_up(pp))
+		if (!dw_pcie_link_up(pci))
 			return 0;
 	}
 
@@ -740,16 +752,17 @@ static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 void dw_pcie_setup_rc(struct pcie_port *pp)
 {
 	u32 val;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
 	/* get iATU unroll support */
-	pp->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pp);
-	dev_dbg(pp->dev, "iATU unroll: %s\n",
-		pp->iatu_unroll_enabled ? "enabled" : "disabled");
+	pci->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pci);
+	dev_dbg(pci->dev, "iATU unroll: %s\n",
+		pci->iatu_unroll_enabled ? "enabled" : "disabled");
 
 	/* set the number of lanes */
-	val = dw_pcie_readl_rc(pp, PCIE_PORT_LINK_CONTROL);
+	val = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
 	val &= ~PORT_LINK_MODE_MASK;
-	switch (pp->lanes) {
+	switch (pci->lanes) {
 	case 1:
 		val |= PORT_LINK_MODE_1_LANES;
 		break;
@@ -763,15 +776,15 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 		val |= PORT_LINK_MODE_8_LANES;
 		break;
 	default:
-		dev_err(pp->dev, "num-lanes %u: invalid value\n", pp->lanes);
+		dev_err(pci->dev, "num-lanes %u: invalid value\n", pci->lanes);
 		return;
 	}
-	dw_pcie_writel_rc(pp, PCIE_PORT_LINK_CONTROL, val);
+	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
 
 	/* set link width speed control register */
-	val = dw_pcie_readl_rc(pp, PCIE_LINK_WIDTH_SPEED_CONTROL);
+	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
 	val &= ~PORT_LOGIC_LINK_WIDTH_MASK;
-	switch (pp->lanes) {
+	switch (pci->lanes) {
 	case 1:
 		val |= PORT_LOGIC_LINK_WIDTH_1_LANES;
 		break;
@@ -785,30 +798,30 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 		val |= PORT_LOGIC_LINK_WIDTH_8_LANES;
 		break;
 	}
-	dw_pcie_writel_rc(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
+	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
 
 	/* setup RC BARs */
-	dw_pcie_writel_rc(pp, PCI_BASE_ADDRESS_0, 0x00000004);
-	dw_pcie_writel_rc(pp, PCI_BASE_ADDRESS_1, 0x00000000);
+	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0x00000004);
+	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_1, 0x00000000);
 
 	/* setup interrupt pins */
-	val = dw_pcie_readl_rc(pp, PCI_INTERRUPT_LINE);
+	val = dw_pcie_readl_dbi(pci, PCI_INTERRUPT_LINE);
 	val &= 0xffff00ff;
 	val |= 0x00000100;
-	dw_pcie_writel_rc(pp, PCI_INTERRUPT_LINE, val);
+	dw_pcie_writel_dbi(pci, PCI_INTERRUPT_LINE, val);
 
 	/* setup bus numbers */
-	val = dw_pcie_readl_rc(pp, PCI_PRIMARY_BUS);
+	val = dw_pcie_readl_dbi(pci, PCI_PRIMARY_BUS);
 	val &= 0xff000000;
 	val |= 0x00010100;
-	dw_pcie_writel_rc(pp, PCI_PRIMARY_BUS, val);
+	dw_pcie_writel_dbi(pci, PCI_PRIMARY_BUS, val);
 
 	/* setup command register */
-	val = dw_pcie_readl_rc(pp, PCI_COMMAND);
+	val = dw_pcie_readl_dbi(pci, PCI_COMMAND);
 	val &= 0xffff0000;
 	val |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
 		PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
-	dw_pcie_writel_rc(pp, PCI_COMMAND, val);
+	dw_pcie_writel_dbi(pci, PCI_COMMAND, val);
 
 	/*
 	 * If the platform provides ->rd_other_conf, it means the platform
@@ -816,11 +829,11 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	 * we should not program the ATU here.
 	 */
 	if (!pp->ops->rd_other_conf) {
-		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
+		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX0,
 					  PCIE_ATU_TYPE_MEM, pp->mem_base,
 					  pp->mem_bus_addr, pp->mem_size);
-		if (pp->num_viewport > 2)
-			dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX2,
+		if (pci->num_viewport > 2)
+			dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX2,
 						  PCIE_ATU_TYPE_IO, pp->io_base,
 						  pp->io_bus_addr, pp->io_size);
 	}
diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
index b6ddb05..d4b3d43 100644
--- a/drivers/pci/dwc/pcie-designware.h
+++ b/drivers/pci/dwc/pcie-designware.h
@@ -93,10 +93,27 @@
 #define MAX_MSI_IRQS			32
 #define MAX_MSI_CTRLS			(MAX_MSI_IRQS / 32)
 
+struct pcie_port;
+struct dw_pcie;
+
+struct dw_pcie_host_ops {
+	int (*rd_own_conf)(struct pcie_port *pp, int where, int size, u32 *val);
+	int (*wr_own_conf)(struct pcie_port *pp, int where, int size, u32 val);
+	int (*rd_other_conf)(struct pcie_port *pp, struct pci_bus *bus,
+			     unsigned int devfn, int where, int size, u32 *val);
+	int (*wr_other_conf)(struct pcie_port *pp, struct pci_bus *bus,
+			     unsigned int devfn, int where, int size, u32 val);
+	void (*host_init)(struct pcie_port *pp);
+	void (*msi_set_irq)(struct pcie_port *pp, int irq);
+	void (*msi_clear_irq)(struct pcie_port *pp, int irq);
+	phys_addr_t (*get_msi_addr)(struct pcie_port *pp);
+	u32 (*get_msi_data)(struct pcie_port *pp, int pos);
+	void (*scan_bus)(struct pcie_port *pp);
+	int (*msi_host_init)(struct pcie_port *pp, struct msi_controller *chip);
+};
+
 struct pcie_port {
-	struct device		*dev;
 	u8			root_bus_nr;
-	void __iomem		*dbi_base;
 	u64			cfg0_base;
 	void __iomem		*va_cfg0_base;
 	u32			cfg0_size;
@@ -114,45 +131,41 @@ struct pcie_port {
 	struct resource		*mem;
 	struct resource		*busn;
 	int			irq;
-	u32			lanes;
-	u32			num_viewport;
-	struct pcie_host_ops	*ops;
+	struct dw_pcie_host_ops	*ops;
 	int			msi_irq;
 	struct irq_domain	*irq_domain;
 	unsigned long		msi_data;
-	u8			iatu_unroll_enabled;
 	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
 };
 
-struct pcie_host_ops {
-	u64 (*cpu_addr_fixup)(u64 cpu_addr);
-	u32 (*readl_rc)(struct pcie_port *pp, u32 reg);
-	void (*writel_rc)(struct pcie_port *pp, u32 reg, u32 val);
-	int (*rd_own_conf)(struct pcie_port *pp, int where, int size, u32 *val);
-	int (*wr_own_conf)(struct pcie_port *pp, int where, int size, u32 val);
-	int (*rd_other_conf)(struct pcie_port *pp, struct pci_bus *bus,
-			unsigned int devfn, int where, int size, u32 *val);
-	int (*wr_other_conf)(struct pcie_port *pp, struct pci_bus *bus,
-			unsigned int devfn, int where, int size, u32 val);
-	int (*link_up)(struct pcie_port *pp);
-	void (*host_init)(struct pcie_port *pp);
-	void (*msi_set_irq)(struct pcie_port *pp, int irq);
-	void (*msi_clear_irq)(struct pcie_port *pp, int irq);
-	phys_addr_t (*get_msi_addr)(struct pcie_port *pp);
-	u32 (*get_msi_data)(struct pcie_port *pp, int pos);
-	void (*scan_bus)(struct pcie_port *pp);
-	int (*msi_host_init)(struct pcie_port *pp, struct msi_controller *chip);
+struct dw_pcie_ops {
+	u64	(*cpu_addr_fixup)(u64 cpu_addr);
+	u32	(*readl_dbi)(struct dw_pcie *pcie, u32 reg);
+	void	(*writel_dbi)(struct dw_pcie *pcie, u32 reg, u32 val);
+	int	(*link_up)(struct dw_pcie *pcie);
 };
 
-u32 dw_pcie_readl_rc(struct pcie_port *pp, u32 reg);
-void dw_pcie_writel_rc(struct pcie_port *pp, u32 reg, u32 val);
+struct dw_pcie {
+	struct device		*dev;
+	void __iomem		*dbi_base;
+	u32			lanes;
+	u32			num_viewport;
+	u8			iatu_unroll_enabled;
+	struct pcie_port	pp;
+	const struct dw_pcie_ops *ops;
+};
+
+#define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
+
 int dw_pcie_read(void __iomem *addr, int size, u32 *val);
 int dw_pcie_write(void __iomem *addr, int size, u32 val);
 irqreturn_t dw_handle_msi_irq(struct pcie_port *pp);
 void dw_pcie_msi_init(struct pcie_port *pp);
-int dw_pcie_wait_for_link(struct pcie_port *pp);
-int dw_pcie_link_up(struct pcie_port *pp);
 void dw_pcie_setup_rc(struct pcie_port *pp);
 int dw_pcie_host_init(struct pcie_port *pp);
 
+u32 dw_pcie_readl_dbi(struct dw_pcie *pci, u32 reg);
+void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val);
+int dw_pcie_link_up(struct dw_pcie *pci);
+int dw_pcie_wait_for_link(struct dw_pcie *pci);
 #endif /* _PCIE_DESIGNWARE_H */
diff --git a/drivers/pci/dwc/pcie-hisi.c b/drivers/pci/dwc/pcie-hisi.c
index ecc1b08..386467a 100644
--- a/drivers/pci/dwc/pcie-hisi.c
+++ b/drivers/pci/dwc/pcie-hisi.c
@@ -127,7 +127,7 @@ struct pci_ecam_ops hisi_pcie_ops = {
 #define PCIE_LTSSM_LINKUP_STATE			0x11
 #define PCIE_LTSSM_STATE_MASK			0x3F
 
-#define to_hisi_pcie(x)	container_of(x, struct hisi_pcie, pp)
+#define to_hisi_pcie(x)	dev_get_drvdata((x)->dev)
 
 struct hisi_pcie;
 
@@ -136,7 +136,7 @@ struct pcie_soc_ops {
 };
 
 struct hisi_pcie {
-	struct pcie_port pp;		/* pp.dbi_base is DT rc_dbi */
+	struct dw_pcie *pci;
 	struct regmap *subctrl;
 	u32 port_id;
 	struct pcie_soc_ops *soc_ops;
@@ -149,10 +149,11 @@ static int hisi_pcie_cfg_read(struct pcie_port *pp, int where, int size,
 	u32 reg;
 	u32 reg_val;
 	void *walker = &reg_val;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
 	walker += (where & 0x3);
 	reg = where & ~0x3;
-	reg_val = dw_pcie_readl_rc(pp, reg);
+	reg_val = dw_pcie_readl_dbi(pci, reg);
 
 	if (size == 1)
 		*val = *(u8 __force *) walker;
@@ -173,19 +174,20 @@ static int hisi_pcie_cfg_write(struct pcie_port *pp, int where, int  size,
 	u32 reg_val;
 	u32 reg;
 	void *walker = &reg_val;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
 	walker += (where & 0x3);
 	reg = where & ~0x3;
 	if (size == 4)
-		dw_pcie_writel_rc(pp, reg, val);
+		dw_pcie_writel_dbi(pci, reg, val);
 	else if (size == 2) {
-		reg_val = dw_pcie_readl_rc(pp, reg);
+		reg_val = dw_pcie_readl_dbi(pci, reg);
 		*(u16 __force *) walker = val;
-		dw_pcie_writel_rc(pp, reg, reg_val);
+		dw_pcie_writel_dbi(pci, reg, reg_val);
 	} else if (size == 1) {
-		reg_val = dw_pcie_readl_rc(pp, reg);
+		reg_val = dw_pcie_readl_dbi(pci, reg);
 		*(u8 __force *) walker = val;
-		dw_pcie_writel_rc(pp, reg, reg_val);
+		dw_pcie_writel_dbi(pci, reg, reg_val);
 	} else
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
@@ -204,32 +206,32 @@ static int hisi_pcie_link_up_hip05(struct hisi_pcie *hisi_pcie)
 
 static int hisi_pcie_link_up_hip06(struct hisi_pcie *hisi_pcie)
 {
-	struct pcie_port *pp = &hisi_pcie->pp;
+	struct dw_pcie *pci = hisi_pcie->pci;
 	u32 val;
 
-	val = dw_pcie_readl_rc(pp, PCIE_SYS_STATE4);
+	val = dw_pcie_readl_dbi(pci, PCIE_SYS_STATE4);
 
 	return ((val & PCIE_LTSSM_STATE_MASK) == PCIE_LTSSM_LINKUP_STATE);
 }
 
-static int hisi_pcie_link_up(struct pcie_port *pp)
+static int hisi_pcie_link_up(struct dw_pcie *pci)
 {
-	struct hisi_pcie *hisi_pcie = to_hisi_pcie(pp);
+	struct hisi_pcie *hisi_pcie = to_hisi_pcie(pci);
 
 	return hisi_pcie->soc_ops->hisi_pcie_link_up(hisi_pcie);
 }
 
-static struct pcie_host_ops hisi_pcie_host_ops = {
+static struct dw_pcie_host_ops hisi_pcie_host_ops = {
 	.rd_own_conf = hisi_pcie_cfg_read,
 	.wr_own_conf = hisi_pcie_cfg_write,
-	.link_up = hisi_pcie_link_up,
 };
 
 static int hisi_add_pcie_port(struct hisi_pcie *hisi_pcie,
 			      struct platform_device *pdev)
 {
-	struct pcie_port *pp = &hisi_pcie->pp;
-	struct device *dev = pp->dev;
+	struct dw_pcie *pci = hisi_pcie->pci;
+	struct pcie_port *pp = &pci->pp;
+	struct device *dev = &pdev->dev;
 	int ret;
 	u32 port_id;
 
@@ -254,11 +256,15 @@ static int hisi_add_pcie_port(struct hisi_pcie *hisi_pcie,
 	return 0;
 }
 
+static const struct dw_pcie_ops dw_pcie_ops = {
+	.link_up = hisi_pcie_link_up,
+};
+
 static int hisi_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct dw_pcie *pci;
 	struct hisi_pcie *hisi_pcie;
-	struct pcie_port *pp;
 	const struct of_device_id *match;
 	struct resource *reg;
 	struct device_driver *driver;
@@ -268,8 +274,13 @@ static int hisi_pcie_probe(struct platform_device *pdev)
 	if (!hisi_pcie)
 		return -ENOMEM;
 
-	pp = &hisi_pcie->pp;
-	pp->dev = dev;
+	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
+	if (!pci)
+		return -ENOMEM;
+
+	pci->dev = dev;
+	pci->ops = &dw_pcie_ops;
+
 	driver = dev->driver;
 
 	match = of_match_device(driver->of_match_table, dev);
@@ -283,9 +294,9 @@ static int hisi_pcie_probe(struct platform_device *pdev)
 	}
 
 	reg = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rc_dbi");
-	pp->dbi_base = devm_ioremap_resource(dev, reg);
-	if (IS_ERR(pp->dbi_base))
-		return PTR_ERR(pp->dbi_base);
+	pci->dbi_base = devm_ioremap_resource(dev, reg);
+	if (IS_ERR(pci->dbi_base))
+		return PTR_ERR(pci->dbi_base);
 
 	platform_set_drvdata(pdev, hisi_pcie);
 
diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
index d75fc02..9879977 100644
--- a/drivers/pci/dwc/pcie-qcom.c
+++ b/drivers/pci/dwc/pcie-qcom.c
@@ -103,7 +103,7 @@ struct qcom_pcie_ops {
 };
 
 struct qcom_pcie {
-	struct pcie_port pp;			/* pp.dbi_base is DT dbi */
+	struct dw_pcie *pci;
 	void __iomem *parf;			/* DT parf */
 	void __iomem *elbi;			/* DT elbi */
 	union qcom_pcie_resources res;
@@ -112,7 +112,7 @@ struct qcom_pcie {
 	struct qcom_pcie_ops *ops;
 };
 
-#define to_qcom_pcie(x)		container_of(x, struct qcom_pcie, pp)
+#define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
 
 static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
 {
@@ -155,21 +155,23 @@ static void qcom_pcie_v2_ltssm_enable(struct qcom_pcie *pcie)
 
 static int qcom_pcie_establish_link(struct qcom_pcie *pcie)
 {
+	struct dw_pcie *pci = pcie->pci;
 
-	if (dw_pcie_link_up(&pcie->pp))
+	if (dw_pcie_link_up(pci))
 		return 0;
 
 	/* Enable Link Training state machine */
 	if (pcie->ops->ltssm_enable)
 		pcie->ops->ltssm_enable(pcie);
 
-	return dw_pcie_wait_for_link(&pcie->pp);
+	return dw_pcie_wait_for_link(pci);
 }
 
 static int qcom_pcie_get_resources_v0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_v0 *res = &pcie->res.v0;
-	struct device *dev = pcie->pp.dev;
+	struct dw_pcie *pci = pcie->pci;
+	struct device *dev = pci->dev;
 
 	res->vdda = devm_regulator_get(dev, "vdda");
 	if (IS_ERR(res->vdda))
@@ -221,7 +223,8 @@ static int qcom_pcie_get_resources_v0(struct qcom_pcie *pcie)
 static int qcom_pcie_get_resources_v1(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_v1 *res = &pcie->res.v1;
-	struct device *dev = pcie->pp.dev;
+	struct dw_pcie *pci = pcie->pci;
+	struct device *dev = pci->dev;
 
 	res->vdda = devm_regulator_get(dev, "vdda");
 	if (IS_ERR(res->vdda))
@@ -270,7 +273,8 @@ static void qcom_pcie_deinit_v0(struct qcom_pcie *pcie)
 static int qcom_pcie_init_v0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_v0 *res = &pcie->res.v0;
-	struct device *dev = pcie->pp.dev;
+	struct dw_pcie *pci = pcie->pci;
+	struct device *dev = pci->dev;
 	u32 val;
 	int ret;
 
@@ -392,7 +396,8 @@ static void qcom_pcie_deinit_v1(struct qcom_pcie *pcie)
 static int qcom_pcie_init_v1(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_v1 *res = &pcie->res.v1;
-	struct device *dev = pcie->pp.dev;
+	struct dw_pcie *pci = pcie->pci;
+	struct device *dev = pci->dev;
 	int ret;
 
 	ret = reset_control_deassert(res->core);
@@ -459,7 +464,8 @@ static int qcom_pcie_init_v1(struct qcom_pcie *pcie)
 static int qcom_pcie_get_resources_v2(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_v2 *res = &pcie->res.v2;
-	struct device *dev = pcie->pp.dev;
+	struct dw_pcie *pci = pcie->pci;
+	struct device *dev = pci->dev;
 
 	res->aux_clk = devm_clk_get(dev, "aux");
 	if (IS_ERR(res->aux_clk))
@@ -487,7 +493,8 @@ static int qcom_pcie_get_resources_v2(struct qcom_pcie *pcie)
 static int qcom_pcie_init_v2(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_v2 *res = &pcie->res.v2;
-	struct device *dev = pcie->pp.dev;
+	struct dw_pcie *pci = pcie->pci;
+	struct device *dev = pci->dev;
 	u32 val;
 	int ret;
 
@@ -551,7 +558,8 @@ static int qcom_pcie_init_v2(struct qcom_pcie *pcie)
 static int qcom_pcie_post_init_v2(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_v2 *res = &pcie->res.v2;
-	struct device *dev = pcie->pp.dev;
+	struct dw_pcie *pci = pcie->pci;
+	struct device *dev = pci->dev;
 	int ret;
 
 	ret = clk_prepare_enable(res->pipe_clk);
@@ -563,10 +571,9 @@ static int qcom_pcie_post_init_v2(struct qcom_pcie *pcie)
 	return 0;
 }
 
-static int qcom_pcie_link_up(struct pcie_port *pp)
+static int qcom_pcie_link_up(struct dw_pcie *pci)
 {
-	struct qcom_pcie *pcie = to_qcom_pcie(pp);
-	u16 val = readw(pcie->pp.dbi_base + PCIE20_CAP + PCI_EXP_LNKSTA);
+	u16 val = readw(pci->dbi_base + PCIE20_CAP + PCI_EXP_LNKSTA);
 
 	return !!(val & PCI_EXP_LNKSTA_DLLLA);
 }
@@ -584,7 +591,8 @@ static void qcom_pcie_deinit_v2(struct qcom_pcie *pcie)
 
 static void qcom_pcie_host_init(struct pcie_port *pp)
 {
-	struct qcom_pcie *pcie = to_qcom_pcie(pp);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct qcom_pcie *pcie = to_qcom_pcie(pci);
 	int ret;
 
 	qcom_ep_reset_assert(pcie);
@@ -622,19 +630,20 @@ static void qcom_pcie_host_init(struct pcie_port *pp)
 static int qcom_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
 				 u32 *val)
 {
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+
 	/* the device class is not reported correctly from the register */
 	if (where == PCI_CLASS_REVISION && size == 4) {
-		*val = readl(pp->dbi_base + PCI_CLASS_REVISION);
+		*val = readl(pci->dbi_base + PCI_CLASS_REVISION);
 		*val &= 0xff;	/* keep revision id */
 		*val |= PCI_CLASS_BRIDGE_PCI << 16;
 		return PCIBIOS_SUCCESSFUL;
 	}
 
-	return dw_pcie_read(pp->dbi_base + where, size, val);
+	return dw_pcie_read(pci->dbi_base + where, size, val);
 }
 
-static struct pcie_host_ops qcom_pcie_dw_ops = {
-	.link_up = qcom_pcie_link_up,
+static struct dw_pcie_host_ops qcom_pcie_dw_ops = {
 	.host_init = qcom_pcie_host_init,
 	.rd_own_conf = qcom_pcie_rd_own_conf,
 };
@@ -661,19 +670,31 @@ static int qcom_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
 	.ltssm_enable = qcom_pcie_v2_ltssm_enable,
 };
 
+static const struct dw_pcie_ops dw_pcie_ops = {
+	.link_up = qcom_pcie_link_up,
+};
+
 static int qcom_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct resource *res;
-	struct qcom_pcie *pcie;
 	struct pcie_port *pp;
+	struct dw_pcie *pci;
+	struct qcom_pcie *pcie;
 	int ret;
 
 	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
 		return -ENOMEM;
 
-	pp = &pcie->pp;
+	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
+	if (!pci)
+		return -ENOMEM;
+
+	pci->dev = dev;
+	pci->ops = &dw_pcie_ops;
+	pp = &pci->pp;
+
 	pcie->ops = (struct qcom_pcie_ops *)of_device_get_match_data(dev);
 
 	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_LOW);
@@ -686,9 +707,9 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(pcie->parf);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
-	pp->dbi_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(pp->dbi_base))
-		return PTR_ERR(pp->dbi_base);
+	pci->dbi_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(pci->dbi_base))
+		return PTR_ERR(pci->dbi_base);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "elbi");
 	pcie->elbi = devm_ioremap_resource(dev, res);
@@ -699,7 +720,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(pcie->phy))
 		return PTR_ERR(pcie->phy);
 
-	pp->dev = dev;
 	ret = pcie->ops->get_resources(pcie);
 	if (ret)
 		return ret;
diff --git a/drivers/pci/dwc/pcie-spear13xx.c b/drivers/pci/dwc/pcie-spear13xx.c
index 7acf91e..348f9c5 100644
--- a/drivers/pci/dwc/pcie-spear13xx.c
+++ b/drivers/pci/dwc/pcie-spear13xx.c
@@ -25,7 +25,7 @@
 #include "pcie-designware.h"
 
 struct spear13xx_pcie {
-	struct pcie_port	pp;		/* DT dbi is pp.dbi_base */
+	struct dw_pcie		*pci;
 	void __iomem		*app_base;
 	struct phy		*phy;
 	struct clk		*clk;
@@ -70,17 +70,18 @@ struct pcie_app_reg {
 
 #define EXP_CAP_ID_OFFSET			0x70
 
-#define to_spear13xx_pcie(x)	container_of(x, struct spear13xx_pcie, pp)
+#define to_spear13xx_pcie(x)	dev_get_drvdata((x)->dev)
 
 static int spear13xx_pcie_establish_link(struct spear13xx_pcie *spear13xx_pcie)
 {
-	struct pcie_port *pp = &spear13xx_pcie->pp;
+	struct dw_pcie *pci = spear13xx_pcie->pci;
+	struct pcie_port *pp = &pci->pp;
 	struct pcie_app_reg *app_reg = spear13xx_pcie->app_base;
 	u32 val;
 	u32 exp_cap_off = EXP_CAP_ID_OFFSET;
 
-	if (dw_pcie_link_up(pp)) {
-		dev_err(pp->dev, "link already up\n");
+	if (dw_pcie_link_up(pci)) {
+		dev_err(pci->dev, "link already up\n");
 		return 0;
 	}
 
@@ -91,33 +92,33 @@ static int spear13xx_pcie_establish_link(struct spear13xx_pcie *spear13xx_pcie)
 	 * default value in capability register is 512 bytes. So force
 	 * it to 128 here.
 	 */
-	dw_pcie_read(pp->dbi_base + exp_cap_off + PCI_EXP_DEVCTL, 2, &val);
+	dw_pcie_read(pci->dbi_base + exp_cap_off + PCI_EXP_DEVCTL, 2, &val);
 	val &= ~PCI_EXP_DEVCTL_READRQ;
-	dw_pcie_write(pp->dbi_base + exp_cap_off + PCI_EXP_DEVCTL, 2, val);
+	dw_pcie_write(pci->dbi_base + exp_cap_off + PCI_EXP_DEVCTL, 2, val);
 
-	dw_pcie_write(pp->dbi_base + PCI_VENDOR_ID, 2, 0x104A);
-	dw_pcie_write(pp->dbi_base + PCI_DEVICE_ID, 2, 0xCD80);
+	dw_pcie_write(pci->dbi_base + PCI_VENDOR_ID, 2, 0x104A);
+	dw_pcie_write(pci->dbi_base + PCI_DEVICE_ID, 2, 0xCD80);
 
 	/*
 	 * if is_gen1 is set then handle it, so that some buggy card
 	 * also works
 	 */
 	if (spear13xx_pcie->is_gen1) {
-		dw_pcie_read(pp->dbi_base + exp_cap_off + PCI_EXP_LNKCAP,
+		dw_pcie_read(pci->dbi_base + exp_cap_off + PCI_EXP_LNKCAP,
 			     4, &val);
 		if ((val & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
 			val &= ~((u32)PCI_EXP_LNKCAP_SLS);
 			val |= PCI_EXP_LNKCAP_SLS_2_5GB;
-			dw_pcie_write(pp->dbi_base + exp_cap_off +
+			dw_pcie_write(pci->dbi_base + exp_cap_off +
 				      PCI_EXP_LNKCAP, 4, val);
 		}
 
-		dw_pcie_read(pp->dbi_base + exp_cap_off + PCI_EXP_LNKCTL2,
+		dw_pcie_read(pci->dbi_base + exp_cap_off + PCI_EXP_LNKCTL2,
 			     2, &val);
 		if ((val & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
 			val &= ~((u32)PCI_EXP_LNKCAP_SLS);
 			val |= PCI_EXP_LNKCAP_SLS_2_5GB;
-			dw_pcie_write(pp->dbi_base + exp_cap_off +
+			dw_pcie_write(pci->dbi_base + exp_cap_off +
 				      PCI_EXP_LNKCTL2, 2, val);
 		}
 	}
@@ -128,14 +129,15 @@ static int spear13xx_pcie_establish_link(struct spear13xx_pcie *spear13xx_pcie)
 			| ((u32)1 << REG_TRANSLATION_ENABLE),
 			&app_reg->app_ctrl_0);
 
-	return dw_pcie_wait_for_link(pp);
+	return dw_pcie_wait_for_link(pci);
 }
 
 static irqreturn_t spear13xx_pcie_irq_handler(int irq, void *arg)
 {
 	struct spear13xx_pcie *spear13xx_pcie = arg;
 	struct pcie_app_reg *app_reg = spear13xx_pcie->app_base;
-	struct pcie_port *pp = &spear13xx_pcie->pp;
+	struct dw_pcie *pci = spear13xx_pcie->pci;
+	struct pcie_port *pp = &pci->pp;
 	unsigned int status;
 
 	status = readl(&app_reg->int_sts);
@@ -152,7 +154,8 @@ static irqreturn_t spear13xx_pcie_irq_handler(int irq, void *arg)
 
 static void spear13xx_pcie_enable_interrupts(struct spear13xx_pcie *spear13xx_pcie)
 {
-	struct pcie_port *pp = &spear13xx_pcie->pp;
+	struct dw_pcie *pci = spear13xx_pcie->pci;
+	struct pcie_port *pp = &pci->pp;
 	struct pcie_app_reg *app_reg = spear13xx_pcie->app_base;
 
 	/* Enable MSI interrupt */
@@ -163,9 +166,9 @@ static void spear13xx_pcie_enable_interrupts(struct spear13xx_pcie *spear13xx_pc
 	}
 }
 
-static int spear13xx_pcie_link_up(struct pcie_port *pp)
+static int spear13xx_pcie_link_up(struct dw_pcie *pci)
 {
-	struct spear13xx_pcie *spear13xx_pcie = to_spear13xx_pcie(pp);
+	struct spear13xx_pcie *spear13xx_pcie = to_spear13xx_pcie(pci);
 	struct pcie_app_reg *app_reg = spear13xx_pcie->app_base;
 
 	if (readl(&app_reg->app_status_1) & XMLH_LINK_UP)
@@ -176,22 +179,23 @@ static int spear13xx_pcie_link_up(struct pcie_port *pp)
 
 static void spear13xx_pcie_host_init(struct pcie_port *pp)
 {
-	struct spear13xx_pcie *spear13xx_pcie = to_spear13xx_pcie(pp);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct spear13xx_pcie *spear13xx_pcie = to_spear13xx_pcie(pci);
 
 	spear13xx_pcie_establish_link(spear13xx_pcie);
 	spear13xx_pcie_enable_interrupts(spear13xx_pcie);
 }
 
-static struct pcie_host_ops spear13xx_pcie_host_ops = {
-	.link_up = spear13xx_pcie_link_up,
+static struct dw_pcie_host_ops spear13xx_pcie_host_ops = {
 	.host_init = spear13xx_pcie_host_init,
 };
 
 static int spear13xx_add_pcie_port(struct spear13xx_pcie *spear13xx_pcie,
 				   struct platform_device *pdev)
 {
-	struct pcie_port *pp = &spear13xx_pcie->pp;
-	struct device *dev = pp->dev;
+	struct dw_pcie *pci = spear13xx_pcie->pci;
+	struct pcie_port *pp = &pci->pp;
+	struct device *dev = &pdev->dev;
 	int ret;
 
 	pp->irq = platform_get_irq(pdev, 0);
@@ -219,11 +223,15 @@ static int spear13xx_add_pcie_port(struct spear13xx_pcie *spear13xx_pcie,
 	return 0;
 }
 
+static const struct dw_pcie_ops dw_pcie_ops = {
+	.link_up = spear13xx_pcie_link_up,
+};
+
 static int spear13xx_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct dw_pcie *pci;
 	struct spear13xx_pcie *spear13xx_pcie;
-	struct pcie_port *pp;
 	struct device_node *np = dev->of_node;
 	struct resource *dbi_base;
 	int ret;
@@ -232,6 +240,13 @@ static int spear13xx_pcie_probe(struct platform_device *pdev)
 	if (!spear13xx_pcie)
 		return -ENOMEM;
 
+	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
+	if (!pci)
+		return -ENOMEM;
+
+	pci->dev = dev;
+	pci->ops = &dw_pcie_ops;
+
 	spear13xx_pcie->phy = devm_phy_get(dev, "pcie-phy");
 	if (IS_ERR(spear13xx_pcie->phy)) {
 		ret = PTR_ERR(spear13xx_pcie->phy);
@@ -255,17 +270,14 @@ static int spear13xx_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	pp = &spear13xx_pcie->pp;
-	pp->dev = dev;
-
 	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
-	pp->dbi_base = devm_ioremap_resource(dev, dbi_base);
-	if (IS_ERR(pp->dbi_base)) {
+	pci->dbi_base = devm_ioremap_resource(dev, dbi_base);
+	if (IS_ERR(pci->dbi_base)) {
 		dev_err(dev, "couldn't remap dbi base %p\n", dbi_base);
-		ret = PTR_ERR(pp->dbi_base);
+		ret = PTR_ERR(pci->dbi_base);
 		goto fail_clk;
 	}
-	spear13xx_pcie->app_base = pp->dbi_base + 0x2000;
+	spear13xx_pcie->app_base = pci->dbi_base + 0x2000;
 
 	if (of_property_read_bool(np, "st,pcie-is-gen1"))
 		spear13xx_pcie->is_gen1 = true;
-- 
1.7.9.5
