Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zL8QK5X5yzF0Zj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jan 2018 10:17:29 +1100 (AEDT)
Received: by mail-pl0-x244.google.com with SMTP id d21so4724268pll.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jan 2018 15:17:29 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: timur@tabi.org,
	broonie@kernel.org,
	mail@maciej.szmigiero.name
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, lgirdwood@gmail.com, fabio.estevam@nxp.com,
 caleb@crome.org, arnaud.mouiche@invoxia.com, lukma@denx.de,
 kernel@pengutronix.de
Subject: [PATCH v4 06/17] ASoC: fsl_ssi: Clear FIFO directly in
 fsl_ssi_config()
Date: Mon, 15 Jan 2018 15:16:21 -0800
Message-Id: <1516058192-65519-7-git-send-email-nicoleotsuka@gmail.com>
In-Reply-To: <1516058192-65519-1-git-send-email-nicoleotsuka@gmail.com>
References: <1516058192-65519-1-git-send-email-nicoleotsuka@gmail.com>
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
---
Changelog
v3
 * Replaced "bool dir" with "int dir" and "int adir"
v2
 * Replaced bool tx with bool dir

 sound/soc/fsl/fsl_ssi.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index bbeef71..a2ac92f 100644
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
2.7.4
