Return-Path: <hansendc@us.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0559EDDEE8
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 03:42:13 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2GGgAe3018809
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:42:10 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l2GGgAOf061558
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 10:42:10 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l2GGgAGV029657
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 10:42:10 -0600
Subject: [PATCH] fix viocons allyesconfig #error
To: boutcher@us.ibm.com
From: Dave Hansen <hansendc@us.ibm.com>
Date: Fri, 16 Mar 2007 09:42:09 -0700
Message-Id: <20070316164209.935CC8F0@elm3b173.beaverton.ibm.com>
Cc: linuxppc-dev@ozlabs.org, ryanarn@us.ibm.com,
	Dave Hansen <hansendc@us.ibm.com>, devilbis@us.ibm.com, sfr@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


make allyesconfig bombs out, and probably has for years.

This should fix it in the right way.  The #error in a .c
file is a wee bit of a hack, and Kconfig should be a bit
more refined.

Signed-off-by: Dave Hansen <hansendc@us.ibm.com>
---


diff -puN arch/powerpc/platforms/iseries/Kconfig~viocons-allyesconfig-fix arch/powerpc/platforms/iseries/Kconfig
--- lxc/arch/powerpc/platforms/iseries/Kconfig~viocons-allyesconfig-fix	2007-03-15 08:52:51.000000000 -0700
+++ lxc-dave/arch/powerpc/platforms/iseries/Kconfig	2007-03-15 08:52:51.000000000 -0700
@@ -4,11 +4,15 @@ menu "iSeries device drivers"
 
 config VIOCONS
 	tristate "iSeries Virtual Console Support (Obsolete)"
+	depends on !VT
 	help
 	  This is the old virtual console driver for legacy iSeries.
 	  You should use the iSeries Hypervisor Virtual Console
 	  support instead.
 
+comment "iSeries Virtual Console Support requires disabling VT"
+	depends on VT
+
 config VIODASD
 	tristate "iSeries Virtual I/O disk support"
 	help
diff -puN drivers/char/viocons.c~viocons-allyesconfig-fix drivers/char/viocons.c
--- lxc/drivers/char/viocons.c~viocons-allyesconfig-fix	2007-03-15 08:52:51.000000000 -0700
+++ lxc-dave/drivers/char/viocons.c	2007-03-15 08:52:51.000000000 -0700
@@ -49,10 +49,6 @@
 #include <asm/iseries/hv_lp_config.h>
 #include <asm/iseries/hv_call.h>
 
-#ifdef CONFIG_VT
-#error You must turn off CONFIG_VT to use CONFIG_VIOCONS
-#endif
-
 #define VIOTTY_MAGIC (0x0DCB)
 #define VTTY_PORTS 10
 
_
