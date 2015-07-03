Return-Path: <jbe@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2C68B1A0099
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jul 2015 20:58:03 +1000 (AEST)
From: Juergen Borleis <jbe@pengutronix.de>
To: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Timur Tabi <timur@tabi.org>, kernel@pengutronix.de,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ASoC: fsl-ssi: Fix bitclock calculation for master mode
Date: Fri,  3 Jul 2015 12:39:36 +0200
Message-Id: <1435919976-1667-1-git-send-email-jbe@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

According to the datasheet 'pm', 'psr' and 'div2' should never be all 0.
Since commit 541b03ad6cfe ("ASoC: fsl_ssi: Fix the incorrect limitation of
the bit clock rate") this can happen, because for some bitclock rates
'pm' = 0 seems to be a valid choice but does not work due to hardware
restrictions. This results into a bad hardware behaviour (slow audio for
example). Feature tested on a i.MX25.

Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index c7647e0..c0b940e 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -633,7 +633,7 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 		sub *= 100000;
 		do_div(sub, freq);
 
-		if (sub < savesub) {
+		if (sub < savesub && !(i == 0 && psr == 0 && div2 == 0)) {
 			baudrate = tmprate;
 			savesub = sub;
 			pm = i;
-- 
2.1.4
