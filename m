Return-Path: <bhumirks@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xY0xJ6xC8zDrLP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 19:17:56 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id t80so2792207pgb.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 02:17:56 -0700 (PDT)
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr, linux@armlinux.org.uk, perex@perex.cz,
 tiwai@suse.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 10/12] ALSA: sparc: make snd_pcm_hardware const
Date: Thu, 17 Aug 2017 14:45:58 +0530
Message-Id: <1502961360-22063-11-git-send-email-bhumirks@gmail.com>
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
 sound/sparc/amd7930.c | 2 +-
 sound/sparc/cs4231.c  | 4 ++--
 sound/sparc/dbri.c    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/sparc/amd7930.c b/sound/sparc/amd7930.c
index 35c1f6a..a6864fd 100644
--- a/sound/sparc/amd7930.c
+++ b/sound/sparc/amd7930.c
@@ -666,7 +666,7 @@ static snd_pcm_uframes_t snd_amd7930_capture_pointer(struct snd_pcm_substream *s
 }
 
 /* Playback and capture have identical properties.  */
-static struct snd_pcm_hardware snd_amd7930_pcm_hw =
+static const struct snd_pcm_hardware snd_amd7930_pcm_hw =
 {
 	.info			= (SNDRV_PCM_INFO_MMAP |
 				   SNDRV_PCM_INFO_MMAP_VALID |
diff --git a/sound/sparc/cs4231.c b/sound/sparc/cs4231.c
index 3d7d425..f5192b3 100644
--- a/sound/sparc/cs4231.c
+++ b/sound/sparc/cs4231.c
@@ -1089,7 +1089,7 @@ static int snd_cs4231_probe(struct snd_cs4231 *chip)
 	return 0;		/* all things are ok.. */
 }
 
-static struct snd_pcm_hardware snd_cs4231_playback = {
+static const struct snd_pcm_hardware snd_cs4231_playback = {
 	.info			= SNDRV_PCM_INFO_MMAP |
 				  SNDRV_PCM_INFO_INTERLEAVED |
 				  SNDRV_PCM_INFO_MMAP_VALID |
@@ -1113,7 +1113,7 @@ static int snd_cs4231_probe(struct snd_cs4231 *chip)
 	.periods_max		= 1024,
 };
 
-static struct snd_pcm_hardware snd_cs4231_capture = {
+static const struct snd_pcm_hardware snd_cs4231_capture = {
 	.info			= SNDRV_PCM_INFO_MMAP |
 				  SNDRV_PCM_INFO_INTERLEAVED |
 				  SNDRV_PCM_INFO_MMAP_VALID |
diff --git a/sound/sparc/dbri.c b/sound/sparc/dbri.c
index 52063b2..72b6c4a 100644
--- a/sound/sparc/dbri.c
+++ b/sound/sparc/dbri.c
@@ -1980,7 +1980,7 @@ static irqreturn_t snd_dbri_interrupt(int irq, void *dev_id)
 /****************************************************************************
 		PCM Interface
 ****************************************************************************/
-static struct snd_pcm_hardware snd_dbri_pcm_hw = {
+static const struct snd_pcm_hardware snd_dbri_pcm_hw = {
 	.info		= SNDRV_PCM_INFO_MMAP |
 			  SNDRV_PCM_INFO_INTERLEAVED |
 			  SNDRV_PCM_INFO_BLOCK_TRANSFER |
-- 
1.9.1
