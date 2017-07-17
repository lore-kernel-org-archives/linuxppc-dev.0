Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xB7Sg5CgPzDrDd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 02:06:10 +1000 (AEST)
From: Mark Brown <broonie@kernel.org>
To: Gustavo A. R. Silva <garsilva@embeddedor.com>
Cc: Mark Brown <broonie@kernel.org>, Timur Tabi <timur@tabi.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20170713071925.GA32343@embeddedgus>
Message-Id: <E1dX8WS-0004m0-3i@debutante>
Date: Mon, 17 Jul 2017 17:05:24 +0100
Subject: Applied "ASoC: fsl_esai: constify snd_soc_dai_ops structure" to the
 asoc tree
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch

   ASoC: fsl_esai: constify snd_soc_dai_ops structure

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

>From 5d29e95eec1451d35ef6ce5b851fbc8b04f82d39 Mon Sep 17 00:00:00 2001
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Date: Thu, 13 Jul 2017 02:19:25 -0500
Subject: [PATCH] ASoC: fsl_esai: constify snd_soc_dai_ops structure

This structure is only stored in the ops field of a snd_soc_dai_driver
structure. That field is declared const, so snd_soc_dai_ops structures
that have this property can be declared as const also.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_esai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 809a069d490b..cef79a1a620b 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -620,7 +620,7 @@ static int fsl_esai_trigger(struct snd_pcm_substream *substream, int cmd,
 	return 0;
 }
 
-static struct snd_soc_dai_ops fsl_esai_dai_ops = {
+static const struct snd_soc_dai_ops fsl_esai_dai_ops = {
 	.startup = fsl_esai_startup,
 	.shutdown = fsl_esai_shutdown,
 	.trigger = fsl_esai_trigger,
-- 
2.13.2
