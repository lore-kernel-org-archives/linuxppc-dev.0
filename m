Return-Path: <zidan.wang@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0147.outbound.protection.outlook.com [207.46.100.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CCFA61A0CE5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 23:35:52 +1100 (AEDT)
From: Zidan Wang <zidan.wang@freescale.com>
To: <timur@tabi.org>
Subject: [alsa-devel][PATCH 1/3] SoC: fsl_sai: add sai master mode support
Date: Tue, 20 Jan 2015 20:21:18 +0800
Message-ID: <1421756480-7055-2-git-send-email-zidan.wang@freescale.com>
In-Reply-To: <1421756480-7055-1-git-send-email-zidan.wang@freescale.com>
References: <1421756480-7055-1-git-send-email-zidan.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org, Zidan Wang <zidan.wang@freescale.com>,
 Xiubo.Lee@gmail.com, tiwai@suse.de, linux-kernel@vger.kernel.org,
 lgirdwood@gmail.com, perex@perex.cz, nicoleotsuka@gmail.com,
 broonie@kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When sai works on master mode, set its bit clock and frame clock.

SAI has 4 MCLK source, bus clock, MCLK1, MCLK2 and MCLK3. fsl_sai_set_bclk
will select proper MCLK source, then calculate and set the bit clock divider.

After fsl_sai_set_bclk, enable the selected mclk in hw_params(), and add
hw_free() to disable the mclk.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/fsl/fsl_sai.c | 110 +++++++++++++++++++++++++++++++++++++++++++++++-
 sound/soc/fsl/fsl_sai.h |   9 +++-
 2 files changed, 115 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index ec79c3d..499cbd9 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -251,12 +251,14 @@ static int fsl_sai_set_dai_fmt_tr(struct snd_soc_dai *cpu_dai,
 		val_cr4 |= FSL_SAI_CR4_FSD_MSTR;
 		break;
 	case SND_SOC_DAIFMT_CBM_CFM:
+		sai->is_slave_mode = true;
 		break;
 	case SND_SOC_DAIFMT_CBS_CFM:
 		val_cr2 |= FSL_SAI_CR2_BCD_MSTR;
 		break;
 	case SND_SOC_DAIFMT_CBM_CFS:
 		val_cr4 |= FSL_SAI_CR4_FSD_MSTR;
+		sai->is_slave_mode = true;
 		break;
 	default:
 		return -EINVAL;
@@ -288,6 +290,75 @@ static int fsl_sai_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 	return ret;
 }
 
+static int fsl_sai_set_bclk(struct snd_soc_dai *dai, bool tx, u32 freq)
+{
+	struct fsl_sai *sai = snd_soc_dai_get_drvdata(dai);
+	unsigned long clk_rate;
+	u32 savediv = 0, ratio, savesub = freq;
+	u32 id;
+	int ret = 0;
+
+	/* Don't apply to slave mode */
+	if (sai->is_slave_mode)
+		return 0;
+
+	for (id = 0; id < FSL_SAI_MCLK_MAX; id++) {
+		clk_rate = clk_get_rate(sai->mclk_clk[id]);
+		if (!clk_rate)
+			continue;
+
+		ratio = clk_rate / freq;
+
+		ret = clk_rate - ratio * freq;
+
+		/* Drop the source that can not be divided
+		 * into the required rate
+		 * */
+		if (ret != 0 && clk_rate / ret < 1000)
+			continue;
+
+		dev_dbg(dai->dev, "ratio %d for freq %dHz based on clock %ldHz\n",
+				ratio, freq, clk_rate);
+
+		if (ratio % 2 == 0 && ratio >= 2 && ratio <= 512)
+			ratio /= 2;
+		else
+			continue;
+
+		if (ret < savesub) {
+			savediv = ratio;
+			sai->mclk_id = id;
+			savesub = ret;
+		}
+
+		if (ret == 0)
+			break;
+	}
+
+	if (savediv == 0) {
+		dev_err(dai->dev, "failed to derive required %cx rate: %d\n",
+				tx ? 'T' : 'R', freq);
+		return -EINVAL;
+	}
+
+	if ((tx && sai->synchronous[TX]) || (!tx && !sai->synchronous[RX])) {
+		regmap_update_bits(sai->regmap, FSL_SAI_RCR2,
+			FSL_SAI_CR2_MSEL_MASK, FSL_SAI_CR2_MSEL(sai->mclk_id));
+		regmap_update_bits(sai->regmap, FSL_SAI_RCR2,
+			FSL_SAI_CR2_DIV_MASK, savediv - 1);
+	} else {
+		regmap_update_bits(sai->regmap, FSL_SAI_TCR2,
+			FSL_SAI_CR2_MSEL_MASK, FSL_SAI_CR2_MSEL(sai->mclk_id));
+		regmap_update_bits(sai->regmap, FSL_SAI_TCR2,
+			FSL_SAI_CR2_DIV_MASK, savediv - 1);
+	}
+
+	dev_dbg(dai->dev, "best fit: clock id=%d, div=%d, deviation =%d\n",
+			sai->mclk_id, savediv, savesub);
+
+	return 0;
+}
+
 static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params,
 		struct snd_soc_dai *cpu_dai)
@@ -297,6 +368,24 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 	unsigned int channels = params_channels(params);
 	u32 word_width = snd_pcm_format_width(params_format(params));
 	u32 val_cr4 = 0, val_cr5 = 0;
+	int ret;
+
+	if (!sai->is_slave_mode) {
+		ret = fsl_sai_set_bclk(cpu_dai, tx,
+			2 * word_width * params_rate(params));
+		if (ret)
+			return ret;
+
+		/* Do not enable the clock if it is already enabled */
+		if (!(sai->mclk_streams & BIT(substream->stream))) {
+			ret = clk_prepare_enable(sai->mclk_clk[sai->mclk_id]);
+			if (ret)
+				return ret;
+
+			sai->mclk_streams |= BIT(substream->stream);
+		}
+
+	}
 
 	if (!sai->is_dsp_mode)
 		val_cr4 |= FSL_SAI_CR4_SYWD(word_width);
@@ -322,6 +411,21 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int fsl_sai_hw_free(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *cpu_dai)
+{
+	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
+
+	if (!sai->is_slave_mode &&
+			sai->mclk_streams & BIT(substream->stream)) {
+		clk_disable_unprepare(sai->mclk_clk[sai->mclk_id]);
+		sai->mclk_streams &= ~BIT(substream->stream);
+	}
+
+	return 0;
+}
+
+
 static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
 		struct snd_soc_dai *cpu_dai)
 {
@@ -428,6 +532,7 @@ static const struct snd_soc_dai_ops fsl_sai_pcm_dai_ops = {
 	.set_sysclk	= fsl_sai_set_dai_sysclk,
 	.set_fmt	= fsl_sai_set_dai_fmt,
 	.hw_params	= fsl_sai_hw_params,
+	.hw_free	= fsl_sai_hw_free,
 	.trigger	= fsl_sai_trigger,
 	.startup	= fsl_sai_startup,
 	.shutdown	= fsl_sai_shutdown,
@@ -600,8 +705,9 @@ static int fsl_sai_probe(struct platform_device *pdev)
 		sai->bus_clk = NULL;
 	}
 
-	for (i = 0; i < FSL_SAI_MCLK_MAX; i++) {
-		sprintf(tmp, "mclk%d", i + 1);
+	sai->mclk_clk[0] = sai->bus_clk;
+	for (i = 1; i < FSL_SAI_MCLK_MAX; i++) {
+		sprintf(tmp, "mclk%d", i);
 		sai->mclk_clk[i] = devm_clk_get(&pdev->dev, tmp);
 		if (IS_ERR(sai->mclk_clk[i])) {
 			dev_err(&pdev->dev, "failed to get mclk%d clock: %ld\n",
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index 3466720..2d8c830 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -72,13 +72,15 @@
 
 /* SAI Transmit and Recieve Configuration 2 Register */
 #define FSL_SAI_CR2_SYNC	BIT(30)
-#define FSL_SAI_CR2_MSEL_MASK	(0xff << 26)
+#define FSL_SAI_CR2_MSEL_MASK	(0x3 << 26)
 #define FSL_SAI_CR2_MSEL_BUS	0
 #define FSL_SAI_CR2_MSEL_MCLK1	BIT(26)
 #define FSL_SAI_CR2_MSEL_MCLK2	BIT(27)
 #define FSL_SAI_CR2_MSEL_MCLK3	(BIT(26) | BIT(27))
+#define FSL_SAI_CR2_MSEL(ID)	((ID) << 26)
 #define FSL_SAI_CR2_BCP		BIT(25)
 #define FSL_SAI_CR2_BCD_MSTR	BIT(24)
+#define FSL_SAI_CR2_DIV_MASK	0xff
 
 /* SAI Transmit and Recieve Configuration 3 Register */
 #define FSL_SAI_CR3_TRCE	BIT(16)
@@ -120,7 +122,7 @@
 #define FSL_SAI_CLK_MAST2	2
 #define FSL_SAI_CLK_MAST3	3
 
-#define FSL_SAI_MCLK_MAX	3
+#define FSL_SAI_MCLK_MAX	4
 
 /* SAI data transfer numbers per DMA request */
 #define FSL_SAI_MAXBURST_TX 6
@@ -133,10 +135,13 @@ struct fsl_sai {
 	struct clk *mclk_clk[FSL_SAI_MCLK_MAX];
 
 	bool is_lsb_first;
+	bool is_slave_mode;
 	bool is_dsp_mode;
 	bool sai_on_imx;
 	bool synchronous[2];
 
+	unsigned int mclk_id;
+	unsigned int mclk_streams;
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 };
-- 
1.9.1
