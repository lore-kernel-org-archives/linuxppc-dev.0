Return-Path: <zidan.wang@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0103.outbound.protection.outlook.com [207.46.100.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 10E3E1A038D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 17:11:54 +1000 (AEST)
From: Zidan Wang <zidan.wang@freescale.com>
To: <nicoleotsuka@gmail.com>
Subject: [alsa-devel][PATCH v2 3/3] ASoC: fsl_sai: add 12kHz, 24kHz,
 176.4kHz and 192kHz sample rate support
Date: Wed, 13 May 2015 15:13:01 +0800
Message-ID: <595fdd29d0a202e8e18cf2ab828ff81c81bafaac.1431500729.git.zidan.wang@freescale.com>
In-Reply-To: <e6293a2408ccd8390fa2999df2af26b6de20f933.1431500729.git.zidan.wang@freescale.com>
References: <e6293a2408ccd8390fa2999df2af26b6de20f933.1431500729.git.zidan.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org, timur@tabi.org,
 Zidan Wang <zidan.wang@freescale.com>, Xiubo.Lee@gmail.com, tiwai@suse.de,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com, perex@perex.cz,
 broonie@kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Normally we don't support 12kHz, 24kHz in audio driver, alsa didn't
have formal definition of 12kHz, 24kHz, but alsa supply a way to
support these sample rates. And add 176.4kHz and 192kHz support.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_sai.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 7624dd0..640bd5b 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -27,6 +27,17 @@
 #define FSL_SAI_FLAGS (FSL_SAI_CSR_SEIE |\
 		       FSL_SAI_CSR_FEIE)
 
+static u32 fsl_sai_rates[] = {
+	8000, 11025, 12000, 16000, 22050,
+	24000, 32000, 44100, 48000, 64000,
+	88200, 96000, 176400, 192000
+};
+
+static struct snd_pcm_hw_constraint_list fsl_sai_rate_constraints = {
+	.count = ARRAY_SIZE(fsl_sai_rates),
+	.list = fsl_sai_rates,
+};
+
 static irqreturn_t fsl_sai_isr(int irq, void *devid)
 {
 	struct fsl_sai *sai = (struct fsl_sai *)devid;
@@ -540,7 +551,10 @@ static int fsl_sai_startup(struct snd_pcm_substream *substream,
 	regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx), FSL_SAI_CR3_TRCE,
 			   FSL_SAI_CR3_TRCE);
 
-	return 0;
+	ret = snd_pcm_hw_constraint_list(substream->runtime, 0,
+			SNDRV_PCM_HW_PARAM_RATE, &fsl_sai_rate_constraints);
+
+	return ret;
 }
 
 static void fsl_sai_shutdown(struct snd_pcm_substream *substream,
@@ -595,14 +609,18 @@ static struct snd_soc_dai_driver fsl_sai_dai = {
 		.stream_name = "CPU-Playback",
 		.channels_min = 1,
 		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000_96000,
+		.rate_min = 8000,
+		.rate_max = 192000,
+		.rates = SNDRV_PCM_RATE_KNOT,
 		.formats = FSL_SAI_FORMATS,
 	},
 	.capture = {
 		.stream_name = "CPU-Capture",
 		.channels_min = 1,
 		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000_96000,
+		.rate_min = 8000,
+		.rate_max = 192000,
+		.rates = SNDRV_PCM_RATE_KNOT,
 		.formats = FSL_SAI_FORMATS,
 	},
 	.ops = &fsl_sai_pcm_dai_ops,
-- 
1.9.1
