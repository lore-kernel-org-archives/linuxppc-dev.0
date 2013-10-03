Return-Path: <groeck7@gmail.com>
Received: from mail-pb0-x22d.google.com (mail-pb0-x22d.google.com
 [IPv6:2607:f8b0:400e:c01::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7A3302C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2013 14:15:32 +1000 (EST)
Received: by mail-pb0-f45.google.com with SMTP id mc17so1861087pbc.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Oct 2013 21:15:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: fsl_ssi: Fix irq_of_parse_and_map() return value check
Date: Wed,  2 Oct 2013 21:15:22 -0700
Message-Id: <1380773722-1295-1-git-send-email-linux@roeck-us.net>
Cc: Timur Tabi <timur@tabi.org>, Takashi Iwai <tiwai@suse.de>,
 linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Grant Likely <grant.likely@linaro.org>, linuxppc-dev@lists.ozlabs.org,
 Guenter Roeck <linux@roeck-us.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

irq_of_parse_and_map() returns 0 on error, not NO_IRQ.

Fix the following xtensa:allmodconfig build error.

sound/soc/fsl/fsl_ssi.c:705:26: error: 'NO_IRQ' undeclared (first use in this function)
make[4]: *** [sound/soc/fsl/fsl_ssi.o] Error 1

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Grant Likely <grant.likely@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Previously submitted by Grant Likely as part of a different patch set.
See https://lkml.org/lkml/2012/1/11/342.
Also see https://lkml.org/lkml/2013/7/25/642.

 sound/soc/fsl/fsl_ssi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index c6b7439..6b81d0c 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -936,7 +936,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	ssi_private->ssi_phys = res.start;
 
 	ssi_private->irq = irq_of_parse_and_map(np, 0);
-	if (ssi_private->irq == NO_IRQ) {
+	if (ssi_private->irq == 0) {
 		dev_err(&pdev->dev, "no irq for node %s\n", np->full_name);
 		return -ENXIO;
 	}
-- 
1.7.9.7
