Return-Path: <bhumirks@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xXNGJ3G3lzDrCv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 18:45:28 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id y192so4760429pgd.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 01:45:28 -0700 (PDT)
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr, johannes@sipsolutions.net, perex@perex.cz,
 tiwai@suse.com, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 2/3] ALSA: pcxhr: make snd_kcontrol_new const
Date: Wed, 16 Aug 2017 14:14:10 +0530
Message-Id: <1502873051-28437-3-git-send-email-bhumirks@gmail.com>
In-Reply-To: <1502873051-28437-1-git-send-email-bhumirks@gmail.com>
References: <1502873051-28437-1-git-send-email-bhumirks@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make these const as they are only used during a copy operation.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/pci/pcxhr/pcxhr_mixer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/pcxhr/pcxhr_mixer.c b/sound/pci/pcxhr/pcxhr_mixer.c
index 36875df..d9a1c6c 100644
--- a/sound/pci/pcxhr/pcxhr_mixer.c
+++ b/sound/pci/pcxhr/pcxhr_mixer.c
@@ -185,7 +185,7 @@ static int pcxhr_analog_vol_put(struct snd_kcontrol *kcontrol,
 	return changed;
 }
 
-static struct snd_kcontrol_new pcxhr_control_analog_level = {
+static const struct snd_kcontrol_new pcxhr_control_analog_level = {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.access =	(SNDRV_CTL_ELEM_ACCESS_READWRITE |
 			 SNDRV_CTL_ELEM_ACCESS_TLV_READ),
@@ -409,7 +409,7 @@ static int pcxhr_pcm_vol_put(struct snd_kcontrol *kcontrol,
 	return changed;
 }
 
-static struct snd_kcontrol_new snd_pcxhr_pcm_vol =
+static const struct snd_kcontrol_new snd_pcxhr_pcm_vol =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.access =	(SNDRV_CTL_ELEM_ACCESS_READWRITE |
-- 
1.9.1
