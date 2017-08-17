Return-Path: <bhumirks@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xY0x82dXYzDrL5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 19:17:48 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id t80so2791667pgb.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 02:17:48 -0700 (PDT)
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr, linux@armlinux.org.uk, perex@perex.cz,
 tiwai@suse.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 09/12] ALSA: sh: make snd_pcm_hardware const
Date: Thu, 17 Aug 2017 14:45:57 +0530
Message-Id: <1502961360-22063-10-git-send-email-bhumirks@gmail.com>
In-Reply-To: <1502961360-22063-1-git-send-email-bhumirks@gmail.com>
References: <1502961360-22063-1-git-send-email-bhumirks@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make these const as they are only used in a copy operation.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/sh/aica.c         | 2 +-
 sound/sh/sh_dac_audio.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/sh/aica.c b/sound/sh/aica.c
index ab4802d..822608d 100644
--- a/sound/sh/aica.c
+++ b/sound/sh/aica.c
@@ -211,7 +211,7 @@ static void aica_chn_halt(void)
 }
 
 /* ALSA code below */
-static struct snd_pcm_hardware snd_pcm_aica_playback_hw = {
+static const struct snd_pcm_hardware snd_pcm_aica_playback_hw = {
 	.info = (SNDRV_PCM_INFO_NONINTERLEAVED),
 	.formats =
 	    (SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE |
diff --git a/sound/sh/sh_dac_audio.c b/sound/sh/sh_dac_audio.c
index c1e00ed..a077f1c 100644
--- a/sound/sh/sh_dac_audio.c
+++ b/sound/sh/sh_dac_audio.c
@@ -93,7 +93,7 @@ static void dac_audio_set_rate(struct snd_sh_dac *chip)
 
 /* PCM INTERFACE */
 
-static struct snd_pcm_hardware snd_sh_dac_pcm_hw = {
+static const struct snd_pcm_hardware snd_sh_dac_pcm_hw = {
 	.info			= (SNDRV_PCM_INFO_MMAP |
 					SNDRV_PCM_INFO_MMAP_VALID |
 					SNDRV_PCM_INFO_INTERLEAVED |
-- 
1.9.1
