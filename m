Return-Path: <guangyu.chen@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4077D140088
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Apr 2014 22:53:03 +1100 (EST)
From: Nicolin Chen <Guangyu.Chen@freescale.com>
To: <broonie@kernel.org>, <shawn.guo@linaro.org>
Subject: [PATCH 1/2] ASoC: fsl_sai: Add clock control for SAI
Date: Tue, 1 Apr 2014 19:52:52 +0800
Message-ID: <87d225a25812d730c0865f9d0bb733c67d8b3ed1.1396352401.git.Guangyu.Chen@freescale.com>
In-Reply-To: <cover.1396352401.git.Guangyu.Chen@freescale.com>
References: <cover.1396352401.git.Guangyu.Chen@freescale.com>
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

The SAI mainly has two clocks:
ipg_clock -- registers access for SoC or DMA to read and write.
sai_clock -- providing DAI format bit clock and frame clock.

Thus this patch adds these two clocks to the driver with their clock
controls and replaces the regmap clock 'sai_clock' with 'ipg_clock'.

Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
---
 .../devicetree/bindings/sound/fsl-sai.txt          |  7 ++--
 sound/soc/fsl/fsl_sai.c                            | 37 ++++++++++++++++++++--
 sound/soc/fsl/fsl_sai.h                            |  2 ++
 3 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
index 35c09fe..bad4453 100644
--- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
+++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
@@ -11,5 +11,6 @@ Required properties:
 - reg: Offset and length of the register set for the device.
 - clocks: Must contain an entry for each entry in clock-names.
-- clock-names : Must include the "sai" entry.
+- clock-names : Must include the "ipg" for register access and "sai" for bit
+  clock and frame clock providing.
 - dmas : Generic dma devicetree binding as described in
   Documentation/devicetree/bindings/dma/dma.txt.
@@ -31,6 +32,6 @@ sai2: sai@40031000 {
 	      pinctrl-names = "default";
 	      pinctrl-0 = <&pinctrl_sai2_1>;
-	      clocks = <&clks VF610_CLK_SAI2>;
-	      clock-names = "sai";
+	      clocks = <&clks VF610_CLK_SAI2>, <&clks VF610_CLK_SAI2>;
+	      clock-names = "ipg", "sai";
 	      dma-names = "tx", "rx";
 	      dmas = <&edma0 0 VF610_EDMA_MUXID0_SAI2_TX>,
diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 3847d2a..2d749df 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -428,5 +428,18 @@ static int fsl_sai_startup(struct snd_pcm_substream *substream,
 {
 	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
-	u32 reg;
+	struct device *dev = &sai->pdev->dev;
+	u32 reg, ret;
+
+	ret = clk_prepare_enable(sai->ipg_clk);
+	if (ret) {
+		dev_err(dev, "failed to prepare and enable ipg clock\n");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(sai->sai_clk);
+	if (ret) {
+		dev_err(dev, "failed to prepare and enable sai clock\n");
+		goto err;
+	}
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
@@ -439,4 +452,9 @@ static int fsl_sai_startup(struct snd_pcm_substream *substream,
 
 	return 0;
+
+err:
+	clk_disable_unprepare(sai->ipg_clk);
+
+	return ret;
 }
 
@@ -454,4 +472,7 @@ static void fsl_sai_shutdown(struct snd_pcm_substream *substream,
 	regmap_update_bits(sai->regmap, reg, FSL_SAI_CR3_TRCE,
 			   ~FSL_SAI_CR3_TRCE);
+
+	clk_disable_unprepare(sai->sai_clk);
+	clk_disable_unprepare(sai->ipg_clk);
 }
 
@@ -609,5 +630,5 @@ static int fsl_sai_probe(struct platform_device *pdev)
 
 	sai->regmap = devm_regmap_init_mmio_clk(&pdev->dev,
-			"sai", base, &fsl_sai_regmap_config);
+			"ipg", base, &fsl_sai_regmap_config);
 	if (IS_ERR(sai->regmap)) {
 		dev_err(&pdev->dev, "regmap init failed\n");
@@ -615,4 +636,16 @@ static int fsl_sai_probe(struct platform_device *pdev)
 	}
 
+	sai->ipg_clk = devm_clk_get(&pdev->dev, "ipg");
+	if (IS_ERR(sai->ipg_clk)) {
+		dev_err(&pdev->dev, "failed to get ipg clock\n");
+		return PTR_ERR(sai->ipg_clk);
+	}
+
+	sai->sai_clk = devm_clk_get(&pdev->dev, "sai");
+	if (IS_ERR(sai->sai_clk)) {
+		dev_err(&pdev->dev, "failed to get sai clock\n");
+		return PTR_ERR(sai->sai_clk);
+	}
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index 677670d..cbaf114 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -127,4 +127,6 @@ struct fsl_sai {
 	struct platform_device *pdev;
 	struct regmap *regmap;
+	struct clk *ipg_clk;
+	struct clk *sai_clk;
 
 	bool big_endian_regs;
-- 
1.8.4
