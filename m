Return-Path: <dan.carpenter@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 37DAF1A2C22
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 01:37:53 +1000 (AEST)
Date: Wed, 10 Jun 2015 18:37:23 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org
Subject: [patch] ASoC: fsl: add an error check
Message-ID: <20150610153723.GB10549@mwanda>
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

My static checker complains that:

	sound/soc/fsl/imx-wm8962.c:196 imx_wm8962_probe() warn:
	we tested 'ret' before and it was 'false'

The intent was that we use "ret" to check imx_audmux_v2_configure_port().

Fixes: 8de2ae2a7f1f ('ASoC: fsl: add imx-wm8962 machine driver')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
I assume checking for an error here will not change anything but I have
not tested this patch.

diff --git a/sound/soc/fsl/imx-wm8962.c b/sound/soc/fsl/imx-wm8962.c
index cd146d4..b38b98c 100644
--- a/sound/soc/fsl/imx-wm8962.c
+++ b/sound/soc/fsl/imx-wm8962.c
@@ -190,7 +190,7 @@ static int imx_wm8962_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "audmux internal port setup failed\n");
 		return ret;
 	}
-	imx_audmux_v2_configure_port(ext_port,
+	ret = imx_audmux_v2_configure_port(ext_port,
 			IMX_AUDMUX_V2_PTCR_SYN,
 			IMX_AUDMUX_V2_PDCR_RXDSEL(int_port));
 	if (ret) {
