Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 6FC52DDF19
	for <linuxppc-dev@ozlabs.org>; Wed,  2 May 2007 22:14:15 +1000 (EST)
Message-Id: <20070502115644.764580297@arndb.de>
References: <20070502114709.074174446@arndb.de>
Date: Wed, 02 May 2007 13:47:11 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/6] powerpc: Move CONFIG_PPC64 into CPU selection
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently, PPC64 is a top level configuration option in
arch/powerpc/Kconfig, which is somewhat unconventional.

Moving it into the CPU selection menu is a natural choice,
and is transparent to the rest of the configuration logic.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Index: linux-2.6/arch/powerpc/platforms/Kconfig.cputype
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/Kconfig.cputype
+++ linux-2.6/arch/powerpc/platforms/Kconfig.cputype
@@ -1,37 +1,24 @@
-config PPC64
-	bool "64-bit kernel"
-	default n
-	help
-	  This option selects whether a 32-bit or a 64-bit kernel
-	  will be built.
-
 menu "Processor support"
 choice
 	prompt "Processor Type"
-	depends on PPC32
 	default 6xx
-
-config CLASSIC32
-	bool "52xx/6xx/7xx/74xx"
-	select PPC_FPU
-	select 6xx
 	help
 	  There are four families of PowerPC chips supported.  The more common
 	  types (601, 603, 604, 740, 750, 7400), the Motorola embedded
-	  versions (821, 823, 850, 855, 860, 52xx, 82xx, 83xx), the AMCC
-	  embedded versions (403 and 405) and the high end 64 bit Power
-	  processors (POWER 3, POWER4, and IBM PPC970 also known as G5).
-
-	  This option is the catch-all for 6xx types, including some of the
-	  embedded versions.  Unless there is see an option for the specific
-	  chip family you are using, you want this option.
+	  versions (8xx, 55xx, 85xx), the AMCC embedded version (403, 405,
+	  440, 460) and the 64 bit processors (POWER 3, POWER4, POWER5,
+	  POWER6, PowerPC 970, Cell/B.E., PA6T).
 
-	  You do not want this if you are building a kernel for a 64 bit
-	  IBM RS/6000 or an Apple G5, choose 6xx.
+	  If unsure, select 52xx/6xx/7xx/74xx.
 
-	  If unsure, select this option
+config PPC64
+	bool "any 64 bit PowerPC"
+	select PPC_FPU
 
-	  Note that the kernel runs in 32-bit mode even on 64-bit chips.
+config CLASSIC32
+	bool "52xx/6xx/7xx/74xx"
+	select PPC_FPU
+	select 6xx
 
 config PPC_82xx
 	bool "Freescale 82xx"
@@ -119,7 +106,6 @@ config E500
 
 config PPC_FPU
 	bool
-	default y if PPC64
 
 config BOOKE
 	bool

--
