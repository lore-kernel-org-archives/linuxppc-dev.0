Return-Path: <adogcalledsummer@gmail.com>
Received: from mail-wi0-x230.google.com (mail-wi0-x230.google.com
 [IPv6:2a00:1450:400c:c05::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6C91114016F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Mar 2014 22:53:08 +1100 (EST)
Received: by mail-wi0-f176.google.com with SMTP id r20so5864428wiv.15
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Mar 2014 04:53:01 -0700 (PDT)
Date: Thu, 27 Mar 2014 11:52:58 +0000
From: Adam Smith <adogcalledsummer@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] ALSA: snd-aoa: Add another layout entry for PowerBook6,5
Message-Id: <20140327115258.40fecbd1439a5cd7769ab792@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: stefang@aon.at
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Either one or a combination of commits
3a3dd0186f619b74e61e6f29dddcaf59af7d3cac "Improve detection of devices
from device-tree" and 26b0d14106954ae46d2f4f7eec3481828a210f7d "Adapt
to new i2c probing scheme" broke the snd-powermac module for my
PowerBook6,5 machine (12" iBook late 2004).  As I understand things,
these machines should be moving over to use snd-aoa.

The attached patch (against a 3.13.0 kernel) creates a new snd-aoa
layout entry for PowerBook6,5 machines.  I've tested it on my iBook and
sound now appears to be fully working.  The module snd-aoa-i2sbus needs
to be added to /etc/modules to ensure all the necessary snd-aoa modules
are loaded. 
 

Signed-off-by: Adam Smith <adogcalledsummer@gmail.com>

diff -uprN a/sound/aoa/fabrics/layout.c b/sound/aoa/fabrics/layout.c
--- a/sound/aoa/fabrics/layout.c	2014-01-20 02:40:07.000000000 +0000
+++ b/sound/aoa/fabrics/layout.c	2014-03-05 18:31:11.748445177 +0000
@@ -113,6 +113,7 @@ MODULE_ALIAS("sound-layout-100");
 MODULE_ALIAS("aoa-device-id-14");
 MODULE_ALIAS("aoa-device-id-22");
 MODULE_ALIAS("aoa-device-id-35");
+MODULE_ALIAS("aoa-device-id-38");
 MODULE_ALIAS("aoa-device-id-44");
 
 /* onyx with all but microphone connected */
@@ -363,6 +364,12 @@ static struct layout layouts[] = {
 	  },
 	},
 	/* PowerBook6,5 */
+	{ .device_id = 38,
+	  .codecs[0] = {
+		.name = "tas",
+		.connections = tas_connections_noline,
+	  },
+	},
 	{ .device_id = 44,
 	  .codecs[0] = {
 		.name = "tas",
diff -uprN a/sound/aoa/soundbus/i2sbus/core.c b/sound/aoa/soundbus/i2sbus/core.c
--- a/sound/aoa/soundbus/i2sbus/core.c	2014-01-20 02:40:07.000000000 +0000
+++ b/sound/aoa/soundbus/i2sbus/core.c	2014-03-05 18:32:41.184445303 +0000
@@ -203,7 +203,7 @@ static int i2sbus_add_dev(struct macio_d
 			 * so restrict to those we do handle for now.
 			 */
 			if (id && (*id == 22 || *id == 14 || *id == 35 ||
-				   *id == 44)) {
+				   *id == 38 || *id == 44)) {
 				snprintf(dev->sound.modalias, 32,
 					 "aoa-device-id-%d", *id);
 				ok = 1;
