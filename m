Return-Path: <Jiada_Wang@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 814E91A04C0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 16:55:16 +1100 (AEDT)
From: Jiada Wang <jiada_wang@mentor.com>
To: <timur@tabi.org>, <festevam@gmail.com>, <lars@metafoo.de>,
 <arnd@arndb.de>, <broonie@kernel.org>, <mpa@pengutronix.de>
Subject: [PATCH v2 2/2] ASoC: fsl_ssi: use platform_get_irq instead of
 irq_of_parse_and_map
Date: Tue, 2 Dec 2014 14:55:07 +0900
Message-ID: <1417499707-3125-3-git-send-email-jiada_wang@mentor.com>
In-Reply-To: <1417499707-3125-1-git-send-email-jiada_wang@mentor.com>
References: <1417499707-3125-1-git-send-email-jiada_wang@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org,
 lgirdwood@gmail.com, nicoleotsuka@gmail.com, Li.Xiubo@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use platform_get_irq as no mapping needs to be done.
By using platform_get_irq, driver can avoid to free IRQ manually
when SSI driver exits.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 sound/soc/fsl/fsl_ssi.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index e19ed39..a7a9eb8 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1363,7 +1363,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		return PTR_ERR(ssi_private->regs);
 	}
 
-	ssi_private->irq = irq_of_parse_and_map(np, 0);
+	ssi_private->irq = platform_get_irq(pdev, 0);
 	if (!ssi_private->irq) {
 		dev_err(&pdev->dev, "no irq for node %s\n", np->full_name);
 		return -ENXIO;
@@ -1389,7 +1389,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	if (ssi_private->soc->imx) {
 		ret = fsl_ssi_imx_probe(pdev, ssi_private, iomem);
 		if (ret)
-			goto error_irqmap;
+			return ret;
 	}
 
 	ret = snd_soc_register_component(&pdev->dev, &fsl_ssi_component,
@@ -1460,10 +1460,6 @@ error_asoc_register:
 	if (ssi_private->soc->imx)
 		fsl_ssi_imx_clean(pdev, ssi_private);
 
-error_irqmap:
-	if (ssi_private->use_dma)
-		irq_dispose_mapping(ssi_private->irq);
-
 	return ret;
 }
 
@@ -1480,9 +1476,6 @@ static int fsl_ssi_remove(struct platform_device *pdev)
 	if (ssi_private->soc->imx)
 		fsl_ssi_imx_clean(pdev, ssi_private);
 
-	if (ssi_private->use_dma)
-		irq_dispose_mapping(ssi_private->irq);
-
 	return 0;
 }
 
-- 
1.9.3
