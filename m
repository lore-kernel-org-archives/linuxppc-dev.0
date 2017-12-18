Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z0QZx2gDxzDsFY
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 13:53:29 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id b18so8618861pgv.10
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Dec 2017 18:53:29 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: timur@tabi.org,
	broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, lgirdwood@gmail.com, fabio.estevam@nxp.com,
 mail@maciej.szmigiero.name, caleb@crome.org, arnaud.mouiche@invoxia.com,
 lukma@denx.de, kernel@pengutronix.de
Subject: [PATCH v4 04/11] ASoC: fsl_ssi: Rename registers and fields macros
Date: Sun, 17 Dec 2017 18:52:03 -0800
Message-Id: <1513565530-33957-5-git-send-email-nicoleotsuka@gmail.com>
In-Reply-To: <1513565530-33957-1-git-send-email-nicoleotsuka@gmail.com>
References: <1513565530-33957-1-git-send-email-nicoleotsuka@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch renames CCSR_SSI_xxx to REG_SSI_xxx and SSI_xxx_yyy style.
It also slightly reduces the length of them to save some space.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 sound/soc/fsl/fsl_ssi.c     | 374 +++++++++++++++++++++----------------------
 sound/soc/fsl/fsl_ssi.h     | 376 ++++++++++++++++++++++----------------------
 sound/soc/fsl/fsl_ssi_dbg.c |  44 +++---
 3 files changed, 397 insertions(+), 397 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index ff1827a..24d9695 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -78,12 +78,12 @@
 	 SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S24_LE)
 #endif
 
-#define FSLSSI_SIER_DBG_RX_FLAGS (CCSR_SSI_SIER_RFF0_EN | \
-		CCSR_SSI_SIER_RLS_EN | CCSR_SSI_SIER_RFS_EN | \
-		CCSR_SSI_SIER_ROE0_EN | CCSR_SSI_SIER_RFRC_EN)
-#define FSLSSI_SIER_DBG_TX_FLAGS (CCSR_SSI_SIER_TFE0_EN | \
-		CCSR_SSI_SIER_TLS_EN | CCSR_SSI_SIER_TFS_EN | \
-		CCSR_SSI_SIER_TUE0_EN | CCSR_SSI_SIER_TFRC_EN)
+#define FSLSSI_SIER_DBG_RX_FLAGS (SSI_SIER_RFF0_EN | \
+		SSI_SIER_RLS_EN | SSI_SIER_RFS_EN | \
+		SSI_SIER_ROE0_EN | SSI_SIER_RFRC_EN)
+#define FSLSSI_SIER_DBG_TX_FLAGS (SSI_SIER_TFE0_EN | \
+		SSI_SIER_TLS_EN | SSI_SIER_TFS_EN | \
+		SSI_SIER_TUE0_EN | SSI_SIER_TFRC_EN)
 
 enum fsl_ssi_type {
 	FSL_SSI_MCP8610,
@@ -107,8 +107,8 @@ struct fsl_ssi_rxtx_reg_val {
 static bool fsl_ssi_readable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case CCSR_SSI_SACCEN:
-	case CCSR_SSI_SACCDIS:
+	case REG_SSI_SACCEN:
+	case REG_SSI_SACCDIS:
 		return false;
 	default:
 		return true;
@@ -118,18 +118,18 @@ static bool fsl_ssi_readable_reg(struct device *dev, unsigned int reg)
 static bool fsl_ssi_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case CCSR_SSI_STX0:
-	case CCSR_SSI_STX1:
-	case CCSR_SSI_SRX0:
-	case CCSR_SSI_SRX1:
-	case CCSR_SSI_SISR:
-	case CCSR_SSI_SFCSR:
-	case CCSR_SSI_SACNT:
-	case CCSR_SSI_SACADD:
-	case CCSR_SSI_SACDAT:
-	case CCSR_SSI_SATAG:
-	case CCSR_SSI_SACCST:
-	case CCSR_SSI_SOR:
+	case REG_SSI_STX0:
+	case REG_SSI_STX1:
+	case REG_SSI_SRX0:
+	case REG_SSI_SRX1:
+	case REG_SSI_SISR:
+	case REG_SSI_SFCSR:
+	case REG_SSI_SACNT:
+	case REG_SSI_SACADD:
+	case REG_SSI_SACDAT:
+	case REG_SSI_SATAG:
+	case REG_SSI_SACCST:
+	case REG_SSI_SOR:
 		return true;
 	default:
 		return false;
@@ -139,12 +139,12 @@ static bool fsl_ssi_volatile_reg(struct device *dev, unsigned int reg)
 static bool fsl_ssi_precious_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case CCSR_SSI_SRX0:
-	case CCSR_SSI_SRX1:
-	case CCSR_SSI_SISR:
-	case CCSR_SSI_SACADD:
-	case CCSR_SSI_SACDAT:
-	case CCSR_SSI_SATAG:
+	case REG_SSI_SRX0:
+	case REG_SSI_SRX1:
+	case REG_SSI_SISR:
+	case REG_SSI_SACADD:
+	case REG_SSI_SACDAT:
+	case REG_SSI_SATAG:
 		return true;
 	default:
 		return false;
@@ -154,9 +154,9 @@ static bool fsl_ssi_precious_reg(struct device *dev, unsigned int reg)
 static bool fsl_ssi_writeable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case CCSR_SSI_SRX0:
-	case CCSR_SSI_SRX1:
-	case CCSR_SSI_SACCST:
+	case REG_SSI_SRX0:
+	case REG_SSI_SRX1:
+	case REG_SSI_SACCST:
 		return false;
 	default:
 		return true;
@@ -164,12 +164,12 @@ static bool fsl_ssi_writeable_reg(struct device *dev, unsigned int reg)
 }
 
 static const struct regmap_config fsl_ssi_regconfig = {
-	.max_register = CCSR_SSI_SACCDIS,
+	.max_register = REG_SSI_SACCDIS,
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
 	.val_format_endian = REGMAP_ENDIAN_NATIVE,
-	.num_reg_defaults_raw = CCSR_SSI_SACCDIS / sizeof(uint32_t) + 1,
+	.num_reg_defaults_raw = REG_SSI_SACCDIS / sizeof(uint32_t) + 1,
 	.readable_reg = fsl_ssi_readable_reg,
 	.volatile_reg = fsl_ssi_volatile_reg,
 	.precious_reg = fsl_ssi_precious_reg,
@@ -290,9 +290,9 @@ struct fsl_ssi {
 static struct fsl_ssi_soc_data fsl_ssi_mpc8610 = {
 	.imx = false,
 	.offline_config = true,
-	.sisr_write_mask = CCSR_SSI_SISR_RFRC | CCSR_SSI_SISR_TFRC |
-			CCSR_SSI_SISR_ROE0 | CCSR_SSI_SISR_ROE1 |
-			CCSR_SSI_SISR_TUE0 | CCSR_SSI_SISR_TUE1,
+	.sisr_write_mask = SSI_SISR_RFRC | SSI_SISR_TFRC |
+			SSI_SISR_ROE0 | SSI_SISR_ROE1 |
+			SSI_SISR_TUE0 | SSI_SISR_TUE1,
 };
 
 static struct fsl_ssi_soc_data fsl_ssi_imx21 = {
@@ -305,16 +305,16 @@ static struct fsl_ssi_soc_data fsl_ssi_imx21 = {
 static struct fsl_ssi_soc_data fsl_ssi_imx35 = {
 	.imx = true,
 	.offline_config = true,
-	.sisr_write_mask = CCSR_SSI_SISR_RFRC | CCSR_SSI_SISR_TFRC |
-			CCSR_SSI_SISR_ROE0 | CCSR_SSI_SISR_ROE1 |
-			CCSR_SSI_SISR_TUE0 | CCSR_SSI_SISR_TUE1,
+	.sisr_write_mask = SSI_SISR_RFRC | SSI_SISR_TFRC |
+			SSI_SISR_ROE0 | SSI_SISR_ROE1 |
+			SSI_SISR_TUE0 | SSI_SISR_TUE1,
 };
 
 static struct fsl_ssi_soc_data fsl_ssi_imx51 = {
 	.imx = true,
 	.offline_config = false,
-	.sisr_write_mask = CCSR_SSI_SISR_ROE0 | CCSR_SSI_SISR_ROE1 |
-		CCSR_SSI_SISR_TUE0 | CCSR_SSI_SISR_TUE1,
+	.sisr_write_mask = SSI_SISR_ROE0 | SSI_SISR_ROE1 |
+		SSI_SISR_TUE0 | SSI_SISR_TUE1,
 };
 
 static const struct of_device_id fsl_ssi_ids[] = {
@@ -354,12 +354,12 @@ static irqreturn_t fsl_ssi_isr(int irq, void *dev_id)
 	__be32 sisr;
 	__be32 sisr2;
 
-	regmap_read(regs, CCSR_SSI_SISR, &sisr);
+	regmap_read(regs, REG_SSI_SISR, &sisr);
 
 	sisr2 = sisr & ssi->soc->sisr_write_mask;
 	/* Clear the bits that we set */
 	if (sisr2)
-		regmap_write(regs, CCSR_SSI_SISR, sisr2);
+		regmap_write(regs, REG_SSI_SISR, sisr2);
 
 	fsl_ssi_dbg_isr(&ssi->dbg_stats, sisr);
 
@@ -375,21 +375,21 @@ static void fsl_ssi_rxtx_config(struct fsl_ssi *ssi, bool enable)
 	struct fsl_ssi_rxtx_reg_val *vals = &ssi->rxtx_reg_val;
 
 	if (enable) {
-		regmap_update_bits(regs, CCSR_SSI_SIER,
+		regmap_update_bits(regs, REG_SSI_SIER,
 				vals->rx.sier | vals->tx.sier,
 				vals->rx.sier | vals->tx.sier);
-		regmap_update_bits(regs, CCSR_SSI_SRCR,
+		regmap_update_bits(regs, REG_SSI_SRCR,
 				vals->rx.srcr | vals->tx.srcr,
 				vals->rx.srcr | vals->tx.srcr);
-		regmap_update_bits(regs, CCSR_SSI_STCR,
+		regmap_update_bits(regs, REG_SSI_STCR,
 				vals->rx.stcr | vals->tx.stcr,
 				vals->rx.stcr | vals->tx.stcr);
 	} else {
-		regmap_update_bits(regs, CCSR_SSI_SRCR,
+		regmap_update_bits(regs, REG_SSI_SRCR,
 				vals->rx.srcr | vals->tx.srcr, 0);
-		regmap_update_bits(regs, CCSR_SSI_STCR,
+		regmap_update_bits(regs, REG_SSI_STCR,
 				vals->rx.stcr | vals->tx.stcr, 0);
-		regmap_update_bits(regs, CCSR_SSI_SIER,
+		regmap_update_bits(regs, REG_SSI_SIER,
 				vals->rx.sier | vals->tx.sier, 0);
 	}
 }
@@ -400,11 +400,11 @@ static void fsl_ssi_rxtx_config(struct fsl_ssi *ssi, bool enable)
 static void fsl_ssi_fifo_clear(struct fsl_ssi *ssi, bool is_rx)
 {
 	if (is_rx) {
-		regmap_update_bits(ssi->regs, CCSR_SSI_SOR,
-			CCSR_SSI_SOR_RX_CLR, CCSR_SSI_SOR_RX_CLR);
+		regmap_update_bits(ssi->regs, REG_SSI_SOR,
+			SSI_SOR_RX_CLR, SSI_SOR_RX_CLR);
 	} else {
-		regmap_update_bits(ssi->regs, CCSR_SSI_SOR,
-			CCSR_SSI_SOR_TX_CLR, CCSR_SSI_SOR_TX_CLR);
+		regmap_update_bits(ssi->regs, REG_SSI_SOR,
+			SSI_SOR_TX_CLR, SSI_SOR_TX_CLR);
 	}
 }
 
@@ -440,10 +440,10 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 	u32 scr_val;
 	int keep_active;
 
-	regmap_read(regs, CCSR_SSI_SCR, &scr_val);
+	regmap_read(regs, REG_SSI_SCR, &scr_val);
 
-	nr_active_streams = !!(scr_val & CCSR_SSI_SCR_TE) +
-				!!(scr_val & CCSR_SSI_SCR_RE);
+	nr_active_streams = !!(scr_val & SSI_SCR_TE) +
+				!!(scr_val & SSI_SCR_RE);
 
 	if (nr_active_streams - 1 > 0)
 		keep_active = 1;
@@ -464,7 +464,7 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 		u32 scr = fsl_ssi_disable_val(vals->scr, avals->scr,
 				keep_active);
 		/* Safely disable SCR register for the stream */
-		regmap_update_bits(regs, CCSR_SSI_SCR, scr, 0);
+		regmap_update_bits(regs, REG_SSI_SCR, scr, 0);
 	}
 
 	/*
@@ -483,11 +483,11 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 
 	/* Online configure single direction while SSI is running */
 	if (enable) {
-		fsl_ssi_fifo_clear(ssi, vals->scr & CCSR_SSI_SCR_RE);
+		fsl_ssi_fifo_clear(ssi, vals->scr & SSI_SCR_RE);
 
-		regmap_update_bits(regs, CCSR_SSI_SRCR, vals->srcr, vals->srcr);
-		regmap_update_bits(regs, CCSR_SSI_STCR, vals->stcr, vals->stcr);
-		regmap_update_bits(regs, CCSR_SSI_SIER, vals->sier, vals->sier);
+		regmap_update_bits(regs, REG_SSI_SRCR, vals->srcr, vals->srcr);
+		regmap_update_bits(regs, REG_SSI_STCR, vals->stcr, vals->stcr);
+		regmap_update_bits(regs, REG_SSI_SIER, vals->sier, vals->sier);
 	} else {
 		u32 sier;
 		u32 srcr;
@@ -505,9 +505,9 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 				keep_active);
 
 		/* Safely disable other control registers for the stream */
-		regmap_update_bits(regs, CCSR_SSI_SRCR, srcr, 0);
-		regmap_update_bits(regs, CCSR_SSI_STCR, stcr, 0);
-		regmap_update_bits(regs, CCSR_SSI_SIER, sier, 0);
+		regmap_update_bits(regs, REG_SSI_SRCR, srcr, 0);
+		regmap_update_bits(regs, REG_SSI_STCR, stcr, 0);
+		regmap_update_bits(regs, REG_SSI_SIER, sier, 0);
 	}
 
 config_done:
@@ -519,19 +519,19 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 		 *
 		 * TODO: FIQ cases might also need this upon testing
 		 */
-		if (ssi->use_dma && (vals->scr & CCSR_SSI_SCR_TE)) {
+		if (ssi->use_dma && (vals->scr & SSI_SCR_TE)) {
 			int i;
 			int max_loop = 100;
 
 			/* Enable SSI first to send TX DMA request */
-			regmap_update_bits(regs, CCSR_SSI_SCR,
-					CCSR_SSI_SCR_SSIEN, CCSR_SSI_SCR_SSIEN);
+			regmap_update_bits(regs, REG_SSI_SCR,
+					SSI_SCR_SSIEN, SSI_SCR_SSIEN);
 
 			/* Busy wait until TX FIFO not empty -- DMA working */
 			for (i = 0; i < max_loop; i++) {
 				u32 sfcsr;
-				regmap_read(regs, CCSR_SSI_SFCSR, &sfcsr);
-				if (CCSR_SSI_SFCSR_TFCNT0(sfcsr))
+				regmap_read(regs, REG_SSI_SFCSR, &sfcsr);
+				if (SSI_SFCSR_TFCNT0(sfcsr))
 					break;
 			}
 			if (i == max_loop) {
@@ -540,7 +540,7 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 			}
 		}
 		/* Enable all remaining bits */
-		regmap_update_bits(regs, CCSR_SSI_SCR, vals->scr, vals->scr);
+		regmap_update_bits(regs, REG_SSI_SCR, vals->scr, vals->scr);
 	}
 }
 
@@ -557,9 +557,9 @@ static void fsl_ssi_tx_ac97_saccst_setup(struct fsl_ssi *ssi)
 	/* no SACC{ST,EN,DIS} regs on imx21-class SSI */
 	if (!ssi->soc->imx21regs) {
 		/* Disable all channel slots */
-		regmap_write(regs, CCSR_SSI_SACCDIS, 0xff);
+		regmap_write(regs, REG_SSI_SACCDIS, 0xff);
 		/* Enable slots 3 & 4 -- PCM Playback Left & Right channels */
-		regmap_write(regs, CCSR_SSI_SACCEN, 0x300);
+		regmap_write(regs, REG_SSI_SACCEN, 0x300);
 	}
 }
 
@@ -585,25 +585,25 @@ static void fsl_ssi_setup_reg_vals(struct fsl_ssi *ssi)
 {
 	struct fsl_ssi_rxtx_reg_val *reg = &ssi->rxtx_reg_val;
 
-	reg->rx.sier = CCSR_SSI_SIER_RFF0_EN;
-	reg->rx.srcr = CCSR_SSI_SRCR_RFEN0;
+	reg->rx.sier = SSI_SIER_RFF0_EN;
+	reg->rx.srcr = SSI_SRCR_RFEN0;
 	reg->rx.scr = 0;
-	reg->tx.sier = CCSR_SSI_SIER_TFE0_EN;
-	reg->tx.stcr = CCSR_SSI_STCR_TFEN0;
+	reg->tx.sier = SSI_SIER_TFE0_EN;
+	reg->tx.stcr = SSI_STCR_TFEN0;
 	reg->tx.scr = 0;
 
 	/* AC97 has already enabled SSIEN, RE and TE, so ignore them */
 	if (!fsl_ssi_is_ac97(ssi)) {
-		reg->rx.scr = CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_RE;
-		reg->tx.scr = CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE;
+		reg->rx.scr = SSI_SCR_SSIEN | SSI_SCR_RE;
+		reg->tx.scr = SSI_SCR_SSIEN | SSI_SCR_TE;
 	}
 
 	if (ssi->use_dma) {
-		reg->rx.sier |= CCSR_SSI_SIER_RDMAE;
-		reg->tx.sier |= CCSR_SSI_SIER_TDMAE;
+		reg->rx.sier |= SSI_SIER_RDMAE;
+		reg->tx.sier |= SSI_SIER_TDMAE;
 	} else {
-		reg->rx.sier |= CCSR_SSI_SIER_RIE;
-		reg->tx.sier |= CCSR_SSI_SIER_TIE;
+		reg->rx.sier |= SSI_SIER_RIE;
+		reg->tx.sier |= SSI_SIER_TIE;
 	}
 
 	reg->rx.sier |= FSLSSI_SIER_DBG_RX_FLAGS;
@@ -615,21 +615,21 @@ static void fsl_ssi_setup_ac97(struct fsl_ssi *ssi)
 	struct regmap *regs = ssi->regs;
 
 	/* Setup the clock control register */
-	regmap_write(regs, CCSR_SSI_STCCR,
-			CCSR_SSI_SxCCR_WL(17) | CCSR_SSI_SxCCR_DC(13));
-	regmap_write(regs, CCSR_SSI_SRCCR,
-			CCSR_SSI_SxCCR_WL(17) | CCSR_SSI_SxCCR_DC(13));
+	regmap_write(regs, REG_SSI_STCCR,
+			SSI_SxCCR_WL(17) | SSI_SxCCR_DC(13));
+	regmap_write(regs, REG_SSI_SRCCR,
+			SSI_SxCCR_WL(17) | SSI_SxCCR_DC(13));
 
 	/* Enable AC97 mode and startup the SSI */
-	regmap_write(regs, CCSR_SSI_SACNT,
-			CCSR_SSI_SACNT_AC97EN | CCSR_SSI_SACNT_FV);
+	regmap_write(regs, REG_SSI_SACNT,
+			SSI_SACNT_AC97EN | SSI_SACNT_FV);
 
 	/* AC97 has to communicate with codec before starting a stream */
-	regmap_update_bits(regs, CCSR_SSI_SCR,
-			CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE,
-			CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE);
+	regmap_update_bits(regs, REG_SSI_SCR,
+			SSI_SCR_SSIEN | SSI_SCR_TE | SSI_SCR_RE,
+			SSI_SCR_SSIEN | SSI_SCR_TE | SSI_SCR_RE);
 
-	regmap_write(regs, CCSR_SSI_SOR, CCSR_SSI_SOR_WAIT(3));
+	regmap_write(regs, REG_SSI_SOR, SSI_SOR_WAIT(3));
 }
 
 static int fsl_ssi_startup(struct snd_pcm_substream *substream,
@@ -762,15 +762,15 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	stccr = CCSR_SSI_SxCCR_PM(pm + 1) | (div2 ? CCSR_SSI_SxCCR_DIV2 : 0) |
-		(psr ? CCSR_SSI_SxCCR_PSR : 0);
-	mask = CCSR_SSI_SxCCR_PM_MASK | CCSR_SSI_SxCCR_DIV2 |
-		CCSR_SSI_SxCCR_PSR;
+	stccr = SSI_SxCCR_PM(pm + 1) | (div2 ? SSI_SxCCR_DIV2 : 0) |
+		(psr ? SSI_SxCCR_PSR : 0);
+	mask = SSI_SxCCR_PM_MASK | SSI_SxCCR_DIV2 |
+		SSI_SxCCR_PSR;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK || synchronous)
-		regmap_update_bits(regs, CCSR_SSI_STCCR, mask, stccr);
+		regmap_update_bits(regs, REG_SSI_STCCR, mask, stccr);
 	else
-		regmap_update_bits(regs, CCSR_SSI_SRCCR, mask, stccr);
+		regmap_update_bits(regs, REG_SSI_SRCCR, mask, stccr);
 
 	if (!baudclk_is_used) {
 		ret = clk_set_rate(ssi->baudclk, baudrate);
@@ -801,13 +801,13 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 	struct regmap *regs = ssi->regs;
 	unsigned int channels = params_channels(hw_params);
 	unsigned int sample_size = params_width(hw_params);
-	u32 wl = CCSR_SSI_SxCCR_WL(sample_size);
+	u32 wl = SSI_SxCCR_WL(sample_size);
 	int ret;
 	u32 scr_val;
 	int enabled;
 
-	regmap_read(regs, CCSR_SSI_SCR, &scr_val);
-	enabled = scr_val & CCSR_SSI_SCR_SSIEN;
+	regmap_read(regs, REG_SSI_SCR, &scr_val);
+	enabled = scr_val & SSI_SCR_SSIEN;
 
 	/*
 	 * SSI is properly configured if it is enabled and running in
@@ -837,23 +837,23 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 		u8 i2smode;
 		/* Normal + Network mode to send 16-bit data in 32-bit frames */
 		if (fsl_ssi_is_i2s_cbm_cfs(ssi) && sample_size == 16)
-			i2smode = CCSR_SSI_SCR_I2S_MODE_NORMAL |
-				CCSR_SSI_SCR_NET;
+			i2smode = SSI_SCR_I2S_MODE_NORMAL |
+				SSI_SCR_NET;
 		else
 			i2smode = ssi->i2s_mode;
 
-		regmap_update_bits(regs, CCSR_SSI_SCR,
-				CCSR_SSI_SCR_NET | CCSR_SSI_SCR_I2S_MODE_MASK,
+		regmap_update_bits(regs, REG_SSI_SCR,
+				SSI_SCR_NET | SSI_SCR_I2S_MODE_MASK,
 				channels == 1 ? 0 : i2smode);
 	}
 
 	/* In synchronous mode, the SSI uses STCCR for capture */
 	if ((substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ||
 	    ssi->cpu_dai_drv.symmetric_rates)
-		regmap_update_bits(regs, CCSR_SSI_STCCR, CCSR_SSI_SxCCR_WL_MASK,
+		regmap_update_bits(regs, REG_SSI_STCCR, SSI_SxCCR_WL_MASK,
 				wl);
 	else
-		regmap_update_bits(regs, CCSR_SSI_SRCCR, CCSR_SSI_SxCCR_WL_MASK,
+		regmap_update_bits(regs, REG_SSI_SRCCR, SSI_SxCCR_WL_MASK,
 				wl);
 
 	return 0;
@@ -890,62 +890,62 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 
 	fsl_ssi_setup_reg_vals(ssi);
 
-	regmap_read(regs, CCSR_SSI_SCR, &scr);
-	scr &= ~(CCSR_SSI_SCR_SYN | CCSR_SSI_SCR_I2S_MODE_MASK);
+	regmap_read(regs, REG_SSI_SCR, &scr);
+	scr &= ~(SSI_SCR_SYN | SSI_SCR_I2S_MODE_MASK);
 	/* Synchronize frame sync clock for TE to avoid data slipping */
-	scr |= CCSR_SSI_SCR_SYNC_TX_FS;
+	scr |= SSI_SCR_SYNC_TX_FS;
 
-	mask = CCSR_SSI_STCR_TXBIT0 | CCSR_SSI_STCR_TFDIR | CCSR_SSI_STCR_TXDIR |
-		CCSR_SSI_STCR_TSCKP | CCSR_SSI_STCR_TFSI | CCSR_SSI_STCR_TFSL |
-		CCSR_SSI_STCR_TEFS;
-	regmap_read(regs, CCSR_SSI_STCR, &stcr);
-	regmap_read(regs, CCSR_SSI_SRCR, &srcr);
+	mask = SSI_STCR_TXBIT0 | SSI_STCR_TFDIR | SSI_STCR_TXDIR |
+		SSI_STCR_TSCKP | SSI_STCR_TFSI | SSI_STCR_TFSL |
+		SSI_STCR_TEFS;
+	regmap_read(regs, REG_SSI_STCR, &stcr);
+	regmap_read(regs, REG_SSI_SRCR, &srcr);
 	stcr &= ~mask;
 	srcr &= ~mask;
 
 	/* Use Network mode as default */
-	ssi->i2s_mode = CCSR_SSI_SCR_NET;
+	ssi->i2s_mode = SSI_SCR_NET;
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
-		regmap_update_bits(regs, CCSR_SSI_STCCR,
-				   CCSR_SSI_SxCCR_DC_MASK,
-				   CCSR_SSI_SxCCR_DC(2));
-		regmap_update_bits(regs, CCSR_SSI_SRCCR,
-				   CCSR_SSI_SxCCR_DC_MASK,
-				   CCSR_SSI_SxCCR_DC(2));
+		regmap_update_bits(regs, REG_SSI_STCCR,
+				   SSI_SxCCR_DC_MASK,
+				   SSI_SxCCR_DC(2));
+		regmap_update_bits(regs, REG_SSI_SRCCR,
+				   SSI_SxCCR_DC_MASK,
+				   SSI_SxCCR_DC(2));
 		switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 		case SND_SOC_DAIFMT_CBM_CFS:
 		case SND_SOC_DAIFMT_CBS_CFS:
-			ssi->i2s_mode |= CCSR_SSI_SCR_I2S_MODE_MASTER;
+			ssi->i2s_mode |= SSI_SCR_I2S_MODE_MASTER;
 			break;
 		case SND_SOC_DAIFMT_CBM_CFM:
-			ssi->i2s_mode |= CCSR_SSI_SCR_I2S_MODE_SLAVE;
+			ssi->i2s_mode |= SSI_SCR_I2S_MODE_SLAVE;
 			break;
 		default:
 			return -EINVAL;
 		}
 
 		/* Data on rising edge of bclk, frame low, 1clk before data */
-		strcr |= CCSR_SSI_STCR_TFSI | CCSR_SSI_STCR_TSCKP |
-			CCSR_SSI_STCR_TXBIT0 | CCSR_SSI_STCR_TEFS;
+		strcr |= SSI_STCR_TFSI | SSI_STCR_TSCKP |
+			SSI_STCR_TXBIT0 | SSI_STCR_TEFS;
 		break;
 	case SND_SOC_DAIFMT_LEFT_J:
 		/* Data on rising edge of bclk, frame high */
-		strcr |= CCSR_SSI_STCR_TXBIT0 | CCSR_SSI_STCR_TSCKP;
+		strcr |= SSI_STCR_TXBIT0 | SSI_STCR_TSCKP;
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
 		/* Data on rising edge of bclk, frame high, 1clk before data */
-		strcr |= CCSR_SSI_STCR_TFSL | CCSR_SSI_STCR_TSCKP |
-			CCSR_SSI_STCR_TXBIT0 | CCSR_SSI_STCR_TEFS;
+		strcr |= SSI_STCR_TFSL | SSI_STCR_TSCKP |
+			SSI_STCR_TXBIT0 | SSI_STCR_TEFS;
 		break;
 	case SND_SOC_DAIFMT_DSP_B:
 		/* Data on rising edge of bclk, frame high */
-		strcr |= CCSR_SSI_STCR_TFSL | CCSR_SSI_STCR_TSCKP |
-			CCSR_SSI_STCR_TXBIT0;
+		strcr |= SSI_STCR_TFSL | SSI_STCR_TSCKP |
+			SSI_STCR_TXBIT0;
 		break;
 	case SND_SOC_DAIFMT_AC97:
 		/* Data on falling edge of bclk, frame high, 1clk before data */
-		ssi->i2s_mode |= CCSR_SSI_SCR_I2S_MODE_NORMAL;
+		ssi->i2s_mode |= SSI_SCR_I2S_MODE_NORMAL;
 		break;
 	default:
 		return -EINVAL;
@@ -959,16 +959,16 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 		break;
 	case SND_SOC_DAIFMT_IB_NF:
 		/* Invert bit clock */
-		strcr ^= CCSR_SSI_STCR_TSCKP;
+		strcr ^= SSI_STCR_TSCKP;
 		break;
 	case SND_SOC_DAIFMT_NB_IF:
 		/* Invert frame clock */
-		strcr ^= CCSR_SSI_STCR_TFSI;
+		strcr ^= SSI_STCR_TFSI;
 		break;
 	case SND_SOC_DAIFMT_IB_IF:
 		/* Invert both clocks */
-		strcr ^= CCSR_SSI_STCR_TSCKP;
-		strcr ^= CCSR_SSI_STCR_TFSI;
+		strcr ^= SSI_STCR_TSCKP;
+		strcr ^= SSI_STCR_TFSI;
 		break;
 	default:
 		return -EINVAL;
@@ -978,18 +978,18 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBS_CFS:
 		/* Output bit and frame sync clocks */
-		strcr |= CCSR_SSI_STCR_TFDIR | CCSR_SSI_STCR_TXDIR;
-		scr |= CCSR_SSI_SCR_SYS_CLK_EN;
+		strcr |= SSI_STCR_TFDIR | SSI_STCR_TXDIR;
+		scr |= SSI_SCR_SYS_CLK_EN;
 		break;
 	case SND_SOC_DAIFMT_CBM_CFM:
 		/* Input bit or frame sync clocks */
-		scr &= ~CCSR_SSI_SCR_SYS_CLK_EN;
+		scr &= ~SSI_SCR_SYS_CLK_EN;
 		break;
 	case SND_SOC_DAIFMT_CBM_CFS:
 		/* Input bit clock but output frame sync clock */
-		strcr &= ~CCSR_SSI_STCR_TXDIR;
-		strcr |= CCSR_SSI_STCR_TFDIR;
-		scr &= ~CCSR_SSI_SCR_SYS_CLK_EN;
+		strcr &= ~SSI_STCR_TXDIR;
+		strcr |= SSI_STCR_TFDIR;
+		scr &= ~SSI_SCR_SYS_CLK_EN;
 		break;
 	default:
 		if (!fsl_ssi_is_ac97(ssi))
@@ -1001,27 +1001,27 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 
 	/* Set SYN mode and clear RXDIR bit when using SYN or AC97 mode */
 	if (ssi->cpu_dai_drv.symmetric_rates || fsl_ssi_is_ac97(ssi)) {
-		srcr &= ~CCSR_SSI_SRCR_RXDIR;
-		scr |= CCSR_SSI_SCR_SYN;
+		srcr &= ~SSI_SRCR_RXDIR;
+		scr |= SSI_SCR_SYN;
 	}
 
-	regmap_write(regs, CCSR_SSI_STCR, stcr);
-	regmap_write(regs, CCSR_SSI_SRCR, srcr);
-	regmap_write(regs, CCSR_SSI_SCR, scr);
+	regmap_write(regs, REG_SSI_STCR, stcr);
+	regmap_write(regs, REG_SSI_SRCR, srcr);
+	regmap_write(regs, REG_SSI_SCR, scr);
 
 	wm = ssi->fifo_watermark;
 
-	regmap_write(regs, CCSR_SSI_SFCSR,
-			CCSR_SSI_SFCSR_TFWM0(wm) | CCSR_SSI_SFCSR_RFWM0(wm) |
-			CCSR_SSI_SFCSR_TFWM1(wm) | CCSR_SSI_SFCSR_RFWM1(wm));
+	regmap_write(regs, REG_SSI_SFCSR,
+			SSI_SFCSR_TFWM0(wm) | SSI_SFCSR_RFWM0(wm) |
+			SSI_SFCSR_TFWM1(wm) | SSI_SFCSR_RFWM1(wm));
 
 	if (ssi->use_dual_fifo) {
-		regmap_update_bits(regs, CCSR_SSI_SRCR, CCSR_SSI_SRCR_RFEN1,
-				CCSR_SSI_SRCR_RFEN1);
-		regmap_update_bits(regs, CCSR_SSI_STCR, CCSR_SSI_STCR_TFEN1,
-				CCSR_SSI_STCR_TFEN1);
-		regmap_update_bits(regs, CCSR_SSI_SCR, CCSR_SSI_SCR_TCH_EN,
-				CCSR_SSI_SCR_TCH_EN);
+		regmap_update_bits(regs, REG_SSI_SRCR, SSI_SRCR_RFEN1,
+				SSI_SRCR_RFEN1);
+		regmap_update_bits(regs, REG_SSI_STCR, SSI_STCR_TFEN1,
+				SSI_STCR_TFEN1);
+		regmap_update_bits(regs, REG_SSI_SCR, SSI_SCR_TCH_EN,
+				SSI_SCR_TCH_EN);
 	}
 
 	if ((fmt & SND_SOC_DAIFMT_FORMAT_MASK) == SND_SOC_DAIFMT_AC97)
@@ -1062,30 +1062,30 @@ static int fsl_ssi_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
 	}
 
 	/* The slot number should be >= 2 if using Network mode or I2S mode */
-	regmap_read(regs, CCSR_SSI_SCR, &val);
-	val &= CCSR_SSI_SCR_I2S_MODE_MASK | CCSR_SSI_SCR_NET;
+	regmap_read(regs, REG_SSI_SCR, &val);
+	val &= SSI_SCR_I2S_MODE_MASK | SSI_SCR_NET;
 	if (val && slots < 2) {
 		dev_err(cpu_dai->dev, "slot number should be >= 2 in I2S or NET\n");
 		return -EINVAL;
 	}
 
-	regmap_update_bits(regs, CCSR_SSI_STCCR, CCSR_SSI_SxCCR_DC_MASK,
-			CCSR_SSI_SxCCR_DC(slots));
-	regmap_update_bits(regs, CCSR_SSI_SRCCR, CCSR_SSI_SxCCR_DC_MASK,
-			CCSR_SSI_SxCCR_DC(slots));
+	regmap_update_bits(regs, REG_SSI_STCCR, SSI_SxCCR_DC_MASK,
+			SSI_SxCCR_DC(slots));
+	regmap_update_bits(regs, REG_SSI_SRCCR, SSI_SxCCR_DC_MASK,
+			SSI_SxCCR_DC(slots));
 
 	/* Save SSIEN bit of the SCR register */
-	regmap_read(regs, CCSR_SSI_SCR, &val);
-	val &= CCSR_SSI_SCR_SSIEN;
+	regmap_read(regs, REG_SSI_SCR, &val);
+	val &= SSI_SCR_SSIEN;
 	/* Temporarily enable SSI to allow SxMSKs to be configurable */
-	regmap_update_bits(regs, CCSR_SSI_SCR, CCSR_SSI_SCR_SSIEN,
-			CCSR_SSI_SCR_SSIEN);
+	regmap_update_bits(regs, REG_SSI_SCR, SSI_SCR_SSIEN,
+			SSI_SCR_SSIEN);
 
-	regmap_write(regs, CCSR_SSI_STMSK, ~tx_mask);
-	regmap_write(regs, CCSR_SSI_SRMSK, ~rx_mask);
+	regmap_write(regs, REG_SSI_STMSK, ~tx_mask);
+	regmap_write(regs, REG_SSI_SRMSK, ~rx_mask);
 
 	/* Restore the value of SSIEN bit */
-	regmap_update_bits(regs, CCSR_SSI_SCR, CCSR_SSI_SCR_SSIEN, val);
+	regmap_update_bits(regs, REG_SSI_SCR, SSI_SCR_SSIEN, val);
 
 	ssi->slot_width = slot_width;
 	ssi->slots = slots;
@@ -1132,9 +1132,9 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 	/* Clear corresponding FIFO */
 	if (fsl_ssi_is_ac97(ssi)) {
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			regmap_write(regs, CCSR_SSI_SOR, CCSR_SSI_SOR_TX_CLR);
+			regmap_write(regs, REG_SSI_SOR, SSI_SOR_TX_CLR);
 		else
-			regmap_write(regs, CCSR_SSI_SOR, CCSR_SSI_SOR_RX_CLR);
+			regmap_write(regs, REG_SSI_SOR, SSI_SOR_RX_CLR);
 	}
 
 	return 0;
@@ -1230,13 +1230,13 @@ static void fsl_ssi_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 	}
 
 	lreg = reg <<  12;
-	regmap_write(regs, CCSR_SSI_SACADD, lreg);
+	regmap_write(regs, REG_SSI_SACADD, lreg);
 
 	lval = val << 4;
-	regmap_write(regs, CCSR_SSI_SACDAT, lval);
+	regmap_write(regs, REG_SSI_SACDAT, lval);
 
-	regmap_update_bits(regs, CCSR_SSI_SACNT, CCSR_SSI_SACNT_RDWR_MASK,
-			CCSR_SSI_SACNT_WR);
+	regmap_update_bits(regs, REG_SSI_SACNT, SSI_SACNT_RDWR_MASK,
+			SSI_SACNT_WR);
 	udelay(100);
 
 	clk_disable_unprepare(fsl_ac97_data->clk);
@@ -1265,13 +1265,13 @@ static unsigned short fsl_ssi_ac97_read(struct snd_ac97 *ac97,
 	}
 
 	lreg = (reg & 0x7f) <<  12;
-	regmap_write(regs, CCSR_SSI_SACADD, lreg);
-	regmap_update_bits(regs, CCSR_SSI_SACNT, CCSR_SSI_SACNT_RDWR_MASK,
-			CCSR_SSI_SACNT_RD);
+	regmap_write(regs, REG_SSI_SACADD, lreg);
+	regmap_update_bits(regs, REG_SSI_SACNT, SSI_SACNT_RDWR_MASK,
+			SSI_SACNT_RD);
 
 	udelay(100);
 
-	regmap_read(regs, CCSR_SSI_SACDAT, &reg_val);
+	regmap_read(regs, REG_SSI_SACDAT, &reg_val);
 	val = (reg_val >> 4) & 0xffff;
 
 	clk_disable_unprepare(fsl_ac97_data->clk);
@@ -1333,8 +1333,8 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
 
 	ssi->dma_params_tx.maxburst = ssi->dma_maxburst;
 	ssi->dma_params_rx.maxburst = ssi->dma_maxburst;
-	ssi->dma_params_tx.addr = ssi->ssi_phys + CCSR_SSI_STX0;
-	ssi->dma_params_rx.addr = ssi->ssi_phys + CCSR_SSI_SRX0;
+	ssi->dma_params_tx.addr = ssi->ssi_phys + REG_SSI_STX0;
+	ssi->dma_params_rx.addr = ssi->ssi_phys + REG_SSI_SRX0;
 
 	/* Set to dual FIFO mode according to the SDMA sciprt */
 	ret = of_property_read_u32_array(np, "dmas", dmas, 4);
@@ -1439,9 +1439,9 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 
 	if (ssi->soc->imx21regs) {
 		/* No SACC{ST,EN,DIS} regs in imx21-class SSI */
-		regconfig.max_register = CCSR_SSI_SRMSK;
+		regconfig.max_register = REG_SSI_SRMSK;
 		regconfig.num_reg_defaults_raw =
-			CCSR_SSI_SRMSK / sizeof(uint32_t) + 1;
+			REG_SSI_SRMSK / sizeof(uint32_t) + 1;
 	}
 
 	ret = of_property_match_string(np, "clock-names", "ipg");
@@ -1638,8 +1638,8 @@ static int fsl_ssi_suspend(struct device *dev)
 	struct fsl_ssi *ssi = dev_get_drvdata(dev);
 	struct regmap *regs = ssi->regs;
 
-	regmap_read(regs, CCSR_SSI_SFCSR, &ssi->regcache_sfcsr);
-	regmap_read(regs, CCSR_SSI_SACNT, &ssi->regcache_sacnt);
+	regmap_read(regs, REG_SSI_SFCSR, &ssi->regcache_sfcsr);
+	regmap_read(regs, REG_SSI_SACNT, &ssi->regcache_sacnt);
 
 	regcache_cache_only(regs, true);
 	regcache_mark_dirty(regs);
@@ -1654,11 +1654,11 @@ static int fsl_ssi_resume(struct device *dev)
 
 	regcache_cache_only(regs, false);
 
-	regmap_update_bits(regs, CCSR_SSI_SFCSR,
-			CCSR_SSI_SFCSR_RFWM1_MASK | CCSR_SSI_SFCSR_TFWM1_MASK |
-			CCSR_SSI_SFCSR_RFWM0_MASK | CCSR_SSI_SFCSR_TFWM0_MASK,
+	regmap_update_bits(regs, REG_SSI_SFCSR,
+			SSI_SFCSR_RFWM1_MASK | SSI_SFCSR_TFWM1_MASK |
+			SSI_SFCSR_RFWM0_MASK | SSI_SFCSR_TFWM0_MASK,
 			ssi->regcache_sfcsr);
-	regmap_write(regs, CCSR_SSI_SACNT, ssi->regcache_sacnt);
+	regmap_write(regs, REG_SSI_SACNT, ssi->regcache_sacnt);
 
 	return regcache_sync(regs);
 }
diff --git a/sound/soc/fsl/fsl_ssi.h b/sound/soc/fsl/fsl_ssi.h
index 1ad3bde..cdcf3d2 100644
--- a/sound/soc/fsl/fsl_ssi.h
+++ b/sound/soc/fsl/fsl_ssi.h
@@ -15,55 +15,55 @@
 /* -- SSI Register Map -- */
 
 /* SSI Transmit Data Register 0 */
-#define CCSR_SSI_STX0			0x00
+#define REG_SSI_STX0			0x00
 /* SSI Transmit Data Register 1 */
-#define CCSR_SSI_STX1			0x04
+#define REG_SSI_STX1			0x04
 /* SSI Receive Data Register 0 */
-#define CCSR_SSI_SRX0			0x08
+#define REG_SSI_SRX0			0x08
 /* SSI Receive Data Register 1 */
-#define CCSR_SSI_SRX1			0x0c
+#define REG_SSI_SRX1			0x0c
 /* SSI Control Register */
-#define CCSR_SSI_SCR			0x10
+#define REG_SSI_SCR			0x10
 /* SSI Interrupt Status Register */
-#define CCSR_SSI_SISR			0x14
+#define REG_SSI_SISR			0x14
 /* SSI Interrupt Enable Register */
-#define CCSR_SSI_SIER			0x18
+#define REG_SSI_SIER			0x18
 /* SSI Transmit Configuration Register */
-#define CCSR_SSI_STCR			0x1c
+#define REG_SSI_STCR			0x1c
 /* SSI Receive Configuration Register */
-#define CCSR_SSI_SRCR			0x20
+#define REG_SSI_SRCR			0x20
 /* SSI Transmit Clock Control Register */
-#define CCSR_SSI_STCCR			0x24
+#define REG_SSI_STCCR			0x24
 /* SSI Receive Clock Control Register */
-#define CCSR_SSI_SRCCR			0x28
+#define REG_SSI_SRCCR			0x28
 /* SSI FIFO Control/Status Register */
-#define CCSR_SSI_SFCSR			0x2c
+#define REG_SSI_SFCSR			0x2c
 /*
  * SSI Test Register (Intended for debugging purposes only)
  *
  * Note: STR is not documented in recent IMX datasheet, but
  * is described in IMX51 reference manual at section 56.3.3.14
  */
-#define CCSR_SSI_STR			0x30
+#define REG_SSI_STR			0x30
 /*
  * SSI Option Register (Intended for internal use only)
  *
  * Note: SOR is not documented in recent IMX datasheet, but
  * is described in IMX51 reference manual at section 56.3.3.15
  */
-#define CCSR_SSI_SOR			0x34
+#define REG_SSI_SOR			0x34
 /* SSI AC97 Control Register */
-#define CCSR_SSI_SACNT			0x38
+#define REG_SSI_SACNT			0x38
 /* SSI AC97 Command Address Register */
-#define CCSR_SSI_SACADD			0x3c
+#define REG_SSI_SACADD			0x3c
 /* SSI AC97 Command Data Register */
-#define CCSR_SSI_SACDAT			0x40
+#define REG_SSI_SACDAT			0x40
 /* SSI AC97 Tag Register */
-#define CCSR_SSI_SATAG			0x44
+#define REG_SSI_SATAG			0x44
 /* SSI Transmit Time Slot Mask Register */
-#define CCSR_SSI_STMSK			0x48
+#define REG_SSI_STMSK			0x48
 /* SSI  Receive Time Slot Mask Register */
-#define CCSR_SSI_SRMSK			0x4c
+#define REG_SSI_SRMSK			0x4c
 /*
  * SSI AC97 Channel Status Register
  *
@@ -72,193 +72,193 @@
  * 2) Writing a '1' bit at some position in SACCDIS unsets the relevant bit
  * 3) Receivng a '1' in SLOTREQ bit from external CODEC via AC Link
  */
-#define CCSR_SSI_SACCST			0x50
+#define REG_SSI_SACCST			0x50
 /* SSI AC97 Channel Enable Register -- Set bits in SACCST */
-#define CCSR_SSI_SACCEN			0x54
+#define REG_SSI_SACCEN			0x54
 /* SSI AC97 Channel Disable Register -- Clear bits in SACCST */
-#define CCSR_SSI_SACCDIS		0x58
+#define REG_SSI_SACCDIS			0x58
 
 /* -- SSI Register Field Maps -- */
 
-/* SSI Control Register -- CCSR_SSI_SCR 0x10 */
-#define CCSR_SSI_SCR_SYNC_TX_FS		0x00001000
-#define CCSR_SSI_SCR_RFR_CLK_DIS	0x00000800
-#define CCSR_SSI_SCR_TFR_CLK_DIS	0x00000400
-#define CCSR_SSI_SCR_TCH_EN		0x00000100
-#define CCSR_SSI_SCR_SYS_CLK_EN		0x00000080
-#define CCSR_SSI_SCR_I2S_MODE_MASK	0x00000060
-#define CCSR_SSI_SCR_I2S_MODE_NORMAL	0x00000000
-#define CCSR_SSI_SCR_I2S_MODE_MASTER	0x00000020
-#define CCSR_SSI_SCR_I2S_MODE_SLAVE	0x00000040
-#define CCSR_SSI_SCR_SYN		0x00000010
-#define CCSR_SSI_SCR_NET		0x00000008
-#define CCSR_SSI_SCR_RE			0x00000004
-#define CCSR_SSI_SCR_TE			0x00000002
-#define CCSR_SSI_SCR_SSIEN		0x00000001
+/* SSI Control Register -- REG_SSI_SCR 0x10 */
+#define SSI_SCR_SYNC_TX_FS		0x00001000
+#define SSI_SCR_RFR_CLK_DIS		0x00000800
+#define SSI_SCR_TFR_CLK_DIS		0x00000400
+#define SSI_SCR_TCH_EN			0x00000100
+#define SSI_SCR_SYS_CLK_EN		0x00000080
+#define SSI_SCR_I2S_MODE_MASK		0x00000060
+#define SSI_SCR_I2S_MODE_NORMAL		0x00000000
+#define SSI_SCR_I2S_MODE_MASTER		0x00000020
+#define SSI_SCR_I2S_MODE_SLAVE		0x00000040
+#define SSI_SCR_SYN			0x00000010
+#define SSI_SCR_NET			0x00000008
+#define SSI_SCR_RE			0x00000004
+#define SSI_SCR_TE			0x00000002
+#define SSI_SCR_SSIEN			0x00000001
 
-/* SSI Interrupt Status Register -- CCSR_SSI_SISR 0x14 */
-#define CCSR_SSI_SISR_RFRC		0x01000000
-#define CCSR_SSI_SISR_TFRC		0x00800000
-#define CCSR_SSI_SISR_CMDAU		0x00040000
-#define CCSR_SSI_SISR_CMDDU		0x00020000
-#define CCSR_SSI_SISR_RXT		0x00010000
-#define CCSR_SSI_SISR_RDR1		0x00008000
-#define CCSR_SSI_SISR_RDR0		0x00004000
-#define CCSR_SSI_SISR_TDE1		0x00002000
-#define CCSR_SSI_SISR_TDE0		0x00001000
-#define CCSR_SSI_SISR_ROE1		0x00000800
-#define CCSR_SSI_SISR_ROE0		0x00000400
-#define CCSR_SSI_SISR_TUE1		0x00000200
-#define CCSR_SSI_SISR_TUE0		0x00000100
-#define CCSR_SSI_SISR_TFS		0x00000080
-#define CCSR_SSI_SISR_RFS		0x00000040
-#define CCSR_SSI_SISR_TLS		0x00000020
-#define CCSR_SSI_SISR_RLS		0x00000010
-#define CCSR_SSI_SISR_RFF1		0x00000008
-#define CCSR_SSI_SISR_RFF0		0x00000004
-#define CCSR_SSI_SISR_TFE1		0x00000002
-#define CCSR_SSI_SISR_TFE0		0x00000001
+/* SSI Interrupt Status Register -- REG_SSI_SISR 0x14 */
+#define SSI_SISR_RFRC			0x01000000
+#define SSI_SISR_TFRC			0x00800000
+#define SSI_SISR_CMDAU			0x00040000
+#define SSI_SISR_CMDDU			0x00020000
+#define SSI_SISR_RXT			0x00010000
+#define SSI_SISR_RDR1			0x00008000
+#define SSI_SISR_RDR0			0x00004000
+#define SSI_SISR_TDE1			0x00002000
+#define SSI_SISR_TDE0			0x00001000
+#define SSI_SISR_ROE1			0x00000800
+#define SSI_SISR_ROE0			0x00000400
+#define SSI_SISR_TUE1			0x00000200
+#define SSI_SISR_TUE0			0x00000100
+#define SSI_SISR_TFS			0x00000080
+#define SSI_SISR_RFS			0x00000040
+#define SSI_SISR_TLS			0x00000020
+#define SSI_SISR_RLS			0x00000010
+#define SSI_SISR_RFF1			0x00000008
+#define SSI_SISR_RFF0			0x00000004
+#define SSI_SISR_TFE1			0x00000002
+#define SSI_SISR_TFE0			0x00000001
 
-/* SSI Interrupt Enable Register -- CCSR_SSI_SIER 0x18 */
-#define CCSR_SSI_SIER_RFRC_EN		0x01000000
-#define CCSR_SSI_SIER_TFRC_EN		0x00800000
-#define CCSR_SSI_SIER_RDMAE		0x00400000
-#define CCSR_SSI_SIER_RIE		0x00200000
-#define CCSR_SSI_SIER_TDMAE		0x00100000
-#define CCSR_SSI_SIER_TIE		0x00080000
-#define CCSR_SSI_SIER_CMDAU_EN		0x00040000
-#define CCSR_SSI_SIER_CMDDU_EN		0x00020000
-#define CCSR_SSI_SIER_RXT_EN		0x00010000
-#define CCSR_SSI_SIER_RDR1_EN		0x00008000
-#define CCSR_SSI_SIER_RDR0_EN		0x00004000
-#define CCSR_SSI_SIER_TDE1_EN		0x00002000
-#define CCSR_SSI_SIER_TDE0_EN		0x00001000
-#define CCSR_SSI_SIER_ROE1_EN		0x00000800
-#define CCSR_SSI_SIER_ROE0_EN		0x00000400
-#define CCSR_SSI_SIER_TUE1_EN		0x00000200
-#define CCSR_SSI_SIER_TUE0_EN		0x00000100
-#define CCSR_SSI_SIER_TFS_EN		0x00000080
-#define CCSR_SSI_SIER_RFS_EN		0x00000040
-#define CCSR_SSI_SIER_TLS_EN		0x00000020
-#define CCSR_SSI_SIER_RLS_EN		0x00000010
-#define CCSR_SSI_SIER_RFF1_EN		0x00000008
-#define CCSR_SSI_SIER_RFF0_EN		0x00000004
-#define CCSR_SSI_SIER_TFE1_EN		0x00000002
-#define CCSR_SSI_SIER_TFE0_EN		0x00000001
+/* SSI Interrupt Enable Register -- REG_SSI_SIER 0x18 */
+#define SSI_SIER_RFRC_EN		0x01000000
+#define SSI_SIER_TFRC_EN		0x00800000
+#define SSI_SIER_RDMAE			0x00400000
+#define SSI_SIER_RIE			0x00200000
+#define SSI_SIER_TDMAE			0x00100000
+#define SSI_SIER_TIE			0x00080000
+#define SSI_SIER_CMDAU_EN		0x00040000
+#define SSI_SIER_CMDDU_EN		0x00020000
+#define SSI_SIER_RXT_EN			0x00010000
+#define SSI_SIER_RDR1_EN		0x00008000
+#define SSI_SIER_RDR0_EN		0x00004000
+#define SSI_SIER_TDE1_EN		0x00002000
+#define SSI_SIER_TDE0_EN		0x00001000
+#define SSI_SIER_ROE1_EN		0x00000800
+#define SSI_SIER_ROE0_EN		0x00000400
+#define SSI_SIER_TUE1_EN		0x00000200
+#define SSI_SIER_TUE0_EN		0x00000100
+#define SSI_SIER_TFS_EN			0x00000080
+#define SSI_SIER_RFS_EN			0x00000040
+#define SSI_SIER_TLS_EN			0x00000020
+#define SSI_SIER_RLS_EN			0x00000010
+#define SSI_SIER_RFF1_EN		0x00000008
+#define SSI_SIER_RFF0_EN		0x00000004
+#define SSI_SIER_TFE1_EN		0x00000002
+#define SSI_SIER_TFE0_EN		0x00000001
 
-/* SSI Transmit Configuration Register -- CCSR_SSI_STCR 0x1C */
-#define CCSR_SSI_STCR_TXBIT0		0x00000200
-#define CCSR_SSI_STCR_TFEN1		0x00000100
-#define CCSR_SSI_STCR_TFEN0		0x00000080
-#define CCSR_SSI_STCR_TFDIR		0x00000040
-#define CCSR_SSI_STCR_TXDIR		0x00000020
-#define CCSR_SSI_STCR_TSHFD		0x00000010
-#define CCSR_SSI_STCR_TSCKP		0x00000008
-#define CCSR_SSI_STCR_TFSI		0x00000004
-#define CCSR_SSI_STCR_TFSL		0x00000002
-#define CCSR_SSI_STCR_TEFS		0x00000001
+/* SSI Transmit Configuration Register -- REG_SSI_STCR 0x1C */
+#define SSI_STCR_TXBIT0			0x00000200
+#define SSI_STCR_TFEN1			0x00000100
+#define SSI_STCR_TFEN0			0x00000080
+#define SSI_STCR_TFDIR			0x00000040
+#define SSI_STCR_TXDIR			0x00000020
+#define SSI_STCR_TSHFD			0x00000010
+#define SSI_STCR_TSCKP			0x00000008
+#define SSI_STCR_TFSI			0x00000004
+#define SSI_STCR_TFSL			0x00000002
+#define SSI_STCR_TEFS			0x00000001
 
-/* SSI Receive Configuration Register -- CCSR_SSI_SRCR 0x20 */
-#define CCSR_SSI_SRCR_RXEXT		0x00000400
-#define CCSR_SSI_SRCR_RXBIT0		0x00000200
-#define CCSR_SSI_SRCR_RFEN1		0x00000100
-#define CCSR_SSI_SRCR_RFEN0		0x00000080
-#define CCSR_SSI_SRCR_RFDIR		0x00000040
-#define CCSR_SSI_SRCR_RXDIR		0x00000020
-#define CCSR_SSI_SRCR_RSHFD		0x00000010
-#define CCSR_SSI_SRCR_RSCKP		0x00000008
-#define CCSR_SSI_SRCR_RFSI		0x00000004
-#define CCSR_SSI_SRCR_RFSL		0x00000002
-#define CCSR_SSI_SRCR_REFS		0x00000001
+/* SSI Receive Configuration Register -- REG_SSI_SRCR 0x20 */
+#define SSI_SRCR_RXEXT			0x00000400
+#define SSI_SRCR_RXBIT0			0x00000200
+#define SSI_SRCR_RFEN1			0x00000100
+#define SSI_SRCR_RFEN0			0x00000080
+#define SSI_SRCR_RFDIR			0x00000040
+#define SSI_SRCR_RXDIR			0x00000020
+#define SSI_SRCR_RSHFD			0x00000010
+#define SSI_SRCR_RSCKP			0x00000008
+#define SSI_SRCR_RFSI			0x00000004
+#define SSI_SRCR_RFSL			0x00000002
+#define SSI_SRCR_REFS			0x00000001
 
 /*
- * SSI Transmit Clock Control Register -- CCSR_SSI_STCCR 0x24
- * SSI Receive Clock Control Register -- CCSR_SSI_SRCCR 0x28
+ * SSI Transmit Clock Control Register -- REG_SSI_STCCR 0x24
+ * SSI Receive Clock Control Register -- REG_SSI_SRCCR 0x28
  */
-#define CCSR_SSI_SxCCR_DIV2_SHIFT	18
-#define CCSR_SSI_SxCCR_DIV2		0x00040000
-#define CCSR_SSI_SxCCR_PSR_SHIFT	17
-#define CCSR_SSI_SxCCR_PSR		0x00020000
-#define CCSR_SSI_SxCCR_WL_SHIFT		13
-#define CCSR_SSI_SxCCR_WL_MASK		0x0001E000
-#define CCSR_SSI_SxCCR_WL(x) \
-	(((((x) / 2) - 1) << CCSR_SSI_SxCCR_WL_SHIFT) & CCSR_SSI_SxCCR_WL_MASK)
-#define CCSR_SSI_SxCCR_DC_SHIFT		8
-#define CCSR_SSI_SxCCR_DC_MASK		0x00001F00
-#define CCSR_SSI_SxCCR_DC(x) \
-	((((x) - 1) << CCSR_SSI_SxCCR_DC_SHIFT) & CCSR_SSI_SxCCR_DC_MASK)
-#define CCSR_SSI_SxCCR_PM_SHIFT		0
-#define CCSR_SSI_SxCCR_PM_MASK		0x000000FF
-#define CCSR_SSI_SxCCR_PM(x) \
-	((((x) - 1) << CCSR_SSI_SxCCR_PM_SHIFT) & CCSR_SSI_SxCCR_PM_MASK)
+#define SSI_SxCCR_DIV2_SHIFT		18
+#define SSI_SxCCR_DIV2			0x00040000
+#define SSI_SxCCR_PSR_SHIFT		17
+#define SSI_SxCCR_PSR			0x00020000
+#define SSI_SxCCR_WL_SHIFT		13
+#define SSI_SxCCR_WL_MASK		0x0001E000
+#define SSI_SxCCR_WL(x) \
+	(((((x) / 2) - 1) << SSI_SxCCR_WL_SHIFT) & SSI_SxCCR_WL_MASK)
+#define SSI_SxCCR_DC_SHIFT		8
+#define SSI_SxCCR_DC_MASK		0x00001F00
+#define SSI_SxCCR_DC(x) \
+	((((x) - 1) << SSI_SxCCR_DC_SHIFT) & SSI_SxCCR_DC_MASK)
+#define SSI_SxCCR_PM_SHIFT		0
+#define SSI_SxCCR_PM_MASK		0x000000FF
+#define SSI_SxCCR_PM(x) \
+	((((x) - 1) << SSI_SxCCR_PM_SHIFT) & SSI_SxCCR_PM_MASK)
 
 /*
- * SSI FIFO Control/Status Register -- CCSR_SSI_SFCSR 0x2c
+ * SSI FIFO Control/Status Register -- REG_SSI_SFCSR 0x2c
  *
- * Tx or Rx FIFO Counter -- CCSR_SSI_SFCSR_xFCNTy Read-Only
- * Tx or Rx FIFO Watermarks -- CCSR_SSI_SFCSR_xFWMy Read/Write
+ * Tx or Rx FIFO Counter -- SSI_SFCSR_xFCNTy Read-Only
+ * Tx or Rx FIFO Watermarks -- SSI_SFCSR_xFWMy Read/Write
  */
-#define CCSR_SSI_SFCSR_RFCNT1_SHIFT	28
-#define CCSR_SSI_SFCSR_RFCNT1_MASK	0xF0000000
-#define CCSR_SSI_SFCSR_RFCNT1(x) \
-	(((x) & CCSR_SSI_SFCSR_RFCNT1_MASK) >> CCSR_SSI_SFCSR_RFCNT1_SHIFT)
-#define CCSR_SSI_SFCSR_TFCNT1_SHIFT	24
-#define CCSR_SSI_SFCSR_TFCNT1_MASK	0x0F000000
-#define CCSR_SSI_SFCSR_TFCNT1(x) \
-	(((x) & CCSR_SSI_SFCSR_TFCNT1_MASK) >> CCSR_SSI_SFCSR_TFCNT1_SHIFT)
-#define CCSR_SSI_SFCSR_RFWM1_SHIFT	20
-#define CCSR_SSI_SFCSR_RFWM1_MASK	0x00F00000
-#define CCSR_SSI_SFCSR_RFWM1(x)	\
-	(((x) << CCSR_SSI_SFCSR_RFWM1_SHIFT) & CCSR_SSI_SFCSR_RFWM1_MASK)
-#define CCSR_SSI_SFCSR_TFWM1_SHIFT	16
-#define CCSR_SSI_SFCSR_TFWM1_MASK	0x000F0000
-#define CCSR_SSI_SFCSR_TFWM1(x)	\
-	(((x) << CCSR_SSI_SFCSR_TFWM1_SHIFT) & CCSR_SSI_SFCSR_TFWM1_MASK)
-#define CCSR_SSI_SFCSR_RFCNT0_SHIFT	12
-#define CCSR_SSI_SFCSR_RFCNT0_MASK	0x0000F000
-#define CCSR_SSI_SFCSR_RFCNT0(x) \
-	(((x) & CCSR_SSI_SFCSR_RFCNT0_MASK) >> CCSR_SSI_SFCSR_RFCNT0_SHIFT)
-#define CCSR_SSI_SFCSR_TFCNT0_SHIFT	8
-#define CCSR_SSI_SFCSR_TFCNT0_MASK	0x00000F00
-#define CCSR_SSI_SFCSR_TFCNT0(x) \
-	(((x) & CCSR_SSI_SFCSR_TFCNT0_MASK) >> CCSR_SSI_SFCSR_TFCNT0_SHIFT)
-#define CCSR_SSI_SFCSR_RFWM0_SHIFT	4
-#define CCSR_SSI_SFCSR_RFWM0_MASK	0x000000F0
-#define CCSR_SSI_SFCSR_RFWM0(x)	\
-	(((x) << CCSR_SSI_SFCSR_RFWM0_SHIFT) & CCSR_SSI_SFCSR_RFWM0_MASK)
-#define CCSR_SSI_SFCSR_TFWM0_SHIFT	0
-#define CCSR_SSI_SFCSR_TFWM0_MASK	0x0000000F
-#define CCSR_SSI_SFCSR_TFWM0(x)	\
-	(((x) << CCSR_SSI_SFCSR_TFWM0_SHIFT) & CCSR_SSI_SFCSR_TFWM0_MASK)
+#define SSI_SFCSR_RFCNT1_SHIFT		28
+#define SSI_SFCSR_RFCNT1_MASK		0xF0000000
+#define SSI_SFCSR_RFCNT1(x) \
+	(((x) & SSI_SFCSR_RFCNT1_MASK) >> SSI_SFCSR_RFCNT1_SHIFT)
+#define SSI_SFCSR_TFCNT1_SHIFT		24
+#define SSI_SFCSR_TFCNT1_MASK		0x0F000000
+#define SSI_SFCSR_TFCNT1(x) \
+	(((x) & SSI_SFCSR_TFCNT1_MASK) >> SSI_SFCSR_TFCNT1_SHIFT)
+#define SSI_SFCSR_RFWM1_SHIFT		20
+#define SSI_SFCSR_RFWM1_MASK		0x00F00000
+#define SSI_SFCSR_RFWM1(x)	\
+	(((x) << SSI_SFCSR_RFWM1_SHIFT) & SSI_SFCSR_RFWM1_MASK)
+#define SSI_SFCSR_TFWM1_SHIFT		16
+#define SSI_SFCSR_TFWM1_MASK		0x000F0000
+#define SSI_SFCSR_TFWM1(x)	\
+	(((x) << SSI_SFCSR_TFWM1_SHIFT) & SSI_SFCSR_TFWM1_MASK)
+#define SSI_SFCSR_RFCNT0_SHIFT		12
+#define SSI_SFCSR_RFCNT0_MASK		0x0000F000
+#define SSI_SFCSR_RFCNT0(x) \
+	(((x) & SSI_SFCSR_RFCNT0_MASK) >> SSI_SFCSR_RFCNT0_SHIFT)
+#define SSI_SFCSR_TFCNT0_SHIFT		8
+#define SSI_SFCSR_TFCNT0_MASK		0x00000F00
+#define SSI_SFCSR_TFCNT0(x) \
+	(((x) & SSI_SFCSR_TFCNT0_MASK) >> SSI_SFCSR_TFCNT0_SHIFT)
+#define SSI_SFCSR_RFWM0_SHIFT		4
+#define SSI_SFCSR_RFWM0_MASK		0x000000F0
+#define SSI_SFCSR_RFWM0(x)	\
+	(((x) << SSI_SFCSR_RFWM0_SHIFT) & SSI_SFCSR_RFWM0_MASK)
+#define SSI_SFCSR_TFWM0_SHIFT		0
+#define SSI_SFCSR_TFWM0_MASK		0x0000000F
+#define SSI_SFCSR_TFWM0(x)	\
+	(((x) << SSI_SFCSR_TFWM0_SHIFT) & SSI_SFCSR_TFWM0_MASK)
 
-/* SSI Test Register -- CCSR_SSI_STR 0x30 */
-#define CCSR_SSI_STR_TEST		0x00008000
-#define CCSR_SSI_STR_RCK2TCK		0x00004000
-#define CCSR_SSI_STR_RFS2TFS		0x00002000
-#define CCSR_SSI_STR_RXSTATE(x) (((x) >> 8) & 0x1F)
-#define CCSR_SSI_STR_TXD2RXD		0x00000080
-#define CCSR_SSI_STR_TCK2RCK		0x00000040
-#define CCSR_SSI_STR_TFS2RFS		0x00000020
-#define CCSR_SSI_STR_TXSTATE(x) ((x) & 0x1F)
+/* SSI Test Register -- REG_SSI_STR 0x30 */
+#define SSI_STR_TEST			0x00008000
+#define SSI_STR_RCK2TCK			0x00004000
+#define SSI_STR_RFS2TFS			0x00002000
+#define SSI_STR_RXSTATE(x)		(((x) >> 8) & 0x1F)
+#define SSI_STR_TXD2RXD			0x00000080
+#define SSI_STR_TCK2RCK			0x00000040
+#define SSI_STR_TFS2RFS			0x00000020
+#define SSI_STR_TXSTATE(x)		((x) & 0x1F)
 
-/* SSI Option Register -- CCSR_SSI_SOR 0x34 */
-#define CCSR_SSI_SOR_CLKOFF		0x00000040
-#define CCSR_SSI_SOR_RX_CLR		0x00000020
-#define CCSR_SSI_SOR_TX_CLR		0x00000010
-#define CCSR_SSI_SOR_INIT		0x00000008
-#define CCSR_SSI_SOR_WAIT_SHIFT		1
-#define CCSR_SSI_SOR_WAIT_MASK		0x00000006
-#define CCSR_SSI_SOR_WAIT(x) (((x) & 3) << CCSR_SSI_SOR_WAIT_SHIFT)
-#define CCSR_SSI_SOR_SYNRST 		0x00000001
+/* SSI Option Register -- REG_SSI_SOR 0x34 */
+#define SSI_SOR_CLKOFF			0x00000040
+#define SSI_SOR_RX_CLR			0x00000020
+#define SSI_SOR_TX_CLR			0x00000010
+#define SSI_SOR_INIT			0x00000008
+#define SSI_SOR_WAIT_SHIFT		1
+#define SSI_SOR_WAIT_MASK		0x00000006
+#define SSI_SOR_WAIT(x)			(((x) & 3) << SSI_SOR_WAIT_SHIFT)
+#define SSI_SOR_SYNRST			0x00000001
 
-/* SSI AC97 Control Register -- CCSR_SSI_SACNT 0x38 */
-#define CCSR_SSI_SACNT_FRDIV(x)		(((x) & 0x3f) << 5)
-#define CCSR_SSI_SACNT_WR		0x00000010
-#define CCSR_SSI_SACNT_RD		0x00000008
-#define CCSR_SSI_SACNT_RDWR_MASK	0x00000018
-#define CCSR_SSI_SACNT_TIF		0x00000004
-#define CCSR_SSI_SACNT_FV		0x00000002
-#define CCSR_SSI_SACNT_AC97EN		0x00000001
+/* SSI AC97 Control Register -- REG_SSI_SACNT 0x38 */
+#define SSI_SACNT_FRDIV(x)		(((x) & 0x3f) << 5)
+#define SSI_SACNT_WR			0x00000010
+#define SSI_SACNT_RD			0x00000008
+#define SSI_SACNT_RDWR_MASK		0x00000018
+#define SSI_SACNT_TIF			0x00000004
+#define SSI_SACNT_FV			0x00000002
+#define SSI_SACNT_AC97EN		0x00000001
 
 
 struct device;
diff --git a/sound/soc/fsl/fsl_ssi_dbg.c b/sound/soc/fsl/fsl_ssi_dbg.c
index 88d9e8e..362df91 100644
--- a/sound/soc/fsl/fsl_ssi_dbg.c
+++ b/sound/soc/fsl/fsl_ssi_dbg.c
@@ -18,67 +18,67 @@
 
 void fsl_ssi_dbg_isr(struct fsl_ssi_dbg *dbg, u32 sisr)
 {
-	if (sisr & CCSR_SSI_SISR_RFRC)
+	if (sisr & SSI_SISR_RFRC)
 		dbg->stats.rfrc++;
 
-	if (sisr & CCSR_SSI_SISR_TFRC)
+	if (sisr & SSI_SISR_TFRC)
 		dbg->stats.tfrc++;
 
-	if (sisr & CCSR_SSI_SISR_CMDAU)
+	if (sisr & SSI_SISR_CMDAU)
 		dbg->stats.cmdau++;
 
-	if (sisr & CCSR_SSI_SISR_CMDDU)
+	if (sisr & SSI_SISR_CMDDU)
 		dbg->stats.cmddu++;
 
-	if (sisr & CCSR_SSI_SISR_RXT)
+	if (sisr & SSI_SISR_RXT)
 		dbg->stats.rxt++;
 
-	if (sisr & CCSR_SSI_SISR_RDR1)
+	if (sisr & SSI_SISR_RDR1)
 		dbg->stats.rdr1++;
 
-	if (sisr & CCSR_SSI_SISR_RDR0)
+	if (sisr & SSI_SISR_RDR0)
 		dbg->stats.rdr0++;
 
-	if (sisr & CCSR_SSI_SISR_TDE1)
+	if (sisr & SSI_SISR_TDE1)
 		dbg->stats.tde1++;
 
-	if (sisr & CCSR_SSI_SISR_TDE0)
+	if (sisr & SSI_SISR_TDE0)
 		dbg->stats.tde0++;
 
-	if (sisr & CCSR_SSI_SISR_ROE1)
+	if (sisr & SSI_SISR_ROE1)
 		dbg->stats.roe1++;
 
-	if (sisr & CCSR_SSI_SISR_ROE0)
+	if (sisr & SSI_SISR_ROE0)
 		dbg->stats.roe0++;
 
-	if (sisr & CCSR_SSI_SISR_TUE1)
+	if (sisr & SSI_SISR_TUE1)
 		dbg->stats.tue1++;
 
-	if (sisr & CCSR_SSI_SISR_TUE0)
+	if (sisr & SSI_SISR_TUE0)
 		dbg->stats.tue0++;
 
-	if (sisr & CCSR_SSI_SISR_TFS)
+	if (sisr & SSI_SISR_TFS)
 		dbg->stats.tfs++;
 
-	if (sisr & CCSR_SSI_SISR_RFS)
+	if (sisr & SSI_SISR_RFS)
 		dbg->stats.rfs++;
 
-	if (sisr & CCSR_SSI_SISR_TLS)
+	if (sisr & SSI_SISR_TLS)
 		dbg->stats.tls++;
 
-	if (sisr & CCSR_SSI_SISR_RLS)
+	if (sisr & SSI_SISR_RLS)
 		dbg->stats.rls++;
 
-	if (sisr & CCSR_SSI_SISR_RFF1)
+	if (sisr & SSI_SISR_RFF1)
 		dbg->stats.rff1++;
 
-	if (sisr & CCSR_SSI_SISR_RFF0)
+	if (sisr & SSI_SISR_RFF0)
 		dbg->stats.rff0++;
 
-	if (sisr & CCSR_SSI_SISR_TFE1)
+	if (sisr & SSI_SISR_TFE1)
 		dbg->stats.tfe1++;
 
-	if (sisr & CCSR_SSI_SISR_TFE0)
+	if (sisr & SSI_SISR_TFE0)
 		dbg->stats.tfe0++;
 }
 
@@ -89,7 +89,7 @@ void fsl_ssi_dbg_isr(struct fsl_ssi_dbg *dbg, u32 sisr)
  */
 #define SIER_SHOW(flag, name) \
 	do { \
-		if (CCSR_SSI_SIER_##flag) \
+		if (SSI_SIER_##flag) \
 			seq_printf(s, #name "=%u\n", ssi_dbg->stats.name); \
 	} while (0)
 
-- 
2.7.4
