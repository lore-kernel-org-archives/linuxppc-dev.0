Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id C87B7DDEC8
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 09:36:26 +1000 (EST)
Message-Id: <20070611233354.844566166@arndb.de>
References: <20070611232824.489103547@arndb.de>
Date: Tue, 12 Jun 2007 01:28:34 +0200
From: arnd@arndb.de
To: paulus@samba.org
Subject: [patch 10/10] powerpc: autoselect optimal -mcpu= flag by platform
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

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
@@ -1,6 +1,7 @@
 config PPC_MPC52xx
 	bool "Freescale 52xx"
 	select FSL_SOC
+	depends on 6xx
 
 config PPC_EFIKA
 	bool "bPlan Efika 5k2. MPC5200B based computer"
@@ -9,6 +10,7 @@ config PPC_EFIKA
 	select PPC_RTAS
 	select RTAS_PROC
 	select PPC_NATIVE
+	select CPU_603e
 	default n
 
 config PPC_LITE5200
@@ -16,6 +18,7 @@ config PPC_LITE5200
 	depends on PPC_MULTIPLATFORM && PPC32
 	depends on PPC_MPC52xx
 	select PPC_MPC5200
+	select CPU_603e
 	default n
 
 config PPC_MPC5200
Index: linux-2.6/arch/powerpc/platforms/82xx/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/82xx/Kconfig
+++ linux-2.6/arch/powerpc/platforms/82xx/Kconfig
@@ -1,6 +1,7 @@
 config PPC_82xx
 	bool "Freescale 82xx"
 	depends on PPC_MULTIPLATFORM && 6xx
+	select CPU_603e
 
 config MPC82xx_ADS
 	bool "Freescale MPC82xx ADS"
Index: linux-2.6/arch/powerpc/platforms/83xx/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/83xx/Kconfig
+++ linux-2.6/arch/powerpc/platforms/83xx/Kconfig
@@ -4,6 +4,7 @@ config PPC_83xx
 	select FSL_SOC
 	select 83xx
 	select WANT_DEVICE_TREE
+	select CPU_603e
 
 config MPC8313_RDB
 	bool "Freescale MPC8313 RDB"
Index: linux-2.6/arch/powerpc/platforms/86xx/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/86xx/Kconfig
+++ linux-2.6/arch/powerpc/platforms/86xx/Kconfig
@@ -4,6 +4,7 @@ config PPC_86xx
 	select FSL_SOC
 	select FSL_PCIE
 	select ALTIVEC
+	select CPU_74xx
 	help
 	  The Freescale E600 SoCs have 74xx cores.
 
Index: linux-2.6/arch/powerpc/platforms/Kconfig.cputype
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/Kconfig.cputype
+++ linux-2.6/arch/powerpc/platforms/Kconfig.cputype
@@ -45,9 +45,232 @@ config E200
 
 endchoice
 
-config POWER4_ONLY
-	bool "Optimize for POWER4"
+config PPC_CPU_SELECTION
+	bool "Advanced CPU selection"
+
+config CPU_DEFAULT
+	bool "Don't specify -mcpu= to gcc" if PPC_CPU_SELECTION
+
+config CPU_RS64
+	bool "RS64" if PPC_CPU_SELECTION
+	depends on PPC64
+	default y if PPC_PSERIES || PPC_ISERIES
+
+config CPU_POWER3
+	bool "IBM Power3" if PPC_CPU_SELECTION
+	depends on PPC64
+	default y if PPC_PSERIES || PPC_ISERIES
+
+config CPU_POWER4
+	bool "IBM Power4" if PPC_CPU_SELECTION
+	depends on PPC64
+	default y if PPC_PSERIES || PPC_ISERIES
+
+config CPU_POWER5
+	bool "IBM Power5" if PPC_CPU_SELECTION
+	depends on PPC64
+	default y if PPC_PSERIES
+
+config CPU_POWER6
+	bool "IBM Power6" if PPC_CPU_SELECTION
+	depends on PPC64
+	default y if PPC_PSERIES
+	select ALTIVEC
+
+config CPU_970
+	bool "IBM PowerPC 970 (G5)" if PPC_CPU_SELECTION
+	depends on PPC64
+	default y if PPC_PSERIES
+	select ALTIVEC
+
+config CPU_CELL
+	bool "Sony/Toshiba/IBM Cell Broadband Engine" if PPC_CPU_SELECTION
 	depends on PPC64
+	select ALTIVEC
+
+config CPU_PA6T
+	bool "PA Semi PA6T-1682M" if PPC_CPU_SELECTION
+	depends on PPC64
+	select ALTIVEC
+
+config CPU_601
+	bool "PowerPC 601 (G1)" if PPC_CPU_SELECTION
+	depends on 6xx
+	default y if PPC_CHRP || PPC_PREP
+
+config CPU_603e
+	bool "PowerPC 603e, 604, 604e, 52xx, 82xx, 83xx (G2)" if PPC_CPU_SELECTION
+	depends on 6xx
+	default y if PPC_CHRP || PPC_PREP || PPC_PMAC
+
+config CPU_7xx
+	bool "PowerPC 740/750 (G3)" if PPC_CPU_SELECTION
+	depends on 6xx
+	default y if PPC_PMAC
+
+config CPU_74xx
+	bool "PowerPC 74xx, 86xx (G4)" if PPC_CPU_SELECTION
+	depends on 6xx
+	default y if PPC_PMAC
+	select ALTIVEC
+
+config CPU_403
+	bool "AMCC 403" if PPC_CPU_SELECTION
+	depends on 40x
+
+config CPU_405
+	bool "AMCC 405" if PPC_CPU_SELECTION
+	depends on 40x
+
+config CPU_440
+	bool "AMCC 440" if PPC_CPU_SELECTION
+	depends on 44x
+
+choice
+	prompt "Tune for processor type" if PPC_CPU_SELECTION
+	default TUNE_POWER4 if PPC64
+	default TUNE_DEFAULT
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
+config TUNE_7xx
+	bool "PowerPC 740/750 (G3)"
+	depends on CPU_7xx
+
+config TUNE_74xx
+	bool "PowerPC 74xx, 86xx (G4)"
+	depends on CPU_74xx
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
+	bool "AMCC 403"
+	depends on CPU_403
+
+config TUNE_405
+	bool "AMCC 405"
+	depends on CPU_405
+
+config TUNE_440
+	bool "AMCC 440"
+	depends on CPU_440
+
+config TUNE_8540
+	bool "Freescale MPC8540"
+	depends on PPC_85xx
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
+	default "-mcpu=powerpc64" if CPU_POWER3 || CPU_RS64
+	default "-mcpu=power4" if (CPU_POWER5 || CPU_POWER6) && (CPU_970 || CPU_CELL || CPU_PA6T)
+	default "-mcpu=power4" if CPU_POWER4
+	default "-mcpu=power5" if CPU_POWER5
+	default "-mcpu=power6" if CPU_POWER6
+	default "-mcpu=970" if CPU_970
+	default "-mcpu=cell" if CPU_CELL
+	default "-mcpu=pa6t" if CPU_PA6T
+	default "-mcpu=powerpc64" if PPC64
+	default "-mcpu=powerpc" if CPU_601 && (CPU_603e || CPU_7xx || CPU_74xx)
+	default "-mcpu=601" if CPU_601
+	default "-mcpu=603e" if CPU_603e
+	default "-mcpu=750" if CPU_7xx
+	default "-mcpu=7450" if CPU_74xx
+	default "-mcpu=powerpc" if (CPU_403 && CPU_405)
+	default "-mcpu=powerpc" if (CPU_403 || CPU_405) && CPU_440
+	default "-mcpu=403" if CPU_403
+	default "-mcpu=405" if CPU_405
+	default "-mcpu=440" if CPU_440
+	default "-mcpu=860" if PPC_8xx
+	default "-mcpu=8540" if PPC_85xx
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
+	default "-mtune=750" if TUNE_7xx
+	default "-mtune=7450" if TUNE_74xx
+	default "-mtune=403" if TUNE_403
+	default "-mtune=405" if TUNE_405
+	default "-mtune=440" if TUNE_440
+	default "-mtune=821" if TUNE_821
+	default "-mtune=823" if TUNE_823
+	default "-mtune=860" if TUNE_860
+	default "-mtune=8540" if TUNE_8540
+	default "-mtune=e200" if TUNE_E200
+	default "-mtune=power4" if PPC64
+
+config POWER4_ONLY
+	def_bool y
+	depends on PPC64 && !CPU_POWER3 && !CPU_RS64
 	default n
 	---help---
 	  Cause the compiler to optimize for POWER4/POWER5/PPC970 processors.
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
@@ -1,5 +1,6 @@
 config EMBEDDED6xx
 	bool "Embedded 6xx"
+	depends on 6xx
 
 config LINKSTATION
 	bool "Linkstation / Kurobox(HG) from Buffalo"
@@ -9,6 +10,7 @@ config LINKSTATION
 	select FSL_SOC
 	select PPC_UDBG_16550 if SERIAL_8250
 	select DEFAULT_UIMAGE
+	select CPU_603e
 	help
 	  Select LINKSTATION if configuring for one of PPC- (MPC8241)
 	  based NAS systems from Buffalo Technology. So far only
@@ -23,6 +25,7 @@ config MPC7448HPC2
 	select TSI108_BRIDGE
 	select DEFAULT_UIMAGE
 	select PPC_UDBG_16550
+	select CPU_74xx
 	help
 	  Select MPC7448HPC2 if configuring for Freescale MPC7448HPC2 (Taiga)
 	  platform
@@ -32,6 +35,7 @@ config PPC_HOLLY
 	depends on EMBEDDED6xx
 	select TSI108_BRIDGE
 	select PPC_UDBG_16550
+	select CPU_7xx
 	help
 	  Select PPC_HOLLY if configuring for an IBM 750GX/CL Eval
 	  Board with TSI108/9 bridge (Hickory/Holly)
@@ -42,6 +46,7 @@ config PPC_PRPMC2800
 	select MV64X60
 	select NOT_COHERENT_CACHE
 	select WANT_DEVICE_TREE
+	select CPU_74xx
 	help
 	  This option enables support for the Motorola PrPMC2800 board
 
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
@@ -5,6 +5,7 @@ config PPC_PASEMI
 	select MPIC
 	select PPC_UDBG_16550
 	select PPC_NATIVE
+	select CPU_PA6T
 	help
 	  This option enables support for PA Semi's PWRficient line
 	  of SoC processors, including PA6T-1682M
Index: linux-2.6/arch/powerpc/platforms/powermac/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/powermac/Kconfig
+++ linux-2.6/arch/powerpc/platforms/powermac/Kconfig
@@ -15,6 +15,7 @@ config PPC_PMAC64
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
Index: linux-2.6/arch/powerpc/platforms/apus/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/apus/Kconfig
+++ linux-2.6/arch/powerpc/platforms/apus/Kconfig
@@ -1,6 +1,7 @@
 config APUS
 	bool "Amiga-APUS"
 	depends on PPC32 && BROKEN
+	select CPU_603e
 	help
 	  Select APUS if configuring for a PowerUP Amiga.
 	  More information is available at:

--
