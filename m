Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 03 Jun 2009 17:17:37 +1000
Subject: [PATCH 2/5] powerpc: Introduce CONFIG_PPC_BOOK3S
In-Reply-To: <1244013451.727669.180978693322.qpush@grosgo>
Message-Id: <20090603071752.5BB91DDDF7@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch introduce a new Kconfig option, CONFIG_PPC_BOOK3S
that represents processors that are compliant with the "classic"
(aka "server") variant of the PowerPC architecture.

It replaces CONFIG_6xx on 32-bit (though the symbol is still
defined for compatibility) and encompass all currently supported
64-bit processors.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/platforms/Kconfig.cputype |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

--- linux-work.orig/arch/powerpc/platforms/Kconfig.cputype	2009-06-03 11:48:23.000000000 +1000
+++ linux-work/arch/powerpc/platforms/Kconfig.cputype	2009-06-03 15:04:56.000000000 +1000
@@ -9,7 +9,6 @@ menu "Processor support"
 choice
 	prompt "Processor Type"
 	depends on PPC32
-	default 6xx
 	help
 	  There are five families of 32 bit PowerPC chips supported.
 	  The most common ones are the desktop and server CPUs (601, 603,
@@ -21,7 +20,7 @@ choice
 
 	  If unsure, select 52xx/6xx/7xx/74xx/82xx/83xx/86xx.
 
-config 6xx
+config PPC_BOOK3S
 	bool "512x/52xx/6xx/7xx/74xx/82xx/83xx/86xx"
 	select PPC_FPU
 
@@ -57,13 +56,11 @@ config E200
 
 endchoice
 
-# Until we have a choice of exclusive CPU types on 64-bit, we always
-# use PPC_BOOK3S. On 32-bit, this is equivalent to 6xx which is
-# "classic" MMU
-
 config PPC_BOOK3S
-       def_bool y
-       depends on PPC64 || 6xx
+	default y
+       	depends on PPC64
+	select PPC_FPU
+
 
 config POWER4_ONLY
 	bool "Optimize for POWER4"
@@ -74,6 +71,10 @@ config POWER4_ONLY
 	  The resulting binary will not work on POWER3 or RS64 processors
 	  when compiled with binutils 2.15 or later.
 
+config 6xx
+	def_bool y
+	depends on PPC32 && PPC_BOOK3S
+
 config POWER3
 	bool
 	depends on PPC64 && PPC_BOOK3S
@@ -202,9 +203,8 @@ config SPE
 	  If in doubt, say Y here.
 
 config PPC_STD_MMU
-	bool
-	depends on 6xx || PPC64
-	default y
+	def_bool y
+	depends on PPC_BOOK3S
 
 config PPC_STD_MMU_32
 	def_bool y
