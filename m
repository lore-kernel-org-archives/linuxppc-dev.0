Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pd0-x233.google.com (mail-pd0-x233.google.com
 [IPv6:2607:f8b0:400e:c02::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CA9B81A0C90
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 May 2015 18:12:53 +1000 (AEST)
Received: by pdbki1 with SMTP id ki1so7793405pdb.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 May 2015 01:12:50 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
 fabio.estevam@freescale.com, zidan.wang@freescale.com
Subject: [PATCH] ASoC: fsl_spdif: Don't try to round-up for clock divisor
 calculation
Date: Sun, 24 May 2015 01:12:41 -0700
Message-Id: <1432455161-4924-1-git-send-email-nicoleotsuka@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As commit 6c8ca30eec7b ("ASoC: fsl_ssi: Don't try to round-up for PM
divisor calculation") mentioned that there's no more need to use a
round up work around to get a better divisor since the clk-divider
driver has been refined a lot.

So this patch applies the same modification to fsl_spdif driver.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Zidan Wang <zidan.wang@freescale.com>
---

Fabio and Zidan,
Theoretically, it should have the same problem as fsl_ssi driver had.
But I don't have an S/PDIF test environment. So I need your helps to
confirm it. Thank you.

 sound/soc/fsl/fsl_spdif.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 91eb3ae..8e93221 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -417,11 +417,9 @@ static int spdif_set_sample_rate(struct snd_pcm_substream *substream,
 	if (clk != STC_TXCLK_SPDIF_ROOT)
 		goto clk_set_bypass;
 
-	/*
-	 * The S/PDIF block needs a clock of 64 * fs * txclk_df.
-	 * So request 64 * fs * (txclk_df + 1) to get rounded.
-	 */
-	ret = clk_set_rate(spdif_priv->txclk[rate], 64 * sample_rate * (txclk_df + 1));
+	/* The S/PDIF block needs a clock of 64 * fs * txclk_df */
+	ret = clk_set_rate(spdif_priv->txclk[rate],
+			   64 * sample_rate * txclk_df);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to set tx clock rate\n");
 		return ret;
@@ -1060,7 +1058,7 @@ static u32 fsl_spdif_txclk_caldiv(struct fsl_spdif_priv *spdif_priv,
 
 	for (sysclk_df = sysclk_dfmin; sysclk_df <= sysclk_dfmax; sysclk_df++) {
 		for (txclk_df = 1; txclk_df <= 128; txclk_df++) {
-			rate_ideal = rate[index] * (txclk_df + 1) * 64;
+			rate_ideal = rate[index] * txclk_df * 64;
 			if (round)
 				rate_actual = clk_round_rate(clk, rate_ideal);
 			else
-- 
1.9.1
