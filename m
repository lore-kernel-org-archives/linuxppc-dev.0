Return-Path: <broonie@sirena.org.uk>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znFHM41DBzDr7t
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 00:16:31 +1100 (AEDT)
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Caleb Crome <caleb@crome.org>,
 Maciej S. Szmigiero <mail@maciej.szmigiero.name>,
 Mark Brown <broonie@kernel.org>, timur@tabi.org, broonie@kernel.org,
 mail@maciej.szmigiero.name, alsa-devel@alsa-project.org, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, caleb@crome.org, lgirdwood@gmail.com,
 arnaud.mouiche@invoxia.com, lukma@denx.de, fabio.estevam@nxp.com,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: fsl_ssi: Add bool synchronous to mark synchronous
 mode" to the asoc tree
In-Reply-To: <1515990087-11598-16-git-send-email-nicoleotsuka@gmail.com>
Message-Id: <E1eoqjU-0006Ed-V7@debutante>
Date: Thu, 22 Feb 2018 13:16:20 +0000
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch

   ASoC: fsl_ssi: Add bool synchronous to mark synchronous mode

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From badc9595bc15686be3b01e3554421647de348df0 Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Mon, 12 Feb 2018 14:03:23 -0800
Subject: [PATCH] ASoC: fsl_ssi: Add bool synchronous to mark synchronous mode

Using symmetric_rates in the cpu_dai_drv is a bit implicit,
so this patch adds a bool synchronous instead.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index ed9102d91cf5..b58fabe77c6f 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -217,6 +217,7 @@ struct fsl_ssi_soc_data {
  * @dai_fmt: DAI configuration this device is currently used with
  * @streams: Mask of current active streams: BIT(TX) and BIT(RX)
  * @i2s_net: I2S and Network mode configurations of SCR register
+ * @synchronous: Use synchronous mode - both of TX and RX use STCK and SFCK
  * @use_dma: DMA is used or FIQ with stream filter
  * @use_dual_fifo: DMA with support for dual FIFO mode
  * @has_ipg_clk_name: If "ipg" is in the clock name list of device tree
@@ -262,6 +263,7 @@ struct fsl_ssi {
 	unsigned int dai_fmt;
 	u8 streams;
 	u8 i2s_net;
+	bool synchronous;
 	bool use_dma;
 	bool use_dual_fifo;
 	bool has_ipg_clk_name;
@@ -673,7 +675,6 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 	bool tx2, tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(dai);
 	struct regmap *regs = ssi->regs;
-	int synchronous = ssi->cpu_dai_drv.symmetric_rates, ret;
 	u32 pm = 999, div2, psr, stccr, mask, afreq, factor, i;
 	unsigned long clkrate, baudrate, tmprate;
 	unsigned int slots = params_channels(hw_params);
@@ -681,6 +682,7 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 	u64 sub, savesub = 100000;
 	unsigned int freq;
 	bool baudclk_is_used;
+	int ret;
 
 	/* Override slots and slot_width if being specifically set... */
 	if (ssi->slots)
@@ -759,7 +761,7 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 	mask = SSI_SxCCR_PM_MASK | SSI_SxCCR_DIV2 | SSI_SxCCR_PSR;
 
 	/* STCCR is used for RX in synchronous mode */
-	tx2 = tx || synchronous;
+	tx2 = tx || ssi->synchronous;
 	regmap_update_bits(regs, REG_SSI_SxCCR(tx2), mask, stccr);
 
 	if (!baudclk_is_used) {
@@ -807,7 +809,7 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 	 * that should set separate configurations for STCCR and SRCCR
 	 * despite running in the synchronous mode.
 	 */
-	if (enabled && ssi->cpu_dai_drv.symmetric_rates)
+	if (enabled && ssi->synchronous)
 		return 0;
 
 	if (fsl_ssi_is_i2s_master(ssi)) {
@@ -839,7 +841,7 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	/* In synchronous mode, the SSI uses STCCR for capture */
-	tx2 = tx || ssi->cpu_dai_drv.symmetric_rates;
+	tx2 = tx || ssi->synchronous;
 	regmap_update_bits(regs, REG_SSI_SxCCR(tx2), SSI_SxCCR_WL_MASK, wl);
 
 	return 0;
@@ -968,7 +970,7 @@ static int _fsl_ssi_set_dai_fmt(struct fsl_ssi *ssi, unsigned int fmt)
 	srcr = strcr;
 
 	/* Set SYN mode and clear RXDIR bit when using SYN or AC97 mode */
-	if (ssi->cpu_dai_drv.symmetric_rates || fsl_ssi_is_ac97(ssi)) {
+	if (ssi->synchronous || fsl_ssi_is_ac97(ssi)) {
 		srcr &= ~SSI_SRCR_RXDIR;
 		scr |= SSI_SCR_SYN;
 	}
@@ -1456,6 +1458,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		if (!fsl_ssi_is_ac97(ssi)) {
 			ssi->cpu_dai_drv.symmetric_rates = 1;
 			ssi->cpu_dai_drv.symmetric_samplebits = 1;
+			ssi->synchronous = true;
 		}
 
 		ssi->cpu_dai_drv.symmetric_channels = 1;
-- 
2.16.1
