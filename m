Return-Path: <shc_work@mail.ru>
Received: from fallback1.mail.ru (fallback1.mail.ru [94.100.176.18])
 by ozlabs.org (Postfix) with ESMTP id F09512C00B0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jan 2014 17:05:18 +1100 (EST)
Received: from smtp32.i.mail.ru (smtp32.i.mail.ru [94.100.177.92])
 by fallback1.mail.ru (mPOP.Fallback_MX) with ESMTP id E949031FDCA4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jan 2014 10:05:16 +0400 (MSK)
From: Alexander Shiyan <shc_work@mail.ru>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: fsl_ssi: Fixed wrong printf format identifier
Date: Tue,  7 Jan 2014 10:04:50 +0400
Message-Id: <1389074690-21654-1-git-send-email-shc_work@mail.ru>
Cc: Alexander Shiyan <shc_work@mail.ru>, Liam Girdwood <lgirdwood@gmail.com>,
 Takashi Iwai <tiwai@suse.de>, Timur Tabi <timur@tabi.org>,
 Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

sound/soc/fsl/fsl_ssi.c: In function 'fsl_ssi_probe':
sound/soc/fsl/fsl_ssi.c:1180:6: warning: format '%d' expects argument
of type 'int', but argument 3 has type 'long int' [-Wformat=]

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 sound/soc/fsl/fsl_ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 3d74477a..c9d567c 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1192,7 +1192,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		 */
 		ssi_private->baudclk = devm_clk_get(&pdev->dev, "baud");
 		if (IS_ERR(ssi_private->baudclk))
-			dev_warn(&pdev->dev, "could not get baud clock: %d\n",
+			dev_warn(&pdev->dev, "could not get baud clock: %ld\n",
 				 PTR_ERR(ssi_private->baudclk));
 		else
 			clk_prepare_enable(ssi_private->baudclk);
-- 
1.8.3.2
