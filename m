Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CC1F3DDF2E
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 23:09:20 +1000 (EST)
Date: Wed, 23 Apr 2008 08:05:20 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH v2] [POWERPC] Port fixmap from x86 and use for kmap_atomic
Message-ID: <Pine.LNX.4.64.0804230805040.15797@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The fixmap code from x86 allows us to have compile time virtual addresses
that we change the physical addresses of at run time.

This is useful for applications like kmap_atomic, PCI config that is done
via direct memory map, kexec/kdump.

We got ride of CONFIG_HIGHMEM_START as we can now determine a more optimal
location for PKMAP_BASE based on where the fixmap addresses start and
working back from there.

Additionally, the kmap code in asm-powerpc/highmem.h always had debug
enabled.  Moved to using CONFIG_DEBUG_HIGHMEM to determine if we should
have the extra debug checking.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

Removed __FIXADDR_TOP, __FIXADDR_BOOT_SIZE, and FIXADDR_BOOT_START
as they were duplicates of other defines and held over from the initial
x86 port.

- k

 arch/powerpc/Kconfig          |   14 -----
 arch/powerpc/mm/init_32.c     |    8 ---
 arch/powerpc/mm/mem.c         |   32 ++++++++++--
 arch/powerpc/mm/pgtable_32.c  |   23 +++++++++
 include/asm-powerpc/fixmap.h  |  108 +++++++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/highmem.h |   41 ++++++++-------
 6 files changed, 179 insertions(+), 47 deletions(-)
 create mode 100644 include/asm-powerpc/fixmap.h

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index fdc755a..20f45a8 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -626,20 +626,6 @@ config ADVANCED_OPTIONS
 comment "Default settings for advanced configuration options are used"
 	depends on !ADVANCED_OPTIONS

-config HIGHMEM_START_BOOL
-	bool "Set high memory pool address"
-	depends on ADVANCED_OPTIONS && HIGHMEM
-	help
-	  This option allows you to set the base address of the kernel virtual
-	  area used to map high memory pages.  This can be useful in
-	  optimizing the layout of kernel virtual memory.
-
-	  Say N here unless you know what you are doing.
-
-config HIGHMEM_START
-	hex "Virtual start address of high memory pool" if HIGHMEM_START_BOOL
-	default "0xfe000000"
-
 config LOWMEM_SIZE_BOOL
 	bool "Set maximum low memory"
 	depends on ADVANCED_OPTIONS
diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 578750e..1952b4d 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -71,14 +71,6 @@ unsigned long agp_special_page;
 EXPORT_SYMBOL(agp_special_page);
 #endif

-#ifdef CONFIG_HIGHMEM
-pte_t *kmap_pte;
-pgprot_t kmap_prot;
-
-EXPORT_SYMBOL(kmap_prot);
-EXPORT_SYMBOL(kmap_pte);
-#endif
-
 void MMU_init(void);

 /* XXX should be in current.h  -- paulus */
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 0062e6b..5ccb579 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -45,6 +45,7 @@
 #include <asm/tlb.h>
 #include <asm/sections.h>
 #include <asm/vdso.h>
+#include <asm/fixmap.h>

 #include "mmu_decl.h"

@@ -57,6 +58,20 @@ int init_bootmem_done;
 int mem_init_done;
 unsigned long memory_limit;

+#ifdef CONFIG_HIGHMEM
+pte_t *kmap_pte;
+pgprot_t kmap_prot;
+
+EXPORT_SYMBOL(kmap_prot);
+EXPORT_SYMBOL(kmap_pte);
+
+static inline pte_t *virt_to_kpte(unsigned long vaddr)
+{
+	return pte_offset_kernel(pmd_offset(pud_offset(pgd_offset_k(vaddr),
+			vaddr), vaddr), vaddr);
+}
+#endif
+
 int page_is_ram(unsigned long pfn)
 {
 	unsigned long paddr = (pfn << PAGE_SHIFT);
@@ -311,14 +326,19 @@ void __init paging_init(void)
 	unsigned long top_of_ram = lmb_end_of_DRAM();
 	unsigned long max_zone_pfns[MAX_NR_ZONES];

+#ifdef CONFIG_PPC32
+	unsigned long v = __fix_to_virt(__end_of_fixed_addresses - 1);
+	unsigned long end = __fix_to_virt(FIX_HOLE);
+
+	for (; v < end; v += PAGE_SIZE)
+		map_page(v, 0, 0); /* XXX gross */
+#endif
+
 #ifdef CONFIG_HIGHMEM
 	map_page(PKMAP_BASE, 0, 0);	/* XXX gross */
-	pkmap_page_table = pte_offset_kernel(pmd_offset(pud_offset(pgd_offset_k
-			(PKMAP_BASE), PKMAP_BASE), PKMAP_BASE), PKMAP_BASE);
-	map_page(KMAP_FIX_BEGIN, 0, 0);	/* XXX gross */
-	kmap_pte = pte_offset_kernel(pmd_offset(pud_offset(pgd_offset_k
-			(KMAP_FIX_BEGIN), KMAP_FIX_BEGIN), KMAP_FIX_BEGIN),
-			 KMAP_FIX_BEGIN);
+	pkmap_page_table = virt_to_kpte(PKMAP_BASE);
+
+	kmap_pte = virt_to_kpte(__fix_to_virt(FIX_KMAP_BEGIN));
 	kmap_prot = PAGE_KERNEL;
 #endif /* CONFIG_HIGHMEM */

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 64c44bc..80d1bab 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -29,6 +29,7 @@

 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
+#include <asm/fixmap.h>
 #include <asm/io.h>

 #include "mmu_decl.h"
@@ -387,3 +388,25 @@ void kernel_map_pages(struct page *page, int numpages, int enable)
 	change_page_attr(page, numpages, enable ? PAGE_KERNEL : __pgprot(0));
 }
 #endif /* CONFIG_DEBUG_PAGEALLOC */
+
+static int fixmaps;
+unsigned long FIXADDR_TOP = 0xfffff000;
+EXPORT_SYMBOL(FIXADDR_TOP);
+
+void __set_fixmap (enum fixed_addresses idx, phys_addr_t phys, pgprot_t flags)
+{
+	unsigned long address = __fix_to_virt(idx);
+
+	if (idx >= __end_of_fixed_addresses) {
+		BUG();
+		return;
+	}
+
+	map_page(address, phys, flags);
+	fixmaps++;
+}
+
+void __this_fixmap_does_not_exist(void)
+{
+	WARN_ON(1);
+}
diff --git a/include/asm-powerpc/fixmap.h b/include/asm-powerpc/fixmap.h
new file mode 100644
index 0000000..974b6de
--- /dev/null
+++ b/include/asm-powerpc/fixmap.h
@@ -0,0 +1,108 @@
+/*
+ * fixmap.h: compile-time virtual memory allocation
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1998 Ingo Molnar
+ *
+ * Support of BIGMEM added by Gerhard Wichert, Siemens AG, July 1999
+ *
+ * Copyright 2008 Freescale Semiconductor Inc.
+ *   Port to powerpc added by Kumar Gala
+ */
+
+#ifndef _ASM_FIXMAP_H
+#define _ASM_FIXMAP_H
+
+extern unsigned long FIXADDR_TOP;
+
+#ifndef __ASSEMBLY__
+#include <linux/kernel.h>
+#include <asm/page.h>
+#ifdef CONFIG_HIGHMEM
+#include <linux/threads.h>
+#include <asm/kmap_types.h>
+#endif
+
+/*
+ * Here we define all the compile-time 'special' virtual
+ * addresses. The point is to have a constant address at
+ * compile time, but to set the physical address only
+ * in the boot process. We allocate these special addresses
+ * from the end of virtual memory (0xfffff000) backwards.
+ * Also this lets us do fail-safe vmalloc(), we
+ * can guarantee that these special addresses and
+ * vmalloc()-ed addresses never overlap.
+ *
+ * these 'compile-time allocated' memory buffers are
+ * fixed-size 4k pages. (or larger if used with an increment
+ * highger than 1) use fixmap_set(idx,phys) to associate
+ * physical memory with fixmap indices.
+ *
+ * TLB entries of such buffers will not be flushed across
+ * task switches.
+ */
+enum fixed_addresses {
+	FIX_HOLE,
+#ifdef CONFIG_HIGHMEM
+	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
+	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
+#endif
+	/* FIX_PCIE_MCFG, */
+	__end_of_fixed_addresses
+};
+
+extern void __set_fixmap (enum fixed_addresses idx,
+					phys_addr_t phys, pgprot_t flags);
+
+#define set_fixmap(idx, phys) \
+		__set_fixmap(idx, phys, PAGE_KERNEL)
+/*
+ * Some hardware wants to get fixmapped without caching.
+ */
+#define set_fixmap_nocache(idx, phys) \
+		__set_fixmap(idx, phys, PAGE_KERNEL_NOCACHE)
+
+#define clear_fixmap(idx) \
+		__set_fixmap(idx, 0, __pgprot(0))
+
+#define __FIXADDR_SIZE	(__end_of_fixed_addresses << PAGE_SHIFT)
+#define FIXADDR_START		(FIXADDR_TOP - __FIXADDR_SIZE)
+
+#define __fix_to_virt(x)	(FIXADDR_TOP - ((x) << PAGE_SHIFT))
+#define __virt_to_fix(x)	((FIXADDR_TOP - ((x)&PAGE_MASK)) >> PAGE_SHIFT)
+
+extern void __this_fixmap_does_not_exist(void);
+
+/*
+ * 'index to address' translation. If anyone tries to use the idx
+ * directly without tranlation, we catch the bug with a NULL-deference
+ * kernel oops. Illegal ranges of incoming indices are caught too.
+ */
+static __always_inline unsigned long fix_to_virt(const unsigned int idx)
+{
+	/*
+	 * this branch gets completely eliminated after inlining,
+	 * except when someone tries to use fixaddr indices in an
+	 * illegal way. (such as mixing up address types or using
+	 * out-of-range indices).
+	 *
+	 * If it doesn't get removed, the linker will complain
+	 * loudly with a reasonably clear error message..
+	 */
+	if (idx >= __end_of_fixed_addresses)
+		__this_fixmap_does_not_exist();
+
+        return __fix_to_virt(idx);
+}
+
+static inline unsigned long virt_to_fix(const unsigned long vaddr)
+{
+	BUG_ON(vaddr >= FIXADDR_TOP || vaddr < FIXADDR_START);
+	return __virt_to_fix(vaddr);
+}
+
+#endif /* !__ASSEMBLY__ */
+#endif
diff --git a/include/asm-powerpc/highmem.h b/include/asm-powerpc/highmem.h
index f7b21ee..5d99b64 100644
--- a/include/asm-powerpc/highmem.h
+++ b/include/asm-powerpc/highmem.h
@@ -27,9 +27,7 @@
 #include <asm/kmap_types.h>
 #include <asm/tlbflush.h>
 #include <asm/page.h>
-
-/* undef for production */
-#define HIGHMEM_DEBUG 1
+#include <asm/fixmap.h>

 extern pte_t *kmap_pte;
 extern pgprot_t kmap_prot;
@@ -40,14 +38,12 @@ extern pte_t *pkmap_page_table;
  * easily, subsequent pte tables have to be allocated in one physical
  * chunk of RAM.
  */
-#define PKMAP_BASE 	CONFIG_HIGHMEM_START
 #define LAST_PKMAP 	(1 << PTE_SHIFT)
 #define LAST_PKMAP_MASK (LAST_PKMAP-1)
+#define PKMAP_BASE	((FIXADDR_START - PAGE_SIZE*(LAST_PKMAP + 1)) & PMD_MASK)
 #define PKMAP_NR(virt)  ((virt-PKMAP_BASE) >> PAGE_SHIFT)
 #define PKMAP_ADDR(nr)  (PKMAP_BASE + ((nr) << PAGE_SHIFT))

-#define KMAP_FIX_BEGIN	(PKMAP_BASE + 0x00400000UL)
-
 extern void *kmap_high(struct page *page);
 extern void kunmap_high(struct page *page);

@@ -73,7 +69,7 @@ static inline void kunmap(struct page *page)
  * be used in IRQ contexts, so in some (very limited) cases we need
  * it.
  */
-static inline void *kmap_atomic(struct page *page, enum km_type type)
+static inline void *kmap_atomic_prot(struct page *page, enum km_type type, pgprot_t prot)
 {
 	unsigned int idx;
 	unsigned long vaddr;
@@ -84,34 +80,39 @@ static inline void *kmap_atomic(struct page *page, enum km_type type)
 		return page_address(page);

 	idx = type + KM_TYPE_NR*smp_processor_id();
-	vaddr = KMAP_FIX_BEGIN + idx * PAGE_SIZE;
-#ifdef HIGHMEM_DEBUG
-	BUG_ON(!pte_none(*(kmap_pte+idx)));
+	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
+#ifdef CONFIG_DEBUG_HIGHMEM
+	BUG_ON(!pte_none(*(kmap_pte-idx)));
 #endif
-	set_pte_at(&init_mm, vaddr, kmap_pte+idx, mk_pte(page, kmap_prot));
+	set_pte_at(&init_mm, vaddr, kmap_pte-idx, mk_pte(page, prot));
 	flush_tlb_page(NULL, vaddr);

 	return (void*) vaddr;
 }

+static inline void *kmap_atomic(struct page *page, enum km_type type)
+{
+	return kmap_atomic_prot(page, type, kmap_prot);
+}
+
 static inline void kunmap_atomic(void *kvaddr, enum km_type type)
 {
-#ifdef HIGHMEM_DEBUG
+#ifdef CONFIG_DEBUG_HIGHMEM
 	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
-	unsigned int idx = type + KM_TYPE_NR*smp_processor_id();
+	enum fixed_addresses idx = type + KM_TYPE_NR*smp_processor_id();

-	if (vaddr < KMAP_FIX_BEGIN) { // FIXME
+	if (vaddr < __fix_to_virt(FIX_KMAP_END)) {
 		pagefault_enable();
 		return;
 	}

-	BUG_ON(vaddr != KMAP_FIX_BEGIN + idx * PAGE_SIZE);
+	BUG_ON(vaddr != __fix_to_virt(FIX_KMAP_BEGIN + idx));

 	/*
 	 * force other mappings to Oops if they'll try to access
 	 * this pte without first remap it
 	 */
-	pte_clear(&init_mm, vaddr, kmap_pte+idx);
+	pte_clear(&init_mm, vaddr, kmap_pte-idx);
 	flush_tlb_page(NULL, vaddr);
 #endif
 	pagefault_enable();
@@ -120,12 +121,14 @@ static inline void kunmap_atomic(void *kvaddr, enum km_type type)
 static inline struct page *kmap_atomic_to_page(void *ptr)
 {
 	unsigned long idx, vaddr = (unsigned long) ptr;
+	pte_t *pte;

-	if (vaddr < KMAP_FIX_BEGIN)
+	if (vaddr < FIXADDR_START)
 		return virt_to_page(ptr);

-	idx = (vaddr - KMAP_FIX_BEGIN) >> PAGE_SHIFT;
-	return pte_page(kmap_pte[idx]);
+	idx = virt_to_fix(vaddr);
+	pte = kmap_pte - (idx - FIX_KMAP_BEGIN);
+	return pte_page(*pte);
 }

 #define flush_cache_kmaps()	flush_cache_all()
-- 
1.5.4.1
