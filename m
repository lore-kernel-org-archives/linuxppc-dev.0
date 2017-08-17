Return-Path: <bhumirks@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xY0wf4BsnzDrLW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 19:17:22 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id y192so8932334pgd.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 02:17:22 -0700 (PDT)
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr, linux@armlinux.org.uk, perex@perex.cz,
 tiwai@suse.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 06/12] ALSA: pci: make snd_pcm_hardware const
Date: Thu, 17 Aug 2017 14:45:54 +0530
Message-Id: <1502961360-22063-7-git-send-email-bhumirks@gmail.com>
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
 sound/pci/au88x0/au88x0_pcm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/au88x0/au88x0_pcm.c b/sound/pci/au88x0/au88x0_pcm.c
index 848eb3c..53714e0 100644
--- a/sound/pci/au88x0/au88x0_pcm.c
+++ b/sound/pci/au88x0/au88x0_pcm.c
@@ -30,7 +30,7 @@
 #define VORTEX_PCM_TYPE(x) (x->name[40])
 
 /* hardware definition */
-static struct snd_pcm_hardware snd_vortex_playback_hw_adb = {
+static const struct snd_pcm_hardware snd_vortex_playback_hw_adb = {
 	.info =
 	    (SNDRV_PCM_INFO_MMAP | /* SNDRV_PCM_INFO_RESUME | */
 	     SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_INTERLEAVED |
@@ -51,7 +51,7 @@
 };
 
 #ifndef CHIP_AU8820
-static struct snd_pcm_hardware snd_vortex_playback_hw_a3d = {
+static const struct snd_pcm_hardware snd_vortex_playback_hw_a3d = {
 	.info =
 	    (SNDRV_PCM_INFO_MMAP | /* SNDRV_PCM_INFO_RESUME | */
 	     SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_INTERLEAVED |
@@ -71,7 +71,7 @@
 	.periods_max = 64,
 };
 #endif
-static struct snd_pcm_hardware snd_vortex_playback_hw_spdif = {
+static const struct snd_pcm_hardware snd_vortex_playback_hw_spdif = {
 	.info =
 	    (SNDRV_PCM_INFO_MMAP | /* SNDRV_PCM_INFO_RESUME | */
 	     SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_INTERLEAVED |
@@ -94,7 +94,7 @@
 };
 
 #ifndef CHIP_AU8810
-static struct snd_pcm_hardware snd_vortex_playback_hw_wt = {
+static const struct snd_pcm_hardware snd_vortex_playback_hw_wt = {
 	.info = (SNDRV_PCM_INFO_MMAP |
 		 SNDRV_PCM_INFO_INTERLEAVED |
 		 SNDRV_PCM_INFO_BLOCK_TRANSFER | SNDRV_PCM_INFO_MMAP_VALID),
-- 
1.9.1
