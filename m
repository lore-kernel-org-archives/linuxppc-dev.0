Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vi37-28-154-113.vibiznes.pl [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3511A1A0144
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Sep 2015 01:11:59 +1000 (AEST)
Message-ID: <55E46EA7.2020004@maciej.szmigiero.name>
Date: Mon, 31 Aug 2015 17:11:35 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
MIME-Version: 1.0
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>,
 Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/2] ASoC: fsl-asoc-card: add AC'97 support
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add AC'97 support to fsl-asoc-card using generic
ASoC AC'97 CODEC.

The SSI controller will silently enable any TX
AC'97 slots that have their bits set in SLOTREQ
received from CODEC and then will redirect some
of playback samples there.

That's why it is important to make sure that
any of CODEC playback slots that can pull samples
are set to slots 3/4 (standard PCM playback slots).
Currently, this applies to S/PDIF slots as they
were seen to pull samples sometimes even with
S/PDIF output being disabled.

Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>
---
 .../devicetree/bindings/sound/fsl-asoc-card.txt    |   10 +-
 sound/soc/fsl/fsl-asoc-card.c                      |  145 +++++++++++++++----
 2 files changed, 120 insertions(+), 35 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
index a96774c..ce55c0a 100644
--- a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
+++ b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
@@ -13,13 +13,15 @@ So having this generic sound card allows all Freescale SoC users to benefit
 from the simplification of a new card support and the capability of the wide
 sample rates support through ASRC.
 
-Note: The card is initially designed for those sound cards who use I2S and
-      PCM DAI formats. However, it'll be also possible to support those non
-      I2S/PCM type sound cards, such as S/PDIF audio and HDMI audio, as long
-      as the driver has been properly upgraded.
+Note: The card is initially designed for those sound cards who use AC'97, I2S
+      and PCM DAI formats. However, it'll be also possible to support those non
+      AC'97/I2S/PCM type sound cards, such as S/PDIF audio and HDMI audio, as
+      long as the driver has been properly upgraded.
 
 
 The compatible list for this generic sound card currently:
+ "fsl,imx-audio-ac97"
+
  "fsl,imx-audio-cs42888"
 
  "fsl,imx-audio-wm8962"
diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 96f55ae..385a9f8 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -14,6 +14,9 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
+#if IS_ENABLED(CONFIG_SND_AC97_CODEC)
+#include <sound/ac97_codec.h>
+#endif
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 
@@ -115,6 +118,11 @@ static const struct snd_soc_dapm_widget fsl_asoc_card_dapm_widgets[] = {
 	SND_SOC_DAPM_MIC("DMIC", NULL),
 };
 
+static bool fsl_asoc_card_is_ac97(struct fsl_asoc_card_priv *priv)
+{
+	return priv->dai_fmt == SND_SOC_DAIFMT_AC97;
+}
+
 static int fsl_asoc_card_hw_params(struct snd_pcm_substream *substream,
 				   struct snd_pcm_hw_params *params)
 {
@@ -133,7 +141,9 @@ static int fsl_asoc_card_hw_params(struct snd_pcm_substream *substream,
 	 * set_bias_level(), bypass the remaining settings in hw_params().
 	 * Note: (dai_fmt & CBM_CFM) includes CBM_CFM and CBM_CFS.
 	 */
-	if (priv->card.set_bias_level && priv->dai_fmt & SND_SOC_DAIFMT_CBM_CFM)
+	if ((priv->card.set_bias_level &&
+	     priv->dai_fmt & SND_SOC_DAIFMT_CBM_CFM) ||
+	    fsl_asoc_card_is_ac97(priv))
 		return 0;
 
 	/* Specific configurations of DAIs starts from here */
@@ -300,7 +310,7 @@ static int fsl_asoc_card_audmux_init(struct device_node *np,
 	ext_port--;
 
 	/*
-	 * Use asynchronous mode (6 wires) for all cases.
+	 * Use asynchronous mode (6 wires) for all cases except AC97.
 	 * If only 4 wires are needed, just set SSI into
 	 * synchronous mode and enable 4 PADs in IOMUX.
 	 */
@@ -346,15 +356,30 @@ static int fsl_asoc_card_audmux_init(struct device_node *np,
 			   IMX_AUDMUX_V2_PTCR_TCLKDIR;
 		break;
 	default:
-		return -EINVAL;
+		if (!fsl_asoc_card_is_ac97(priv))
+			return -EINVAL;
+	}
+
+	if (fsl_asoc_card_is_ac97(priv)) {
+		int_ptcr = IMX_AUDMUX_V2_PTCR_SYN |
+			   IMX_AUDMUX_V2_PTCR_TCSEL(ext_port) |
+			   IMX_AUDMUX_V2_PTCR_TCLKDIR;
+		ext_ptcr = IMX_AUDMUX_V2_PTCR_SYN |
+			   IMX_AUDMUX_V2_PTCR_TFSEL(int_port) |
+			   IMX_AUDMUX_V2_PTCR_TFSDIR;
 	}
 
 	/* Asynchronous mode can not be set along with RCLKDIR */
-	ret = imx_audmux_v2_configure_port(int_port, 0,
-					   IMX_AUDMUX_V2_PDCR_RXDSEL(ext_port));
-	if (ret) {
-		dev_err(dev, "audmux internal port setup failed\n");
-		return ret;
+	if (!fsl_asoc_card_is_ac97(priv)) {
+		unsigned int pdcr =
+				IMX_AUDMUX_V2_PDCR_RXDSEL(ext_port);
+
+		ret = imx_audmux_v2_configure_port(int_port, 0,
+						   pdcr);
+		if (ret) {
+			dev_err(dev, "audmux internal port setup failed\n");
+			return ret;
+		}
 	}
 
 	ret = imx_audmux_v2_configure_port(int_port, int_ptcr,
@@ -364,11 +389,16 @@ static int fsl_asoc_card_audmux_init(struct device_node *np,
 		return ret;
 	}
 
-	ret = imx_audmux_v2_configure_port(ext_port, 0,
-					   IMX_AUDMUX_V2_PDCR_RXDSEL(int_port));
-	if (ret) {
-		dev_err(dev, "audmux external port setup failed\n");
-		return ret;
+	if (!fsl_asoc_card_is_ac97(priv)) {
+		unsigned int pdcr =
+				IMX_AUDMUX_V2_PDCR_RXDSEL(int_port);
+
+		ret = imx_audmux_v2_configure_port(ext_port, 0,
+						   pdcr);
+		if (ret) {
+			dev_err(dev, "audmux external port setup failed\n");
+			return ret;
+		}
 	}
 
 	ret = imx_audmux_v2_configure_port(ext_port, ext_ptcr,
@@ -389,6 +419,23 @@ static int fsl_asoc_card_late_probe(struct snd_soc_card *card)
 	struct device *dev = card->dev;
 	int ret;
 
+	if (fsl_asoc_card_is_ac97(priv)) {
+#if IS_ENABLED(CONFIG_SND_AC97_CODEC)
+		struct snd_soc_codec *codec = card->rtd[0].codec;
+		struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
+
+		/*
+		 * Use slots 3/4 for S/PDIF so SSI won't try to enable
+		 * other slots and send some samples there
+		 * due to SLOTREQ bits for S/PDIF received from codec
+		 */
+		snd_ac97_update_bits(ac97, AC97_EXTENDED_STATUS,
+				     AC97_EA_SPSA_SLOT_MASK, AC97_EA_SPSA_3_4);
+#endif
+
+		return 0;
+	}
+
 	ret = snd_soc_dai_set_sysclk(codec_dai, codec_priv->mclk_id,
 				     codec_priv->mclk_freq, SND_SOC_CLOCK_IN);
 	if (ret) {
@@ -404,10 +451,9 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	struct device_node *cpu_np, *codec_np, *asrc_np;
 	struct device_node *np = pdev->dev.of_node;
 	struct platform_device *asrc_pdev = NULL;
-	struct platform_device *cpu_pdev;
+	struct platform_device *cpu_pdev, *codec_pdev;
 	struct fsl_asoc_card_priv *priv;
-	struct i2c_client *codec_dev;
-	struct clk *codec_clk;
+	struct i2c_client *codec_i2c_dev;
 	const char *codec_dai_name;
 	u32 width;
 	int ret;
@@ -420,9 +466,8 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	/* Give a chance to old DT binding */
 	if (!cpu_np)
 		cpu_np = of_parse_phandle(np, "ssi-controller", 0);
-	codec_np = of_parse_phandle(np, "audio-codec", 0);
-	if (!cpu_np || !codec_np) {
-		dev_err(&pdev->dev, "phandle missing or invalid\n");
+	if (!cpu_np) {
+		dev_err(&pdev->dev, "CPU phandle missing or invalid\n");
 		ret = -EINVAL;
 		goto fail;
 	}
@@ -434,11 +479,13 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
-	codec_dev = of_find_i2c_device_by_node(codec_np);
-	if (!codec_dev) {
-		dev_err(&pdev->dev, "failed to find codec platform device\n");
-		ret = -EINVAL;
-		goto fail;
+	codec_np = of_parse_phandle(np, "audio-codec", 0);
+	if (codec_np) {
+		codec_pdev = of_find_device_by_node(codec_np);
+		codec_i2c_dev = of_find_i2c_device_by_node(codec_np);
+	} else {
+		codec_pdev = NULL;
+		codec_i2c_dev = NULL;
 	}
 
 	asrc_np = of_parse_phandle(np, "audio-asrc", 0);
@@ -446,10 +493,13 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 		asrc_pdev = of_find_device_by_node(asrc_np);
 
 	/* Get the MCLK rate only, and leave it controlled by CODEC drivers */
-	codec_clk = clk_get(&codec_dev->dev, NULL);
-	if (!IS_ERR(codec_clk)) {
-		priv->codec_priv.mclk_freq = clk_get_rate(codec_clk);
-		clk_put(codec_clk);
+	if (codec_pdev) {
+		struct clk *codec_clk = clk_get(&codec_pdev->dev, NULL);
+
+		if (!IS_ERR(codec_clk)) {
+			priv->codec_priv.mclk_freq = clk_get_rate(codec_clk);
+			clk_put(codec_clk);
+		}
 	}
 
 	/* Default sample rate and format, will be updated in hw_params() */
@@ -486,12 +536,22 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 		priv->codec_priv.fll_id = WM8960_SYSCLK_AUTO;
 		priv->codec_priv.pll_id = WM8960_SYSCLK_AUTO;
 		priv->dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;
+	} else if (of_device_is_compatible(np, "fsl,imx-audio-ac97")) {
+		codec_dai_name = "ac97-hifi";
+		priv->card.set_bias_level = NULL;
+		priv->dai_fmt = SND_SOC_DAIFMT_AC97;
 	} else {
 		dev_err(&pdev->dev, "unknown Device Tree compatible\n");
 		ret = -EINVAL;
 		goto asrc_fail;
 	}
 
+	if (!fsl_asoc_card_is_ac97(priv) && !codec_pdev) {
+		dev_err(&pdev->dev, "failed to find codec platform device\n");
+		ret = -EINVAL;
+		goto asrc_fail;
+	}
+
 	/* Common settings for corresponding Freescale CPU DAI driver */
 	if (strstr(cpu_np->name, "ssi")) {
 		/* Only SSI needs to configure AUDMUX */
@@ -508,7 +568,9 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 		priv->cpu_priv.sysclk_id[0] = FSL_SAI_CLK_MAST1;
 	}
 
-	sprintf(priv->name, "%s-audio", codec_dev->name);
+	snprintf(priv->name, sizeof(priv->name), "%s-audio",
+		 fsl_asoc_card_is_ac97(priv) ? "ac97" :
+		 codec_i2c_dev ? codec_i2c_dev->name : codec_pdev->name);
 
 	/* Initialize sound card */
 	priv->pdev = pdev;
@@ -532,8 +594,26 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 
 	/* Normal DAI Link */
 	priv->dai_link[0].cpu_of_node = cpu_np;
-	priv->dai_link[0].codec_of_node = codec_np;
 	priv->dai_link[0].codec_dai_name = codec_dai_name;
+
+	if (!fsl_asoc_card_is_ac97(priv))
+		priv->dai_link[0].codec_of_node = codec_np;
+	else {
+		u32 idx;
+
+		ret = of_property_read_u32(cpu_np, "cell-index", &idx);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"cannot get CPU index property\n");
+			goto asrc_fail;
+		}
+
+		priv->dai_link[0].codec_name =
+				devm_kasprintf(&pdev->dev, GFP_KERNEL,
+					       "ac97-codec.%u",
+					       (unsigned int)idx);
+	}
+
 	priv->dai_link[0].platform_of_node = cpu_np;
 	priv->dai_link[0].dai_fmt = priv->dai_fmt;
 	priv->card.num_links = 1;
@@ -544,6 +624,8 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 		priv->dai_link[1].platform_of_node = asrc_np;
 		priv->dai_link[2].codec_dai_name = codec_dai_name;
 		priv->dai_link[2].codec_of_node = codec_np;
+		priv->dai_link[2].codec_name =
+				priv->dai_link[0].codec_name;
 		priv->dai_link[2].cpu_of_node = cpu_np;
 		priv->dai_link[2].dai_fmt = priv->dai_fmt;
 		priv->card.num_links = 3;
@@ -579,14 +661,15 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 
 asrc_fail:
 	of_node_put(asrc_np);
-fail:
 	of_node_put(codec_np);
+fail:
 	of_node_put(cpu_np);
 
 	return ret;
 }
 
 static const struct of_device_id fsl_asoc_card_dt_ids[] = {
+	{ .compatible = "fsl,imx-audio-ac97", },
 	{ .compatible = "fsl,imx-audio-cs42888", },
 	{ .compatible = "fsl,imx-audio-sgtl5000", },
 	{ .compatible = "fsl,imx-audio-wm8962", },
