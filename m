Return-Path: <clabbe@baylibre.com>
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 426SWk65bTzF3TQ
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Sep 2018 05:42:26 +1000 (AEST)
Received: by mail-wr1-x443.google.com with SMTP id a108-v6so15979782wrc.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Sep 2018 12:42:26 -0700 (PDT)
From: Corentin Labbe <clabbe@baylibre.com>
To: Gilles.Muller@lip6.fr, Julia.Lawall@lip6.fr, agust@denx.de,
 alexandre.torgue@st.com, alistair@popple.id.au, benh@kernel.crashing.org,
 carlo@caione.org, davem@davemloft.net, galak@kernel.crashing.org,
 joabreu@synopsys.com, khilman@baylibre.com, maxime.ripard@bootlin.com,
 michal.lkml@markovi.net, mpe@ellerman.id.au, mporter@kernel.crashing.org,
 nicolas.palix@imag.fr, oss@buserror.net, paulus@samba.org,
 peppe.cavallaro@st.com, tj@kernel.org, vitb@kernel.crashing.org,
 wens@csie.org
Cc: cocci@systeme.lip6.fr, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, linux-sunxi@googlegroups.com,
 Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 4/5] net: ethernet: stmmac: use xxxsetbits32
Date: Fri,  7 Sep 2018 19:41:46 +0000
Message-Id: <1536349307-20714-5-git-send-email-clabbe@baylibre.com>
In-Reply-To: <1536349307-20714-1-git-send-email-clabbe@baylibre.com>
References: <1536349307-20714-1-git-send-email-clabbe@baylibre.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch convert stmmac driver to use all xxxsetbits32 functions.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-meson8b.c    | 54 +++++++----------
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  | 55 ++++-------------
 .../net/ethernet/stmicro/stmmac/dwmac1000_core.c   | 21 +++----
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  | 51 ++++++----------
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c   | 13 ++--
 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c   | 42 +++----------
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c       | 11 +---
 drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c    | 17 ++----
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    | 30 ++++------
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 69 +++++-----------------
 .../net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c  | 11 +---
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  |  7 +--
 12 files changed, 108 insertions(+), 273 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
index c5979569fd60..035a2ab7b479 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
@@ -22,6 +22,7 @@
 #include <linux/of_net.h>
 #include <linux/mfd/syscon.h>
 #include <linux/platform_device.h>
+#include <linux/setbits.h>
 #include <linux/stmmac.h>
 
 #include "stmmac_platform.h"
@@ -75,18 +76,6 @@ struct meson8b_dwmac_clk_configs {
 	struct clk_gate		rgmii_tx_en;
 };
 
-static void meson8b_dwmac_mask_bits(struct meson8b_dwmac *dwmac, u32 reg,
-				    u32 mask, u32 value)
-{
-	u32 data;
-
-	data = readl(dwmac->regs + reg);
-	data &= ~mask;
-	data |= (value & mask);
-
-	writel(data, dwmac->regs + reg);
-}
-
 static struct clk *meson8b_dwmac_register_clk(struct meson8b_dwmac *dwmac,
 					      const char *name_suffix,
 					      const char **parent_names,
@@ -192,14 +181,12 @@ static int meson8b_set_phy_mode(struct meson8b_dwmac *dwmac)
 	case PHY_INTERFACE_MODE_RGMII_ID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		/* enable RGMII mode */
-		meson8b_dwmac_mask_bits(dwmac, PRG_ETH0,
-					PRG_ETH0_RGMII_MODE,
-					PRG_ETH0_RGMII_MODE);
+		clrsetbits32(dwmac->regs + PRG_ETH0, PRG_ETH0_RGMII_MODE,
+			     PRG_ETH0_RGMII_MODE);
 		break;
 	case PHY_INTERFACE_MODE_RMII:
 		/* disable RGMII mode -> enables RMII mode */
-		meson8b_dwmac_mask_bits(dwmac, PRG_ETH0,
-					PRG_ETH0_RGMII_MODE, 0);
+		clrsetbits32(dwmac->regs + PRG_ETH0, PRG_ETH0_RGMII_MODE, 0);
 		break;
 	default:
 		dev_err(dwmac->dev, "fail to set phy-mode %s\n",
@@ -218,15 +205,15 @@ static int meson_axg_set_phy_mode(struct meson8b_dwmac *dwmac)
 	case PHY_INTERFACE_MODE_RGMII_ID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		/* enable RGMII mode */
-		meson8b_dwmac_mask_bits(dwmac, PRG_ETH0,
-					PRG_ETH0_EXT_PHY_MODE_MASK,
-					PRG_ETH0_EXT_RGMII_MODE);
+		clrsetbits32(dwmac->regs + PRG_ETH0,
+			     PRG_ETH0_EXT_PHY_MODE_MASK,
+			     PRG_ETH0_EXT_RGMII_MODE);
 		break;
 	case PHY_INTERFACE_MODE_RMII:
 		/* disable RGMII mode -> enables RMII mode */
-		meson8b_dwmac_mask_bits(dwmac, PRG_ETH0,
-					PRG_ETH0_EXT_PHY_MODE_MASK,
-					PRG_ETH0_EXT_RMII_MODE);
+		clrsetbits32(dwmac->regs + PRG_ETH0,
+			     PRG_ETH0_EXT_PHY_MODE_MASK,
+			     PRG_ETH0_EXT_RMII_MODE);
 		break;
 	default:
 		dev_err(dwmac->dev, "fail to set phy-mode %s\n",
@@ -255,11 +242,11 @@ static int meson8b_init_prg_eth(struct meson8b_dwmac *dwmac)
 	case PHY_INTERFACE_MODE_RGMII_ID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		/* only relevant for RMII mode -> disable in RGMII mode */
-		meson8b_dwmac_mask_bits(dwmac, PRG_ETH0,
-					PRG_ETH0_INVERTED_RMII_CLK, 0);
+		clrsetbits32(dwmac->regs + PRG_ETH0,
+			     PRG_ETH0_INVERTED_RMII_CLK, 0);
 
-		meson8b_dwmac_mask_bits(dwmac, PRG_ETH0, PRG_ETH0_TXDLY_MASK,
-					tx_dly_val << PRG_ETH0_TXDLY_SHIFT);
+		clrsetbits32(dwmac->regs + PRG_ETH0, PRG_ETH0_TXDLY_MASK,
+			     tx_dly_val << PRG_ETH0_TXDLY_SHIFT);
 
 		/* Configure the 125MHz RGMII TX clock, the IP block changes
 		 * the output automatically (= without us having to configure
@@ -287,13 +274,12 @@ static int meson8b_init_prg_eth(struct meson8b_dwmac *dwmac)
 
 	case PHY_INTERFACE_MODE_RMII:
 		/* invert internal clk_rmii_i to generate 25/2.5 tx_rx_clk */
-		meson8b_dwmac_mask_bits(dwmac, PRG_ETH0,
-					PRG_ETH0_INVERTED_RMII_CLK,
-					PRG_ETH0_INVERTED_RMII_CLK);
+		clrsetbits32(dwmac->regs + PRG_ETH0,
+			     PRG_ETH0_INVERTED_RMII_CLK,
+			     PRG_ETH0_INVERTED_RMII_CLK);
 
 		/* TX clock delay cannot be configured in RMII mode */
-		meson8b_dwmac_mask_bits(dwmac, PRG_ETH0, PRG_ETH0_TXDLY_MASK,
-					0);
+		clrsetbits32(dwmac->regs + PRG_ETH0, PRG_ETH0_TXDLY_MASK, 0);
 
 		break;
 
@@ -304,8 +290,8 @@ static int meson8b_init_prg_eth(struct meson8b_dwmac *dwmac)
 	}
 
 	/* enable TX_CLK and PHY_REF_CLK generator */
-	meson8b_dwmac_mask_bits(dwmac, PRG_ETH0, PRG_ETH0_TX_AND_PHY_REF_CLK,
-				PRG_ETH0_TX_AND_PHY_REF_CLK);
+	clrsetbits32(dwmac->regs + PRG_ETH0, PRG_ETH0_TX_AND_PHY_REF_CLK,
+		     PRG_ETH0_TX_AND_PHY_REF_CLK);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 0f660af01a4b..3c7f531feadf 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -27,6 +27,7 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regmap.h>
+#include <linux/setbits.h>
 #include <linux/stmmac.h>
 
 #include "stmmac.h"
@@ -342,50 +343,27 @@ static void sun8i_dwmac_disable_dma_irq(void __iomem *ioaddr, u32 chan)
 
 static void sun8i_dwmac_dma_start_tx(void __iomem *ioaddr, u32 chan)
 {
-	u32 v;
-
-	v = readl(ioaddr + EMAC_TX_CTL1);
-	v |= EMAC_TX_DMA_START;
-	v |= EMAC_TX_DMA_EN;
-	writel(v, ioaddr + EMAC_TX_CTL1);
+	setbits32(ioaddr + EMAC_TX_CTL1, EMAC_TX_DMA_START | EMAC_TX_DMA_EN);
 }
 
 static void sun8i_dwmac_enable_dma_transmission(void __iomem *ioaddr)
 {
-	u32 v;
-
-	v = readl(ioaddr + EMAC_TX_CTL1);
-	v |= EMAC_TX_DMA_START;
-	v |= EMAC_TX_DMA_EN;
-	writel(v, ioaddr + EMAC_TX_CTL1);
+	setbits32(ioaddr + EMAC_TX_CTL1, EMAC_TX_DMA_START | EMAC_TX_DMA_EN);
 }
 
 static void sun8i_dwmac_dma_stop_tx(void __iomem *ioaddr, u32 chan)
 {
-	u32 v;
-
-	v = readl(ioaddr + EMAC_TX_CTL1);
-	v &= ~EMAC_TX_DMA_EN;
-	writel(v, ioaddr + EMAC_TX_CTL1);
+	clrbits32(ioaddr + EMAC_TX_CTL1, EMAC_TX_DMA_EN);
 }
 
 static void sun8i_dwmac_dma_start_rx(void __iomem *ioaddr, u32 chan)
 {
-	u32 v;
-
-	v = readl(ioaddr + EMAC_RX_CTL1);
-	v |= EMAC_RX_DMA_START;
-	v |= EMAC_RX_DMA_EN;
-	writel(v, ioaddr + EMAC_RX_CTL1);
+	setbits32(ioaddr + EMAC_RX_CTL1, EMAC_RX_DMA_START | EMAC_RX_DMA_EN);
 }
 
 static void sun8i_dwmac_dma_stop_rx(void __iomem *ioaddr, u32 chan)
 {
-	u32 v;
-
-	v = readl(ioaddr + EMAC_RX_CTL1);
-	v &= ~EMAC_RX_DMA_EN;
-	writel(v, ioaddr + EMAC_RX_CTL1);
+	clrbits32(ioaddr + EMAC_RX_CTL1, EMAC_RX_DMA_EN);
 }
 
 static int sun8i_dwmac_dma_interrupt(void __iomem *ioaddr,
@@ -608,11 +586,8 @@ static void sun8i_dwmac_get_umac_addr(struct mac_device_info *hw,
 static int sun8i_dwmac_rx_ipc_enable(struct mac_device_info *hw)
 {
 	void __iomem *ioaddr = hw->pcsr;
-	u32 v;
 
-	v = readl(ioaddr + EMAC_RX_CTL0);
-	v |= EMAC_RX_DO_CRC;
-	writel(v, ioaddr + EMAC_RX_CTL0);
+	setbits32(ioaddr + EMAC_RX_CTL0, EMAC_RX_DO_CRC);
 
 	return 1;
 }
@@ -662,21 +637,16 @@ static void sun8i_dwmac_flow_ctrl(struct mac_device_info *hw,
 				  unsigned int pause_time, u32 tx_cnt)
 {
 	void __iomem *ioaddr = hw->pcsr;
-	u32 v;
 
-	v = readl(ioaddr + EMAC_RX_CTL0);
 	if (fc == FLOW_AUTO)
-		v |= EMAC_RX_FLOW_CTL_EN;
+		setbits32(ioaddr + EMAC_RX_CTL0, EMAC_RX_FLOW_CTL_EN);
 	else
-		v &= ~EMAC_RX_FLOW_CTL_EN;
-	writel(v, ioaddr + EMAC_RX_CTL0);
+		clrbits32(ioaddr + EMAC_RX_CTL0, EMAC_RX_FLOW_CTL_EN);
 
-	v = readl(ioaddr + EMAC_TX_FLOW_CTL);
 	if (fc == FLOW_AUTO)
-		v |= EMAC_TX_FLOW_CTL_EN;
+		setbits32(ioaddr + EMAC_TX_FLOW_CTL, EMAC_TX_FLOW_CTL_EN);
 	else
-		v &= ~EMAC_TX_FLOW_CTL_EN;
-	writel(v, ioaddr + EMAC_TX_FLOW_CTL);
+		clrbits32(ioaddr + EMAC_TX_FLOW_CTL, EMAC_TX_FLOW_CTL_EN);
 }
 
 static int sun8i_dwmac_reset(struct stmmac_priv *priv)
@@ -684,8 +654,7 @@ static int sun8i_dwmac_reset(struct stmmac_priv *priv)
 	u32 v;
 	int err;
 
-	v = readl(priv->ioaddr + EMAC_BASIC_CTL1);
-	writel(v | 0x01, priv->ioaddr + EMAC_BASIC_CTL1);
+	setbits32(priv->ioaddr + EMAC_BASIC_CTL1, 0x01);
 
 	/* The timeout was previoulsy set to 10ms, but some board (OrangePI0)
 	 * need more if no cable plugged. 100ms seems OK
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index 0877bde6e860..ca864c3d7ff3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -25,6 +25,7 @@
 #include <linux/crc32.h>
 #include <linux/slab.h>
 #include <linux/ethtool.h>
+#include <linux/setbits.h>
 #include <net/dsa.h>
 #include <asm/io.h>
 #include "stmmac.h"
@@ -355,7 +356,6 @@ static void dwmac1000_set_eee_mode(struct mac_device_info *hw,
 				   bool en_tx_lpi_clockgating)
 {
 	void __iomem *ioaddr = hw->pcsr;
-	u32 value;
 
 	/*TODO - en_tx_lpi_clockgating treatment */
 
@@ -363,19 +363,16 @@ static void dwmac1000_set_eee_mode(struct mac_device_info *hw,
 	 * receive path and instruct the transmit to enter in LPI
 	 * state.
 	 */
-	value = readl(ioaddr + LPI_CTRL_STATUS);
-	value |= LPI_CTRL_STATUS_LPIEN | LPI_CTRL_STATUS_LPITXA;
-	writel(value, ioaddr + LPI_CTRL_STATUS);
+	setbits32(ioaddr + LPI_CTRL_STATUS,
+		  LPI_CTRL_STATUS_LPIEN | LPI_CTRL_STATUS_LPITXA);
 }
 
 static void dwmac1000_reset_eee_mode(struct mac_device_info *hw)
 {
 	void __iomem *ioaddr = hw->pcsr;
-	u32 value;
 
-	value = readl(ioaddr + LPI_CTRL_STATUS);
-	value &= ~(LPI_CTRL_STATUS_LPIEN | LPI_CTRL_STATUS_LPITXA);
-	writel(value, ioaddr + LPI_CTRL_STATUS);
+	clrbits32(ioaddr + LPI_CTRL_STATUS,
+		  (LPI_CTRL_STATUS_LPIEN | LPI_CTRL_STATUS_LPITXA));
 }
 
 static void dwmac1000_set_eee_pls(struct mac_device_info *hw, int link)
@@ -383,14 +380,10 @@ static void dwmac1000_set_eee_pls(struct mac_device_info *hw, int link)
 	void __iomem *ioaddr = hw->pcsr;
 	u32 value;
 
-	value = readl(ioaddr + LPI_CTRL_STATUS);
-
 	if (link)
-		value |= LPI_CTRL_STATUS_PLS;
+		setbits32(ioaddr + LPI_CTRL_STATUS, LPI_CTRL_STATUS_PLS);
 	else
-		value &= ~LPI_CTRL_STATUS_PLS;
-
-	writel(value, ioaddr + LPI_CTRL_STATUS);
+		clrbits32(ioaddr + LPI_CTRL_STATUS, LPI_CTRL_STATUS_PLS);
 }
 
 static void dwmac1000_set_eee_timer(struct mac_device_info *hw, int ls, int tw)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 7e5d5db0d516..998695cbf3c2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -17,6 +17,8 @@
 #include <linux/slab.h>
 #include <linux/ethtool.h>
 #include <linux/io.h>
+#include <linux/setbits.h>
+#include <linux/setbits.h>
 #include <net/dsa.h>
 #include "stmmac.h"
 #include "stmmac_pcs.h"
@@ -85,16 +87,11 @@ static void dwmac4_rx_queue_priority(struct mac_device_info *hw,
 {
 	void __iomem *ioaddr = hw->pcsr;
 	u32 base_register;
-	u32 value;
 
 	base_register = (queue < 4) ? GMAC_RXQ_CTRL2 : GMAC_RXQ_CTRL3;
 
-	value = readl(ioaddr + base_register);
-
-	value &= ~GMAC_RXQCTRL_PSRQX_MASK(queue);
-	value |= (prio << GMAC_RXQCTRL_PSRQX_SHIFT(queue)) &
-						GMAC_RXQCTRL_PSRQX_MASK(queue);
-	writel(value, ioaddr + base_register);
+	clrsetbits32(ioaddr + base_register, GMAC_RXQCTRL_PSRQX_MASK(queue),
+		     (prio << GMAC_RXQCTRL_PSRQX_SHIFT(queue)) & GMAC_RXQCTRL_PSRQX_MASK(queue));
 }
 
 static void dwmac4_tx_queue_priority(struct mac_device_info *hw,
@@ -102,17 +99,11 @@ static void dwmac4_tx_queue_priority(struct mac_device_info *hw,
 {
 	void __iomem *ioaddr = hw->pcsr;
 	u32 base_register;
-	u32 value;
 
 	base_register = (queue < 4) ? GMAC_TXQ_PRTY_MAP0 : GMAC_TXQ_PRTY_MAP1;
 
-	value = readl(ioaddr + base_register);
-
-	value &= ~GMAC_TXQCTRL_PSTQX_MASK(queue);
-	value |= (prio << GMAC_TXQCTRL_PSTQX_SHIFT(queue)) &
-						GMAC_TXQCTRL_PSTQX_MASK(queue);
-
-	writel(value, ioaddr + base_register);
+	clrsetbits32(ioaddr + base_register, GMAC_TXQCTRL_PSTQX_MASK(queue),
+		     (prio << GMAC_TXQCTRL_PSTQX_SHIFT(queue)) & GMAC_TXQCTRL_PSTQX_MASK(queue));
 }
 
 static void dwmac4_rx_queue_routing(struct mac_device_info *hw,
@@ -198,11 +189,9 @@ static void dwmac4_set_mtl_tx_queue_weight(struct mac_device_info *hw,
 					   u32 weight, u32 queue)
 {
 	void __iomem *ioaddr = hw->pcsr;
-	u32 value = readl(ioaddr + MTL_TXQX_WEIGHT_BASE_ADDR(queue));
-
-	value &= ~MTL_TXQ_WEIGHT_ISCQW_MASK;
-	value |= weight & MTL_TXQ_WEIGHT_ISCQW_MASK;
-	writel(value, ioaddr + MTL_TXQX_WEIGHT_BASE_ADDR(queue));
+	clrsetbits32(ioaddr + MTL_TXQX_WEIGHT_BASE_ADDR(queue),
+		     MTL_TXQ_WEIGHT_ISCQW_MASK,
+		     weight & MTL_TXQ_WEIGHT_ISCQW_MASK);
 }
 
 static void dwmac4_map_mtl_dma(struct mac_device_info *hw, u32 queue, u32 chan)
@@ -243,10 +232,8 @@ static void dwmac4_config_cbs(struct mac_device_info *hw,
 	pr_debug("\tlow_credit: 0x%08x\n", low_credit);
 
 	/* enable AV algorithm */
-	value = readl(ioaddr + MTL_ETSX_CTRL_BASE_ADDR(queue));
-	value |= MTL_ETS_CTRL_AVALG;
-	value |= MTL_ETS_CTRL_CC;
-	writel(value, ioaddr + MTL_ETSX_CTRL_BASE_ADDR(queue));
+	setbits32(ioaddr + MTL_ETSX_CTRL_BASE_ADDR(queue),
+		  MTL_ETS_CTRL_AVALG | MTL_ETS_CTRL_CC);
 
 	/* configure send slope */
 	value = readl(ioaddr + MTL_SEND_SLP_CREDX_BASE_ADDR(queue));
@@ -360,11 +347,9 @@ static void dwmac4_set_eee_mode(struct mac_device_info *hw,
 static void dwmac4_reset_eee_mode(struct mac_device_info *hw)
 {
 	void __iomem *ioaddr = hw->pcsr;
-	u32 value;
 
-	value = readl(ioaddr + GMAC4_LPI_CTRL_STATUS);
-	value &= ~(GMAC4_LPI_CTRL_STATUS_LPIEN | GMAC4_LPI_CTRL_STATUS_LPITXA);
-	writel(value, ioaddr + GMAC4_LPI_CTRL_STATUS);
+	clrbits32(ioaddr + GMAC4_LPI_CTRL_STATUS,
+		  (GMAC4_LPI_CTRL_STATUS_LPIEN | GMAC4_LPI_CTRL_STATUS_LPITXA));
 }
 
 static void dwmac4_set_eee_pls(struct mac_device_info *hw, int link)
@@ -372,14 +357,12 @@ static void dwmac4_set_eee_pls(struct mac_device_info *hw, int link)
 	void __iomem *ioaddr = hw->pcsr;
 	u32 value;
 
-	value = readl(ioaddr + GMAC4_LPI_CTRL_STATUS);
-
 	if (link)
-		value |= GMAC4_LPI_CTRL_STATUS_PLS;
+		setbits32(ioaddr + GMAC4_LPI_CTRL_STATUS,
+			  GMAC4_LPI_CTRL_STATUS_PLS);
 	else
-		value &= ~GMAC4_LPI_CTRL_STATUS_PLS;
-
-	writel(value, ioaddr + GMAC4_LPI_CTRL_STATUS);
+		clrbits32(ioaddr + GMAC4_LPI_CTRL_STATUS,
+			  GMAC4_LPI_CTRL_STATUS_PLS);
 }
 
 static void dwmac4_set_eee_timer(struct mac_device_info *hw, int ls, int tw)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
index edb6053bd980..63c582ff24a1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/io.h>
+#include <linux/setbits.h>
 #include "dwmac4.h"
 #include "dwmac4_dma.h"
 
@@ -270,9 +271,7 @@ static void dwmac4_dma_rx_chan_op_mode(void __iomem *ioaddr, int mode,
 	writel(mtl_rx_op, ioaddr + MTL_CHAN_RX_OP_MODE(channel));
 
 	/* Enable MTL RX overflow */
-	mtl_rx_int = readl(ioaddr + MTL_CHAN_INT_CTRL(channel));
-	writel(mtl_rx_int | MTL_RX_OVERFLOW_INT_EN,
-	       ioaddr + MTL_CHAN_INT_CTRL(channel));
+	setbits32(ioaddr + MTL_CHAN_INT_CTRL(channel), MTL_RX_OVERFLOW_INT_EN);
 }
 
 static void dwmac4_dma_tx_chan_op_mode(void __iomem *ioaddr, int mode,
@@ -422,12 +421,8 @@ static void dwmac4_qmode(void __iomem *ioaddr, u32 channel, u8 qmode)
 
 static void dwmac4_set_bfsize(void __iomem *ioaddr, int bfsize, u32 chan)
 {
-	u32 value = readl(ioaddr + DMA_CHAN_RX_CONTROL(chan));
-
-	value &= ~DMA_RBSZ_MASK;
-	value |= (bfsize << DMA_RBSZ_SHIFT) & DMA_RBSZ_MASK;
-
-	writel(value, ioaddr + DMA_CHAN_RX_CONTROL(chan));
+	clrsetbits32(ioaddr + DMA_CHAN_RX_CONTROL(chan), DMA_RBSZ_MASK,
+		     (bfsize << DMA_RBSZ_SHIFT) & DMA_RBSZ_MASK);
 }
 
 const struct stmmac_dma_ops dwmac4_dma_ops = {
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
index 49f5687879df..5f699cf54e17 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
@@ -10,6 +10,7 @@
 
 #include <linux/io.h>
 #include <linux/delay.h>
+#include <linux/setbits.h>
 #include "common.h"
 #include "dwmac4_dma.h"
 #include "dwmac4.h"
@@ -47,51 +48,26 @@ void dwmac4_set_tx_tail_ptr(void __iomem *ioaddr, u32 tail_ptr, u32 chan)
 
 void dwmac4_dma_start_tx(void __iomem *ioaddr, u32 chan)
 {
-	u32 value = readl(ioaddr + DMA_CHAN_TX_CONTROL(chan));
-
-	value |= DMA_CONTROL_ST;
-	writel(value, ioaddr + DMA_CHAN_TX_CONTROL(chan));
-
-	value = readl(ioaddr + GMAC_CONFIG);
-	value |= GMAC_CONFIG_TE;
-	writel(value, ioaddr + GMAC_CONFIG);
+	setbits32(ioaddr + DMA_CHAN_TX_CONTROL(chan), DMA_CONTROL_ST);
+	setbits32(ioaddr + GMAC_CONFIG, GMAC_CONFIG_TE);
 }
 
 void dwmac4_dma_stop_tx(void __iomem *ioaddr, u32 chan)
 {
-	u32 value = readl(ioaddr + DMA_CHAN_TX_CONTROL(chan));
-
-	value &= ~DMA_CONTROL_ST;
-	writel(value, ioaddr + DMA_CHAN_TX_CONTROL(chan));
-
-	value = readl(ioaddr + GMAC_CONFIG);
-	value &= ~GMAC_CONFIG_TE;
-	writel(value, ioaddr + GMAC_CONFIG);
+	clrbits32(ioaddr + DMA_CHAN_TX_CONTROL(chan), DMA_CONTROL_ST);
+	clrbits32(ioaddr + GMAC_CONFIG, GMAC_CONFIG_TE);
 }
 
 void dwmac4_dma_start_rx(void __iomem *ioaddr, u32 chan)
 {
-	u32 value = readl(ioaddr + DMA_CHAN_RX_CONTROL(chan));
-
-	value |= DMA_CONTROL_SR;
-
-	writel(value, ioaddr + DMA_CHAN_RX_CONTROL(chan));
-
-	value = readl(ioaddr + GMAC_CONFIG);
-	value |= GMAC_CONFIG_RE;
-	writel(value, ioaddr + GMAC_CONFIG);
+	setbits32(ioaddr + DMA_CHAN_RX_CONTROL(chan), DMA_CONTROL_SR);
+	setbits32(ioaddr + GMAC_CONFIG, GMAC_CONFIG_RE);
 }
 
 void dwmac4_dma_stop_rx(void __iomem *ioaddr, u32 chan)
 {
-	u32 value = readl(ioaddr + DMA_CHAN_RX_CONTROL(chan));
-
-	value &= ~DMA_CONTROL_SR;
-	writel(value, ioaddr + DMA_CHAN_RX_CONTROL(chan));
-
-	value = readl(ioaddr + GMAC_CONFIG);
-	value &= ~GMAC_CONFIG_RE;
-	writel(value, ioaddr + GMAC_CONFIG);
+	clrbits32(ioaddr + DMA_CHAN_RX_CONTROL(chan), DMA_CONTROL_SR);
+	clrbits32(ioaddr + GMAC_CONFIG, GMAC_CONFIG_RE);
 }
 
 void dwmac4_set_tx_ring_len(void __iomem *ioaddr, u32 len, u32 chan)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
index 3f4f3132e16b..aec2fb884477 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
@@ -4,6 +4,7 @@
 
 #include <linux/bitops.h>
 #include <linux/iopoll.h>
+#include <linux/setbits.h>
 #include "common.h"
 #include "dwmac4.h"
 #include "dwmac5.h"
@@ -307,9 +308,7 @@ static int dwmac5_rxp_disable(void __iomem *ioaddr)
 	u32 val;
 	int ret;
 
-	val = readl(ioaddr + MTL_OPERATION_MODE);
-	val &= ~MTL_FRPE;
-	writel(val, ioaddr + MTL_OPERATION_MODE);
+	clrbits32(ioaddr + MTL_OPERATION_MODE, MTL_FRPE);
 
 	ret = readl_poll_timeout(ioaddr + MTL_RXP_CONTROL_STATUS, val,
 			val & RXPI, 1, 10000);
@@ -320,11 +319,7 @@ static int dwmac5_rxp_disable(void __iomem *ioaddr)
 
 static void dwmac5_rxp_enable(void __iomem *ioaddr)
 {
-	u32 val;
-
-	val = readl(ioaddr + MTL_OPERATION_MODE);
-	val |= MTL_FRPE;
-	writel(val, ioaddr + MTL_OPERATION_MODE);
+	setbits32(ioaddr + MTL_OPERATION_MODE, MTL_FRPE);
 }
 
 static int dwmac5_rxp_update_single_entry(void __iomem *ioaddr,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
index 7516ca210855..acecb9f0ee4b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
@@ -18,6 +18,7 @@
 
 #include <linux/io.h>
 #include <linux/iopoll.h>
+#include <linux/setbits.h>
 #include "common.h"
 #include "dwmac_dma.h"
 
@@ -59,30 +60,22 @@ void dwmac_disable_dma_irq(void __iomem *ioaddr, u32 chan)
 
 void dwmac_dma_start_tx(void __iomem *ioaddr, u32 chan)
 {
-	u32 value = readl(ioaddr + DMA_CONTROL);
-	value |= DMA_CONTROL_ST;
-	writel(value, ioaddr + DMA_CONTROL);
+	setbits32(ioaddr + DMA_CONTROL, DMA_CONTROL_ST);
 }
 
 void dwmac_dma_stop_tx(void __iomem *ioaddr, u32 chan)
 {
-	u32 value = readl(ioaddr + DMA_CONTROL);
-	value &= ~DMA_CONTROL_ST;
-	writel(value, ioaddr + DMA_CONTROL);
+	clrbits32(ioaddr + DMA_CONTROL, DMA_CONTROL_ST);
 }
 
 void dwmac_dma_start_rx(void __iomem *ioaddr, u32 chan)
 {
-	u32 value = readl(ioaddr + DMA_CONTROL);
-	value |= DMA_CONTROL_SR;
-	writel(value, ioaddr + DMA_CONTROL);
+	setbits32(ioaddr + DMA_CONTROL, DMA_CONTROL_SR);
 }
 
 void dwmac_dma_stop_rx(void __iomem *ioaddr, u32 chan)
 {
-	u32 value = readl(ioaddr + DMA_CONTROL);
-	value &= ~DMA_CONTROL_SR;
-	writel(value, ioaddr + DMA_CONTROL);
+	clrbits32(ioaddr + DMA_CONTROL, DMA_CONTROL_SR);
 }
 
 #ifdef DWMAC_DMA_DEBUG
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 64b8cb88ea45..fc7df8de2ba7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -4,6 +4,7 @@
  * stmmac XGMAC support.
  */
 
+#include <linux/setbits.h>
 #include "stmmac.h"
 #include "dwxgmac2.h"
 
@@ -75,12 +76,10 @@ static int dwxgmac2_rx_ipc(struct mac_device_info *hw)
 	void __iomem *ioaddr = hw->pcsr;
 	u32 value;
 
-	value = readl(ioaddr + XGMAC_RX_CONFIG);
 	if (hw->rx_csum)
-		value |= XGMAC_CONFIG_IPC;
+		setbits32(ioaddr + XGMAC_RX_CONFIG, XGMAC_CONFIG_IPC);
 	else
-		value &= ~XGMAC_CONFIG_IPC;
-	writel(value, ioaddr + XGMAC_RX_CONFIG);
+		clrbits32(ioaddr + XGMAC_RX_CONFIG, XGMAC_CONFIG_IPC);
 
 	return !!(readl(ioaddr + XGMAC_RX_CONFIG) & XGMAC_CONFIG_IPC);
 }
@@ -107,11 +106,8 @@ static void dwxgmac2_rx_queue_prio(struct mac_device_info *hw, u32 prio,
 
 	reg = (queue < 4) ? XGMAC_RXQ_CTRL2 : XGMAC_RXQ_CTRL3;
 
-	value = readl(ioaddr + reg);
-	value &= ~XGMAC_PSRQ(queue);
-	value |= (prio << XGMAC_PSRQ_SHIFT(queue)) & XGMAC_PSRQ(queue);
-
-	writel(value, ioaddr + reg);
+	clrsetbits32(ioaddr + reg, XGMAC_PSRQ(queue),
+		     (prio << XGMAC_PSRQ_SHIFT(queue)) & XGMAC_PSRQ(queue));
 }
 
 static void dwxgmac2_prog_mtl_rx_algorithms(struct mac_device_info *hw,
@@ -170,11 +166,8 @@ static void dwxgmac2_map_mtl_to_dma(struct mac_device_info *hw, u32 queue,
 
 	reg = (queue < 4) ? XGMAC_MTL_RXQ_DMA_MAP0 : XGMAC_MTL_RXQ_DMA_MAP1;
 
-	value = readl(ioaddr + reg);
-	value &= ~XGMAC_QxMDMACH(queue);
-	value |= (chan << XGMAC_QxMDMACH_SHIFT(queue)) & XGMAC_QxMDMACH(queue);
-
-	writel(value, ioaddr + reg);
+	clrsetbits32(ioaddr + reg, XGMAC_QxMDMACH(queue),
+		     (chan << XGMAC_QxMDMACH_SHIFT(queue)) & XGMAC_QxMDMACH(queue));
 }
 
 static void dwxgmac2_config_cbs(struct mac_device_info *hw,
@@ -189,9 +182,8 @@ static void dwxgmac2_config_cbs(struct mac_device_info *hw,
 	writel(high_credit, ioaddr + XGMAC_MTL_TCx_HICREDIT(queue));
 	writel(low_credit, ioaddr + XGMAC_MTL_TCx_LOCREDIT(queue));
 
-	value = readl(ioaddr + XGMAC_MTL_TCx_ETS_CONTROL(queue));
-	value |= XGMAC_CC | XGMAC_CBS;
-	writel(value, ioaddr + XGMAC_MTL_TCx_ETS_CONTROL(queue));
+	setbits32(ioaddr + XGMAC_MTL_TCx_ETS_CONTROL(queue),
+		  XGMAC_CC | XGMAC_CBS);
 }
 
 static int dwxgmac2_host_irq_status(struct mac_device_info *hw,
@@ -263,9 +255,7 @@ static void dwxgmac2_pmt(struct mac_device_info *hw, unsigned long mode)
 	if (mode & WAKE_UCAST)
 		val |= XGMAC_PWRDWN | XGMAC_GLBLUCAST | XGMAC_RWKPKTEN;
 	if (val) {
-		u32 cfg = readl(ioaddr + XGMAC_RX_CONFIG);
-		cfg |= XGMAC_CONFIG_RE;
-		writel(cfg, ioaddr + XGMAC_RX_CONFIG);
+		setbits32(ioaddr + XGMAC_RX_CONFIG, XGMAC_CONFIG_RE);
 	}
 
 	writel(val, ioaddr + XGMAC_PMT);
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index 6c5092e7771c..7a7d584211e9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/iopoll.h>
+#include <linux/setbits.h>
 #include "stmmac.h"
 #include "dwxgmac2.h"
 
@@ -47,12 +48,9 @@ static void dwxgmac2_dma_init_rx_chan(void __iomem *ioaddr,
 				      u32 dma_rx_phy, u32 chan)
 {
 	u32 rxpbl = dma_cfg->rxpbl ?: dma_cfg->pbl;
-	u32 value;
 
-	value = readl(ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
-	value &= ~XGMAC_RxPBL;
-	value |= (rxpbl << XGMAC_RxPBL_SHIFT) & XGMAC_RxPBL;
-	writel(value, ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
+	clrsetbits32(ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan), XGMAC_RxPBL,
+		     (rxpbl << XGMAC_RxPBL_SHIFT) & XGMAC_RxPBL);
 
 	writel(dma_rx_phy, ioaddr + XGMAC_DMA_CH_RxDESC_LADDR(chan));
 }
@@ -150,8 +148,7 @@ static void dwxgmac2_dma_rx_mode(void __iomem *ioaddr, int mode,
 	writel(value, ioaddr + XGMAC_MTL_RXQ_OPMODE(channel));
 
 	/* Enable MTL RX overflow */
-	value = readl(ioaddr + XGMAC_MTL_QINTEN(channel));
-	writel(value | XGMAC_RXOIE, ioaddr + XGMAC_MTL_QINTEN(channel));
+	setbits32(ioaddr + XGMAC_MTL_QINTEN(channel), XGMAC_RXOIE);
 }
 
 static void dwxgmac2_dma_tx_mode(void __iomem *ioaddr, int mode,
@@ -209,54 +206,26 @@ static void dwxgmac2_disable_dma_irq(void __iomem *ioaddr, u32 chan)
 
 static void dwxgmac2_dma_start_tx(void __iomem *ioaddr, u32 chan)
 {
-	u32 value;
-
-	value = readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
-	value |= XGMAC_TXST;
-	writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
-
-	value = readl(ioaddr + XGMAC_TX_CONFIG);
-	value |= XGMAC_CONFIG_TE;
-	writel(value, ioaddr + XGMAC_TX_CONFIG);
+	setbits32(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan), XGMAC_TXST);
+	setbits32(ioaddr + XGMAC_TX_CONFIG, XGMAC_CONFIG_TE);
 }
 
 static void dwxgmac2_dma_stop_tx(void __iomem *ioaddr, u32 chan)
 {
-	u32 value;
-
-	value = readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
-	value &= ~XGMAC_TXST;
-	writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
-
-	value = readl(ioaddr + XGMAC_TX_CONFIG);
-	value &= ~XGMAC_CONFIG_TE;
-	writel(value, ioaddr + XGMAC_TX_CONFIG);
+	clrbits32(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan), XGMAC_TXST);
+	clrbits32(ioaddr + XGMAC_TX_CONFIG, XGMAC_CONFIG_TE);
 }
 
 static void dwxgmac2_dma_start_rx(void __iomem *ioaddr, u32 chan)
 {
-	u32 value;
-
-	value = readl(ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
-	value |= XGMAC_RXST;
-	writel(value, ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
-
-	value = readl(ioaddr + XGMAC_RX_CONFIG);
-	value |= XGMAC_CONFIG_RE;
-	writel(value, ioaddr + XGMAC_RX_CONFIG);
+	setbits32(ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan), XGMAC_RXST);
+	setbits32(ioaddr + XGMAC_RX_CONFIG, XGMAC_CONFIG_RE);
 }
 
 static void dwxgmac2_dma_stop_rx(void __iomem *ioaddr, u32 chan)
 {
-	u32 value;
-
-	value = readl(ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
-	value &= ~XGMAC_RXST;
-	writel(value, ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
-
-	value = readl(ioaddr + XGMAC_RX_CONFIG);
-	value &= ~XGMAC_CONFIG_RE;
-	writel(value, ioaddr + XGMAC_RX_CONFIG);
+	clrbits32(ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan), XGMAC_RXST);
+	clrbits32(ioaddr + XGMAC_RX_CONFIG, XGMAC_CONFIG_RE);
 }
 
 static int dwxgmac2_dma_interrupt(void __iomem *ioaddr,
@@ -367,14 +336,10 @@ static void dwxgmac2_set_tx_tail_ptr(void __iomem *ioaddr, u32 ptr, u32 chan)
 
 static void dwxgmac2_enable_tso(void __iomem *ioaddr, bool en, u32 chan)
 {
-	u32 value = readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
-
 	if (en)
-		value |= XGMAC_TSE;
+		setbits32(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan), XGMAC_TSE);
 	else
-		value &= ~XGMAC_TSE;
-
-	writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
+		clrbits32(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan), XGMAC_TSE);
 }
 
 static void dwxgmac2_qmode(void __iomem *ioaddr, u32 channel, u8 qmode)
@@ -394,11 +359,7 @@ static void dwxgmac2_qmode(void __iomem *ioaddr, u32 channel, u8 qmode)
 
 static void dwxgmac2_set_bfsize(void __iomem *ioaddr, int bfsize, u32 chan)
 {
-	u32 value;
-
-	value = readl(ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
-	value |= bfsize << 1;
-	writel(value, ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
+	setbits32(ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan), bfsize << 1);
 }
 
 const struct stmmac_dma_ops dwxgmac210_dma_ops = {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
index 8d9cc2157afd..8680fb4b1fa8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -21,6 +21,7 @@
 
 #include <linux/io.h>
 #include <linux/delay.h>
+#include <linux/setbits.h>
 #include "common.h"
 #include "stmmac_ptp.h"
 
@@ -64,14 +65,11 @@ static void config_sub_second_increment(void __iomem *ioaddr,
 static int init_systime(void __iomem *ioaddr, u32 sec, u32 nsec)
 {
 	int limit;
-	u32 value;
 
 	writel(sec, ioaddr + PTP_STSUR);
 	writel(nsec, ioaddr + PTP_STNSUR);
 	/* issue command to initialize the system time value */
-	value = readl(ioaddr + PTP_TCR);
-	value |= PTP_TCR_TSINIT;
-	writel(value, ioaddr + PTP_TCR);
+	setbits32(ioaddr + PTP_TCR, PTP_TCR_TSINIT);
 
 	/* wait for present system time initialize to complete */
 	limit = 10;
@@ -88,14 +86,11 @@ static int init_systime(void __iomem *ioaddr, u32 sec, u32 nsec)
 
 static int config_addend(void __iomem *ioaddr, u32 addend)
 {
-	u32 value;
 	int limit;
 
 	writel(addend, ioaddr + PTP_TAR);
 	/* issue command to update the addend value */
-	value = readl(ioaddr + PTP_TCR);
-	value |= PTP_TCR_TSADDREG;
-	writel(value, ioaddr + PTP_TCR);
+	setbits32(ioaddr + PTP_TCR, PTP_TCR_TSADDREG);
 
 	/* wait for present addend update to complete */
 	limit = 10;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index b72ef171477e..b9cdf951eda6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -27,6 +27,7 @@
 #include <linux/of_gpio.h>
 #include <linux/of_mdio.h>
 #include <linux/phy.h>
+#include <linux/setbits.h>
 #include <linux/slab.h>
 
 #include "dwxgmac2.h"
@@ -64,10 +65,8 @@ static int stmmac_xgmac2_c22_format(struct stmmac_priv *priv, int phyaddr,
 		return -EBUSY;
 
 	/* Set port as Clause 22 */
-	tmp = readl(priv->ioaddr + XGMAC_MDIO_C22P);
-	tmp &= ~MII_XGMAC_C22P_MASK;
-	tmp |= BIT(phyaddr);
-	writel(tmp, priv->ioaddr + XGMAC_MDIO_C22P);
+	clrsetbits32(priv->ioaddr + XGMAC_MDIO_C22P, MII_XGMAC_C22P_MASK,
+		     BIT(phyaddr));
 
 	*hw_addr = (phyaddr << 16) | (phyreg & 0x1f);
 	return 0;
-- 
2.16.4
