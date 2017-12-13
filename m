Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yxt1M4N5RzDsGN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Dec 2017 10:19:03 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id d23so2248976pfe.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 15:19:03 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, fabio.estevam@nxp.com, timur@tabi.org,
 mail@maciej.szmigiero.name, caleb@crome.org, lgirdwood@gmail.com,
 arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
Subject: [PATCH v3 07/11] ASoC: fsl_ssi: Rename cpu_dai parameter to dai
Date: Wed, 13 Dec 2017 15:18:24 -0800
Message-Id: <1513207108-30430-8-git-send-email-nicoleotsuka@gmail.com>
In-Reply-To: <1513207108-30430-1-git-send-email-nicoleotsuka@gmail.com>
References: <1513207108-30430-1-git-send-email-nicoleotsuka@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Shortens the variable name to save space, useful for dev_err outputs.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 sound/soc/fsl/fsl_ssi.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 7b6aedd..83d6e3d 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -668,10 +668,10 @@ static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
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
@@ -701,7 +701,7 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 	 * never greater than 1/5 IPG clock rate
 	 */
 	if (freq * 5 > clk_get_rate(ssi->clk)) {
-		dev_err(cpu_dai->dev, "bitclk > ipgclk / 5\n");
+		dev_err(dai->dev, "bitclk > ipgclk / 5\n");
 		return -EINVAL;
 	}
 
@@ -750,7 +750,7 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 
 	/* No proper pm found if it is still remaining the initial value */
 	if (pm == 999) {
-		dev_err(cpu_dai->dev, "failed to handle the required sysclk\n");
+		dev_err(dai->dev, "failed to handle the required sysclk\n");
 		return -EINVAL;
 	}
 
@@ -766,7 +766,7 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 	if (!baudclk_is_used) {
 		ret = clk_set_rate(ssi->baudclk, baudrate);
 		if (ret) {
-			dev_err(cpu_dai->dev, "failed to set baudclk rate\n");
+			dev_err(dai->dev, "failed to set baudclk rate\n");
 			return -EINVAL;
 		}
 	}
@@ -787,9 +787,9 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
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
@@ -811,7 +811,7 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 		return 0;
 
 	if (fsl_ssi_is_i2s_master(ssi)) {
-		ret = fsl_ssi_set_bclk(substream, cpu_dai, hw_params);
+		ret = fsl_ssi_set_bclk(substream, dai, hw_params);
 		if (ret)
 			return ret;
 
@@ -849,7 +849,7 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 }
 
 static int fsl_ssi_hw_free(struct snd_pcm_substream *substream,
-			   struct snd_soc_dai *cpu_dai)
+			   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(rtd->cpu_dai);
@@ -1018,30 +1018,30 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
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
 
@@ -1049,7 +1049,7 @@ static int fsl_ssi_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
 	regmap_read(regs, REG_SSI_SCR, &val);
 	val &= SSI_SCR_I2S_MODE_MASK | SSI_SCR_NET;
 	if (val && slots < 2) {
-		dev_err(cpu_dai->dev, "slot number should be >= 2 in I2S or NET\n");
+		dev_err(dai->dev, "slot number should be >= 2 in I2S or NET\n");
 		return -EINVAL;
 	}
 
-- 
2.1.4
