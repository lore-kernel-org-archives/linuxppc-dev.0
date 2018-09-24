Return-Path: <clabbe@baylibre.com>
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Jtt94F0RzF3Hl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 05:04:33 +1000 (AEST)
Received: by mail-wr1-x444.google.com with SMTP id u12-v6so20768096wrr.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2018 12:04:33 -0700 (PDT)
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
Subject: [PATCH v2 4/7] ata: ahci_sunxi: use xxxsetbits32 functions
Date: Mon, 24 Sep 2018 19:04:13 +0000
Message-Id: <1537815856-31728-5-git-send-email-clabbe@baylibre.com>
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

This patch converts ahci_sunxi to use xxxsetbits32 functions

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/ata/ahci_sunxi.c | 51 ++++++++++++------------------------------------
 1 file changed, 12 insertions(+), 39 deletions(-)

diff --git a/drivers/ata/ahci_sunxi.c b/drivers/ata/ahci_sunxi.c
index 911710643305..5b285a6dff60 100644
--- a/drivers/ata/ahci_sunxi.c
+++ b/drivers/ata/ahci_sunxi.c
@@ -25,6 +25,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
+#include <linux/setbits.h>
 #include "ahci.h"
 
 #define DRV_NAME "ahci-sunxi"
@@ -58,34 +59,6 @@ MODULE_PARM_DESC(enable_pmp,
 #define AHCI_P0PHYCR	0x0178
 #define AHCI_P0PHYSR	0x017c
 
-static void sunxi_clrbits(void __iomem *reg, u32 clr_val)
-{
-	u32 reg_val;
-
-	reg_val = readl(reg);
-	reg_val &= ~(clr_val);
-	writel(reg_val, reg);
-}
-
-static void sunxi_setbits(void __iomem *reg, u32 set_val)
-{
-	u32 reg_val;
-
-	reg_val = readl(reg);
-	reg_val |= set_val;
-	writel(reg_val, reg);
-}
-
-static void sunxi_clrsetbits(void __iomem *reg, u32 clr_val, u32 set_val)
-{
-	u32 reg_val;
-
-	reg_val = readl(reg);
-	reg_val &= ~(clr_val);
-	reg_val |= set_val;
-	writel(reg_val, reg);
-}
-
 static u32 sunxi_getbits(void __iomem *reg, u8 mask, u8 shift)
 {
 	return (readl(reg) >> shift) & mask;
@@ -100,22 +73,22 @@ static int ahci_sunxi_phy_init(struct device *dev, void __iomem *reg_base)
 	writel(0, reg_base + AHCI_RWCR);
 	msleep(5);
 
-	sunxi_setbits(reg_base + AHCI_PHYCS1R, BIT(19));
-	sunxi_clrsetbits(reg_base + AHCI_PHYCS0R,
+	setbits_le32(reg_base + AHCI_PHYCS1R, BIT(19));
+	clrsetbits_le32(reg_base + AHCI_PHYCS0R,
 			 (0x7 << 24),
 			 (0x5 << 24) | BIT(23) | BIT(18));
-	sunxi_clrsetbits(reg_base + AHCI_PHYCS1R,
+	clrsetbits_le32(reg_base + AHCI_PHYCS1R,
 			 (0x3 << 16) | (0x1f << 8) | (0x3 << 6),
 			 (0x2 << 16) | (0x6 << 8) | (0x2 << 6));
-	sunxi_setbits(reg_base + AHCI_PHYCS1R, BIT(28) | BIT(15));
-	sunxi_clrbits(reg_base + AHCI_PHYCS1R, BIT(19));
-	sunxi_clrsetbits(reg_base + AHCI_PHYCS0R,
+	setbits_le32(reg_base + AHCI_PHYCS1R, BIT(28) | BIT(15));
+	clrbits_le32(reg_base + AHCI_PHYCS1R, BIT(19));
+	clrsetbits_le32(reg_base + AHCI_PHYCS0R,
 			 (0x7 << 20), (0x3 << 20));
-	sunxi_clrsetbits(reg_base + AHCI_PHYCS2R,
+	clrsetbits_le32(reg_base + AHCI_PHYCS2R,
 			 (0x1f << 5), (0x19 << 5));
 	msleep(5);
 
-	sunxi_setbits(reg_base + AHCI_PHYCS0R, (0x1 << 19));
+	setbits_le32(reg_base + AHCI_PHYCS0R, (0x1 << 19));
 
 	timeout = 250; /* Power up takes aprox 50 us */
 	do {
@@ -130,7 +103,7 @@ static int ahci_sunxi_phy_init(struct device *dev, void __iomem *reg_base)
 		udelay(1);
 	} while (1);
 
-	sunxi_setbits(reg_base + AHCI_PHYCS2R, (0x1 << 24));
+	setbits_le32(reg_base + AHCI_PHYCS2R, (0x1 << 24));
 
 	timeout = 100; /* Calibration takes aprox 10 us */
 	do {
@@ -158,10 +131,10 @@ static void ahci_sunxi_start_engine(struct ata_port *ap)
 	struct ahci_host_priv *hpriv = ap->host->private_data;
 
 	/* Setup DMA before DMA start */
-	sunxi_clrsetbits(hpriv->mmio + AHCI_P0DMACR, 0x0000ff00, 0x00004400);
+	clrsetbits_le32(hpriv->mmio + AHCI_P0DMACR, 0x0000ff00, 0x00004400);
 
 	/* Start DMA */
-	sunxi_setbits(port_mmio + PORT_CMD, PORT_CMD_START);
+	setbits_le32(port_mmio + PORT_CMD, PORT_CMD_START);
 }
 
 static const struct ata_port_info ahci_sunxi_port_info = {
-- 
2.16.4
