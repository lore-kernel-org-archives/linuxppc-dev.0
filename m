Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 53822DDE24
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jul 2007 05:44:44 +1000 (EST)
Message-Id: <20070713184823.452555107@arndb.de>
References: <20070713184452.466490031@arndb.de>
Date: Fri, 13 Jul 2007 20:44:53 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: paulus@samba.org
Subject: [PATCH 1/5] autoselect optimal -mcpu= flag by platform
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Loeliger <jdl@freescale.com> wrote:
X-Provags-ID: V01U2FsdGVkX1+BoY6XjUrGly1rWyOZxsXD2wcNMyeBnkUMy7/
 aE+cggJKYpJ3rKZ1wc9pqTY5IFAoNnY8dtj7q9qT51Y7DKTlnv
 RU/QVHeYEEj4zJk1aarlw==

> Hmmm... Shouldn't this sort of change come
> with an update to the 8641 defconfig too?
Content-Disposition: inline; filename=advanced-cpusel.diff

We can choose the -mcpu= gcc flags for compiling the kernel
based on the platform that we build for. In case of multiplatform
kernels, this chooses a setting for a common subset.

When using a platform type that can use different CPUs, a
new option CONFIG_PPC_CPU_SELECTION can be enabled to select
more specifically which CPUs the kernel will be able to
run on.

This replaces the CONFIG_POWER4_ONLY option with an much more
generic approach.

Also, when CONFIG_PPC_CPU_SELECTION is set, it is now possible
to select a CPU to tune for by means of the -mtune= option.

I tried to be very careful when coding the specific rules into
the Kconfig language, but it would be good to have a few
people sanity-checking them.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Index: linux-2.6/arch/powerpc/platforms/4xx/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/4xx/Kconfig
+++ linux-2.6/arch/powerpc/platforms/4xx/Kconfig
@@ -87,6 +87,7 @@ endmenu
 # 40x specific CPU modules, selected based on the board above.
 config NP405H
 	bool
+	select CPU_405
 	#depends on ASH
 
 # OAK doesn't exist but wanted to keep this around for any future 403GCX boards
@@ -94,6 +95,7 @@ config 403GCX
 	bool
 	#depends on OAK
 	select IBM405_ERR51
+	select CPU_403
 
 config 405GP
 	bool
@@ -102,19 +104,23 @@ config 405GP
 
 config 405EP
 	bool
+	select CPU_405
 
 config 405GPR
 	bool
+	select CPU_405
 
 config VIRTEX_II_PRO
 	bool
 	select IBM405_ERR77
 	select IBM405_ERR51
+	select CPU_405
 
 config STB03xxx
 	bool
 	select IBM405_ERR77
 	select IBM405_ERR51
+	select CPU_405
 
 # 40x errata/workaround config symbols, selected by the CPU models above
 
@@ -168,20 +174,25 @@ config 440EP
 	bool
 	select PPC_FPU
 	select IBM440EP_ERR42
+	select CPU_440
 
 config 440GP
 	bool
 	select IBM_NEW_EMAC_ZMII
+	select CPU_440
 
 config 440GX
 	bool
+	select CPU_440
 
 config 440SP
 	bool
+	select CPU_440
 
 config 440A
 	bool
 	depends on 440GX
+	select CPU_440
 	default y
 
 # 44x errata/workaround config symbols, selected by the CPU models above
Index: linux-2.6/arch/powerpc/platforms/52xx/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/52xx/Kconfig
+++ linux-2.6/arch/powerpc/platforms/52xx/Kconfig
@@ -25,12 +25,14 @@ config PPC_EFIKA
 	select RTAS_PROC
 	select PPC_MPC52xx
 	select PPC_NATIVE
+	select CPU_603e
 	default n
 
 config PPC_LITE5200
 	bool "Freescale Lite5200 Eval Board"
 	depends on PPC_MULTIPLATFORM && PPC32
 	select PPC_MPC5200
+	select CPU_603e
 	default n
 
 
Index: linux-2.6/arch/powerpc/platforms/82xx/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/82xx/Kconfig
+++ linux-2.6/arch/powerpc/platforms/82xx/Kconfig
@@ -10,6 +10,7 @@ config MPC82xx_ADS
 	select 8272
 	select 8260
 	select FSL_SOC
+	select CPU_603e
 	help
 	This option enables support for the MPC8272 ADS board
 
Index: linux-2.6/arch/powerpc/platforms/83xx/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/83xx/Kconfig
+++ linux-2.6/arch/powerpc/platforms/83xx/Kconfig
@@ -6,6 +6,7 @@ choice
 config MPC8313_RDB
 	bool "Freescale MPC8313 RDB"
 	select DEFAULT_UIMAGE
+	select CPU_603e
 	help
 	  This option enables support for the MPC8313 RDB board.
 
@@ -13,6 +14,7 @@ config MPC832x_MDS
 	bool "Freescale MPC832x MDS"
 	select DEFAULT_UIMAGE
 	select QUICC_ENGINE
+	select CPU_603e
 	help
 	  This option enables support for the MPC832x MDS evaluation board.
 
@@ -20,12 +22,14 @@ config MPC832x_RDB
 	bool "Freescale MPC832x RDB"
 	select DEFAULT_UIMAGE
 	select QUICC_ENGINE
+	select CPU_603e
 	help
 	  This option enables support for the MPC8323 RDB board.
 
 config MPC834x_MDS
 	bool "Freescale MPC834x MDS"
 	select DEFAULT_UIMAGE
+	select CPU_603e
 	help
 	  This option enables support for the MPC 834x MDS evaluation board.
 
@@ -37,6 +41,7 @@ config MPC834x_MDS
 config MPC834x_ITX
 	bool "Freescale MPC834x ITX"
 	select DEFAULT_UIMAGE
+	select CPU_603e
 	help
 	  This option enables support for the MPC 834x ITX evaluation board.
 
@@ -47,6 +52,7 @@ config MPC836x_MDS
 	bool "Freescale MPC836x MDS"
 	select DEFAULT_UIMAGE
 	select QUICC_ENGINE
+	select CPU_603e
 	help
 	  This option enables support for the MPC836x MDS Processor Board.
 
Index: linux-2.6/arch/powerpc/platforms/86xx/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/86xx/Kconfig
+++ linux-2.6/arch/powerpc/platforms/86xx/Kconfig
@@ -7,6 +7,7 @@ config MPC8641_HPCN
 	bool "Freescale MPC8641 HPCN"
 	select PPC_I8259
 	select DEFAULT_UIMAGE
+	select CPU_7450
 	help
 	  This option enables support for the MPC8641 HPCN board.
 
Index: linux-2.6/arch/powerpc/platforms/Kconfig.cputype
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/Kconfig.cputype
+++ linux-2.6/arch/powerpc/platforms/Kconfig.cputype
@@ -51,14 +51,352 @@ config E200
 
 endchoice
 
-config POWER4_ONLY
-	bool "Optimize for POWER4"
+config PPC_CPU_SELECTION
+	bool "Advanced CPU selection"
+	help
+	  The kernel can be built for a range of CPU types, which it
+	  normally determines automatically from the platform types that
+	  have been enabled.  In order to optimized leaving out support
+	  for the older CPUs or selecting the exact -mtune= option that
+	  is passed to gcc, you can further optimize the kernel for a
+	  particular system.
+
+	  Selecting this option will not cause changes directly, but will
+	  reveal further options.
+
+	  If unsure, say N.
+
+config CPU_DEFAULT
+	bool "Don't specify -mcpu= to gcc" if PPC_CPU_SELECTION
+	help
+	  When this option is selected, gcc is called without
+	  any specific -mcpu= argument, regardless of which
+	  CPUs are enabled in the next options.
+
+config CPU_RS64
+	bool "RS64" if PPC_CPU_SELECTION
 	depends on PPC64
-	default n
-	---help---
-	  Cause the compiler to optimize for POWER4/POWER5/PPC970 processors.
-	  The resulting binary will not work on POWER3 or RS64 processors
-	  when compiled with binutils 2.15 or later.
+	default y if PPC_PSERIES || PPC_ISERIES
+	help
+	  Select this if you want to have support for the first
+	  generation of 64 bit PowerPC CPUs used in the late
+	  1990s in IBM RS/6000 and AS/400 machines.
+
+config CPU_POWER3
+	bool "IBM Power3" if PPC_CPU_SELECTION
+	depends on PPC64
+	default y if PPC_PSERIES
+	help
+	  Select this if you want to have support for the
+	  Power3 chip used in IBM RS/6000 and early pSeries
+	  machines.
+
+config CPU_POWER4
+	bool "IBM Power4" if PPC_CPU_SELECTION
+	depends on PPC64
+	default y if PPC_PSERIES || PPC_ISERIES
+	help
+	  Select this if you want to have support for the Power 4
+	  processor used in IBM pSeries and iSeries machines.
+
+config CPU_POWER5
+	bool "IBM Power5" if PPC_CPU_SELECTION
+	depends on PPC64
+	default y if PPC_PSERIES
+	help
+	  Select this if you want to have support for the Power 5
+	  processor used in IBM System p and System i machines.
+
+config CPU_POWER6
+	bool "IBM Power6" if PPC_CPU_SELECTION
+	depends on PPC64
+	default y if PPC_PSERIES
+	select ALTIVEC
+	help
+	  Select this if you want to have support for the Power 6
+	  processor used in the latest IBM System p and System i
+	  machines.
+
+config CPU_970
+	bool "IBM PowerPC 970 (G5)" if PPC_CPU_SELECTION
+	depends on PPC64
+	default y if PPC_PSERIES
+	select ALTIVEC
+	help
+	  Select this if you want to have support for the PowerPC 970
+	  processor used in Apple Power Macintosh G5 and IBM JS2x blade
+	  servers and other systems.
+
+config CPU_CELL
+	bool "Sony/Toshiba/IBM Cell Broadband Engine" if PPC_CPU_SELECTION
+	depends on PPC64
+	select ALTIVEC
+	help
+	  Select this if you want to have support for the Cell Broadband
+	  Engine processor used the Sony Playstation 3, the IBM QS2x
+	  blade servers and other systems.
+
+config CPU_PA6T
+	bool "PA Semi PA6T-1682M" if PPC_CPU_SELECTION
+	depends on PPC64
+	select ALTIVEC
+	help
+	  Select this if you want to have support for the PA6T-1682M
+	  processor from  PA Semi.
+
+config CPU_601
+	bool "PowerPC 601 (G1)" if PPC_CPU_SELECTION
+	depends on 6xx
+	default PPC_CHRP || PPC_PREP
+	help
+	  Select this if you really wish to have support for ancient PowerPC
+	  601 processors used in very early Power Macintosh machines and
+	  some CHRP boards.
+	  Most people will want to disable this option to get better
+	  performance on modern machines.
+
+config CPU_603e
+	bool "PowerPC 603e, 604, 604e, 52xx, 82xx, 83xx (G2)" if PPC_CPU_SELECTION
+	depends on 6xx
+	default PPC_CHRP || PPC_PREP || PPC_PMAC
+	help
+	  The 603e processor line is the most widespread implementation of
+	  the PowerPC ISA, so you most likely want to enable this if you are
+	  building a kernel for multiple platforms.
+
+config CPU_750
+	bool "PowerPC 740, 750 (G3)" if PPC_CPU_SELECTION
+	depends on 6xx
+	default PPC_PMAC
+	help
+	  Select this for the G3 PowerPC 750 processor used in Apple
+	  Power Macintosh and a number of embedded boards.
+
+config CPU_7400
+	bool "PowerPC 7400, 7410 (G4)" if PPC_CPU_SELECTION
+	depends on 6xx
+	default PPC_PMAC
+	select ALTIVEC
+	help
+	  Select this for the early G4 PowerPC 7400 processor used in
+	  a few Apple Power Macintosh and other machines.
+
+config CPU_7450
+	bool "PowerPC 744x, 745x, 86xx (G4)" if PPC_CPU_SELECTION
+	depends on 6xx
+	default PPC_PMAC
+	select ALTIVEC
+	help
+	  Select this for the later G4 PowerPC 7450 processor and its
+	  derivatives used in most of the late Apple Power Macintosh
+	  machines and some high-performance embedded boards.
+
+config CPU_8540
+	bool "Freescale e500v1 (MPC8540 compatible)" if PPC_CPU_SELECTION
+	depends on PPC_85xx
+	help
+	  Select this for the older version 1 of the e500 core used in
+	  the earlier MPC85xx processors.
+
+config CPU_8548
+	bool "Freescale e500v2 (MPC8548 compatible)" if PPC_CPU_SELECTION
+	depends on PPC_85xx
+	help
+	  Select this for the newer version 2 of the e500 core that was
+	  first used in the MPC8548 processor.
+	  Some versions of gcc don't know about this yet, so you may
+	  also have to enable 8540 to get the best performance with
+	  your compiler.
+
+config CPU_403
+	bool "IBM 403" if PPC_CPU_SELECTION
+	depends on 40x
+	help
+	  The PowerPC 403 core is used in the first generation Tivo and
+	  some other old machines. Select this only if you are sure that
+	  you want to run your kernel on one of these machines.
+
+config CPU_405
+	bool "IBM/AMCC 405" if PPC_CPU_SELECTION
+	depends on 40x
+	default y
+	help
+	  Practically all PowerPC 40x based platforms supported by Linux use
+	  a 405 core, so you should enable this option.
+
+config CPU_440
+	bool "IBM/AMCC 440" if PPC_CPU_SELECTION
+	depends on 44x
+	default y
+	help
+	  If you are building for a PowerPC 440 based, you don't really
+	  have a choice here, say Y.
+
+choice
+	prompt "Tune for processor type" if PPC_CPU_SELECTION
+	default TUNE_POWER4 if PPC64
+	default TUNE_DEFAULT
+	help
+	  This will choose the gcc flag to use for the -mtune= parameter.
+	  See the above list for a description of the invidual options.
+
+	  If unsure, select TUNE_DEFAULT, gcc will tune for the oldest
+	  CPU that the kernel supports in that case, which usually
+	  gives reasonable results on newer CPUs as well.
+
+config TUNE_DEFAULT
+	bool "Don't specify -mtune= to gcc"
+
+config TUNE_RS64
+	bool "RS64"
+	depends on CPU_RS64
+
+config TUNE_POWER3
+	bool "IBM Power3"
+	depends on CPU_POWER3
+
+config TUNE_POWER4
+	bool "IBM Power4"
+	depends on CPU_POWER4
+
+config TUNE_POWER5
+	bool "IBM Power5"
+	depends on CPU_POWER5
+
+config TUNE_POWER6
+	bool "IBM Power6"
+	depends on CPU_POWER6
+
+config TUNE_970
+	bool "IBM PowerPC 970 (G5)"
+	depends on CPU_970
+
+config TUNE_CELL
+	bool "Sony/Toshiba/IBM Cell Broadband Engine"
+	depends on CPU_CELL
+
+config TUNE_PA6T
+	bool "PA Semi PA6T-1682M"
+	depends on CPU_PA6T
+
+config TUNE_601
+	bool "PowerPC 601 (G1)"
+	depends on CPU_601
+
+config TUNE_603e
+	bool "PowerPC 603e, 604, 604e, 52xx, 82xx, 83xx (G2)"
+	depends on CPU_603e
+
+config TUNE_750
+	bool "PowerPC 740/750 (G3)"
+	depends on CPU_750
+
+config TUNE_7400
+	bool "PowerPC 7400, 7410 (G4)"
+	depends on CPU_7400
+
+config TUNE_7450
+	bool "PowerPC 744x, 745x, 86xx (G4)"
+	depends on CPU_7450
+
+config TUNE_821
+	bool "Freescale MPC821"
+	depends on 8xx
+
+config TUNE_823
+	bool "Freescale MPC823"
+	depends on 8xx
+
+config TUNE_860
+	bool "Freescale MPC860"
+	depends on 8xx
+
+config TUNE_403
+	bool "IBM 403"
+	depends on CPU_403
+
+config TUNE_405
+	bool "IBM/AMCC 405"
+	depends on CPU_405
+
+config TUNE_440
+	bool "IBM/AMCC 440"
+	depends on CPU_440
+
+config TUNE_8540
+	bool "Freescale e500v1"
+	depends on CPU_8540
+
+config TUNE_8548
+	bool "Freescale e500v2"
+	depends on CPU_8548
+
+config TUNE_E200
+	bool "Freescale e200"
+	depends on E200
+
+endchoice
+
+config PPC_MCPU
+	string
+	default "" if CPU_DEFAULT
+	default "-mcpu=power3" if CPU_POWER3 || CPU_RS64
+	default "-mcpu=power4" if (CPU_POWER5 || CPU_POWER6) && (CPU_970 || CPU_CELL || CPU_PA6T)
+	default "-mcpu=power4" if CPU_POWER4
+	default "-mcpu=power5" if CPU_POWER5
+	default "-mcpu=power6" if CPU_POWER6
+	default "-mcpu=970" if CPU_970
+	default "-mcpu=cell" if CPU_CELL
+	default "-mcpu=pa6t" if CPU_PA6T
+	default "-mcpu=power3" if PPC64
+	default "-mcpu=powerpc" if CPU_601 && (CPU_603e || CPU_750 || CPU_7400 || CPU_7450)
+	default "-mcpu=601" if CPU_601
+	default "-mcpu=603e" if CPU_603e
+	default "-mcpu=750" if CPU_750
+	default "-mcpu=7400" if CPU_7400
+	default "-mcpu=7450" if CPU_7450
+	default "-mcpu=8540" if CPU_8540
+	default "-mcpu=8548" if CPU_8548
+	default "-mcpu=powerpc" if (CPU_403 && CPU_405)
+	default "-mcpu=powerpc" if (CPU_403 || CPU_405) && CPU_440
+	default "-mcpu=403" if CPU_403
+	default "-mcpu=405" if CPU_405
+	default "-mcpu=440" if CPU_440
+	default "-mcpu=860" if PPC_8xx
+	default "-mcpu=e200" if E200
+	default "-mcpu=powerpc"
+
+config PPC_MTUNE
+	string
+	default "" if TUNE_DEFAULT
+	default "-mtune=power3" if TUNE_POWER3
+	default "-mtune=rs64a" if TUNE_RS64
+	default "-mtune=power4" if TUNE_POWER4
+	default "-mtune=power5" if TUNE_POWER5
+	default "-mtune=power6" if TUNE_POWER6
+	default "-mtune=970" if TUNE_970
+	default "-mtune=cell" if TUNE_CELL
+	default "-mtune=pa6t" if TUNE_PA6T
+	default "-mtune=601" if TUNE_601
+	default "-mtune=603e" if TUNE_603e
+	default "-mtune=750" if TUNE_750
+	default "-mtune=7400" if TUNE_7400
+	default "-mtune=7450" if TUNE_7450
+	default "-mtune=8540" if TUNE_8540
+	default "-mtune=8548" if TUNE_8548
+	default "-mtune=403" if TUNE_403
+	default "-mtune=405" if TUNE_405
+	default "-mtune=440" if TUNE_440
+	default "-mtune=821" if TUNE_821
+	default "-mtune=823" if TUNE_823
+	default "-mtune=860" if TUNE_860
+	default "-mtune=e200" if TUNE_E200
+	default "-mtune=power4" if PPC64
+
+# The next three options should probably go away
+config POWER4_ONLY
+	def_bool y
+	depends on PPC64 && !CPU_POWER3 && !CPU_RS64
 
 config POWER3
 	bool
Index: linux-2.6/arch/powerpc/platforms/cell/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/Kconfig
+++ linux-2.6/arch/powerpc/platforms/cell/Kconfig
@@ -20,6 +20,7 @@ config PPC_IBM_CELL_BLADE
 	select MMIO_NVRAM
 	select PPC_UDBG_16550
 	select UDBG_RTAS_CONSOLE
+	select CPU_CELL
 
 menu "Cell Broadband Engine options"
 	depends on PPC_CELL
Index: linux-2.6/arch/powerpc/platforms/celleb/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/celleb/Kconfig
+++ linux-2.6/arch/powerpc/platforms/celleb/Kconfig
@@ -2,6 +2,7 @@ config PPC_CELLEB
 	bool "Toshiba's Cell Reference Set 'Celleb' Architecture"
 	depends on PPC_MULTIPLATFORM && PPC64
 	select PPC_CELL
+	select CPU_CELL
 	select PPC_OF_PLATFORM_PCI
 	select HAS_TXX9_SERIAL
 	select PPC_UDBG_BEAT
Index: linux-2.6/arch/powerpc/platforms/embedded6xx/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/embedded6xx/Kconfig
+++ linux-2.6/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -8,6 +8,7 @@ config LINKSTATION
 	select FSL_SOC
 	select PPC_UDBG_16550 if SERIAL_8250
 	select DEFAULT_UIMAGE
+	select CPU_603e
 	help
 	  Select LINKSTATION if configuring for one of PPC- (MPC8241)
 	  based NAS systems from Buffalo Technology. So far only
@@ -20,6 +21,7 @@ config MPC7448HPC2
 	select TSI108_BRIDGE
 	select DEFAULT_UIMAGE
 	select PPC_UDBG_16550
+	select CPU_7450
 	help
 	  Select MPC7448HPC2 if configuring for Freescale MPC7448HPC2 (Taiga)
 	  platform
@@ -29,6 +31,7 @@ config PPC_HOLLY
 	select TSI108_BRIDGE
 	select PPC_UDBG_16550
 	select WANT_DEVICE_TREE
+	select CPU_750
 	help
 	  Select PPC_HOLLY if configuring for an IBM 750GX/CL Eval
 	  Board with TSI108/9 bridge (Hickory/Holly)
@@ -38,6 +41,7 @@ config PPC_PRPMC2800
 	select MV64X60
 	select NOT_COHERENT_CACHE
 	select WANT_DEVICE_TREE
+	select CPU_7450
 	help
 	  This option enables support for the Motorola PrPMC2800 board
 endchoice
Index: linux-2.6/arch/powerpc/platforms/maple/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/maple/Kconfig
+++ linux-2.6/arch/powerpc/platforms/maple/Kconfig
@@ -11,6 +11,7 @@ config PPC_MAPLE
 	select PPC_RTAS
 	select MMIO_NVRAM
 	select ATA_NONSTANDARD if ATA
+	select CPU_970
 	default n
 	help
           This option enables support for the Maple 970FX Evaluation Board.
Index: linux-2.6/arch/powerpc/platforms/pasemi/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pasemi/Kconfig
+++ linux-2.6/arch/powerpc/platforms/pasemi/Kconfig
@@ -2,6 +2,7 @@ config PPC_PASEMI
 	depends on PPC_MULTIPLATFORM && PPC64
 	bool "PA Semi SoC-based platforms"
 	default n
+	select CPU_PA6T
 	select MPIC
 	select PPC_UDBG_16550
 	select PPC_NATIVE
Index: linux-2.6/arch/powerpc/platforms/powermac/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/powermac/Kconfig
+++ linux-2.6/arch/powerpc/platforms/powermac/Kconfig
@@ -16,6 +16,7 @@ config PPC_PMAC64
 	select MPIC_U3_HT_IRQS
 	select GENERIC_TBSYNC
 	select PPC_970_NAP
+	select CPU_970
 	default y
 
 
Index: linux-2.6/arch/powerpc/platforms/ps3/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/ps3/Kconfig
+++ linux-2.6/arch/powerpc/platforms/ps3/Kconfig
@@ -2,6 +2,7 @@ config PPC_PS3
 	bool "Sony PS3 (incomplete)"
 	depends on PPC_MULTIPLATFORM && PPC64
 	select PPC_CELL
+	select CPU_CELL
 	select USB_ARCH_HAS_OHCI
 	select USB_OHCI_LITTLE_ENDIAN
 	select USB_OHCI_BIG_ENDIAN_MMIO
Index: linux-2.6/arch/powerpc/Makefile
===================================================================
--- linux-2.6.orig/arch/powerpc/Makefile
+++ linux-2.6/arch/powerpc/Makefile
@@ -78,24 +78,23 @@ LINUXINCLUDE    += $(LINUXINCLUDE-y)
 
 CHECKFLAGS	+= -m$(SZ) -D__powerpc__ -D__powerpc$(SZ)__
 
+OPTFLAGS := $(call cc-option,$(CONFIG_PPC_MCPU)) $(call cc-option,$(CONFIG_PPC_MTUNE))
+
+# compilers older than 4.0.0 can only set -maltivec in 64 bit mode
+# when compiling for 970
 ifeq ($(CONFIG_PPC64),y)
 GCC_BROKEN_VEC	:= $(shell if [ $(call cc-version) -lt 0400 ] ; then echo "y"; fi)
-
 ifeq ($(CONFIG_POWER4_ONLY),y)
 ifeq ($(CONFIG_ALTIVEC),y)
 ifeq ($(GCC_BROKEN_VEC),y)
-	CFLAGS += $(call cc-option,-mcpu=970)
-else
-	CFLAGS += $(call cc-option,-mcpu=power4)
+	OPTFLAGS := $(call cc-option,-mcpu=970) $(call cc-option,$(CONFIG_PPC_MTUNE))
 endif
-else
-	CFLAGS += $(call cc-option,-mcpu=power4)
 endif
-else
-	CFLAGS += $(call cc-option,-mtune=power4)
 endif
 endif
 
+CFLAGS += $(OPTFLAGS)
+
 # No AltiVec instruction when building kernel
 CFLAGS += $(call cc-option,-mno-altivec)
 
@@ -107,10 +106,6 @@ CFLAGS += $(call cc-option,-funit-at-a-t
 # often slow when they are implemented at all
 CFLAGS		+= -mno-string
 
-ifeq ($(CONFIG_6xx),y)
-CFLAGS		+= -mcpu=powerpc
-endif
-
 cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
 cpu-as-$(CONFIG_6xx)		+= -Wa,-maltivec
 cpu-as-$(CONFIG_POWER4)		+= -Wa,-maltivec
Index: linux-2.6/arch/powerpc/platforms/85xx/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/85xx/Kconfig
+++ linux-2.6/arch/powerpc/platforms/85xx/Kconfig
@@ -6,24 +6,28 @@ choice
 config MPC8540_ADS
 	bool "Freescale MPC8540 ADS"
 	select DEFAULT_UIMAGE
+	select CPU_8540
 	help
 	  This option enables support for the MPC 8540 ADS board
 
 config MPC8560_ADS
 	bool "Freescale MPC8560 ADS"
 	select DEFAULT_UIMAGE
+	select CPU_8540
 	help
 	  This option enables support for the MPC 8560 ADS board
 
 config MPC85xx_CDS
 	bool "Freescale MPC85xx CDS"
 	select DEFAULT_UIMAGE
+	select CPU_8548
 	help
 	  This option enables support for the MPC85xx CDS board
 
 config MPC85xx_MDS
 	bool "Freescale MPC85xx MDS"
 	select DEFAULT_UIMAGE
+	select CPU_8548
 #	select QUICC_ENGINE
 	help
 	  This option enables support for the MPC85xx MDS board
@@ -31,6 +35,7 @@ config MPC85xx_MDS
 config MPC8544_DS
 	bool "Freescale MPC8544 DS"
 	select DEFAULT_UIMAGE
+	select CPU_8548
 	help
 	  This option enables support for the MPC8544 DS board
 

--
