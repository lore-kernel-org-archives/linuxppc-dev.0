Return-Path: <bhumirks@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xY2Fl1WgnzDrKs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 20:17:15 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id y129so9162674pgy.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 03:17:15 -0700 (PDT)
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr, timur@tabi.org, nicoleotsuka@gmail.com,
 Xiubo.Lee@gmail.com, fabio.estevam@nxp.com, lgirdwood@gmail.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com, plai@codeaurora.org,
 bgoswami@codeaurora.org, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 5/6] ASoC: sh: make snd_pcm_hardware const
Date: Thu, 17 Aug 2017 15:46:11 +0530
Message-Id: <1502964972-22722-6-git-send-email-bhumirks@gmail.com>
In-Reply-To: <1502964972-22722-1-git-send-email-bhumirks@gmail.com>
References: <1502964972-22722-1-git-send-email-bhumirks@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make these const as they are only passed as the 2nd argument to the
function snd_soc_set_runtime_hwparams, which is const.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/soc/sh/dma-sh7760.c | 2 +-
 sound/soc/sh/fsi.c        | 2 +-
 sound/soc/sh/rcar/core.c  | 2 +-
 sound/soc/sh/siu_dai.c    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sh/dma-sh7760.c b/sound/soc/sh/dma-sh7760.c
index 35788a6..1e7d417 100644
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
index 7cf0edb..6d3c770 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -1710,7 +1710,7 @@ static int fsi_dai_hw_params(struct snd_pcm_substream *substream,
  *		pcm ops
  */
 
-static struct snd_pcm_hardware fsi_pcm_hardware = {
+static const struct snd_pcm_hardware fsi_pcm_hardware = {
 	.info =		SNDRV_PCM_INFO_INTERLEAVED	|
 			SNDRV_PCM_INFO_MMAP		|
 			SNDRV_PCM_INFO_MMAP_VALID,
diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index df39831..1071332 100644
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
index 4a22aad..1605029 100644
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
1.9.1
