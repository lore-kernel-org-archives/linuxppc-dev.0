Return-Path: <guangyu.chen@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0250.outbound.messaging.microsoft.com [213.199.154.250])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0292A2C007B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Dec 2013 21:37:54 +1100 (EST)
From: Nicolin Chen <b42378@freescale.com>
To: <broonie@kernel.org>, <timur@tabi.org>
Subject: [PATCH] ASoC: fsl_ssi: Implement symmetric_channels and
 symmetric_samplebits
Date: Tue, 3 Dec 2013 18:38:07 +0800
Message-ID: <1386067087-12243-1-git-send-email-b42378@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 lgirdwood@gmail.com, perex@perex.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since we introduced symmetric_channels and symmetric_samplebits, we implement
these two features to fsl_ssi so as to drop some no-more-needed code and make
the driver neat and clean.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 sound/soc/fsl/fsl_ssi.c | 79 ++++++-------------------------------------------
 1 file changed, 9 insertions(+), 70 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 90ff107..f9f4569 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -119,8 +119,6 @@ static inline void write_ssi_mask(u32 __iomem *addr, u32 clear, u32 set)
  * @ssi: pointer to the SSI's registers
  * @ssi_phys: physical address of the SSI registers
  * @irq: IRQ of this SSI
- * @first_stream: pointer to the stream that was opened first
- * @second_stream: pointer to second stream
  * @playback: the number of playback streams opened
  * @capture: the number of capture streams opened
  * @cpu_dai: the CPU DAI for this device
@@ -132,8 +130,6 @@ struct fsl_ssi_private {
 	struct ccsr_ssi __iomem *ssi;
 	dma_addr_t ssi_phys;
 	unsigned int irq;
-	struct snd_pcm_substream *first_stream;
-	struct snd_pcm_substream *second_stream;
 	unsigned int fifo_depth;
 	struct snd_soc_dai_driver cpu_dai_drv;
 	struct device_attribute dev_attr;
@@ -438,54 +434,13 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct fsl_ssi_private *ssi_private =
 		snd_soc_dai_get_drvdata(rtd->cpu_dai);
-	int synchronous = ssi_private->cpu_dai_drv.symmetric_rates;
 
-	/*
-	 * If this is the first stream opened, then request the IRQ
-	 * and initialize the SSI registers.
+	/* First, we only do fsl_ssi_setup() when SSI is going to be active.
+	 * Second, fsl_ssi_setup was already called by ac97_init earlier if
+	 * the driver is in ac97 mode.
 	 */
-	if (!ssi_private->first_stream) {
-		ssi_private->first_stream = substream;
-
-		/*
-		 * fsl_ssi_setup was already called by ac97_init earlier if
-		 * the driver is in ac97 mode.
-		 */
-		if (!ssi_private->imx_ac97)
-			fsl_ssi_setup(ssi_private);
-	} else {
-		if (synchronous) {
-			struct snd_pcm_runtime *first_runtime =
-				ssi_private->first_stream->runtime;
-			/*
-			 * This is the second stream open, and we're in
-			 * synchronous mode, so we need to impose sample
-			 * sample size constraints. This is because STCCR is
-			 * used for playback and capture in synchronous mode,
-			 * so there's no way to specify different word
-			 * lengths.
-			 *
-			 * Note that this can cause a race condition if the
-			 * second stream is opened before the first stream is
-			 * fully initialized.  We provide some protection by
-			 * checking to make sure the first stream is
-			 * initialized, but it's not perfect.  ALSA sometimes
-			 * re-initializes the driver with a different sample
-			 * rate or size.  If the second stream is opened
-			 * before the first stream has received its final
-			 * parameters, then the second stream may be
-			 * constrained to the wrong sample rate or size.
-			 */
-			if (first_runtime->sample_bits) {
-				snd_pcm_hw_constraint_minmax(substream->runtime,
-						SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
-				first_runtime->sample_bits,
-				first_runtime->sample_bits);
-			}
-		}
-
-		ssi_private->second_stream = substream;
-	}
+	if (!dai->active && !ssi_private->imx_ac97)
+		fsl_ssi_setup(ssi_private);
 
 	return 0;
 }
@@ -615,23 +570,6 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 	return 0;
 }
 
-/**
- * fsl_ssi_shutdown: shutdown the SSI
- *
- * Shutdown the SSI if there are no other substreams open.
- */
-static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
-			     struct snd_soc_dai *dai)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(rtd->cpu_dai);
-
-	if (ssi_private->first_stream == substream)
-		ssi_private->first_stream = ssi_private->second_stream;
-
-	ssi_private->second_stream = NULL;
-}
-
 static int fsl_ssi_dai_probe(struct snd_soc_dai *dai)
 {
 	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(dai);
@@ -647,7 +585,6 @@ static int fsl_ssi_dai_probe(struct snd_soc_dai *dai)
 static const struct snd_soc_dai_ops fsl_ssi_dai_ops = {
 	.startup	= fsl_ssi_startup,
 	.hw_params	= fsl_ssi_hw_params,
-	.shutdown	= fsl_ssi_shutdown,
 	.trigger	= fsl_ssi_trigger,
 };
 
@@ -722,7 +659,6 @@ static int fsl_ssi_ac97_trigger(struct snd_pcm_substream *substream, int cmd,
 
 static const struct snd_soc_dai_ops fsl_ssi_ac97_dai_ops = {
 	.startup	= fsl_ssi_startup,
-	.shutdown	= fsl_ssi_shutdown,
 	.trigger	= fsl_ssi_ac97_trigger,
 };
 
@@ -947,8 +883,11 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	}
 
 	/* Are the RX and the TX clocks locked? */
-	if (!of_find_property(np, "fsl,ssi-asynchronous", NULL))
+	if (!of_find_property(np, "fsl,ssi-asynchronous", NULL)) {
 		ssi_private->cpu_dai_drv.symmetric_rates = 1;
+		ssi_private->cpu_dai_drv.symmetric_channels = 1;
+		ssi_private->cpu_dai_drv.symmetric_samplebits = 1;
+	}
 
 	/* Determine the FIFO depth. */
 	iprop = of_get_property(np, "fsl,fifo-depth", NULL);
-- 
1.8.4
