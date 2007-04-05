Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 46067DDE34
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 14:04:45 +1000 (EST)
Date: Thu, 5 Apr 2007 14:04:44 +1000
To: linuxppc-dev@ozlabs.org
Subject: [RFC/PATCH] [POWERPC] Forcefully select at least one platform in
	MULIT_PLATFORM builds.
Message-ID: <20070405040444.GV12768@bakeyournoodle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: tony@bakeyournoodle.com (Tony Breeds)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This was discovered by Rob Landley with 2.6.20.4 and reported on lkml
(http://marc.info/?l=linux-kernel&m=117529162824010).  This patch forces
the selection of at least one platform.

It does have the side effect that in order to turn off pSeries (or CHRP
for ppc32) you need to select at least one other platform, which I admit
might be a little strange.

From: Tony Breeds <tony@bakeyournoodle.com>

[PATCH] [POWERPC] Forcefully select at least one platform in MULIT_PLATFORM builds.

Currently it is possible to select PPC_MULTI_PLATFORM, and then select no
platforms, this is unlikely to create a working kernel.  Introduce a couple
of new Kconfig variables to forcefully select at least one platform.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/Kconfig |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 0855d55..27d53b6 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -360,6 +360,14 @@ endmenu
 
 source "init/Kconfig"
 
+config PPC_PLATFORM_CHOSEN
+	def_bool n
+
+config PPC_DEFAULT_PLATFORM
+	def_bool PPC_MULTIPLATFORM && !PPC_PLATFORM_CHOSEN
+	select PPC_CHRP    if PPC32
+	select PPC_PSERIES if PPC64
+
 menu "Platform support"
 	depends on PPC64 || CLASSIC32
 
@@ -406,12 +414,15 @@ config PPC_PSERIES
 	select RTAS_ERROR_LOGGING
 	select PPC_UDBG_16550
 	select PPC_NATIVE
+# No need to "select PPC_PLATFORM_CHOSEN" for pSeries, as it is the default
+# platform for PPC64, see PPC_DEFAULT_PLATFORM
 	default y
 
 config PPC_ISERIES
 	bool "IBM Legacy iSeries"
 	depends on PPC_MULTIPLATFORM && PPC64
 	select PPC_INDIRECT_IO
+	select PPC_PLATFORM_CHOSEN
 
 config PPC_CHRP
 	bool "Common Hardware Reference Platform (CHRP) based machines"
@@ -423,6 +434,8 @@ config PPC_CHRP
 	select PPC_MPC106
 	select PPC_UDBG_16550
 	select PPC_NATIVE
+# No need to "select PPC_PLATFORM_CHOSEN" here, as it is the default platform 
+# for PPC32, see PPC_DEFAULT_PLATFORM
 	default y
 
 config PPC_MPC52xx
@@ -436,6 +449,7 @@ config PPC_EFIKA
 	select RTAS_PROC
 	select PPC_MPC52xx
 	select PPC_NATIVE
+	select PPC_PLATFORM_CHOSEN
 	default n
 
 config PPC_LITE5200
@@ -451,6 +465,7 @@ config PPC_PMAC
 	select PPC_INDIRECT_PCI if PPC32
 	select PPC_MPC106 if PPC32
 	select PPC_NATIVE
+	select PPC_PLATFORM_CHOSEN
 	default y
 
 config PPC_PMAC64
@@ -461,6 +476,7 @@ config PPC_PMAC64
 	select MPIC_BROKEN_U3
 	select GENERIC_TBSYNC
 	select PPC_970_NAP
+	select PPC_PLATFORM_CHOSEN
 	default y
 
 config PPC_PREP
@@ -471,6 +487,7 @@ config PPC_PREP
 	select PPC_INDIRECT_PCI
 	select PPC_UDBG_16550
 	select PPC_NATIVE
+	select PPC_PLATFORM_CHOSEN
 	default n
 
 config PPC_MAPLE
@@ -484,6 +501,7 @@ config PPC_MAPLE
 	select PPC_970_NAP
 	select PPC_NATIVE
 	select PPC_RTAS
+	select PPC_PLATFORM_CHOSEN
 	default n
 	help
           This option enables support for the Maple 970FX Evaluation Board.
@@ -497,6 +515,7 @@ config PPC_PASEMI
 	select PPC_UDBG_16550
 	select GENERIC_TBSYNC
 	select PPC_NATIVE
+	select PPC_PLATFORM_CHOSEN
 	help
 	  This option enables support for PA Semi's PWRficient line
 	  of SoC processors, including PA6T-1682M
@@ -523,11 +542,13 @@ config PPC_IBM_CELL_BLADE
 	select MMIO_NVRAM
 	select PPC_UDBG_16550
 	select UDBG_RTAS_CONSOLE
+	select PPC_PLATFORM_CHOSEN
 
 config PPC_PS3
 	bool "Sony PS3"
 	depends on PPC_MULTIPLATFORM && PPC64
 	select PPC_CELL
+	select PPC_PLATFORM_CHOSEN
 	help
 	  This option enables support for the Sony PS3 game console
 	  and other platforms using the PS3 hypervisor.
-- 
1.5.0.6



Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
