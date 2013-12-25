Return-Path: <Li.Xiubo@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 022C82C007C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Dec 2013 15:13:30 +1100 (EST)
From: Xiubo Li <Li.Xiubo@freescale.com>
To: <broonie@kernel.org>
Subject: [PATCH] ASoC: fsl_sai: Move the global registers setting to
 _dai_probe()
Date: Wed, 25 Dec 2013 11:20:14 +0800
Message-ID: <1387941614-7629-1-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de,
 linux-kernel@vger.kernel.org, timur@tabi.org, perex@perex.cz,
 shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org, b47053@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Because we cannot make sure which one of _dai_fmt() and _dai_sysclk()
will be firstly called. So move the RCSR/TCSR and TCR1/RCR1's
initialization to _dai_probe(), and this can make sure that before any
of {T,R}CR{1~5} register to be set the RCSR/TCSR's RE/TE bit has been
cleared for the hareware limitation.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/fsl/fsl_sai.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index b72132f..596aabb 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -100,11 +100,6 @@ static int fsl_sai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 	if (ret)
 		return ret;
 
-	sai_writel(sai, 0x0, sai->base + FSL_SAI_RCSR);
-	sai_writel(sai, 0x0, sai->base + FSL_SAI_TCSR);
-	sai_writel(sai, FSL_SAI_MAXBURST_TX * 2, sai->base + FSL_SAI_TCR1);
-	sai_writel(sai, FSL_SAI_MAXBURST_RX - 1, sai->base + FSL_SAI_RCR1);
-
 	ret = fsl_sai_set_dai_sysclk_tr(cpu_dai, clk_id, freq,
 					FSL_FMT_TRANSMITTER);
 	if (ret) {
@@ -351,6 +346,18 @@ static const struct snd_soc_dai_ops fsl_sai_pcm_dai_ops = {
 static int fsl_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 {
 	struct fsl_sai *sai = dev_get_drvdata(cpu_dai->dev);
+	int ret;
+
+	ret = clk_prepare_enable(sai->clk);
+	if (ret)
+		return ret;
+
+	sai_writel(sai, 0x0, sai->base + FSL_SAI_RCSR);
+	sai_writel(sai, 0x0, sai->base + FSL_SAI_TCSR);
+	sai_writel(sai, FSL_SAI_MAXBURST_TX * 2, sai->base + FSL_SAI_TCR1);
+	sai_writel(sai, FSL_SAI_MAXBURST_RX - 1, sai->base + FSL_SAI_RCR1);
+
+	clk_disable_unprepare(sai->clk);
 
 	snd_soc_dai_init_dma_data(cpu_dai, &sai->dma_params_tx,
 				&sai->dma_params_rx);
-- 
1.8.4
