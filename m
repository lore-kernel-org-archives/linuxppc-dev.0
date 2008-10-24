Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A0CA5DDDE6
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 23:44:28 +1100 (EST)
Subject: Re: adding more machines to snd-aoa
From: Johannes Berg <johannes@sipsolutions.net>
To: Gabriel Paubert <paubert@iram.es>
In-Reply-To: <20081024122616.GA19424@iram.es>
References: <1224769461.6002.12.camel@johannes.berg>
	<20081023153510.GA28277@iram.es>
	<1224776462.6002.45.camel@johannes.berg>
	<20081023164302.GA29454@iram.es>
	<1224837623.6002.84.camel@johannes.berg>
	<20081024122616.GA19424@iram.es>
Content-Type: text/plain
Date: Fri, 24 Oct 2008 14:43:11 +0200
Message-Id: <1224852191.611.8.camel@johannes.berg>
Mime-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linux User #330250 <linuxuser330250@gmx.net>,
	Sjoerd Simons <sjoerd@luon.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here's a patch that actually applies against 2.6.27.

---
 sound/aoa/fabrics/snd-aoa-fabric-layout.c |   73 +++++++++++++++++++++++-------
 sound/aoa/soundbus/i2sbus/i2sbus-core.c   |   16 ++++--
 2 files changed, 68 insertions(+), 21 deletions(-)

--- everything.orig/sound/aoa/fabrics/snd-aoa-fabric-layout.c	2008-10-24 13:35:00.000000000 +0200
+++ everything/sound/aoa/fabrics/snd-aoa-fabric-layout.c	2008-10-24 14:42:32.000000000 +0200
@@ -1,16 +1,14 @@
 /*
- * Apple Onboard Audio driver -- layout fabric
+ * Apple Onboard Audio driver -- layout/machine id fabric
  *
- * Copyright 2006 Johannes Berg <johannes@sipsolutions.net>
+ * Copyright 2006, 2008 Johannes Berg <johannes@sipsolutions.net>
  *
  * GPL v2, can be found in COPYING.
  *
  *
- * This fabric module looks for sound codecs
- * based on the layout-id property in the device tree.
- *
+ * This fabric module looks for sound codecs based on the
+ * layout-id or device-id property in the device tree.
  */
-
 #include <asm/prom.h>
 #include <linux/list.h>
 #include <linux/module.h>
@@ -63,7 +61,7 @@ struct codec_connect_info {
 #define LAYOUT_FLAG_COMBO_LINEOUT_SPDIF	(1<<0)
 
 struct layout {
-	unsigned int layout_id;
+	unsigned int layout_id, device_id;
 	struct codec_connect_info codecs[MAX_CODECS_PER_BUS];
 	int flags;
 	
@@ -111,6 +109,10 @@ MODULE_ALIAS("sound-layout-96");
 MODULE_ALIAS("sound-layout-98");
 MODULE_ALIAS("sound-layout-100");
 
+MODULE_ALIAS("aoa-device-id-14");
+MODULE_ALIAS("aoa-device-id-22");
+MODULE_ALIAS("aoa-device-id-35");
+
 /* onyx with all but microphone connected */
 static struct codec_connection onyx_connections_nomic[] = {
 	{
@@ -518,6 +520,27 @@ static struct layout layouts[] = {
 		.connections = onyx_connections_noheadphones,
 	  },
 	},
+	/* PowerMac3,4 */
+	{ .device_id = 14,
+	  .codecs[0] = {
+		.name = "tas",
+		.connections = tas_connections_noline,
+	  },
+	},
+	/* PowerMac3,6 */
+	{ .device_id = 22,
+	  .codecs[0] = {
+		.name = "tas",
+		.connections = tas_connections_all,
+	  },
+	},
+	/* PowerBook5,2 */
+	{ .device_id = 35,
+	  .codecs[0] = {
+		.name = "tas",
+		.connections = tas_connections_all,
+	  },
+	},
 	{}
 };
 
@@ -526,7 +549,7 @@ static struct layout *find_layout_by_id(
 	struct layout *l;
 
 	l = layouts;
-	while (l->layout_id) {
+	while (l->codecs[0].name) {
 		if (l->layout_id == id)
 			return l;
 		l++;
@@ -534,6 +557,19 @@ static struct layout *find_layout_by_id(
 	return NULL;
 }
 
+static struct layout *find_layout_by_device(unsigned int id)
+{
+	struct layout *l;
+
+	l = layouts;
+	while (l->codecs[0].name) {
+		if (l->device_id == id)
+			return l;
+		l++;
+	}
+	return NULL;
+}
+
 static void use_layout(struct layout *l)
 {
 	int i;
@@ -938,8 +974,8 @@ static struct aoa_fabric layout_fabric =
 static int aoa_fabric_layout_probe(struct soundbus_dev *sdev)
 {
 	struct device_node *sound = NULL;
-	const unsigned int *layout_id;
-	struct layout *layout;
+	const unsigned int *id;
+	struct layout *layout = NULL;
 	struct layout_dev *ldev = NULL;
 	int err;
 
@@ -952,15 +988,18 @@ static int aoa_fabric_layout_probe(struc
 		if (sound->type && strcasecmp(sound->type, "soundchip") == 0)
 			break;
 	}
-	if (!sound) return -ENODEV;
+	if (!sound)
+		return -ENODEV;
 
-	layout_id = of_get_property(sound, "layout-id", NULL);
-	if (!layout_id)
-		goto outnodev;
-	printk(KERN_INFO "snd-aoa-fabric-layout: found bus with layout %d\n",
-	       *layout_id);
+	id = of_get_property(sound, "layout-id", NULL);
+	if (id) {
+		layout = find_layout_by_id(*id);
+	} else {
+		id = of_get_property(sound, "device-id", NULL);
+		if (id)
+			layout = find_layout_by_device(*id);
+	}
 
-	layout = find_layout_by_id(*layout_id);
 	if (!layout) {
 		printk(KERN_ERR "snd-aoa-fabric-layout: unknown layout\n");
 		goto outnodev;
--- everything.orig/sound/aoa/soundbus/i2sbus/i2sbus-core.c	2008-10-24 14:01:15.000000000 +0200
+++ everything/sound/aoa/soundbus/i2sbus/i2sbus-core.c	2008-10-24 14:42:32.000000000 +0200
@@ -186,13 +186,21 @@ static int i2sbus_add_dev(struct macio_d
 		}
 	}
 	if (i == 1) {
-		const u32 *layout_id =
-			of_get_property(sound, "layout-id", NULL);
-		if (layout_id) {
-			layout = *layout_id;
+		const u32 *id = of_get_property(sound, "layout-id", NULL);
+
+		if (id) {
+			layout = *id;
 			snprintf(dev->sound.modalias, 32,
 				 "sound-layout-%d", layout);
 			force = 1;
+		} else {
+			id = of_get_property(sound, "device-id", NULL);
+			if (id) {
+				snprintf(dev->sound.modalias, 32,
+					 "aoa-device-id-%d", *id);
+				force = 1;
+				layout = -1;
+			}
 		}
 	}
 	/* for the time being, until we can handle non-layout-id
