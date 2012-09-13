Return-Path: <emillbrandt@norco.coldhaus.com>
Received: from norco.coldhaus.com (norco.coldhaus.com [64.32.230.18])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (Client CN "norco.coldhaus.com",
 Issuer "StartCom Class 1 Primary Intermediate Server CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9B5262C00E2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2012 07:43:34 +1000 (EST)
From: Eric Millbrandt <emillbrandt@dekaresearch.com>
To: Grant Likely <grant.likely@secretlab.ca>, Liam Girdwood <lrg@ti.com>,
 Mark Brown <broonie@opensource.wolfsonmicro.com>,
 Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 6/7] ASoC: fsl: convert pcm030-audio-fabric to use
 snd_soc_register_card
Date: Thu, 13 Sep 2012 17:43:15 -0400
Message-Id: <1347572596-37540-7-git-send-email-emillbrandt@dekaresearch.com>
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

This patch converts pcm030-audio-fabric to use the new snd_soc_register_card
ASoC api instead of the older method of registering a separate platform
device.  It also creates the dai_link to the mpc5200_psc_ac97 platform using
the device tree.

Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com>

diff --git a/sound/soc/fsl/pcm030-audio-fabric.c b/sound/soc/fsl/pcm030-audio-fabric.c
index 5c8e2d6..893e240 100644
--- a/sound/soc/fsl/pcm030-audio-fabric.c
+++ b/sound/soc/fsl/pcm030-audio-fabric.c
@@ -28,7 +28,6 @@ static struct snd_soc_dai_link pcm030_fabric_dai[] = {
 	.stream_name = "AC97 Analog",
 	.codec_dai_name = "wm9712-hifi",
 	.cpu_dai_name = "mpc5200-psc-ac97.0",
-	.platform_name = "mpc5200-pcm-audio",
 	.codec_name = "wm9712-codec",
 },
 {
@@ -36,12 +35,11 @@ static struct snd_soc_dai_link pcm030_fabric_dai[] = {
 	.stream_name = "AC97 IEC958",
 	.codec_dai_name = "wm9712-aux",
 	.cpu_dai_name = "mpc5200-psc-ac97.1",
-	.platform_name = "mpc5200-pcm-audio",
 	.codec_name = "wm9712-codec",
 },
 };
 
-static struct snd_soc_card card = {
+static struct snd_soc_card pcm030_card = {
 	.name = "pcm030",
 	.owner = THIS_MODULE,
 	.dai_link = pcm030_fabric_dai,
@@ -50,37 +48,42 @@ static struct snd_soc_card card = {
 
 static int __init pcm030_fabric_probe(struct platform_device *op)
 {
-	struct platform_device *pdev;
-	int rc;
+	struct device_node *np = op->dev.of_node;
+	struct device_node *platform_np;
+	struct snd_soc_card *card = &pcm030_card;
+	int ret;
+	int i;
 
 	if (!of_machine_is_compatible("phytec,pcm030"))
 		return -ENODEV;
 
-	pdev = platform_device_alloc("soc-audio", 1);
-	if (!pdev) {
-		pr_err("pcm030_fabric_init: platform_device_alloc() failed\n");
+	card->dev = &op->dev;
+	platform_set_drvdata(op, card);
+
+	platform_np = of_parse_phandle(np, "asoc-platform", 0);
+	if (!platform_np) {
+		dev_err(&op->dev, "ac97 not registered\n");
 		return -ENODEV;
 	}
 
-	platform_set_drvdata(op, pdev);
-	platform_set_drvdata(pdev, &card);
+	for (i = 0; i < card->num_links; i++)
+		card->dai_link[i].platform_of_node = platform_np;
 
-	rc = platform_device_add(pdev);
-	if (rc) {
-		pr_err("pcm030_fabric_init: platform_device_add() failed\n");
-		platform_device_put(pdev);
-		return -ENODEV;
-	}
-	return 0;
+	ret = snd_soc_register_card(card);
+	if (ret)
+		dev_err(&op->dev, "snd_soc_register_card() failed: %d\n", ret);
+
+	return ret;
 }
 
 static int __devexit pcm030_fabric_remove(struct platform_device *op)
 {
-	struct platform_device *pdev = platform_get_drvdata(op);
+	struct snd_soc_card *card = platform_get_drvdata(op);
+	int ret;
 
-	platform_device_unregister(pdev);
+	ret = snd_soc_unregister_card(card);
 
-	return 0;
+	return ret;
 }
 
 static struct of_device_id pcm030_audio_match[] = {
-- 
1.7.2.5
