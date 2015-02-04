Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0109.outbound.protection.outlook.com [157.56.111.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2E4DD1A168C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Feb 2015 01:53:14 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <devel@driverdev.osuosl.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>
Subject: [RFC 03/10] powerpc/mpc85xx: Add platform support for the Freescale
 DPAA BMan
Date: Wed, 4 Feb 2015 08:48:35 -0600
Message-ID: <1423061322-16059-4-git-send-email-Emilian.Medve@Freescale.com>
In-Reply-To: <1423061322-16059-1-git-send-email-Emilian.Medve@Freescale.com>
References: <1423061322-16059-1-git-send-email-Emilian.Medve@Freescale.com>
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

Change-Id: I59de17c040cdd304f86306336fcf89f130f7db2d
Signed-off-by: Geoff Thorpe <Geoff.Thorpe@freescale.com>
---
 arch/powerpc/Kconfig                          | 33 +++++++++++++++------------
 arch/powerpc/platforms/85xx/Kconfig           | 11 +++++----
 arch/powerpc/platforms/85xx/corenet_generic.c | 20 ++++++++++++++--
 arch/powerpc/platforms/85xx/p1023_rdb.c       | 20 +++++++++++++---
 4 files changed, 60 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 89996f3..7b2e673 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -361,7 +361,7 @@ config PPC_TRANSACTIONAL_MEM
        select VSX
        default n
        ---help---
-         Support user-mode Transactional Memory on POWERPC.
+	 Support user-mode Transactional Memory on POWERPC.
 
 config IOMMU_HELPER
 	def_bool PPC64
@@ -374,7 +374,7 @@ config SWIOTLB
 	  Support for IO bounce buffering for systems without an IOMMU.
 	  This allows us to DMA to the full physical address space on
 	  platforms where the size of a physical address is larger
-	  than the bus address.  Not all platforms support this.
+	  than the bus address.	 Not all platforms support this.
 
 config HOTPLUG_CPU
 	bool "Support for enabling/disabling CPUs"
@@ -410,8 +410,8 @@ config KEXEC
 	depends on (PPC_BOOK3S || FSL_BOOKE || (44x && !SMP))
 	help
 	  kexec is a system call that implements the ability to shutdown your
-	  current kernel, and to start another kernel.  It is like a reboot
-	  but it is independent of the system firmware.   And like a reboot
+	  current kernel, and to start another kernel.	It is like a reboot
+	  but it is independent of the system firmware.	  And like a reboot
 	  you can start any kernel with it, not just Linux.
 
 	  The name comes from the similarity to the exec system call.
@@ -450,7 +450,7 @@ config IRQ_ALL_CPUS
 	help
 	  This option gives the kernel permission to distribute IRQs across
 	  multiple CPUs.  Saying N here will route all IRQs to the first
-	  CPU.  Generally saying Y is safe, although some problems have been
+	  CPU.	Generally saying Y is safe, although some problems have been
 	  reported with SMP Power Macintoshes with this option enabled.
 
 config NUMA
@@ -499,9 +499,9 @@ config ARCH_MEMORY_PROBE
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
@@ -600,8 +600,8 @@ config FORCE_MAX_ZONEORDER
 	  This config option is actually maximum order plus one. For example,
 	  a value of 11 means that the largest free memory block is 2^10 pages.
 
-	  The page size is not necessarily 4KB.  For example, on 64-bit
-	  systems, 64KB pages can be enabled via CONFIG_PPC_64K_PAGES.  Keep
+	  The page size is not necessarily 4KB.	 For example, on 64-bit
+	  systems, 64KB pages can be enabled via CONFIG_PPC_64K_PAGES.	Keep
 	  this in mind when choosing a value for this option.
 
 config PPC_SUBPAGE_PROT
@@ -630,7 +630,7 @@ config PPC_DENORMALISATION
 	default "y" if PPC_POWERNV
 	---help---
 	  Add support for handling denormalisation of single precision
-	  values.  Useful for bare metal only.  If unsure say Y here.
+	  values.  Useful for bare metal only.	If unsure say Y here.
 
 config CMDLINE_BOOL
 	bool "Default bootloader kernel arguments"
@@ -740,7 +740,7 @@ config FSL_SOC
 	bool
 
 config FSL_PCI
- 	bool
+	bool
 	select PPC_INDIRECT_PCI
 	select PCI_QUIRKS
 
@@ -778,12 +778,17 @@ config FSL_GTM
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
@@ -910,14 +915,14 @@ config DYNAMIC_MEMSTART
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
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 0e72534..7f8c798 100644
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
@@ -249,7 +249,7 @@ config PPC_QEMU_E500
 	select DEFAULT_UIMAGE
 	help
 	  This option enables support for running as a QEMU guest using
-	  QEMU's generic e500 machine.  This is not required if you're
+	  QEMU's generic e500 machine.	This is not required if you're
 	  using a QEMU machine that targets a specific board, such as
 	  mpc8544ds.
 
@@ -270,6 +270,7 @@ config CORENET_GENERIC
 	select GPIO_MPC8XXX
 	select HAS_RAPIDIO
 	select PPC_EPAPR_HV_PIC
+	select HAS_FSL_QBMAN
 	help
 	  This option enables support for the FSL CoreNet based boards.
 	  For 32bit kernel, the following boards are supported:
diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index 63bef30..74faab7 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -5,8 +5,8 @@
  *
  * Copyright 2009-2011 Freescale Semiconductor Inc.
  *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
+ * This program is free software; you can redistribute	it and/or modify it
+ * under  the terms of	the GNU General	 Public License as published by the
  * Free Software Foundation;  either version 2 of the  License, or (at your
  * option) any later version.
  */
@@ -197,6 +197,21 @@ static int __init corenet_generic_probe(void)
 	return 0;
 }
 
+/* Early setup is required for large chunks of contiguous (and coarsely-aligned)
+ * memory. The following shoe-horns Bman "init_early" calls into the
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
@@ -215,6 +230,7 @@ define_machine(corenet_generic) {
 #else
 	.power_save		= e500_idle,
 #endif
+	.init_early		= corenet_ds_init_early,
 };
 
 machine_arch_initcall(corenet_generic, corenet_gen_publish_devices);
diff --git a/arch/powerpc/platforms/85xx/p1023_rdb.c b/arch/powerpc/platforms/85xx/p1023_rdb.c
index d5b7509..624d3d6 100644
--- a/arch/powerpc/platforms/85xx/p1023_rdb.c
+++ b/arch/powerpc/platforms/85xx/p1023_rdb.c
@@ -6,8 +6,8 @@
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
+ * memory. The following shoe-horns Bman "init_early" calls into the
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
2.2.2
