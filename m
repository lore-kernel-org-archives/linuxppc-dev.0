Return-Path: <broonie@sirena.org.uk>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1FKS0wVSzDx4w
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 21:59:40 +1100 (AEDT)
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Maciej S. Szmigiero <mail@maciej.szmigiero.name>,
 Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>, timur@tabi.org,
 broonie@kernel.org, mail@maciej.szmigiero.name, kernel@pengutronix.de,
 lgirdwood@gmail.com, alsa-devel@alsa-project.org, caleb@crome.org,
 linux-kernel@vger.kernel.org, arnaud.mouiche@invoxia.com, lukma@denx.de,
 fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org
Subject: Applied "ASoC: fsl_ssi: Replace fsl_ssi_rxtx_reg_val with
 fsl_ssi_regvals" to the asoc tree
In-Reply-To: <1513565530-33957-10-git-send-email-nicoleotsuka@gmail.com>
Message-Id: <E1eRFcR-0000sI-GU@debutante>
Date: Tue, 19 Dec 2017 10:59:31 +0000
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch

   ASoC: fsl_ssi: Replace fsl_ssi_rxtx_reg_val with fsl_ssi_regvals

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 2474e4037c4e3fe8b4fe4ab37232973d9b17a573 Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Sun, 17 Dec 2017 18:52:08 -0800
Subject: [PATCH] ASoC: fsl_ssi: Replace fsl_ssi_rxtx_reg_val with
 fsl_ssi_regvals

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
Acked-by: Timur Tabi <timur@tabi.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 79 +++++++++++++++++++++++--------------------------
 sound/soc/fsl/fsl_ssi.h |  3 ++
 2 files changed, 40 insertions(+), 42 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index af3ba718d4bb..aef014c46d96 100644
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
@@ -386,25 +381,25 @@ static irqreturn_t fsl_ssi_isr(int irq, void *dev_id)
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
 
@@ -446,10 +441,10 @@ static void fsl_ssi_fifo_clear(struct fsl_ssi *ssi, bool is_rx)
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
@@ -464,10 +459,10 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
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
 		/*
@@ -558,7 +553,7 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 
 static void fsl_ssi_rx_config(struct fsl_ssi *ssi, bool enable)
 {
-	fsl_ssi_config(ssi, enable, &ssi->rxtx_reg_val.rx);
+	fsl_ssi_config(ssi, enable, &ssi->regvals[RX]);
 }
 
 static void fsl_ssi_tx_ac97_saccst_setup(struct fsl_ssi *ssi)
@@ -586,39 +581,39 @@ static void fsl_ssi_tx_config(struct fsl_ssi *ssi, bool enable)
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
@@ -892,7 +887,7 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 		return -EINVAL;
 	}
 
-	fsl_ssi_setup_reg_vals(ssi);
+	fsl_ssi_setup_regvals(ssi);
 
 	regmap_read(regs, REG_SSI_SCR, &scr);
 	scr &= ~(SSI_SCR_SYN | SSI_SCR_I2S_MODE_MASK);
diff --git a/sound/soc/fsl/fsl_ssi.h b/sound/soc/fsl/fsl_ssi.h
index fe38e6913f96..52b88f1d6c6f 100644
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
2.15.1
