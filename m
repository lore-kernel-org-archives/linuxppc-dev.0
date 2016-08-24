Return-Path: <aaro.koskinen@iki.fi>
Received: from emh02.mail.saunalahti.fi (emh02.mail.saunalahti.fi
 [62.142.5.108])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sKFY43ynBzDrJy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 04:03:36 +1000 (AEST)
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Johannes Berg <johannes@sipsolutions.net>, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org,
	Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] ALSA: snd-aoa: enable sound on PowerBook G4 12"
Date: Wed, 24 Aug 2016 20:57:47 +0300
Message-Id: <20160824175747.31180-1-aaro.koskinen@iki.fi>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enable sound on PowerBook G4 12".

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 sound/aoa/fabrics/layout.c       | 8 ++++++++
 sound/aoa/soundbus/i2sbus/core.c | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/aoa/fabrics/layout.c b/sound/aoa/fabrics/layout.c
index 8f71f7e..edc8681 100644
--- a/sound/aoa/fabrics/layout.c
+++ b/sound/aoa/fabrics/layout.c
@@ -112,6 +112,7 @@ MODULE_ALIAS("sound-layout-100");
 
 MODULE_ALIAS("aoa-device-id-14");
 MODULE_ALIAS("aoa-device-id-22");
+MODULE_ALIAS("aoa-device-id-31");
 MODULE_ALIAS("aoa-device-id-35");
 MODULE_ALIAS("aoa-device-id-44");
 
@@ -362,6 +363,13 @@ static struct layout layouts[] = {
 		.connections = tas_connections_nolineout,
 	  },
 	},
+	/* PowerBook6,1 */
+	{ .device_id = 31,
+	  .codecs[0] = {
+		.name = "tas",
+		.connections = tas_connections_nolineout,
+	  },
+	},
 	/* PowerBook6,5 */
 	{ .device_id = 44,
 	  .codecs[0] = {
diff --git a/sound/aoa/soundbus/i2sbus/core.c b/sound/aoa/soundbus/i2sbus/core.c
index 1cbf210..000b585 100644
--- a/sound/aoa/soundbus/i2sbus/core.c
+++ b/sound/aoa/soundbus/i2sbus/core.c
@@ -197,7 +197,7 @@ static int i2sbus_add_dev(struct macio_dev *macio,
 			 * so restrict to those we do handle for now.
 			 */
 			if (id && (*id == 22 || *id == 14 || *id == 35 ||
-				   *id == 44)) {
+				   *id == 31 || *id == 44)) {
 				snprintf(dev->sound.modalias, 32,
 					 "aoa-device-id-%d", *id);
 				ok = 1;
-- 
2.9.2
