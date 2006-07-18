Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 43A8767B8B
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jul 2006 04:43:28 +1000 (EST)
Message-Id: <20060718173017.459954000@sipsolutions.net>>
References: <20060718172841.046446000@sipsolutions.net>>
Date: Tue, 18 Jul 2006 19:28:44 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/5] make snd-powermac load even when it cant bind the device
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

This patch makes snd-powermac load when it can't bind the device right
away. That's the expected behaviour for hotplugging, but fixes an
important problem I was seeing with doing a modprobe snd-powermac with
a version that refuses loading on machines with layout-id: snd-powermac
would create a bunch of uevents and then refuse to load, the uevents
causing udev to reload it again, ad eternum.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- linux-2.6-fetch.orig/sound/ppc/powermac.c	2006-07-18 18:16:53.633476868 +0200
+++ linux-2.6-fetch/sound/ppc/powermac.c	2006-07-18 18:40:39.243476868 +0200
@@ -181,21 +181,14 @@ static int __init alsa_card_pmac_init(vo
 	if ((err = platform_driver_register(&snd_pmac_driver)) < 0)
 		return err;
 	device = platform_device_register_simple(SND_PMAC_DRIVER, -1, NULL, 0);
-	if (!IS_ERR(device)) {
-		if (platform_get_drvdata(device))
-			return 0;
-		platform_device_unregister(device);
-		err = -ENODEV;
-	} else
-		err = PTR_ERR(device);
-	platform_driver_unregister(&snd_pmac_driver);
-	return err;
+	return 0;
 
 }
 
 static void __exit alsa_card_pmac_exit(void)
 {
-	platform_device_unregister(device);
+	if (!IS_ERR(device))
+		platform_device_unregister(device);
 	platform_driver_unregister(&snd_pmac_driver);
 }
 

--
