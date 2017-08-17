Return-Path: <bhumirks@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xY0wK2NL2zDrKj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 19:17:05 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id 123so8901369pga.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 02:17:05 -0700 (PDT)
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr, linux@armlinux.org.uk, perex@perex.cz,
 tiwai@suse.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 04/12] ALSA: isa: make snd_pcm_hardware const
Date: Thu, 17 Aug 2017 14:45:52 +0530
Message-Id: <1502961360-22063-5-git-send-email-bhumirks@gmail.com>
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
 sound/isa/ad1816a/ad1816a_lib.c | 4 ++--
 sound/isa/es1688/es1688_lib.c   | 4 ++--
 sound/isa/es18xx.c              | 4 ++--
 sound/isa/gus/gus_pcm.c         | 4 ++--
 sound/isa/msnd/msnd.c           | 4 ++--
 sound/isa/sb/emu8000_pcm.c      | 2 +-
 sound/isa/sb/sb16_main.c        | 4 ++--
 sound/isa/sb/sb8_main.c         | 4 ++--
 sound/isa/wss/wss_lib.c         | 4 ++--
 9 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/sound/isa/ad1816a/ad1816a_lib.c b/sound/isa/ad1816a/ad1816a_lib.c
index 5c6df15..9232014 100644
--- a/sound/isa/ad1816a/ad1816a_lib.c
+++ b/sound/isa/ad1816a/ad1816a_lib.c
@@ -339,7 +339,7 @@ static irqreturn_t snd_ad1816a_interrupt(int irq, void *dev_id)
 }
 
 
-static struct snd_pcm_hardware snd_ad1816a_playback = {
+static const struct snd_pcm_hardware snd_ad1816a_playback = {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_MMAP_VALID),
 	.formats =		(SNDRV_PCM_FMTBIT_MU_LAW | SNDRV_PCM_FMTBIT_A_LAW |
@@ -358,7 +358,7 @@ static irqreturn_t snd_ad1816a_interrupt(int irq, void *dev_id)
 	.fifo_size =		0,
 };
 
-static struct snd_pcm_hardware snd_ad1816a_capture = {
+static const struct snd_pcm_hardware snd_ad1816a_capture = {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_MMAP_VALID),
 	.formats =		(SNDRV_PCM_FMTBIT_MU_LAW | SNDRV_PCM_FMTBIT_A_LAW |
diff --git a/sound/isa/es1688/es1688_lib.c b/sound/isa/es1688/es1688_lib.c
index ec7e68b..f9c0662 100644
--- a/sound/isa/es1688/es1688_lib.c
+++ b/sound/isa/es1688/es1688_lib.c
@@ -526,7 +526,7 @@ static snd_pcm_uframes_t snd_es1688_capture_pointer(struct snd_pcm_substream *su
 
  */
 
-static struct snd_pcm_hardware snd_es1688_playback =
+static const struct snd_pcm_hardware snd_es1688_playback =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_MMAP_VALID),
@@ -544,7 +544,7 @@ static snd_pcm_uframes_t snd_es1688_capture_pointer(struct snd_pcm_substream *su
 	.fifo_size =		0,
 };
 
-static struct snd_pcm_hardware snd_es1688_capture =
+static const struct snd_pcm_hardware snd_es1688_capture =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_MMAP_VALID),
diff --git a/sound/isa/es18xx.c b/sound/isa/es18xx.c
index 77023e4..cb9c9a1 100644
--- a/sound/isa/es18xx.c
+++ b/sound/isa/es18xx.c
@@ -838,7 +838,7 @@ static snd_pcm_uframes_t snd_es18xx_capture_pointer(struct snd_pcm_substream *su
 	return pos >> chip->dma1_shift;
 }
 
-static struct snd_pcm_hardware snd_es18xx_playback =
+static const struct snd_pcm_hardware snd_es18xx_playback =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_RESUME |
@@ -858,7 +858,7 @@ static snd_pcm_uframes_t snd_es18xx_capture_pointer(struct snd_pcm_substream *su
 	.fifo_size =		0,
 };
 
-static struct snd_pcm_hardware snd_es18xx_capture =
+static const struct snd_pcm_hardware snd_es18xx_capture =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_RESUME |
diff --git a/sound/isa/gus/gus_pcm.c b/sound/isa/gus/gus_pcm.c
index 36e852f..131b289 100644
--- a/sound/isa/gus/gus_pcm.c
+++ b/sound/isa/gus/gus_pcm.c
@@ -650,7 +650,7 @@ static void snd_gf1_pcm_interrupt_dma_read(struct snd_gus_card * gus)
 	}
 }
 
-static struct snd_pcm_hardware snd_gf1_pcm_playback =
+static const struct snd_pcm_hardware snd_gf1_pcm_playback =
 {
 	.info =			SNDRV_PCM_INFO_NONINTERLEAVED,
 	.formats		= (SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_U8 |
@@ -668,7 +668,7 @@ static void snd_gf1_pcm_interrupt_dma_read(struct snd_gus_card * gus)
 	.fifo_size =		0,
 };
 
-static struct snd_pcm_hardware snd_gf1_pcm_capture =
+static const struct snd_pcm_hardware snd_gf1_pcm_capture =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_MMAP_VALID),
diff --git a/sound/isa/msnd/msnd.c b/sound/isa/msnd/msnd.c
index ae9562c..569897f 100644
--- a/sound/isa/msnd/msnd.c
+++ b/sound/isa/msnd/msnd.c
@@ -437,7 +437,7 @@ static void snd_msnd_capture_reset_queue(struct snd_msnd *chip,
 	}
 }
 
-static struct snd_pcm_hardware snd_msnd_playback = {
+static const struct snd_pcm_hardware snd_msnd_playback = {
 	.info =			SNDRV_PCM_INFO_MMAP |
 				SNDRV_PCM_INFO_INTERLEAVED |
 				SNDRV_PCM_INFO_MMAP_VALID |
@@ -456,7 +456,7 @@ static void snd_msnd_capture_reset_queue(struct snd_msnd *chip,
 	.fifo_size =		0,
 };
 
-static struct snd_pcm_hardware snd_msnd_capture = {
+static const struct snd_pcm_hardware snd_msnd_capture = {
 	.info =			SNDRV_PCM_INFO_MMAP |
 				SNDRV_PCM_INFO_INTERLEAVED |
 				SNDRV_PCM_INFO_MMAP_VALID |
diff --git a/sound/isa/sb/emu8000_pcm.c b/sound/isa/sb/emu8000_pcm.c
index 9409827..8f34551 100644
--- a/sound/isa/sb/emu8000_pcm.c
+++ b/sound/isa/sb/emu8000_pcm.c
@@ -157,7 +157,7 @@ static int calc_rate_offset(int hz)
 /*
  */
 
-static struct snd_pcm_hardware emu8k_pcm_hw = {
+static const struct snd_pcm_hardware emu8k_pcm_hw = {
 #ifdef USE_NONINTERLEAVE
 	.info =			SNDRV_PCM_INFO_NONINTERLEAVED,
 #else
diff --git a/sound/isa/sb/sb16_main.c b/sound/isa/sb/sb16_main.c
index 6fc6325..3e39ba2 100644
--- a/sound/isa/sb/sb16_main.c
+++ b/sound/isa/sb/sb16_main.c
@@ -473,7 +473,7 @@ static snd_pcm_uframes_t snd_sb16_capture_pointer(struct snd_pcm_substream *subs
 
  */
 
-static struct snd_pcm_hardware snd_sb16_playback =
+static const struct snd_pcm_hardware snd_sb16_playback =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_MMAP_VALID),
@@ -491,7 +491,7 @@ static snd_pcm_uframes_t snd_sb16_capture_pointer(struct snd_pcm_substream *subs
 	.fifo_size =		0,
 };
 
-static struct snd_pcm_hardware snd_sb16_capture =
+static const struct snd_pcm_hardware snd_sb16_capture =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_MMAP_VALID),
diff --git a/sound/isa/sb/sb8_main.c b/sound/isa/sb/sb8_main.c
index f5d8f2d..d45df5c 100644
--- a/sound/isa/sb/sb8_main.c
+++ b/sound/isa/sb/sb8_main.c
@@ -447,7 +447,7 @@ static snd_pcm_uframes_t snd_sb8_capture_pointer(struct snd_pcm_substream *subst
 
  */
 
-static struct snd_pcm_hardware snd_sb8_playback =
+static const struct snd_pcm_hardware snd_sb8_playback =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_MMAP_VALID),
@@ -466,7 +466,7 @@ static snd_pcm_uframes_t snd_sb8_capture_pointer(struct snd_pcm_substream *subst
 	.fifo_size =		0,
 };
 
-static struct snd_pcm_hardware snd_sb8_capture =
+static const struct snd_pcm_hardware snd_sb8_capture =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_MMAP_VALID),
diff --git a/sound/isa/wss/wss_lib.c b/sound/isa/wss/wss_lib.c
index 29adb01..8a85204 100644
--- a/sound/isa/wss/wss_lib.c
+++ b/sound/isa/wss/wss_lib.c
@@ -1452,7 +1452,7 @@ static int snd_wss_probe(struct snd_wss *chip)
 
  */
 
-static struct snd_pcm_hardware snd_wss_playback =
+static const struct snd_pcm_hardware snd_wss_playback =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_MMAP_VALID |
@@ -1472,7 +1472,7 @@ static int snd_wss_probe(struct snd_wss *chip)
 	.fifo_size =		0,
 };
 
-static struct snd_pcm_hardware snd_wss_capture =
+static const struct snd_pcm_hardware snd_wss_capture =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_MMAP_VALID |
-- 
1.9.1
