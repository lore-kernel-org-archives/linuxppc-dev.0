Return-Path: <shengjiu.wang@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0143.outbound.protection.outlook.com [207.46.100.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2BAE01A0387
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 20:19:44 +1100 (AEDT)
From: Shengjiu Wang <shengjiu.wang@freescale.com>
To: <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
 <ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>, <timur@tabi.org>,
 <nicoleotsuka@gmail.com>, <Xiubo.Lee@gmail.com>, <lgirdwood@gmail.com>,
 <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
 <shawnguo@kernel.org>
CC: <alsa-devel@alsa-project.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH V4 2/3] ASoC: fsl_spdif: spba clk is needed by spdif device
Date: Tue, 24 Nov 2015 17:19:33 +0800
Message-ID: <02a93459781754faa531e37abb74470f9c90fafd.1448356624.git.shengjiu.wang@freescale.com>
In-Reply-To: <cover.1448356624.git.shengjiu.wang@freescale.com>
References: <cover.1448356624.git.shengjiu.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

SPDIF need to enable the spba clock, when sdma is using share peripheral
script. In this case, there is two spba master port is used, if don't
enable the clock, the spba bus will have arbitration issue, which may
cause read/write wrong data from/to SPDIF registers.

Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
---
 Documentation/devicetree/bindings/sound/fsl,spdif.txt |  5 +++++
 sound/soc/fsl/fsl_spdif.c                             | 19 +++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.txt b/Documentation/devicetree/bindings/sound/fsl,spdif.txt
index b5ee32e..4ca39dd 100644
--- a/Documentation/devicetree/bindings/sound/fsl,spdif.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,spdif.txt
@@ -27,6 +27,11 @@ Required properties:
 			  Transceiver Clock Diagram" of SoC reference manual.
 			  It can also be referred to TxClk_Source bit of
 			  register SPDIF_STC.
+	"spba"		  The spba clock is required when SPDIF is placed as a
+			  bus slave of the Shared Peripheral Bus and when two
+			  or more bus masters (CPU, DMA or DSP) try to access
+			  it. This property is optional depending on the SoC
+			  design.
 
    - big-endian		: If this property is absent, the native endian mode
 			  will be in use as default, or the big endian mode
diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 28a8823..151849f 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -88,6 +88,7 @@ struct spdif_mixer_control {
  * @rxclk: rx clock sources for capture
  * @coreclk: core clock for register access via DMA
  * @sysclk: system clock for rx clock rate measurement
+ * @spbaclk: SPBA clock (optional, depending on SoC design)
  * @dma_params_tx: DMA parameters for transmit channel
  * @dma_params_rx: DMA parameters for receive channel
  */
@@ -106,6 +107,7 @@ struct fsl_spdif_priv {
 	struct clk *rxclk;
 	struct clk *coreclk;
 	struct clk *sysclk;
+	struct clk *spbaclk;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
 	/* regcache for SRPC */
@@ -474,6 +476,14 @@ static int fsl_spdif_startup(struct snd_pcm_substream *substream,
 			return ret;
 		}
 
+		if (!IS_ERR(spdif_priv->spbaclk)) {
+			ret = clk_prepare_enable(spdif_priv->spbaclk);
+			if (ret) {
+				dev_err(&pdev->dev, "failed to enable spba clock\n");
+				goto err_spbaclk;
+			}
+		}
+
 		ret = spdif_softreset(spdif_priv);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to soft reset\n");
@@ -515,6 +525,9 @@ disable_txclk:
 	for (i--; i >= 0; i--)
 		clk_disable_unprepare(spdif_priv->txclk[i]);
 err:
+	if (!IS_ERR(spdif_priv->spbaclk))
+		clk_disable_unprepare(spdif_priv->spbaclk);
+err_spbaclk:
 	clk_disable_unprepare(spdif_priv->coreclk);
 
 	return ret;
@@ -548,6 +561,8 @@ static void fsl_spdif_shutdown(struct snd_pcm_substream *substream,
 		spdif_intr_status_clear(spdif_priv);
 		regmap_update_bits(regmap, REG_SPDIF_SCR,
 				SCR_LOW_POWER, SCR_LOW_POWER);
+		if (!IS_ERR(spdif_priv->spbaclk))
+			clk_disable_unprepare(spdif_priv->spbaclk);
 		clk_disable_unprepare(spdif_priv->coreclk);
 	}
 }
@@ -1261,6 +1276,10 @@ static int fsl_spdif_probe(struct platform_device *pdev)
 		return PTR_ERR(spdif_priv->coreclk);
 	}
 
+	spdif_priv->spbaclk = devm_clk_get(&pdev->dev, "spba");
+	if (IS_ERR(spdif_priv->spbaclk))
+		dev_warn(&pdev->dev, "no spba clock in devicetree\n");
+
 	/* Select clock source for rx/tx clock */
 	spdif_priv->rxclk = devm_clk_get(&pdev->dev, "rxtx1");
 	if (IS_ERR(spdif_priv->rxclk)) {
-- 
1.9.1
