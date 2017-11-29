Return-Path: <broonie@sirena.org.uk>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ymyDY30FczDr8f
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Nov 2017 21:57:48 +1100 (AEDT)
From: Mark Brown <broonie@kernel.org>
To: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, alsa-devel@alsa-project.org,
 linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org
Subject: Applied "ASoC: fsl_ssi: call _fsl_ssi_set_dai_fmt() just once in
 AC'97 mode" to the asoc tree
In-Reply-To: <5c2325bd-3e7b-0026-4c1a-65f32737a74a@maciej.szmigiero.name>
Message-Id: <E1eK03e-00061f-6a@debutante>
Date: Wed, 29 Nov 2017 10:57:38 +0000
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch

   ASoC: fsl_ssi: call _fsl_ssi_set_dai_fmt() just once in AC'97 mode

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

>From c997a92a78161af605b314cbe6cf636663999652 Mon Sep 17 00:00:00 2001
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Date: Wed, 22 Nov 2017 00:55:14 +0100
Subject: [PATCH] ASoC: fsl_ssi: call _fsl_ssi_set_dai_fmt() just once in AC'97
 mode

In AC'97 mode we configure and start SSI RX / TX on probe path via
a call to _fsl_ssi_set_dai_fmt() function.
We don't need to call this function again later and in fact don't want to
do it since this function temporarily sets STCR, SRCR and SCR to some
intermediate values.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 9e97a0529f37..939d1b8894dc 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1079,6 +1079,9 @@ static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 {
 	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
 
+	if (fsl_ssi_is_ac97(ssi_private))
+		return 0;
+
 	return _fsl_ssi_set_dai_fmt(cpu_dai->dev, ssi_private, fmt);
 }
 
-- 
2.15.0
