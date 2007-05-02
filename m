Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 30398DDF1B
	for <linuxppc-dev@ozlabs.org>; Wed,  2 May 2007 22:14:16 +1000 (EST)
Message-Id: <20070502115644.638734471@arndb.de>
References: <20070502114709.074174446@arndb.de>
Date: Wed, 02 May 2007 13:47:10 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/6] powerpc: split out CPU specific options into a new
	Kconfig file
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A lot of the options in arch/powerpc/Kconfig deal with the CPU menu,
and my next patches add more to them. Moving them to a new
arch/powerpc/platforms/Kconfig.cputype file makes it easier to
follow.

There are no functional changes in here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Index: linux-2.6/arch/powerpc/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/Kconfig
+++ linux-2.6/arch/powerpc/Kconfig
@@ -4,12 +4,7 @@
 
 mainmenu "Linux/PowerPC Kernel Configuration"
 
-config PPC64
-	bool "64-bit kernel"
-	default n
-	help
-	  This option selects whether a 32-bit or a 64-bit kernel
-	  will be built.
+source "arch/powerpc/platforms/Kconfig.cputype"
 
 config PPC_PM_NEEDS_RTC_LIB
 	bool
@@ -123,122 +118,6 @@ config DEFAULT_UIMAGE
 	  Used to allow a board to specify it wants a uImage built by default
 	default n
 
-menu "Processor support"
-choice
-	prompt "Processor Type"
-	depends on PPC32
-	default 6xx
-
-config CLASSIC32
-	bool "52xx/6xx/7xx/74xx"
-	select PPC_FPU
-	select 6xx
-	help
-	  There are four families of PowerPC chips supported.  The more common
-	  types (601, 603, 604, 740, 750, 7400), the Motorola embedded
-	  versions (821, 823, 850, 855, 860, 52xx, 82xx, 83xx), the AMCC
-	  embedded versions (403 and 405) and the high end 64 bit Power
-	  processors (POWER 3, POWER4, and IBM PPC970 also known as G5).
-
-	  This option is the catch-all for 6xx types, including some of the
-	  embedded versions.  Unless there is see an option for the specific
-	  chip family you are using, you want this option.
-	  
-	  You do not want this if you are building a kernel for a 64 bit
-	  IBM RS/6000 or an Apple G5, choose 6xx.
-	  
-	  If unsure, select this option
-	  
-	  Note that the kernel runs in 32-bit mode even on 64-bit chips.
-
-config PPC_82xx
-	bool "Freescale 82xx"
-	select 6xx
-	select PPC_FPU
-
-config PPC_83xx
-	bool "Freescale 83xx"
-	select 6xx
-	select FSL_SOC
-	select 83xx
-	select PPC_FPU
-	select WANT_DEVICE_TREE
-
-config PPC_85xx
-	bool "Freescale 85xx"
-	select E500
-	select FSL_SOC
-	select 85xx
-	select WANT_DEVICE_TREE
-
-config PPC_86xx
-	bool "Freescale 86xx"
-	select 6xx
-	select FSL_SOC
-	select FSL_PCIE
-	select PPC_FPU
-	select ALTIVEC
-	help
-	  The Freescale E600 SoCs have 74xx cores.
-
-config PPC_8xx
-	bool "Freescale 8xx"
-	select FSL_SOC
-	select 8xx
-
-config 40x
-	bool "AMCC 40x"
-	select PPC_DCR_NATIVE
-
-config 44x
-	bool "AMCC 44x"
-	select PPC_DCR_NATIVE
-
-config E200
-	bool "Freescale e200"
-
-endchoice
-
-config POWER4_ONLY
-	bool "Optimize for POWER4"
-	depends on PPC64
-	default n
-	---help---
-	  Cause the compiler to optimize for POWER4/POWER5/PPC970 processors.
-	  The resulting binary will not work on POWER3 or RS64 processors
-	  when compiled with binutils 2.15 or later.
-
-config POWER3
-	bool
-	depends on PPC64
-	default y if !POWER4_ONLY
-
-config POWER4
-	depends on PPC64
-	def_bool y
-
-config 6xx
-	bool
-
-# this is temp to handle compat with arch=ppc
-config 8xx
-	bool
-
-# this is temp to handle compat with arch=ppc
-config 83xx
-	bool
-
-# this is temp to handle compat with arch=ppc
-config 85xx
-	bool
-
-config E500
-	bool
-
-config PPC_FPU
-	bool
-	default y if PPC64
-
 config PPC_DCR_NATIVE
 	bool
 	default n
@@ -257,121 +136,6 @@ config PPC_OF_PLATFORM_PCI
 	depends on PPC64 # not supported on 32 bits yet
 	default n
 
-config BOOKE
-	bool
-	depends on E200 || E500
-	default y
-
-config FSL_BOOKE
-	bool
-	depends on E200 || E500
-	default y
-
-config PTE_64BIT
-	bool
-	depends on 44x || E500
-	default y if 44x
-	default y if E500 && PHYS_64BIT
-
-config PHYS_64BIT
-	bool 'Large physical address support' if E500
-	depends on 44x || E500
-	select RESOURCES_64BIT
-	default y if 44x
-	---help---
-	  This option enables kernel support for larger than 32-bit physical
-	  addresses.  This features is not be available on all e500 cores.
-
-	  If in doubt, say N here.
-
-config ALTIVEC
-	bool "AltiVec Support"
-	depends on CLASSIC32 || POWER4
-	---help---
-	  This option enables kernel support for the Altivec extensions to the
-	  PowerPC processor. The kernel currently supports saving and restoring
-	  altivec registers, and turning on the 'altivec enable' bit so user
-	  processes can execute altivec instructions.
-
-	  This option is only usefully if you have a processor that supports
-	  altivec (G4, otherwise known as 74xx series), but does not have
-	  any affect on a non-altivec cpu (it does, however add code to the
-	  kernel).
-
-	  If in doubt, say Y here.
-
-config SPE
-	bool "SPE Support"
-	depends on E200 || E500
-	default y
-	---help---
-	  This option enables kernel support for the Signal Processing
-	  Extensions (SPE) to the PowerPC processor. The kernel currently
-	  supports saving and restoring SPE registers, and turning on the
-	  'spe enable' bit so user processes can execute SPE instructions.
-
-	  This option is only useful if you have a processor that supports
-	  SPE (e500, otherwise known as 85xx series), but does not have any
-	  effect on a non-spe cpu (it does, however add code to the kernel).
-
-	  If in doubt, say Y here.
-
-config PPC_STD_MMU
-	bool
-	depends on 6xx || POWER3 || POWER4 || PPC64
-	default y
-
-config PPC_STD_MMU_32
-	def_bool y
-	depends on PPC_STD_MMU && PPC32
-
-config VIRT_CPU_ACCOUNTING
-	bool "Deterministic task and CPU time accounting"
-	depends on PPC64
-	default y
-	help
-	  Select this option to enable more accurate task and CPU time
-	  accounting.  This is done by reading a CPU counter on each
-	  kernel entry and exit and on transitions within the kernel
-	  between system, softirq and hardirq state, so there is a
-	  small performance impact.  This also enables accounting of
-	  stolen time on logically-partitioned systems running on
-	  IBM POWER5-based machines.
-
-	  If in doubt, say Y here.
-
-config SMP
-	depends on PPC_STD_MMU
-	bool "Symmetric multi-processing support"
-	---help---
-	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, say N. If you have a system with more
-	  than one CPU, say Y.  Note that the kernel does not currently
-	  support SMP machines with 603/603e/603ev or PPC750 ("G3") processors
-	  since they have inadequate hardware support for multiprocessor
-	  operation.
-
-	  If you say N here, the kernel will run on single and multiprocessor
-	  machines, but will use only one CPU of a multiprocessor machine. If
-	  you say Y here, the kernel will run on single-processor machines.
-	  On a single-processor machine, the kernel will run faster if you say
-	  N here.
-
-	  If you don't know what to do here, say N.
-
-config NR_CPUS
-	int "Maximum number of CPUs (2-128)"
-	range 2 128
-	depends on SMP
-	default "32" if PPC64
-	default "4"
-
-config NOT_COHERENT_CACHE
-	bool
-	depends on 4xx || 8xx || E200
-	default y
-endmenu
-
 source "init/Kconfig"
 
 source "arch/powerpc/platforms/Kconfig"
Index: linux-2.6/arch/powerpc/platforms/Kconfig.cputype
===================================================================
--- /dev/null
+++ linux-2.6/arch/powerpc/platforms/Kconfig.cputype
@@ -0,0 +1,238 @@
+config PPC64
+	bool "64-bit kernel"
+	default n
+	help
+	  This option selects whether a 32-bit or a 64-bit kernel
+	  will be built.
+
+menu "Processor support"
+choice
+	prompt "Processor Type"
+	depends on PPC32
+	default 6xx
+
+config CLASSIC32
+	bool "52xx/6xx/7xx/74xx"
+	select PPC_FPU
+	select 6xx
+	help
+	  There are four families of PowerPC chips supported.  The more common
+	  types (601, 603, 604, 740, 750, 7400), the Motorola embedded
+	  versions (821, 823, 850, 855, 860, 52xx, 82xx, 83xx), the AMCC
+	  embedded versions (403 and 405) and the high end 64 bit Power
+	  processors (POWER 3, POWER4, and IBM PPC970 also known as G5).
+
+	  This option is the catch-all for 6xx types, including some of the
+	  embedded versions.  Unless there is see an option for the specific
+	  chip family you are using, you want this option.
+
+	  You do not want this if you are building a kernel for a 64 bit
+	  IBM RS/6000 or an Apple G5, choose 6xx.
+
+	  If unsure, select this option
+
+	  Note that the kernel runs in 32-bit mode even on 64-bit chips.
+
+config PPC_82xx
+	bool "Freescale 82xx"
+	select 6xx
+	select PPC_FPU
+
+config PPC_83xx
+	bool "Freescale 83xx"
+	select 6xx
+	select FSL_SOC
+	select 83xx
+	select PPC_FPU
+	select WANT_DEVICE_TREE
+
+config PPC_85xx
+	bool "Freescale 85xx"
+	select E500
+	select FSL_SOC
+	select 85xx
+	select WANT_DEVICE_TREE
+
+config PPC_86xx
+	bool "Freescale 86xx"
+	select 6xx
+	select FSL_SOC
+	select FSL_PCIE
+	select PPC_FPU
+	select ALTIVEC
+	help
+	  The Freescale E600 SoCs have 74xx cores.
+
+config PPC_8xx
+	bool "Freescale 8xx"
+	select FSL_SOC
+	select 8xx
+
+config 40x
+	bool "AMCC 40x"
+	select PPC_DCR_NATIVE
+
+config 44x
+	bool "AMCC 44x"
+	select PPC_DCR_NATIVE
+
+config E200
+	bool "Freescale e200"
+
+endchoice
+
+config POWER4_ONLY
+	bool "Optimize for POWER4"
+	depends on PPC64
+	default n
+	---help---
+	  Cause the compiler to optimize for POWER4/POWER5/PPC970 processors.
+	  The resulting binary will not work on POWER3 or RS64 processors
+	  when compiled with binutils 2.15 or later.
+
+config POWER3
+	bool
+	depends on PPC64
+	default y if !POWER4_ONLY
+
+config POWER4
+	depends on PPC64
+	def_bool y
+
+config 6xx
+	bool
+
+# this is temp to handle compat with arch=ppc
+config 8xx
+	bool
+
+# this is temp to handle compat with arch=ppc
+config 83xx
+	bool
+
+# this is temp to handle compat with arch=ppc
+config 85xx
+	bool
+
+config E500
+	bool
+
+config PPC_FPU
+	bool
+	default y if PPC64
+
+config BOOKE
+	bool
+	depends on E200 || E500
+	default y
+
+config FSL_BOOKE
+	bool
+	depends on E200 || E500
+	default y
+
+config PTE_64BIT
+	bool
+	depends on 44x || E500
+	default y if 44x
+	default y if E500 && PHYS_64BIT
+
+config PHYS_64BIT
+	bool 'Large physical address support' if E500
+	depends on 44x || E500
+	select RESOURCES_64BIT
+	default y if 44x
+	---help---
+	  This option enables kernel support for larger than 32-bit physical
+	  addresses.  This features is not be available on all e500 cores.
+
+	  If in doubt, say N here.
+
+config ALTIVEC
+	bool "AltiVec Support"
+	depends on CLASSIC32 || POWER4
+	---help---
+	  This option enables kernel support for the Altivec extensions to the
+	  PowerPC processor. The kernel currently supports saving and restoring
+	  altivec registers, and turning on the 'altivec enable' bit so user
+	  processes can execute altivec instructions.
+
+	  This option is only usefully if you have a processor that supports
+	  altivec (G4, otherwise known as 74xx series), but does not have
+	  any affect on a non-altivec cpu (it does, however add code to the
+	  kernel).
+
+	  If in doubt, say Y here.
+
+config SPE
+	bool "SPE Support"
+	depends on E200 || E500
+	default y
+	---help---
+	  This option enables kernel support for the Signal Processing
+	  Extensions (SPE) to the PowerPC processor. The kernel currently
+	  supports saving and restoring SPE registers, and turning on the
+	  'spe enable' bit so user processes can execute SPE instructions.
+
+	  This option is only useful if you have a processor that supports
+	  SPE (e500, otherwise known as 85xx series), but does not have any
+	  effect on a non-spe cpu (it does, however add code to the kernel).
+
+	  If in doubt, say Y here.
+
+config PPC_STD_MMU
+	bool
+	depends on 6xx || POWER3 || POWER4 || PPC64
+	default y
+
+config PPC_STD_MMU_32
+	def_bool y
+	depends on PPC_STD_MMU && PPC32
+
+config VIRT_CPU_ACCOUNTING
+	bool "Deterministic task and CPU time accounting"
+	depends on PPC64
+	default y
+	help
+	  Select this option to enable more accurate task and CPU time
+	  accounting.  This is done by reading a CPU counter on each
+	  kernel entry and exit and on transitions within the kernel
+	  between system, softirq and hardirq state, so there is a
+	  small performance impact.  This also enables accounting of
+	  stolen time on logically-partitioned systems running on
+	  IBM POWER5-based machines.
+
+	  If in doubt, say Y here.
+
+config SMP
+	depends on PPC_STD_MMU
+	bool "Symmetric multi-processing support"
+	---help---
+	  This enables support for systems with more than one CPU. If you have
+	  a system with only one CPU, say N. If you have a system with more
+	  than one CPU, say Y.  Note that the kernel does not currently
+	  support SMP machines with 603/603e/603ev or PPC750 ("G3") processors
+	  since they have inadequate hardware support for multiprocessor
+	  operation.
+
+	  If you say N here, the kernel will run on single and multiprocessor
+	  machines, but will use only one CPU of a multiprocessor machine. If
+	  you say Y here, the kernel will run on single-processor machines.
+	  On a single-processor machine, the kernel will run faster if you say
+	  N here.
+
+	  If you don't know what to do here, say N.
+
+config NR_CPUS
+	int "Maximum number of CPUs (2-128)"
+	range 2 128
+	depends on SMP
+	default "32" if PPC64
+	default "4"
+
+config NOT_COHERENT_CACHE
+	bool
+	depends on 4xx || 8xx || E200
+	default y
+endmenu
+

--
