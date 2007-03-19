Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 49303DDF4D
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 06:29:53 +1100 (EST)
Date: Mon, 19 Mar 2007 14:26:27 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'ppc_kconfig' branch for 2.6.22
Message-ID: <Pine.LNX.4.64.0703191424480.14888@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please pull from 'ppc_kconfig' branch of
master.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git

No on seems to have any issues with this set of changes, and I'd like to
get it in your 2.6.22 tree ASAP since we are moving things around.

to receive the following updates:

 arch/powerpc/Kconfig                       |  385 -----------------------------
 arch/powerpc/Kconfig.debug                 |    3
 arch/powerpc/platforms/52xx/Kconfig        |   35 ++
 arch/powerpc/platforms/82xx/Kconfig        |   35 ++
 arch/powerpc/platforms/Kconfig             |  219 ++++++++++++++++
 arch/powerpc/platforms/cell/Kconfig        |   23 +
 arch/powerpc/platforms/celleb/Kconfig      |    9
 arch/powerpc/platforms/chrp/Kconfig        |   11
 arch/powerpc/platforms/embedded6xx/Kconfig |  264 -------------------
 arch/powerpc/platforms/iseries/Kconfig     |    4
 arch/powerpc/platforms/maple/Kconfig       |   17 +
 arch/powerpc/platforms/pasemi/Kconfig      |   12
 arch/powerpc/platforms/powermac/Kconfig    |   20 +
 arch/powerpc/platforms/prep/Kconfig        |    9
 arch/powerpc/platforms/ps3/Kconfig         |   16 +
 arch/powerpc/platforms/pseries/Kconfig     |   10
 16 files changed, 424 insertions(+), 648 deletions(-)

Kumar Gala (6):
      [POWERPC] Split 52xx platforms into their own Kconfig file
      [POWERPC] Split powermac platforms into their own Kconfig file
      [POWERPC] Split cell platforms into their respective Kconfig file
      [POWERPC] Removed config options that we don't support in embedded6xx
      [POWERPC] Split several platforms into their respective Kconfig file
      [POWERPC] Created arch/powerpc/platforms/Kconfig for "Platform support"

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index e720527..20aae16 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -367,383 +367,7 @@ endmenu

 source "init/Kconfig"

-menu "Platform support"
-	depends on PPC64 || CLASSIC32
-
-choice
-	prompt "Machine type"
-	default PPC_MULTIPLATFORM
-
-config PPC_MULTIPLATFORM
-	bool "Generic desktop/server/laptop"
-	help
-	  Select this option if configuring for an IBM pSeries or
-	  RS/6000 machine, an Apple machine, or a PReP, CHRP,
-	  Maple or Cell-based machine.
-
-config EMBEDDED6xx
-	bool "Embedded 6xx/7xx/7xxx-based board"
-	depends on PPC32 && (BROKEN||BROKEN_ON_SMP)
-
-config APUS
-	bool "Amiga-APUS"
-	depends on PPC32 && BROKEN
-	help
-	  Select APUS if configuring for a PowerUP Amiga.
-	  More information is available at:
-	  <http://linux-apus.sourceforge.net/>.
-endchoice
-
-config QUICC_ENGINE
-	bool
-	depends on PPC_MPC836x || PPC_MPC832x
-	default y
-	help
-	  The QUICC Engine (QE) is a new generation of communications
-	  coprocessors on Freescale embedded CPUs (akin to CPM in older chips).
-	  Selecting this option means that you wish to build a kernel
-	  for a machine with a QE coprocessor.
-
-config PPC_PSERIES
-	depends on PPC_MULTIPLATFORM && PPC64
-	bool "IBM pSeries & new (POWER5-based) iSeries"
-	select MPIC
-	select PPC_I8259
-	select PPC_RTAS
-	select RTAS_ERROR_LOGGING
-	select PPC_UDBG_16550
-	select PPC_NATIVE
-	default y
-
-config PPC_ISERIES
-	bool "IBM Legacy iSeries"
-	depends on PPC_MULTIPLATFORM && PPC64
-	select PPC_INDIRECT_IO
-
-config PPC_CHRP
-	bool "Common Hardware Reference Platform (CHRP) based machines"
-	depends on PPC_MULTIPLATFORM && PPC32
-	select MPIC
-	select PPC_I8259
-	select PPC_INDIRECT_PCI
-	select PPC_RTAS
-	select PPC_MPC106
-	select PPC_UDBG_16550
-	select PPC_NATIVE
-	default y
-
-config PPC_MPC52xx
-	bool
-	default n
-
-config PPC_MPC5200
-	bool
-	select PPC_MPC52xx
-	default n
-
-config PPC_MPC5200_BUGFIX
-	bool "MPC5200 (L25R) bugfix support"
-	depends on PPC_MPC5200
-	default n
-	help
-	  Enable workarounds for original MPC5200 errata.  This is not required
-	  for MPC5200B based boards.
-
-	  It is safe to say 'Y' here
-
-config PPC_EFIKA
-	bool "bPlan Efika 5k2. MPC5200B based computer"
-	depends on PPC_MULTIPLATFORM && PPC32
-	select PPC_RTAS
-	select RTAS_PROC
-	select PPC_MPC52xx
-	select PPC_NATIVE
-	default n
-
-config PPC_LITE5200
-	bool "Freescale Lite5200 Eval Board"
-	depends on PPC_MULTIPLATFORM && PPC32
-	select PPC_MPC5200
-	default n
-
-config PPC_PMAC
-	bool "Apple PowerMac based machines"
-	depends on PPC_MULTIPLATFORM
-	select MPIC
-	select PPC_INDIRECT_PCI if PPC32
-	select PPC_MPC106 if PPC32
-	select PPC_NATIVE
-	default y
-
-config PPC_PMAC64
-	bool
-	depends on PPC_PMAC && POWER4
-	select MPIC
-	select U3_DART
-	select MPIC_BROKEN_U3
-	select GENERIC_TBSYNC
-	select PPC_970_NAP
-	default y
-
-config PPC_PREP
-	bool "PowerPC Reference Platform (PReP) based machines"
-	depends on PPC_MULTIPLATFORM && PPC32 && BROKEN
-	select MPIC
-	select PPC_I8259
-	select PPC_INDIRECT_PCI
-	select PPC_UDBG_16550
-	select PPC_NATIVE
-	default n
-
-config PPC_MAPLE
-	depends on PPC_MULTIPLATFORM && PPC64
-	bool "Maple 970FX Evaluation Board"
-	select MPIC
-	select U3_DART
-	select MPIC_BROKEN_U3
-	select GENERIC_TBSYNC
-	select PPC_UDBG_16550
-	select PPC_970_NAP
-	select PPC_NATIVE
-	select PPC_RTAS
-	select MMIO_NVRAM
-	select ATA_NONSTANDARD if ATA
-	default n
-	help
-          This option enables support for the Maple 970FX Evaluation Board.
-	  For more information, refer to <http://www.970eval.com>
-
-config PPC_PASEMI
-	depends on PPC_MULTIPLATFORM && PPC64
-	bool "PA Semi SoC-based platforms"
-	default n
-	select MPIC
-	select PPC_UDBG_16550
-	select GENERIC_TBSYNC
-	select PPC_NATIVE
-	help
-	  This option enables support for PA Semi's PWRficient line
-	  of SoC processors, including PA6T-1682M
-
-config PPC_CELL
-	bool
-	default n
-
-config PPC_CELL_NATIVE
-	bool
-	select PPC_CELL
-	select PPC_DCR_MMIO
-	select PPC_OF_PLATFORM_PCI
-	select PPC_INDIRECT_IO
-	select PPC_NATIVE
-	select MPIC
-	default n
-
-config PPC_IBM_CELL_BLADE
-	bool "IBM Cell Blade"
-	depends on PPC_MULTIPLATFORM && PPC64
-	select PPC_CELL_NATIVE
-	select PPC_RTAS
-	select MMIO_NVRAM
-	select PPC_UDBG_16550
-	select UDBG_RTAS_CONSOLE
-
-config PPC_PS3
-	bool "Sony PS3 (incomplete)"
-	depends on PPC_MULTIPLATFORM && PPC64
-	select PPC_CELL
-	select USB_ARCH_HAS_OHCI
-	select USB_OHCI_LITTLE_ENDIAN
-	select USB_OHCI_BIG_ENDIAN_MMIO
-	select USB_ARCH_HAS_EHCI
-	select USB_EHCI_BIG_ENDIAN_MMIO
-	help
-	  This option enables support for the Sony PS3 game console
-	  and other platforms using the PS3 hypervisor.
-	  Support for this platform is not yet complete, so
-	  enabling this will not result in a bootable kernel on a
-	  PS3 system.
-
-config PPC_CELLEB
-	bool "Toshiba's Cell Reference Set 'Celleb' Architecture"
-	depends on PPC_MULTIPLATFORM && PPC64
-	select PPC_CELL
-	select PPC_OF_PLATFORM_PCI
-	select HAS_TXX9_SERIAL
-	select PPC_UDBG_BEAT
-	select USB_OHCI_BIG_ENDIAN_MMIO
-	select USB_EHCI_BIG_ENDIAN_MMIO
-
-config PPC_NATIVE
-	bool
-	depends on PPC_MULTIPLATFORM
-	help
-	  Support for running natively on the hardware, i.e. without
-	  a hypervisor. This option is not user-selectable but should
-	  be selected by all platforms that need it.
-
-config UDBG_RTAS_CONSOLE
-	bool "RTAS based debug console"
-	depends on PPC_RTAS
-	default n
-
-config PPC_UDBG_BEAT
-	bool "BEAT based debug console"
-	depends on PPC_CELLEB
-	default n
-
-config XICS
-	depends on PPC_PSERIES
-	bool
-	default y
-
-config U3_DART
-	bool
-	depends on PPC_MULTIPLATFORM && PPC64
-	default n
-
-config PPC_RTAS
-	bool
-	default n
-
-config RTAS_ERROR_LOGGING
-	bool
-	depends on PPC_RTAS
-	default n
-
-config RTAS_PROC
-	bool "Proc interface to RTAS"
-	depends on PPC_RTAS
-	default y
-
-config RTAS_FLASH
-	tristate "Firmware flash interface"
-	depends on PPC64 && RTAS_PROC
-
-config PPC_PMI
-	tristate "Support for PMI"
-	depends PPC_IBM_CELL_BLADE
-	help
-	  PMI (Platform Management Interrupt) is a way to
-	  communicate with the BMC (Baseboard Mangement Controller).
-	  It is used in some IBM Cell blades.
-	default m
-
-config MMIO_NVRAM
-	bool
-	default n
-
-config MPIC_BROKEN_U3
-	bool
-	depends on PPC_MAPLE
-	default y
-
-config IBMVIO
-	depends on PPC_PSERIES || PPC_ISERIES
-	bool
-	default y
-
-config IBMEBUS
-	depends on PPC_PSERIES
-	bool "Support for GX bus based adapters"
-	help
-	  Bus device driver for GX bus based adapters.
-
-config PPC_MPC106
-	bool
-	default n
-
-config PPC_970_NAP
-	bool
-	default n
-
-config PPC_INDIRECT_IO
-	bool
-	select GENERIC_IOMAP
-	default n
-
-config GENERIC_IOMAP
-	bool
-	default n
-
-source "drivers/cpufreq/Kconfig"
-
-config CPU_FREQ_PMAC
-	bool "Support for Apple PowerBooks"
-	depends on CPU_FREQ && ADB_PMU && PPC32
-	select CPU_FREQ_TABLE
-	help
-	  This adds support for frequency switching on Apple PowerBooks,
-	  this currently includes some models of iBook & Titanium
-	  PowerBook.
-
-config CPU_FREQ_PMAC64
-	bool "Support for some Apple G5s"
-	depends on CPU_FREQ && PPC64
-	select CPU_FREQ_TABLE
-	help
-	  This adds support for frequency switching on Apple iMac G5,
-	  and some of the more recent desktop G5 machines as well.
-
-config PPC601_SYNC_FIX
-	bool "Workarounds for PPC601 bugs"
-	depends on 6xx && (PPC_PREP || PPC_PMAC)
-	help
-	  Some versions of the PPC601 (the first PowerPC chip) have bugs which
-	  mean that extra synchronization instructions are required near
-	  certain instructions, typically those that make major changes to the
-	  CPU state.  These extra instructions reduce performance slightly.
-	  If you say N here, these extra instructions will not be included,
-	  resulting in a kernel which will run faster but may not run at all
-	  on some systems with the PPC601 chip.
-
-	  If in doubt, say Y here.
-
-config TAU
-	bool "On-chip CPU temperature sensor support"
-	depends on 6xx
-	help
-	  G3 and G4 processors have an on-chip temperature sensor called the
-	  'Thermal Assist Unit (TAU)', which, in theory, can measure the on-die
-	  temperature within 2-4 degrees Celsius. This option shows the current
-	  on-die temperature in /proc/cpuinfo if the cpu supports it.
-
-	  Unfortunately, on some chip revisions, this sensor is very inaccurate
-	  and in many cases, does not work at all, so don't assume the cpu
-	  temp is actually what /proc/cpuinfo says it is.
-
-config TAU_INT
-	bool "Interrupt driven TAU driver (DANGEROUS)"
-	depends on TAU
-	---help---
-	  The TAU supports an interrupt driven mode which causes an interrupt
-	  whenever the temperature goes out of range. This is the fastest way
-	  to get notified the temp has exceeded a range. With this option off,
-	  a timer is used to re-check the temperature periodically.
-
-	  However, on some cpus it appears that the TAU interrupt hardware
-	  is buggy and can cause a situation which would lead unexplained hard
-	  lockups.
-
-	  Unless you are extending the TAU driver, or enjoy kernel/hardware
-	  debugging, leave this option off.
-
-config TAU_AVERAGE
-	bool "Average high and low temp"
-	depends on TAU
-	---help---
-	  The TAU hardware can compare the temperature to an upper and lower
-	  bound.  The default behavior is to show both the upper and lower
-	  bound in /proc/cpuinfo. If the range is large, the temperature is
-	  either changing a lot, or the TAU hardware is broken (likely on some
-	  G4's). If the range is small (around 4 degrees), the temperature is
-	  relatively stable.  If you say Y here, a single temperature value,
-	  halfway between the upper and lower bounds, will be reported in
-	  /proc/cpuinfo.
-
-	  If in doubt, say N here.
-
-endmenu
+source "arch/powerpc/platforms/Kconfig"

 source arch/powerpc/platforms/embedded6xx/Kconfig
 source arch/powerpc/platforms/4xx/Kconfig
@@ -752,9 +376,6 @@ source arch/powerpc/platforms/83xx/Kconfig
 source arch/powerpc/platforms/85xx/Kconfig
 source arch/powerpc/platforms/86xx/Kconfig
 source arch/powerpc/platforms/8xx/Kconfig
-source arch/powerpc/platforms/cell/Kconfig
-source arch/powerpc/platforms/ps3/Kconfig
-source arch/powerpc/platforms/pasemi/Kconfig

 menu "Kernel options"

@@ -859,7 +480,6 @@ config IRQ_ALL_CPUS
 	  CPU.  Generally saying Y is safe, although some problems have been
 	  reported with SMP Power Macintoshes with this option enabled.

-source "arch/powerpc/platforms/pseries/Kconfig"

 config NUMA
 	bool "NUMA support"
@@ -931,8 +551,6 @@ config PROC_DEVICETREE
 	  an image of the device tree that the kernel copies from Open
 	  Firmware or other boot firmware. If unsure, say Y here.

-source "arch/powerpc/platforms/prep/Kconfig"
-
 config CMDLINE_BOOL
 	bool "Default bootloader kernel arguments"

@@ -1229,7 +847,6 @@ source "fs/Kconfig"

 source "arch/powerpc/sysdev/qe_lib/Kconfig"

-source "arch/powerpc/platforms/iseries/Kconfig"

 source "lib/Kconfig"

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index d39d133..50f48f0 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -132,8 +132,7 @@ config BOOTX_TEXT

 config SERIAL_TEXT_DEBUG
 	bool "Support for early boot texts over serial port"
-	depends on 4xx || LOPEC || MV64X60 || PPLUS || PRPMC800 || \
-		PPC_GEN550 || PPC_MPC52xx
+	depends on 4xx

 config PPC_EARLY_DEBUG
 	bool "Early debugging (dangerous)"
diff --git a/arch/powerpc/platforms/52xx/Kconfig b/arch/powerpc/platforms/52xx/Kconfig
new file mode 100644
index 0000000..bc4aa4a
--- /dev/null
+++ b/arch/powerpc/platforms/52xx/Kconfig
@@ -0,0 +1,35 @@
+config PPC_MPC52xx
+	bool
+	default n
+
+config PPC_MPC5200
+	bool
+	select PPC_MPC52xx
+	default n
+
+config PPC_MPC5200_BUGFIX
+	bool "MPC5200 (L25R) bugfix support"
+	depends on PPC_MPC5200
+	default n
+	help
+	  Enable workarounds for original MPC5200 errata.  This is not required
+	  for MPC5200B based boards.
+
+	  It is safe to say 'Y' here
+
+config PPC_EFIKA
+	bool "bPlan Efika 5k2. MPC5200B based computer"
+	depends on PPC_MULTIPLATFORM && PPC32
+	select PPC_RTAS
+	select RTAS_PROC
+	select PPC_MPC52xx
+	select PPC_NATIVE
+	default n
+
+config PPC_LITE5200
+	bool "Freescale Lite5200 Eval Board"
+	depends on PPC_MULTIPLATFORM && PPC32
+	select PPC_MPC5200
+	default n
+
+
diff --git a/arch/powerpc/platforms/82xx/Kconfig b/arch/powerpc/platforms/82xx/Kconfig
index 47d841e..4110716 100644
--- a/arch/powerpc/platforms/82xx/Kconfig
+++ b/arch/powerpc/platforms/82xx/Kconfig
@@ -18,4 +18,39 @@ config MPC82xx_ADS

 endchoice

+config PQ2ADS
+	bool
+	depends on ADS8272
+	default y
+
+config ADS8272
+	bool
+
+config 8260
+	bool "CPM2 Support" if WILLOW
+	depends on 6xx
+	default y if PQ2FADS
+	help
+	  The MPC8260 is a typical embedded CPU made by Motorola.  Selecting
+	  this option means that you wish to build a kernel for a machine with
+	  an 8260 class CPU.
+
+config 8272
+	bool
+	depends on 6xx
+	default y if ADS8272
+	select 8260
+	help
+	  The MPC8272 CPM has a different internal dpram setup than other CPM2
+	  devices
+
+config CPM2
+	bool
+	depends on 8260 || MPC8560 || MPC8555
+	default y
+	help
+	  The CPM2 (Communications Processor Module) is a coprocessor on
+	  embedded CPUs made by Motorola.  Selecting this option means that
+	  you wish to build a kernel for a machine with a CPM2 coprocessor
+	  on it (826x, 827x, 8560).
 endmenu
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
new file mode 100644
index 0000000..d338c95
--- /dev/null
+++ b/arch/powerpc/platforms/Kconfig
@@ -0,0 +1,219 @@
+menu "Platform support"
+	depends on PPC64 || CLASSIC32
+
+choice
+	prompt "Machine type"
+	default PPC_MULTIPLATFORM
+
+config PPC_MULTIPLATFORM
+	bool "Generic desktop/server/laptop"
+	help
+	  Select this option if configuring for an IBM pSeries or
+	  RS/6000 machine, an Apple machine, or a PReP, CHRP,
+	  Maple or Cell-based machine.
+
+config EMBEDDED6xx
+	bool "Embedded 6xx/7xx/7xxx-based board"
+	depends on PPC32 && (BROKEN||BROKEN_ON_SMP)
+
+config APUS
+	bool "Amiga-APUS"
+	depends on PPC32 && BROKEN
+	help
+	  Select APUS if configuring for a PowerUP Amiga.
+	  More information is available at:
+	  <http://linux-apus.sourceforge.net/>.
+endchoice
+
+config QUICC_ENGINE
+	bool
+	depends on PPC_MPC836x || PPC_MPC832x
+	default y
+	help
+	  The QUICC Engine (QE) is a new generation of communications
+	  coprocessors on Freescale embedded CPUs (akin to CPM in older chips).
+	  Selecting this option means that you wish to build a kernel
+	  for a machine with a QE coprocessor.
+
+source "arch/powerpc/platforms/pseries/Kconfig"
+source "arch/powerpc/platforms/iseries/Kconfig"
+source "arch/powerpc/platforms/chrp/Kconfig"
+source "arch/powerpc/platforms/52xx/Kconfig"
+source "arch/powerpc/platforms/powermac/Kconfig"
+source "arch/powerpc/platforms/prep/Kconfig"
+source "arch/powerpc/platforms/maple/Kconfig"
+source "arch/powerpc/platforms/pasemi/Kconfig"
+source arch/powerpc/platforms/celleb/Kconfig
+source arch/powerpc/platforms/ps3/Kconfig
+source arch/powerpc/platforms/cell/Kconfig
+
+config PPC_NATIVE
+	bool
+	depends on PPC_MULTIPLATFORM
+	help
+	  Support for running natively on the hardware, i.e. without
+	  a hypervisor. This option is not user-selectable but should
+	  be selected by all platforms that need it.
+
+config UDBG_RTAS_CONSOLE
+	bool "RTAS based debug console"
+	depends on PPC_RTAS
+	default n
+
+config PPC_UDBG_BEAT
+	bool "BEAT based debug console"
+	depends on PPC_CELLEB
+	default n
+
+config XICS
+	depends on PPC_PSERIES
+	bool
+	default y
+
+config U3_DART
+	bool
+	depends on PPC_MULTIPLATFORM && PPC64
+	default n
+
+config PPC_RTAS
+	bool
+	default n
+
+config RTAS_ERROR_LOGGING
+	bool
+	depends on PPC_RTAS
+	default n
+
+config RTAS_PROC
+	bool "Proc interface to RTAS"
+	depends on PPC_RTAS
+	default y
+
+config RTAS_FLASH
+	tristate "Firmware flash interface"
+	depends on PPC64 && RTAS_PROC
+
+config PPC_PMI
+	tristate "Support for PMI"
+	depends PPC_IBM_CELL_BLADE
+	help
+	  PMI (Platform Management Interrupt) is a way to
+	  communicate with the BMC (Baseboard Mangement Controller).
+	  It is used in some IBM Cell blades.
+	default m
+
+config MMIO_NVRAM
+	bool
+	default n
+
+config MPIC_BROKEN_U3
+	bool
+	depends on PPC_MAPLE
+	default y
+
+config IBMVIO
+	depends on PPC_PSERIES || PPC_ISERIES
+	bool
+	default y
+
+config IBMEBUS
+	depends on PPC_PSERIES
+	bool "Support for GX bus based adapters"
+	help
+	  Bus device driver for GX bus based adapters.
+
+config PPC_MPC106
+	bool
+	default n
+
+config PPC_970_NAP
+	bool
+	default n
+
+config PPC_INDIRECT_IO
+	bool
+	select GENERIC_IOMAP
+	default n
+
+config GENERIC_IOMAP
+	bool
+	default n
+
+source "drivers/cpufreq/Kconfig"
+
+config CPU_FREQ_PMAC
+	bool "Support for Apple PowerBooks"
+	depends on CPU_FREQ && ADB_PMU && PPC32
+	select CPU_FREQ_TABLE
+	help
+	  This adds support for frequency switching on Apple PowerBooks,
+	  this currently includes some models of iBook & Titanium
+	  PowerBook.
+
+config CPU_FREQ_PMAC64
+	bool "Support for some Apple G5s"
+	depends on CPU_FREQ && PPC64
+	select CPU_FREQ_TABLE
+	help
+	  This adds support for frequency switching on Apple iMac G5,
+	  and some of the more recent desktop G5 machines as well.
+
+config PPC601_SYNC_FIX
+	bool "Workarounds for PPC601 bugs"
+	depends on 6xx && (PPC_PREP || PPC_PMAC)
+	help
+	  Some versions of the PPC601 (the first PowerPC chip) have bugs which
+	  mean that extra synchronization instructions are required near
+	  certain instructions, typically those that make major changes to the
+	  CPU state.  These extra instructions reduce performance slightly.
+	  If you say N here, these extra instructions will not be included,
+	  resulting in a kernel which will run faster but may not run at all
+	  on some systems with the PPC601 chip.
+
+	  If in doubt, say Y here.
+
+config TAU
+	bool "On-chip CPU temperature sensor support"
+	depends on 6xx
+	help
+	  G3 and G4 processors have an on-chip temperature sensor called the
+	  'Thermal Assist Unit (TAU)', which, in theory, can measure the on-die
+	  temperature within 2-4 degrees Celsius. This option shows the current
+	  on-die temperature in /proc/cpuinfo if the cpu supports it.
+
+	  Unfortunately, on some chip revisions, this sensor is very inaccurate
+	  and in many cases, does not work at all, so don't assume the cpu
+	  temp is actually what /proc/cpuinfo says it is.
+
+config TAU_INT
+	bool "Interrupt driven TAU driver (DANGEROUS)"
+	depends on TAU
+	---help---
+	  The TAU supports an interrupt driven mode which causes an interrupt
+	  whenever the temperature goes out of range. This is the fastest way
+	  to get notified the temp has exceeded a range. With this option off,
+	  a timer is used to re-check the temperature periodically.
+
+	  However, on some cpus it appears that the TAU interrupt hardware
+	  is buggy and can cause a situation which would lead unexplained hard
+	  lockups.
+
+	  Unless you are extending the TAU driver, or enjoy kernel/hardware
+	  debugging, leave this option off.
+
+config TAU_AVERAGE
+	bool "Average high and low temp"
+	depends on TAU
+	---help---
+	  The TAU hardware can compare the temperature to an upper and lower
+	  bound.  The default behavior is to show both the upper and lower
+	  bound in /proc/cpuinfo. If the range is large, the temperature is
+	  either changing a lot, or the TAU hardware is broken (likely on some
+	  G4's). If the range is small (around 4 degrees), the temperature is
+	  relatively stable.  If you say Y here, a single temperature value,
+	  halfway between the upper and lower bounds, will be reported in
+	  /proc/cpuinfo.
+
+	  If in doubt, say N here.
+
+endmenu
diff --git a/arch/powerpc/platforms/cell/Kconfig b/arch/powerpc/platforms/cell/Kconfig
index 06a85b7..53913a2 100644
--- a/arch/powerpc/platforms/cell/Kconfig
+++ b/arch/powerpc/platforms/cell/Kconfig
@@ -1,3 +1,26 @@
+config PPC_CELL
+	bool
+	default n
+
+config PPC_CELL_NATIVE
+	bool
+	select PPC_CELL
+	select PPC_DCR_MMIO
+	select PPC_OF_PLATFORM_PCI
+	select PPC_INDIRECT_IO
+	select PPC_NATIVE
+	select MPIC
+	default n
+
+config PPC_IBM_CELL_BLADE
+	bool "IBM Cell Blade"
+	depends on PPC_MULTIPLATFORM && PPC64
+	select PPC_CELL_NATIVE
+	select PPC_RTAS
+	select MMIO_NVRAM
+	select PPC_UDBG_16550
+	select UDBG_RTAS_CONSOLE
+
 menu "Cell Broadband Engine options"
 	depends on PPC_CELL

diff --git a/arch/powerpc/platforms/celleb/Kconfig b/arch/powerpc/platforms/celleb/Kconfig
new file mode 100644
index 0000000..2db1e29
--- /dev/null
+++ b/arch/powerpc/platforms/celleb/Kconfig
@@ -0,0 +1,9 @@
+config PPC_CELLEB
+	bool "Toshiba's Cell Reference Set 'Celleb' Architecture"
+	depends on PPC_MULTIPLATFORM && PPC64
+	select PPC_CELL
+	select PPC_OF_PLATFORM_PCI
+	select HAS_TXX9_SERIAL
+	select PPC_UDBG_BEAT
+	select USB_OHCI_BIG_ENDIAN_MMIO
+	select USB_EHCI_BIG_ENDIAN_MMIO
diff --git a/arch/powerpc/platforms/chrp/Kconfig b/arch/powerpc/platforms/chrp/Kconfig
new file mode 100644
index 0000000..d2c6905
--- /dev/null
+++ b/arch/powerpc/platforms/chrp/Kconfig
@@ -0,0 +1,11 @@
+config PPC_CHRP
+	bool "Common Hardware Reference Platform (CHRP) based machines"
+	depends on PPC_MULTIPLATFORM && PPC32
+	select MPIC
+	select PPC_I8259
+	select PPC_INDIRECT_PCI
+	select PPC_RTAS
+	select PPC_MPC106
+	select PPC_UDBG_16550
+	select PPC_NATIVE
+	default y
diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/platforms/embedded6xx/Kconfig
index 3410bcb..9557908 100644
--- a/arch/powerpc/platforms/embedded6xx/Kconfig
+++ b/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -2,78 +2,6 @@ choice
 	prompt "Machine Type"
 	depends on EMBEDDED6xx

-config KATANA
-	bool "Artesyn-Katana"
-	help
-	  Select KATANA if configuring an Artesyn KATANA 750i or 3750
-	  cPCI board.
-
-config WILLOW
-	bool "Cogent-Willow"
-
-config CPCI690
-	bool "Force-CPCI690"
-	help
-	  Select CPCI690 if configuring a Force CPCI690 cPCI board.
-
-config POWERPMC250
-	bool "Force-PowerPMC250"
-
-config CHESTNUT
-	bool "IBM 750FX Eval board or 750GX Eval board"
-	help
-	  Select CHESTNUT if configuring an IBM 750FX Eval Board or a
-	  IBM 750GX Eval board.
-
-config SPRUCE
-	bool "IBM-Spruce"
-	select PPC_INDIRECT_PCI
-
-config HDPU
-	bool "Sky-HDPU"
-	help
-	  Select HDPU if configuring a Sky Computers Compute Blade.
-
-config HDPU_FEATURES
-	depends on HDPU
-	tristate "HDPU-Features"
-	help
-	  Select to enable HDPU enhanced features.
-
-config EV64260
-	bool "Marvell-EV64260BP"
-	help
-	  Select EV64260 if configuring a Marvell (formerly Galileo)
-	  EV64260BP Evaluation platform.
-
-config LOPEC
-	bool "Motorola-LoPEC"
-	select PPC_I8259
-
-config MVME5100
-	bool "Motorola-MVME5100"
-	select PPC_INDIRECT_PCI
-
-config PPLUS
-	bool "Motorola-PowerPlus"
-	select PPC_I8259
-	select PPC_INDIRECT_PCI
-
-config PRPMC750
-	bool "Motorola-PrPMC750"
-	select PPC_INDIRECT_PCI
-
-config PRPMC800
-	bool "Motorola-PrPMC800"
-	select PPC_INDIRECT_PCI
-
-config SANDPOINT
-	bool "Motorola-Sandpoint"
-	select PPC_I8259
-	help
-	  Select SANDPOINT if configuring for a Motorola Sandpoint X3
-	  (any flavor).
-
 config LINKSTATION
 	bool "Linkstation / Kurobox(HG) from Buffalo"
 	select MPIC
@@ -97,212 +25,24 @@ config MPC7448HPC2
 	help
 	  Select MPC7448HPC2 if configuring for Freescale MPC7448HPC2 (Taiga)
 	  platform
-
-config RADSTONE_PPC7D
-	bool "Radstone Technology PPC7D board"
-	select PPC_I8259
-
-config PAL4
-	bool "SBS-Palomar4"
-
-config EST8260
-	bool "EST8260"
-	---help---
-	  The EST8260 is a single-board computer manufactured by Wind River
-	  Systems, Inc. (formerly Embedded Support Tools Corp.) and based on
-	  the MPC8260.  Wind River Systems has a website at
-	  <http://www.windriver.com/>, but the EST8260 cannot be found on it
-	  and has probably been discontinued or rebadged.
-
-config SBC82xx
-	bool "SBC82xx"
-	---help---
-	  SBC PowerQUICC II, single-board computer with MPC82xx CPU
-	  Manufacturer: Wind River Systems, Inc.
-	  Date of Release: May 2003
-	  End of Life: -
-	  URL: <http://www.windriver.com/>
-
-config SBS8260
-	bool "SBS8260"
-
-config RPX8260
-	bool "RPXSUPER"
-
-config TQM8260
-	bool "TQM8260"
-	---help---
-	  MPC8260 based module, little larger than credit card,
-	  up to 128 MB global + 64 MB local RAM, 32 MB Flash,
-	  32 kB EEPROM, 256 kB L@ Cache, 10baseT + 100baseT Ethernet,
-	  2 x serial ports, ...
-	  Manufacturer: TQ Components, www.tq-group.de
-	  Date of Release: June 2001
-	  End of Life: not yet :-)
-	  URL: <http://www.denx.de/PDF/TQM82xx_SPEC_Rev005.pdf>
-
-config ADS8272
-	bool "ADS8272"
-
-config PQ2FADS
-	bool "Freescale-PQ2FADS"
-	help
-	  Select PQ2FADS if you wish to configure for a Freescale
-	  PQ2FADS board (-VR or -ZU).
-
-config EV64360
-	bool "Marvell-EV64360BP"
-	help
-	  Select EV64360 if configuring a Marvell EV64360BP Evaluation
-	  platform.
 endchoice

-config PQ2ADS
-	bool
-	depends on ADS8272
-	default y
-
-config TQM8xxL
-	bool
-	depends on 8xx && (TQM823L || TQM850L || FPS850L || TQM855L || TQM860L)
-	default y
-
-config 8260
-	bool "CPM2 Support" if WILLOW
-	depends on 6xx
-	default y if TQM8260 || RPX8260 || EST8260 || SBS8260 || SBC82xx || PQ2FADS
-	help
-	  The MPC8260 is a typical embedded CPU made by Motorola.  Selecting
-	  this option means that you wish to build a kernel for a machine with
-	  an 8260 class CPU.
-
-config 8272
-	bool
-	depends on 6xx
-	default y if ADS8272
-	select 8260
-	help
-	  The MPC8272 CPM has a different internal dpram setup than other CPM2
-	  devices
-
-config CPM2
-	bool
-	depends on 8260 || MPC8560 || MPC8555
-	default y
-	help
-	  The CPM2 (Communications Processor Module) is a coprocessor on
-	  embedded CPUs made by Motorola.  Selecting this option means that
-	  you wish to build a kernel for a machine with a CPM2 coprocessor
-	  on it (826x, 827x, 8560).
-
-config PPC_GEN550
-	bool
-	depends on SANDPOINT || SPRUCE || PPLUS || \
-		PRPMC750 || PRPMC800 || LOPEC || \
-		(EV64260 && !SERIAL_MPSC) || CHESTNUT || RADSTONE_PPC7D || \
-		83xx || LINKSTATION
-	default y
-
-config FORCE
-	bool
-	depends on 6xx && POWERPMC250
-	default y
-
-config GT64260
-	bool
-	depends on EV64260 || CPCI690
-	default y
-
-config MV64360		# Really MV64360 & MV64460
-	bool
-	depends on CHESTNUT || KATANA || RADSTONE_PPC7D || HDPU || EV64360
-	default y
-
-config MV64X60
-	bool
-	depends on (GT64260 || MV64360)
-	select PPC_INDIRECT_PCI
-	default y
-
 config TSI108_BRIDGE
 	bool
 	depends on MPC7448HPC2
 	default y

-menu "Set bridge options"
-	depends on MV64X60
-
-config NOT_COHERENT_CACHE
-	bool "Turn off Cache Coherency"
-	default n
-	help
-	  Some 64x60 bridges lock up when trying to enforce cache coherency.
-	  When this option is selected, cache coherency will be turned off.
-	  Note that this can cause other problems (e.g., stale data being
-	  speculatively loaded via a cached mapping).  Use at your own risk.
-
-config MV64X60_BASE
-	hex "Set bridge base used by firmware"
-	default "0xf1000000"
-	help
-	  A firmware can leave the base address of the bridge's registers at
-	  a non-standard location.  If so, set this value to reflect the
-	  address of that non-standard location.
-
-config MV64X60_NEW_BASE
-	hex "Set bridge base used by kernel"
-	default "0xf1000000"
-	help
-	  If the current base address of the bridge's registers is not where
-	  you want it, set this value to the address that you want it moved to.
-
-endmenu
-
-config NONMONARCH_SUPPORT
-	bool "Enable Non-Monarch Support"
-	depends on PRPMC800
-
-config HARRIER
-	bool
-	depends on PRPMC800
-	default y
-
-config EPIC_SERIAL_MODE
-	bool
-	depends on 6xx && (LOPEC || SANDPOINT)
-	default y
-
 config MPC10X_BRIDGE
 	bool
-	depends on POWERPMC250 || LOPEC || SANDPOINT || LINKSTATION
+	depends on LINKSTATION
 	select PPC_INDIRECT_PCI
 	default y

 config MPC10X_OPENPIC
 	bool
-	depends on POWERPMC250 || LOPEC || SANDPOINT || LINKSTATION
+	depends on LINKSTATION
 	default y

 config MPC10X_STORE_GATHERING
 	bool "Enable MPC10x store gathering"
 	depends on MPC10X_BRIDGE
-
-config SANDPOINT_ENABLE_UART1
-	bool "Enable DUART mode on Sandpoint"
-	depends on SANDPOINT
-	help
-	  If this option is enabled then the MPC824x processor will run
-	  in DUART mode instead of UART mode.
-
-config HARRIER_STORE_GATHERING
-	bool "Enable Harrier store gathering"
-	depends on HARRIER
-
-config MVME5100_IPMC761_PRESENT
-	bool "MVME5100 configured with an IPMC761"
-	depends on MVME5100
-	select PPC_I8259
-
-config SPRUCE_BAUD_33M
-	bool "Spruce baud clock support"
-	depends on SPRUCE
diff --git a/arch/powerpc/platforms/iseries/Kconfig b/arch/powerpc/platforms/iseries/Kconfig
index 54e6b3b..46c3a8e 100644
--- a/arch/powerpc/platforms/iseries/Kconfig
+++ b/arch/powerpc/platforms/iseries/Kconfig
@@ -1,3 +1,7 @@
+config PPC_ISERIES
+	bool "IBM Legacy iSeries"
+	depends on PPC_MULTIPLATFORM && PPC64
+	select PPC_INDIRECT_IO

 menu "iSeries device drivers"
 	depends on PPC_ISERIES
diff --git a/arch/powerpc/platforms/maple/Kconfig b/arch/powerpc/platforms/maple/Kconfig
new file mode 100644
index 0000000..5f364b8
--- /dev/null
+++ b/arch/powerpc/platforms/maple/Kconfig
@@ -0,0 +1,17 @@
+config PPC_MAPLE
+	depends on PPC_MULTIPLATFORM && PPC64
+	bool "Maple 970FX Evaluation Board"
+	select MPIC
+	select U3_DART
+	select MPIC_BROKEN_U3
+	select GENERIC_TBSYNC
+	select PPC_UDBG_16550
+	select PPC_970_NAP
+	select PPC_NATIVE
+	select PPC_RTAS
+	select MMIO_NVRAM
+	select ATA_NONSTANDARD if ATA
+	default n
+	help
+          This option enables support for the Maple 970FX Evaluation Board.
+	  For more information, refer to <http://www.970eval.com>
diff --git a/arch/powerpc/platforms/pasemi/Kconfig b/arch/powerpc/platforms/pasemi/Kconfig
index 68dc529..64e5525 100644
--- a/arch/powerpc/platforms/pasemi/Kconfig
+++ b/arch/powerpc/platforms/pasemi/Kconfig
@@ -1,3 +1,15 @@
+config PPC_PASEMI
+	depends on PPC_MULTIPLATFORM && PPC64
+	bool "PA Semi SoC-based platforms"
+	default n
+	select MPIC
+	select PPC_UDBG_16550
+	select GENERIC_TBSYNC
+	select PPC_NATIVE
+	help
+	  This option enables support for PA Semi's PWRficient line
+	  of SoC processors, including PA6T-1682M
+
 menu "PA Semi PWRficient options"
 	depends on PPC_PASEMI

diff --git a/arch/powerpc/platforms/powermac/Kconfig b/arch/powerpc/platforms/powermac/Kconfig
new file mode 100644
index 0000000..02d9c7d
--- /dev/null
+++ b/arch/powerpc/platforms/powermac/Kconfig
@@ -0,0 +1,20 @@
+config PPC_PMAC
+	bool "Apple PowerMac based machines"
+	depends on PPC_MULTIPLATFORM
+	select MPIC
+	select PPC_INDIRECT_PCI if PPC32
+	select PPC_MPC106 if PPC32
+	select PPC_NATIVE
+	default y
+
+config PPC_PMAC64
+	bool
+	depends on PPC_PMAC && POWER4
+	select MPIC
+	select U3_DART
+	select MPIC_BROKEN_U3
+	select GENERIC_TBSYNC
+	select PPC_970_NAP
+	default y
+
+
diff --git a/arch/powerpc/platforms/prep/Kconfig b/arch/powerpc/platforms/prep/Kconfig
index 673ac47..29d4112 100644
--- a/arch/powerpc/platforms/prep/Kconfig
+++ b/arch/powerpc/platforms/prep/Kconfig
@@ -1,3 +1,12 @@
+config PPC_PREP
+	bool "PowerPC Reference Platform (PReP) based machines"
+	depends on PPC_MULTIPLATFORM && PPC32 && BROKEN
+	select MPIC
+	select PPC_I8259
+	select PPC_INDIRECT_PCI
+	select PPC_UDBG_16550
+	select PPC_NATIVE
+	default n

 config PREP_RESIDUAL
 	bool "Support for PReP Residual Data"
diff --git a/arch/powerpc/platforms/ps3/Kconfig b/arch/powerpc/platforms/ps3/Kconfig
index 1a481a6..40f0008 100644
--- a/arch/powerpc/platforms/ps3/Kconfig
+++ b/arch/powerpc/platforms/ps3/Kconfig
@@ -1,3 +1,19 @@
+config PPC_PS3
+	bool "Sony PS3 (incomplete)"
+	depends on PPC_MULTIPLATFORM && PPC64
+	select PPC_CELL
+	select USB_ARCH_HAS_OHCI
+	select USB_OHCI_LITTLE_ENDIAN
+	select USB_OHCI_BIG_ENDIAN_MMIO
+	select USB_ARCH_HAS_EHCI
+	select USB_EHCI_BIG_ENDIAN_MMIO
+	help
+	  This option enables support for the Sony PS3 game console
+	  and other platforms using the PS3 hypervisor.
+	  Support for this platform is not yet complete, so
+	  enabling this will not result in a bootable kernel on a
+	  PS3 system.
+
 menu "PS3 Platform Options"
 	depends on PPC_PS3

diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index a57032c..16e4e40 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -1,3 +1,13 @@
+config PPC_PSERIES
+	depends on PPC_MULTIPLATFORM && PPC64
+	bool "IBM pSeries & new (POWER5-based) iSeries"
+	select MPIC
+	select PPC_I8259
+	select PPC_RTAS
+	select RTAS_ERROR_LOGGING
+	select PPC_UDBG_16550
+	select PPC_NATIVE
+	default y

 config PPC_SPLPAR
 	depends on PPC_PSERIES
