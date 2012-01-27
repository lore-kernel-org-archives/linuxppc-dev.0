Return-Path: <axel.lin@gmail.com>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
 [209.85.160.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 696F6B6FA2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2012 18:24:07 +1100 (EST)
Received: by ghbz2 with SMTP id z2so689924ghb.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2012 23:24:03 -0800 (PST)
Message-ID: <1327649031.3758.1.camel@phoenix>
Subject: [PATCH] ALSA: aoa: Convert onyx and tas codec drivers to
 module_i2c_driver
From: Axel Lin <axel.lin@gmail.com>
To: alsa-devel@alsa-project.org
Date: Fri, 27 Jan 2012 15:23:51 +0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>, Johannes Berg <johannes@sipsolutions.net>,
 linuxppc-dev@lists.ozlabs.org, Jaroslav Kysela <perex@perex.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch converts onyx and tas codec drivers to use the module_i2c_driver()
macro which makes the code smaller and a bit simpler.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/aoa/codecs/onyx.c |   13 +------------
 sound/aoa/codecs/tas.c  |   13 +------------
 2 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/sound/aoa/codecs/onyx.c b/sound/aoa/codecs/onyx.c
index 762af68..270790d 100644
--- a/sound/aoa/codecs/onyx.c
+++ b/sound/aoa/codecs/onyx.c
@@ -1132,15 +1132,4 @@ static struct i2c_driver onyx_driver = {
 	.id_table = onyx_i2c_id,
 };
 
-static int __init onyx_init(void)
-{
-	return i2c_add_driver(&onyx_driver);
-}
-
-static void __exit onyx_exit(void)
-{
-	i2c_del_driver(&onyx_driver);
-}
-
-module_init(onyx_init);
-module_exit(onyx_exit);
+module_i2c_driver(onyx_driver);
diff --git a/sound/aoa/codecs/tas.c b/sound/aoa/codecs/tas.c
index fd2188c..8e63d1f 100644
--- a/sound/aoa/codecs/tas.c
+++ b/sound/aoa/codecs/tas.c
@@ -1026,15 +1026,4 @@ static struct i2c_driver tas_driver = {
 	.id_table = tas_i2c_id,
 };
 
-static int __init tas_init(void)
-{
-	return i2c_add_driver(&tas_driver);
-}
-
-static void __exit tas_exit(void)
-{
-	i2c_del_driver(&tas_driver);
-}
-
-module_init(tas_init);
-module_exit(tas_exit);
+module_i2c_driver(tas_driver);
-- 
1.7.5.4
