Return-Path: <clabbe@baylibre.com>
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42JttC3LkYzF3HZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 05:04:35 +1000 (AEST)
Received: by mail-wm1-x342.google.com with SMTP id j25-v6so10695585wmc.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2018 12:04:35 -0700 (PDT)
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
Subject: [PATCH v2 5/7] net: ethernet: stmmac: dwmac-sun8i: use xxxsetbits32
Date: Mon, 24 Sep 2018 19:04:14 +0000
Message-Id: <1537815856-31728-6-git-send-email-clabbe@baylibre.com>
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

This patch convert dwmac-sun8i driver to use all xxxsetbits32 functions.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 62 ++++++-----------------
 1 file changed, 16 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index f9a61f90cfbc..74067a59af50 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -28,6 +28,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/regmap.h>
 #include <linux/stmmac.h>
+#include <linux/setbits.h>
 
 #include "stmmac.h"
 #include "stmmac_platform.h"
@@ -342,50 +343,30 @@ static void sun8i_dwmac_disable_dma_irq(void __iomem *ioaddr, u32 chan)
 
 static void sun8i_dwmac_dma_start_tx(void __iomem *ioaddr, u32 chan)
 {
-	u32 v;
-
-	v = readl(ioaddr + EMAC_TX_CTL1);
-	v |= EMAC_TX_DMA_START;
-	v |= EMAC_TX_DMA_EN;
-	writel(v, ioaddr + EMAC_TX_CTL1);
+	setbits_le32(ioaddr + EMAC_TX_CTL1,
+		     EMAC_TX_DMA_START | EMAC_TX_DMA_EN);
 }
 
 static void sun8i_dwmac_enable_dma_transmission(void __iomem *ioaddr)
 {
-	u32 v;
-
-	v = readl(ioaddr + EMAC_TX_CTL1);
-	v |= EMAC_TX_DMA_START;
-	v |= EMAC_TX_DMA_EN;
-	writel(v, ioaddr + EMAC_TX_CTL1);
+	setbits_le32(ioaddr + EMAC_TX_CTL1,
+		     EMAC_TX_DMA_START | EMAC_TX_DMA_EN);
 }
 
 static void sun8i_dwmac_dma_stop_tx(void __iomem *ioaddr, u32 chan)
 {
-	u32 v;
-
-	v = readl(ioaddr + EMAC_TX_CTL1);
-	v &= ~EMAC_TX_DMA_EN;
-	writel(v, ioaddr + EMAC_TX_CTL1);
+	clrbits_le32(ioaddr + EMAC_TX_CTL1, EMAC_TX_DMA_EN);
 }
 
 static void sun8i_dwmac_dma_start_rx(void __iomem *ioaddr, u32 chan)
 {
-	u32 v;
-
-	v = readl(ioaddr + EMAC_RX_CTL1);
-	v |= EMAC_RX_DMA_START;
-	v |= EMAC_RX_DMA_EN;
-	writel(v, ioaddr + EMAC_RX_CTL1);
+	setbits_le32(ioaddr + EMAC_RX_CTL1,
+		     EMAC_RX_DMA_START | EMAC_RX_DMA_EN);
 }
 
 static void sun8i_dwmac_dma_stop_rx(void __iomem *ioaddr, u32 chan)
 {
-	u32 v;
-
-	v = readl(ioaddr + EMAC_RX_CTL1);
-	v &= ~EMAC_RX_DMA_EN;
-	writel(v, ioaddr + EMAC_RX_CTL1);
+	clrbits_le32(ioaddr + EMAC_RX_CTL1, EMAC_RX_DMA_EN);
 }
 
 static int sun8i_dwmac_dma_interrupt(void __iomem *ioaddr,
@@ -578,7 +559,6 @@ static void sun8i_dwmac_set_umac_addr(struct mac_device_info *hw,
 				      unsigned int reg_n)
 {
 	void __iomem *ioaddr = hw->pcsr;
-	u32 v;
 
 	if (!addr) {
 		writel(0, ioaddr + EMAC_MACADDR_HI(reg_n));
@@ -588,9 +568,8 @@ static void sun8i_dwmac_set_umac_addr(struct mac_device_info *hw,
 	stmmac_set_mac_addr(ioaddr, addr, EMAC_MACADDR_HI(reg_n),
 			    EMAC_MACADDR_LO(reg_n));
 	if (reg_n > 0) {
-		v = readl(ioaddr + EMAC_MACADDR_HI(reg_n));
-		v |= MAC_ADDR_TYPE_DST;
-		writel(v, ioaddr + EMAC_MACADDR_HI(reg_n));
+		setbits_le32(ioaddr + EMAC_MACADDR_HI(reg_n),
+			     MAC_ADDR_TYPE_DST);
 	}
 }
 
@@ -608,11 +587,8 @@ static void sun8i_dwmac_get_umac_addr(struct mac_device_info *hw,
 static int sun8i_dwmac_rx_ipc_enable(struct mac_device_info *hw)
 {
 	void __iomem *ioaddr = hw->pcsr;
-	u32 v;
 
-	v = readl(ioaddr + EMAC_RX_CTL0);
-	v |= EMAC_RX_DO_CRC;
-	writel(v, ioaddr + EMAC_RX_CTL0);
+	setbits_le32(ioaddr + EMAC_RX_CTL0, EMAC_RX_DO_CRC);
 
 	return 1;
 }
@@ -662,21 +638,15 @@ static void sun8i_dwmac_flow_ctrl(struct mac_device_info *hw,
 				  unsigned int pause_time, u32 tx_cnt)
 {
 	void __iomem *ioaddr = hw->pcsr;
-	u32 v;
 
-	v = readl(ioaddr + EMAC_RX_CTL0);
 	if (fc == FLOW_AUTO)
-		v |= EMAC_RX_FLOW_CTL_EN;
+		setbits_le32(ioaddr + EMAC_RX_CTL0, EMAC_RX_FLOW_CTL_EN);
 	else
-		v &= ~EMAC_RX_FLOW_CTL_EN;
-	writel(v, ioaddr + EMAC_RX_CTL0);
-
-	v = readl(ioaddr + EMAC_TX_FLOW_CTL);
+		clrbits_le32(ioaddr + EMAC_RX_CTL0, EMAC_RX_FLOW_CTL_EN);
 	if (fc == FLOW_AUTO)
-		v |= EMAC_TX_FLOW_CTL_EN;
+		setbits_le32(ioaddr + EMAC_TX_FLOW_CTL, EMAC_TX_FLOW_CTL_EN);
 	else
-		v &= ~EMAC_TX_FLOW_CTL_EN;
-	writel(v, ioaddr + EMAC_TX_FLOW_CTL);
+		clrbits_le32(ioaddr + EMAC_TX_FLOW_CTL, EMAC_TX_FLOW_CTL_EN);
 }
 
 static int sun8i_dwmac_reset(struct stmmac_priv *priv)
-- 
2.16.4
