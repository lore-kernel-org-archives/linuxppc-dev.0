Return-Path: <kishon@ti.com>
Received: from fllnx210.ext.ti.com (fllnx210.ext.ti.com [198.47.19.17])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzlBq2yVKzDqZX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 23:17:39 +1100 (AEDT)
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@axis.com>, <linux-arm-msm@vger.kernel.org>,
 <nsekhar@ti.com>, <kishon@ti.com>
Subject: [PATCH 22/37] PCI: dwc: Modify dbi accessors to access data of 4/2/1
 bytes
Date: Thu, 12 Jan 2017 15:56:11 +0530
Message-ID: <1484216786-17292-23-git-send-email-kishon@ti.com>
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

Previously dbi accessors can be used to access data of size 4
bytes. But there might be situations (like accessing
MSI_MESSAGE_CONTROL in order to set/get the number of required
MSI interrupts in EP mode) where dbi accessors must
be used to access data of size 2. This is in preparation for
adding endpoint mode support to designware driver.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/dwc/pci-dra7xx.c           |    8 ++--
 drivers/pci/dwc/pci-exynos.c           |   16 +++----
 drivers/pci/dwc/pci-imx6.c             |   58 +++++++++++------------
 drivers/pci/dwc/pci-keystone-dw.c      |   13 +++---
 drivers/pci/dwc/pcie-armada8k.c        |   38 +++++++--------
 drivers/pci/dwc/pcie-artpec6.c         |    6 +--
 drivers/pci/dwc/pcie-designware-host.c |   16 +++----
 drivers/pci/dwc/pcie-designware.c      |   79 +++++++++++++++++++-------------
 drivers/pci/dwc/pcie-designware.h      |   14 +++---
 drivers/pci/dwc/pcie-hisi.c            |   14 +++---
 10 files changed, 140 insertions(+), 122 deletions(-)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index 76d0b40..8a1fccd 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -498,9 +498,9 @@ static int dra7xx_pcie_suspend(struct device *dev)
 	u32 val;
 
 	/* clear MSE */
-	val = dw_pcie_readl_dbi(pci, base, PCI_COMMAND);
+	val = dw_pcie_read_dbi(pci, base, PCI_COMMAND, 0x4);
 	val &= ~PCI_COMMAND_MEMORY;
-	dw_pcie_writel_dbi(pci, base, PCI_COMMAND, val);
+	dw_pcie_write_dbi(pci, base, PCI_COMMAND, 0x4, val);
 
 	return 0;
 }
@@ -513,9 +513,9 @@ static int dra7xx_pcie_resume(struct device *dev)
 	u32 val;
 
 	/* set MSE */
-	val = dw_pcie_readl_dbi(pci, base, PCI_COMMAND);
+	val = dw_pcie_read_dbi(pci, base, PCI_COMMAND, 0x4);
 	val |= PCI_COMMAND_MEMORY;
-	dw_pcie_writel_dbi(pci, base, PCI_COMMAND, val);
+	dw_pcie_write_dbi(pci, base, PCI_COMMAND, 0x4, val);
 
 	return 0;
 }
diff --git a/drivers/pci/dwc/pci-exynos.c b/drivers/pci/dwc/pci-exynos.c
index a109cf0..f6beb05 100644
--- a/drivers/pci/dwc/pci-exynos.c
+++ b/drivers/pci/dwc/pci-exynos.c
@@ -405,25 +405,25 @@ static void exynos_pcie_enable_interrupts(struct exynos_pcie *exynos_pcie)
 		exynos_pcie_msi_init(exynos_pcie);
 }
 
-static u32 exynos_pcie_readl_dbi(struct dw_pcie *pci, void __iomem *base,
-				 u32 reg)
+static u32 exynos_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
+				u32 reg, int size)
 {
 	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pci);
 	u32 val;
 
 	exynos_pcie_sideband_dbi_r_mode(exynos_pcie, true);
-	val = readl(base + reg);
+	dw_pcie_read(base + reg, size, &val);
 	exynos_pcie_sideband_dbi_r_mode(exynos_pcie, false);
 	return val;
 }
 
-static void exynos_pcie_writel_dbi(struct dw_pcie *pci, void __iomem *base,
-				   u32 reg, u32 val)
+static void exynos_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base,
+				  u32 reg, int size, u32 val)
 {
 	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pci);
 
 	exynos_pcie_sideband_dbi_w_mode(exynos_pcie, true);
-	writel(val, base + reg);
+	dw_pcie_write(base + reg, size, val);
 	exynos_pcie_sideband_dbi_w_mode(exynos_pcie, false);
 }
 
@@ -530,8 +530,8 @@ static int __init exynos_add_pcie_port(struct exynos_pcie *exynos_pcie,
 }
 
 static const struct dw_pcie_ops dw_pcie_ops = {
-	.readl_dbi = exynos_pcie_readl_dbi,
-	.writel_dbi = exynos_pcie_writel_dbi,
+	.read_dbi = exynos_pcie_read_dbi,
+	.write_dbi = exynos_pcie_write_dbi,
 	.link_up = exynos_pcie_link_up,
 };
 
diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c
index ecc8690..08ebe62 100644
--- a/drivers/pci/dwc/pci-imx6.c
+++ b/drivers/pci/dwc/pci-imx6.c
@@ -104,7 +104,7 @@ static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, int exp_val)
 	u32 wait_counter = 0;
 
 	do {
-		val = dw_pcie_readl_dbi(pci, base, PCIE_PHY_STAT);
+		val = dw_pcie_read_dbi(pci, base, PCIE_PHY_STAT, 0x4);
 		val = (val >> PCIE_PHY_STAT_ACK_LOC) & 0x1;
 		wait_counter++;
 
@@ -125,17 +125,17 @@ static int pcie_phy_wait_ack(struct imx6_pcie *imx6_pcie, int addr)
 	int ret;
 
 	val = addr << PCIE_PHY_CTRL_DATA_LOC;
-	dw_pcie_writel_dbi(pci, base, PCIE_PHY_CTRL, val);
+	dw_pcie_write_dbi(pci, base, PCIE_PHY_CTRL, 0x4, val);
 
 	val |= (0x1 << PCIE_PHY_CTRL_CAP_ADR_LOC);
-	dw_pcie_writel_dbi(pci, base, PCIE_PHY_CTRL, val);
+	dw_pcie_write_dbi(pci, base, PCIE_PHY_CTRL, 0x4, val);
 
 	ret = pcie_phy_poll_ack(imx6_pcie, 1);
 	if (ret)
 		return ret;
 
 	val = addr << PCIE_PHY_CTRL_DATA_LOC;
-	dw_pcie_writel_dbi(pci, base, PCIE_PHY_CTRL, val);
+	dw_pcie_write_dbi(pci, base, PCIE_PHY_CTRL, 0x4, val);
 
 	return pcie_phy_poll_ack(imx6_pcie, 0);
 }
@@ -154,17 +154,17 @@ static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, int *data)
 
 	/* assert Read signal */
 	phy_ctl = 0x1 << PCIE_PHY_CTRL_RD_LOC;
-	dw_pcie_writel_dbi(pci, base, PCIE_PHY_CTRL, phy_ctl);
+	dw_pcie_write_dbi(pci, base, PCIE_PHY_CTRL, 0x4, phy_ctl);
 
 	ret = pcie_phy_poll_ack(imx6_pcie, 1);
 	if (ret)
 		return ret;
 
-	val = dw_pcie_readl_dbi(pci, base, PCIE_PHY_STAT);
+	val = dw_pcie_read_dbi(pci, base, PCIE_PHY_STAT, 0x4);
 	*data = val & 0xffff;
 
 	/* deassert Read signal */
-	dw_pcie_writel_dbi(pci, base, PCIE_PHY_CTRL, 0x00);
+	dw_pcie_write_dbi(pci, base, PCIE_PHY_CTRL, 0x4, 0x00);
 
 	return pcie_phy_poll_ack(imx6_pcie, 0);
 }
@@ -183,11 +183,11 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 		return ret;
 
 	var = data << PCIE_PHY_CTRL_DATA_LOC;
-	dw_pcie_writel_dbi(pci, base, PCIE_PHY_CTRL, var);
+	dw_pcie_write_dbi(pci, base, PCIE_PHY_CTRL, 0x4, var);
 
 	/* capture data */
 	var |= (0x1 << PCIE_PHY_CTRL_CAP_DAT_LOC);
-	dw_pcie_writel_dbi(pci, base, PCIE_PHY_CTRL, var);
+	dw_pcie_write_dbi(pci, base, PCIE_PHY_CTRL, 0x4, var);
 
 	ret = pcie_phy_poll_ack(imx6_pcie, 1);
 	if (ret)
@@ -195,7 +195,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 
 	/* deassert cap data */
 	var = data << PCIE_PHY_CTRL_DATA_LOC;
-	dw_pcie_writel_dbi(pci, base, PCIE_PHY_CTRL, var);
+	dw_pcie_write_dbi(pci, base, PCIE_PHY_CTRL, 0x4, var);
 
 	/* wait for ack de-assertion */
 	ret = pcie_phy_poll_ack(imx6_pcie, 0);
@@ -204,7 +204,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 
 	/* assert wr signal */
 	var = 0x1 << PCIE_PHY_CTRL_WR_LOC;
-	dw_pcie_writel_dbi(pci, base, PCIE_PHY_CTRL, var);
+	dw_pcie_write_dbi(pci, base, PCIE_PHY_CTRL, 0x4, var);
 
 	/* wait for ack */
 	ret = pcie_phy_poll_ack(imx6_pcie, 1);
@@ -213,14 +213,14 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 
 	/* deassert wr signal */
 	var = data << PCIE_PHY_CTRL_DATA_LOC;
-	dw_pcie_writel_dbi(pci, base, PCIE_PHY_CTRL, var);
+	dw_pcie_write_dbi(pci, base, PCIE_PHY_CTRL, 0x4, var);
 
 	/* wait for ack de-assertion */
 	ret = pcie_phy_poll_ack(imx6_pcie, 0);
 	if (ret)
 		return ret;
 
-	dw_pcie_writel_dbi(pci, base, PCIE_PHY_CTRL, 0x0);
+	dw_pcie_write_dbi(pci, base, PCIE_PHY_CTRL, 0x4, 0x0);
 
 	return 0;
 }
@@ -289,10 +289,10 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 
 		if ((gpr1 & IMX6Q_GPR1_PCIE_REF_CLK_EN) &&
 		    (gpr12 & IMX6Q_GPR12_PCIE_CTL_2)) {
-			val = dw_pcie_readl_dbi(pci, base, PCIE_PL_PFLR);
+			val = dw_pcie_read_dbi(pci, base, PCIE_PL_PFLR, 0x4);
 			val &= ~PCIE_PL_PFLR_LINK_STATE_MASK;
 			val |= PCIE_PL_PFLR_FORCE_LINK;
-			dw_pcie_writel_dbi(pci, base, PCIE_PL_PFLR, val);
+			dw_pcie_write_dbi(pci, base, PCIE_PL_PFLR, 0x4, val);
 
 			regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 					   IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
@@ -454,8 +454,8 @@ static int imx6_pcie_wait_for_link(struct imx6_pcie *imx6_pcie)
 		return 0;
 
 	dev_dbg(dev, "DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
-		dw_pcie_readl_dbi(pci, base, PCIE_PHY_DEBUG_R0),
-		dw_pcie_readl_dbi(pci, base, PCIE_PHY_DEBUG_R1));
+		dw_pcie_read_dbi(pci, base, PCIE_PHY_DEBUG_R0, 0x4),
+		dw_pcie_read_dbi(pci, base, PCIE_PHY_DEBUG_R1, 0x4));
 	return -ETIMEDOUT;
 }
 
@@ -468,8 +468,8 @@ static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
 	unsigned int retries;
 
 	for (retries = 0; retries < 200; retries++) {
-		tmp = dw_pcie_readl_dbi(pci, base,
-					PCIE_LINK_WIDTH_SPEED_CONTROL);
+		tmp = dw_pcie_read_dbi(pci, base,
+				       PCIE_LINK_WIDTH_SPEED_CONTROL, 0x4);
 		/* Test if the speed change finished. */
 		if (!(tmp & PORT_LOGIC_SPEED_CHANGE))
 			return 0;
@@ -502,10 +502,10 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 	 * started in Gen2 mode, there is a possibility the devices on the
 	 * bus will not be detected at all.  This happens with PCIe switches.
 	 */
-	tmp = dw_pcie_readl_dbi(pci, base, PCIE_RC_LCR);
+	tmp = dw_pcie_read_dbi(pci, base, PCIE_RC_LCR, 0x4);
 	tmp &= ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
 	tmp |= PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1;
-	dw_pcie_writel_dbi(pci, base, PCIE_RC_LCR, tmp);
+	dw_pcie_write_dbi(pci, base, PCIE_RC_LCR, 0x4, tmp);
 
 	/* Start LTSSM. */
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
@@ -519,10 +519,10 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 
 	if (imx6_pcie->link_gen == 2) {
 		/* Allow Gen2 mode after the link is up. */
-		tmp = dw_pcie_readl_dbi(pci, base, PCIE_RC_LCR);
+		tmp = dw_pcie_read_dbi(pci, base, PCIE_RC_LCR, 0x4);
 		tmp &= ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
 		tmp |= PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN2;
-		dw_pcie_writel_dbi(pci, base, PCIE_RC_LCR, tmp);
+		dw_pcie_write_dbi(pci, base, PCIE_RC_LCR, 0x4, tmp);
 	} else {
 		dev_info(dev, "Link: Gen2 disabled\n");
 	}
@@ -531,9 +531,9 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 	 * Start Directed Speed Change so the best possible speed both link
 	 * partners support can be negotiated.
 	 */
-	tmp = dw_pcie_readl_dbi(pci, base, PCIE_LINK_WIDTH_SPEED_CONTROL);
+	tmp = dw_pcie_read_dbi(pci, base, PCIE_LINK_WIDTH_SPEED_CONTROL, 0x4);
 	tmp |= PORT_LOGIC_SPEED_CHANGE;
-	dw_pcie_writel_dbi(pci, base, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
+	dw_pcie_write_dbi(pci, base, PCIE_LINK_WIDTH_SPEED_CONTROL, 0x4, tmp);
 
 	ret = imx6_pcie_wait_for_speed_change(imx6_pcie);
 	if (ret) {
@@ -548,14 +548,14 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 		goto err_reset_phy;
 	}
 
-	tmp = dw_pcie_readl_dbi(pci, base, PCIE_RC_LCSR);
+	tmp = dw_pcie_read_dbi(pci, base, PCIE_RC_LCSR, 0x4);
 	dev_info(dev, "Link up, Gen%i\n", (tmp >> 16) & 0xf);
 	return 0;
 
 err_reset_phy:
 	dev_dbg(dev, "PHY DEBUG_R0=0x%08x DEBUG_R1=0x%08x\n",
-		dw_pcie_readl_dbi(pci, base, PCIE_PHY_DEBUG_R0),
-		dw_pcie_readl_dbi(pci, base, PCIE_PHY_DEBUG_R1));
+		dw_pcie_read_dbi(pci, base, PCIE_PHY_DEBUG_R0, 0x4),
+		dw_pcie_read_dbi(pci, base, PCIE_PHY_DEBUG_R1, 0x4));
 	imx6_pcie_reset_phy(imx6_pcie);
 	return ret;
 }
@@ -579,7 +579,7 @@ static int imx6_pcie_link_up(struct dw_pcie *pci)
 {
 	void __iomem *base = pci->dbi_base;
 
-	return dw_pcie_readl_dbi(pci, base, PCIE_PHY_DEBUG_R1) &
+	return dw_pcie_read_dbi(pci, base, PCIE_PHY_DEBUG_R1, 0x4) &
 			PCIE_PHY_DEBUG_R1_XMLH_LINK_UP;
 }
 
diff --git a/drivers/pci/dwc/pci-keystone-dw.c b/drivers/pci/dwc/pci-keystone-dw.c
index 7220c04..8318efe 100644
--- a/drivers/pci/dwc/pci-keystone-dw.c
+++ b/drivers/pci/dwc/pci-keystone-dw.c
@@ -386,8 +386,8 @@ void ks_dw_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
 
 	/* Disable BARs for inbound access */
 	ks_dw_pcie_set_dbi_mode(ks_pcie);
-	dw_pcie_writel_dbi(pci, base, PCI_BASE_ADDRESS_0, 0);
-	dw_pcie_writel_dbi(pci, base, PCI_BASE_ADDRESS_1, 0);
+	dw_pcie_write_dbi(pci, base, PCI_BASE_ADDRESS_0, 0x4, 0);
+	dw_pcie_write_dbi(pci, base, PCI_BASE_ADDRESS_1, 0x4, 0);
 	ks_dw_pcie_clear_dbi_mode(ks_pcie);
 
 	/* Set outbound translation size per window division */
@@ -490,8 +490,8 @@ void ks_dw_pcie_v3_65_scan_bus(struct pcie_port *pp)
 	ks_dw_pcie_set_dbi_mode(ks_pcie);
 
 	/* Enable BAR0 */
-	dw_pcie_writel_dbi(pci, base, PCI_BASE_ADDRESS_0, 1);
-	dw_pcie_writel_dbi(pci, base, PCI_BASE_ADDRESS_0, SZ_4K - 1);
+	dw_pcie_write_dbi(pci, base, PCI_BASE_ADDRESS_0, 0x4, 1);
+	dw_pcie_write_dbi(pci, base, PCI_BASE_ADDRESS_0, 0x4, SZ_4K - 1);
 
 	ks_dw_pcie_clear_dbi_mode(ks_pcie);
 
@@ -499,7 +499,8 @@ void ks_dw_pcie_v3_65_scan_bus(struct pcie_port *pp)
 	  * For BAR0, just setting bus address for inbound writes (MSI) should
 	  * be sufficient.  Use physical address to avoid any conflicts.
 	  */
-	dw_pcie_writel_dbi(pci, base, PCI_BASE_ADDRESS_0, ks_pcie->app.start);
+	dw_pcie_write_dbi(pci, base, PCI_BASE_ADDRESS_0, 0x4,
+			  ks_pcie->app.start);
 }
 
 /**
@@ -510,7 +511,7 @@ int ks_dw_pcie_link_up(struct dw_pcie *pci)
 	u32 val;
 	void __iomem *base = pci->dbi_base;
 
-	val = dw_pcie_readl_dbi(pci, base, DEBUG0);
+	val = dw_pcie_read_dbi(pci, base, DEBUG0, 0x4);
 	return (val & LTSSM_STATE_MASK) == LTSSM_STATE_L0;
 }
 
diff --git a/drivers/pci/dwc/pcie-armada8k.c b/drivers/pci/dwc/pcie-armada8k.c
index 2656f86..6067749 100644
--- a/drivers/pci/dwc/pcie-armada8k.c
+++ b/drivers/pci/dwc/pcie-armada8k.c
@@ -75,7 +75,7 @@ static int armada8k_pcie_link_up(struct dw_pcie *pci)
 	u32 mask = PCIE_GLB_STS_RDLH_LINK_UP | PCIE_GLB_STS_PHY_LINK_UP;
 	void __iomem *base = pci->dbi_base;
 
-	reg = dw_pcie_readl_dbi(pci, base, PCIE_GLOBAL_STATUS_REG);
+	reg = dw_pcie_read_dbi(pci, base, PCIE_GLOBAL_STATUS_REG, 0x4);
 
 	if ((reg & mask) == mask)
 		return 1;
@@ -92,45 +92,45 @@ static void armada8k_pcie_establish_link(struct armada8k_pcie *pcie)
 
 	if (!dw_pcie_link_up(pci)) {
 		/* Disable LTSSM state machine to enable configuration */
-		reg = dw_pcie_readl_dbi(pci, base, PCIE_GLOBAL_CONTROL_REG);
+		reg = dw_pcie_read_dbi(pci, base, PCIE_GLOBAL_CONTROL_REG, 0x4);
 		reg &= ~(PCIE_APP_LTSSM_EN);
-		dw_pcie_writel_dbi(pci, base, PCIE_GLOBAL_CONTROL_REG, reg);
+		dw_pcie_write_dbi(pci, base, PCIE_GLOBAL_CONTROL_REG, 0x4, reg);
 	}
 
 	/* Set the device to root complex mode */
-	reg = dw_pcie_readl_dbi(pci, base, PCIE_GLOBAL_CONTROL_REG);
+	reg = dw_pcie_read_dbi(pci, base, PCIE_GLOBAL_CONTROL_REG, 0x4);
 	reg &= ~(PCIE_DEVICE_TYPE_MASK << PCIE_DEVICE_TYPE_SHIFT);
 	reg |= PCIE_DEVICE_TYPE_RC << PCIE_DEVICE_TYPE_SHIFT;
-	dw_pcie_writel_dbi(pci, base, PCIE_GLOBAL_CONTROL_REG, reg);
+	dw_pcie_write_dbi(pci, base, PCIE_GLOBAL_CONTROL_REG, 0x4, reg);
 
 	/* Set the PCIe master AxCache attributes */
-	dw_pcie_writel_dbi(pci, base, PCIE_ARCACHE_TRC_REG,
-			   ARCACHE_DEFAULT_VALUE);
-	dw_pcie_writel_dbi(pci, base, PCIE_AWCACHE_TRC_REG,
-			   AWCACHE_DEFAULT_VALUE);
+	dw_pcie_write_dbi(pci, base, PCIE_ARCACHE_TRC_REG, 0x4,
+			  ARCACHE_DEFAULT_VALUE);
+	dw_pcie_write_dbi(pci, base, PCIE_AWCACHE_TRC_REG, 0x4,
+			  AWCACHE_DEFAULT_VALUE);
 
 	/* Set the PCIe master AxDomain attributes */
-	reg = dw_pcie_readl_dbi(pci, base, PCIE_ARUSER_REG);
+	reg = dw_pcie_read_dbi(pci, base, PCIE_ARUSER_REG, 0x4);
 	reg &= ~(AX_USER_DOMAIN_MASK << AX_USER_DOMAIN_SHIFT);
 	reg |= DOMAIN_OUTER_SHAREABLE << AX_USER_DOMAIN_SHIFT;
-	dw_pcie_writel_dbi(pci, base, PCIE_ARUSER_REG, reg);
+	dw_pcie_write_dbi(pci, base, PCIE_ARUSER_REG, 0x4, reg);
 
-	reg = dw_pcie_readl_dbi(pci, base, PCIE_AWUSER_REG);
+	reg = dw_pcie_read_dbi(pci, base, PCIE_AWUSER_REG, 0x4);
 	reg &= ~(AX_USER_DOMAIN_MASK << AX_USER_DOMAIN_SHIFT);
 	reg |= DOMAIN_OUTER_SHAREABLE << AX_USER_DOMAIN_SHIFT;
-	dw_pcie_writel_dbi(pci, base, PCIE_AWUSER_REG, reg);
+	dw_pcie_write_dbi(pci, base, PCIE_AWUSER_REG, 0x4, reg);
 
 	/* Enable INT A-D interrupts */
-	reg = dw_pcie_readl_dbi(pci, base, PCIE_GLOBAL_INT_MASK1_REG);
+	reg = dw_pcie_read_dbi(pci, base, PCIE_GLOBAL_INT_MASK1_REG, 0x4);
 	reg |= PCIE_INT_A_ASSERT_MASK | PCIE_INT_B_ASSERT_MASK |
 	       PCIE_INT_C_ASSERT_MASK | PCIE_INT_D_ASSERT_MASK;
-	dw_pcie_writel_dbi(pci, base, PCIE_GLOBAL_INT_MASK1_REG, reg);
+	dw_pcie_write_dbi(pci, base, PCIE_GLOBAL_INT_MASK1_REG, 0x4, reg);
 
 	if (!dw_pcie_link_up(pci)) {
 		/* Configuration done. Start LTSSM */
-		reg = dw_pcie_readl_dbi(pci, base, PCIE_GLOBAL_CONTROL_REG);
+		reg = dw_pcie_read_dbi(pci, base, PCIE_GLOBAL_CONTROL_REG, 0x4);
 		reg |= PCIE_APP_LTSSM_EN;
-		dw_pcie_writel_dbi(pci, base, PCIE_GLOBAL_CONTROL_REG, reg);
+		dw_pcie_write_dbi(pci, base, PCIE_GLOBAL_CONTROL_REG, 0x4, reg);
 	}
 
 	/* Wait until the link becomes active again */
@@ -159,8 +159,8 @@ static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
 	 * PCI device. However, they are also latched into the PCIe
 	 * controller, so we simply discard them.
 	 */
-	val = dw_pcie_readl_dbi(pci, base, PCIE_GLOBAL_INT_CAUSE1_REG);
-	dw_pcie_writel_dbi(pci, base, PCIE_GLOBAL_INT_CAUSE1_REG, val);
+	val = dw_pcie_read_dbi(pci, base, PCIE_GLOBAL_INT_CAUSE1_REG, 0x4);
+	dw_pcie_write_dbi(pci, base, PCIE_GLOBAL_INT_CAUSE1_REG, 0x4, val);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/pci/dwc/pcie-artpec6.c b/drivers/pci/dwc/pcie-artpec6.c
index 4c7820a..a00b703 100644
--- a/drivers/pci/dwc/pcie-artpec6.c
+++ b/drivers/pci/dwc/pcie-artpec6.c
@@ -141,7 +141,7 @@ static int artpec6_pcie_establish_link(struct artpec6_pcie *artpec6_pcie)
 	 * Enable writing to config regs. This is required as the Synopsys
 	 * driver changes the class code. That register needs DBI write enable.
 	 */
-	dw_pcie_writel_dbi(pci, base, MISC_CONTROL_1_OFF, DBI_RO_WR_EN);
+	dw_pcie_write_dbi(pci, base, MISC_CONTROL_1_OFF, 0x4, DBI_RO_WR_EN);
 
 	pp->io_base &= ARTPEC6_CPU_TO_BUS_ADDR;
 	pp->mem_base &= ARTPEC6_CPU_TO_BUS_ADDR;
@@ -161,8 +161,8 @@ static int artpec6_pcie_establish_link(struct artpec6_pcie *artpec6_pcie)
 		return 0;
 
 	dev_dbg(pci->dev, "DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
-		dw_pcie_readl_dbi(pci, base, PCIE_PHY_DEBUG_R0),
-		dw_pcie_readl_dbi(pci, base, PCIE_PHY_DEBUG_R1));
+		dw_pcie_read_dbi(pci, base, PCIE_PHY_DEBUG_R0, 0x4),
+		dw_pcie_read_dbi(pci, base, PCIE_PHY_DEBUG_R1, 0x4));
 
 	return -ETIMEDOUT;
 }
diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
index e3a5104..044fcda 100644
--- a/drivers/pci/dwc/pcie-designware-host.c
+++ b/drivers/pci/dwc/pcie-designware-host.c
@@ -572,27 +572,27 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	dw_pcie_setup(pci);
 
 	/* setup RC BARs */
-	dw_pcie_writel_dbi(pci, base, PCI_BASE_ADDRESS_0, 0x00000004);
-	dw_pcie_writel_dbi(pci, base, PCI_BASE_ADDRESS_1, 0x00000000);
+	dw_pcie_write_dbi(pci, base, PCI_BASE_ADDRESS_0, 0x4, 0x00000004);
+	dw_pcie_write_dbi(pci, base, PCI_BASE_ADDRESS_1, 0x4, 0x00000000);
 
 	/* setup interrupt pins */
-	val = dw_pcie_readl_dbi(pci, base, PCI_INTERRUPT_LINE);
+	val = dw_pcie_read_dbi(pci, base, PCI_INTERRUPT_LINE, 0x4);
 	val &= 0xffff00ff;
 	val |= 0x00000100;
-	dw_pcie_writel_dbi(pci, base, PCI_INTERRUPT_LINE, val);
+	dw_pcie_write_dbi(pci, base, PCI_INTERRUPT_LINE, 0x4, val);
 
 	/* setup bus numbers */
-	val = dw_pcie_readl_dbi(pci, base, PCI_PRIMARY_BUS);
+	val = dw_pcie_read_dbi(pci, base, PCI_PRIMARY_BUS, 0x4);
 	val &= 0xff000000;
 	val |= 0x00010100;
-	dw_pcie_writel_dbi(pci, base, PCI_PRIMARY_BUS, val);
+	dw_pcie_write_dbi(pci, base, PCI_PRIMARY_BUS, 0x4, val);
 
 	/* setup command register */
-	val = dw_pcie_readl_dbi(pci, base, PCI_COMMAND);
+	val = dw_pcie_read_dbi(pci, base, PCI_COMMAND, 0x4);
 	val &= 0xffff0000;
 	val |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
 		PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
-	dw_pcie_writel_dbi(pci, base, PCI_COMMAND, val);
+	dw_pcie_write_dbi(pci, base, PCI_COMMAND, 0x4, val);
 
 	/*
 	 * If the platform provides ->rd_other_conf, it means the platform
diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-designware.c
index db39f13..ef545e7 100644
--- a/drivers/pci/dwc/pcie-designware.c
+++ b/drivers/pci/dwc/pcie-designware.c
@@ -61,21 +61,35 @@ int dw_pcie_write(void __iomem *addr, int size, u32 val)
 	return PCIBIOS_SUCCESSFUL;
 }
 
-u32 dw_pcie_readl_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg)
+u32 dw_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
+		     int size)
 {
-	if (pci->ops->readl_dbi)
-		return pci->ops->readl_dbi(pci, base, reg);
+	int ret;
+	u32 val;
+
+	if (pci->ops->read_dbi)
+		return pci->ops->read_dbi(pci, base,  reg, size);
 
-	return readl(base + reg);
+	ret = dw_pcie_read(base + reg, size, &val);
+	if (ret)
+		dev_err(pci->dev, "read DBI address failed\n");
+
+	return val;
 }
 
-void dw_pcie_writel_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
-			u32 val)
+void dw_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
+		       int size, u32 val)
 {
-	if (pci->ops->writel_dbi)
-		pci->ops->writel_dbi(pci, base, reg, val);
-	else
-		writel(val, base + reg);
+	int ret;
+
+	if (pci->ops->write_dbi) {
+		pci->ops->write_dbi(pci, base, reg, size, val);
+		return;
+	}
+
+	ret = dw_pcie_write(base + reg, size, val);
+	if (ret)
+		dev_err(pci->dev, "write DBI address failed\n");
 }
 
 static u32 dw_pcie_readl_unroll(struct dw_pcie *pci, void __iomem *base,
@@ -83,7 +97,7 @@ static u32 dw_pcie_readl_unroll(struct dw_pcie *pci, void __iomem *base,
 {
 	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
 
-	return dw_pcie_readl_dbi(pci, base, offset + reg);
+	return dw_pcie_read_dbi(pci, base, offset + reg, 0x4);
 }
 
 static void dw_pcie_writel_unroll(struct dw_pcie *pci, void __iomem *base,
@@ -91,7 +105,7 @@ static void dw_pcie_writel_unroll(struct dw_pcie *pci, void __iomem *base,
 {
 	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
 
-	dw_pcie_writel_dbi(pci, base, offset + reg, val);
+	dw_pcie_write_dbi(pci, base, offset + reg, 0x4, val);
 }
 
 void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
@@ -122,20 +136,21 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
 				      PCIE_ATU_UNR_REGION_CTRL2,
 				      PCIE_ATU_ENABLE);
 	} else {
-		dw_pcie_writel_dbi(pci, base, PCIE_ATU_VIEWPORT,
-				   PCIE_ATU_REGION_OUTBOUND | index);
-		dw_pcie_writel_dbi(pci, base, PCIE_ATU_LOWER_BASE,
-				   lower_32_bits(cpu_addr));
-		dw_pcie_writel_dbi(pci, base, PCIE_ATU_UPPER_BASE,
-				   upper_32_bits(cpu_addr));
-		dw_pcie_writel_dbi(pci, base, PCIE_ATU_LIMIT,
-				   lower_32_bits(cpu_addr + size - 1));
-		dw_pcie_writel_dbi(pci, base, PCIE_ATU_LOWER_TARGET,
-				   lower_32_bits(pci_addr));
-		dw_pcie_writel_dbi(pci, base, PCIE_ATU_UPPER_TARGET,
-				   upper_32_bits(pci_addr));
-		dw_pcie_writel_dbi(pci, base, PCIE_ATU_CR1, type);
-		dw_pcie_writel_dbi(pci, base, PCIE_ATU_CR2, PCIE_ATU_ENABLE);
+		dw_pcie_write_dbi(pci, base, PCIE_ATU_VIEWPORT, 0x4,
+				  PCIE_ATU_REGION_OUTBOUND | index);
+		dw_pcie_write_dbi(pci, base, PCIE_ATU_LOWER_BASE, 0x4,
+				  lower_32_bits(cpu_addr));
+		dw_pcie_write_dbi(pci, base, PCIE_ATU_UPPER_BASE, 0x4,
+				  upper_32_bits(cpu_addr));
+		dw_pcie_write_dbi(pci, base, PCIE_ATU_LIMIT, 0x4,
+				  lower_32_bits(cpu_addr + size - 1));
+		dw_pcie_write_dbi(pci, base, PCIE_ATU_LOWER_TARGET, 0x4,
+				  lower_32_bits(pci_addr));
+		dw_pcie_write_dbi(pci, base, PCIE_ATU_UPPER_TARGET, 0x4,
+				  upper_32_bits(pci_addr));
+		dw_pcie_write_dbi(pci, base, PCIE_ATU_CR1, 0x4, type);
+		dw_pcie_write_dbi(pci, base, PCIE_ATU_CR2, 0x4,
+				  PCIE_ATU_ENABLE);
 	}
 
 	/*
@@ -147,7 +162,7 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
 			val = dw_pcie_readl_unroll(pci, base, index,
 						   PCIE_ATU_UNR_REGION_CTRL2);
 		else
-			val = dw_pcie_readl_dbi(pci, base, PCIE_ATU_CR2);
+			val = dw_pcie_read_dbi(pci, base, PCIE_ATU_CR2, 0x4);
 
 		if (val == PCIE_ATU_ENABLE)
 			return;
@@ -192,7 +207,7 @@ static u8 dw_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
 	u32 val;
 	void __iomem *base = pci->dbi_base;
 
-	val = dw_pcie_readl_dbi(pci, base, PCIE_ATU_VIEWPORT);
+	val = dw_pcie_read_dbi(pci, base, PCIE_ATU_VIEWPORT, 0x4);
 	if (val == 0xffffffff)
 		return 1;
 
@@ -218,7 +233,7 @@ void dw_pcie_setup(struct dw_pcie *pci)
 		lanes = 0;
 
 	/* set the number of lanes */
-	val = dw_pcie_readl_dbi(pci, base, PCIE_PORT_LINK_CONTROL);
+	val = dw_pcie_read_dbi(pci, base, PCIE_PORT_LINK_CONTROL, 0x4);
 	val &= ~PORT_LINK_MODE_MASK;
 	switch (lanes) {
 	case 1:
@@ -237,10 +252,10 @@ void dw_pcie_setup(struct dw_pcie *pci)
 		dev_err(pci->dev, "num-lanes %u: invalid value\n", lanes);
 		return;
 	}
-	dw_pcie_writel_dbi(pci, base, PCIE_PORT_LINK_CONTROL, val);
+	dw_pcie_write_dbi(pci, base, PCIE_PORT_LINK_CONTROL, 0x4, val);
 
 	/* set link width speed control register */
-	val = dw_pcie_readl_dbi(pci, base, PCIE_LINK_WIDTH_SPEED_CONTROL);
+	val = dw_pcie_read_dbi(pci, base, PCIE_LINK_WIDTH_SPEED_CONTROL, 0x4);
 	val &= ~PORT_LOGIC_LINK_WIDTH_MASK;
 	switch (lanes) {
 	case 1:
@@ -256,5 +271,5 @@ void dw_pcie_setup(struct dw_pcie *pci)
 		val |= PORT_LOGIC_LINK_WIDTH_8_LANES;
 		break;
 	}
-	dw_pcie_writel_dbi(pci, base, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
+	dw_pcie_write_dbi(pci, base, PCIE_LINK_WIDTH_SPEED_CONTROL, 0x4, val);
 }
diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
index fe93f7f..0ef6ae7 100644
--- a/drivers/pci/dwc/pcie-designware.h
+++ b/drivers/pci/dwc/pcie-designware.h
@@ -144,9 +144,10 @@ struct pcie_port {
 
 struct dw_pcie_ops {
 	u64	(*cpu_addr_fixup)(u64 cpu_addr);
-	u32	(*readl_dbi)(struct dw_pcie *pcie, void __iomem *base, u32 reg);
-	void	(*writel_dbi)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
-			      u32 val);
+	u32	(*read_dbi)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
+			    int size);
+	void	(*write_dbi)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
+			     int size, u32 val);
 	int	(*link_up)(struct dw_pcie *pcie);
 };
 
@@ -164,9 +165,10 @@ struct dw_pcie {
 int dw_pcie_read(void __iomem *addr, int size, u32 *val);
 int dw_pcie_write(void __iomem *addr, int size, u32 val);
 
-u32 dw_pcie_readl_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg);
-void dw_pcie_writel_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
-			u32 val);
+u32 dw_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
+		     int size);
+void dw_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
+		       int size, u32 val);
 int dw_pcie_link_up(struct dw_pcie *pci);
 int dw_pcie_wait_for_link(struct dw_pcie *pci);
 void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
diff --git a/drivers/pci/dwc/pcie-hisi.c b/drivers/pci/dwc/pcie-hisi.c
index 560f6a4..f8f7d43 100644
--- a/drivers/pci/dwc/pcie-hisi.c
+++ b/drivers/pci/dwc/pcie-hisi.c
@@ -154,7 +154,7 @@ static int hisi_pcie_cfg_read(struct pcie_port *pp, int where, int size,
 
 	walker += (where & 0x3);
 	reg = where & ~0x3;
-	reg_val = dw_pcie_readl_dbi(pci, base, reg);
+	reg_val = dw_pcie_read_dbi(pci, base, reg, 0x4);
 
 	if (size == 1)
 		*val = *(u8 __force *) walker;
@@ -181,15 +181,15 @@ static int hisi_pcie_cfg_write(struct pcie_port *pp, int where, int  size,
 	walker += (where & 0x3);
 	reg = where & ~0x3;
 	if (size == 4)
-		dw_pcie_writel_dbi(pci, base, reg, val);
+		dw_pcie_write_dbi(pci, base, reg, 0x4, val);
 	else if (size == 2) {
-		reg_val = dw_pcie_readl_dbi(pci, base, reg);
+		reg_val = dw_pcie_read_dbi(pci, base, reg, 0x4);
 		*(u16 __force *) walker = val;
-		dw_pcie_writel_dbi(pci, base, reg, reg_val);
+		dw_pcie_write_dbi(pci, base, reg, 0x4, reg_val);
 	} else if (size == 1) {
-		reg_val = dw_pcie_readl_dbi(pci, base, reg);
+		reg_val = dw_pcie_read_dbi(pci, base, reg, 0x4);
 		*(u8 __force *) walker = val;
-		dw_pcie_writel_dbi(pci, base, reg, reg_val);
+		dw_pcie_write_dbi(pci, base, reg, 0x4, reg_val);
 	} else
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
@@ -212,7 +212,7 @@ static int hisi_pcie_link_up_hip06(struct hisi_pcie *hisi_pcie)
 	void __iomem *base = pci->dbi_base;
 	u32 val;
 
-	val = dw_pcie_readl_dbi(pci, base, PCIE_SYS_STATE4);
+	val = dw_pcie_read_dbi(pci, base, PCIE_SYS_STATE4, 0x4);
 
 	return ((val & PCIE_LTSSM_STATE_MASK) == PCIE_LTSSM_LINKUP_STATE);
 }
-- 
1.7.9.5
