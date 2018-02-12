Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgKRQ25ljzF0pv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 09:02:58 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id t4so7362347pgp.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 14:02:58 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: broonie@kernel.org,
	timur@tabi.org
Cc: caleb@crome.org, mail@maciej.szmigiero.name, fabio.estevam@nxp.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
 arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
Subject: [PATCH v6 15/17] ASoC: fsl_ssi: Add bool synchronous to mark
 synchronous mode
Date: Mon, 12 Feb 2018 14:03:23 -0800
Message-Id: <1518473005-14090-16-git-send-email-nicoleotsuka@gmail.com>
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

Using symmetric_rates in the cpu_dai_drv is a bit implicit,
so this patch adds a bool synchronous instead.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 sound/soc/fsl/fsl_ssi.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index ed9102d..b58fabe 100644
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
2.1.4
