Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTQvk4bVmzDr2g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 23:34:09 +1000 (AEST)
To: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 Fabio Estevam <fabio.estevam@nxp.com>, Jaroslav Kysela <perex@perex.cz>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ASoC: Freescale: Delete an error message for a failed memory
 allocation in three functions
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Message-ID: <671f4a88-bee9-85b4-ea9b-68abcdb40443@users.sourceforge.net>
Date: Fri, 11 Aug 2017 15:32:55 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>From 885ccd6c63291dcd4854a0cbaab5188cdc3db805 Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 11 Aug 2017 15:10:43 +0200
Subject: [PATCH] ASoC: Freescale: Delete an error message for a failed memory allocation in three functions

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/soc/fsl/fsl_asrc_dma.c | 4 +---
 sound/soc/fsl/fsl_dma.c      | 1 -
 sound/soc/fsl/fsl_ssi.c      | 4 +---
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
index 282d841840b1..2baf19608bd0 100644
--- a/sound/soc/fsl/fsl_asrc_dma.c
+++ b/sound/soc/fsl/fsl_asrc_dma.c
@@ -282,7 +282,5 @@ static int fsl_asrc_dma_startup(struct snd_pcm_substream *substream)
-	if (!pair) {
-		dev_err(dev, "failed to allocate pair\n");
+	if (!pair)
 		return -ENOMEM;
-	}
 
 	pair->asrc_priv = asrc_priv;
 
diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index ccadefceeff2..0ce172f86d6c 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -907,5 +907,4 @@ static int fsl_soc_dma_probe(struct platform_device *pdev)
 	if (!dma) {
-		dev_err(&pdev->dev, "could not allocate dma object\n");
 		of_node_put(ssi_np);
 		return -ENOMEM;
 	}
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 173cb8496641..64598d1183f8 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1435,7 +1435,5 @@ static int fsl_ssi_probe(struct platform_device *pdev)
-	if (!ssi_private) {
-		dev_err(&pdev->dev, "could not allocate DAI object\n");
+	if (!ssi_private)
 		return -ENOMEM;
-	}
 
 	ssi_private->soc = of_id->data;
 	ssi_private->dev = &pdev->dev;
-- 
2.14.0
