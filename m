Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4625A67B8D
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jul 2006 04:43:28 +1000 (EST)
Message-Id: <20060718173016.348627000@sipsolutions.net>>
References: <20060718172841.046446000@sipsolutions.net>>
Date: Tue, 18 Jul 2006 19:28:43 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/5] aoa: fix toonie codec
Mime-Version: 1.0
Cc: alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes the toonie codec to be actually usable.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- linux-2.6-fetch.orig/sound/aoa/codecs/snd-aoa-codec-toonie.c	2006-07-18 11:40:32.363476868 +0200
+++ linux-2.6-fetch/sound/aoa/codecs/snd-aoa-codec-toonie.c	2006-07-18 11:52:29.783476868 +0200
@@ -51,6 +51,13 @@ static struct transfer_info toonie_trans
 	{}
 };
 
+static int toonie_usable(struct codec_info_item *cii,
+			 struct transfer_info *ti,
+			 struct transfer_info *out)
+{
+	return 1;
+}
+
 #ifdef CONFIG_PM
 static int toonie_suspend(struct codec_info_item *cii, pm_message_t state)
 {
@@ -69,6 +76,7 @@ static struct codec_info toonie_codec_in
 	.sysclock_factor = 256,
 	.bus_factor = 64,
 	.owner = THIS_MODULE,
+	.usable = toonie_usable,
 #ifdef CONFIG_PM
 	.suspend = toonie_suspend,
 	.resume = toonie_resume,
@@ -79,19 +87,20 @@ static int toonie_init_codec(struct aoa_
 {
 	struct toonie *toonie = codec_to_toonie(codec);
 
+	/* nothing connected? what a joke! */
+	if (toonie->codec.connected != 1)
+		return -ENOTCONN;
+
 	if (aoa_snd_device_new(SNDRV_DEV_LOWLEVEL, toonie, &ops)) {
 		printk(KERN_ERR PFX "failed to create toonie snd device!\n");
 		return -ENODEV;
 	}
 
-	/* nothing connected? what a joke! */
-	if (toonie->codec.connected != 1)
-		return -ENOTCONN;
-
 	if (toonie->codec.soundbus_dev->attach_codec(toonie->codec.soundbus_dev,
 						     aoa_get_card(),
 						     &toonie_codec_info, toonie)) {
 		printk(KERN_ERR PFX "error creating toonie pcm\n");
+		snd_device_free(aoa_get_card(), toonie);
 		return -ENODEV;
 	}
 

--
