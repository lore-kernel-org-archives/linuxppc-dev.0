Return-Path: <robherring2@gmail.com>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xBtxX6krRzDrKX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 07:45:20 +1000 (AEST)
Received: by mail-pg0-f65.google.com with SMTP id v190so4355187pgv.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 14:45:20 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: Takashi Iwai <tiwai@suse.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] sound: fsl_dma: remove dma_object path member
Date: Tue, 18 Jul 2017 16:43:39 -0500
Message-Id: <20170718214339.7774-59-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

dma_object.path is unused, so rather than fix it to work with DT
full_name changes, just remove it.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Timur Tabi <timur@tabi.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Cc: linuxppc-dev@lists.ozlabs.org
---
 sound/soc/fsl/fsl_dma.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index ccadefceeff2..b38dd328c783 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -63,7 +63,6 @@ struct dma_object {
 	struct ccsr_dma_channel __iomem *channel;
 	unsigned int irq;
 	bool assigned;
-	char path[1];
 };

 /*
@@ -897,20 +896,19 @@ static int fsl_soc_dma_probe(struct platform_device *pdev)

 	ret = of_address_to_resource(ssi_np, 0, &res);
 	if (ret) {
-		dev_err(&pdev->dev, "could not determine resources for %s\n",
-			ssi_np->full_name);
+		dev_err(&pdev->dev, "could not determine resources for %pOF\n",
+			ssi_np);
 		of_node_put(ssi_np);
 		return ret;
 	}

-	dma = kzalloc(sizeof(*dma) + strlen(np->full_name), GFP_KERNEL);
+	dma = kzalloc(sizeof(*dma), GFP_KERNEL);
 	if (!dma) {
 		dev_err(&pdev->dev, "could not allocate dma object\n");
 		of_node_put(ssi_np);
 		return -ENOMEM;
 	}

-	strcpy(dma->path, np->full_name);
 	dma->dai.ops = &fsl_dma_ops;
 	dma->dai.pcm_new = fsl_dma_new;
 	dma->dai.pcm_free = fsl_dma_free_dma_buffers;
--
2.11.0
