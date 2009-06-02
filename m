Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 02 Jun 2009 17:50:09 +1000
Subject: [PATCH 3/5] powerpc: Introduce CONFIG_PPC_BOOK3S
In-Reply-To: <1243929002.876045.46197476176.qpush@grosgo>
Message-Id: <20090602075022.57FE2DDF72@ozlabs.org>
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

 arch/powerpc/platforms/Kconfig.cputype |   28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

--- linux-work.orig/arch/powerpc/platforms/Kconfig.cputype	2009-06-02 16:29:27.000000000 +1000
+++ linux-work/arch/powerpc/platforms/Kconfig.cputype	2009-06-02 16:55:01.000000000 +1000
@@ -9,7 +9,6 @@ menu "Processor support"
 choice
 	prompt "Processor Type"
 	depends on PPC32
-	default 6xx
 	help
 	  There are five families of 32 bit PowerPC chips supported.
 	  The most common ones are the desktop and server CPUs (601, 603,
@@ -21,24 +20,27 @@ choice
 
 	  If unsure, select 52xx/6xx/7xx/74xx/82xx/83xx/86xx.
 
-config 6xx
+config PPC_BOOK3S
 	bool "512x/52xx/6xx/7xx/74xx/82xx/83xx/86xx"
 	select PPC_FPU
 
 config PPC_85xx
 	bool "Freescale 85xx"
+	depends on PPC32
 	select E500
 	select FSL_SOC
 	select MPC85xx
 
 config PPC_8xx
 	bool "Freescale 8xx"
+	depends on PPC32
 	select FSL_SOC
 	select 8xx
 	select PPC_LIB_RHEAP
 
 config 40x
 	bool "AMCC 40x"
+	depends on PPC32
 	select PPC_DCR_NATIVE
 	select PPC_UDBG_16550
 	select 4xx_SOC
@@ -46,6 +48,7 @@ config 40x
 
 config 44x
 	bool "AMCC 44x"
+	depends on PPC32
 	select PPC_DCR_NATIVE
 	select PPC_UDBG_16550
 	select 4xx_SOC
@@ -54,16 +57,15 @@ config 44x
 
 config E200
 	bool "Freescale e200"
+	depends on PPC32
 
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
@@ -74,6 +76,10 @@ config POWER4_ONLY
 	  The resulting binary will not work on POWER3 or RS64 processors
 	  when compiled with binutils 2.15 or later.
 
+config 6xx
+	def_bool y
+	depends on PPC32 && PPC_BOOK3S
+
 config POWER3
 	bool
 	depends on PPC64 && PPC_BOOK3S
@@ -125,6 +131,7 @@ config BOOKE
 config FSL_BOOKE
 	bool
 	depends on E200 || E500
+	select PPC_BOOK3E_MMU
 	default y
 
 config FSL_EMB_PERFMON
@@ -203,7 +210,7 @@ config SPE
 
 config PPC_STD_MMU
 	bool
-	depends on 6xx || PPC64
+	depends on PPC_BOOK3S
 	default y
 
 config PPC_STD_MMU_32
@@ -219,8 +226,7 @@ config PPC_MMU_NOHASH
 	depends on !PPC_STD_MMU
 
 config PPC_BOOK3E_MMU
-	def_bool y
-	depends on FSL_BOOKE
+       def_bool n
 
 config PPC_MM_SLICES
 	bool
