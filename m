Return-Path: <shengjiu.wang@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0136.outbound.protection.outlook.com [65.55.169.136])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6C9B71A0021
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Sep 2014 19:34:08 +1000 (EST)
From: Shengjiu Wang <shengjiu.wang@freescale.com>
To: <timur@tabi.org>, <nicoleotsuka@gmail.com>, <Li.Xiubo@freescale.com>,
 <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.de>
Subject: [PATCH V1] ASoC: fsl_ssi: refine ipg clock usage in this module
Date: Tue, 9 Sep 2014 17:18:07 +0800
Message-ID: <e5a50d8bfde3aea5fcd092118da5aea4072c7e2f.1410254125.git.shengjiu.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move the ipg clock enable and disable operation to startup and shutdown,
that is only enable ipg clock when ssi is working. we don't need to enable
ipg clock in probe.
Another register accessing need the ipg clock, so use devm_regmap_init_mmio_clk
instead of devm_regmap_init_mmio.

Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
---
 sound/soc/fsl/fsl_ssi.c |   38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 2fc3e66..d32d0f5 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -531,6 +531,9 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 	struct fsl_ssi_private *ssi_private =
 		snd_soc_dai_get_drvdata(rtd->cpu_dai);
 
+	if (ssi_private->soc->imx)
+		clk_prepare_enable(ssi_private->clk);
+
 	/* When using dual fifo mode, it is safer to ensure an even period
 	 * size. If appearing to an odd number while DMA always starts its
 	 * task from fifo0, fifo1 would be neglected at the end of each
@@ -544,6 +547,22 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 }
 
 /**
+ * fsl_ssi_shutdown: shutdown the SSI
+ *
+ */
+static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
+                             struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct fsl_ssi_private *ssi_private =
+		snd_soc_dai_get_drvdata(rtd->cpu_dai);
+
+	if (ssi_private->soc->imx)
+		clk_disable_unprepare(ssi_private->clk);
+
+}
+
+/**
  * fsl_ssi_set_bclk - configure Digital Audio Interface bit clock
  *
  * Note: This function can be only called when using SSI as DAI master
@@ -1043,6 +1062,7 @@ static int fsl_ssi_dai_probe(struct snd_soc_dai *dai)
 
 static const struct snd_soc_dai_ops fsl_ssi_dai_ops = {
 	.startup	= fsl_ssi_startup,
+	.shutdown       = fsl_ssi_shutdown,
 	.hw_params	= fsl_ssi_hw_params,
 	.hw_free	= fsl_ssi_hw_free,
 	.set_fmt	= fsl_ssi_set_dai_fmt,
@@ -1168,16 +1188,10 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
 	u32 dmas[4];
 	int ret;
 
-	ssi_private->clk = devm_clk_get(&pdev->dev, NULL);
+	ssi_private->clk = devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(ssi_private->clk)) {
 		ret = PTR_ERR(ssi_private->clk);
-		dev_err(&pdev->dev, "could not get clock: %d\n", ret);
-		return ret;
-	}
-
-	ret = clk_prepare_enable(ssi_private->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "clk_prepare_enable failed: %d\n", ret);
+		dev_err(&pdev->dev, "could not get ipg clock: %d\n", ret);
 		return ret;
 	}
 
@@ -1236,7 +1250,6 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
 	return 0;
 
 error_pcm:
-	clk_disable_unprepare(ssi_private->clk);
 
 	return ret;
 }
@@ -1246,7 +1259,6 @@ static void fsl_ssi_imx_clean(struct platform_device *pdev,
 {
 	if (!ssi_private->use_dma)
 		imx_pcm_fiq_exit(pdev);
-	clk_disable_unprepare(ssi_private->clk);
 }
 
 static int fsl_ssi_probe(struct platform_device *pdev)
@@ -1321,7 +1333,11 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	ssi_private->regs = devm_regmap_init_mmio(&pdev->dev, iomem,
+	if (ssi_private->soc->imx)
+		ssi_private->regs = devm_regmap_init_mmio_clk(&pdev->dev,
+			"ipg", iomem, &fsl_ssi_regconfig);
+	else
+		ssi_private->regs = devm_regmap_init_mmio(&pdev->dev, iomem,
 			&fsl_ssi_regconfig);
 	if (IS_ERR(ssi_private->regs)) {
 		dev_err(&pdev->dev, "Failed to init register map\n");
-- 
1.7.9.5
