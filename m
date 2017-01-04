Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tv00g6VyCzDqN4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jan 2017 05:37:23 +1100 (AEDT)
From: Mark Brown <broonie@kernel.org>
To: Caleb Crome <caleb@crome.org>
Cc: Mark Brown <broonie@kernel.org>, Timur Tabi <timur@tabi.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Arnaud Mouiche <arnaud.mouiche@invoxia.com>
In-Reply-To: <1483467777-8651-1-git-send-email-caleb@signalessence.com>
Message-Id: <E1cOqQn-0001uf-Va@debutante>
Date: Wed, 04 Jan 2017 18:37:01 +0000
Subject: Applied "ASoC: fsl_ssi: set fifo watermark to more reliable value" to
 the asoc tree
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch

   ASoC: fsl_ssi: set fifo watermark to more reliable value

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 4ee437fbf626b5ad756889d8bc0fcead3d66dde7 Mon Sep 17 00:00:00 2001
From: Caleb Crome <caleb@crome.org>
Date: Tue, 3 Jan 2017 10:22:57 -0800
Subject: [PATCH] ASoC: fsl_ssi: set fifo watermark to more reliable value

The fsl_ssi fifo watermark is by default set to 2 free spaces (i.e.
activate DMA on FIFO when only 2 spaces are left.)  This means the
DMA must service the fifo within 2 audio samples, which is just not
enough time  for many use cases with high data rate.  In many
configurations the audio channel slips (causing l/r swap in stereo
configurations, or channel slipping in multi-channel configurations).

This patch gives more breathing room and allows the SSI to operate
reliably by changing the fifio refill watermark to 8.

There is no change in behavior for older chips (with an 8-deep fifo).
Only the newer chips with a 15-deep fifo get the new behavior. I
suspect a new fifo depth setting could be optimized on the older
chips too, but I have not tested.

Signed-off-by: Caleb Crome <caleb@crome.org>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 74 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 53 insertions(+), 21 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 50349437d961..fde08660b63b 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -224,6 +224,12 @@ struct fsl_ssi_soc_data {
  * @dbg_stats: Debugging statistics
  *
  * @soc: SoC specific data
+ *
+ * @fifo_watermark: the FIFO watermark setting.  Notifies DMA when
+ *             there are @fifo_watermark or fewer words in TX fifo or
+ *             @fifo_watermark or more empty words in RX fifo.
+ * @dma_maxburst: max number of words to transfer in one go.  So far,
+ *             this is always the same as fifo_watermark.
  */
 struct fsl_ssi_private {
 	struct regmap *regs;
@@ -263,6 +269,9 @@ struct fsl_ssi_private {
 
 	const struct fsl_ssi_soc_data *soc;
 	struct device *dev;
+
+	u32 fifo_watermark;
+	u32 dma_maxburst;
 };
 
 /*
@@ -1051,21 +1060,7 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 	regmap_write(regs, CCSR_SSI_SRCR, srcr);
 	regmap_write(regs, CCSR_SSI_SCR, scr);
 
-	/*
-	 * Set the watermark for transmit FIFI 0 and receive FIFO 0. We don't
-	 * use FIFO 1. We program the transmit water to signal a DMA transfer
-	 * if there are only two (or fewer) elements left in the FIFO. Two
-	 * elements equals one frame (left channel, right channel). This value,
-	 * however, depends on the depth of the transmit buffer.
-	 *
-	 * We set the watermark on the same level as the DMA burstsize.  For
-	 * fiq it is probably better to use the biggest possible watermark
-	 * size.
-	 */
-	if (ssi_private->use_dma)
-		wm = ssi_private->fifo_depth - 2;
-	else
-		wm = ssi_private->fifo_depth;
+	wm = ssi_private->fifo_watermark;
 
 	regmap_write(regs, CCSR_SSI_SFCSR,
 			CCSR_SSI_SFCSR_TFWM0(wm) | CCSR_SSI_SFCSR_RFWM0(wm) |
@@ -1373,12 +1368,8 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
 		dev_dbg(&pdev->dev, "could not get baud clock: %ld\n",
 			 PTR_ERR(ssi_private->baudclk));
 
-	/*
-	 * We have burstsize be "fifo_depth - 2" to match the SSI
-	 * watermark setting in fsl_ssi_startup().
-	 */
-	ssi_private->dma_params_tx.maxburst = ssi_private->fifo_depth - 2;
-	ssi_private->dma_params_rx.maxburst = ssi_private->fifo_depth - 2;
+	ssi_private->dma_params_tx.maxburst = ssi_private->dma_maxburst;
+	ssi_private->dma_params_rx.maxburst = ssi_private->dma_maxburst;
 	ssi_private->dma_params_tx.addr = ssi_private->ssi_phys + CCSR_SSI_STX0;
 	ssi_private->dma_params_rx.addr = ssi_private->ssi_phys + CCSR_SSI_SRX0;
 
@@ -1543,6 +1534,47 @@ static int fsl_ssi_probe(struct platform_device *pdev)
                 /* Older 8610 DTs didn't have the fifo-depth property */
 		ssi_private->fifo_depth = 8;
 
+	/*
+	 * Set the watermark for transmit FIFO 0 and receive FIFO 0. We don't
+	 * use FIFO 1 but set the watermark appropriately nontheless.
+	 * We program the transmit water to signal a DMA transfer
+	 * if there are N elements left in the FIFO. For chips with 15-deep
+	 * FIFOs, set watermark to 8.  This allows the SSI to operate at a
+	 * high data rate without channel slipping. Behavior is unchanged
+	 * for the older chips with a fifo depth of only 8.  A value of 4
+	 * might be appropriate for the older chips, but is left at
+	 * fifo_depth-2 until sombody has a chance to test.
+	 *
+	 * We set the watermark on the same level as the DMA burstsize.  For
+	 * fiq it is probably better to use the biggest possible watermark
+	 * size.
+	 */
+	switch (ssi_private->fifo_depth) {
+	case 15:
+		/*
+		 * 2 samples is not enough when running at high data
+		 * rates (like 48kHz @ 16 bits/channel, 16 channels)
+		 * 8 seems to split things evenly and leave enough time
+		 * for the DMA to fill the FIFO before it's over/under
+		 * run.
+		 */
+		ssi_private->fifo_watermark = 8;
+		ssi_private->dma_maxburst = 8;
+		break;
+	case 8:
+	default:
+		/*
+		 * maintain old behavior for older chips.
+		 * Keeping it the same because I don't have an older
+		 * board to test with.
+		 * I suspect this could be changed to be something to
+		 * leave some more space in the fifo.
+		 */
+		ssi_private->fifo_watermark = ssi_private->fifo_depth - 2;
+		ssi_private->dma_maxburst = ssi_private->fifo_depth - 2;
+		break;
+	}
+
 	dev_set_drvdata(&pdev->dev, ssi_private);
 
 	if (ssi_private->soc->imx) {
-- 
2.11.0
