Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BD557DDF35
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 02:29:13 +1100 (EST)
Received: from [72.183.106.80] (helo=[192.168.1.2])
	by nommos.sslcatacombnetworking.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.63) (envelope-from <galak@kernel.crashing.org>)
	id 1HSEMg-0000fd-TU
	for linuxppc-dev@ozlabs.org; Fri, 16 Mar 2007 10:29:11 -0500
Date: Fri, 16 Mar 2007 10:25:52 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH][POWERPC] [006/006] Created arch/powerpc/platforms/Kconfig
	for "Platform support"
In-Reply-To: <Pine.LNX.4.64.0703161016520.9740@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0703161025150.9740@localhost.localdomain>
References: <Pine.LNX.4.64.0703161016520.9740@localhost.localdomain>
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

Split "Platform support" menu out from arch/powerpc/Kconfig into
arch/powerpc/platforms/Kconfig in prep for allowing other sub-arches to
be configured via a single "Platform support" menu.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/Kconfig           |  220 +---------------------------------------
 arch/powerpc/platforms/Kconfig |  219 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 220 insertions(+), 219 deletions(-)
 create mode 100644 arch/powerpc/platforms/Kconfig

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c5014ba..20aae16 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -367,225 +367,7 @@ endmenu

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
-source "arch/powerpc/platforms/pseries/Kconfig"
-source "arch/powerpc/platforms/iseries/Kconfig"
-source "arch/powerpc/platforms/chrp/Kconfig"
-source "arch/powerpc/platforms/52xx/Kconfig"
-source "arch/powerpc/platforms/powermac/Kconfig"
-source "arch/powerpc/platforms/prep/Kconfig"
-source "arch/powerpc/platforms/maple/Kconfig"
-source "arch/powerpc/platforms/pasemi/Kconfig"
-source arch/powerpc/platforms/celleb/Kconfig
-source arch/powerpc/platforms/ps3/Kconfig
-source arch/powerpc/platforms/cell/Kconfig
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
-- 
1.5.0.2
