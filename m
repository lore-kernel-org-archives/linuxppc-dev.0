Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pa0-x22b.google.com (mail-pa0-x22b.google.com
 [IPv6:2607:f8b0:400e:c03::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8C1E81A0048
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 16:32:00 +1100 (AEDT)
Received: by mail-pa0-f43.google.com with SMTP id fa1so1736528pad.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 21:31:58 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: broonie@kernel.org,
	timur@tabi.org
Subject: [PATCH] ASoC: fsl_ssi: Fix the incorrect limitation of the bit clock
 rate
Date: Tue, 10 Feb 2015 21:31:43 -0800
Message-Id: <1423632703-3683-1-git-send-email-nicoleotsuka@gmail.com>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, scerveau@voxtok.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

According to i.MX Reference Manual, the bit-clock frequency generated
by SSI must be never greater than 1/5 of the peripheral clock frequency.

This peripheral clock, however, is not baudclk but the IPG clock (i.e.
ssi_private->clk in the fsl_ssi driver).

So this patch just simply fixes the incorrect limitation applied to
the bit clock (baudclk) rate.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_ssi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 059496e..d7365c5 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -603,10 +603,6 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 	factor = (div2 + 1) * (7 * psr + 1) * 2;
 
 	for (i = 0; i < 255; i++) {
-		/* The bclk rate must be smaller than 1/5 sysclk rate */
-		if (factor * (i + 1) < 5)
-			continue;
-
 		tmprate = freq * factor * (i + 2);
 
 		if (baudclk_is_used)
@@ -614,6 +610,13 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 		else
 			clkrate = clk_round_rate(ssi_private->baudclk, tmprate);
 
+		/*
+		 * Hardware limitation: The bclk rate must be
+		 * never greater than 1/5 IPG clock rate
+		 */
+		if (clkrate * 5 > clk_get_rate(ssi_private->clk))
+			continue;
+
 		clkrate /= factor;
 		afreq = clkrate / (i + 1);
 
-- 
1.9.1
