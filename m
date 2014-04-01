Return-Path: <guangyu.chen@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 338CA1400AB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Apr 2014 22:34:01 +1100 (EST)
From: Nicolin Chen <Guangyu.Chen@freescale.com>
To: <broonie@kernel.org>
Subject: [PATCH] ASoC: fsl_sai: Add imx6sx platform support
Date: Tue, 1 Apr 2014 19:34:09 +0800
Message-ID: <1396352049-23554-1-git-send-email-Guangyu.Chen@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, pawel.moll@arm.com, linux-doc@vger.kernel.org,
 ijc+devicetree@hellion.org.uk, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, timur@tabi.org, Li.Xiubo@freescale.com, rob@landley.net,
 galak@codeaurora.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The next coming i.MX6 Solo X SoC also contains SAI module while we use
imp_pcm_init() for i.MX platform.

So this patch adds one compatible route for imx6sx and updates the DT
doc accordingly.

Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
---
 Documentation/devicetree/bindings/sound/fsl-sai.txt |  2 +-
 sound/soc/fsl/fsl_sai.c                             | 12 ++++++++++--
 sound/soc/fsl/fsl_sai.h                             |  1 +
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
index 98611a6..35c09fe 100644
--- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
+++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
@@ -7,7 +7,7 @@ codec/DSP interfaces.
 
 
 Required properties:
-- compatible: Compatible list, contains "fsl,vf610-sai".
+- compatible: Compatible list, contains "fsl,vf610-sai" or "fsl,imx6sx-sai".
 - reg: Offset and length of the register set for the device.
 - clocks: Must contain an entry for each entry in clock-names.
 - clock-names : Must include the "sai" entry.
diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index d64c33f..9ed6795 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -22,6 +22,7 @@
 #include <sound/pcm_params.h>
 
 #include "fsl_sai.h"
+#include "imx-pcm.h"
 
 #define FSL_SAI_FLAGS (FSL_SAI_CSR_SEIE |\
 		       FSL_SAI_CSR_FEIE)
@@ -592,6 +593,9 @@ static int fsl_sai_probe(struct platform_device *pdev)
 
 	sai->pdev = pdev;
 
+	if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx6sx-sai"))
+		sai->sai_on_imx = true;
+
 	sai->big_endian_regs = of_property_read_bool(np, "big-endian-regs");
 	if (sai->big_endian_regs)
 		fsl_sai_regmap_config.val_format_endian = REGMAP_ENDIAN_BIG;
@@ -634,12 +638,16 @@ static int fsl_sai_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return devm_snd_dmaengine_pcm_register(&pdev->dev, NULL,
-			SND_DMAENGINE_PCM_FLAG_NO_RESIDUE);
+	if (sai->sai_on_imx)
+		return imx_pcm_dma_init(pdev);
+	else
+		return devm_snd_dmaengine_pcm_register(&pdev->dev, NULL,
+				SND_DMAENGINE_PCM_FLAG_NO_RESIDUE);
 }
 
 static const struct of_device_id fsl_sai_ids[] = {
 	{ .compatible = "fsl,vf610-sai", },
+	{ .compatible = "fsl,imx6sx-sai", },
 	{ /* sentinel */ }
 };
 
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index be26d46..677670d 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -130,6 +130,7 @@ struct fsl_sai {
 	bool big_endian_regs;
 	bool big_endian_data;
 	bool is_dsp_mode;
+	bool sai_on_imx;
 
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
-- 
1.8.4
