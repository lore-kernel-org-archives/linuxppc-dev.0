Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgKRC5dcrzF0pP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 09:02:47 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id g2so8413524pgn.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 14:02:47 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: broonie@kernel.org,
	timur@tabi.org
Cc: caleb@crome.org, mail@maciej.szmigiero.name, fabio.estevam@nxp.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
 arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
Subject: [PATCH v6 06/17] ASoC: fsl_ssi: Clear FIFO directly in
 fsl_ssi_config()
Date: Mon, 12 Feb 2018 14:03:14 -0800
Message-Id: <1518473005-14090-7-git-send-email-nicoleotsuka@gmail.com>
In-Reply-To: <1518473005-14090-1-git-send-email-nicoleotsuka@gmail.com>
References: <1518473005-14090-1-git-send-email-nicoleotsuka@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The FIFO clear helper function is just one line of code now.
So it could be cleaned up by removing it and calling regmap
directly.

Meanwhile, FIFO clear could be applied to all use cases, not
confined to AC97. So this patch also moves FIFO clear in the
trigger() to fsl_ssi_config() and removes the AC97 check.

Note that SOR register is safe from offline_config HW limit.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 sound/soc/fsl/fsl_ssi.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 0d8c800..d276b78 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -410,17 +410,6 @@ static void fsl_ssi_rxtx_config(struct fsl_ssi *ssi, bool enable)
 }
 
 /**
- * Clear remaining data in the FIFO to avoid dirty data or channel slipping
- */
-static void fsl_ssi_fifo_clear(struct fsl_ssi *ssi, bool is_rx)
-{
-	bool tx = !is_rx;
-
-	regmap_update_bits(ssi->regs, REG_SSI_SOR,
-			   SSI_SOR_xX_CLR(tx), SSI_SOR_xX_CLR(tx));
-}
-
-/**
  * Exclude bits that are used by the opposite stream
  *
  * When both streams are active, disabling some bits for the current stream
@@ -446,10 +435,11 @@ static void fsl_ssi_fifo_clear(struct fsl_ssi *ssi, bool is_rx)
 static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 			   struct fsl_ssi_regvals *vals)
 {
-	int adir = (&ssi->regvals[TX] == vals) ? RX : TX;
-	int dir = (&ssi->regvals[TX] == vals) ? TX : RX;
+	bool tx = &ssi->regvals[TX] == vals;
 	struct regmap *regs = ssi->regs;
 	struct fsl_ssi_regvals *avals;
+	int adir = tx ? RX : TX;
+	int dir = tx ? TX : RX;
 	bool aactive;
 
 	/* Check if the opposite stream is active */
@@ -489,7 +479,9 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 
 	/* Online configure single direction while SSI is running */
 	if (enable) {
-		fsl_ssi_fifo_clear(ssi, vals->scr & SSI_SCR_RE);
+		/* Clear FIFO to prevent dirty data or channel slipping */
+		regmap_update_bits(ssi->regs, REG_SSI_SOR,
+				   SSI_SOR_xX_CLR(tx), SSI_SOR_xX_CLR(tx));
 
 		regmap_update_bits(regs, REG_SSI_SRCR, vals->srcr, vals->srcr);
 		regmap_update_bits(regs, REG_SSI_STCR, vals->stcr, vals->stcr);
@@ -511,6 +503,10 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 		regmap_update_bits(regs, REG_SSI_SRCR, srcr, 0);
 		regmap_update_bits(regs, REG_SSI_STCR, stcr, 0);
 		regmap_update_bits(regs, REG_SSI_SIER, sier, 0);
+
+		/* Clear FIFO to prevent dirty data or channel slipping */
+		regmap_update_bits(ssi->regs, REG_SSI_SOR,
+				   SSI_SOR_xX_CLR(tx), SSI_SOR_xX_CLR(tx));
 	}
 
 config_done:
@@ -1091,7 +1087,6 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(rtd->cpu_dai);
-	struct regmap *regs = ssi->regs;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -1116,14 +1111,6 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 		return -EINVAL;
 	}
 
-	/* Clear corresponding FIFO */
-	if (fsl_ssi_is_ac97(ssi)) {
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			regmap_write(regs, REG_SSI_SOR, SSI_SOR_TX_CLR);
-		else
-			regmap_write(regs, REG_SSI_SOR, SSI_SOR_RX_CLR);
-	}
-
 	return 0;
 }
 
-- 
2.1.4
