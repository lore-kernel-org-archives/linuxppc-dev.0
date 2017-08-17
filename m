Return-Path: <bhumirks@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xY0wT4TSkzDrKw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 19:17:13 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id u185so8943249pgb.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 02:17:13 -0700 (PDT)
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr, linux@armlinux.org.uk, perex@perex.cz,
 tiwai@suse.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 05/12] ALSA: mips: make snd_pcm_hardware const
Date: Thu, 17 Aug 2017 14:45:53 +0530
Message-Id: <1502961360-22063-6-git-send-email-bhumirks@gmail.com>
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
Done using Coccinelle

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/mips/hal2.c       | 2 +-
 sound/mips/sgio2audio.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/mips/hal2.c b/sound/mips/hal2.c
index 3318c15..367d6c37 100644
--- a/sound/mips/hal2.c
+++ b/sound/mips/hal2.c
@@ -496,7 +496,7 @@ static void hal2_free_dmabuf(struct hal2_codec *codec)
 		       DMA_ATTR_NON_CONSISTENT);
 }
 
-static struct snd_pcm_hardware hal2_pcm_hw = {
+static const struct snd_pcm_hardware hal2_pcm_hw = {
 	.info = (SNDRV_PCM_INFO_MMAP |
 		 SNDRV_PCM_INFO_MMAP_VALID |
 		 SNDRV_PCM_INFO_INTERLEAVED |
diff --git a/sound/mips/sgio2audio.c b/sound/mips/sgio2audio.c
index 0ebc1c3..603892f 100644
--- a/sound/mips/sgio2audio.c
+++ b/sound/mips/sgio2audio.c
@@ -532,7 +532,7 @@ static irqreturn_t snd_sgio2audio_error_isr(int irq, void *dev_id)
 
 /* PCM part */
 /* PCM hardware definition */
-static struct snd_pcm_hardware snd_sgio2audio_pcm_hw = {
+static const struct snd_pcm_hardware snd_sgio2audio_pcm_hw = {
 	.info = (SNDRV_PCM_INFO_MMAP |
 		 SNDRV_PCM_INFO_MMAP_VALID |
 		 SNDRV_PCM_INFO_INTERLEAVED |
-- 
1.9.1
