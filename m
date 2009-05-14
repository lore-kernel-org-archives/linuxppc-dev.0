Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 487E84755E
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 22:37:47 +1000 (EST)
Date: Thu, 14 May 2009 14:37:21 +0200
From: Jean Delvare <khali@linux-fr.org>
To: alsa-devel@alsa-project.org
Subject: [PATCH] keywest: Get rid of useless i2c_device_name() macro
Message-ID: <20090514143721.2954805e@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The i2c_device_name() macro is used only once and doesn't have much
value, it hurts redability more than it helps. Get rid of it.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 sound/ppc/keywest.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- linux-2.6.30-rc1.orig/sound/ppc/keywest.c	2009-04-10 16:22:08.000000000 +0200
+++ linux-2.6.30-rc1/sound/ppc/keywest.c	2009-04-10 16:25:16.000000000 +0200
@@ -33,10 +33,6 @@
 static struct pmac_keywest *keywest_ctx;
 
 
-#ifndef i2c_device_name
-#define i2c_device_name(x)	((x)->name)
-#endif
-
 static int keywest_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -56,7 +52,7 @@ static int keywest_attach_adapter(struct
 	if (! keywest_ctx)
 		return -EINVAL;
 
-	if (strncmp(i2c_device_name(adapter), "mac-io", 6))
+	if (strncmp(adapter->name, "mac-io", 6))
 		return 0; /* ignored */
 
 	memset(&info, 0, sizeof(struct i2c_board_info));


-- 
Jean Delvare
