Return-Path: <groeck7@gmail.com>
Received: from mail-pb0-x22c.google.com (mail-pb0-x22c.google.com
 [IPv6:2607:f8b0:400e:c01::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 28EBC1A032B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2014 17:19:53 +1000 (EST)
Received: by mail-pb0-f44.google.com with SMTP id rq2so7113521pbb.31
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2014 00:19:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] ASoC: fsl: Fix build problem
Date: Wed, 11 Jun 2014 00:13:52 -0700
Message-Id: <1402470832-24889-1-git-send-email-linux@roeck-us.net>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 Takashi Iwai <tiwai@suse.de>, Timur Tabi <timur@tabi.org>,
 Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>,
 Markus Pargmann <mpa@pengutronix.de>, Guenter Roeck <linux@roeck-us.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 432481220 (ASoC: fsl-ssi: Use regmap) removed struct ccsr_ssi.
Unfortunately, the structure is still used. This causes
mpc85xx_smp_defconfig and mpc85xx_defconfig builds to fail with

sound/soc/fsl/fsl_dma.c:926:50:
  error: invalid use of undefined type 'struct ccsr_ssi'
  dma->ssi_stx_phys = res.start + offsetof(struct ccsr_ssi, stx0);
ound/soc/fsl/fsl_dma.c:927:50:
  error: invalid use of undefined type 'struct ccsr_ssi'
  dma->ssi_srx_phys = res.start + offsetof(struct ccsr_ssi, srx0);

Fix by using constants, similar to original commit.

Cc: Markus Pargmann <mpa@pengutronix.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 sound/soc/fsl/fsl_dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index 6bb0ea5..a609aaf 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -923,8 +923,8 @@ static int fsl_soc_dma_probe(struct platform_device *pdev)
 	dma->dai.pcm_free = fsl_dma_free_dma_buffers;
 
 	/* Store the SSI-specific information that we need */
-	dma->ssi_stx_phys = res.start + offsetof(struct ccsr_ssi, stx0);
-	dma->ssi_srx_phys = res.start + offsetof(struct ccsr_ssi, srx0);
+	dma->ssi_stx_phys = res.start + CCSR_SSI_STX0;
+	dma->ssi_srx_phys = res.start + CCSR_SSI_SRX0;
 
 	iprop = of_get_property(ssi_np, "fsl,fifo-depth", NULL);
 	if (iprop)
-- 
1.9.1
