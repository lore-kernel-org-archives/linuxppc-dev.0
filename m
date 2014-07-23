Return-Path: <nicoleotsuka@gmail.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0203.outbound.protection.outlook.com [207.46.163.203])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A93F41A03F4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 21:21:27 +1000 (EST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: <broonie@kernel.org>
Subject: [PATCH 1/3] ASoC: fsl_sai: Reduce race condition during TE/RE enabling
Date: Wed, 23 Jul 2014 19:23:38 +0800
Message-ID: <3eb17601f37a686322db6fdf0a6749a592a751e8.1406113865.git.nicoleotsuka@gmail.com>
In-Reply-To: <cover.1406113865.git.nicoleotsuka@gmail.com>
References: <cover.1406113865.git.nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org, b42378@freescale.com, b02247@freescale.com,
 linux-kernel@vger.kernel.org, timur@tabi.org, Li.Xiubo@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Nicolin Chen <Guangyu.Chen@freescale.com>

For trigger start, we don't need to check if it's the first time to
enable TE/RE or second time. It doesn't hurt to enable them any way,
which in the meantime can reduce race condition for TE/RE enabling.

For trigger stop, we will definitely clear FRDE of current direction.
Thus the driver only needs to read the opposite one's.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_sai.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 1b6ee2c..a437899 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -327,7 +327,7 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
 {
 	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
 	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
-	u32 tcsr, rcsr;
+	u32 xcsr;
 
 	/*
 	 * The transmitter bit clock and frame sync are to be
@@ -338,9 +338,6 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
 	regmap_update_bits(sai->regmap, FSL_SAI_RCR2, FSL_SAI_CR2_SYNC,
 			   FSL_SAI_CR2_SYNC);
 
-	regmap_read(sai->regmap, FSL_SAI_TCSR, &tcsr);
-	regmap_read(sai->regmap, FSL_SAI_RCSR, &rcsr);
-
 	/*
 	 * It is recommended that the transmitter is the last enabled
 	 * and the first disabled.
@@ -349,12 +346,10 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		if (!(tcsr & FSL_SAI_CSR_FRDE || rcsr & FSL_SAI_CSR_FRDE)) {
-			regmap_update_bits(sai->regmap, FSL_SAI_RCSR,
-					   FSL_SAI_CSR_TERE, FSL_SAI_CSR_TERE);
-			regmap_update_bits(sai->regmap, FSL_SAI_TCSR,
-					   FSL_SAI_CSR_TERE, FSL_SAI_CSR_TERE);
-		}
+		regmap_update_bits(sai->regmap, FSL_SAI_RCSR,
+				   FSL_SAI_CSR_TERE, FSL_SAI_CSR_TERE);
+		regmap_update_bits(sai->regmap, FSL_SAI_TCSR,
+				   FSL_SAI_CSR_TERE, FSL_SAI_CSR_TERE);
 
 		regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx),
 				   FSL_SAI_CSR_xIE_MASK, FSL_SAI_FLAGS);
@@ -370,7 +365,8 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
 				   FSL_SAI_CSR_xIE_MASK, 0);
 
 		/* Check if the opposite FRDE is also disabled */
-		if (!(tx ? rcsr & FSL_SAI_CSR_FRDE : tcsr & FSL_SAI_CSR_FRDE)) {
+		regmap_read(sai->regmap, FSL_SAI_xCSR(!tx), &xcsr);
+		if (!(xcsr & FSL_SAI_CSR_FRDE)) {
 			/* Disable both directions and reset their FIFOs */
 			regmap_update_bits(sai->regmap, FSL_SAI_TCSR,
 					   FSL_SAI_CSR_TERE | FSL_SAI_CSR_FR,
-- 
1.8.4
