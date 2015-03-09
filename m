Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0101.outbound.protection.outlook.com [157.56.111.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A53C81A21E2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:47:49 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <scottwood@Freescale.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>
Subject: [RFC v3 03/10] powerpc/mpc85xx: Add platform support for the
 Freescale DPAA BMan
Date: Mon, 9 Mar 2015 09:41:48 -0500
Message-ID: <1425912115-27398-4-git-send-email-Emilian.Medve@Freescale.com>
In-Reply-To: <1425912115-27398-1-git-send-email-Emilian.Medve@Freescale.com>
References: <1425912115-27398-1-git-send-email-Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Geoff Thorpe <Geoff.Thorpe@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Geoff Thorpe <Geoff.Thorpe@freescale.com>

Signed-off-by: Geoff Thorpe <Geoff.Thorpe@freescale.com>
---
 arch/powerpc/Kconfig                          | 33 +++++++++++++++------------
 arch/powerpc/configs/mpc85xx_defconfig        |  1 +
 arch/powerpc/configs/mpc85xx_smp_defconfig    |  1 +
 arch/powerpc/platforms/85xx/Kconfig           | 11 +++++----
 arch/powerpc/platforms/85xx/corenet_generic.c | 22 +++++++++++++++---
 arch/powerpc/platforms/85xx/p1023_rdb.c       | 22 ++++++++++++++----
 6 files changed, 64 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 7258b468..6ab5ad5 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -362,7 +362,7 @@ config PPC_TRANSACTIONAL_MEM
        select VSX
        default n
        ---help---
-         Support user-mode Transactional Memory on POWERPC.
+	 Support user-mode Transactional Memory on POWERPC.
 
 config IOMMU_HELPER
 	def_bool PPC64
@@ -375,7 +375,7 @@ config SWIOTLB
 	  Support for IO bounce buffering for systems without an IOMMU.
 	  This allows us to DMA to the full physical address space on
 	  platforms where the size of a physical address is larger
-	  than the bus address.  Not all platforms support this.
+	  than the bus address.	 Not all platforms support this.
 
 config HOTPLUG_CPU
 	bool "Support for enabling/disabling CPUs"
@@ -411,8 +411,8 @@ config KEXEC
 	depends on (PPC_BOOK3S || FSL_BOOKE || (44x && !SMP))
 	help
 	  kexec is a system call that implements the ability to shutdown your
-	  current kernel, and to start another kernel.  It is like a reboot
-	  but it is independent of the system firmware.   And like a reboot
+	  current kernel, and to start another kernel.	It is like a reboot
+	  but it is independent of the system firmware.	  And like a reboot
 	  you can start any kernel with it, not just Linux.
 
 	  The name comes from the similarity to the exec system call.
@@ -451,7 +451,7 @@ config IRQ_ALL_CPUS
 	help
 	  This option gives the kernel permission to distribute IRQs across
 	  multiple CPUs.  Saying N here will route all IRQs to the first
-	  CPU.  Generally saying Y is safe, although some problems have been
+	  CPU.	Generally saying Y is safe, although some problems have been
 	  reported with SMP Power Macintoshes with this option enabled.
 
 config NUMA
@@ -500,9 +500,9 @@ config ARCH_MEMORY_PROBE
 	depends on MEMORY_HOTPLUG
 
 # Some NUMA nodes have memory ranges that span
-# other nodes.  Even though a pfn is valid and
+# other nodes.	Even though a pfn is valid and
 # between a node's start and end pfns, it may not
-# reside on that node.  See memmap_init_zone()
+# reside on that node.	See memmap_init_zone()
 # for details.
 config NODES_SPAN_OTHER_NODES
 	def_bool y
@@ -601,8 +601,8 @@ config FORCE_MAX_ZONEORDER
 	  This config option is actually maximum order plus one. For example,
 	  a value of 11 means that the largest free memory block is 2^10 pages.
 
-	  The page size is not necessarily 4KB.  For example, on 64-bit
-	  systems, 64KB pages can be enabled via CONFIG_PPC_64K_PAGES.  Keep
+	  The page size is not necessarily 4KB.	 For example, on 64-bit
+	  systems, 64KB pages can be enabled via CONFIG_PPC_64K_PAGES.	Keep
 	  this in mind when choosing a value for this option.
 
 config PPC_SUBPAGE_PROT
@@ -631,7 +631,7 @@ config PPC_DENORMALISATION
 	default "y" if PPC_POWERNV
 	---help---
 	  Add support for handling denormalisation of single precision
-	  values.  Useful for bare metal only.  If unsure say Y here.
+	  values.  Useful for bare metal only.	If unsure say Y here.
 
 config CMDLINE_BOOL
 	bool "Default bootloader kernel arguments"
@@ -741,7 +741,7 @@ config FSL_SOC
 	bool
 
 config FSL_PCI
- 	bool
+	bool
 	select PPC_INDIRECT_PCI
 	select PCI_QUIRKS
 
@@ -779,12 +779,17 @@ config FSL_GTM
 	help
 	  Freescale General-purpose Timers support
 
+config HAS_FSL_QBMAN
+	bool "Datapath Acceleration Queue and Buffer management"
+	help
+	  Datapath Acceleration Queue and Buffer management
+
 # Yes MCA RS/6000s exist but Linux-PPC does not currently support any
 config MCA
 	bool
 
 # Platforms that what PCI turned unconditionally just do select PCI
-# in their config node.  Platforms that want to choose at config
+# in their config node.	 Platforms that want to choose at config
 # time should select PPC_PCI_CHOICE
 config PPC_PCI_CHOICE
 	bool
@@ -911,14 +916,14 @@ config DYNAMIC_MEMSTART
 	select NONSTATIC_KERNEL
 	help
 	  This option enables the kernel to be loaded at any page aligned
-	  physical address. The kernel creates a mapping from KERNELBASE to 
+	  physical address. The kernel creates a mapping from KERNELBASE to
 	  the address where the kernel is loaded. The page size here implies
 	  the TLB page size of the mapping for kernel on the particular platform.
 	  Please refer to the init code for finding the TLB page size.
 
 	  DYNAMIC_MEMSTART is an easy way of implementing pseudo-RELOCATABLE
 	  kernel image, where the only restriction is the page aligned kernel
-	  load address. When this option is enabled, the compile time physical 
+	  load address. When this option is enabled, the compile time physical
 	  address CONFIG_PHYSICAL_START is ignored.
 
 	  This option is overridden by CONFIG_RELOCATABLE
diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
index 8535c34..22242a9 100644
--- a/arch/powerpc/configs/mpc85xx_defconfig
+++ b/arch/powerpc/configs/mpc85xx_defconfig
@@ -49,6 +49,7 @@ CONFIG_HIGHMEM=y
 CONFIG_BINFMT_MISC=m
 CONFIG_MATH_EMULATION=y
 CONFIG_FORCE_MAX_ZONEORDER=12
+CONFIG_HAS_FSL_QBMAN=y
 CONFIG_PCI=y
 CONFIG_PCIEPORTBUS=y
 # CONFIG_PCIEASPM is not set
diff --git a/arch/powerpc/configs/mpc85xx_smp_defconfig b/arch/powerpc/configs/mpc85xx_smp_defconfig
index c45ad2e..6c0a226 100644
--- a/arch/powerpc/configs/mpc85xx_smp_defconfig
+++ b/arch/powerpc/configs/mpc85xx_smp_defconfig
@@ -50,6 +50,7 @@ CONFIG_HIGHMEM=y
 CONFIG_BINFMT_MISC=m
 CONFIG_MATH_EMULATION=y
 CONFIG_FORCE_MAX_ZONEORDER=12
+CONFIG_HAS_FSL_QBMAN=y
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
 CONFIG_RAPIDIO=y
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index dbdd5fa..51e9a7b 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -146,10 +146,10 @@ config SOCRATES
 	  This option enables support for the Socrates board.
 
 config KSI8560
-        bool "Emerson KSI8560"
-        select DEFAULT_UIMAGE
-        help
-          This option enables support for the Emerson KSI8560 board
+	bool "Emerson KSI8560"
+	select DEFAULT_UIMAGE
+	help
+	  This option enables support for the Emerson KSI8560 board
 
 config XES_MPC85xx
 	bool "X-ES single-board computer"
@@ -255,7 +255,7 @@ config PPC_QEMU_E500
 	select DEFAULT_UIMAGE
 	help
 	  This option enables support for running as a QEMU guest using
-	  QEMU's generic e500 machine.  This is not required if you're
+	  QEMU's generic e500 machine.	This is not required if you're
 	  using a QEMU machine that targets a specific board, such as
 	  mpc8544ds.
 
@@ -276,6 +276,7 @@ config CORENET_GENERIC
 	select GPIO_MPC8XXX
 	select HAS_RAPIDIO
 	select PPC_EPAPR_HV_PIC
+	select HAS_FSL_QBMAN
 	help
 	  This option enables support for the FSL CoreNet based boards.
 	  For 32bit kernel, the following boards are supported:
diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index 9824d2c..c5a82c9 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -3,10 +3,10 @@
  *
  * Maintained by Kumar Gala (see MAINTAINERS for contact information)
  *
- * Copyright 2009-2011 Freescale Semiconductor Inc.
+ * Copyright 2009 - 2015 Freescale Semiconductor Inc.
  *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
+ * This program is free software; you can redistribute	it and/or modify it
+ * under  the terms of	the GNU General	 Public License as published by the
  * Free Software Foundation;  either version 2 of the  License, or (at your
  * option) any later version.
  */
@@ -200,6 +200,21 @@ static int __init corenet_generic_probe(void)
 	return 0;
 }
 
+/* Early setup is required for large chunks of contiguous (and coarsely-aligned)
+ * memory. The following shoe-horns BMan "init_early" calls into the
+ * platform setup to let them parse their CCSR nodes early on.
+ */
+#ifdef CONFIG_FSL_BMAN_CONFIG
+void __init bman_init_early(void);
+#endif
+
+__init void corenet_ds_init_early(void)
+{
+#ifdef CONFIG_FSL_BMAN_CONFIG
+	bman_init_early();
+#endif
+}
+
 define_machine(corenet_generic) {
 	.name			= "CoreNet Generic",
 	.probe			= corenet_generic_probe,
@@ -218,6 +233,7 @@ define_machine(corenet_generic) {
 #else
 	.power_save		= e500_idle,
 #endif
+	.init_early		= corenet_ds_init_early,
 };
 
 machine_arch_initcall(corenet_generic, corenet_gen_publish_devices);
diff --git a/arch/powerpc/platforms/85xx/p1023_rdb.c b/arch/powerpc/platforms/85xx/p1023_rdb.c
index d5b7509..e629394 100644
--- a/arch/powerpc/platforms/85xx/p1023_rdb.c
+++ b/arch/powerpc/platforms/85xx/p1023_rdb.c
@@ -1,13 +1,13 @@
 /*
- * Copyright 2010-2011, 2013 Freescale Semiconductor, Inc.
+ * Copyright 2010 - 2015 Freescale Semiconductor, Inc.
  *
  * Author: Roy Zang <tie-fei.zang@freescale.com>
  *
  * Description:
  * P1023 RDB Board Setup
  *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
+ * This program is free software; you can redistribute	it and/or modify it
+ * under  the terms of	the GNU General	 Public License as published by the
  * Free Software Foundation;  either version 2 of the  License, or (at your
  * option) any later version.
  */
@@ -103,7 +103,20 @@ static int __init p1023_rdb_probe(void)
 	unsigned long root = of_get_flat_dt_root();
 
 	return of_flat_dt_is_compatible(root, "fsl,P1023RDB");
+}
+
+/* Early setup is required for large chunks of contiguous (and coarsely-aligned)
+ * memory. The following shoe-horns BMan "init_early" calls into the
+ * platform setup to let them parse their CCSR nodes early on. */
+#ifdef CONFIG_FSL_BMAN_CONFIG
+void __init bman_init_early(void);
+#endif
 
+static __init void p1023_rdb_init_early(void)
+{
+#ifdef CONFIG_FSL_BMAN_CONFIG
+	bman_init_early();
+#endif
 }
 
 define_machine(p1023_rdb) {
@@ -117,6 +130,7 @@ define_machine(p1023_rdb) {
 	.progress		= udbg_progress,
 #ifdef CONFIG_PCI
 	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
-	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
+	.pcibios_fixup_phb	= fsl_pcibios_fixup_phb,
 #endif
+	.init_early		= p1023_rdb_init_early,
 };
-- 
2.3.0
