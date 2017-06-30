Return-Path: <garsilva@embeddedor.com>
Received: from gateway32.websitewelcome.com (gateway32.websitewelcome.com
 [192.185.145.171])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wzs2m6PCFzDr8Z
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Jul 2017 08:41:36 +1000 (AEST)
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
 by gateway32.websitewelcome.com (Postfix) with ESMTP id 6375F15931E
 for <linuxppc-dev@lists.ozlabs.org>;
 Fri, 30 Jun 2017 17:17:37 -0500 (CDT)
Date: Fri, 30 Jun 2017 17:17:35 -0500
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] ASoC: imx-ssi: add check on platform_get_irq return value
Message-ID: <20170630221735.GA17951@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Check return value from call to platform_get_irq(),
so in case of failure print error message and propagate
the return value.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 sound/soc/fsl/imx-ssi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index b95132e..0679061 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -527,6 +527,10 @@ static int imx_ssi_probe(struct platform_device *pdev)
 	}
 
 	ssi->irq = platform_get_irq(pdev, 0);
+	if (ssi->irq < 0) {
+		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", ssi->irq);
+		return ssi->irq;
+	}
 
 	ssi->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(ssi->clk)) {
-- 
2.5.0
