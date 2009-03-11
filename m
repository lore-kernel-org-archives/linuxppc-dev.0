Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 11 Mar 2009 14:53:27 +1100
Subject: [PATCH 1/9] powerpc/kconfig: Kill PPC_MULTIPLATFORM
In-Reply-To: <1236743604.932194.842849421348.qpush@grosgo>
Message-Id: <20090311035330.DDF1FDE153@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

CONFIG_PPC_MULTIPLATFORM is a remain of the pre-powerpc days and isn't
really meaningful anymore. It was basically equivalent to PPC64 || 6xx.

This removes it along with the following changes:

 - 32-bit platforms that relied on PPC32 && PPC_MULTIPLATFORM now rely
   on 6xx which is what they want anyway.

 - A new symbol, PPC_BOOK3S, is defined that represent compliance with
   the "Server" variant of the architecture. This is set when either 6xx
   or PPC64 is set and open the door for future BOOK3E 64-bit.

 - 64-bit platforms that relied on PPC64 && PPC_MULTIPLATFORM now use
   PPC64 && PPC_BOOK3S

 - A separate and selectable CONFIG_PPC_OF_BOOT_TRAMPOLINE option is now
   used to control the use of prom_init.c

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/Kconfig                       |    2 +-
 arch/powerpc/Kconfig.debug                 |    2 +-
 arch/powerpc/kernel/Makefile               |    2 +-
 arch/powerpc/kernel/head_32.S              |    7 +++++--
 arch/powerpc/kernel/head_64.S              |    6 +++++-
 arch/powerpc/platforms/512x/Kconfig        |    4 ++--
 arch/powerpc/platforms/52xx/Kconfig        |    2 +-
 arch/powerpc/platforms/82xx/Kconfig        |    2 +-
 arch/powerpc/platforms/83xx/Kconfig        |    2 +-
 arch/powerpc/platforms/86xx/Kconfig        |    2 +-
 arch/powerpc/platforms/Kconfig             |   27 +++++++++++++++------------
 arch/powerpc/platforms/Kconfig.cputype     |   18 +++++++++++++-----
 arch/powerpc/platforms/amigaone/Kconfig    |    2 +-
 arch/powerpc/platforms/cell/Kconfig        |    6 +++---
 arch/powerpc/platforms/chrp/Kconfig        |    2 +-
 arch/powerpc/platforms/embedded6xx/Kconfig |    2 +-
 arch/powerpc/platforms/iseries/Kconfig     |    2 +-
 arch/powerpc/platforms/maple/Kconfig       |    2 +-
 arch/powerpc/platforms/pasemi/Kconfig      |    2 +-
 arch/powerpc/platforms/powermac/Kconfig    |    2 +-
 arch/powerpc/platforms/prep/Kconfig        |    2 +-
 arch/powerpc/platforms/ps3/Kconfig         |    2 +-
 arch/powerpc/platforms/pseries/Kconfig     |    2 +-
 23 files changed, 60 insertions(+), 42 deletions(-)

--- linux-work.orig/arch/powerpc/Kconfig	2009-02-24 15:04:13.000000000 +1100
+++ linux-work/arch/powerpc/Kconfig	2009-02-24 15:31:51.000000000 +1100
@@ -313,7 +313,7 @@ config ARCH_ENABLE_MEMORY_HOTREMOVE
 
 config KEXEC
 	bool "kexec system call (EXPERIMENTAL)"
-	depends on (PPC_PRPMC2800 || PPC_MULTIPLATFORM) && EXPERIMENTAL
+	depends on BOOK3S && EXPERIMENTAL
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
Index: linux-work/arch/powerpc/kernel/Makefile
===================================================================
--- linux-work.orig/arch/powerpc/kernel/Makefile	2009-02-24 15:05:49.000000000 +1100
+++ linux-work/arch/powerpc/kernel/Makefile	2009-02-24 15:12:20.000000000 +1100
@@ -75,7 +75,7 @@ obj-y				+= time.o prom.o traps.o setup-
 obj-$(CONFIG_PPC32)		+= entry_32.o setup_32.o
 obj-$(CONFIG_PPC64)		+= dma-iommu.o iommu.o
 obj-$(CONFIG_KGDB)		+= kgdb.o
-obj-$(CONFIG_PPC_MULTIPLATFORM)	+= prom_init.o
+obj-$(CONFIG_PPC_OF_BOOT_TRAMPOLINE)	+= prom_init.o
 obj-$(CONFIG_MODULES)		+= ppc_ksyms.o
 obj-$(CONFIG_BOOTX_TEXT)	+= btext.o
 obj-$(CONFIG_SMP)		+= smp.o
Index: linux-work/arch/powerpc/kernel/head_32.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/head_32.S	2009-02-24 15:12:55.000000000 +1100
+++ linux-work/arch/powerpc/kernel/head_32.S	2009-02-24 16:24:44.000000000 +1100
@@ -108,18 +108,21 @@ __start:
  * because OF may have I/O devices mapped into that area
  * (particularly on CHRP).
  */
-#ifdef CONFIG_PPC_MULTIPLATFORM
 	cmpwi	0,r5,0
 	beq	1f
 
+#ifdef CONFIG_PPC_OF_BOOT_TRAMPOLINE
 	/* find out where we are now */
 	bcl	20,31,$+4
 0:	mflr	r8			/* r8 = runtime addr here */
 	addis	r8,r8,(_stext - 0b)@ha
 	addi	r8,r8,(_stext - 0b)@l	/* current runtime base addr */
 	bl	prom_init
+#endif /* CONFIG_PPC_OF_BOOT_TRAMPOLINE */
+
+	/* We never return. We also hit that trap if trying to boot
+	 * from OF while CONFIG_PPC_OF_BOOT_TRAMPOLINE isn't selected */
 	trap
-#endif
 
 /*
  * Check for BootX signature when supporting PowerMac and branch to
Index: linux-work/arch/powerpc/platforms/Kconfig
===================================================================
--- linux-work.orig/arch/powerpc/platforms/Kconfig	2009-02-24 15:02:47.000000000 +1100
+++ linux-work/arch/powerpc/platforms/Kconfig	2009-02-24 15:35:02.000000000 +1100
@@ -1,14 +1,5 @@
 menu "Platform support"
 
-config PPC_MULTIPLATFORM
-	bool
-	depends on PPC64 || 6xx
-	default y
-
-config CLASSIC32
-	def_bool y
-	depends on 6xx && PPC_MULTIPLATFORM
-
 source "arch/powerpc/platforms/pseries/Kconfig"
 source "arch/powerpc/platforms/iseries/Kconfig"
 source "arch/powerpc/platforms/chrp/Kconfig"
@@ -32,12 +23,24 @@ source "arch/powerpc/platforms/amigaone/
 
 config PPC_NATIVE
 	bool
-	depends on PPC_MULTIPLATFORM
+	depends on 6xx || PPC64
 	help
 	  Support for running natively on the hardware, i.e. without
 	  a hypervisor. This option is not user-selectable but should
 	  be selected by all platforms that need it.
 
+config PPC_OF_BOOT_TRAMPOLINE
+	bool "Support booting from Open Firmware or yaboot"
+	depends on 6xx || PPC64
+	default y
+	help
+	  Support from booting from Open Firmware or yaboot using an
+	  Open Firmware client interface. This enables the kernel to
+	  communicate with open firmware to retrieve system informations
+	  such as the device tree.
+
+	  In case of doubt, say Y
+
 config UDBG_RTAS_CONSOLE
 	bool "RTAS based debug console"
 	depends on PPC_RTAS
@@ -71,7 +74,7 @@ config PPC_I8259
 
 config U3_DART
 	bool
-	depends on PPC_MULTIPLATFORM && PPC64
+	depends on PPC64
 	default n
 
 config PPC_RTAS
@@ -188,7 +191,7 @@ config PPC601_SYNC_FIX
 
 config TAU
 	bool "On-chip CPU temperature sensor support"
-	depends on CLASSIC32
+	depends on 6xx
 	help
 	  G3 and G4 processors have an on-chip temperature sensor called the
 	  'Thermal Assist Unit (TAU)', which, in theory, can measure the on-die
Index: linux-work/arch/powerpc/platforms/512x/Kconfig
===================================================================
--- linux-work.orig/arch/powerpc/platforms/512x/Kconfig	2009-02-24 15:13:42.000000000 +1100
+++ linux-work/arch/powerpc/platforms/512x/Kconfig	2009-02-24 15:14:02.000000000 +1100
@@ -12,7 +12,7 @@ config PPC_MPC5121
 
 config MPC5121_ADS
 	bool "Freescale MPC5121E ADS"
-	depends on PPC_MULTIPLATFORM && PPC32
+	depends on 6xx
 	select DEFAULT_UIMAGE
 	select PPC_MPC5121
 	select MPC5121_ADS_CPLD
@@ -21,7 +21,7 @@ config MPC5121_ADS
 
 config MPC5121_GENERIC
 	bool "Generic support for simple MPC5121 based boards"
-	depends on PPC_MULTIPLATFORM && PPC32
+	depends on 6xx
 	select DEFAULT_UIMAGE
 	select PPC_MPC5121
 	help
Index: linux-work/arch/powerpc/platforms/52xx/Kconfig
===================================================================
--- linux-work.orig/arch/powerpc/platforms/52xx/Kconfig	2009-02-24 15:14:15.000000000 +1100
+++ linux-work/arch/powerpc/platforms/52xx/Kconfig	2009-02-24 15:14:18.000000000 +1100
@@ -1,6 +1,6 @@
 config PPC_MPC52xx
 	bool "52xx-based boards"
-	depends on PPC_MULTIPLATFORM && PPC32
+	depends on 6xx
 	select PPC_CLOCK
 	select PPC_PCI_CHOICE
 
Index: linux-work/arch/powerpc/platforms/82xx/Kconfig
===================================================================
--- linux-work.orig/arch/powerpc/platforms/82xx/Kconfig	2009-02-24 15:14:27.000000000 +1100
+++ linux-work/arch/powerpc/platforms/82xx/Kconfig	2009-02-24 15:14:32.000000000 +1100
@@ -1,6 +1,6 @@
 menuconfig PPC_82xx
 	bool "82xx-based boards (PQ II)"
-	depends on 6xx && PPC_MULTIPLATFORM
+	depends on 6xx
 
 if PPC_82xx
 
Index: linux-work/arch/powerpc/platforms/83xx/Kconfig
===================================================================
--- linux-work.orig/arch/powerpc/platforms/83xx/Kconfig	2009-02-24 15:14:38.000000000 +1100
+++ linux-work/arch/powerpc/platforms/83xx/Kconfig	2009-02-24 15:14:43.000000000 +1100
@@ -1,6 +1,6 @@
 menuconfig PPC_83xx
 	bool "83xx-based boards"
-	depends on 6xx && PPC_MULTIPLATFORM
+	depends on 6xx
 	select PPC_UDBG_16550
 	select PPC_PCI_CHOICE
 	select FSL_PCI if PCI
Index: linux-work/arch/powerpc/platforms/86xx/Kconfig
===================================================================
--- linux-work.orig/arch/powerpc/platforms/86xx/Kconfig	2009-02-24 15:14:52.000000000 +1100
+++ linux-work/arch/powerpc/platforms/86xx/Kconfig	2009-02-24 15:14:58.000000000 +1100
@@ -1,7 +1,7 @@
 config PPC_86xx
 menuconfig PPC_86xx
 	bool "86xx-based boards"
-	depends on 6xx && PPC_MULTIPLATFORM
+	depends on 6xx
 	select FSL_SOC
 	select ALTIVEC
 	help
Index: linux-work/arch/powerpc/platforms/Kconfig.cputype
===================================================================
--- linux-work.orig/arch/powerpc/platforms/Kconfig.cputype	2009-02-24 15:22:46.000000000 +1100
+++ linux-work/arch/powerpc/platforms/Kconfig.cputype	2009-02-24 15:35:09.000000000 +1100
@@ -57,9 +57,17 @@ config E200
 
 endchoice
 
+# Until we have a choice of exclusive CPU types on 64-bit, we always
+# use PPC_BOOK3S. On 32-bit, this is equivalent to 6xx which is
+# "classic" MMU
+
+config PPC_BOOK3S
+       def_bool y
+       depends on PPC64 || 6xx
+
 config POWER4_ONLY
 	bool "Optimize for POWER4"
-	depends on PPC64
+	depends on PPC64 && PPC_BOOK3S
 	default n
 	---help---
 	  Cause the compiler to optimize for POWER4/POWER5/PPC970 processors.
@@ -68,16 +76,16 @@ config POWER4_ONLY
 
 config POWER3
 	bool
-	depends on PPC64
+	depends on PPC64 && PPC_BOOK3S
 	default y if !POWER4_ONLY
 
 config POWER4
-	depends on PPC64
+	depends on PPC64 && PPC_BOOK3S
 	def_bool y
 
 config TUNE_CELL
 	bool "Optimize for Cell Broadband Engine"
-	depends on PPC64
+	depends on PPC64 && PPC_BOOK3S
 	help
 	  Cause the compiler to optimize for the PPE of the Cell Broadband
 	  Engine. This will make the code run considerably faster on Cell
@@ -147,7 +155,7 @@ config PHYS_64BIT
 
 config ALTIVEC
 	bool "AltiVec Support"
-	depends on CLASSIC32 || POWER4
+	depends on 6xx || POWER4
 	---help---
 	  This option enables kernel support for the Altivec extensions to the
 	  PowerPC processor. The kernel currently supports saving and restoring
Index: linux-work/arch/powerpc/platforms/amigaone/Kconfig
===================================================================
--- linux-work.orig/arch/powerpc/platforms/amigaone/Kconfig	2009-02-24 15:27:56.000000000 +1100
+++ linux-work/arch/powerpc/platforms/amigaone/Kconfig	2009-02-24 15:28:08.000000000 +1100
@@ -1,6 +1,6 @@
 config AMIGAONE
 	bool "Eyetech AmigaOne/MAI Teron"
-	depends on PPC32 && BROKEN_ON_SMP && PPC_MULTIPLATFORM
+	depends on 6xx && BROKEN_ON_SMP
 	select PPC_I8259
 	select PPC_INDIRECT_PCI
 	select PPC_UDBG_16550
Index: linux-work/arch/powerpc/platforms/cell/Kconfig
===================================================================
--- linux-work.orig/arch/powerpc/platforms/cell/Kconfig	2009-02-24 15:15:08.000000000 +1100
+++ linux-work/arch/powerpc/platforms/cell/Kconfig	2009-02-24 15:25:15.000000000 +1100
@@ -23,7 +23,7 @@ config PPC_CELL_NATIVE
 
 config PPC_IBM_CELL_BLADE
 	bool "IBM Cell Blade"
-	depends on PPC_MULTIPLATFORM && PPC64
+	depends on PPC64 && PPC_BOOK3S
 	select PPC_CELL_NATIVE
 	select MMIO_NVRAM
 	select PPC_UDBG_16550
@@ -31,7 +31,7 @@ config PPC_IBM_CELL_BLADE
 
 config PPC_CELLEB
 	bool "Toshiba's Cell Reference Set 'Celleb' Architecture"
-	depends on PPC_MULTIPLATFORM && PPC64
+	depends on PPC64 && PPC_BOOK3S
 	select PPC_CELL_NATIVE
 	select HAS_TXX9_SERIAL
 	select PPC_UDBG_BEAT
@@ -40,7 +40,7 @@ config PPC_CELLEB
 
 config PPC_CELL_QPACE
 	bool "IBM Cell - QPACE"
-	depends on PPC_MULTIPLATFORM && PPC64
+	depends on PPC64 && PPC_BOOK3S
 	select PPC_CELL_COMMON
 
 menu "Cell Broadband Engine options"
Index: linux-work/arch/powerpc/platforms/chrp/Kconfig
===================================================================
--- linux-work.orig/arch/powerpc/platforms/chrp/Kconfig	2009-02-24 15:15:31.000000000 +1100
+++ linux-work/arch/powerpc/platforms/chrp/Kconfig	2009-02-24 15:15:44.000000000 +1100
@@ -1,6 +1,6 @@
 config PPC_CHRP
 	bool "Common Hardware Reference Platform (CHRP) based machines"
-	depends on PPC_MULTIPLATFORM && PPC32
+	depends on 6xx
 	select MPIC
 	select PPC_I8259
 	select PPC_INDIRECT_PCI
Index: linux-work/arch/powerpc/platforms/embedded6xx/Kconfig
===================================================================
--- linux-work.orig/arch/powerpc/platforms/embedded6xx/Kconfig	2009-02-24 15:15:58.000000000 +1100
+++ linux-work/arch/powerpc/platforms/embedded6xx/Kconfig	2009-02-24 15:16:21.000000000 +1100
@@ -1,6 +1,6 @@
 config EMBEDDED6xx
 	bool "Embedded 6xx/7xx/7xxx-based boards"
-	depends on PPC32 && BROKEN_ON_SMP && PPC_MULTIPLATFORM
+	depends on 6xx && BROKEN_ON_SMP
 
 config LINKSTATION
 	bool "Linkstation / Kurobox(HG) from Buffalo"
Index: linux-work/arch/powerpc/platforms/iseries/Kconfig
===================================================================
--- linux-work.orig/arch/powerpc/platforms/iseries/Kconfig	2009-02-24 15:21:42.000000000 +1100
+++ linux-work/arch/powerpc/platforms/iseries/Kconfig	2009-02-24 15:25:35.000000000 +1100
@@ -1,6 +1,6 @@
 config PPC_ISERIES
 	bool "IBM Legacy iSeries"
-	depends on PPC_MULTIPLATFORM && PPC64
+	depends on PPC64 && PPC_BOOK3S
 	select PPC_INDIRECT_IO
 	select PPC_PCI_CHOICE if EMBEDDED
 
Index: linux-work/arch/powerpc/platforms/maple/Kconfig
===================================================================
--- linux-work.orig/arch/powerpc/platforms/maple/Kconfig	2009-02-24 15:22:00.000000000 +1100
+++ linux-work/arch/powerpc/platforms/maple/Kconfig	2009-02-24 15:25:41.000000000 +1100
@@ -1,5 +1,5 @@
 config PPC_MAPLE
-	depends on PPC_MULTIPLATFORM && PPC64
+	depends on PPC64 && PPC_BOOK3S
 	bool "Maple 970FX Evaluation Board"
 	select PCI
 	select MPIC
Index: linux-work/arch/powerpc/platforms/pasemi/Kconfig
===================================================================
--- linux-work.orig/arch/powerpc/platforms/pasemi/Kconfig	2009-02-24 15:22:18.000000000 +1100
+++ linux-work/arch/powerpc/platforms/pasemi/Kconfig	2009-02-24 15:25:50.000000000 +1100
@@ -1,5 +1,5 @@
 config PPC_PASEMI
-	depends on PPC_MULTIPLATFORM && PPC64
+	depends on PPC64 && PPC_BOOK3S
 	bool "PA Semi SoC-based platforms"
 	default n
 	select MPIC
Index: linux-work/arch/powerpc/platforms/powermac/Kconfig
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/Kconfig	2009-02-24 15:26:00.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/Kconfig	2009-02-24 15:26:11.000000000 +1100
@@ -1,6 +1,6 @@
 config PPC_PMAC
 	bool "Apple PowerMac based machines"
-	depends on PPC_MULTIPLATFORM
+	depends on PPC_BOOK3S
 	select MPIC
 	select PCI
 	select PPC_INDIRECT_PCI if PPC32
Index: linux-work/arch/powerpc/platforms/prep/Kconfig
===================================================================
--- linux-work.orig/arch/powerpc/platforms/prep/Kconfig	2009-02-24 15:26:55.000000000 +1100
+++ linux-work/arch/powerpc/platforms/prep/Kconfig	2009-02-24 15:27:04.000000000 +1100
@@ -1,6 +1,6 @@
 config PPC_PREP
 	bool "PowerPC Reference Platform (PReP) based machines"
-	depends on PPC_MULTIPLATFORM && PPC32 && BROKEN
+	depends on 6xx && BROKEN
 	select MPIC
 	select PPC_I8259
 	select PPC_INDIRECT_PCI
Index: linux-work/arch/powerpc/platforms/ps3/Kconfig
===================================================================
--- linux-work.orig/arch/powerpc/platforms/ps3/Kconfig	2009-02-24 15:27:20.000000000 +1100
+++ linux-work/arch/powerpc/platforms/ps3/Kconfig	2009-02-24 15:27:31.000000000 +1100
@@ -1,6 +1,6 @@
 config PPC_PS3
 	bool "Sony PS3"
-	depends on PPC_MULTIPLATFORM && PPC64
+	depends on PPC64 && PPC_BOOK3S
 	select PPC_CELL
 	select USB_ARCH_HAS_OHCI
 	select USB_OHCI_LITTLE_ENDIAN
Index: linux-work/arch/powerpc/platforms/pseries/Kconfig
===================================================================
--- linux-work.orig/arch/powerpc/platforms/pseries/Kconfig	2009-02-24 15:27:36.000000000 +1100
+++ linux-work/arch/powerpc/platforms/pseries/Kconfig	2009-02-24 15:27:47.000000000 +1100
@@ -1,5 +1,5 @@
 config PPC_PSERIES
-	depends on PPC_MULTIPLATFORM && PPC64
+	depends on PPC64 && PPC_BOOK3S
 	bool "IBM pSeries & new (POWER5-based) iSeries"
 	select MPIC
 	select PPC_I8259
Index: linux-work/arch/powerpc/Kconfig.debug
===================================================================
--- linux-work.orig/arch/powerpc/Kconfig.debug	2009-02-24 15:30:26.000000000 +1100
+++ linux-work/arch/powerpc/Kconfig.debug	2009-02-24 15:31:01.000000000 +1100
@@ -129,7 +129,7 @@ config BDI_SWITCH
 
 config BOOTX_TEXT
 	bool "Support for early boot text console (BootX or OpenFirmware only)"
-	depends on PPC_OF && PPC_MULTIPLATFORM
+	depends on PPC_OF && PPC_BOOK3S
 	help
 	  Say Y here to see progress messages from the boot firmware in text
 	  mode. Requires either BootX or Open Firmware.
Index: linux-work/arch/powerpc/kernel/head_64.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/head_64.S	2009-02-24 16:23:30.000000000 +1100
+++ linux-work/arch/powerpc/kernel/head_64.S	2009-02-24 16:25:07.000000000 +1100
@@ -1360,6 +1360,7 @@ _GLOBAL(__start_initialization_multiplat
 	b	.__after_prom_start
 
 _INIT_STATIC(__boot_from_prom)
+#ifdef CONFIG_PPC_OF_BOOT_TRAMPOLINE
 	/* Save parameters */
 	mr	r31,r3
 	mr	r30,r4
@@ -1390,7 +1391,10 @@ _INIT_STATIC(__boot_from_prom)
 	/* Do all of the interaction with OF client interface */
 	mr	r8,r26
 	bl	.prom_init
-	/* We never return */
+#endif /* #CONFIG_PPC_OF_BOOT_TRAMPOLINE */
+
+	/* We never return. We also hit that trap if trying to boot
+	 * from OF while CONFIG_PPC_OF_BOOT_TRAMPOLINE isn't selected */
 	trap
 
 _STATIC(__after_prom_start)
