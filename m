Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A65CA67BBA
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Jul 2006 03:00:23 +1000 (EST)
Message-Id: <20060707165530.406861000@sipsolutions.net>
References: <20060707165207.877010000@sipsolutions.net>
Date: Fri, 07 Jul 2006 18:52:11 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 04/12] aoa: fix when all is built into the kernel
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes initialisation issues when all of aoa is built
into the kernel by re-ordering the link order in the Makefile
and making the soundbus use subsys_initcall so it is initialised
earlier.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- linux-2.6-fetch.orig/sound/aoa/Makefile	2006-07-07 12:15:40.067697157 +0200
+++ linux-2.6-fetch/sound/aoa/Makefile	2006-07-07 12:15:52.407697157 +0200
@@ -1,4 +1,4 @@
 obj-$(CONFIG_SND_AOA) += core/
-obj-$(CONFIG_SND_AOA) += codecs/
-obj-$(CONFIG_SND_AOA) += fabrics/
 obj-$(CONFIG_SND_AOA_SOUNDBUS) += soundbus/
+obj-$(CONFIG_SND_AOA) += fabrics/
+obj-$(CONFIG_SND_AOA) += codecs/
--- linux-2.6-fetch.orig/sound/aoa/soundbus/core.c	2006-07-07 12:15:40.137697157 +0200
+++ linux-2.6-fetch/sound/aoa/soundbus/core.c	2006-07-07 12:15:52.407697157 +0200
@@ -194,16 +194,6 @@ static struct bus_type soundbus_bus_type
 	.dev_attrs	= soundbus_dev_attrs,
 };
 
-static int __init soundbus_init(void)
-{
-	return bus_register(&soundbus_bus_type);
-}
-
-static void __exit soundbus_exit(void)
-{
-	bus_unregister(&soundbus_bus_type);
-}
-
 int soundbus_add_one(struct soundbus_dev *dev)
 {
 	static int devcount;
@@ -246,5 +236,15 @@ void soundbus_unregister_driver(struct s
 }
 EXPORT_SYMBOL_GPL(soundbus_unregister_driver);
 
-module_init(soundbus_init);
+static int __init soundbus_init(void)
+{
+	return bus_register(&soundbus_bus_type);
+}
+
+static void __exit soundbus_exit(void)
+{
+	bus_unregister(&soundbus_bus_type);
+}
+
+subsys_initcall(soundbus_init);
 module_exit(soundbus_exit);

--
