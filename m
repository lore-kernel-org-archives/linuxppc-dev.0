Return-Path: <broonie@sirena.org.uk>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1FL43l2ZzDx6F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 22:00:12 +1100 (AEDT)
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Maciej S. Szmigiero <mail@maciej.szmigiero.name>,
 Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>,
 broonie@kernel.org, alsa-devel@alsa-project.org, kernel@pengutronix.de,
 lgirdwood@gmail.com, timur@tabi.org, caleb@crome.org,
 linux-kernel@vger.kernel.org, arnaud.mouiche@invoxia.com, lukma@denx.de,
 fabio.estevam@nxp.com, mail@maciej.szmigiero.name,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: fsl_ssi: Rename cpu_dai parameter to dai" to the asoc
 tree
In-Reply-To: <1513146874-25476-8-git-send-email-nicoleotsuka@gmail.com>
Message-Id: <E1eRFcy-0000wR-U5@debutante>
Date: Tue, 19 Dec 2017 11:00:04 +0000
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch

   ASoC: fsl_ssi: Rename cpu_dai parameter to dai

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

>From 0c884bed6ba743b8456c6eee4d599aaad6ffa008 Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Sun, 17 Dec 2017 18:52:06 -0800
Subject: [PATCH] ASoC: fsl_ssi: Rename cpu_dai parameter to dai

Shortens the variable name to save space, useful for dev_err outputs.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Acked-by: Timur Tabi <timur@tabi.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index eb9ac847bda3..237302fb9279 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -683,10 +683,10 @@ static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
  *       (In 2-channel I2S Master mode, slot_width is fixed 32)
  */
 static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
-			    struct snd_soc_dai *cpu_dai,
+			    struct snd_soc_dai *dai,
 			    struct snd_pcm_hw_params *hw_params)
 {
-	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(cpu_dai);
+	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(dai);
 	struct regmap *regs = ssi->regs;
 	int synchronous = ssi->cpu_dai_drv.symmetric_rates, ret;
 	u32 pm = 999, div2, psr, stccr, mask, afreq, factor, i;
@@ -716,7 +716,7 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 	 * never greater than 1/5 IPG clock rate
 	 */
 	if (freq * 5 > clk_get_rate(ssi->clk)) {
-		dev_err(cpu_dai->dev, "bitclk > ipgclk / 5\n");
+		dev_err(dai->dev, "bitclk > ipgclk / 5\n");
 		return -EINVAL;
 	}
 
@@ -765,7 +765,7 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 
 	/* No proper pm found if it is still remaining the initial value */
 	if (pm == 999) {
-		dev_err(cpu_dai->dev, "failed to handle the required sysclk\n");
+		dev_err(dai->dev, "failed to handle the required sysclk\n");
 		return -EINVAL;
 	}
 
@@ -781,7 +781,7 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 	if (!baudclk_is_used) {
 		ret = clk_set_rate(ssi->baudclk, baudrate);
 		if (ret) {
-			dev_err(cpu_dai->dev, "failed to set baudclk rate\n");
+			dev_err(dai->dev, "failed to set baudclk rate\n");
 			return -EINVAL;
 		}
 	}
@@ -802,9 +802,9 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
  */
 static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *hw_params,
-			     struct snd_soc_dai *cpu_dai)
+			     struct snd_soc_dai *dai)
 {
-	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(cpu_dai);
+	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(dai);
 	struct regmap *regs = ssi->regs;
 	unsigned int channels = params_channels(hw_params);
 	unsigned int sample_size = params_width(hw_params);
@@ -826,7 +826,7 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 		return 0;
 
 	if (fsl_ssi_is_i2s_master(ssi)) {
-		ret = fsl_ssi_set_bclk(substream, cpu_dai, hw_params);
+		ret = fsl_ssi_set_bclk(substream, dai, hw_params);
 		if (ret)
 			return ret;
 
@@ -864,7 +864,7 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 }
 
 static int fsl_ssi_hw_free(struct snd_pcm_substream *substream,
-			   struct snd_soc_dai *cpu_dai)
+			   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(rtd->cpu_dai);
@@ -1033,30 +1033,30 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 /**
  * Configure Digital Audio Interface (DAI) Format
  */
-static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
+static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
-	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(cpu_dai);
+	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(dai);
 
 	/* AC97 configured DAIFMT earlier in the probe() */
 	if (fsl_ssi_is_ac97(ssi))
 		return 0;
 
-	return _fsl_ssi_set_dai_fmt(cpu_dai->dev, ssi, fmt);
+	return _fsl_ssi_set_dai_fmt(dai->dev, ssi, fmt);
 }
 
 /**
  * Set TDM slot number and slot width
  */
-static int fsl_ssi_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
+static int fsl_ssi_set_dai_tdm_slot(struct snd_soc_dai *dai, u32 tx_mask,
 				    u32 rx_mask, int slots, int slot_width)
 {
-	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(cpu_dai);
+	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(dai);
 	struct regmap *regs = ssi->regs;
 	u32 val;
 
 	/* The word length should be 8, 10, 12, 16, 18, 20, 22 or 24 */
 	if (slot_width & 1 || slot_width < 8 || slot_width > 24) {
-		dev_err(cpu_dai->dev, "invalid slot width: %d\n", slot_width);
+		dev_err(dai->dev, "invalid slot width: %d\n", slot_width);
 		return -EINVAL;
 	}
 
@@ -1064,7 +1064,7 @@ static int fsl_ssi_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
 	regmap_read(regs, REG_SSI_SCR, &val);
 	val &= SSI_SCR_I2S_MODE_MASK | SSI_SCR_NET;
 	if (val && slots < 2) {
-		dev_err(cpu_dai->dev, "slot number should be >= 2 in I2S or NET\n");
+		dev_err(dai->dev, "slot number should be >= 2 in I2S or NET\n");
 		return -EINVAL;
 	}
 
-- 
2.15.1
