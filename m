Return-Path: <broonie@sirena.org.uk>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znFHm5Nq1zDr7t
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 00:16:52 +1100 (AEDT)
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Caleb Crome <caleb@crome.org>,
 Maciej S. Szmigiero <mail@maciej.szmigiero.name>,
 Mark Brown <broonie@kernel.org>, timur@tabi.org, broonie@kernel.org,
 mail@maciej.szmigiero.name, kernel@pengutronix.de, lgirdwood@gmail.com,
 alsa-devel@alsa-project.org, caleb@crome.org, linux-kernel@vger.kernel.org,
 arnaud.mouiche@invoxia.com, lukma@denx.de, fabio.estevam@nxp.com,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: fsl_ssi: Add DAIFMT define for AC97" to the asoc tree
In-Reply-To: <1513702819-42310-7-git-send-email-nicoleotsuka@gmail.com>
Message-Id: <E1eoqjr-0006MG-1N@debutante>
Date: Thu, 22 Feb 2018 13:16:43 +0000
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch

   ASoC: fsl_ssi: Add DAIFMT define for AC97

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From b6c93f7f60a0d0b61c1fce2872b9d4f7263d6ec2 Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Mon, 12 Feb 2018 14:03:16 -0800
Subject: [PATCH] ASoC: fsl_ssi: Add DAIFMT define for AC97

The _fsl_ssi_set_dai_fmt() bypasses an undefined format for AC97
mode. However, it's not really necessary if AC97 has its complete
format defined.

So this patch adds a DAIFMT macro of complete format including a
clock direction and polarity.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 9f024a9afaa5..fc5768d243d1 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -90,6 +90,16 @@
 	 SNDRV_PCM_FMTBIT_S24_LE)
 #endif
 
+/*
+ * In AC97 mode, TXDIR bit is forced to 0 and TFDIR bit is forced to 1:
+ *  - SSI inputs external bit clock and outputs frame sync clock -- CBM_CFS
+ *  - Also have NB_NF to mark these two clocks will not be inverted
+ */
+#define FSLSSI_AC97_DAIFMT \
+	(SND_SOC_DAIFMT_AC97 | \
+	 SND_SOC_DAIFMT_CBM_CFS | \
+	 SND_SOC_DAIFMT_NB_NF)
+
 #define FSLSSI_SIER_DBG_RX_FLAGS \
 	(SSI_SIER_RFF0_EN | \
 	 SSI_SIER_RLS_EN | \
@@ -964,8 +974,7 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 		scr &= ~SSI_SCR_SYS_CLK_EN;
 		break;
 	default:
-		if (!fsl_ssi_is_ac97(ssi))
-			return -EINVAL;
+		return -EINVAL;
 	}
 
 	stcr |= strcr;
@@ -1372,7 +1381,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	sprop = of_get_property(np, "fsl,mode", NULL);
 	if (sprop) {
 		if (!strcmp(sprop, "ac97-slave"))
-			ssi->dai_fmt = SND_SOC_DAIFMT_AC97;
+			ssi->dai_fmt = FSLSSI_AC97_DAIFMT;
 	}
 
 	/* Select DMA or FIQ */
-- 
2.16.1
