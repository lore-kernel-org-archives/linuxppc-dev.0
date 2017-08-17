Return-Path: <bhumirks@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xY0w83dwyzDrKj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 19:16:56 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id y192so8930593pgd.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 02:16:56 -0700 (PDT)
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr, linux@armlinux.org.uk, perex@perex.cz,
 tiwai@suse.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 03/12] ALSA: drivers: make snd_pcm_hardware const
Date: Thu, 17 Aug 2017 14:45:51 +0530
Message-Id: <1502961360-22063-4-git-send-email-bhumirks@gmail.com>
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
 sound/drivers/aloop.c         | 2 +-
 sound/drivers/dummy.c         | 2 +-
 sound/drivers/ml403-ac97cr.c  | 4 ++--
 sound/drivers/pcsp/pcsp_lib.c | 2 +-
 sound/drivers/vx/vx_pcm.c     | 4 ++--
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 54f348a..6e02ee0 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -561,7 +561,7 @@ static snd_pcm_uframes_t loopback_pointer(struct snd_pcm_substream *substream)
 	return bytes_to_frames(runtime, pos);
 }
 
-static struct snd_pcm_hardware loopback_pcm_hardware =
+static const struct snd_pcm_hardware loopback_pcm_hardware =
 {
 	.info =		(SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_MMAP |
 			 SNDRV_PCM_INFO_MMAP_VALID | SNDRV_PCM_INFO_PAUSE |
diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index dd5ed03..c0939a0 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -520,7 +520,7 @@ static snd_pcm_uframes_t dummy_pcm_pointer(struct snd_pcm_substream *substream)
 	return get_dummy_ops(substream)->pointer(substream);
 }
 
-static struct snd_pcm_hardware dummy_pcm_hardware = {
+static const struct snd_pcm_hardware dummy_pcm_hardware = {
 	.info =			(SNDRV_PCM_INFO_MMAP |
 				 SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_RESUME |
diff --git a/sound/drivers/ml403-ac97cr.c b/sound/drivers/ml403-ac97cr.c
index bdcb572..d634e10 100644
--- a/sound/drivers/ml403-ac97cr.c
+++ b/sound/drivers/ml403-ac97cr.c
@@ -373,7 +373,7 @@ struct snd_ml403_ac97cr {
 	struct snd_pcm_indirect2 capture_ind2_rec;
 };
 
-static struct snd_pcm_hardware snd_ml403_ac97cr_playback = {
+static const struct snd_pcm_hardware snd_ml403_ac97cr_playback = {
 	.info =	            (SNDRV_PCM_INFO_MMAP |
 			     SNDRV_PCM_INFO_INTERLEAVED |
 			     SNDRV_PCM_INFO_MMAP_VALID),
@@ -392,7 +392,7 @@ struct snd_ml403_ac97cr {
 	.fifo_size =	    0,
 };
 
-static struct snd_pcm_hardware snd_ml403_ac97cr_capture = {
+static const struct snd_pcm_hardware snd_ml403_ac97cr_capture = {
 	.info =	            (SNDRV_PCM_INFO_MMAP |
 			     SNDRV_PCM_INFO_INTERLEAVED |
 			     SNDRV_PCM_INFO_MMAP_VALID),
diff --git a/sound/drivers/pcsp/pcsp_lib.c b/sound/drivers/pcsp/pcsp_lib.c
index 44b3632..2f5a35f 100644
--- a/sound/drivers/pcsp/pcsp_lib.c
+++ b/sound/drivers/pcsp/pcsp_lib.c
@@ -285,7 +285,7 @@ static snd_pcm_uframes_t snd_pcsp_playback_pointer(struct snd_pcm_substream
 	return bytes_to_frames(substream->runtime, pos);
 }
 
-static struct snd_pcm_hardware snd_pcsp_playback = {
+static const struct snd_pcm_hardware snd_pcsp_playback = {
 	.info = (SNDRV_PCM_INFO_INTERLEAVED |
 		 SNDRV_PCM_INFO_HALF_DUPLEX |
 		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID),
diff --git a/sound/drivers/vx/vx_pcm.c b/sound/drivers/vx/vx_pcm.c
index d318a33..380a028 100644
--- a/sound/drivers/vx/vx_pcm.c
+++ b/sound/drivers/vx/vx_pcm.c
@@ -500,7 +500,7 @@ static int vx_stop_stream(struct vx_core *chip, struct vx_pipe *pipe)
  * playback hw information
  */
 
-static struct snd_pcm_hardware vx_pcm_playback_hw = {
+static const struct snd_pcm_hardware vx_pcm_playback_hw = {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_MMAP_VALID /*|*/
 				 /*SNDRV_PCM_INFO_RESUME*/),
@@ -891,7 +891,7 @@ static int vx_pcm_prepare(struct snd_pcm_substream *subs)
  * playback hw information
  */
 
-static struct snd_pcm_hardware vx_pcm_capture_hw = {
+static const struct snd_pcm_hardware vx_pcm_capture_hw = {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_MMAP_VALID /*|*/
 				 /*SNDRV_PCM_INFO_RESUME*/),
-- 
1.9.1
