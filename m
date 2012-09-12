Return-Path: <emillbrandt@norco.coldhaus.com>
Received: from norco.coldhaus.com (norco.coldhaus.com [64.32.230.18])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (Client CN "norco.coldhaus.com",
 Issuer "StartCom Class 1 Primary Intermediate Server CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 052EB2C007C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2012 12:25:27 +1000 (EST)
From: Eric Millbrandt <emillbrandt@dekaresearch.com>
To: Grant Likely <grant.likely@secretlab.ca>, Liam Girdwood <lrg@ti.com>,
 Mark Brown <broonie@opensource.wolfsonmicro.com>,
 Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 3/5] ASoC: fsl: mpc5200-soc-audio driver
Date: Tue, 11 Sep 2012 22:14:47 -0400
Message-Id: <1347416089-23393-4-git-send-email-emillbrandt@dekaresearch.com>
In-Reply-To: <1347416089-23393-1-git-send-email-emillbrandt@dekaresearch.com>
References: <1347416089-23393-1-git-send-email-emillbrandt@dekaresearch.com>
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

Add a generic mpc5200 driver that allows asoc cards to be defined in the
device tree.

Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com>
---
 .../devicetree/bindings/powerpc/fsl/mpc5200.txt    |   17 ++
 sound/soc/fsl/Kconfig                              |    7 +
 sound/soc/fsl/Makefile                             |    1 +
 sound/soc/fsl/mpc5200_soc_audio.c                  |  232 ++++++++++++++++++++
 4 files changed, 257 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/fsl/mpc5200_soc_audio.c

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/mpc5200.txt b/Documentation/devicetree/bindings/powerpc/fsl/mpc5200.txt
index 4ccb2cd..399d159 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/mpc5200.txt
+++ b/Documentation/devicetree/bindings/powerpc/fsl/mpc5200.txt
@@ -196,3 +196,20 @@ External interrupts:
 fsl,mpc5200-mscan nodes
 -----------------------
 See file can.txt in this directory.
+
+fsl,mpc5200-soc-audio
+---------------------
+The mpc5200 soc-audio driver allows the snd_soc_dai_link to be filled
+in based on the node properties described below.
+
+A sound node is defined for each asoc platform.  A sound node must
+have at least one child DAI node.
+- card-name           - The card name to register in asoc
+- audio-platform      - Contains a phandle to a ac97 or i2s node
+- number-of-dais      - The number of DAIs defined
+
+Multiple DAI nodes may be attached to a sound node
+- stream-name         - The asoc name of the platform DAI stream
+- codec-name          - The name of codec to bind to
+- codec-dai-name      - The codec DAI to bind to
+- cpu-dai-name        - The cpu DAI to bind to
diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index d701330..b3eee63 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -63,6 +63,13 @@ config SND_SOC_MPC5200_AC97
 	help
 	  Say Y here to support the MPC5200 PSCs in AC97 mode.
 
+config SND_MPC52xx_SOC_AUDIO
+	tristate "SoC Generic Audio support for MPC5200"
+	depends on (SND_SOC_MPC5200_AC97 || SND_SOC_MPC5200_I2S)
+	help
+	  Say Y if you want to generic device-tree support for sound on the
+	  Freescale MPC5200
+
 config SND_MPC52xx_SOC_PCM030
 	tristate "SoC AC97 Audio support for Phytec pcm030 and WM9712"
 	depends on PPC_MPC5200_SIMPLE
diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
index 5f3cf3f..d2e2e68 100644
--- a/sound/soc/fsl/Makefile
+++ b/sound/soc/fsl/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_SND_SOC_MPC5200_I2S) += mpc5200_psc_i2s.o
 obj-$(CONFIG_SND_SOC_MPC5200_AC97) += mpc5200_psc_ac97.o
 
 # MPC5200 Machine Support
+obj-$(CONFIG_SND_MPC52xx_SOC_AUDIO) += mpc5200_soc_audio.o
 obj-$(CONFIG_SND_MPC52xx_SOC_PCM030) += pcm030-audio-fabric.o
 obj-$(CONFIG_SND_MPC52xx_SOC_EFIKA) += efika-audio-fabric.o
 
diff --git a/sound/soc/fsl/mpc5200_soc_audio.c b/sound/soc/fsl/mpc5200_soc_audio.c
new file mode 100644
index 0000000..8004563
--- /dev/null
+++ b/sound/soc/fsl/mpc5200_soc_audio.c
@@ -0,0 +1,232 @@
+/*
+ * Freescale MPC5200 audio bindings
+ *
+ * Copyright 2012 DEKA R&D
+ * Author: Eric Millbrandt <emillbrandt@dekaresearch.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+#define DEBUG
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/slab.h>
+#include <sound/soc.h>
+
+#include "mpc5200_dma.h"
+
+#define DRV_NAME "mpc5200-soc-audio"
+struct mpc5200_soc_audio_data {
+	struct snd_soc_card *card;
+	struct platform_device *codec_device[AC97_BUS_MAX_DEVICES];
+};
+
+static void of_register_ac97_devices(struct platform_device *op,
+				     struct device_node *np,
+				     struct mpc5200_soc_audio_data *pdata)
+{
+	struct device_node *nc;
+	const u32 *addr;
+	char modalias[PLATFORM_NAME_SIZE];
+	char codec[PLATFORM_NAME_SIZE];
+	int len;
+	int rc;
+	int i = 0;
+
+	if (!np) {
+		dev_err(&op->dev, "No device node found!!!\n");
+		return;
+	}
+
+	for_each_child_of_node(np, nc) {
+
+		if (nc->full_name)
+			dev_dbg(&op->dev, "loading %s\n", nc->full_name);
+
+		/* Select codec */
+		if (of_modalias_node(nc, modalias,
+				     sizeof(modalias)) < 0) {
+			dev_err(&op->dev, "cannot find modalias for %s\n",
+				nc->full_name);
+			continue;
+		}
+		strlcpy(codec, modalias, sizeof(codec));
+		strlcat(codec, "-codec", sizeof(codec));
+
+		/* Device address */
+		addr = of_get_property(nc, "reg", &len);
+		if (!addr || len < sizeof(*addr)) {
+			dev_err(&op->dev, "%s has no 'reg' property\n",
+				nc->full_name);
+			continue;
+		}
+
+		/* Allocate a platform device for the attached codec */
+		pdata->codec_device[i] = platform_device_alloc(codec, *addr);
+		if (!pdata->codec_device[i]) {
+			dev_err(&op->dev, "device allocation failed\n");
+			continue;
+		}
+
+		rc = platform_device_add(pdata->codec_device[i]);
+		if (rc) {
+			dev_err(&op->dev, "device assignment failed\n");
+			continue;
+		}
+
+		/* Register the new codec */
+		dev_dbg(&op->dev, "Registering snd-soc-%s\n", modalias);
+		rc = request_module("snd-soc-%s", modalias);
+		if (rc)
+			dev_err(&op->dev, "request_module returned: %d\n", rc);
+
+		i++;
+	}
+}
+
+static int __init mpc5200_soc_audio_probe(struct platform_device *op)
+{
+	struct device_node *np = op->dev.of_node;
+	struct device_node *nc;
+	struct device_node *cpu_platform_np;
+	struct snd_soc_card *card;
+	struct mpc5200_soc_audio_data *pdata;
+	int ret;
+	int i = 0;
+
+	card = kzalloc(sizeof(struct snd_soc_card), GFP_KERNEL);
+	if (!card) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	pdata = kzalloc(sizeof(struct mpc5200_soc_audio_data), GFP_KERNEL);
+	if (!pdata) {
+		ret = -ENOMEM;
+		goto no_mem;
+	}
+
+	pdata->card = card;
+
+	card->owner = THIS_MODULE;
+	ret = of_property_read_u32(np, "number-of-dais", &card->num_links);
+	if (ret || card->num_links < 1) {
+		dev_err(&op->dev, "number-of-dais not setup\n");
+		ret = -EINVAL;
+		goto no_dais;
+	}
+
+	card->dai_link = kzalloc(card->num_links *
+				 sizeof(struct snd_soc_dai_link), GFP_KERNEL);
+	if (!card->dai_link) {
+		ret = -ENOMEM;
+		goto no_dais;
+	}
+
+	cpu_platform_np = of_parse_phandle(np, "audio-platform", 0);
+	if (!cpu_platform_np)
+		dev_err(&op->dev, "ac97 not enabled!\n");
+
+	/* Register attached codecs */
+	dev_dbg(&op->dev, "Registering attached codecs\n");
+	of_register_ac97_devices(op, cpu_platform_np, pdata);
+
+	card->dev = &op->dev;
+
+	/* Set card name */
+	snd_soc_of_parse_card_name(card, "card-name");
+
+	/* Add devices to dai_link */
+	for_each_child_of_node(np, nc) {
+		card->dai_link[i].name = nc->name;
+		card->dai_link[i].platform_of_node = cpu_platform_np;
+		of_property_read_string(nc, "stream-name",
+					&card->dai_link[i].stream_name);
+		of_property_read_string(nc, "codec-name",
+					&card->dai_link[i].codec_name);
+		of_property_read_string(nc, "codec-dai-name",
+					&card->dai_link[i].codec_dai_name);
+		of_property_read_string(nc, "cpu-dai-name",
+					&card->dai_link[i].cpu_dai_name);
+
+		dev_dbg(&op->dev, "%d: name: %s\n", i,
+			card->dai_link[i].name);
+		dev_dbg(&op->dev, "%d: stream-name: %s\n", i,
+			card->dai_link[i].stream_name);
+		dev_dbg(&op->dev, "%d: codec-name: %s\n", i,
+			card->dai_link[i].codec_name);
+		dev_dbg(&op->dev, "%d: codec-dai-name: %s\n", i,
+			card->dai_link[i].codec_dai_name);
+		dev_dbg(&op->dev, "%d: cpu-dai-name: %s\n", i,
+			card->dai_link[i].cpu_dai_name);
+
+		i++;
+	}
+
+	ret = snd_soc_register_card(card);
+	if (ret) {
+		dev_err(&op->dev, "snd_soc_register_card() failed: %d\n", ret);
+		goto no_card;
+	}
+
+	platform_set_drvdata(op, pdata);
+
+	return ret;
+no_card:
+	kfree(card->dai_link);
+no_dais:
+	kfree(pdata);
+no_mem:
+	kfree(card);
+out:
+	return ret;
+}
+
+static int mpc5200_soc_audio_remove(struct platform_device *op)
+{
+	struct mpc5200_soc_audio_data *pdata = platform_get_drvdata(op);
+	struct snd_soc_card *card = pdata->card;
+	int i;
+	int ret;
+
+	ret = snd_soc_unregister_card(card);
+
+	if (ret == 0) {
+		kfree(card->dai_link);
+		kfree(card);
+
+		for (i = 0; i < AC97_BUS_MAX_DEVICES; i++)
+			if (pdata->codec_device[i])
+				platform_device_unregister(
+					pdata->codec_device[i]);
+		kfree(pdata);
+	}
+
+	return ret;
+}
+
+static struct of_device_id mpc5200_audio_match[] = {
+	{ .compatible = "fsl,mpc5200b-soc-audio", },
+	{ .compatible = "fsl,mpc5200-soc-audio", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, mpc5200_audio_match);
+
+static struct platform_driver mpc5200_soc_audio_driver = {
+	.probe		= mpc5200_soc_audio_probe,
+	.remove		= mpc5200_soc_audio_remove,
+	.driver		= {
+		.name	= DRV_NAME,
+		.owner	= THIS_MODULE,
+		.of_match_table    = mpc5200_audio_match,
+	},
+};
+
+module_platform_driver(mpc5200_soc_audio_driver);
+
+MODULE_AUTHOR("Eric Millbrandt <emillbrandt@dekaresearch.com>");
+MODULE_DESCRIPTION(DRV_NAME ": mpc5200 audio fabric driver");
+MODULE_LICENSE("GPL");
-- 
1.7.2.5
