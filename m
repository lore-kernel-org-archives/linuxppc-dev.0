Return-Path: <broonie@sirena.org.uk>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znFJH2kYszF1St
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 00:17:19 +1100 (AEDT)
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Caleb Crome <caleb@crome.org>,
 Maciej S. Szmigiero <mail@maciej.szmigiero.name>,
 Mark Brown <broonie@kernel.org>, timur@tabi.org, broonie@kernel.org,
 mail@maciej.szmigiero.name, alsa-devel@alsa-project.org, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, caleb@crome.org, lgirdwood@gmail.com,
 arnaud.mouiche@invoxia.com, lukma@denx.de, fabio.estevam@nxp.com,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: fsl_ssi: Keep ssi->i2s_net updated" to the asoc tree
In-Reply-To: <1515652995-15996-2-git-send-email-nicoleotsuka@gmail.com>
Message-Id: <E1eoqkI-0006TJ-Ih@debutante>
Date: Thu, 22 Feb 2018 13:17:10 +0000
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch

   ASoC: fsl_ssi: Keep ssi->i2s_net updated

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

>From ebf08ae3bc906fc5dd33d02977efa5d4b9831517 Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Mon, 12 Feb 2018 14:03:10 -0800
Subject: [PATCH] ASoC: fsl_ssi: Keep ssi->i2s_net updated

The hw_params() overwrites i2s_net settings for special cases like
mono-channel support, however, it doesn't update ssi->i2s_net as
set_dai_fmt() does.

This patch removes the local i2s_net variable and directly updates
ssi->i2s_net in the hw_params() so that the driver can simply look
up the ssi->i2s_net instead of reading the register.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 3c8dd609e42e..d4f1f0d64136 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -838,16 +838,16 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	if (!fsl_ssi_is_ac97(ssi)) {
-		u8 i2s_net;
 		/* Normal + Network mode to send 16-bit data in 32-bit frames */
 		if (fsl_ssi_is_i2s_cbm_cfs(ssi) && sample_size == 16)
-			i2s_net = SSI_SCR_I2S_MODE_NORMAL | SSI_SCR_NET;
-		else
-			i2s_net = ssi->i2s_net;
+			ssi->i2s_net = SSI_SCR_I2S_MODE_NORMAL | SSI_SCR_NET;
+
+		/* Use Normal mode to send mono data at 1st slot of 2 slots */
+		if (channels == 1)
+			ssi->i2s_net = SSI_SCR_I2S_MODE_NORMAL;
 
 		regmap_update_bits(regs, REG_SSI_SCR,
-				   SSI_SCR_I2S_NET_MASK,
-				   channels == 1 ? 0 : i2s_net);
+				   SSI_SCR_I2S_NET_MASK, ssi->i2s_net);
 	}
 
 	/* In synchronous mode, the SSI uses STCCR for capture */
-- 
2.16.1
