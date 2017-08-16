Return-Path: <bhumirks@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xXNG92913zDrFM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 18:45:21 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id 83so4746111pgb.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 01:45:21 -0700 (PDT)
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr, johannes@sipsolutions.net, perex@perex.cz,
 tiwai@suse.com, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 1/3] ALSA: aoa: make snd_kcontrol_new const
Date: Wed, 16 Aug 2017 14:14:09 +0530
Message-Id: <1502873051-28437-2-git-send-email-bhumirks@gmail.com>
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
 sound/aoa/codecs/onyx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/aoa/codecs/onyx.c b/sound/aoa/codecs/onyx.c
index a04edff..d2d96ca 100644
--- a/sound/aoa/codecs/onyx.c
+++ b/sound/aoa/codecs/onyx.c
@@ -167,7 +167,7 @@ static int onyx_snd_vol_put(struct snd_kcontrol *kcontrol,
 	return 1;
 }
 
-static struct snd_kcontrol_new volume_control = {
+static const struct snd_kcontrol_new volume_control = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Master Playback Volume",
 	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
@@ -229,7 +229,7 @@ static int onyx_snd_inputgain_put(struct snd_kcontrol *kcontrol,
 	return n != v;
 }
 
-static struct snd_kcontrol_new inputgain_control = {
+static const struct snd_kcontrol_new inputgain_control = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Master Capture Volume",
 	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
@@ -284,7 +284,7 @@ static int onyx_snd_capture_source_put(struct snd_kcontrol *kcontrol,
 	return 1;
 }
 
-static struct snd_kcontrol_new capture_source_control = {
+static const struct snd_kcontrol_new capture_source_control = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	/* If we name this 'Input Source', it properly shows up in
 	 * alsamixer as a selection, * but it's shown under the
@@ -348,7 +348,7 @@ static int onyx_snd_mute_put(struct snd_kcontrol *kcontrol,
 	return !err ? (v != c) : err;
 }
 
-static struct snd_kcontrol_new mute_control = {
+static const struct snd_kcontrol_new mute_control = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Master Playback Switch",
 	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
@@ -476,7 +476,7 @@ static int onyx_spdif_mask_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static struct snd_kcontrol_new onyx_spdif_mask = {
+static const struct snd_kcontrol_new onyx_spdif_mask = {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READ,
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
 	.name =		SNDRV_CTL_NAME_IEC958("",PLAYBACK,CON_MASK),
@@ -533,7 +533,7 @@ static int onyx_spdif_put(struct snd_kcontrol *kcontrol,
 	return 1;
 }
 
-static struct snd_kcontrol_new onyx_spdif_ctrl = {
+static const struct snd_kcontrol_new onyx_spdif_ctrl = {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READWRITE,
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
 	.name =		SNDRV_CTL_NAME_IEC958("",PLAYBACK,DEFAULT),
-- 
1.9.1
