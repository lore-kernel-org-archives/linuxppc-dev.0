Return-Path: <broonie@sirena.org.uk>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1FKh09tHzDx6D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 21:59:52 +1100 (AEDT)
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Maciej S. Szmigiero <mail@maciej.szmigiero.name>,
 Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>,
 broonie@kernel.org, mail@maciej.szmigiero.name, timur@tabi.org,
 kernel@pengutronix.de, lgirdwood@gmail.com, alsa-devel@alsa-project.org,
 caleb@crome.org, linux-kernel@vger.kernel.org, arnaud.mouiche@invoxia.com,
 lukma@denx.de, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org
Subject: Applied "ASoC: fsl_ssi: Rename scr_val to scr" to the asoc tree
In-Reply-To: <1513207108-30430-9-git-send-email-nicoleotsuka@gmail.com>
Message-Id: <E1eRFcf-0000tY-5V@debutante>
Date: Tue, 19 Dec 2017 10:59:45 +0000
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch

   ASoC: fsl_ssi: Rename scr_val to scr

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From ff4adb090066c1636a43b88a497c34d2bd2312ec Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Sun, 17 Dec 2017 18:52:07 -0800
Subject: [PATCH] ASoC: fsl_ssi: Rename scr_val to scr

Simplify the variable name. This reduces one over-80-character line.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Acked-by: Timur Tabi <timur@tabi.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 237302fb9279..af3ba718d4bb 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -451,12 +451,12 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 	struct regmap *regs = ssi->regs;
 	struct fsl_ssi_reg_val *avals;
 	int nr_active_streams;
-	u32 scr_val;
+	u32 scr;
 	int keep_active;
 
-	regmap_read(regs, REG_SSI_SCR, &scr_val);
+	regmap_read(regs, REG_SSI_SCR, &scr);
 
-	nr_active_streams = !!(scr_val & SSI_SCR_TE) + !!(scr_val & SSI_SCR_RE);
+	nr_active_streams = !!(scr & SSI_SCR_TE) + !!(scr & SSI_SCR_RE);
 
 	if (nr_active_streams - 1 > 0)
 		keep_active = 1;
@@ -810,11 +810,11 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 	unsigned int sample_size = params_width(hw_params);
 	u32 wl = SSI_SxCCR_WL(sample_size);
 	int ret;
-	u32 scr_val;
+	u32 scr;
 	int enabled;
 
-	regmap_read(regs, REG_SSI_SCR, &scr_val);
-	enabled = scr_val & SSI_SCR_SSIEN;
+	regmap_read(regs, REG_SSI_SCR, &scr);
+	enabled = scr & SSI_SCR_SSIEN;
 
 	/*
 	 * SSI is properly configured if it is enabled and running in
-- 
2.15.1
