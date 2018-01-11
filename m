Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHGZ84NQ3zF0XQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 17:44:16 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id e11so870486pff.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 22:44:16 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: timur@tabi.org,
	broonie@kernel.org,
	mail@maciej.szmigiero.name
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, lgirdwood@gmail.com, fabio.estevam@nxp.com,
 caleb@crome.org, arnaud.mouiche@invoxia.com, lukma@denx.de,
 kernel@pengutronix.de
Subject: [PATCH v2 10/16] ASoC: fsl_ssi: Use snd_soc_init_dma_data instead
Date: Wed, 10 Jan 2018 22:43:09 -0800
Message-Id: <1515652995-15996-11-git-send-email-nicoleotsuka@gmail.com>
In-Reply-To: <1515652995-15996-1-git-send-email-nicoleotsuka@gmail.com>
References: <1515652995-15996-1-git-send-email-nicoleotsuka@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since there is a helper function, use it to help readability.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
---
 sound/soc/fsl/fsl_ssi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index e75b57d..2c179a7 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1105,10 +1105,9 @@ static int fsl_ssi_dai_probe(struct snd_soc_dai *dai)
 {
 	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(dai);
 
-	if (ssi->soc->imx && ssi->use_dma) {
-		dai->playback_dma_data = &ssi->dma_params_tx;
-		dai->capture_dma_data = &ssi->dma_params_rx;
-	}
+	if (ssi->soc->imx && ssi->use_dma)
+		snd_soc_dai_init_dma_data(dai, &ssi->dma_params_tx,
+					  &ssi->dma_params_rx);
 
 	return 0;
 }
-- 
2.7.4
