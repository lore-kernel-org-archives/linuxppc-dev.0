Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yxt1P711qzDsFq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Dec 2017 10:19:05 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id b18so2112259pgv.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 15:19:05 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, fabio.estevam@nxp.com, timur@tabi.org,
 mail@maciej.szmigiero.name, caleb@crome.org, lgirdwood@gmail.com,
 arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
Subject: [PATCH v3 09/11] ASoC: fsl_ssi: Replace fsl_ssi_rxtx_reg_val with
 fsl_ssi_regvals
Date: Wed, 13 Dec 2017 15:18:26 -0800
Message-Id: <1513207108-30430-10-git-send-email-nicoleotsuka@gmail.com>
In-Reply-To: <1513207108-30430-1-git-send-email-nicoleotsuka@gmail.com>
References: <1513207108-30430-1-git-send-email-nicoleotsuka@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The name fsl_ssi_rxtx_reg_val is too long to read comfortably.
So this patch shortens it by using an array (fsl_ssi_regvals,
renamed from fsl_ssi_reg_val). To do that, it also introduces
two macros (TX and RX) to replace the wrapper structure. This
will also help further cleanups.

Meanwhile, it unifies all local variable with the name "vals"
to get rid of the name "reg" -- could be confusing with "regs"
in the private struct for regmap.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 sound/soc/fsl/fsl_ssi.c | 79 +++++++++++++++++++++++--------------------------
 sound/soc/fsl/fsl_ssi.h |  3 ++
 2 files changed, 40 insertions(+), 42 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 08258c4..1cdc62a 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -106,18 +106,13 @@ enum fsl_ssi_type {
 	FSL_SSI_MX51,
 };
 
-struct fsl_ssi_reg_val {
+struct fsl_ssi_regvals {
 	u32 sier;
 	u32 srcr;
 	u32 stcr;
 	u32 scr;
 };
 
-struct fsl_ssi_rxtx_reg_val {
-	struct fsl_ssi_reg_val rx;
-	struct fsl_ssi_reg_val tx;
-};
-
 static bool fsl_ssi_readable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -213,7 +208,7 @@ struct fsl_ssi_soc_data {
  * @fifo_depth: Depth of the SSI FIFOs
  * @slot_width: Width of each DAI slot
  * @slots: Number of slots
- * @rxtx_reg_val: Specific RX/TX register settings
+ * @regvals: Specific RX/TX register settings
  *
  * @clk: Clock source to access register
  * @baudclk: Clock source to generate bit and frame-sync clocks
@@ -257,7 +252,7 @@ struct fsl_ssi {
 	unsigned int fifo_depth;
 	unsigned int slot_width;
 	unsigned int slots;
-	struct fsl_ssi_rxtx_reg_val rxtx_reg_val;
+	struct fsl_ssi_regvals regvals[2];
 
 	struct clk *clk;
 	struct clk *baudclk;
@@ -383,25 +378,25 @@ static irqreturn_t fsl_ssi_isr(int irq, void *dev_id)
 static void fsl_ssi_rxtx_config(struct fsl_ssi *ssi, bool enable)
 {
 	struct regmap *regs = ssi->regs;
-	struct fsl_ssi_rxtx_reg_val *vals = &ssi->rxtx_reg_val;
+	struct fsl_ssi_regvals *vals = ssi->regvals;
 
 	if (enable) {
 		regmap_update_bits(regs, REG_SSI_SIER,
-				   vals->rx.sier | vals->tx.sier,
-				   vals->rx.sier | vals->tx.sier);
+				   vals[RX].sier | vals[TX].sier,
+				   vals[RX].sier | vals[TX].sier);
 		regmap_update_bits(regs, REG_SSI_SRCR,
-				   vals->rx.srcr | vals->tx.srcr,
-				   vals->rx.srcr | vals->tx.srcr);
+				   vals[RX].srcr | vals[TX].srcr,
+				   vals[RX].srcr | vals[TX].srcr);
 		regmap_update_bits(regs, REG_SSI_STCR,
-				   vals->rx.stcr | vals->tx.stcr,
-				   vals->rx.stcr | vals->tx.stcr);
+				   vals[RX].stcr | vals[TX].stcr,
+				   vals[RX].stcr | vals[TX].stcr);
 	} else {
 		regmap_update_bits(regs, REG_SSI_SRCR,
-				   vals->rx.srcr | vals->tx.srcr, 0);
+				   vals[RX].srcr | vals[TX].srcr, 0);
 		regmap_update_bits(regs, REG_SSI_STCR,
-				   vals->rx.stcr | vals->tx.stcr, 0);
+				   vals[RX].stcr | vals[TX].stcr, 0);
 		regmap_update_bits(regs, REG_SSI_SIER,
-				   vals->rx.sier | vals->tx.sier, 0);
+				   vals[RX].sier | vals[TX].sier, 0);
 	}
 }
 
@@ -443,10 +438,10 @@ static void fsl_ssi_fifo_clear(struct fsl_ssi *ssi, bool is_rx)
  * Enable or disable SSI configuration.
  */
 static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
-			   struct fsl_ssi_reg_val *vals)
+			   struct fsl_ssi_regvals *vals)
 {
 	struct regmap *regs = ssi->regs;
-	struct fsl_ssi_reg_val *avals;
+	struct fsl_ssi_regvals *avals;
 	int nr_active_streams;
 	u32 scr;
 	int keep_active;
@@ -461,10 +456,10 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 		keep_active = 0;
 
 	/* Get the opposite direction to keep its values untouched */
-	if (&ssi->rxtx_reg_val.rx == vals)
-		avals = &ssi->rxtx_reg_val.tx;
+	if (&ssi->regvals[RX] == vals)
+		avals = &ssi->regvals[TX];
 	else
-		avals = &ssi->rxtx_reg_val.rx;
+		avals = &ssi->regvals[RX];
 
 	if (!enable) {
 		/* Exclude necessary bits for the opposite stream */
@@ -543,7 +538,7 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 
 static void fsl_ssi_rx_config(struct fsl_ssi *ssi, bool enable)
 {
-	fsl_ssi_config(ssi, enable, &ssi->rxtx_reg_val.rx);
+	fsl_ssi_config(ssi, enable, &ssi->regvals[RX]);
 }
 
 static void fsl_ssi_tx_ac97_saccst_setup(struct fsl_ssi *ssi)
@@ -571,39 +566,39 @@ static void fsl_ssi_tx_config(struct fsl_ssi *ssi, bool enable)
 	if (enable && fsl_ssi_is_ac97(ssi))
 		fsl_ssi_tx_ac97_saccst_setup(ssi);
 
-	fsl_ssi_config(ssi, enable, &ssi->rxtx_reg_val.tx);
+	fsl_ssi_config(ssi, enable, &ssi->regvals[TX]);
 }
 
 /**
  * Cache critical bits of SIER, SRCR, STCR and SCR to later set them safely
  */
-static void fsl_ssi_setup_reg_vals(struct fsl_ssi *ssi)
+static void fsl_ssi_setup_regvals(struct fsl_ssi *ssi)
 {
-	struct fsl_ssi_rxtx_reg_val *reg = &ssi->rxtx_reg_val;
+	struct fsl_ssi_regvals *vals = ssi->regvals;
 
-	reg->rx.sier = SSI_SIER_RFF0_EN;
-	reg->rx.srcr = SSI_SRCR_RFEN0;
-	reg->rx.scr = 0;
-	reg->tx.sier = SSI_SIER_TFE0_EN;
-	reg->tx.stcr = SSI_STCR_TFEN0;
-	reg->tx.scr = 0;
+	vals[RX].sier = SSI_SIER_RFF0_EN;
+	vals[RX].srcr = SSI_SRCR_RFEN0;
+	vals[RX].scr = 0;
+	vals[TX].sier = SSI_SIER_TFE0_EN;
+	vals[TX].stcr = SSI_STCR_TFEN0;
+	vals[TX].scr = 0;
 
 	/* AC97 has already enabled SSIEN, RE and TE, so ignore them */
 	if (!fsl_ssi_is_ac97(ssi)) {
-		reg->rx.scr = SSI_SCR_SSIEN | SSI_SCR_RE;
-		reg->tx.scr = SSI_SCR_SSIEN | SSI_SCR_TE;
+		vals[RX].scr = SSI_SCR_SSIEN | SSI_SCR_RE;
+		vals[TX].scr = SSI_SCR_SSIEN | SSI_SCR_TE;
 	}
 
 	if (ssi->use_dma) {
-		reg->rx.sier |= SSI_SIER_RDMAE;
-		reg->tx.sier |= SSI_SIER_TDMAE;
+		vals[RX].sier |= SSI_SIER_RDMAE;
+		vals[TX].sier |= SSI_SIER_TDMAE;
 	} else {
-		reg->rx.sier |= SSI_SIER_RIE;
-		reg->tx.sier |= SSI_SIER_TIE;
+		vals[RX].sier |= SSI_SIER_RIE;
+		vals[TX].sier |= SSI_SIER_TIE;
 	}
 
-	reg->rx.sier |= FSLSSI_SIER_DBG_RX_FLAGS;
-	reg->tx.sier |= FSLSSI_SIER_DBG_TX_FLAGS;
+	vals[RX].sier |= FSLSSI_SIER_DBG_RX_FLAGS;
+	vals[TX].sier |= FSLSSI_SIER_DBG_TX_FLAGS;
 }
 
 static void fsl_ssi_setup_ac97(struct fsl_ssi *ssi)
@@ -877,7 +872,7 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 		return -EINVAL;
 	}
 
-	fsl_ssi_setup_reg_vals(ssi);
+	fsl_ssi_setup_regvals(ssi);
 
 	regmap_read(regs, REG_SSI_SCR, &scr);
 	scr &= ~(SSI_SCR_SYN | SSI_SCR_I2S_MODE_MASK);
diff --git a/sound/soc/fsl/fsl_ssi.h b/sound/soc/fsl/fsl_ssi.h
index fe38e69..52b88f1 100644
--- a/sound/soc/fsl/fsl_ssi.h
+++ b/sound/soc/fsl/fsl_ssi.h
@@ -12,6 +12,9 @@
 #ifndef _MPC8610_I2S_H
 #define _MPC8610_I2S_H
 
+#define RX 0
+#define TX 1
+
 /* -- SSI Register Map -- */
 
 /* SSI Transmit Data Register 0 */
-- 
2.1.4
