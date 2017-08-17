Return-Path: <broonie@sirena.org.uk>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYDPm3JG0zDr69
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 03:54:52 +1000 (AEST)
From: Mark Brown <broonie@kernel.org>
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, julia.lawall@lip6.fr, timur@tabi.org,
 nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, fabio.estevam@nxp.com,
 lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 plai@codeaurora.org, bgoswami@codeaurora.org, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org
Subject: Applied "ASoC: sh: make snd_pcm_hardware const" to the asoc tree
In-Reply-To: <1502964972-22722-6-git-send-email-bhumirks@gmail.com>
Message-Id: <E1diOMR-000081-AO@debutante>
Date: Thu, 17 Aug 2017 18:13:35 +0100
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch

   ASoC: sh: make snd_pcm_hardware const

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

>From 5c2e035e69ffff4c8b3f0a2ddfefa102ad9d9d42 Mon Sep 17 00:00:00 2001
From: Bhumika Goyal <bhumirks@gmail.com>
Date: Thu, 17 Aug 2017 15:46:11 +0530
Subject: [PATCH] ASoC: sh: make snd_pcm_hardware const

Make these const as they are only passed as the 2nd argument to the
function snd_soc_set_runtime_hwparams, which is const.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/dma-sh7760.c | 2 +-
 sound/soc/sh/fsi.c        | 2 +-
 sound/soc/sh/rcar/core.c  | 2 +-
 sound/soc/sh/siu_dai.c    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sh/dma-sh7760.c b/sound/soc/sh/dma-sh7760.c
index 35788a6db963..1e7d417b53ef 100644
--- a/sound/soc/sh/dma-sh7760.c
+++ b/sound/soc/sh/dma-sh7760.c
@@ -89,7 +89,7 @@ struct camelot_pcm {
 #define DMABRG_PREALLOC_BUFFER		32 * 1024
 #define DMABRG_PREALLOC_BUFFER_MAX	32 * 1024
 
-static struct snd_pcm_hardware camelot_pcm_hardware = {
+static const struct snd_pcm_hardware camelot_pcm_hardware = {
 	.info = (SNDRV_PCM_INFO_MMAP |
 		SNDRV_PCM_INFO_INTERLEAVED |
 		SNDRV_PCM_INFO_BLOCK_TRANSFER |
diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index 5d7d9fe8bc98..39ec772912d5 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -1710,7 +1710,7 @@ static const struct snd_soc_dai_ops fsi_dai_ops = {
  *		pcm ops
  */
 
-static struct snd_pcm_hardware fsi_pcm_hardware = {
+static const struct snd_pcm_hardware fsi_pcm_hardware = {
 	.info =		SNDRV_PCM_INFO_INTERLEAVED	|
 			SNDRV_PCM_INFO_MMAP		|
 			SNDRV_PCM_INFO_MMAP_VALID,
diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index df39831b8e8f..107133297e8d 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -843,7 +843,7 @@ static int rsnd_soc_hw_rule_channels(struct snd_pcm_hw_params *params,
 				ir, &ic);
 }
 
-static struct snd_pcm_hardware rsnd_pcm_hardware = {
+static const struct snd_pcm_hardware rsnd_pcm_hardware = {
 	.info =		SNDRV_PCM_INFO_INTERLEAVED	|
 			SNDRV_PCM_INFO_MMAP		|
 			SNDRV_PCM_INFO_MMAP_VALID,
diff --git a/sound/soc/sh/siu_dai.c b/sound/soc/sh/siu_dai.c
index 4a22aadac294..160502947da2 100644
--- a/sound/soc/sh/siu_dai.c
+++ b/sound/soc/sh/siu_dai.c
@@ -333,7 +333,7 @@ static void siu_dai_spbstop(struct siu_port *port_info)
 /*		API functions		*/
 
 /* Playback and capture hardware properties are identical */
-static struct snd_pcm_hardware siu_dai_pcm_hw = {
+static const struct snd_pcm_hardware siu_dai_pcm_hw = {
 	.info			= SNDRV_PCM_INFO_INTERLEAVED,
 	.formats		= SNDRV_PCM_FMTBIT_S16,
 	.rates			= SNDRV_PCM_RATE_8000_48000,
-- 
2.13.3
