Return-Path: <gustavo@embeddedor.com>
Received: from gateway34.websitewelcome.com (gateway34.websitewelcome.com
 [192.185.149.46])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41LNwz6LM3zF1LJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2018 00:41:55 +1000 (AEST)
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
 by gateway34.websitewelcome.com (Postfix) with ESMTP id 865E217AC80
 for <linuxppc-dev@lists.ozlabs.org>;
 Wed,  4 Jul 2018 09:19:16 -0500 (CDT)
Date: Wed, 4 Jul 2018 09:18:33 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ASoC: fsl_spdif: Use 64-bit arithmetic instead of 32-bit
Message-ID: <20180704141833.GA6702@embeddedor.com>
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

Add suffix ULL to constant 64 in order to give the compiler complete
information about the proper arithmetic to use.

Notice that such constant is used in a context that expects an
expression of type u64 (64 bits, unsigned) and the following
expression is currently being evaluated using 32-bit arithmetic:

rate[index] * txclk_df * 64

Addresses-Coverity-ID: 1222129 ("Unintentional integer overflow")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/fsl/fsl_spdif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 9b59d87..740b90d 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -1118,7 +1118,7 @@ static u32 fsl_spdif_txclk_caldiv(struct fsl_spdif_priv *spdif_priv,
 
 	for (sysclk_df = sysclk_dfmin; sysclk_df <= sysclk_dfmax; sysclk_df++) {
 		for (txclk_df = 1; txclk_df <= 128; txclk_df++) {
-			rate_ideal = rate[index] * txclk_df * 64;
+			rate_ideal = rate[index] * txclk_df * 64ULL;
 			if (round)
 				rate_actual = clk_round_rate(clk, rate_ideal);
 			else
-- 
2.7.4
