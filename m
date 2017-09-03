Return-Path: <colin.king@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xlZGT1MFSzDqYy
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Sep 2017 23:54:24 +1000 (AEST)
From: Colin King <colin.king@canonical.com>
To: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl_spdif: make const arrays rate static
Date: Sun,  3 Sep 2017 14:54:08 +0100
Message-Id: <20170903135408.7602-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Colin Ian King <colin.king@canonical.com>

Don't populate the const arrays rate on the stack, instead make them
static. Makes the object code smaller by 220 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
  24385	   9776	    128	  34289	   85f1	sound/soc/fsl/fsl_spdif.o

After:
   text	   data	    bss	    dec	    hex	filename
  24005	   9936	    128	  34069	   8515	sound/soc/fsl/fsl_spdif.o

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/fsl/fsl_spdif.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 7e6cc4da0088..4f7469c1864c 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -1110,7 +1110,7 @@ static u32 fsl_spdif_txclk_caldiv(struct fsl_spdif_priv *spdif_priv,
 				struct clk *clk, u64 savesub,
 				enum spdif_txrate index, bool round)
 {
-	const u32 rate[] = { 32000, 44100, 48000, 96000, 192000 };
+	static const u32 rate[] = { 32000, 44100, 48000, 96000, 192000 };
 	bool is_sysclk = clk_is_match(clk, spdif_priv->sysclk);
 	u64 rate_ideal, rate_actual, sub;
 	u32 sysclk_dfmin, sysclk_dfmax;
@@ -1169,7 +1169,7 @@ static u32 fsl_spdif_txclk_caldiv(struct fsl_spdif_priv *spdif_priv,
 static int fsl_spdif_probe_txclk(struct fsl_spdif_priv *spdif_priv,
 				enum spdif_txrate index)
 {
-	const u32 rate[] = { 32000, 44100, 48000, 96000, 192000 };
+	static const u32 rate[] = { 32000, 44100, 48000, 96000, 192000 };
 	struct platform_device *pdev = spdif_priv->pdev;
 	struct device *dev = &pdev->dev;
 	u64 savesub = 100000, ret;
-- 
2.14.1
