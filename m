Return-Path: <bjorn.helgaas@hp.com>
Received: from atlrel9.hp.com (atlrel9.hp.com [156.153.255.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "atlrel9.hp.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id F04CB67A01
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Mar 2006 10:35:32 +1100 (EST)
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: tidy-up of_register_driver()/driver_register()
	return values
Date: Thu, 2 Mar 2006 16:16:07 -0700
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200603021616.07670.bjorn.helgaas@hp.com>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove the assumption that driver_register() returns the number of
devices bound to the driver.  In fact, it returns zero for success
or a negative error value.

Nobody uses the return value of of_register_driver() anyway.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm4/arch/powerpc/kernel/of_device.c
===================================================================
--- work-mm4.orig/arch/powerpc/kernel/of_device.c	2006-03-01 15:37:13.000000000 -0700
+++ work-mm4/arch/powerpc/kernel/of_device.c	2006-03-02 10:46:58.000000000 -0700
@@ -147,15 +147,12 @@
 
 int of_register_driver(struct of_platform_driver *drv)
 {
-	int count = 0;
-
 	/* initialize common driver fields */
 	drv->driver.name = drv->name;
 	drv->driver.bus = &of_platform_bus_type;
 
 	/* register with core */
-	count = driver_register(&drv->driver);
-	return count ? count : 1;
+	return driver_register(&drv->driver);
 }
 
 void of_unregister_driver(struct of_platform_driver *drv)
Index: work-mm4/drivers/macintosh/smu.c
===================================================================
--- work-mm4.orig/drivers/macintosh/smu.c	2006-03-01 15:37:41.000000000 -0700
+++ work-mm4/drivers/macintosh/smu.c	2006-03-02 10:47:30.000000000 -0700
@@ -630,8 +630,6 @@
 
 static int __init smu_init_sysfs(void)
 {
-	int rc;
-
 	/*
 	 * Due to sysfs bogosity, a sysdev is not a real device, so
 	 * we should in fact create both if we want sysdev semantics
@@ -640,7 +638,7 @@
 	 * I'm a bit too far from figuring out how that works with those
 	 * new chipsets, but that will come back and bite us
 	 */
-	rc = of_register_driver(&smu_of_platform_driver);
+	of_register_driver(&smu_of_platform_driver);
 	return 0;
 }
 
