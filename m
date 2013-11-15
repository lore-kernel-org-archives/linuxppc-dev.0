Return-Path: <guangyu.chen@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0251.outbound.messaging.microsoft.com [213.199.154.251])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B6BC22C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Nov 2013 03:25:33 +1100 (EST)
From: Nicolin Chen <b42378@freescale.com>
To: <timur@tabi.org>, <broonie@kernel.org>, <linux@arm.linux.org.uk>
Subject: [PATCH v2] ASoC: fsl_ssi: Add monaural audio support for non-ac97
 interface
Date: Sat, 16 Nov 2013 00:25:29 +0800
Message-ID: <1384532729-6588-1-git-send-email-b42378@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The normal mode of SSI allows it to send/receive data to/from the first
slot of each period. So we can use this normal mode to trick I2S signal
by puting/getting data to/from the first slot only (the left channel)
so as to support monaural audio playback and recording.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
Changelog
v2:
 * Moved i2s_mode to ssi_private so that we can save and retore it as needed
 * And dropped the horrible static thing.

 sound/soc/fsl/fsl_ssi.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index f43be6d..cba5c4d 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -144,6 +144,7 @@ struct fsl_ssi_private {
 	bool imx_ac97;
 	bool use_dma;
 	bool use_dual_fifo;
+	u8 i2s_mode;
 	struct clk *clk;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
@@ -325,14 +326,13 @@ static irqreturn_t fsl_ssi_isr(int irq, void *dev_id)
 static int fsl_ssi_setup(struct fsl_ssi_private *ssi_private)
 {
 	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
-	u8 i2s_mode;
 	u8 wm;
 	int synchronous = ssi_private->cpu_dai_drv.symmetric_rates;
 
 	if (ssi_private->imx_ac97)
-		i2s_mode = CCSR_SSI_SCR_I2S_MODE_NORMAL | CCSR_SSI_SCR_NET;
+		ssi_private->i2s_mode = CCSR_SSI_SCR_I2S_MODE_NORMAL | CCSR_SSI_SCR_NET;
 	else
-		i2s_mode = CCSR_SSI_SCR_I2S_MODE_SLAVE;
+		ssi_private->i2s_mode = CCSR_SSI_SCR_I2S_MODE_SLAVE;
 
 	/*
 	 * Section 16.5 of the MPC8610 reference manual says that the SSI needs
@@ -349,7 +349,7 @@ static int fsl_ssi_setup(struct fsl_ssi_private *ssi_private)
 	write_ssi_mask(&ssi->scr,
 		CCSR_SSI_SCR_I2S_MODE_MASK | CCSR_SSI_SCR_SYN,
 		CCSR_SSI_SCR_TFR_CLK_DIS |
-		i2s_mode |
+		ssi_private->i2s_mode |
 		(synchronous ? CCSR_SSI_SCR_SYN : 0));
 
 	write_ssi(CCSR_SSI_STCR_TXBIT0 | CCSR_SSI_STCR_TFEN0 |
@@ -517,6 +517,7 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 {
 	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
 	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
+	unsigned int channels = params_channels(hw_params);
 	unsigned int sample_size =
 		snd_pcm_format_width(params_format(hw_params));
 	u32 wl = CCSR_SSI_SxCCR_WL(sample_size);
@@ -546,6 +547,11 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 	else
 		write_ssi_mask(&ssi->srccr, CCSR_SSI_SxCCR_WL_MASK, wl);
 
+	if (!ssi_private->imx_ac97)
+		write_ssi_mask(&ssi->scr,
+				CCSR_SSI_SCR_NET | CCSR_SSI_SCR_I2S_MODE_MASK,
+				channels == 1 ? 0 : ssi_private->i2s_mode);
+
 	return 0;
 }
 
@@ -658,14 +664,13 @@ static const struct snd_soc_dai_ops fsl_ssi_dai_ops = {
 static struct snd_soc_dai_driver fsl_ssi_dai_template = {
 	.probe = fsl_ssi_dai_probe,
 	.playback = {
-		/* The SSI does not support monaural audio. */
-		.channels_min = 2,
+		.channels_min = 1,
 		.channels_max = 2,
 		.rates = FSLSSI_I2S_RATES,
 		.formats = FSLSSI_I2S_FORMATS,
 	},
 	.capture = {
-		.channels_min = 2,
+		.channels_min = 1,
 		.channels_max = 2,
 		.rates = FSLSSI_I2S_RATES,
 		.formats = FSLSSI_I2S_FORMATS,
-- 
1.8.4
