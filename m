Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zKgDd4ZN7zF0ZG
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jan 2018 15:22:25 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id a88so5972343pfe.12
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Jan 2018 20:22:25 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: timur@tabi.org,
	broonie@kernel.org,
	mail@maciej.szmigiero.name
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, lgirdwood@gmail.com, fabio.estevam@nxp.com,
 caleb@crome.org, arnaud.mouiche@invoxia.com, lukma@denx.de,
 kernel@pengutronix.de
Subject: [PATCH v3 08/17] ASoC: fsl_ssi: Add DAIFMT define for AC97
Date: Sun, 14 Jan 2018 20:21:18 -0800
Message-Id: <1515990087-11598-9-git-send-email-nicoleotsuka@gmail.com>
In-Reply-To: <1515990087-11598-1-git-send-email-nicoleotsuka@gmail.com>
References: <1515990087-11598-1-git-send-email-nicoleotsuka@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The _fsl_ssi_set_dai_fmt() bypasses an undefined format for AC97
mode. However, it's not really necessary if AC97 has its complete
format defined.

So this patch adds a DAIFMT macro of complete format including a
clock direction and polarity.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
---
 sound/soc/fsl/fsl_ssi.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 7a6a32b..b76a517 100644
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
2.7.4
