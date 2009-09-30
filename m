Return-Path: <khali@linux-fr.org>
Received: from poutre.nerim.net (poutre.nerim.net [62.4.16.124])
	by ozlabs.org (Postfix) with ESMTP id D78EEB7B7B
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2009 23:35:48 +1000 (EST)
Date: Wed, 30 Sep 2009 15:25:42 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Johannes Berg <johannes@sipsolutions.net>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] sound: Don't assume i2c device probing always succeeds
Message-ID: <20090930152542.3ef753ee@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	Tim Shepard <shep@alum.mit.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If i2c device probing fails, then there is no driver to dereference
after calling i2c_new_device(). Stop assuming that probing will always
succeed, to avoid NULL pointer dereferences. We have an easier access
to the driver anyway.

Reported-by: Tim Shepard <shep@alum.mit.edu>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
---
The code is similar to the one in therm_adt746x, for which Tim reported
a real-world oops, so it should be fixed ASAP.

 sound/aoa/codecs/onyx.c |    4 +++-
 sound/aoa/codecs/tas.c  |    4 +++-
 sound/ppc/keywest.c     |    4 +++-
 3 files changed, 9 insertions(+), 3 deletions(-)

--- linux-2.6.32-rc1.orig/sound/aoa/codecs/onyx.c	2009-09-30 15:13:12.000000000 +0200
+++ linux-2.6.32-rc1/sound/aoa/codecs/onyx.c	2009-09-30 15:13:58.000000000 +0200
@@ -996,6 +996,8 @@ static void onyx_exit_codec(struct aoa_c
 	onyx->codec.soundbus_dev->detach_codec(onyx->codec.soundbus_dev, onyx);
 }
 
+static struct i2c_driver onyx_driver;
+
 static int onyx_create(struct i2c_adapter *adapter,
 		       struct device_node *node,
 		       int addr)
@@ -1027,7 +1029,7 @@ static int onyx_create(struct i2c_adapte
 	 * Let i2c-core delete that device on driver removal.
 	 * This is safe because i2c-core holds the core_lock mutex for us.
 	 */
-	list_add_tail(&client->detected, &client->driver->clients);
+	list_add_tail(&client->detected, &onyx_driver.clients);
 	return 0;
 }
 
--- linux-2.6.32-rc1.orig/sound/aoa/codecs/tas.c	2009-09-30 15:13:12.000000000 +0200
+++ linux-2.6.32-rc1/sound/aoa/codecs/tas.c	2009-09-30 15:13:58.000000000 +0200
@@ -882,6 +882,8 @@ static void tas_exit_codec(struct aoa_co
 }
 
 
+static struct i2c_driver tas_driver;
+
 static int tas_create(struct i2c_adapter *adapter,
 		       struct device_node *node,
 		       int addr)
@@ -902,7 +904,7 @@ static int tas_create(struct i2c_adapter
 	 * Let i2c-core delete that device on driver removal.
 	 * This is safe because i2c-core holds the core_lock mutex for us.
 	 */
-	list_add_tail(&client->detected, &client->driver->clients);
+	list_add_tail(&client->detected, &tas_driver.clients);
 	return 0;
 }
 
--- linux-2.6.32-rc1.orig/sound/ppc/keywest.c	2009-09-30 15:13:12.000000000 +0200
+++ linux-2.6.32-rc1/sound/ppc/keywest.c	2009-09-30 15:13:58.000000000 +0200
@@ -40,6 +40,8 @@ static int keywest_probe(struct i2c_clie
 	return 0;
 }
 
+struct i2c_driver keywest_driver;
+
 /*
  * This is kind of a hack, best would be to turn powermac to fixed i2c
  * bus numbers and declare the sound device as part of platform
@@ -65,7 +67,7 @@ static int keywest_attach_adapter(struct
 	 * This is safe because i2c-core holds the core_lock mutex for us.
 	 */
 	list_add_tail(&keywest_ctx->client->detected,
-		      &keywest_ctx->client->driver->clients);
+		      &keywest_driver.clients);
 	return 0;
 }
 


-- 
Jean Delvare
