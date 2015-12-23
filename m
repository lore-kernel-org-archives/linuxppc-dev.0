Return-Path: <geliangtang@163.com>
Received: from m50-134.163.com (m50-134.163.com [123.125.50.134])
 by lists.ozlabs.org (Postfix) with ESMTP id BC0831A0BD7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Dec 2015 00:03:57 +1100 (AEDT)
From: Geliang Tang <geliangtang@163.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Geliang Tang <geliangtang@163.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] ASoC: twl6040, fsl: use to_platform_device
Date: Wed, 23 Dec 2015 21:03:39 +0800
Message-Id: <e0497ed266c5f2013268cca6c02fd2b161339c07.1450875641.git.geliangtang@163.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use to_platform_device() instead of open-coding it.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 sound/soc/codecs/twl6040.c   | 3 +--
 sound/soc/fsl/mpc8610_hpcd.c | 3 +--
 sound/soc/fsl/p1022_ds.c     | 3 +--
 sound/soc/fsl/p1022_rdk.c    | 3 +--
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 4cad892..bc3de2e 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1097,8 +1097,7 @@ static int twl6040_probe(struct snd_soc_codec *codec)
 {
 	struct twl6040_data *priv;
 	struct twl6040 *twl6040 = dev_get_drvdata(codec->dev->parent);
-	struct platform_device *pdev = container_of(codec->dev,
-						   struct platform_device, dev);
+	struct platform_device *pdev = to_platform_device(codec->dev);
 	int ret = 0;
 
 	priv = devm_kzalloc(codec->dev, sizeof(*priv), GFP_KERNEL);
diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index 6f236f1..ddf49f3 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -189,8 +189,7 @@ static int mpc8610_hpcd_probe(struct platform_device *pdev)
 {
 	struct device *dev = pdev->dev.parent;
 	/* ssi_pdev is the platform device for the SSI node that probed us */
-	struct platform_device *ssi_pdev =
-		container_of(dev, struct platform_device, dev);
+	struct platform_device *ssi_pdev = to_platform_device(dev);
 	struct device_node *np = ssi_pdev->dev.of_node;
 	struct device_node *codec_np = NULL;
 	struct mpc8610_hpcd_data *machine_data;
diff --git a/sound/soc/fsl/p1022_ds.c b/sound/soc/fsl/p1022_ds.c
index 747aab0..a1f780e 100644
--- a/sound/soc/fsl/p1022_ds.c
+++ b/sound/soc/fsl/p1022_ds.c
@@ -199,8 +199,7 @@ static int p1022_ds_probe(struct platform_device *pdev)
 {
 	struct device *dev = pdev->dev.parent;
 	/* ssi_pdev is the platform device for the SSI node that probed us */
-	struct platform_device *ssi_pdev =
-		container_of(dev, struct platform_device, dev);
+	struct platform_device *ssi_pdev = to_platform_device(dev);
 	struct device_node *np = ssi_pdev->dev.of_node;
 	struct device_node *codec_np = NULL;
 	struct machine_data *mdata;
diff --git a/sound/soc/fsl/p1022_rdk.c b/sound/soc/fsl/p1022_rdk.c
index 1dd49e5..d4d88a8 100644
--- a/sound/soc/fsl/p1022_rdk.c
+++ b/sound/soc/fsl/p1022_rdk.c
@@ -203,8 +203,7 @@ static int p1022_rdk_probe(struct platform_device *pdev)
 {
 	struct device *dev = pdev->dev.parent;
 	/* ssi_pdev is the platform device for the SSI node that probed us */
-	struct platform_device *ssi_pdev =
-		container_of(dev, struct platform_device, dev);
+	struct platform_device *ssi_pdev = to_platform_device(dev);
 	struct device_node *np = ssi_pdev->dev.of_node;
 	struct device_node *codec_np = NULL;
 	struct machine_data *mdata;
-- 
2.5.0
