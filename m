Return-Path: <guangyu.chen@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E998C140111
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Apr 2014 21:09:28 +1100 (EST)
From: Nicolin Chen <Guangyu.Chen@freescale.com>
To: <broonie@kernel.org>, <shawn.guo@linaro.org>
Subject: [PATCH v2 1/2] ASoC: fsl_sai: Add clock controls for SAI
Date: Wed, 2 Apr 2014 18:10:19 +0800
Message-ID: <12898efab7a5907e6ed1c438a486692f59ef9d8b.1396432924.git.Guangyu.Chen@freescale.com>
In-Reply-To: <cover.1396432924.git.Guangyu.Chen@freescale.com>
References: <cover.1396432924.git.Guangyu.Chen@freescale.com>
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

The SAI mainly has the following clocks:
  bus clock
    control and configuration registers and to generate synchronous
    interrupts and DMA requests.

  mclk1, mclk2, mclk3
    to generate the bit clock when the receiver or transmitter is
    configured for an internally generated bit clock.

So this patch adds these clocks to the driver and their clock controls.

Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
---
 .../devicetree/bindings/sound/fsl-sai.txt          |  8 ++--
 sound/soc/fsl/fsl_sai.c                            | 50 ++++++++++++++++++++--
 sound/soc/fsl/fsl_sai.h                            |  4 ++
 3 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
index 35c09fe..8a273bc 100644
--- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
+++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
@@ -10,7 +10,8 @@ Required properties:
 - compatible: Compatible list, contains "fsl,vf610-sai" or "fsl,imx6sx-sai".
 - reg: Offset and length of the register set for the device.
 - clocks: Must contain an entry for each entry in clock-names.
-- clock-names : Must include the "sai" entry.
+- clock-names : Must include the "bus" for register access and "mclk1" "mclk2"
+  "mclk3" for bit clock and frame clock providing.
 - dmas : Generic dma devicetree binding as described in
   Documentation/devicetree/bindings/dma/dma.txt.
 - dma-names : Two dmas have to be defined, "tx" and "rx".
@@ -30,8 +31,9 @@ sai2: sai@40031000 {
 	      reg = <0x40031000 0x1000>;
 	      pinctrl-names = "default";
 	      pinctrl-0 = <&pinctrl_sai2_1>;
-	      clocks = <&clks VF610_CLK_SAI2>;
-	      clock-names = "sai";
+	      clocks = <&clks VF610_CLK_SAI2>, <&clks VF610_CLK_SAI2>
+		      <&clks 0>, <&clks 0>;
+	      clock-names = "bus", "mclk1", "mclk2", "mclk3";
 	      dma-names = "tx", "rx";
 	      dmas = <&edma0 0 VF610_EDMA_MUXID0_SAI2_TX>,
 		   <&edma0 0 VF610_EDMA_MUXID0_SAI2_RX>;
diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 9cd1764..99051c7 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -401,7 +401,22 @@ static int fsl_sai_startup(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *cpu_dai)
 {
 	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
-	u32 reg;
+	struct device *dev = &sai->pdev->dev;
+	u32 reg, ret, i;
+
+	ret = clk_prepare_enable(sai->bus_clk);
+	if (ret) {
+		dev_err(dev, "failed to enable bus clock\n");
+		return ret;
+	}
+
+	for (i = 0; i < FSL_SAI_MCLK_MAX; i++) {
+		ret = clk_prepare_enable(sai->mclk_clk[i]);
+		if (ret) {
+			dev_err(dev, "failed to enable mclk%d clock\n", i + 1);
+			goto err;
+		}
+	}
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		reg = FSL_SAI_TCR3;
@@ -412,13 +427,20 @@ static int fsl_sai_startup(struct snd_pcm_substream *substream,
 			   FSL_SAI_CR3_TRCE);
 
 	return 0;
+
+err:
+	for (; i > 0; i--)
+		clk_disable_unprepare(sai->mclk_clk[i - 1]);
+	clk_disable_unprepare(sai->bus_clk);
+
+	return ret;
 }
 
 static void fsl_sai_shutdown(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *cpu_dai)
 {
 	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
-	u32 reg;
+	u32 reg, i;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		reg = FSL_SAI_TCR3;
@@ -427,6 +449,10 @@ static void fsl_sai_shutdown(struct snd_pcm_substream *substream,
 
 	regmap_update_bits(sai->regmap, reg, FSL_SAI_CR3_TRCE,
 			   ~FSL_SAI_CR3_TRCE);
+
+	for (i = 0; i < FSL_SAI_MCLK_MAX; i++)
+		clk_disable_unprepare(sai->mclk_clk[i]);
+	clk_disable_unprepare(sai->bus_clk);
 }
 
 static const struct snd_soc_dai_ops fsl_sai_pcm_dai_ops = {
@@ -559,7 +585,8 @@ static int fsl_sai_probe(struct platform_device *pdev)
 	struct fsl_sai *sai;
 	struct resource *res;
 	void __iomem *base;
-	int irq, ret;
+	char tmp[8];
+	int irq, ret, i;
 
 	sai = devm_kzalloc(&pdev->dev, sizeof(*sai), GFP_KERNEL);
 	if (!sai)
@@ -582,12 +609,27 @@ static int fsl_sai_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	sai->regmap = devm_regmap_init_mmio_clk(&pdev->dev,
-			"sai", base, &fsl_sai_regmap_config);
+			"bus", base, &fsl_sai_regmap_config);
 	if (IS_ERR(sai->regmap)) {
 		dev_err(&pdev->dev, "regmap init failed\n");
 		return PTR_ERR(sai->regmap);
 	}
 
+	sai->bus_clk = devm_clk_get(&pdev->dev, "bus");
+	if (IS_ERR(sai->bus_clk)) {
+		dev_err(&pdev->dev, "failed to get bus clock\n");
+		return PTR_ERR(sai->bus_clk);
+	}
+
+	for (i = 0; i < FSL_SAI_MCLK_MAX; i++) {
+		sprintf(tmp, "mclk%d", i + 1);
+		sai->mclk_clk[i] = devm_clk_get(&pdev->dev, tmp);
+		if (IS_ERR(sai->mclk_clk[i])) {
+			dev_err(&pdev->dev, "failed to get mclk%d clock\n", i + 1);
+			return PTR_ERR(sai->mclk_clk[i]);
+		}
+	}
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "no irq for node %s\n", np->full_name);
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index 677670d..0e6c9f5 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -119,6 +119,8 @@
 #define FSL_SAI_CLK_MAST2	2
 #define FSL_SAI_CLK_MAST3	3
 
+#define FSL_SAI_MCLK_MAX	3
+
 /* SAI data transfer numbers per DMA request */
 #define FSL_SAI_MAXBURST_TX 6
 #define FSL_SAI_MAXBURST_RX 6
@@ -126,6 +128,8 @@
 struct fsl_sai {
 	struct platform_device *pdev;
 	struct regmap *regmap;
+	struct clk *bus_clk;
+	struct clk *mclk_clk[FSL_SAI_MCLK_MAX];
 
 	bool big_endian_regs;
 	bool big_endian_data;
-- 
1.8.4
