Return-Path: <k.kozlowski@samsung.com>
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3DC4C1A0DCE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2015 16:49:16 +1000 (AEST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NR900561EH74W40@mailout2.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Fri, 10 Jul 2015 07:39:07 +0100 (BST)
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: Johannes Berg <johannes@sipsolutions.net>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 linuxppc-dev@lists.ozlabs.org (open list:AOA (Apple Onboard Audio) ALSA
 DRIVER),
 alsa-devel@alsa-project.org (moderated list:AOA (Apple Onboard Audio) ALSA
 DRIVER), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ALSA: aoa: Drop owner assignment from i2c_driver
Date: Fri, 10 Jul 2015 15:39:02 +0900
Message-id: <1436510344-5889-1-git-send-email-k.kozlowski@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

i2c_driver does not need to set an owner because i2c_register_driver()
will set it.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

The coccinelle script which generated the patch was sent here:
http://www.spinics.net/lists/kernel/msg2029903.html
---
 sound/aoa/codecs/onyx.c | 1 -
 sound/aoa/codecs/tas.c  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/sound/aoa/codecs/onyx.c b/sound/aoa/codecs/onyx.c
index 23c371ecfb6b..a04edff8b729 100644
--- a/sound/aoa/codecs/onyx.c
+++ b/sound/aoa/codecs/onyx.c
@@ -1050,7 +1050,6 @@ MODULE_DEVICE_TABLE(i2c,onyx_i2c_id);
 static struct i2c_driver onyx_driver = {
 	.driver = {
 		.name = "aoa_codec_onyx",
-		.owner = THIS_MODULE,
 	},
 	.probe = onyx_i2c_probe,
 	.remove = onyx_i2c_remove,
diff --git a/sound/aoa/codecs/tas.c b/sound/aoa/codecs/tas.c
index 364c7c4416e8..78ed1ffbf786 100644
--- a/sound/aoa/codecs/tas.c
+++ b/sound/aoa/codecs/tas.c
@@ -939,7 +939,6 @@ MODULE_DEVICE_TABLE(i2c,tas_i2c_id);
 static struct i2c_driver tas_driver = {
 	.driver = {
 		.name = "aoa_codec_tas",
-		.owner = THIS_MODULE,
 	},
 	.probe = tas_i2c_probe,
 	.remove = tas_i2c_remove,
-- 
1.9.1
