Return-Path: <Jiada_Wang@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5C6C31A03D1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 16:55:15 +1100 (AEDT)
From: Jiada Wang <jiada_wang@mentor.com>
To: <timur@tabi.org>, <festevam@gmail.com>, <lars@metafoo.de>,
 <arnd@arndb.de>, <broonie@kernel.org>, <mpa@pengutronix.de>
Subject: [PATCH v2 1/2] ASoC: fsl_ssi: fix error path in probe
Date: Tue, 2 Dec 2014 14:55:06 +0900
Message-ID: <1417499707-3125-2-git-send-email-jiada_wang@mentor.com>
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

SSI component isn't unregistered if fsl_ssi_debugfs_create() fails
in probe phase.

To fix it, this commit replaces label error_asoc_register with
error_irq.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 sound/soc/fsl/fsl_ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index e695517..e19ed39 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1412,7 +1412,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 
 	ret = fsl_ssi_debugfs_create(&ssi_private->dbg_stats, &pdev->dev);
 	if (ret)
-		goto error_asoc_register;
+		goto error_irq;
 
 	/*
 	 * If codec-handle property is missing from SSI node, we assume
-- 
1.9.3
