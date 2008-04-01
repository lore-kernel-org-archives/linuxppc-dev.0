Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1745BDDF1B
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 12:12:48 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: paulus@samba.org
Subject: [PATCH 11/11] [POWERPC] 85xx: Add support for relocatble kernel (and
	booting at non-zero)
Date: Mon, 31 Mar 2008 21:08:35 -0500
Message-Id: <1207015715-31496-12-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1207015715-31496-11-git-send-email-galak@kernel.crashing.org>
References: <1207015715-31496-1-git-send-email-galak@kernel.crashing.org>
	<1207015715-31496-2-git-send-email-galak@kernel.crashing.org>
	<1207015715-31496-3-git-send-email-galak@kernel.crashing.org>
	<1207015715-31496-4-git-send-email-galak@kernel.crashing.org>
	<1207015715-31496-5-git-send-email-galak@kernel.crashing.org>
	<1207015715-31496-6-git-send-email-galak@kernel.crashing.org>
	<1207015715-31496-7-git-send-email-galak@kernel.crashing.org>
	<1207015715-31496-8-git-send-email-galak@kernel.crashing.org>
	<1207015715-31496-9-git-send-email-galak@kernel.crashing.org>
	<1207015715-31496-10-git-send-email-galak@kernel.crashing.org>
	<1207015715-31496-11-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Added support to allow an 85xx kernel to be run from a non-zero physical
address (useful for cooperative asymmetric multiprocessing situations) and
kdump.  The support can either be at compile time or runtime
(CONFIG_RELOCATABLE).

Currently we are limited to running at a physical address that is module
256M.  This is due to how we map TLBs to cover lowmem and should be fixed
up to allow 64M or maybe even 16M alignment in the future.

All the magic for this support is accomplished by proper initializating
of the kernel memory subsystem properly and ARCH_PFN_OFFSET.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/Kconfig                 |   69 ++++++++++++++++++++++++++++++++-
 arch/powerpc/boot/Makefile           |    4 +-
 arch/powerpc/kernel/head_fsl_booke.S |   11 +++++
 arch/powerpc/kernel/prom.c           |    4 ++
 arch/powerpc/kernel/setup_64.c       |    2 +-
 arch/powerpc/mm/init_32.c            |    4 +-
 arch/powerpc/mm/init_64.c            |    3 +-
 arch/powerpc/mm/mem.c                |    5 +-
 include/asm-powerpc/kdump.h          |    5 --
 include/asm-powerpc/page.h           |   43 +++++++++++++++++---
 include/asm-powerpc/page_32.h        |    6 +++
 include/asm-powerpc/pgtable-ppc32.h  |    5 +--
 12 files changed, 135 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 4d9ced2..42c22f7 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -619,21 +619,76 @@ config LOWMEM_SIZE
 	hex "Maximum low memory size (in bytes)" if LOWMEM_SIZE_BOOL
 	default "0x30000000"
 
+config RELOCATABLE
+	bool "Build a relocatable kernel (EXPERIMENTAL)"
+	depends on EXPERIMENTAL && ADVANCED_OPTIONS && FLATMEM && FSL_BOOKE
+	help
+	  This builds a kernel image that is capable of running at the
+	  location the kernel is loaded at (some alignment restrictions may
+	  exist).
+
+	  One use is for the kexec on panic case where the recovery kernel
+	  must live at a different physical address than the primary
+	  kernel.
+
+	  Note: If CONFIG_RELOCATABLE=y, then the kernel runs from the address
+	  it has been loaded at and the compile time physical addresses
+	  CONFIG_PHYSICAL_START is ignored.  However CONFIG_PHYSICAL_START
+	  setting can still be useful to bootwrappers that need to know the
+	  load location of the kernel (eg. u-boot/mkimage).
+
+config PAGE_OFFSET_BOOL
+	bool "Set custom page offset address"
+	depends on ADVANCED_OPTIONS
+	help
+	  This option allows you to set the kernel virtual address at which
+	  the kernel will map low memory.  This can be useful in optimizing
+	  the virtual memory layout of the system.
+
+	  Say N here unless you know what you are doing.
+
+config PAGE_OFFSET
+	hex "Virtual address of memory base" if PAGE_OFFSET_BOOL
+	default "0xc0000000"
+
 config KERNEL_START_BOOL
 	bool "Set custom kernel base address"
 	depends on ADVANCED_OPTIONS
 	help
 	  This option allows you to set the kernel virtual address at which
-	  the kernel will map low memory (the kernel image will be linked at
-	  this address).  This can be useful in optimizing the virtual memory
-	  layout of the system.
+	  the kernel will be loaded.  Normally this should match PAGE_OFFSET
+	  however there are times (like kdump) that one might not want them
+	  to be the same.
 
 	  Say N here unless you know what you are doing.
 
 config KERNEL_START
 	hex "Virtual address of kernel base" if KERNEL_START_BOOL
+	default PAGE_OFFSET if PAGE_OFFSET_BOOL
+	default "0xc2000000" if CRASH_DUMP
 	default "0xc0000000"
 
+config PHYSICAL_START_BOOL
+	bool "Set physical address where the kernel is loaded"
+	depends on ADVANCED_OPTIONS && FLATMEM && FSL_BOOKE
+	help
+	  This gives the physical address where the kernel is loaded.
+
+	  Say N here unless you know what you are doing.
+
+config PHYSICAL_START
+	hex "Physical address where the kernel is loaded" if PHYSICAL_START_BOOL
+	default "0x02000000" if PPC_STD_MMU && CRASH_DUMP
+	default "0x00000000"
+
+config PHYSICAL_ALIGN
+	hex
+	default "0x10000000" if FSL_BOOKE
+	help
+	  This value puts the alignment restrictions on physical address
+	  where kernel is loaded and run from. Kernel is compiled for an
+	  address which meets above alignment restriction.
+
 config TASK_SIZE_BOOL
 	bool "Set custom user task size"
 	depends on ADVANCED_OPTIONS
@@ -680,9 +735,17 @@ config PIN_TLB
 endmenu
 
 if PPC64
+config PAGE_OFFSET
+	hex
+	default "0xc000000000000000"
 config KERNEL_START
 	hex
+	default "0xc000000002000000" if CRASH_DUMP
 	default "0xc000000000000000"
+config PHYSICAL_START
+	hex
+	default "0x02000000" if CRASH_DUMP
+	default "0x00000000"
 endif
 
 source "net/Kconfig"
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 3c80858..c7c2a9d 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -35,8 +35,8 @@ endif
 
 BOOTCFLAGS	+= -I$(obj) -I$(srctree)/$(obj) -I$(srctree)/$(src)/libfdt
 
-ifdef CONFIG_MEMORY_START
-MEMBASE=$(CONFIG_MEMORY_START)
+ifdef CONFIG_PHYSICAL_START
+MEMBASE=$(CONFIG_PHYSICAL_START)
 else
 MEMBASE=0x00000000
 endif
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 9f40b3e..4d0336b 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -368,6 +368,17 @@ skpinv:	addi	r6,r6,1				/* Increment */
 
 	bl	early_init
 
+#ifdef CONFIG_RELOCATABLE
+	lis	r3,kernstart_addr@ha
+	la	r3,kernstart_addr@l(r3)
+#ifdef CONFIG_PHYS_64BIT
+	stw	r23,0(r3)
+	stw	r25,4(r3)
+#else
+	stw	r25,0(r3)
+#endif
+#endif
+
 	mfspr	r3,SPRN_TLB1CFG
 	andi.	r3,r3,0xfff
 	lis	r4,num_tlbcam_entries@ha
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 60ef7d1..988cbde 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -53,6 +53,7 @@
 #include <asm/pci-bridge.h>
 #include <asm/phyp_dump.h>
 #include <asm/kexec.h>
+#include <mm/mmu_decl.h>
 
 #ifdef DEBUG
 #define DBG(fmt...) printk(KERN_ERR fmt)
@@ -978,7 +979,10 @@ static int __init early_init_dt_scan_memory(unsigned long node,
 		}
 #endif
 		lmb_add(base, size);
+
+		memstart_addr = min((u64)memstart_addr, base);
 	}
+
 	return 0;
 }
 
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 0205d40..9087e7a 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -431,7 +431,7 @@ void __init setup_system(void)
 		printk("htab_address                  = 0x%p\n", htab_address);
 	printk("htab_hash_mask                = 0x%lx\n", htab_hash_mask);
 #if PHYSICAL_START > 0
-	printk("physical_start                = 0x%x\n", PHYSICAL_START);
+	printk("physical_start                = 0x%lx\n", PHYSICAL_START);
 #endif
 	printk("-----------------------------------------------------\n");
 
diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 2c72c39..4b97daa 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -59,8 +59,10 @@ DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 unsigned long total_memory;
 unsigned long total_lowmem;
 
-phys_addr_t memstart_addr;
+phys_addr_t memstart_addr = (phys_addr_t)~0ull;
 EXPORT_SYMBOL(memstart_addr);
+phys_addr_t kernstart_addr;
+EXPORT_SYMBOL(kernstart_addr);
 phys_addr_t lowmem_end_addr;
 
 int boot_mapsize;
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index f18b203..7fbbafd 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -75,7 +75,8 @@
 /* max amount of RAM to use */
 unsigned long __max_memory;
 
-phys_addr_t memstart_addr;
+phys_addr_t memstart_addr = ~0;
+phys_addr_t kernstart_addr;
 
 void free_initmem(void)
 {
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 9c10b14..3ec7814 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -217,7 +217,7 @@ void __init do_init_bootmem(void)
 	unsigned long total_pages;
 	int boot_mapsize;
 
-	max_pfn = lmb_end_of_DRAM() >> PAGE_SHIFT;
+	max_low_pfn = max_pfn = lmb_end_of_DRAM() >> PAGE_SHIFT;
 	total_pages = (lmb_end_of_DRAM() - memstart_addr) >> PAGE_SHIFT;
 #ifdef CONFIG_HIGHMEM
 	total_pages = total_lowmem >> PAGE_SHIFT;
@@ -233,7 +233,8 @@ void __init do_init_bootmem(void)
 
 	start = lmb_alloc(bootmap_pages << PAGE_SHIFT, PAGE_SIZE);
 
-	boot_mapsize = init_bootmem(start >> PAGE_SHIFT, total_pages);
+	min_low_pfn = MEMORY_START >> PAGE_SHIFT;
+	boot_mapsize = init_bootmem_node(NODE_DATA(0), start >> PAGE_SHIFT, min_low_pfn, max_low_pfn);
 
 	/* Add active regions with valid PFNs */
 	for (i = 0; i < lmb.memory.cnt; i++) {
diff --git a/include/asm-powerpc/kdump.h b/include/asm-powerpc/kdump.h
index 10e8eb1..f6c93c7 100644
--- a/include/asm-powerpc/kdump.h
+++ b/include/asm-powerpc/kdump.h
@@ -11,16 +11,11 @@
 
 #ifdef CONFIG_CRASH_DUMP
 
-#define PHYSICAL_START	KDUMP_KERNELBASE
 #define KDUMP_TRAMPOLINE_START	0x0100
 #define KDUMP_TRAMPOLINE_END	0x3000
 
 #define KDUMP_MIN_TCE_ENTRIES	2048
 
-#else /* !CONFIG_CRASH_DUMP */
-
-#define PHYSICAL_START	0x0
-
 #endif /* CONFIG_CRASH_DUMP */
 
 #ifndef __ASSEMBLY__
diff --git a/include/asm-powerpc/page.h b/include/asm-powerpc/page.h
index df47bbb..adf0591 100644
--- a/include/asm-powerpc/page.h
+++ b/include/asm-powerpc/page.h
@@ -12,6 +12,7 @@
 
 #include <asm/asm-compat.h>
 #include <asm/kdump.h>
+#include <asm/types.h>
 
 /*
  * On PPC32 page size is 4K. For PPC64 we support either 4K or 64K software
@@ -42,8 +43,23 @@
  *
  * The kdump dump kernel is one example where KERNELBASE != PAGE_OFFSET.
  *
- * To get a physical address from a virtual one you subtract PAGE_OFFSET,
- * _not_ KERNELBASE.
+ * PAGE_OFFSET is the virtual address of the start of lowmem.
+ *
+ * PHYSICAL_START is the physical address of the start of the kernel.
+ *
+ * MEMORY_START is the physical address of the start of lowmem.
+ *
+ * KERNELBASE, PAGE_OFFSET, and PHYSICAL_START are all configurable on
+ * ppc32 and based on how they are set we determine MEMORY_START.
+ *
+ * For the linear mapping the following equation should be true:
+ * KERNELBASE - PAGE_OFFSET = PHYSICAL_START - MEMORY_START
+ *
+ * Also, KERNELBASE >= PAGE_OFFSET and PHYSICAL_START >= MEMORY_START
+ *
+ * There are two was to determine a physical address from a virtual one:
+ * va = pa + PAGE_OFFSET - MEMORY_START
+ * va = pa + KERNELBASE - PHYSICAL_START
  *
  * If you want to know something's offset from the start of the kernel you
  * should subtract KERNELBASE.
@@ -51,19 +67,32 @@
  * If you want to test if something's a kernel address, use is_kernel_addr().
  */
 
-#define PAGE_OFFSET     ASM_CONST(CONFIG_KERNEL_START)
-#define KERNELBASE      (PAGE_OFFSET + PHYSICAL_START)
+#define KERNELBASE      ASM_CONST(CONFIG_KERNEL_START)
+#define PAGE_OFFSET	ASM_CONST(CONFIG_PAGE_OFFSET)
+
+#if defined(CONFIG_RELOCATABLE) && defined(CONFIG_FLATMEM)
+#ifndef __ASSEMBLY__
+extern phys_addr_t memstart_addr;
+extern phys_addr_t kernstart_addr;
+#endif
+#define PHYSICAL_START	kernstart_addr
+#define MEMORY_START	memstart_addr
+#else
+#define PHYSICAL_START	ASM_CONST(CONFIG_PHYSICAL_START)
+#define MEMORY_START	(PHYSICAL_START + PAGE_OFFSET - KERNELBASE)
+#endif
 
 #ifdef CONFIG_FLATMEM
-#define pfn_valid(pfn)		((pfn) < max_mapnr)
+#define ARCH_PFN_OFFSET		(MEMORY_START >> PAGE_SHIFT)
+#define pfn_valid(pfn)		((pfn) >= ARCH_PFN_OFFSET && (pfn) < (ARCH_PFN_OFFSET + max_mapnr))
 #endif
 
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
 #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
 
-#define __va(x) ((void *)((unsigned long)(x) + PAGE_OFFSET))
-#define __pa(x) ((unsigned long)(x) - PAGE_OFFSET)
+#define __va(x) ((void *)((unsigned long)(x) - PHYSICAL_START + KERNELBASE))
+#define __pa(x) ((unsigned long)(x) + PHYSICAL_START - KERNELBASE)
 
 /*
  * Unfortunately the PLT is in the BSS in the PPC32 ELF ABI,
diff --git a/include/asm-powerpc/page_32.h b/include/asm-powerpc/page_32.h
index 51f8134..ebfae53 100644
--- a/include/asm-powerpc/page_32.h
+++ b/include/asm-powerpc/page_32.h
@@ -1,6 +1,12 @@
 #ifndef _ASM_POWERPC_PAGE_32_H
 #define _ASM_POWERPC_PAGE_32_H
 
+#if defined(CONFIG_PHYSICAL_ALIGN) && (CONFIG_PHYSICAL_START != 0)
+#if (CONFIG_PHYSICAL_START % CONFIG_PHYSICAL_ALIGN) != 0
+#error "CONFIG_PHYSICAL_START must be a multiple of CONFIG_PHYSICAL_ALIGN"
+#endif
+#endif
+
 #define VM_DATA_DEFAULT_FLAGS	VM_DATA_DEFAULT_FLAGS32
 
 #ifdef CONFIG_NOT_COHERENT_CACHE
diff --git a/include/asm-powerpc/pgtable-ppc32.h b/include/asm-powerpc/pgtable-ppc32.h
index 2c79f55..dbd1875 100644
--- a/include/asm-powerpc/pgtable-ppc32.h
+++ b/include/asm-powerpc/pgtable-ppc32.h
@@ -98,9 +98,6 @@ extern int icache_44x_need_flush;
 #define USER_PTRS_PER_PGD	(TASK_SIZE / PGDIR_SIZE)
 #define FIRST_USER_ADDRESS	0
 
-#define USER_PGD_PTRS (PAGE_OFFSET >> PGDIR_SHIFT)
-#define KERNEL_PGD_PTRS (PTRS_PER_PGD-USER_PGD_PTRS)
-
 #define pte_ERROR(e) \
 	printk("%s:%d: bad pte %llx.\n", __FILE__, __LINE__, \
 		(unsigned long long)pte_val(e))
@@ -692,7 +689,7 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 #define pmd_page_vaddr(pmd)	\
 	((unsigned long) (pmd_val(pmd) & PAGE_MASK))
 #define pmd_page(pmd)		\
-	(mem_map + (__pa(pmd_val(pmd)) >> PAGE_SHIFT))
+	(mem_map + (__pa(pmd_val(pmd)) >> PAGE_SHIFT) - ARCH_PFN_OFFSET)
 #endif
 
 /* to find an entry in a kernel page-table-directory */
-- 
1.5.4.1
