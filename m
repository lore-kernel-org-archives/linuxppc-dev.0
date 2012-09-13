Return-Path: <emillbrandt@norco.coldhaus.com>
Received: from norco.coldhaus.com (norco.coldhaus.com [64.32.230.18])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (Client CN "norco.coldhaus.com",
 Issuer "StartCom Class 1 Primary Intermediate Server CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F2B302C0093
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2012 07:43:30 +1000 (EST)
From: Eric Millbrandt <emillbrandt@dekaresearch.com>
To: Grant Likely <grant.likely@secretlab.ca>, Liam Girdwood <lrg@ti.com>,
 Mark Brown <broonie@opensource.wolfsonmicro.com>,
 Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 2/7] ASoC: fsl: mpc5200 combine psc_dma platform data
Date: Thu, 13 Sep 2012 17:43:11 -0400
Message-Id: <1347572596-37540-3-git-send-email-emillbrandt@dekaresearch.com>
In-Reply-To: <1347572596-37540-1-git-send-email-emillbrandt@dekaresearch.com>
References: <1347572596-37540-1-git-send-email-emillbrandt@dekaresearch.com>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The mpc5200_psc_ac97 and mpc5200_psc_i2s modules rely on shared platform data
with mpc5200_dma.

Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com>

diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
index 9a3f7c5..9997c03 100644
--- a/sound/soc/fsl/mpc5200_dma.c
+++ b/sound/soc/fsl/mpc5200_dma.c
@@ -370,7 +370,7 @@ static struct snd_soc_platform_driver mpc5200_audio_dma_platform = {
 	.pcm_free	= &psc_dma_free,
 };
 
-static int mpc5200_hpcd_probe(struct platform_device *op)
+int mpc5200_audio_dma_create(struct platform_device *op)
 {
 	phys_addr_t fifo;
 	struct psc_dma *psc_dma;
@@ -487,8 +487,9 @@ out_unmap:
 	iounmap(regs);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(mpc5200_audio_dma_create);
 
-static int mpc5200_hpcd_remove(struct platform_device *op)
+int mpc5200_audio_dma_destroy(struct platform_device *op)
 {
 	struct psc_dma *psc_dma = dev_get_drvdata(&op->dev);
 
@@ -510,24 +511,7 @@ static int mpc5200_hpcd_remove(struct platform_device *op)
 
 	return 0;
 }
-
-static struct of_device_id mpc5200_hpcd_match[] = {
-	{ .compatible = "fsl,mpc5200-pcm", },
-	{}
-};
-MODULE_DEVICE_TABLE(of, mpc5200_hpcd_match);
-
-static struct platform_driver mpc5200_hpcd_of_driver = {
-	.probe		= mpc5200_hpcd_probe,
-	.remove		= mpc5200_hpcd_remove,
-	.driver = {
-		.owner		= THIS_MODULE,
-		.name		= "mpc5200-pcm-audio",
-		.of_match_table    = mpc5200_hpcd_match,
-	}
-};
-
-module_platform_driver(mpc5200_hpcd_of_driver);
+EXPORT_SYMBOL_GPL(mpc5200_audio_dma_destroy);
 
 MODULE_AUTHOR("Grant Likely <grant.likely@secretlab.ca>");
 MODULE_DESCRIPTION("Freescale MPC5200 PSC in DMA mode ASoC Driver");
diff --git a/sound/soc/fsl/mpc5200_dma.h b/sound/soc/fsl/mpc5200_dma.h
index a3c0cd5..dff253f 100644
--- a/sound/soc/fsl/mpc5200_dma.h
+++ b/sound/soc/fsl/mpc5200_dma.h
@@ -81,4 +81,7 @@ to_psc_dma_stream(struct snd_pcm_substream *substream, struct psc_dma *psc_dma)
 	return &psc_dma->playback;
 }
 
+int mpc5200_audio_dma_create(struct platform_device *op);
+int mpc5200_audio_dma_destroy(struct platform_device *op);
+
 #endif /* __SOUND_SOC_FSL_MPC5200_DMA_H__ */
diff --git a/sound/soc/fsl/mpc5200_psc_ac97.c b/sound/soc/fsl/mpc5200_psc_ac97.c
index ffa00a2..9a09453 100644
--- a/sound/soc/fsl/mpc5200_psc_ac97.c
+++ b/sound/soc/fsl/mpc5200_psc_ac97.c
@@ -278,6 +278,10 @@ static int __devinit psc_ac97_of_probe(struct platform_device *op)
 	struct snd_ac97 ac97;
 	struct mpc52xx_psc __iomem *regs;
 
+	rc = mpc5200_audio_dma_create(op);
+	if (rc != 0)
+		return rc;
+
 	rc = snd_soc_register_dais(&op->dev, psc_ac97_dai, ARRAY_SIZE(psc_ac97_dai));
 	if (rc != 0) {
 		dev_err(&op->dev, "Failed to register DAI\n");
@@ -303,6 +307,7 @@ static int __devinit psc_ac97_of_probe(struct platform_device *op)
 
 static int __devexit psc_ac97_of_remove(struct platform_device *op)
 {
+	mpc5200_audio_dma_destroy(op);
 	snd_soc_unregister_dais(&op->dev, ARRAY_SIZE(psc_ac97_dai));
 	return 0;
 }
diff --git a/sound/soc/fsl/mpc5200_psc_i2s.c b/sound/soc/fsl/mpc5200_psc_i2s.c
index 7b53032..c0b7a23 100644
--- a/sound/soc/fsl/mpc5200_psc_i2s.c
+++ b/sound/soc/fsl/mpc5200_psc_i2s.c
@@ -156,6 +156,10 @@ static int __devinit psc_i2s_of_probe(struct platform_device *op)
 	struct psc_dma *psc_dma;
 	struct mpc52xx_psc __iomem *regs;
 
+	rc = mpc5200_audio_dma_create(op);
+	if (rc != 0)
+		return rc;
+
 	rc = snd_soc_register_dais(&op->dev, psc_i2s_dai, ARRAY_SIZE(psc_i2s_dai));
 	if (rc != 0) {
 		pr_err("Failed to register DAI\n");
@@ -200,6 +204,7 @@ static int __devinit psc_i2s_of_probe(struct platform_device *op)
 
 static int __devexit psc_i2s_of_remove(struct platform_device *op)
 {
+	mpc5200_audio_dma_destroy(op);
 	snd_soc_unregister_dais(&op->dev, ARRAY_SIZE(psc_i2s_dai));
 	return 0;
 }
-- 
1.7.2.5
