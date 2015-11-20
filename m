Return-Path: <shengjiu.wang@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0133.outbound.protection.outlook.com [207.46.100.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AD95B1A0023
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2015 17:33:45 +1100 (AEDT)
From: Shengjiu Wang <shengjiu.wang@freescale.com>
To: <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
 <ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>, <timur@tabi.org>,
 <nicoleotsuka@gmail.com>, <Xiubo.Lee@gmail.com>, <lgirdwood@gmail.com>,
 <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
 <shawnguo@kernel.org>
CC: <alsa-devel@alsa-project.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH V2 2/3] ASoC: fsl_spdif: spba clk is needed by spdif device
Date: Fri, 20 Nov 2015 14:17:52 +0800
Message-ID: <13b069f41f05e1d37ba7d698b2bb5417639055c3.1447997800.git.shengjiu.wang@freescale.com>
In-Reply-To: <cover.1447997800.git.shengjiu.wang@freescale.com>
References: <cover.1447997800.git.shengjiu.wang@freescale.com>
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
 Documentation/devicetree/bindings/sound/fsl,spdif.txt |  2 ++
 sound/soc/fsl/fsl_spdif.c                             | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.txt b/Documentation/devicetree/bindings/sound/fsl,spdif.txt
index b5ee32e..7bcd9d0 100644
--- a/Documentation/devicetree/bindings/sound/fsl,spdif.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,spdif.txt
@@ -27,6 +27,8 @@ Required properties:
 			  Transceiver Clock Diagram" of SoC reference manual.
 			  It can also be referred to TxClk_Source bit of
 			  register SPDIF_STC.
+	"spba"		  The spba clock is needed when two spba master port
+			  is used.
 
    - big-endian		: If this property is absent, the native endian mode
 			  will be in use as default, or the big endian mode
diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 28a8823..d4b0ba3 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -106,6 +106,7 @@ struct fsl_spdif_priv {
 	struct clk *rxclk;
 	struct clk *coreclk;
 	struct clk *sysclk;
+	struct clk *spbaclk;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
 	/* regcache for SRPC */
@@ -474,6 +475,12 @@ static int fsl_spdif_startup(struct snd_pcm_substream *substream,
 			return ret;
 		}
 
+		ret = clk_prepare_enable(spdif_priv->spbaclk);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to enable spba clock\n");
+			goto err_spbaclk;
+		}
+
 		ret = spdif_softreset(spdif_priv);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to soft reset\n");
@@ -515,6 +522,8 @@ disable_txclk:
 	for (i--; i >= 0; i--)
 		clk_disable_unprepare(spdif_priv->txclk[i]);
 err:
+	clk_disable_unprepare(spdif_priv->spbaclk);
+err_spbaclk:
 	clk_disable_unprepare(spdif_priv->coreclk);
 
 	return ret;
@@ -548,6 +557,7 @@ static void fsl_spdif_shutdown(struct snd_pcm_substream *substream,
 		spdif_intr_status_clear(spdif_priv);
 		regmap_update_bits(regmap, REG_SPDIF_SCR,
 				SCR_LOW_POWER, SCR_LOW_POWER);
+		clk_disable_unprepare(spdif_priv->spbaclk);
 		clk_disable_unprepare(spdif_priv->coreclk);
 	}
 }
@@ -1261,6 +1271,10 @@ static int fsl_spdif_probe(struct platform_device *pdev)
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
