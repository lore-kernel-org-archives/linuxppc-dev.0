Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHGZD6ZdXzF0XR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 17:44:20 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id m26so874286pfj.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 22:44:20 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: timur@tabi.org,
	broonie@kernel.org,
	mail@maciej.szmigiero.name
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, lgirdwood@gmail.com, fabio.estevam@nxp.com,
 caleb@crome.org, arnaud.mouiche@invoxia.com, lukma@denx.de,
 kernel@pengutronix.de
Subject: [PATCH v2 14/16] ASoC: fsl_ssi: Remove cpu_dai_drv from fsl_ssi
 structure
Date: Wed, 10 Jan 2018 22:43:13 -0800
Message-Id: <1515652995-15996-15-git-send-email-nicoleotsuka@gmail.com>
In-Reply-To: <1515652995-15996-1-git-send-email-nicoleotsuka@gmail.com>
References: <1515652995-15996-1-git-send-email-nicoleotsuka@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The cpu_dai_drv is only used for symmetric_rates. So this patch replaces
it with a synchronous boolean flag.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
---
 sound/soc/fsl/fsl_ssi.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 213962a..716603c 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -208,11 +208,11 @@ struct fsl_ssi_soc_data {
  *
  * @regs: Pointer to the regmap registers
  * @irq: IRQ of this SSI
- * @cpu_dai_drv: CPU DAI driver for this device
  *
  * @dai_fmt: DAI configuration this device is currently used with
  * @streams: Mask of current active streams: BIT(TX) and BIT(RX)
  * @i2s_net: I2S and Network mode configurations of SCR register
+ * @synchronous: Use synchronous mode - both of TX and RX use STCK and SFCK
  * @use_dma: DMA is used or FIQ with stream filter
  * @use_dual_fifo: DMA with support for dual FIFO mode
  * @has_ipg_clk_name: If "ipg" is in the clock name list of device tree
@@ -253,11 +253,11 @@ struct fsl_ssi_soc_data {
 struct fsl_ssi {
 	struct regmap *regs;
 	int irq;
-	struct snd_soc_dai_driver cpu_dai_drv;
 
 	unsigned int dai_fmt;
 	u8 streams;
 	u8 i2s_net;
+	bool synchronous;
 	bool use_dma;
 	bool use_dual_fifo;
 	bool has_ipg_clk_name;
@@ -668,7 +668,6 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 	bool tx2, tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(dai);
 	struct regmap *regs = ssi->regs;
-	int synchronous = ssi->cpu_dai_drv.symmetric_rates, ret;
 	u32 pm = 999, div2, psr, stccr, mask, afreq, factor, i;
 	unsigned long clkrate, baudrate, tmprate;
 	unsigned int slots = params_channels(hw_params);
@@ -676,6 +675,7 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 	u64 sub, savesub = 100000;
 	unsigned int freq;
 	bool baudclk_is_used;
+	int ret;
 
 	/* Override slots and slot_width if being specifically set... */
 	if (ssi->slots)
@@ -754,7 +754,7 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 	mask = SSI_SxCCR_PM_MASK | SSI_SxCCR_DIV2 | SSI_SxCCR_PSR;
 
 	/* STCCR is used for RX in synchronous mode */
-	tx2 = tx || synchronous;
+	tx2 = tx || ssi->synchronous;
 	regmap_update_bits(regs, REG_SSI_SxCCR(tx2), mask, stccr);
 
 	if (!baudclk_is_used) {
@@ -802,7 +802,7 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 	 * that should set separate configurations for STCCR and SRCCR
 	 * despite running in the synchronous mode.
 	 */
-	if (enabled && ssi->cpu_dai_drv.symmetric_rates)
+	if (enabled && ssi->synchronous)
 		return 0;
 
 	if (fsl_ssi_is_i2s_master(ssi)) {
@@ -834,7 +834,7 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	/* In synchronous mode, the SSI uses STCCR for capture */
-	tx2 = tx || ssi->cpu_dai_drv.symmetric_rates;
+	tx2 = tx || ssi->synchronous;
 	regmap_update_bits(regs, REG_SSI_SxCCR(tx2), SSI_SxCCR_WL_MASK, wl);
 
 	return 0;
@@ -959,7 +959,7 @@ static int _fsl_ssi_set_dai_fmt(struct fsl_ssi *ssi, unsigned int fmt)
 	srcr = strcr;
 
 	/* Set SYN mode and clear RXDIR bit when using SYN or AC97 mode */
-	if (ssi->cpu_dai_drv.symmetric_rates || fsl_ssi_is_ac97(ssi)) {
+	if (ssi->synchronous || fsl_ssi_is_ac97(ssi)) {
 		srcr &= ~SSI_SRCR_RXDIR;
 		scr |= SSI_SCR_SYN;
 	}
@@ -1360,6 +1360,7 @@ static void fsl_ssi_imx_clean(struct platform_device *pdev, struct fsl_ssi *ssi)
 
 static int fsl_ssi_probe(struct platform_device *pdev)
 {
+	struct snd_soc_dai_driver *cpu_dai_drv;
 	struct fsl_ssi *ssi;
 	int ret = 0;
 	struct device_node *np = pdev->dev.of_node;
@@ -1394,14 +1395,12 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	ssi->use_dma = !of_property_read_bool(np, "fsl,fiq-stream-filter");
 
 	if (fsl_ssi_is_ac97(ssi)) {
-		memcpy(&ssi->cpu_dai_drv, &fsl_ssi_ac97_dai,
-		       sizeof(fsl_ssi_ac97_dai));
+		cpu_dai_drv = &fsl_ssi_ac97_dai;
 		fsl_ac97_data = ssi;
 	} else {
-		memcpy(&ssi->cpu_dai_drv, &fsl_ssi_dai_template,
-		       sizeof(fsl_ssi_dai_template));
+		cpu_dai_drv = &fsl_ssi_dai_template;
 	}
-	ssi->cpu_dai_drv.name = dev_name(dev);
+	cpu_dai_drv->name = dev_name(dev);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	iomem = devm_ioremap_resource(dev, res);
@@ -1439,11 +1438,12 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	/* Set software limitations for synchronous mode */
 	if (!of_find_property(np, "fsl,ssi-asynchronous", NULL)) {
 		if (!fsl_ssi_is_ac97(ssi)) {
-			ssi->cpu_dai_drv.symmetric_rates = 1;
-			ssi->cpu_dai_drv.symmetric_samplebits = 1;
+			cpu_dai_drv->symmetric_rates = 1;
+			cpu_dai_drv->symmetric_samplebits = 1;
+			ssi->synchronous = true;
 		}
 
-		ssi->cpu_dai_drv.symmetric_channels = 1;
+		cpu_dai_drv->symmetric_channels = 1;
 	}
 
 	/* Fetch FIFO depth; Set to 8 for older DT without this property */
@@ -1498,7 +1498,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_snd_soc_register_component(dev, &fsl_ssi_component,
-					      &ssi->cpu_dai_drv, 1);
+					      cpu_dai_drv, 1);
 	if (ret) {
 		dev_err(dev, "failed to register DAI: %d\n", ret);
 		goto error_asoc_register;
-- 
2.7.4
