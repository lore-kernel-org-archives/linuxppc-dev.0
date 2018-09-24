Return-Path: <clabbe@baylibre.com>
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42JttD4XDSzF3Hk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 05:04:36 +1000 (AEST)
Received: by mail-wr1-x444.google.com with SMTP id z3-v6so8957299wrr.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2018 12:04:36 -0700 (PDT)
From: Corentin Labbe <clabbe@baylibre.com>
To: Gilles.Muller@lip6.fr, Julia.Lawall@lip6.fr, agust@denx.de,
 airlied@linux.ie, alexandre.torgue@st.com, alistair@popple.id.au,
 benh@kernel.crashing.org, carlo@caione.org, davem@davemloft.net,
 galak@kernel.crashing.org, joabreu@synopsys.com, khilman@baylibre.com,
 maxime.ripard@bootlin.com, michal.lkml@markovi.net, mpe@ellerman.id.au,
 mporter@kernel.crashing.org, narmstrong@baylibre.com,
 nicolas.palix@imag.fr, oss@buserror.net, paulus@samba.org,
 peppe.cavallaro@st.com, tj@kernel.org, vitb@kernel.crashing.org,
 wens@csie.org
Cc: cocci@systeme.lip6.fr, dri-devel@lists.freedesktop.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
 Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 7/7] net: stmmac: dwmac-meson8b: use xxxsetbits32
Date: Mon, 24 Sep 2018 19:04:16 +0000
Message-Id: <1537815856-31728-8-git-send-email-clabbe@baylibre.com>
In-Reply-To: <1537815856-31728-1-git-send-email-clabbe@baylibre.com>
References: <1537815856-31728-1-git-send-email-clabbe@baylibre.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch convert meson stmmac glue driver to use all xxxsetbits32 functions.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-meson8b.c    | 56 +++++++++-------------
 1 file changed, 22 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
index c5979569fd60..abcf65588576 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
@@ -23,6 +23,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/platform_device.h>
 #include <linux/stmmac.h>
+#include <linux/setbits.h>
 
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
@@ -192,14 +181,13 @@ static int meson8b_set_phy_mode(struct meson8b_dwmac *dwmac)
 	case PHY_INTERFACE_MODE_RGMII_ID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		/* enable RGMII mode */
-		meson8b_dwmac_mask_bits(dwmac, PRG_ETH0,
-					PRG_ETH0_RGMII_MODE,
-					PRG_ETH0_RGMII_MODE);
+		clrsetbits_le32(dwmac->regs + PRG_ETH0, PRG_ETH0_RGMII_MODE,
+				PRG_ETH0_RGMII_MODE);
 		break;
 	case PHY_INTERFACE_MODE_RMII:
 		/* disable RGMII mode -> enables RMII mode */
-		meson8b_dwmac_mask_bits(dwmac, PRG_ETH0,
-					PRG_ETH0_RGMII_MODE, 0);
+		clrsetbits_le32(dwmac->regs + PRG_ETH0, PRG_ETH0_RGMII_MODE,
+				0);
 		break;
 	default:
 		dev_err(dwmac->dev, "fail to set phy-mode %s\n",
@@ -218,15 +206,15 @@ static int meson_axg_set_phy_mode(struct meson8b_dwmac *dwmac)
 	case PHY_INTERFACE_MODE_RGMII_ID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		/* enable RGMII mode */
-		meson8b_dwmac_mask_bits(dwmac, PRG_ETH0,
-					PRG_ETH0_EXT_PHY_MODE_MASK,
-					PRG_ETH0_EXT_RGMII_MODE);
+		clrsetbits_le32(dwmac->regs + PRG_ETH0,
+				PRG_ETH0_EXT_PHY_MODE_MASK,
+				PRG_ETH0_EXT_RGMII_MODE);
 		break;
 	case PHY_INTERFACE_MODE_RMII:
 		/* disable RGMII mode -> enables RMII mode */
-		meson8b_dwmac_mask_bits(dwmac, PRG_ETH0,
-					PRG_ETH0_EXT_PHY_MODE_MASK,
-					PRG_ETH0_EXT_RMII_MODE);
+		clrsetbits_le32(dwmac->regs + PRG_ETH0,
+				PRG_ETH0_EXT_PHY_MODE_MASK,
+				PRG_ETH0_EXT_RMII_MODE);
 		break;
 	default:
 		dev_err(dwmac->dev, "fail to set phy-mode %s\n",
@@ -255,11 +243,11 @@ static int meson8b_init_prg_eth(struct meson8b_dwmac *dwmac)
 	case PHY_INTERFACE_MODE_RGMII_ID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		/* only relevant for RMII mode -> disable in RGMII mode */
-		meson8b_dwmac_mask_bits(dwmac, PRG_ETH0,
-					PRG_ETH0_INVERTED_RMII_CLK, 0);
+		clrsetbits_le32(dwmac->regs + PRG_ETH0,
+				PRG_ETH0_INVERTED_RMII_CLK, 0);
 
-		meson8b_dwmac_mask_bits(dwmac, PRG_ETH0, PRG_ETH0_TXDLY_MASK,
-					tx_dly_val << PRG_ETH0_TXDLY_SHIFT);
+		clrsetbits_le32(dwmac->regs + PRG_ETH0, PRG_ETH0_TXDLY_MASK,
+				tx_dly_val << PRG_ETH0_TXDLY_SHIFT);
 
 		/* Configure the 125MHz RGMII TX clock, the IP block changes
 		 * the output automatically (= without us having to configure
@@ -287,13 +275,13 @@ static int meson8b_init_prg_eth(struct meson8b_dwmac *dwmac)
 
 	case PHY_INTERFACE_MODE_RMII:
 		/* invert internal clk_rmii_i to generate 25/2.5 tx_rx_clk */
-		meson8b_dwmac_mask_bits(dwmac, PRG_ETH0,
-					PRG_ETH0_INVERTED_RMII_CLK,
-					PRG_ETH0_INVERTED_RMII_CLK);
+		clrsetbits_le32(dwmac->regs + PRG_ETH0,
+				PRG_ETH0_INVERTED_RMII_CLK,
+				PRG_ETH0_INVERTED_RMII_CLK);
 
 		/* TX clock delay cannot be configured in RMII mode */
-		meson8b_dwmac_mask_bits(dwmac, PRG_ETH0, PRG_ETH0_TXDLY_MASK,
-					0);
+		clrsetbits_le32(dwmac->regs + PRG_ETH0, PRG_ETH0_TXDLY_MASK,
+				0);
 
 		break;
 
@@ -304,8 +292,8 @@ static int meson8b_init_prg_eth(struct meson8b_dwmac *dwmac)
 	}
 
 	/* enable TX_CLK and PHY_REF_CLK generator */
-	meson8b_dwmac_mask_bits(dwmac, PRG_ETH0, PRG_ETH0_TX_AND_PHY_REF_CLK,
-				PRG_ETH0_TX_AND_PHY_REF_CLK);
+	clrsetbits_le32(dwmac->regs + PRG_ETH0, PRG_ETH0_TX_AND_PHY_REF_CLK,
+			PRG_ETH0_TX_AND_PHY_REF_CLK);
 
 	return 0;
 }
-- 
2.16.4
