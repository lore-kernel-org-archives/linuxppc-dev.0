Return-Path: <emillbrandt@norco.coldhaus.com>
Received: from norco.coldhaus.com (norco.coldhaus.com [64.32.230.18])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (Client CN "norco.coldhaus.com",
 Issuer "StartCom Class 1 Primary Intermediate Server CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9E9C12C00E5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2012 07:43:34 +1000 (EST)
From: Eric Millbrandt <emillbrandt@dekaresearch.com>
To: Grant Likely <grant.likely@secretlab.ca>, Liam Girdwood <lrg@ti.com>,
 Mark Brown <broonie@opensource.wolfsonmicro.com>,
 Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 5/7] ASoC: fsl: convert pcm030-audio-fabric to a
 platform-driver
Date: Thu, 13 Sep 2012 17:43:14 -0400
Message-Id: <1347572596-37540-6-git-send-email-emillbrandt@dekaresearch.com>
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

This patch converts the pcm030-audio-fabric driver to a platform-driver and
adds a remove function.

Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com>

diff --git a/sound/soc/fsl/pcm030-audio-fabric.c b/sound/soc/fsl/pcm030-audio-fabric.c
index 1353e8f..5c8e2d6 100644
--- a/sound/soc/fsl/pcm030-audio-fabric.c
+++ b/sound/soc/fsl/pcm030-audio-fabric.c
@@ -48,7 +48,7 @@ static struct snd_soc_card card = {
 	.num_links = ARRAY_SIZE(pcm030_fabric_dai),
 };
 
-static __init int pcm030_fabric_init(void)
+static int __init pcm030_fabric_probe(struct platform_device *op)
 {
 	struct platform_device *pdev;
 	int rc;
@@ -62,6 +62,7 @@ static __init int pcm030_fabric_init(void)
 		return -ENODEV;
 	}
 
+	platform_set_drvdata(op, pdev);
 	platform_set_drvdata(pdev, &card);
 
 	rc = platform_device_add(pdev);
@@ -73,7 +74,32 @@ static __init int pcm030_fabric_init(void)
 	return 0;
 }
 
-module_init(pcm030_fabric_init);
+static int __devexit pcm030_fabric_remove(struct platform_device *op)
+{
+	struct platform_device *pdev = platform_get_drvdata(op);
+
+	platform_device_unregister(pdev);
+
+	return 0;
+}
+
+static struct of_device_id pcm030_audio_match[] = {
+	{ .compatible = "phytec,pcm030-audio-fabric", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, pcm030_audio_match);
+
+static struct platform_driver pcm030_fabric_driver = {
+	.probe		= pcm030_fabric_probe,
+	.remove		= __devexit_p(pcm030_fabric_remove),
+	.driver		= {
+		.name	= DRV_NAME,
+		.owner	= THIS_MODULE,
+		.of_match_table    = pcm030_audio_match,
+	},
+};
+
+module_platform_driver(pcm030_fabric_driver);
 
 
 MODULE_AUTHOR("Jon Smirl <jonsmirl@gmail.com>");
-- 
1.7.2.5
