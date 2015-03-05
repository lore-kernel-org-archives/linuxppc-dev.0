Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pa0-x235.google.com (mail-pa0-x235.google.com
 [IPv6:2607:f8b0:400e:c03::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 03B411A03D1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Mar 2015 16:05:15 +1100 (AEDT)
Received: by pabli10 with SMTP id li10so39598221pab.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2015 21:05:11 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: broonie@kernel.org
Subject: [PATCH] ASoC: fsl_ssi: Don't try to round-up for PM divisor
 calculation
Date: Wed,  4 Mar 2015 21:05:04 -0800
Message-Id: <1425531904-3770-1-git-send-email-nicoleotsuka@gmail.com>
Cc: alsa-devel@alsa-project.org, timur@tabi.org, tiwai@suse.de,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com, perex@perex.cz,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

According to i.MX6 Series Reference Manual, the formula to calculate
the sys clock is

sysclk rate = bclk rate * (div2 + 1) * (7 * psr + 1) * (pm + 1) * 2

Commit aafa85e71a75 ("ASoC: fsl_ssi: Add DAI master mode support for
SSI on i.MX series") added the divisor calculation which relies on
the clk_round_rate(). However, at that time, clk_round_rate() didn't
provide closest clock rates for some cases because it might not use
a correct rounding policy. So using the original formula (pm + 1) for
PM divisor was not able to give us a desired clock rate. And then we
used (pm + 2) to do the trick.

However, the clk-divider driver has been refined a lot since commit
b11d282dbea2 ("clk: divider: fix rate calculation for fractional rates")
Now using (pm + 2) trick would result an incorrect clock rate.

So this patch fixes the problem by removing the useless trick.

Reported-by: Stephane Cerveau <scerveau@voxtok.com>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 05575f4..6b0c8f7 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -603,7 +603,7 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 	factor = (div2 + 1) * (7 * psr + 1) * 2;
 
 	for (i = 0; i < 255; i++) {
-		tmprate = freq * factor * (i + 2);
+		tmprate = freq * factor * (i + 1);
 
 		if (baudclk_is_used)
 			clkrate = clk_get_rate(ssi_private->baudclk);
-- 
1.9.1
