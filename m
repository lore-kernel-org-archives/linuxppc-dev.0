Return-Path: <shc_work@mail.ru>
Received: from fallback6.mail.ru (fallback6.mail.ru [94.100.176.134])
 by ozlabs.org (Postfix) with ESMTP id 41A9E2C00B6
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Jan 2014 17:30:05 +1100 (EST)
Received: from smtp12.mail.ru (smtp12.mail.ru [94.100.176.89])
 by fallback6.mail.ru (mPOP.Fallback_MX) with ESMTP id 067662BEEE32
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Jan 2014 10:21:31 +0400 (MSK)
From: Alexander Shiyan <shc_work@mail.ru>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: fsl_ssi: Fix printing return code on clk error
Date: Sun,  5 Jan 2014 10:21:16 +0400
Message-Id: <1388902876-29964-1-git-send-email-shc_work@mail.ru>
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

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 sound/soc/fsl/fsl_ssi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 2101fc5..3d74477a 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1192,7 +1192,8 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		 */
 		ssi_private->baudclk = devm_clk_get(&pdev->dev, "baud");
 		if (IS_ERR(ssi_private->baudclk))
-			dev_warn(&pdev->dev, "could not get baud clock: %d\n", ret);
+			dev_warn(&pdev->dev, "could not get baud clock: %d\n",
+				 PTR_ERR(ssi_private->baudclk));
 		else
 			clk_prepare_enable(ssi_private->baudclk);
 
-- 
1.8.3.2
