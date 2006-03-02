Return-Path: <bjorn.helgaas@hp.com>
Received: from atlrel8.hp.com (atlrel8.hp.com [156.153.255.206])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "atlrel8.hp.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 3CD29679FF
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Mar 2006 10:38:41 +1100 (EST)
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] macintosh: tidy-up driver_register() return values
Date: Thu, 2 Mar 2006 16:18:51 -0700
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200603021618.51590.bjorn.helgaas@hp.com>
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

All callers of macio_register_driver() either ignore the return value
or return it as the return value of a module_init() function.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm4/drivers/macintosh/macio_asic.c
===================================================================
--- work-mm4.orig/drivers/macintosh/macio_asic.c	2006-03-01 15:37:15.000000000 -0700
+++ work-mm4/drivers/macintosh/macio_asic.c	2006-03-02 12:57:05.000000000 -0700
@@ -550,15 +550,12 @@
  */
 int macio_register_driver(struct macio_driver *drv)
 {
-	int count = 0;
-
 	/* initialize common driver fields */
 	drv->driver.name = drv->name;
 	drv->driver.bus = &macio_bus_type;
 
 	/* register with core */
-	count = driver_register(&drv->driver);
-	return count ? count : 1;
+	return driver_register(&drv->driver);
 }
 
 /**
