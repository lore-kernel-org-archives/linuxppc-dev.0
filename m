Return-Path: <B42378@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 24AF42C01E6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Aug 2013 21:54:56 +1000 (EST)
From: Nicolin Chen <b42378@freescale.com>
To: <broonie@kernel.org>, <lars@metafoo.de>, <p.zabel@pengutronix.de>
Subject: [PATCH v4 resent 2/2] ASoC: fsl: Add S/PDIF machine driver
Date: Mon, 12 Aug 2013 20:05:28 +0800
Message-ID: <31f0e20222b30d3645981b950ed21fe31440ba75.1376309076.git.b42378@freescale.com>
In-Reply-To: <cover.1376309076.git.b42378@freescale.com>
References: <cover.1376309076.git.b42378@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, timur@tabi.org, rob.herring@calxeda.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add S/PDIF machine driver for Freescale i.MX series SoC.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 .../devicetree/bindings/sound/imx-audio-spdif.txt  |   29 +++++
 sound/soc/fsl/Kconfig                              |   11 ++
 sound/soc/fsl/Makefile                             |    2 +
 sound/soc/fsl/imx-spdif.c                          |  134 ++++++++++++++++++++
 4 files changed, 176 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/imx-audio-spdif.txt
 create mode 100644 sound/soc/fsl/imx-spdif.c

diff --git a/Documentation/devicetree/bindings/sound/imx-audio-spdif.txt b/Documentation/devicetree/bindings/sound/imx-audio-spdif.txt
new file mode 100644
index 0000000..9a3fa26
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/imx-audio-spdif.txt
@@ -0,0 +1,29 @@
+Freescale i.MX audio complex with S/PDIF transceiver
+
+Required properties:
+
+  - compatible : "fsl,imx-audio-spdif"
+
+  - model : The user-visible name of this sound complex
+
+  - spdif-controller : The phandle of the i.MX S/PDIF controller
+
+
+Optional properties:
+
+  - spdif-transmitter : The phandle of the spdif-transmitter dummy codec
+
+  - spdif-receiver : The phandle of the spdif-receiver dummy codec
+
+* Note: At least one of these two properties should be set in the DT binding.
+
+
+Example:
+
+sound-spdif {
+	compatible = "fsl,imx-audio-spdif";
+	model = "imx-spdif";
+	spdif-controller = <&spdif>;
+	spdif-transmitter = <&spdif_tx_codec>;
+	spdif-receiver = <&spdif_rx_codec>;
+};
diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 2c518db..4cc118c 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -195,6 +195,17 @@ config SND_SOC_IMX_SGTL5000
 	  Say Y if you want to add support for SoC audio on an i.MX board with
 	  a sgtl5000 codec.
 
+config SND_SOC_IMX_SPDIF
+	tristate "SoC Audio support for i.MX boards with S/PDIF"
+	select SND_SOC_IMX_PCM_DMA
+	select SND_SOC_FSL_SPDIF
+	select SND_SOC_FSL_UTILS
+	select SND_SOC_SPDIF
+	help
+	  SoC Audio support for i.MX boards with S/PDIF
+	  Say Y if you want to add support for SoC audio on an i.MX board with
+	  a S/DPDIF.
+
 config SND_SOC_IMX_MC13783
 	tristate "SoC Audio support for I.MX boards with mc13783"
 	depends on MFD_MC13783 && ARM
diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
index 4b5970e..e2aaff7 100644
--- a/sound/soc/fsl/Makefile
+++ b/sound/soc/fsl/Makefile
@@ -45,6 +45,7 @@ snd-soc-mx27vis-aic32x4-objs := mx27vis-aic32x4.o
 snd-soc-wm1133-ev1-objs := wm1133-ev1.o
 snd-soc-imx-sgtl5000-objs := imx-sgtl5000.o
 snd-soc-imx-wm8962-objs := imx-wm8962.o
+snd-soc-imx-spdif-objs :=imx-spdif.o
 snd-soc-imx-mc13783-objs := imx-mc13783.o
 
 obj-$(CONFIG_SND_SOC_EUKREA_TLV320) += snd-soc-eukrea-tlv320.o
@@ -53,4 +54,5 @@ obj-$(CONFIG_SND_SOC_MX27VIS_AIC32X4) += snd-soc-mx27vis-aic32x4.o
 obj-$(CONFIG_SND_MXC_SOC_WM1133_EV1) += snd-soc-wm1133-ev1.o
 obj-$(CONFIG_SND_SOC_IMX_SGTL5000) += snd-soc-imx-sgtl5000.o
 obj-$(CONFIG_SND_SOC_IMX_WM8962) += snd-soc-imx-wm8962.o
+obj-$(CONFIG_SND_SOC_IMX_SPDIF) += snd-soc-imx-spdif.o
 obj-$(CONFIG_SND_SOC_IMX_MC13783) += snd-soc-imx-mc13783.o
diff --git a/sound/soc/fsl/imx-spdif.c b/sound/soc/fsl/imx-spdif.c
new file mode 100644
index 0000000..893f3d1
--- /dev/null
+++ b/sound/soc/fsl/imx-spdif.c
@@ -0,0 +1,134 @@
+/*
+ * Copyright (C) 2013 Freescale Semiconductor, Inc.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <sound/soc.h>
+
+struct imx_spdif_data {
+	struct snd_soc_dai_link dai[2];
+	struct snd_soc_card card;
+};
+
+static int imx_spdif_audio_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *spdif_np, *codec_tx_np, *codec_rx_np;
+	struct platform_device *spdif_pdev;
+	struct imx_spdif_data *data;
+	int ret = 0, num_links = 0;
+
+	spdif_np = of_parse_phandle(np, "spdif-controller", 0);
+	if (!spdif_np) {
+		dev_err(&pdev->dev, "failed to find spdif-controller\n");
+		ret = -EINVAL;
+		goto fail;
+	}
+
+	spdif_pdev = of_find_device_by_node(spdif_np);
+	if (!spdif_pdev) {
+		dev_err(&pdev->dev, "failed to find S/PDIF device\n");
+		ret = -EINVAL;
+		goto fail;
+	}
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data) {
+		dev_err(&pdev->dev, "failed to allocate memory\n");
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	codec_tx_np = of_parse_phandle(np, "spdif-transmitter", 0);
+	if (codec_tx_np) {
+		data->dai[num_links].name = "S/PDIF TX";
+		data->dai[num_links].stream_name = "S/PDIF PCM Playback";
+		data->dai[num_links].codec_dai_name = "dit-hifi";
+		data->dai[num_links].codec_of_node = codec_tx_np;
+		data->dai[num_links].cpu_of_node = spdif_np;
+		data->dai[num_links].platform_of_node = spdif_np;
+		num_links++;
+	}
+
+	codec_rx_np = of_parse_phandle(np, "spdif-receiver", 0);
+	if (codec_rx_np) {
+		data->dai[num_links].name = "S/PDIF RX";
+		data->dai[num_links].stream_name = "S/PDIF PCM Capture";
+		data->dai[num_links].codec_dai_name = "dir-hifi";
+		data->dai[num_links].codec_of_node = codec_rx_np;
+		data->dai[num_links].cpu_of_node = spdif_np;
+		data->dai[num_links].platform_of_node = spdif_np;
+		num_links++;
+	}
+
+	if (!num_links) {
+		dev_err(&pdev->dev, "no enabled S/PDIF DAI link\n");
+		goto fail;
+	}
+
+	data->card.dev = &pdev->dev;
+	data->card.num_links = num_links;
+	data->card.dai_link = data->dai;
+
+	ret = snd_soc_of_parse_card_name(&data->card, "model");
+	if (ret)
+		goto fail;
+
+	ret = snd_soc_register_card(&data->card);
+	if (ret) {
+		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
+		goto fail;
+	}
+
+	platform_set_drvdata(pdev, data);
+
+fail:
+	if (codec_tx_np)
+		of_node_put(codec_tx_np);
+	if (codec_rx_np)
+		of_node_put(codec_rx_np);
+	if (spdif_np)
+		of_node_put(spdif_np);
+
+	return ret;
+}
+
+static int imx_spdif_audio_remove(struct platform_device *pdev)
+{
+	struct imx_spdif_data *data = platform_get_drvdata(pdev);
+
+	snd_soc_unregister_card(&data->card);
+
+	return 0;
+}
+
+static const struct of_device_id imx_spdif_dt_ids[] = {
+	{ .compatible = "fsl,imx-audio-spdif", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, imx_spdif_dt_ids);
+
+static struct platform_driver imx_spdif_driver = {
+	.driver = {
+		.name = "imx-spdif",
+		.owner = THIS_MODULE,
+		.of_match_table = imx_spdif_dt_ids,
+	},
+	.probe = imx_spdif_audio_probe,
+	.remove = imx_spdif_audio_remove,
+};
+
+module_platform_driver(imx_spdif_driver);
+
+MODULE_AUTHOR("Freescale Semiconductor, Inc.");
+MODULE_DESCRIPTION("Freescale i.MX S/PDIF machine driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:imx-spdif");
-- 
1.7.1
