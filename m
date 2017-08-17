Return-Path: <bhumirks@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xY0wz4VhHzDrKf
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 19:17:39 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id 83so8931048pgb.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 02:17:39 -0700 (PDT)
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr, linux@armlinux.org.uk, perex@perex.cz,
 tiwai@suse.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 08/12] ALSA: ppc: make snd_pcm_hardware const
Date: Thu, 17 Aug 2017 14:45:56 +0530
Message-Id: <1502961360-22063-9-git-send-email-bhumirks@gmail.com>
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
 sound/ppc/pmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/ppc/pmac.c b/sound/ppc/pmac.c
index a5843fc..45f0295 100644
--- a/sound/ppc/pmac.c
+++ b/sound/ppc/pmac.c
@@ -509,7 +509,7 @@ static void snd_pmac_pcm_update(struct snd_pmac *chip, struct pmac_stream *rec)
  * hw info
  */
 
-static struct snd_pcm_hardware snd_pmac_playback =
+static const struct snd_pcm_hardware snd_pmac_playback =
 {
 	.info =			(SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_MMAP |
@@ -528,7 +528,7 @@ static void snd_pmac_pcm_update(struct snd_pmac *chip, struct pmac_stream *rec)
 	.periods_max =		PMAC_MAX_FRAGS,
 };
 
-static struct snd_pcm_hardware snd_pmac_capture =
+static const struct snd_pcm_hardware snd_pmac_capture =
 {
 	.info =			(SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_MMAP |
-- 
1.9.1
