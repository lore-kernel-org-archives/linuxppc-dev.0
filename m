Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2EBF9DDEC9
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Mar 2007 21:19:37 +1000 (EST)
Subject: [PATCH] snd-aoa-i2sbus: use MODULE_DEVICE_TABLE instead of plain
	MODULE_ALIAS
From: Johannes Berg <johannes@sipsolutions.net>
To: Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain
Date: Wed, 28 Mar 2007 13:18:20 +0200
Message-Id: <1175080700.5151.56.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	ALSA development <alsa-devel@alsa-project.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch changes snd-aoa-i2sbus to use MODULE_DEVICE_TABLE instead of
a hardcoded MODULE_ALIAS. Thanks to Sylvain Munaut for pointing this
out.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

---
Please apply to the alsa tree.

 sound/aoa/soundbus/i2sbus/i2sbus-core.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- wireless-dev.orig/sound/aoa/soundbus/i2sbus/i2sbus-core.c	2007-03-28 13:08:25.903457795 +0200
+++ wireless-dev/sound/aoa/soundbus/i2sbus/i2sbus-core.c	2007-03-28 13:09:21.253457795 +0200
@@ -23,9 +23,6 @@
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Johannes Berg <johannes@sipsolutions.net>");
 MODULE_DESCRIPTION("Apple Soundbus: I2S support");
-/* for auto-loading, declare that we handle this weird
- * string that macio puts into the relevant device */
-MODULE_ALIAS("of:Ni2sTi2sC");
 
 static int force;
 module_param(force, int, 0444);
@@ -37,6 +34,8 @@ static struct of_device_id i2sbus_match[
 	{ }
 };
 
+MODULE_DEVICE_TABLE(of, i2sbus_match);
+
 static int alloc_dbdma_descriptor_ring(struct i2sbus_dev *i2sdev,
 				       struct dbdma_command_mem *r,
 				       int numcmds)
