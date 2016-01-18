Return-Path: <caleb@crome.org>
Received: from mail-pa0-x229.google.com (mail-pa0-x229.google.com
 [IPv6:2607:f8b0:400e:c03::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0E80A1A0CC1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jan 2016 05:37:45 +1100 (AEDT)
Received: by mail-pa0-x229.google.com with SMTP id uo6so423559848pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jan 2016 10:37:45 -0800 (PST)
From: Caleb Crome <caleb@crome.org>
To: timur@tabi.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: Caleb Crome <caleb@crome.org>
Subject: [PATCH] ASoC: fsl_ssi: Set watermark and maxburst settings to
 eliminate DMA xruns on imx processors
Date: Mon, 18 Jan 2016 10:36:45 -0800
Message-Id: <1453142205-83135-1-git-send-email-caleb@crome.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Change watermark settings for imx processors.  The previous setting
was fifo_depth-2, which causes silent but deadly xruns when using more
than 2 channels.  This patch sets the watermark & maxburst
settings to

DMA, imx processors: 4
DMA, mpc8610       : fifo_depth - 2
FIQ, all           : fifo_depth

This leaves mpc8610 with identically the same settings as before this
patch, and changes the IMX processors to have a watermark setting of
4, meaning when there are 4 or more empty spaces in the TX FIFO, to
start a DMA burst. And similarly, when there are 4 or more
filled spaces in the RX fifo, to start a DMA burst.

The tradeoff with this patch is that on IMX processors, the DMA will
be more reliable (not have DMA slips), epseically when running more
than 2 channels, at the expense of more DMA transactions.  Interrupt
frequency is unaffected.

Signed-off-by: Caleb Crome <caleb@crome.org>
---
 sound/soc/fsl/fsl_ssi.c | 54 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 21 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 95d2392..5080c29 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -220,6 +220,10 @@ struct fsl_ssi_soc_data {
  * @dbg_stats: Debugging statistics
  *
  * @soc: SoC specific data
+ *
+ * @fifo_watermark:  the fifo level to signal the DMA for more words
+ * @dma_maxburst:    the maximum number of words to send to the fifo
+ *                   in a DMA burst
  */
 struct fsl_ssi_private {
 	struct regmap *regs;
@@ -257,6 +261,9 @@ struct fsl_ssi_private {
 	struct fsl_ssi_dbg dbg_stats;
 
 	const struct fsl_ssi_soc_data *soc;
+
+	u32 fifo_watermark;
+	u32 dma_maxburst;
 };
 
 /*
@@ -985,21 +992,7 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
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
+	wm = ssi_private->soc.fifo_watermark;
 
 	regmap_write(regs, CCSR_SSI_SFCSR,
 			CCSR_SSI_SFCSR_TFWM0(wm) | CCSR_SSI_SFCSR_RFWM0(wm) |
@@ -1307,12 +1300,8 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
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
 
@@ -1465,6 +1454,29 @@ static int fsl_ssi_probe(struct platform_device *pdev)
                 /* Older 8610 DTs didn't have the fifo-depth property */
 		ssi_private->fifo_depth = 8;
 
+	if (ssi_private->use_dma) {
+		/*
+		 * using DMA, set both watermark & maxburst
+		 * imx parts need a value of 4 to keep up with the
+		 * fastest data rates.
+		 * older non-imx parts keep the old values of
+		 * fifo_depth-2.
+		 * maxburst must be <= fifo_watermark;
+		 * and must be even if dual fifo is used.
+		 */
+		if (ssi_private->soc->imx) {
+			ssi_private->fifo_watermark = 4;
+			ssi_private->dma_maxburst = 4;
+		} else {
+			ssi_private->fifo_watermark =
+				ssi_private->fifo_depth - 2;
+			ssi_private->dma_maxburst =
+				ssi_private->fifo_depth - 2;
+		}
+	} else
+		/* using FIQ.  Keep settings what they were originally */
+		ssi_private->fifo_watermark = ssi_private->fifo_depth;
+
 	dev_set_drvdata(&pdev->dev, ssi_private);
 
 	if (ssi_private->soc->imx) {
-- 
2.1.4
