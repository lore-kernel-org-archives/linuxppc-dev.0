Return-Path: <kishon@ti.com>
Received: from fllnx209.ext.ti.com (fllnx209.ext.ti.com [198.47.19.16])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzkZ101kpzDqVR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 22:49:12 +1100 (AEDT)
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@axis.com>, <linux-arm-msm@vger.kernel.org>,
 <nsekhar@ti.com>, <kishon@ti.com>
Subject: [PATCH 21/37] PCI: dwc: Modify dbi accessors to take dbi_base as
 argument
Date: Thu, 12 Jan 2017 15:56:10 +0530
Message-ID: <1484216786-17292-22-git-send-email-kishon@ti.com>
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

dwc has 2 dbi address space labelled dbics and dbics2. The existing
helper to access dbi address space can access only dbics. However
dbics2 has to be accessed for programming the BAR registers in the
case of EP mode. This is in preparation for adding EP mode support
to dwc driver.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/dwc/pci-dra7xx.c           |   10 +++--
 drivers/pci/dwc/pci-exynos.c           |   10 +++--
 drivers/pci/dwc/pci-imx6.c             |   67 ++++++++++++++++------------
 drivers/pci/dwc/pci-keystone-dw.c      |   15 ++++---
 drivers/pci/dwc/pcie-armada8k.c        |   39 +++++++++-------
 drivers/pci/dwc/pcie-artpec6.c         |    7 +--
 drivers/pci/dwc/pcie-designware-host.c |   17 +++----
 drivers/pci/dwc/pcie-designware.c      |   76 ++++++++++++++++++--------------
 drivers/pci/dwc/pcie-designware.h      |   10 +++--
 drivers/pci/dwc/pcie-hisi.c            |   17 ++++---
 10 files changed, 153 insertions(+), 115 deletions(-)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index 3c525b0..76d0b40 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -494,12 +494,13 @@ static int dra7xx_pcie_suspend(struct device *dev)
 {
 	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
 	struct dw_pcie *pci = dra7xx->pci;
+	void __iomem *base = pci->dbi_base;
 	u32 val;
 
 	/* clear MSE */
-	val = dw_pcie_readl_dbi(pci, PCI_COMMAND);
+	val = dw_pcie_readl_dbi(pci, base, PCI_COMMAND);
 	val &= ~PCI_COMMAND_MEMORY;
-	dw_pcie_writel_dbi(pci, PCI_COMMAND, val);
+	dw_pcie_writel_dbi(pci, base, PCI_COMMAND, val);
 
 	return 0;
 }
@@ -508,12 +509,13 @@ static int dra7xx_pcie_resume(struct device *dev)
 {
 	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
 	struct dw_pcie *pci = dra7xx->pci;
+	void __iomem *base = pci->dbi_base;
 	u32 val;
 
 	/* set MSE */
-	val = dw_pcie_readl_dbi(pci, PCI_COMMAND);
+	val = dw_pcie_readl_dbi(pci, base, PCI_COMMAND);
 	val |= PCI_COMMAND_MEMORY;
-	dw_pcie_writel_dbi(pci, PCI_COMMAND, val);
+	dw_pcie_writel_dbi(pci, base, PCI_COMMAND, val);
 
 	return 0;
 }
diff --git a/drivers/pci/dwc/pci-exynos.c b/drivers/pci/dwc/pci-exynos.c
index 0295ec9..a109cf0 100644
--- a/drivers/pci/dwc/pci-exynos.c
+++ b/drivers/pci/dwc/pci-exynos.c
@@ -405,23 +405,25 @@ static void exynos_pcie_enable_interrupts(struct exynos_pcie *exynos_pcie)
 		exynos_pcie_msi_init(exynos_pcie);
 }
 
-static u32 exynos_pcie_readl_dbi(struct dw_pcie *pci, u32 reg)
+static u32 exynos_pcie_readl_dbi(struct dw_pcie *pci, void __iomem *base,
+				 u32 reg)
 {
 	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pci);
 	u32 val;
 
 	exynos_pcie_sideband_dbi_r_mode(exynos_pcie, true);
-	val = readl(pci->dbi_base + reg);
+	val = readl(base + reg);
 	exynos_pcie_sideband_dbi_r_mode(exynos_pcie, false);
 	return val;
 }
 
-static void exynos_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
+static void exynos_pcie_writel_dbi(struct dw_pcie *pci, void __iomem *base,
+				   u32 reg, u32 val)
 {
 	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pci);
 
 	exynos_pcie_sideband_dbi_w_mode(exynos_pcie, true);
-	writel(val, pci->dbi_base + reg);
+	writel(val, base + reg);
 	exynos_pcie_sideband_dbi_w_mode(exynos_pcie, false);
 }
 
diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c
index 70fa380..ecc8690 100644
--- a/drivers/pci/dwc/pci-imx6.c
+++ b/drivers/pci/dwc/pci-imx6.c
@@ -98,12 +98,13 @@ struct imx6_pcie {
 static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, int exp_val)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
+	void __iomem *base = pci->dbi_base;
 	u32 val;
 	u32 max_iterations = 10;
 	u32 wait_counter = 0;
 
 	do {
-		val = dw_pcie_readl_dbi(pci, PCIE_PHY_STAT);
+		val = dw_pcie_readl_dbi(pci, base, PCIE_PHY_STAT);
 		val = (val >> PCIE_PHY_STAT_ACK_LOC) & 0x1;
 		wait_counter++;
 
@@ -119,21 +120,22 @@ static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, int exp_val)
 static int pcie_phy_wait_ack(struct imx6_pcie *imx6_pcie, int addr)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
+	void __iomem *base = pci->dbi_base;
 	u32 val;
 	int ret;
 
 	val = addr << PCIE_PHY_CTRL_DATA_LOC;
-	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, val);
+	dw_pcie_writel_dbi(pci, base, PCIE_PHY_CTRL, val);
 
 	val |= (0x1 << PCIE_PHY_CTRL_CAP_ADR_LOC);
-	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, val);
+	dw_pcie_writel_dbi(pci, base, PCIE_PHY_CTRL, val);
 
 	ret = pcie_phy_poll_ack(imx6_pcie, 1);
 	if (ret)
 		return ret;
 
 	val = addr << PCIE_PHY_CTRL_DATA_LOC;
-	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, val);
+	dw_pcie_writel_dbi(pci, base, PCIE_PHY_CTRL, val);
 
 	return pcie_phy_poll_ack(imx6_pcie, 0);
 }
@@ -142,6 +144,7 @@ static int pcie_phy_wait_ack(struct imx6_pcie *imx6_pcie, int addr)
 static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, int *data)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
+	void __iomem *base = pci->dbi_base;
 	u32 val, phy_ctl;
 	int ret;
 
@@ -151,17 +154,17 @@ static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, int *data)
 
 	/* assert Read signal */
 	phy_ctl = 0x1 << PCIE_PHY_CTRL_RD_LOC;
-	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, phy_ctl);
+	dw_pcie_writel_dbi(pci, base, PCIE_PHY_CTRL, phy_ctl);
 
 	ret = pcie_phy_poll_ack(imx6_pcie, 1);
 	if (ret)
 		return ret;
 
-	val = dw_pcie_readl_dbi(pci, PCIE_PHY_STAT);
+	val = dw_pcie_readl_dbi(pci, base, PCIE_PHY_STAT);
 	*data = val & 0xffff;
 
 	/* deassert Read signal */
-	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, 0x00);
+	dw_pcie_writel_dbi(pci, base, PCIE_PHY_CTRL, 0x00);
 
 	return pcie_phy_poll_ack(imx6_pcie, 0);
 }
@@ -169,6 +172,7 @@ static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, int *data)
 static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
+	void __iomem *base = pci->dbi_base;
 	u32 var;
 	int ret;
 
@@ -179,11 +183,11 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 		return ret;
 
 	var = data << PCIE_PHY_CTRL_DATA_LOC;
-	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
+	dw_pcie_writel_dbi(pci, base, PCIE_PHY_CTRL, var);
 
 	/* capture data */
 	var |= (0x1 << PCIE_PHY_CTRL_CAP_DAT_LOC);
-	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
+	dw_pcie_writel_dbi(pci, base, PCIE_PHY_CTRL, var);
 
 	ret = pcie_phy_poll_ack(imx6_pcie, 1);
 	if (ret)
@@ -191,7 +195,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 
 	/* deassert cap data */
 	var = data << PCIE_PHY_CTRL_DATA_LOC;
-	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
+	dw_pcie_writel_dbi(pci, base, PCIE_PHY_CTRL, var);
 
 	/* wait for ack de-assertion */
 	ret = pcie_phy_poll_ack(imx6_pcie, 0);
@@ -200,7 +204,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 
 	/* assert wr signal */
 	var = 0x1 << PCIE_PHY_CTRL_WR_LOC;
-	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
+	dw_pcie_writel_dbi(pci, base, PCIE_PHY_CTRL, var);
 
 	/* wait for ack */
 	ret = pcie_phy_poll_ack(imx6_pcie, 1);
@@ -209,14 +213,14 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 
 	/* deassert wr signal */
 	var = data << PCIE_PHY_CTRL_DATA_LOC;
-	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
+	dw_pcie_writel_dbi(pci, base, PCIE_PHY_CTRL, var);
 
 	/* wait for ack de-assertion */
 	ret = pcie_phy_poll_ack(imx6_pcie, 0);
 	if (ret)
 		return ret;
 
-	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, 0x0);
+	dw_pcie_writel_dbi(pci, base, PCIE_PHY_CTRL, 0x0);
 
 	return 0;
 }
@@ -248,6 +252,7 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
 static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
+	void __iomem *base = pci->dbi_base;
 	u32 val, gpr1, gpr12;
 
 	switch (imx6_pcie->variant) {
@@ -284,10 +289,10 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 
 		if ((gpr1 & IMX6Q_GPR1_PCIE_REF_CLK_EN) &&
 		    (gpr12 & IMX6Q_GPR12_PCIE_CTL_2)) {
-			val = dw_pcie_readl_dbi(pci, PCIE_PL_PFLR);
+			val = dw_pcie_readl_dbi(pci, base, PCIE_PL_PFLR);
 			val &= ~PCIE_PL_PFLR_LINK_STATE_MASK;
 			val |= PCIE_PL_PFLR_FORCE_LINK;
-			dw_pcie_writel_dbi(pci, PCIE_PL_PFLR, val);
+			dw_pcie_writel_dbi(pci, base, PCIE_PL_PFLR, val);
 
 			regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 					   IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
@@ -441,6 +446,7 @@ static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 static int imx6_pcie_wait_for_link(struct imx6_pcie *imx6_pcie)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
+	void __iomem *base = pci->dbi_base;
 	struct device *dev = pci->dev;
 
 	/* check if the link is up or not */
@@ -448,20 +454,22 @@ static int imx6_pcie_wait_for_link(struct imx6_pcie *imx6_pcie)
 		return 0;
 
 	dev_dbg(dev, "DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
-		dw_pcie_readl_dbi(pci, PCIE_PHY_DEBUG_R0),
-		dw_pcie_readl_dbi(pci, PCIE_PHY_DEBUG_R1));
+		dw_pcie_readl_dbi(pci, base, PCIE_PHY_DEBUG_R0),
+		dw_pcie_readl_dbi(pci, base, PCIE_PHY_DEBUG_R1));
 	return -ETIMEDOUT;
 }
 
 static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
+	void __iomem *base = pci->dbi_base;
 	struct device *dev = pci->dev;
 	u32 tmp;
 	unsigned int retries;
 
 	for (retries = 0; retries < 200; retries++) {
-		tmp = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
+		tmp = dw_pcie_readl_dbi(pci, base,
+					PCIE_LINK_WIDTH_SPEED_CONTROL);
 		/* Test if the speed change finished. */
 		if (!(tmp & PORT_LOGIC_SPEED_CHANGE))
 			return 0;
@@ -484,6 +492,7 @@ static irqreturn_t imx6_pcie_msi_handler(int irq, void *arg)
 static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
+	void __iomem *base = pci->dbi_base;
 	struct device *dev = pci->dev;
 	u32 tmp;
 	int ret;
@@ -493,10 +502,10 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 	 * started in Gen2 mode, there is a possibility the devices on the
 	 * bus will not be detected at all.  This happens with PCIe switches.
 	 */
-	tmp = dw_pcie_readl_dbi(pci, PCIE_RC_LCR);
+	tmp = dw_pcie_readl_dbi(pci, base, PCIE_RC_LCR);
 	tmp &= ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
 	tmp |= PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1;
-	dw_pcie_writel_dbi(pci, PCIE_RC_LCR, tmp);
+	dw_pcie_writel_dbi(pci, base, PCIE_RC_LCR, tmp);
 
 	/* Start LTSSM. */
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
@@ -510,10 +519,10 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 
 	if (imx6_pcie->link_gen == 2) {
 		/* Allow Gen2 mode after the link is up. */
-		tmp = dw_pcie_readl_dbi(pci, PCIE_RC_LCR);
+		tmp = dw_pcie_readl_dbi(pci, base, PCIE_RC_LCR);
 		tmp &= ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
 		tmp |= PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN2;
-		dw_pcie_writel_dbi(pci, PCIE_RC_LCR, tmp);
+		dw_pcie_writel_dbi(pci, base, PCIE_RC_LCR, tmp);
 	} else {
 		dev_info(dev, "Link: Gen2 disabled\n");
 	}
@@ -522,9 +531,9 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 	 * Start Directed Speed Change so the best possible speed both link
 	 * partners support can be negotiated.
 	 */
-	tmp = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
+	tmp = dw_pcie_readl_dbi(pci, base, PCIE_LINK_WIDTH_SPEED_CONTROL);
 	tmp |= PORT_LOGIC_SPEED_CHANGE;
-	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
+	dw_pcie_writel_dbi(pci, base, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
 
 	ret = imx6_pcie_wait_for_speed_change(imx6_pcie);
 	if (ret) {
@@ -539,14 +548,14 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 		goto err_reset_phy;
 	}
 
-	tmp = dw_pcie_readl_dbi(pci, PCIE_RC_LCSR);
+	tmp = dw_pcie_readl_dbi(pci, base, PCIE_RC_LCSR);
 	dev_info(dev, "Link up, Gen%i\n", (tmp >> 16) & 0xf);
 	return 0;
 
 err_reset_phy:
 	dev_dbg(dev, "PHY DEBUG_R0=0x%08x DEBUG_R1=0x%08x\n",
-		dw_pcie_readl_dbi(pci, PCIE_PHY_DEBUG_R0),
-		dw_pcie_readl_dbi(pci, PCIE_PHY_DEBUG_R1));
+		dw_pcie_readl_dbi(pci, base, PCIE_PHY_DEBUG_R0),
+		dw_pcie_readl_dbi(pci, base, PCIE_PHY_DEBUG_R1));
 	imx6_pcie_reset_phy(imx6_pcie);
 	return ret;
 }
@@ -568,7 +577,9 @@ static void imx6_pcie_host_init(struct pcie_port *pp)
 
 static int imx6_pcie_link_up(struct dw_pcie *pci)
 {
-	return dw_pcie_readl_dbi(pci, PCIE_PHY_DEBUG_R1) &
+	void __iomem *base = pci->dbi_base;
+
+	return dw_pcie_readl_dbi(pci, base, PCIE_PHY_DEBUG_R1) &
 			PCIE_PHY_DEBUG_R1_XMLH_LINK_UP;
 }
 
diff --git a/drivers/pci/dwc/pci-keystone-dw.c b/drivers/pci/dwc/pci-keystone-dw.c
index 6b396f6..7220c04 100644
--- a/drivers/pci/dwc/pci-keystone-dw.c
+++ b/drivers/pci/dwc/pci-keystone-dw.c
@@ -378,6 +378,7 @@ static void ks_dw_pcie_clear_dbi_mode(struct keystone_pcie *ks_pcie)
 void ks_dw_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
 {
 	struct dw_pcie *pci = ks_pcie->pci;
+	void __iomem *base = pci->dbi_base;
 	struct pcie_port *pp = &pci->pp;
 	u32 start = pp->mem->start, end = pp->mem->end;
 	int i, tr_size;
@@ -385,8 +386,8 @@ void ks_dw_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
 
 	/* Disable BARs for inbound access */
 	ks_dw_pcie_set_dbi_mode(ks_pcie);
-	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0);
-	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_1, 0);
+	dw_pcie_writel_dbi(pci, base, PCI_BASE_ADDRESS_0, 0);
+	dw_pcie_writel_dbi(pci, base, PCI_BASE_ADDRESS_1, 0);
 	ks_dw_pcie_clear_dbi_mode(ks_pcie);
 
 	/* Set outbound translation size per window division */
@@ -482,14 +483,15 @@ int ks_dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 void ks_dw_pcie_v3_65_scan_bus(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	void __iomem *base = pci->dbi_base;
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
 
 	/* Configure and set up BAR0 */
 	ks_dw_pcie_set_dbi_mode(ks_pcie);
 
 	/* Enable BAR0 */
-	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 1);
-	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, SZ_4K - 1);
+	dw_pcie_writel_dbi(pci, base, PCI_BASE_ADDRESS_0, 1);
+	dw_pcie_writel_dbi(pci, base, PCI_BASE_ADDRESS_0, SZ_4K - 1);
 
 	ks_dw_pcie_clear_dbi_mode(ks_pcie);
 
@@ -497,7 +499,7 @@ void ks_dw_pcie_v3_65_scan_bus(struct pcie_port *pp)
 	  * For BAR0, just setting bus address for inbound writes (MSI) should
 	  * be sufficient.  Use physical address to avoid any conflicts.
 	  */
-	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, ks_pcie->app.start);
+	dw_pcie_writel_dbi(pci, base, PCI_BASE_ADDRESS_0, ks_pcie->app.start);
 }
 
 /**
@@ -506,8 +508,9 @@ void ks_dw_pcie_v3_65_scan_bus(struct pcie_port *pp)
 int ks_dw_pcie_link_up(struct dw_pcie *pci)
 {
 	u32 val;
+	void __iomem *base = pci->dbi_base;
 
-	val = dw_pcie_readl_dbi(pci, DEBUG0);
+	val = dw_pcie_readl_dbi(pci, base, DEBUG0);
 	return (val & LTSSM_STATE_MASK) == LTSSM_STATE_L0;
 }
 
diff --git a/drivers/pci/dwc/pcie-armada8k.c b/drivers/pci/dwc/pcie-armada8k.c
index 66bac6f..2656f86 100644
--- a/drivers/pci/dwc/pcie-armada8k.c
+++ b/drivers/pci/dwc/pcie-armada8k.c
@@ -73,8 +73,9 @@ static int armada8k_pcie_link_up(struct dw_pcie *pci)
 {
 	u32 reg;
 	u32 mask = PCIE_GLB_STS_RDLH_LINK_UP | PCIE_GLB_STS_PHY_LINK_UP;
+	void __iomem *base = pci->dbi_base;
 
-	reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_STATUS_REG);
+	reg = dw_pcie_readl_dbi(pci, base, PCIE_GLOBAL_STATUS_REG);
 
 	if ((reg & mask) == mask)
 		return 1;
@@ -86,47 +87,50 @@ static int armada8k_pcie_link_up(struct dw_pcie *pci)
 static void armada8k_pcie_establish_link(struct armada8k_pcie *pcie)
 {
 	struct dw_pcie *pci = pcie->pci;
+	void __iomem *base = pci->dbi_base;
 	u32 reg;
 
 	if (!dw_pcie_link_up(pci)) {
 		/* Disable LTSSM state machine to enable configuration */
-		reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_CONTROL_REG);
+		reg = dw_pcie_readl_dbi(pci, base, PCIE_GLOBAL_CONTROL_REG);
 		reg &= ~(PCIE_APP_LTSSM_EN);
-		dw_pcie_writel_dbi(pci, PCIE_GLOBAL_CONTROL_REG, reg);
+		dw_pcie_writel_dbi(pci, base, PCIE_GLOBAL_CONTROL_REG, reg);
 	}
 
 	/* Set the device to root complex mode */
-	reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_CONTROL_REG);
+	reg = dw_pcie_readl_dbi(pci, base, PCIE_GLOBAL_CONTROL_REG);
 	reg &= ~(PCIE_DEVICE_TYPE_MASK << PCIE_DEVICE_TYPE_SHIFT);
 	reg |= PCIE_DEVICE_TYPE_RC << PCIE_DEVICE_TYPE_SHIFT;
-	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_CONTROL_REG, reg);
+	dw_pcie_writel_dbi(pci, base, PCIE_GLOBAL_CONTROL_REG, reg);
 
 	/* Set the PCIe master AxCache attributes */
-	dw_pcie_writel_dbi(pci, PCIE_ARCACHE_TRC_REG, ARCACHE_DEFAULT_VALUE);
-	dw_pcie_writel_dbi(pci, PCIE_AWCACHE_TRC_REG, AWCACHE_DEFAULT_VALUE);
+	dw_pcie_writel_dbi(pci, base, PCIE_ARCACHE_TRC_REG,
+			   ARCACHE_DEFAULT_VALUE);
+	dw_pcie_writel_dbi(pci, base, PCIE_AWCACHE_TRC_REG,
+			   AWCACHE_DEFAULT_VALUE);
 
 	/* Set the PCIe master AxDomain attributes */
-	reg = dw_pcie_readl_dbi(pci, PCIE_ARUSER_REG);
+	reg = dw_pcie_readl_dbi(pci, base, PCIE_ARUSER_REG);
 	reg &= ~(AX_USER_DOMAIN_MASK << AX_USER_DOMAIN_SHIFT);
 	reg |= DOMAIN_OUTER_SHAREABLE << AX_USER_DOMAIN_SHIFT;
-	dw_pcie_writel_dbi(pci, PCIE_ARUSER_REG, reg);
+	dw_pcie_writel_dbi(pci, base, PCIE_ARUSER_REG, reg);
 
-	reg = dw_pcie_readl_dbi(pci, PCIE_AWUSER_REG);
+	reg = dw_pcie_readl_dbi(pci, base, PCIE_AWUSER_REG);
 	reg &= ~(AX_USER_DOMAIN_MASK << AX_USER_DOMAIN_SHIFT);
 	reg |= DOMAIN_OUTER_SHAREABLE << AX_USER_DOMAIN_SHIFT;
-	dw_pcie_writel_dbi(pci, PCIE_AWUSER_REG, reg);
+	dw_pcie_writel_dbi(pci, base, PCIE_AWUSER_REG, reg);
 
 	/* Enable INT A-D interrupts */
-	reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_MASK1_REG);
+	reg = dw_pcie_readl_dbi(pci, base, PCIE_GLOBAL_INT_MASK1_REG);
 	reg |= PCIE_INT_A_ASSERT_MASK | PCIE_INT_B_ASSERT_MASK |
 	       PCIE_INT_C_ASSERT_MASK | PCIE_INT_D_ASSERT_MASK;
-	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_MASK1_REG, reg);
+	dw_pcie_writel_dbi(pci, base, PCIE_GLOBAL_INT_MASK1_REG, reg);
 
 	if (!dw_pcie_link_up(pci)) {
 		/* Configuration done. Start LTSSM */
-		reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_CONTROL_REG);
+		reg = dw_pcie_readl_dbi(pci, base, PCIE_GLOBAL_CONTROL_REG);
 		reg |= PCIE_APP_LTSSM_EN;
-		dw_pcie_writel_dbi(pci, PCIE_GLOBAL_CONTROL_REG, reg);
+		dw_pcie_writel_dbi(pci, base, PCIE_GLOBAL_CONTROL_REG, reg);
 	}
 
 	/* Wait until the link becomes active again */
@@ -147,6 +151,7 @@ static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
 {
 	struct armada8k_pcie *pcie = arg;
 	struct dw_pcie *pci = pcie->pci;
+	void __iomem *base = pci->dbi_base;
 	u32 val;
 
 	/*
@@ -154,8 +159,8 @@ static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
 	 * PCI device. However, they are also latched into the PCIe
 	 * controller, so we simply discard them.
 	 */
-	val = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_CAUSE1_REG);
-	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_CAUSE1_REG, val);
+	val = dw_pcie_readl_dbi(pci, base, PCIE_GLOBAL_INT_CAUSE1_REG);
+	dw_pcie_writel_dbi(pci, base, PCIE_GLOBAL_INT_CAUSE1_REG, val);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/pci/dwc/pcie-artpec6.c b/drivers/pci/dwc/pcie-artpec6.c
index 59ecc9e..4c7820a 100644
--- a/drivers/pci/dwc/pcie-artpec6.c
+++ b/drivers/pci/dwc/pcie-artpec6.c
@@ -81,6 +81,7 @@ static void artpec6_pcie_writel(struct artpec6_pcie *artpec6_pcie, u32 offset, u
 static int artpec6_pcie_establish_link(struct artpec6_pcie *artpec6_pcie)
 {
 	struct dw_pcie *pci = artpec6_pcie->pci;
+	void __iomem *base = pci->dbi_base;
 	struct pcie_port *pp = &pci->pp;
 	u32 val;
 	unsigned int retries;
@@ -140,7 +141,7 @@ static int artpec6_pcie_establish_link(struct artpec6_pcie *artpec6_pcie)
 	 * Enable writing to config regs. This is required as the Synopsys
 	 * driver changes the class code. That register needs DBI write enable.
 	 */
-	dw_pcie_writel_dbi(pci, MISC_CONTROL_1_OFF, DBI_RO_WR_EN);
+	dw_pcie_writel_dbi(pci, base, MISC_CONTROL_1_OFF, DBI_RO_WR_EN);
 
 	pp->io_base &= ARTPEC6_CPU_TO_BUS_ADDR;
 	pp->mem_base &= ARTPEC6_CPU_TO_BUS_ADDR;
@@ -160,8 +161,8 @@ static int artpec6_pcie_establish_link(struct artpec6_pcie *artpec6_pcie)
 		return 0;
 
 	dev_dbg(pci->dev, "DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
-		dw_pcie_readl_dbi(pci, PCIE_PHY_DEBUG_R0),
-		dw_pcie_readl_dbi(pci, PCIE_PHY_DEBUG_R1));
+		dw_pcie_readl_dbi(pci, base, PCIE_PHY_DEBUG_R0),
+		dw_pcie_readl_dbi(pci, base, PCIE_PHY_DEBUG_R1));
 
 	return -ETIMEDOUT;
 }
diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
index e7eb653..e3a5104 100644
--- a/drivers/pci/dwc/pcie-designware-host.c
+++ b/drivers/pci/dwc/pcie-designware-host.c
@@ -567,31 +567,32 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 {
 	u32 val;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	void __iomem *base = pci->dbi_base;
 
 	dw_pcie_setup(pci);
 
 	/* setup RC BARs */
-	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0x00000004);
-	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_1, 0x00000000);
+	dw_pcie_writel_dbi(pci, base, PCI_BASE_ADDRESS_0, 0x00000004);
+	dw_pcie_writel_dbi(pci, base, PCI_BASE_ADDRESS_1, 0x00000000);
 
 	/* setup interrupt pins */
-	val = dw_pcie_readl_dbi(pci, PCI_INTERRUPT_LINE);
+	val = dw_pcie_readl_dbi(pci, base, PCI_INTERRUPT_LINE);
 	val &= 0xffff00ff;
 	val |= 0x00000100;
-	dw_pcie_writel_dbi(pci, PCI_INTERRUPT_LINE, val);
+	dw_pcie_writel_dbi(pci, base, PCI_INTERRUPT_LINE, val);
 
 	/* setup bus numbers */
-	val = dw_pcie_readl_dbi(pci, PCI_PRIMARY_BUS);
+	val = dw_pcie_readl_dbi(pci, base, PCI_PRIMARY_BUS);
 	val &= 0xff000000;
 	val |= 0x00010100;
-	dw_pcie_writel_dbi(pci, PCI_PRIMARY_BUS, val);
+	dw_pcie_writel_dbi(pci, base, PCI_PRIMARY_BUS, val);
 
 	/* setup command register */
-	val = dw_pcie_readl_dbi(pci, PCI_COMMAND);
+	val = dw_pcie_readl_dbi(pci, base, PCI_COMMAND);
 	val &= 0xffff0000;
 	val |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
 		PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
-	dw_pcie_writel_dbi(pci, PCI_COMMAND, val);
+	dw_pcie_writel_dbi(pci, base, PCI_COMMAND, val);
 
 	/*
 	 * If the platform provides ->rd_other_conf, it means the platform
diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-designware.c
index fb020ee..db39f13 100644
--- a/drivers/pci/dwc/pcie-designware.c
+++ b/drivers/pci/dwc/pcie-designware.c
@@ -61,75 +61,81 @@ int dw_pcie_write(void __iomem *addr, int size, u32 val)
 	return PCIBIOS_SUCCESSFUL;
 }
 
-u32 dw_pcie_readl_dbi(struct dw_pcie *pci, u32 reg)
+u32 dw_pcie_readl_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg)
 {
 	if (pci->ops->readl_dbi)
-		return pci->ops->readl_dbi(pci, reg);
+		return pci->ops->readl_dbi(pci, base, reg);
 
-	return readl(pci->dbi_base + reg);
+	return readl(base + reg);
 }
 
-void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
+void dw_pcie_writel_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
+			u32 val)
 {
 	if (pci->ops->writel_dbi)
-		pci->ops->writel_dbi(pci, reg, val);
+		pci->ops->writel_dbi(pci, base, reg, val);
 	else
-		writel(val, pci->dbi_base + reg);
+		writel(val, base + reg);
 }
 
-static u32 dw_pcie_readl_unroll(struct dw_pcie *pci, u32 index, u32 reg)
+static u32 dw_pcie_readl_unroll(struct dw_pcie *pci, void __iomem *base,
+				u32 index, u32 reg)
 {
 	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
 
-	return dw_pcie_readl_dbi(pci, offset + reg);
+	return dw_pcie_readl_dbi(pci, base, offset + reg);
 }
 
-static void dw_pcie_writel_unroll(struct dw_pcie *pci, u32 index, u32 reg,
-				  u32 val)
+static void dw_pcie_writel_unroll(struct dw_pcie *pci, void __iomem *base,
+				  u32 index, u32 reg, u32 val)
 {
 	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
 
-	dw_pcie_writel_dbi(pci, offset + reg, val);
+	dw_pcie_writel_dbi(pci, base, offset + reg, val);
 }
 
 void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
 			       u64 cpu_addr, u64 pci_addr, u32 size)
 {
 	u32 retries, val;
+	void __iomem *base = pci->dbi_base;
 
 	if (pci->ops->cpu_addr_fixup)
 		cpu_addr = pci->ops->cpu_addr_fixup(cpu_addr);
 
 	if (pci->iatu_unroll_enabled) {
-		dw_pcie_writel_unroll(pci, index, PCIE_ATU_UNR_LOWER_BASE,
+		dw_pcie_writel_unroll(pci, base, index, PCIE_ATU_UNR_LOWER_BASE,
 				      lower_32_bits(cpu_addr));
-		dw_pcie_writel_unroll(pci, index, PCIE_ATU_UNR_UPPER_BASE,
+		dw_pcie_writel_unroll(pci, base, index, PCIE_ATU_UNR_UPPER_BASE,
 				      upper_32_bits(cpu_addr));
-		dw_pcie_writel_unroll(pci, index, PCIE_ATU_UNR_LIMIT,
+		dw_pcie_writel_unroll(pci, base, index, PCIE_ATU_UNR_LIMIT,
 				      lower_32_bits(cpu_addr + size - 1));
-		dw_pcie_writel_unroll(pci, index, PCIE_ATU_UNR_LOWER_TARGET,
+		dw_pcie_writel_unroll(pci, base, index,
+				      PCIE_ATU_UNR_LOWER_TARGET,
 				      lower_32_bits(pci_addr));
-		dw_pcie_writel_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
+		dw_pcie_writel_unroll(pci, base, index,
+				      PCIE_ATU_UNR_UPPER_TARGET,
 				      upper_32_bits(pci_addr));
-		dw_pcie_writel_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1,
-				      type);
-		dw_pcie_writel_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
+		dw_pcie_writel_unroll(pci, base, index,
+				      PCIE_ATU_UNR_REGION_CTRL1, type);
+		dw_pcie_writel_unroll(pci, base, index,
+				      PCIE_ATU_UNR_REGION_CTRL2,
 				      PCIE_ATU_ENABLE);
 	} else {
-		dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT,
+		dw_pcie_writel_dbi(pci, base, PCIE_ATU_VIEWPORT,
 				   PCIE_ATU_REGION_OUTBOUND | index);
-		dw_pcie_writel_dbi(pci, PCIE_ATU_LOWER_BASE,
+		dw_pcie_writel_dbi(pci, base, PCIE_ATU_LOWER_BASE,
 				   lower_32_bits(cpu_addr));
-		dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_BASE,
+		dw_pcie_writel_dbi(pci, base, PCIE_ATU_UPPER_BASE,
 				   upper_32_bits(cpu_addr));
-		dw_pcie_writel_dbi(pci, PCIE_ATU_LIMIT,
+		dw_pcie_writel_dbi(pci, base, PCIE_ATU_LIMIT,
 				   lower_32_bits(cpu_addr + size - 1));
-		dw_pcie_writel_dbi(pci, PCIE_ATU_LOWER_TARGET,
+		dw_pcie_writel_dbi(pci, base, PCIE_ATU_LOWER_TARGET,
 				   lower_32_bits(pci_addr));
-		dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_TARGET,
+		dw_pcie_writel_dbi(pci, base, PCIE_ATU_UPPER_TARGET,
 				   upper_32_bits(pci_addr));
-		dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, type);
-		dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, PCIE_ATU_ENABLE);
+		dw_pcie_writel_dbi(pci, base, PCIE_ATU_CR1, type);
+		dw_pcie_writel_dbi(pci, base, PCIE_ATU_CR2, PCIE_ATU_ENABLE);
 	}
 
 	/*
@@ -138,10 +144,10 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
 	 */
 	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
 		if (pci->iatu_unroll_enabled)
-			val = dw_pcie_readl_unroll(pci, index,
+			val = dw_pcie_readl_unroll(pci, base, index,
 						   PCIE_ATU_UNR_REGION_CTRL2);
 		else
-			val = dw_pcie_readl_dbi(pci, PCIE_ATU_CR2);
+			val = dw_pcie_readl_dbi(pci, base, PCIE_ATU_CR2);
 
 		if (val == PCIE_ATU_ENABLE)
 			return;
@@ -184,8 +190,9 @@ int dw_pcie_link_up(struct dw_pcie *pci)
 static u8 dw_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
 {
 	u32 val;
+	void __iomem *base = pci->dbi_base;
 
-	val = dw_pcie_readl_dbi(pci, PCIE_ATU_VIEWPORT);
+	val = dw_pcie_readl_dbi(pci, base, PCIE_ATU_VIEWPORT);
 	if (val == 0xffffffff)
 		return 1;
 
@@ -199,6 +206,7 @@ void dw_pcie_setup(struct dw_pcie *pci)
 	u32 lanes;
 	struct device *dev = pci->dev;
 	struct device_node *np = dev->of_node;
+	void __iomem *base = pci->dbi_base;
 
 	/* get iATU unroll support */
 	pci->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pci);
@@ -210,7 +218,7 @@ void dw_pcie_setup(struct dw_pcie *pci)
 		lanes = 0;
 
 	/* set the number of lanes */
-	val = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
+	val = dw_pcie_readl_dbi(pci, base, PCIE_PORT_LINK_CONTROL);
 	val &= ~PORT_LINK_MODE_MASK;
 	switch (lanes) {
 	case 1:
@@ -229,10 +237,10 @@ void dw_pcie_setup(struct dw_pcie *pci)
 		dev_err(pci->dev, "num-lanes %u: invalid value\n", lanes);
 		return;
 	}
-	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
+	dw_pcie_writel_dbi(pci, base, PCIE_PORT_LINK_CONTROL, val);
 
 	/* set link width speed control register */
-	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
+	val = dw_pcie_readl_dbi(pci, base, PCIE_LINK_WIDTH_SPEED_CONTROL);
 	val &= ~PORT_LOGIC_LINK_WIDTH_MASK;
 	switch (lanes) {
 	case 1:
@@ -248,5 +256,5 @@ void dw_pcie_setup(struct dw_pcie *pci)
 		val |= PORT_LOGIC_LINK_WIDTH_8_LANES;
 		break;
 	}
-	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
+	dw_pcie_writel_dbi(pci, base, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
 }
diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
index 8f3dcb2..fe93f7f 100644
--- a/drivers/pci/dwc/pcie-designware.h
+++ b/drivers/pci/dwc/pcie-designware.h
@@ -144,8 +144,9 @@ struct pcie_port {
 
 struct dw_pcie_ops {
 	u64	(*cpu_addr_fixup)(u64 cpu_addr);
-	u32	(*readl_dbi)(struct dw_pcie *pcie, u32 reg);
-	void	(*writel_dbi)(struct dw_pcie *pcie, u32 reg, u32 val);
+	u32	(*readl_dbi)(struct dw_pcie *pcie, void __iomem *base, u32 reg);
+	void	(*writel_dbi)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
+			      u32 val);
 	int	(*link_up)(struct dw_pcie *pcie);
 };
 
@@ -163,8 +164,9 @@ struct dw_pcie {
 int dw_pcie_read(void __iomem *addr, int size, u32 *val);
 int dw_pcie_write(void __iomem *addr, int size, u32 val);
 
-u32 dw_pcie_readl_dbi(struct dw_pcie *pci, u32 reg);
-void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val);
+u32 dw_pcie_readl_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg);
+void dw_pcie_writel_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
+			u32 val);
 int dw_pcie_link_up(struct dw_pcie *pci);
 int dw_pcie_wait_for_link(struct dw_pcie *pci);
 void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
diff --git a/drivers/pci/dwc/pcie-hisi.c b/drivers/pci/dwc/pcie-hisi.c
index 386467a..560f6a4 100644
--- a/drivers/pci/dwc/pcie-hisi.c
+++ b/drivers/pci/dwc/pcie-hisi.c
@@ -150,10 +150,11 @@ static int hisi_pcie_cfg_read(struct pcie_port *pp, int where, int size,
 	u32 reg_val;
 	void *walker = &reg_val;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	void __iomem *base = pci->dbi_base;
 
 	walker += (where & 0x3);
 	reg = where & ~0x3;
-	reg_val = dw_pcie_readl_dbi(pci, reg);
+	reg_val = dw_pcie_readl_dbi(pci, base, reg);
 
 	if (size == 1)
 		*val = *(u8 __force *) walker;
@@ -175,19 +176,20 @@ static int hisi_pcie_cfg_write(struct pcie_port *pp, int where, int  size,
 	u32 reg;
 	void *walker = &reg_val;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	void __iomem *base = pci->dbi_base;
 
 	walker += (where & 0x3);
 	reg = where & ~0x3;
 	if (size == 4)
-		dw_pcie_writel_dbi(pci, reg, val);
+		dw_pcie_writel_dbi(pci, base, reg, val);
 	else if (size == 2) {
-		reg_val = dw_pcie_readl_dbi(pci, reg);
+		reg_val = dw_pcie_readl_dbi(pci, base, reg);
 		*(u16 __force *) walker = val;
-		dw_pcie_writel_dbi(pci, reg, reg_val);
+		dw_pcie_writel_dbi(pci, base, reg, reg_val);
 	} else if (size == 1) {
-		reg_val = dw_pcie_readl_dbi(pci, reg);
+		reg_val = dw_pcie_readl_dbi(pci, base, reg);
 		*(u8 __force *) walker = val;
-		dw_pcie_writel_dbi(pci, reg, reg_val);
+		dw_pcie_writel_dbi(pci, base, reg, reg_val);
 	} else
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
@@ -207,9 +209,10 @@ static int hisi_pcie_link_up_hip05(struct hisi_pcie *hisi_pcie)
 static int hisi_pcie_link_up_hip06(struct hisi_pcie *hisi_pcie)
 {
 	struct dw_pcie *pci = hisi_pcie->pci;
+	void __iomem *base = pci->dbi_base;
 	u32 val;
 
-	val = dw_pcie_readl_dbi(pci, PCIE_SYS_STATE4);
+	val = dw_pcie_readl_dbi(pci, base, PCIE_SYS_STATE4);
 
 	return ((val & PCIE_LTSSM_STATE_MASK) == PCIE_LTSSM_LINKUP_STATE);
 }
-- 
1.7.9.5
