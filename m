Return-Path: <B42378@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 95C3C2C0390
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 23:33:38 +1100 (EST)
From: Nicolin Chen <b42378@freescale.com>
To: <timur@tabi.org>, <shawn.guo@linaro.org>, <broonie@kernel.org>
Subject: [PATCH 2/3] ASoC: fsl_ssi: Add dual fifo mode support
Date: Tue, 29 Oct 2013 20:33:16 +0800
Message-ID: <02f8867363ed3038a0a70703856e4b642fef4339.1383047327.git.b42378@freescale.com>
In-Reply-To: <cover.1383047327.git.b42378@freescale.com>
References: <cover.1383047327.git.b42378@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, pawel.moll@arm.com, linux-doc@vger.kernel.org,
 s.hauer@pengutronix.de, swarren@wwwdotorg.org, linux-kernel@vger.kernel.org,
 rob.herring@calxeda.com, b32955@freescale.com, dmaengine@vger.kernel.org,
 ijc+devicetree@hellion.org.uk, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

By enabling dual fifo mode, it would allow SSI enter a better performance
to transimit/receive data without occasional hardware underrun/overrun.

[ Passed compile-test with mpc85xx_defconfig ]

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 sound/soc/fsl/fsl_ssi.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 3797bf0..7ad01ce 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -146,6 +146,7 @@ struct fsl_ssi_private {
 	bool ssi_on_imx;
 	bool imx_ac97;
 	bool use_dma;
+	bool use_dual_fifo;
 	struct clk *clk;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
@@ -416,6 +417,16 @@ static int fsl_ssi_setup(struct fsl_ssi_private *ssi_private)
 		write_ssi(CCSR_SSI_SOR_WAIT(3), &ssi->sor);
 	}
 
+	if (ssi_private->use_dual_fifo) {
+		write_ssi_mask(&ssi->srcr, 0, CCSR_SSI_SRCR_RFEN1);
+		write_ssi_mask(&ssi->stcr, 0, CCSR_SSI_STCR_TFEN1);
+		write_ssi_mask(&ssi->scr, 0, CCSR_SSI_SCR_TCH_EN);
+	} else {
+		write_ssi_mask(&ssi->srcr, CCSR_SSI_SRCR_RFEN1, 0);
+		write_ssi_mask(&ssi->stcr, CCSR_SSI_STCR_TFEN1, 0);
+		write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_TCH_EN, 0);
+	}
+
 	return 0;
 }
 
@@ -952,7 +963,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		ssi_private->fifo_depth = 8;
 
 	if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx21-ssi")) {
-		u32 dma_events[2];
+		u32 dma_events[2], dmas[4];
 		ssi_private->ssi_on_imx = true;
 
 		ssi_private->clk = devm_clk_get(&pdev->dev, NULL);
@@ -1006,6 +1017,17 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 			dma_events[0], shared ? IMX_DMATYPE_SSI_SP : IMX_DMATYPE_SSI);
 		imx_pcm_dma_params_init_data(&ssi_private->filter_data_rx,
 			dma_events[1], shared ? IMX_DMATYPE_SSI_SP : IMX_DMATYPE_SSI);
+		if (!of_property_read_u32_array(pdev->dev.of_node, "dmas", dmas, 4)
+				&& dmas[2] == IMX_DMATYPE_SSI_DUAL) {
+			ssi_private->use_dual_fifo = true;
+			/* When using dual fifo mode, we need to keep watermark
+			 * as even numbers due to dma script limitation.
+			 */
+			ssi_private->dma_params_tx.maxburst /= 2;
+			ssi_private->dma_params_tx.maxburst *= 2;
+			ssi_private->dma_params_rx.maxburst /= 2;
+			ssi_private->dma_params_rx.maxburst *= 2;
+		}
 	} else if (ssi_private->use_dma) {
 		/* The 'name' should not have any slashes in it. */
 		ret = devm_request_irq(&pdev->dev, ssi_private->irq,
-- 
1.8.4
