Return-Path: <shengjiu.wang@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0121.outbound.protection.outlook.com [65.55.169.121])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B9F871A0024
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Sep 2014 15:39:02 +1000 (EST)
From: Shengjiu Wang <shengjiu.wang@freescale.com>
To: <timur@tabi.org>, <nicoleotsuka@gmail.com>, <Li.Xiubo@freescale.com>,
 <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.de>
Subject: [PATCH V2] ASoC: fsl_ssi: refine ipg clock usage in this module
Date: Thu, 11 Sep 2014 13:38:29 +0800
Message-ID: <27584da8e3ab291ab8dbcbb411579613f8384a59.1410413734.git.shengjiu.wang@freescale.com>
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
that is only enable ipg clock when ssi is working. Keep clock is disabled
when ssi is in idle.
otherwise, _fsl_ssi_set_dai_fmt function need to be called in probe,
so add ipg clock control for it.

Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
---

change log
v2: update patch according to maintainer's review comments.

 sound/soc/fsl/fsl_ssi.c |   39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 2fc3e66..4447f95 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -530,6 +530,11 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct fsl_ssi_private *ssi_private =
 		snd_soc_dai_get_drvdata(rtd->cpu_dai);
+	int ret;
+
+	ret = clk_prepare_enable(ssi_private->clk);
+	if (ret)
+		return ret;
 
 	/* When using dual fifo mode, it is safer to ensure an even period
 	 * size. If appearing to an odd number while DMA always starts its
@@ -544,6 +549,21 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
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
+	clk_disable_unprepare(ssi_private->clk);
+
+}
+
+/**
  * fsl_ssi_set_bclk - configure Digital Audio Interface bit clock
  *
  * Note: This function can be only called when using SSI as DAI master
@@ -771,6 +791,7 @@ static int _fsl_ssi_set_dai_fmt(struct fsl_ssi_private *ssi_private,
 	struct regmap *regs = ssi_private->regs;
 	u32 strcr = 0, stcr, srcr, scr, mask;
 	u8 wm;
+	int ret;
 
 	ssi_private->dai_fmt = fmt;
 
@@ -779,6 +800,10 @@ static int _fsl_ssi_set_dai_fmt(struct fsl_ssi_private *ssi_private,
 		return -EINVAL;
 	}
 
+	ret = clk_prepare_enable(ssi_private->clk);
+	if (ret)
+		return ret;
+
 	fsl_ssi_setup_reg_vals(ssi_private);
 
 	regmap_read(regs, CCSR_SSI_SCR, &scr);
@@ -811,6 +836,7 @@ static int _fsl_ssi_set_dai_fmt(struct fsl_ssi_private *ssi_private,
 			ssi_private->i2s_mode |= CCSR_SSI_SCR_I2S_MODE_SLAVE;
 			break;
 		default:
+			clk_disable_unprepare(ssi_private->clk);
 			return -EINVAL;
 		}
 
@@ -836,6 +862,7 @@ static int _fsl_ssi_set_dai_fmt(struct fsl_ssi_private *ssi_private,
 		ssi_private->i2s_mode |= CCSR_SSI_SCR_I2S_MODE_NORMAL;
 		break;
 	default:
+		clk_disable_unprepare(ssi_private->clk);
 		return -EINVAL;
 	}
 	scr |= ssi_private->i2s_mode;
@@ -859,6 +886,7 @@ static int _fsl_ssi_set_dai_fmt(struct fsl_ssi_private *ssi_private,
 		strcr ^= CCSR_SSI_STCR_TFSI;
 		break;
 	default:
+		clk_disable_unprepare(ssi_private->clk);
 		return -EINVAL;
 	}
 
@@ -877,6 +905,7 @@ static int _fsl_ssi_set_dai_fmt(struct fsl_ssi_private *ssi_private,
 		scr &= ~CCSR_SSI_SCR_SYS_CLK_EN;
 		break;
 	default:
+		clk_disable_unprepare(ssi_private->clk);
 		return -EINVAL;
 	}
 
@@ -925,6 +954,7 @@ static int _fsl_ssi_set_dai_fmt(struct fsl_ssi_private *ssi_private,
 	if (fmt & SND_SOC_DAIFMT_AC97)
 		fsl_ssi_setup_ac97(ssi_private);
 
+	clk_disable_unprepare(ssi_private->clk);
 	return 0;
 
 }
@@ -1043,6 +1073,7 @@ static int fsl_ssi_dai_probe(struct snd_soc_dai *dai)
 
 static const struct snd_soc_dai_ops fsl_ssi_dai_ops = {
 	.startup	= fsl_ssi_startup,
+	.shutdown       = fsl_ssi_shutdown,
 	.hw_params	= fsl_ssi_hw_params,
 	.hw_free	= fsl_ssi_hw_free,
 	.set_fmt	= fsl_ssi_set_dai_fmt,
@@ -1175,12 +1206,6 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
 		return ret;
 	}
 
-	ret = clk_prepare_enable(ssi_private->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "clk_prepare_enable failed: %d\n", ret);
-		return ret;
-	}
-
 	/* For those SLAVE implementations, we ingore non-baudclk cases
 	 * and, instead, abandon MASTER mode that needs baud clock.
 	 */
@@ -1236,7 +1261,6 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
 	return 0;
 
 error_pcm:
-	clk_disable_unprepare(ssi_private->clk);
 
 	return ret;
 }
@@ -1246,7 +1270,6 @@ static void fsl_ssi_imx_clean(struct platform_device *pdev,
 {
 	if (!ssi_private->use_dma)
 		imx_pcm_fiq_exit(pdev);
-	clk_disable_unprepare(ssi_private->clk);
 }
 
 static int fsl_ssi_probe(struct platform_device *pdev)
-- 
1.7.9.5
