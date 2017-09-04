Return-Path: <broonie@sirena.org.uk>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xm8jx5kLZzDqjy
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Sep 2017 22:46:44 +1000 (AEST)
From: Mark Brown <broonie@kernel.org>
To: Colin Ian King <colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Timur Tabi <timur@tabi.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: fsl_spdif: make const arrays rate static" to the asoc
 tree
In-Reply-To: <20170903135408.7602-1-colin.king@canonical.com>
Message-Id: <20170904124635.667A24400FC@finisterre.ee.mobilebroadband>
Date: Mon,  4 Sep 2017 13:46:35 +0100 (BST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch

   ASoC: fsl_spdif: make const arrays rate static

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 2db5f9e9fa0ebc3c023f7ac906946a3eef8f5498 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Sun, 3 Sep 2017 14:54:08 +0100
Subject: [PATCH] ASoC: fsl_spdif: make const arrays rate static

Don't populate the const arrays rate on the stack, instead make them
static. Makes the object code smaller by 220 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
  24385	   9776	    128	  34289	   85f1	sound/soc/fsl/fsl_spdif.o

After:
   text	   data	    bss	    dec	    hex	filename
  24005	   9936	    128	  34069	   8515	sound/soc/fsl/fsl_spdif.o

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.13.2
