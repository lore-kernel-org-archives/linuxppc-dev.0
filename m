Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] ALSA: snd-aoa: Add a layout entry for PowerBook6,5
Date: Mon,  6 May 2013 11:01:05 +1000
Message-Id: <1367802065-32150-1-git-send-email-michael@ellerman.id.au>
Cc: newchief@king.net.pl
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Either one or a combination of commits 81e5d86
"Register i2c devices from device-tree" and 3a3dd01
"Improve detection of devices from device-tree" broke sound on
PowerBook6,5 machines.

Fix it by adding an entry to the new driver to match PowerBook6,5
machines.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 sound/aoa/fabrics/layout.c       |    8 ++++++++
 sound/aoa/soundbus/i2sbus/core.c |    3 ++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/sound/aoa/fabrics/layout.c b/sound/aoa/fabrics/layout.c
index 552b97a..61ab640 100644
--- a/sound/aoa/fabrics/layout.c
+++ b/sound/aoa/fabrics/layout.c
@@ -113,6 +113,7 @@ MODULE_ALIAS("sound-layout-100");
 MODULE_ALIAS("aoa-device-id-14");
 MODULE_ALIAS("aoa-device-id-22");
 MODULE_ALIAS("aoa-device-id-35");
+MODULE_ALIAS("aoa-device-id-44");
 
 /* onyx with all but microphone connected */
 static struct codec_connection onyx_connections_nomic[] = {
@@ -361,6 +362,13 @@ static struct layout layouts[] = {
 		.connections = tas_connections_nolineout,
 	  },
 	},
+	/* PowerBook6,5 */
+	{ .device_id = 44,
+	  .codecs[0] = {
+		.name = "tas",
+		.connections = tas_connections_all,
+	  },
+	},
 	/* PowerBook6,7 */
 	{ .layout_id = 80,
 	  .codecs[0] = {
diff --git a/sound/aoa/soundbus/i2sbus/core.c b/sound/aoa/soundbus/i2sbus/core.c
index 0106583..15e7613 100644
--- a/sound/aoa/soundbus/i2sbus/core.c
+++ b/sound/aoa/soundbus/i2sbus/core.c
@@ -200,7 +200,8 @@ static int i2sbus_add_dev(struct macio_dev *macio,
 			 * We probably cannot handle all device-id machines,
 			 * so restrict to those we do handle for now.
 			 */
-			if (id && (*id == 22 || *id == 14 || *id == 35)) {
+			if (id && (*id == 22 || *id == 14 || *id == 35 ||
+				   *id == 44)) {
 				snprintf(dev->sound.modalias, 32,
 					 "aoa-device-id-%d", *id);
 				ok = 1;
-- 
1.7.10.4
