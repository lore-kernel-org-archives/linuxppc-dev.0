Return-Path: <zidan.wang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0139.outbound.protection.outlook.com [157.56.110.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 34DEA1A0337
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 17:06:19 +1000 (AEST)
From: Zidan Wang <zidan.wang@freescale.com>
To: <nicoleotsuka@gmail.com>
Subject: [alsa-devel][PATCH 3/3] ASoC: fsl_sai: add 12kHz, 24kHz,
 176.4kHz and 192kHz sample rate support
Date: Tue, 12 May 2015 15:07:41 +0800
Message-ID: <ba023dc465f8e39f66714e68d5b27216ddbcfdbb.1431414110.git.zidan.wang@freescale.com>
In-Reply-To: <a60e5babb208b08fb4cd8188573606eb745cc1c4.1431414110.git.zidan.wang@freescale.com>
References: <a60e5babb208b08fb4cd8188573606eb745cc1c4.1431414110.git.zidan.wang@freescale.com>
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
---
 sound/soc/fsl/fsl_sai.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 88f5861..7efcac4 100644
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
@@ -531,7 +542,10 @@ static int fsl_sai_startup(struct snd_pcm_substream *substream,
 	regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx), FSL_SAI_CR3_TRCE,
 			   FSL_SAI_CR3_TRCE);
 
-	return 0;
+	ret = snd_pcm_hw_constraint_list(substream->runtime, 0,
+			SNDRV_PCM_HW_PARAM_RATE, &fsl_sai_rate_constraints);
+
+	return ret;
 }
 
 static void fsl_sai_shutdown(struct snd_pcm_substream *substream,
@@ -586,14 +600,18 @@ static struct snd_soc_dai_driver fsl_sai_dai = {
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
