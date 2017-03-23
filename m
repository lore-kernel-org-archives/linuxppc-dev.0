Return-Path: <daniel.baluta@gmail.com>
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com
 [IPv6:2a00:1450:400c:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vplXp3sKWzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 23:02:18 +1100 (AEDT)
Received: by mail-wm0-x243.google.com with SMTP id n11so16118873wma.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 05:02:17 -0700 (PDT)
From: Daniel Baluta <daniel.baluta@gmail.com>
To: timur@tabi.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 fabio.estevam@nxp.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, daniel.baluta@nxp.com, mihai.serban@nxp.com,
 viorel.suman@nxp.com, shengjiu.wang@nxp.com,
 Nicolin Chen <b42378@freescale.com>
Subject: [PATCH] ASoC: WM8962: Let codec driver enable/disable its MCLK
Date: Thu, 23 Mar 2017 14:01:50 +0200
Message-Id: <1490270510-17061-1-git-send-email-daniel.baluta@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Nicolin Chen <b42378@freescale.com>

WM8962 needs its MCLK when powerup in wm8962_resume(). Thus it's better
to control the MCLK in codec driver. Thus remove the clock enable in
machine dirver accordingly.

While at it, get rid of imx_wm8962_remove function since it is now
empty.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/fsl/imx-wm8962.c | 40 ++++++++--------------------------------
 1 file changed, 8 insertions(+), 32 deletions(-)

diff --git a/sound/soc/fsl/imx-wm8962.c b/sound/soc/fsl/imx-wm8962.c
index 1b60958..3d894d9 100644
--- a/sound/soc/fsl/imx-wm8962.c
+++ b/sound/soc/fsl/imx-wm8962.c
@@ -33,7 +33,6 @@ struct imx_wm8962_data {
 	struct snd_soc_card card;
 	char codec_dai_name[DAI_NAME_SIZE];
 	char platform_name[DAI_NAME_SIZE];
-	struct clk *codec_clk;
 	unsigned int clk_frequency;
 };
 
@@ -163,6 +162,7 @@ static int imx_wm8962_probe(struct platform_device *pdev)
 	struct imx_priv *priv = &card_priv;
 	struct i2c_client *codec_dev;
 	struct imx_wm8962_data *data;
+	struct clk *codec_clk;
 	int int_port, ext_port;
 	int ret;
 
@@ -231,19 +231,14 @@ static int imx_wm8962_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
-	data->codec_clk = devm_clk_get(&codec_dev->dev, NULL);
-	if (IS_ERR(data->codec_clk)) {
-		ret = PTR_ERR(data->codec_clk);
+	codec_clk = devm_clk_get(&codec_dev->dev, NULL);
+	if (IS_ERR(codec_clk)) {
+		ret = PTR_ERR(codec_clk);
 		dev_err(&codec_dev->dev, "failed to get codec clk: %d\n", ret);
 		goto fail;
 	}
 
-	data->clk_frequency = clk_get_rate(data->codec_clk);
-	ret = clk_prepare_enable(data->codec_clk);
-	if (ret) {
-		dev_err(&codec_dev->dev, "failed to enable codec clk: %d\n", ret);
-		goto fail;
-	}
+	data->clk_frequency = clk_get_rate(codec_clk);
 
 	data->dai.name = "HiFi";
 	data->dai.stream_name = "HiFi";
@@ -258,10 +253,10 @@ static int imx_wm8962_probe(struct platform_device *pdev)
 	data->card.dev = &pdev->dev;
 	ret = snd_soc_of_parse_card_name(&data->card, "model");
 	if (ret)
-		goto clk_fail;
+		goto fail;
 	ret = snd_soc_of_parse_audio_routing(&data->card, "audio-routing");
 	if (ret)
-		goto clk_fail;
+		goto fail;
 	data->card.num_links = 1;
 	data->card.owner = THIS_MODULE;
 	data->card.dai_link = &data->dai;
@@ -277,16 +272,9 @@ static int imx_wm8962_probe(struct platform_device *pdev)
 	ret = devm_snd_soc_register_card(&pdev->dev, &data->card);
 	if (ret) {
 		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
-		goto clk_fail;
+		goto fail;
 	}
 
-	of_node_put(ssi_np);
-	of_node_put(codec_np);
-
-	return 0;
-
-clk_fail:
-	clk_disable_unprepare(data->codec_clk);
 fail:
 	of_node_put(ssi_np);
 	of_node_put(codec_np);
@@ -294,17 +282,6 @@ static int imx_wm8962_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int imx_wm8962_remove(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-	struct imx_wm8962_data *data = snd_soc_card_get_drvdata(card);
-
-	if (!IS_ERR(data->codec_clk))
-		clk_disable_unprepare(data->codec_clk);
-
-	return 0;
-}
-
 static const struct of_device_id imx_wm8962_dt_ids[] = {
 	{ .compatible = "fsl,imx-audio-wm8962", },
 	{ /* sentinel */ }
@@ -318,7 +295,6 @@ static struct platform_driver imx_wm8962_driver = {
 		.of_match_table = imx_wm8962_dt_ids,
 	},
 	.probe = imx_wm8962_probe,
-	.remove = imx_wm8962_remove,
 };
 module_platform_driver(imx_wm8962_driver);
 
-- 
2.7.4
