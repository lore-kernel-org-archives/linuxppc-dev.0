Return-Path: <suzuki@in.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id C7626100803
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2011 19:57:23 +1100 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Thu, 15 Dec 2011 14:27:20 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pBF8vIYN3223710
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2011 14:27:18 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pBF8vGp6031594
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2011 14:27:17 +0530
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH v5 1/7] [booke] Rename mapping based RELOCATABLE to
 DYNAMIC_MEMSTART for BookE
To: Josh Boyer <jwboyer@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 15 Dec 2011 14:27:15 +0530
Message-ID: <20111215085651.3404.17057.stgit@suzukikp.in.ibm.com>
In-Reply-To: <20111215085516.3404.56377.stgit@suzukikp.in.ibm.com>
References: <20111215085516.3404.56377.stgit@suzukikp.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Scott Wood <scottwood@freescale.com>,
 Josh Poimboeuf <jpoimboe@linux.vnet.ibm.com>,
 linux ppc dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The current implementation of CONFIG_RELOCATABLE in BookE is based
on mapping the page aligned kernel load address to KERNELBASE. This
approach however is not enough for platforms, where the TLB page size
is large (e.g, 256M on 44x). So we are renaming the RELOCATABLE used
currently in BookE to DYNAMIC_MEMSTART to reflect the actual method.

The CONFIG_RELOCATABLE for PPC32(BookE) based on processing of the
dynamic relocations will be introduced in the later in the patch series.

This change would allow the use of the old method of RELOCATABLE for
platforms which can afford to enforce the page alignment (platforms with
smaller TLB size).

Changes since v3:

* Introduced a new config, NONSTATIC_KERNEL, to denote a kernel which is
  either a RELOCATABLE or DYNAMIC_MEMSTART(Suggested by: Josh Boyer)

Suggested-by: Scott Wood <scottwood@freescale.com>
Tested-by: Scott Wood <scottwood@freescale.com>

Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
Cc: Scott Wood <scottwood@freescale.com>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: Josh Boyer <jwboyer@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux ppc dev <linuxppc-dev@lists.ozlabs.org>
---

 arch/powerpc/Kconfig                          |   60 +++++++++++++++++--------
 arch/powerpc/configs/44x/iss476-smp_defconfig |    3 +
 arch/powerpc/include/asm/kdump.h              |    4 +-
 arch/powerpc/include/asm/page.h               |    4 +-
 arch/powerpc/kernel/crash_dump.c              |    4 +-
 arch/powerpc/kernel/head_44x.S                |    4 +-
 arch/powerpc/kernel/head_fsl_booke.S          |    2 -
 arch/powerpc/kernel/machine_kexec.c           |    2 -
 arch/powerpc/kernel/prom_init.c               |    2 -
 arch/powerpc/mm/44x_mmu.c                     |    2 -
 10 files changed, 56 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 7c93c7e..fac92ce 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -364,7 +364,8 @@ config KEXEC
 config CRASH_DUMP
 	bool "Build a kdump crash kernel"
 	depends on PPC64 || 6xx || FSL_BOOKE
-	select RELOCATABLE if PPC64 || FSL_BOOKE
+	select RELOCATABLE if PPC64
+	select DYNAMIC_MEMSTART if FSL_BOOKE
 	help
 	  Build a kernel suitable for use as a kdump capture kernel.
 	  The same kernel binary can be used as production kernel and dump
@@ -773,6 +774,10 @@ source "drivers/rapidio/Kconfig"
 
 endmenu
 
+config NONSTATIC_KERNEL
+	bool
+	default n
+
 menu "Advanced setup"
 	depends on PPC32
 
@@ -822,23 +827,39 @@ config LOWMEM_CAM_NUM
 	int "Number of CAMs to use to map low memory" if LOWMEM_CAM_NUM_BOOL
 	default 3
 
-config RELOCATABLE
-	bool "Build a relocatable kernel (EXPERIMENTAL)"
+config DYNAMIC_MEMSTART
+	bool "Enable page aligned dynamic load address for kernel (EXPERIMENTAL)"
 	depends on EXPERIMENTAL && ADVANCED_OPTIONS && FLATMEM && (FSL_BOOKE || PPC_47x)
-	help
-	  This builds a kernel image that is capable of running at the
-	  location the kernel is loaded at (some alignment restrictions may
-	  exist).
-
-	  One use is for the kexec on panic case where the recovery kernel
-	  must live at a different physical address than the primary
-	  kernel.
-
-	  Note: If CONFIG_RELOCATABLE=y, then the kernel runs from the address
-	  it has been loaded at and the compile time physical addresses
-	  CONFIG_PHYSICAL_START is ignored.  However CONFIG_PHYSICAL_START
-	  setting can still be useful to bootwrappers that need to know the
-	  load location of the kernel (eg. u-boot/mkimage).
+	select NONSTATIC_KERNEL
+	help
+	  This option enables the kernel to be loaded at any page aligned
+	  physical address. The kernel creates a mapping from KERNELBASE to 
+	  the address where the kernel is loaded. The page size here implies
+	  the TLB page size of the mapping for kernel on the particular platform.
+	  Please refer to the init code for finding the TLB page size.
+
+	  DYNAMIC_MEMSTART is an easy way of implementing pseudo-RELOCATABLE
+	  kernel image, where the only restriction is the page aligned kernel
+	  load address. When this option is enabled, the compile time physical 
+	  address CONFIG_PHYSICAL_START is ignored.
+
+# Mapping based RELOCATABLE is moved to DYNAMIC_MEMSTART
+# config RELOCATABLE
+#	bool "Build a relocatable kernel (EXPERIMENTAL)"
+#	depends on EXPERIMENTAL && ADVANCED_OPTIONS && FLATMEM && (FSL_BOOKE || PPC_47x)
+#	help
+#	  This builds a kernel image that is capable of running at the
+#	  location the kernel is loaded at, without any alignment restrictions.
+#
+#	  One use is for the kexec on panic case where the recovery kernel
+#	  must live at a different physical address than the primary
+#	  kernel.
+#
+#	  Note: If CONFIG_RELOCATABLE=y, then the kernel runs from the address
+#	  it has been loaded at and the compile time physical addresses
+#	  CONFIG_PHYSICAL_START is ignored.  However CONFIG_PHYSICAL_START
+#	  setting can still be useful to bootwrappers that need to know the
+#	  load location of the kernel (eg. u-boot/mkimage).
 
 config PAGE_OFFSET_BOOL
 	bool "Set custom page offset address"
@@ -868,7 +889,7 @@ config KERNEL_START_BOOL
 config KERNEL_START
 	hex "Virtual address of kernel base" if KERNEL_START_BOOL
 	default PAGE_OFFSET if PAGE_OFFSET_BOOL
-	default "0xc2000000" if CRASH_DUMP && !RELOCATABLE
+	default "0xc2000000" if CRASH_DUMP && !NONSTATIC_KERNEL
 	default "0xc0000000"
 
 config PHYSICAL_START_BOOL
@@ -881,7 +902,7 @@ config PHYSICAL_START_BOOL
 
 config PHYSICAL_START
 	hex "Physical address where the kernel is loaded" if PHYSICAL_START_BOOL
-	default "0x02000000" if PPC_STD_MMU && CRASH_DUMP && !RELOCATABLE
+	default "0x02000000" if PPC_STD_MMU && CRASH_DUMP && !NONSTATIC_KERNEL
 	default "0x00000000"
 
 config PHYSICAL_ALIGN
@@ -927,6 +948,7 @@ endmenu
 if PPC64
 config RELOCATABLE
 	bool "Build a relocatable kernel"
+	select NONSTATIC_KERNEL
 	help
 	  This builds a kernel image that is capable of running anywhere
 	  in the RMA (real memory area) at any 16k-aligned base address.
diff --git a/arch/powerpc/configs/44x/iss476-smp_defconfig b/arch/powerpc/configs/44x/iss476-smp_defconfig
index a6eb6ad..ca00cf7 100644
--- a/arch/powerpc/configs/44x/iss476-smp_defconfig
+++ b/arch/powerpc/configs/44x/iss476-smp_defconfig
@@ -25,7 +25,8 @@ CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="root=/dev/issblk0"
 # CONFIG_PCI is not set
 CONFIG_ADVANCED_OPTIONS=y
-CONFIG_RELOCATABLE=y
+CONFIG_NONSTATIC_KERNEL=y
+CONFIG_DYNAMIC_MEMSTART=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
diff --git a/arch/powerpc/include/asm/kdump.h b/arch/powerpc/include/asm/kdump.h
index bffd062..c977620 100644
--- a/arch/powerpc/include/asm/kdump.h
+++ b/arch/powerpc/include/asm/kdump.h
@@ -32,11 +32,11 @@
 
 #ifndef __ASSEMBLY__
 
-#if defined(CONFIG_CRASH_DUMP) && !defined(CONFIG_RELOCATABLE)
+#if defined(CONFIG_CRASH_DUMP) && !defined(CONFIG_NONSTATIC_KERNEL)
 extern void reserve_kdump_trampoline(void);
 extern void setup_kdump_trampoline(void);
 #else
-/* !CRASH_DUMP || RELOCATABLE */
+/* !CRASH_DUMP || !NONSTATIC_KERNEL */
 static inline void reserve_kdump_trampoline(void) { ; }
 static inline void setup_kdump_trampoline(void) { ; }
 #endif
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 9d7485c..f149967 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -92,7 +92,7 @@ extern unsigned int HPAGE_SHIFT;
 #define PAGE_OFFSET	ASM_CONST(CONFIG_PAGE_OFFSET)
 #define LOAD_OFFSET	ASM_CONST((CONFIG_KERNEL_START-CONFIG_PHYSICAL_START))
 
-#if defined(CONFIG_RELOCATABLE)
+#if defined(CONFIG_NONSTATIC_KERNEL)
 #ifndef __ASSEMBLY__
 
 extern phys_addr_t memstart_addr;
@@ -105,7 +105,7 @@ extern phys_addr_t kernstart_addr;
 
 #ifdef CONFIG_PPC64
 #define MEMORY_START	0UL
-#elif defined(CONFIG_RELOCATABLE)
+#elif defined(CONFIG_NONSTATIC_KERNEL)
 #define MEMORY_START	memstart_addr
 #else
 #define MEMORY_START	(PHYSICAL_START + PAGE_OFFSET - KERNELBASE)
diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash_dump.c
index 424afb6..b3ba516 100644
--- a/arch/powerpc/kernel/crash_dump.c
+++ b/arch/powerpc/kernel/crash_dump.c
@@ -28,7 +28,7 @@
 #define DBG(fmt...)
 #endif
 
-#ifndef CONFIG_RELOCATABLE
+#ifndef CONFIG_NONSTATIC_KERNEL
 void __init reserve_kdump_trampoline(void)
 {
 	memblock_reserve(0, KDUMP_RESERVE_LIMIT);
@@ -67,7 +67,7 @@ void __init setup_kdump_trampoline(void)
 
 	DBG(" <- setup_kdump_trampoline()\n");
 }
-#endif /* CONFIG_RELOCATABLE */
+#endif /* CONFIG_NONSTATIC_KERNEL */
 
 static int __init parse_savemaxmem(char *p)
 {
diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index b725dab..3df7735 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -86,8 +86,10 @@ _ENTRY(_start);
 
 	bl	early_init
 
-#ifdef CONFIG_RELOCATABLE
+#ifdef CONFIG_DYNAMIC_MEMSTART
 	/*
+	 * Mapping based, page aligned dynamic kernel loading.
+	 *
 	 * r25 will contain RPN/ERPN for the start address of memory
 	 *
 	 * Add the difference between KERNELBASE and PAGE_OFFSET to the
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 9f5d210..d5d78c4 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -197,7 +197,7 @@ _ENTRY(__early_start)
 
 	bl	early_init
 
-#ifdef CONFIG_RELOCATABLE
+#ifdef CONFIG_DYNAMIC_MEMSTART
 	lis	r3,kernstart_addr@ha
 	la	r3,kernstart_addr@l(r3)
 #ifdef CONFIG_PHYS_64BIT
diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
index 9ce1672..ec50bb9 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -128,7 +128,7 @@ void __init reserve_crashkernel(void)
 
 	crash_size = resource_size(&crashk_res);
 
-#ifndef CONFIG_RELOCATABLE
+#ifndef CONFIG_NONSTATIC_KERNEL
 	if (crashk_res.start != KDUMP_KERNELBASE)
 		printk("Crash kernel location must be 0x%x\n",
 				KDUMP_KERNELBASE);
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index df47316..6e63b20 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -2844,7 +2844,7 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
 	RELOC(of_platform) = prom_find_machine_type();
 	prom_printf("Detected machine type: %x\n", RELOC(of_platform));
 
-#ifndef CONFIG_RELOCATABLE
+#ifndef CONFIG_NONSTATIC_KERNEL
 	/* Bail if this is a kdump kernel. */
 	if (PHYSICAL_START > 0)
 		prom_panic("Error: You can't boot a kdump kernel from OF!\n");
diff --git a/arch/powerpc/mm/44x_mmu.c b/arch/powerpc/mm/44x_mmu.c
index f60e006..924a258 100644
--- a/arch/powerpc/mm/44x_mmu.c
+++ b/arch/powerpc/mm/44x_mmu.c
@@ -221,7 +221,7 @@ void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 {
 	u64 size;
 
-#ifndef CONFIG_RELOCATABLE
+#ifndef CONFIG_NONSTATIC_KERNEL
 	/* We don't currently support the first MEMBLOCK not mapping 0
 	 * physical on those processors
 	 */
