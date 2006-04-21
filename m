Return-Path: <agx@sigxcpu.org>
Received: from honk1.physik.uni-konstanz.de (honk1.physik.uni-konstanz.de
	[134.34.140.224])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "honk1.physik.uni-konstanz.de",
	Issuer "Mittelerde" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0BD9D679FB
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 18:26:59 +1000 (EST)
Date: Fri, 21 Apr 2006 10:03:14 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: linuxppc-dev@ozlabs.org
Subject: fix oops due to i2c-keylarge ->  i2c-powermac rename
Message-ID: <20060421080314.GA4538@bogon.ms20.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,
the i2c-keywest module has been renamed to i2c-powermac during the
2.6.16 development cycle. This fixes the corresponding request_module
calls so the module gets loaded again and we don't oops on i2c accesses.
Patch applies against current Linus git. Please apply:

Singend-Off-By: Guido Guenther <agx@sigxcpu.org>

--- orig/linux-2.6.16.7/sound/ppc/tumbler.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16.7/sound/ppc/tumbler.c	2006-04-19 23:15:20.000000000 +0200
@@ -1314,7 +1314,7 @@
 
 #ifdef CONFIG_KMOD
 	if (current->fs->root)
-		request_module("i2c-keywest");
+		request_module("i2c-powermac");
 #endif /* CONFIG_KMOD */	
 
 	mix = kmalloc(sizeof(*mix), GFP_KERNEL);
--- orig/linux-2.6.16.7/sound/ppc/daca.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16.7/sound/ppc/daca.c	2006-04-19 23:14:33.000000000 +0200
@@ -256,7 +256,7 @@
 
 #ifdef CONFIG_KMOD
 	if (current->fs->root)
-		request_module("i2c-keywest");
+		request_module("i2c-powermac");
 #endif /* CONFIG_KMOD */	
 
 	mix = kmalloc(sizeof(*mix), GFP_KERNEL);
--- orig/linux-2.6.16.7/sound/oss/dmasound/tas_common.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16.7/sound/oss/dmasound/tas_common.c	2006-04-20 20:46:55.000000000 +0200
@@ -195,8 +195,8 @@
 
 	printk(KERN_INFO "tas driver [%s])\n", driver_name);
 
-#ifndef CONFIG_I2C_KEYWEST
-	request_module("i2c-keywest");
+#ifndef CONFIG_I2C_POWERMAC
+	request_module("i2c-powermac");
 #endif
 	tas_node = find_devices("deq");
 	if (tas_node == NULL)
--- orig/linux-2.6.16.7/drivers/macintosh/therm_adt746x.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16.7/drivers/macintosh/therm_adt746x.c	2006-04-20 20:45:32.000000000 +0200
@@ -627,8 +627,8 @@
 	if(therm_type == ADT7460)
 		device_create_file(&of_dev->dev, &dev_attr_sensor2_fan_speed);
 
-#ifndef CONFIG_I2C_KEYWEST
-	request_module("i2c-keywest");
+#ifndef CONFIG_I2C_POWERMAC
+	request_module("i2c-powermac");
 #endif
 
 	return i2c_add_driver(&thermostat_driver);

Cheers,
 -- Guido
