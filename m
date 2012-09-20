Return-Path: <emillbrandt@norco.coldhaus.com>
Received: from norco.coldhaus.com (norco.coldhaus.com [64.32.230.18])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (Client CN "norco.coldhaus.com",
 Issuer "StartCom Class 1 Primary Intermediate Server CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 555712C009C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2012 00:37:34 +1000 (EST)
From: Eric Millbrandt <emillbrandt@dekaresearch.com>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>,
 Liam Girdwood <lrg@ti.com>, Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 3/3] ASoC: fsl: register the wm9712-codec
Date: Thu, 20 Sep 2012 10:36:45 -0400
Message-Id: <1348151805-93991-3-git-send-email-emillbrandt@dekaresearch.com>
In-Reply-To: <1348151805-93991-1-git-send-email-emillbrandt@dekaresearch.com>
References: <1348151805-93991-1-git-send-email-emillbrandt@dekaresearch.com>
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

The mpc5200-psc-ac97 driver does not enumerate attached ac97 devices, so
register the device here.

Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com>
---
 sound/soc/fsl/pcm030-audio-fabric.c |   32 +++++++++++++++++++++++++++++---
 1 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/pcm030-audio-fabric.c b/sound/soc/fsl/pcm030-audio-fabric.c
index 893e240..4b63ec8 100644
--- a/sound/soc/fsl/pcm030-audio-fabric.c
+++ b/sound/soc/fsl/pcm030-audio-fabric.c
@@ -22,6 +22,11 @@
 
 #define DRV_NAME "pcm030-audio-fabric"
 
+struct pcm030_audio_data {
+	struct snd_soc_card *card;
+	struct platform_device *codec_device;
+};
+
 static struct snd_soc_dai_link pcm030_fabric_dai[] = {
 {
 	.name = "AC97",
@@ -51,14 +56,22 @@ static int __init pcm030_fabric_probe(struct platform_device *op)
 	struct device_node *np = op->dev.of_node;
 	struct device_node *platform_np;
 	struct snd_soc_card *card = &pcm030_card;
+	struct pcm030_audio_data *pdata;
 	int ret;
 	int i;
 
 	if (!of_machine_is_compatible("phytec,pcm030"))
 		return -ENODEV;
 
+	pdata = devm_kzalloc(&op->dev, sizeof(struct pcm030_audio_data),
+			     GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
 	card->dev = &op->dev;
-	platform_set_drvdata(op, card);
+	platform_set_drvdata(op, pdata);
+
+	pdata->card = card;
 
 	platform_np = of_parse_phandle(np, "asoc-platform", 0);
 	if (!platform_np) {
@@ -69,6 +82,18 @@ static int __init pcm030_fabric_probe(struct platform_device *op)
 	for (i = 0; i < card->num_links; i++)
 		card->dai_link[i].platform_of_node = platform_np;
 
+	ret = request_module("snd-soc-wm9712");
+	if (ret)
+		dev_err(&op->dev, "request_module returned: %d\n", ret);
+
+	pdata->codec_device = platform_device_alloc("wm9712-codec", -1);
+	if (!pdata->codec_device)
+		dev_err(&op->dev, "platform_device_alloc() failed\n");
+
+	ret = platform_device_add(pdata->codec_device);
+	if (ret)
+		dev_err(&op->dev, "platform_device_add() failed: %d\n", ret);
+
 	ret = snd_soc_register_card(card);
 	if (ret)
 		dev_err(&op->dev, "snd_soc_register_card() failed: %d\n", ret);
@@ -78,10 +103,11 @@ static int __init pcm030_fabric_probe(struct platform_device *op)
 
 static int __devexit pcm030_fabric_remove(struct platform_device *op)
 {
-	struct snd_soc_card *card = platform_get_drvdata(op);
+	struct pcm030_audio_data *pdata = platform_get_drvdata(op);
 	int ret;
 
-	ret = snd_soc_unregister_card(card);
+	ret = snd_soc_unregister_card(pdata->card);
+	platform_device_unregister(pdata->codec_device);
 
 	return ret;
 }
-- 
1.7.2.5
