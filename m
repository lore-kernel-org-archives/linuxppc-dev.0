Return-Path: <groeck7@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zF4YJ0TSgzF0RK
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Jan 2018 04:05:55 +1100 (AEDT)
Received: by mail-pl0-x242.google.com with SMTP id d21so6272088pll.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 07 Jan 2018 09:05:55 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>, Nicolin Chen <nicoleotsuka@gmail.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Timur Tabi <timur@tabi.org>
Subject: [PATCH -next] ASoC: fsl_ssi: Fix build error
Date: Sun,  7 Jan 2018 09:05:50 -0800
Message-Id: <1515344750-6159-1-git-send-email-linux@roeck-us.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc:mpc85xx_defconfig fails to build with the following errors.

sound/soc/fsl/fsl_dma.c: In function 'fsl_soc_dma_probe':
sound/soc/fsl/fsl_dma.c:916:34: error: 'CCSR_SSI_STX0' undeclared
sound/soc/fsl/fsl_dma.c:917:34: error: 'CCSR_SSI_SRX0' undeclared

Fixes: a818aa5f967b ("ASoC: fsl_ssi: Rename registers and fields macros")
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Cc: Timur Tabi <timur@tabi.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
I would suggest to merge this patch into the offending patch to preserve
bisectability.

 sound/soc/fsl/fsl_dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index 0c11f434a374..8c2981b70f64 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -913,8 +913,8 @@ static int fsl_soc_dma_probe(struct platform_device *pdev)
 	dma->dai.pcm_free = fsl_dma_free_dma_buffers;
 
 	/* Store the SSI-specific information that we need */
-	dma->ssi_stx_phys = res.start + CCSR_SSI_STX0;
-	dma->ssi_srx_phys = res.start + CCSR_SSI_SRX0;
+	dma->ssi_stx_phys = res.start + REG_SSI_STX0;
+	dma->ssi_srx_phys = res.start + REG_SSI_SRX0;
 
 	iprop = of_get_property(ssi_np, "fsl,fifo-depth", NULL);
 	if (iprop)
-- 
2.7.4
