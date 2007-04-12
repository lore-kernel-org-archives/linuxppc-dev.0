Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 602D9DDF72
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 09:16:47 +1000 (EST)
Received: from [72.183.106.80] (helo=[192.168.1.2])
	by nommos.sslcatacombnetworking.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.63) (envelope-from <galak@kernel.crashing.org>)
	id 1Hc8Wx-0002uR-U2
	for linuxppc-dev@ozlabs.org; Thu, 12 Apr 2007 18:16:44 -0500
Date: Thu, 12 Apr 2007 18:12:50 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 7/7] Miscellaneous arch/powerpc Kconfig and platform/Kconfig
	cleanup
In-Reply-To: <Pine.LNX.4.64.0704121806330.28324@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0704121812280.28324@localhost.localdomain>
References: <Pine.LNX.4.64.0704121806330.28324@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Cleaned up some whitespace in arch/powerpc/Kconfig
* Moved sourcing of platforms/embedded6xx/Kconfig into platform/Kconfig
* Moved sourcing of platforms/4xx/Kconfig into platform/Kconfig and disabled it
* Removed EMBEDDEDBOOT since its not supported in arch/powerpc
* Removed PC_KEYBOARD since its not used anywhere
* Moved a few CONFIG options around in platform/Kconfig
* Moved interrupt controllers into platform/Kconfig out of bus section

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/Kconfig           |   37 +++++--------------------------------
 arch/powerpc/platforms/Kconfig |   38 +++++++++++++++++++++++++-------------
 2 files changed, 30 insertions(+), 45 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 033666c..26713da 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -192,7 +192,6 @@ config 44x
 	bool "AMCC 44x"
 	select PPC_DCR_NATIVE

-
 config E200
 	bool "Freescale e200"

@@ -375,9 +374,6 @@ source "init/Kconfig"

 source "arch/powerpc/platforms/Kconfig"

-source arch/powerpc/platforms/embedded6xx/Kconfig
-source arch/powerpc/platforms/4xx/Kconfig
-
 menu "Kernel options"

 config HIGHMEM
@@ -459,15 +455,6 @@ config CRASH_DUMP

 	  Don't change this unless you know what you are doing.

-config EMBEDDEDBOOT
-	bool
-	depends on 8xx || 8260
-	default y
-
-config PC_KEYBOARD
-	bool "PC PS/2 style Keyboard"
-	depends on 4xx || CPM2
-
 config PPCBUG_NVRAM
 	bool "Enable reading PPCBUG NVRAM during boot" if PPLUS || LOPEC
 	default y if PPC_PREP
@@ -481,7 +468,6 @@ config IRQ_ALL_CPUS
 	  CPU.  Generally saying Y is safe, although some problems have been
 	  reported with SMP Power Macintoshes with this option enabled.

-
 config NUMA
 	bool "NUMA support"
 	depends on PPC64
@@ -531,10 +517,10 @@ config PPC_64K_PAGES
 	depends on PPC64
 	help
 	  This option changes the kernel logical page size to 64k. On machines
-          without processor support for 64k pages, the kernel will simulate
-          them by loading each individual 4k page on demand transparently,
-          while on hardware with such support, it will be used to map
-          normal application pages.
+	  without processor support for 64k pages, the kernel will simulate
+	  them by loading each individual 4k page on demand transparently,
+	  while on hardware with such support, it will be used to map
+	  normal application pages.

 config SCHED_SMT
 	bool "SMT (Hyperthreading) scheduler support"
@@ -614,18 +600,6 @@ config GENERIC_ISA_DMA
 	depends on PPC64 || POWER4 || 6xx && !CPM2
 	default y

-config MPIC
-	bool
-	default n
-
-config MPIC_WEIRD
-	bool
-	default n
-
-config PPC_I8259
-	bool
-	default n
-
 config PPC_INDIRECT_PCI
 	bool
 	depends on PCI
@@ -857,11 +831,10 @@ source "fs/Kconfig"

 source "arch/powerpc/sysdev/qe_lib/Kconfig"

-
 source "lib/Kconfig"

 menu "Instrumentation Support"
-        depends on EXPERIMENTAL
+	depends on EXPERIMENTAL

 source "arch/powerpc/oprofile/Kconfig"

diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index e173fd4..86be82a 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -1,6 +1,4 @@
 menu "Platform support"
-	depends on PPC64 || CLASSIC32 || PPC_8xx || PPC_82xx || PPC_83xx || \
-			PPC_85xx || PPC_86xx

 choice
 	prompt "Machine type"
@@ -27,14 +25,6 @@ config APUS
 	  <http://linux-apus.sourceforge.net/>.
 endchoice

-config QUICC_ENGINE
-	bool
-	help
-	  The QUICC Engine (QE) is a new generation of communications
-	  coprocessors on Freescale embedded CPUs (akin to CPM in older chips).
-	  Selecting this option means that you wish to build a kernel
-	  for a machine with a QE coprocessor.
-
 source "arch/powerpc/platforms/pseries/Kconfig"
 source "arch/powerpc/platforms/iseries/Kconfig"
 source "arch/powerpc/platforms/chrp/Kconfig"
@@ -43,14 +33,16 @@ source "arch/powerpc/platforms/powermac/Kconfig"
 source "arch/powerpc/platforms/prep/Kconfig"
 source "arch/powerpc/platforms/maple/Kconfig"
 source "arch/powerpc/platforms/pasemi/Kconfig"
-source arch/powerpc/platforms/celleb/Kconfig
-source arch/powerpc/platforms/ps3/Kconfig
-source arch/powerpc/platforms/cell/Kconfig
+source "arch/powerpc/platforms/celleb/Kconfig"
+source "arch/powerpc/platforms/ps3/Kconfig"
+source "arch/powerpc/platforms/cell/Kconfig"
 source "arch/powerpc/platforms/8xx/Kconfig"
 source "arch/powerpc/platforms/82xx/Kconfig"
 source "arch/powerpc/platforms/83xx/Kconfig"
 source "arch/powerpc/platforms/85xx/Kconfig"
 source "arch/powerpc/platforms/86xx/Kconfig"
+source "arch/powerpc/platforms/embedded6xx/Kconfig"
+#source "arch/powerpc/platforms/4xx/Kconfig

 config PPC_NATIVE
 	bool
@@ -75,6 +67,18 @@ config XICS
 	bool
 	default y

+config MPIC
+	bool
+	default n
+
+config MPIC_WEIRD
+	bool
+	default n
+
+config PPC_I8259
+	bool
+	default n
+
 config U3_DART
 	bool
 	depends on PPC_MULTIPLATFORM && PPC64
@@ -225,6 +229,14 @@ config TAU_AVERAGE

 	  If in doubt, say N here.

+config QUICC_ENGINE
+	bool
+	help
+	  The QUICC Engine (QE) is a new generation of communications
+	  coprocessors on Freescale embedded CPUs (akin to CPM in older chips).
+	  Selecting this option means that you wish to build a kernel
+	  for a machine with a QE coprocessor.
+
 config CPM2
 	bool
 	default n
-- 
1.5.0.6
