Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wJ8b07jRzDr4N
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 01:50:22 +1000 (AEST)
Message-Id: <8f75a74b167f55844db88d317f580d0f271b4f66.1527608397.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1527608397.git.christophe.leroy@c-s.fr>
References: <cover.1527608397.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 02/14] powerpc: move io mapping functions into ioremap.c
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 29 May 2018 15:50:18 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch is the first of a serie that intends to make
io mappings common to PPC32 and PPC64.

It moves ioremap/unmap fonctions into a new file called ioremap.c with
no other modification to the functions.
For the time being, the PPC32 and PPC64 parts get enclosed into #ifdef.
Following patches will aim at making those functions as common as
possible between PPC32 and PPC64.

This patch also moves EXPORT_SYMBOL at the end of each function

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/Makefile                    |   2 +-
 arch/powerpc/mm/{pgtable_64.c => ioremap.c} | 313 +++++++++++++++-------------
 arch/powerpc/mm/pgtable_32.c                | 139 ------------
 arch/powerpc/mm/pgtable_64.c                | 177 ----------------
 4 files changed, 166 insertions(+), 465 deletions(-)
 copy arch/powerpc/mm/{pgtable_64.c => ioremap.c} (56%)

diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index f06f3577d8d1..22d54c1d90e1 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -9,7 +9,7 @@ ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
 
 obj-y				:= fault.o mem.o pgtable.o mmap.o \
 				   init_$(BITS).o pgtable_$(BITS).o \
-				   init-common.o mmu_context.o drmem.o
+				   init-common.o mmu_context.o drmem.o ioremap.o
 obj-$(CONFIG_PPC_MMU_NOHASH)	+= mmu_context_nohash.o tlb_nohash.o \
 				   tlb_nohash_low.o
 obj-$(CONFIG_PPC_BOOK3E)	+= tlb_low_$(BITS)e.o
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/ioremap.c
similarity index 56%
copy from arch/powerpc/mm/pgtable_64.c
copy to arch/powerpc/mm/ioremap.c
index 53e9eeecd5d4..0c8f6113e0f3 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/ioremap.c
@@ -1,109 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0
+
 /*
- *  This file contains ioremap and related functions for 64-bit machines.
- *
- *  Derived from arch/ppc64/mm/init.c
- *    Copyright (C) 1995-1996 Gary Thomas (gdt@linuxppc.org)
- *
- *  Modifications by Paul Mackerras (PowerMac) (paulus@samba.org)
- *  and Cort Dougan (PReP) (cort@cs.nmt.edu)
- *    Copyright (C) 1996 Paul Mackerras
- *
- *  Derived from "arch/i386/mm/init.c"
- *    Copyright (C) 1991, 1992, 1993, 1994  Linus Torvalds
+ * This file contains the routines for mapping IO areas
  *
- *  Dave Engebretsen <engebret@us.ibm.com>
- *      Rework for PPC64 port.
- *
- *  This program is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU General Public License
- *  as published by the Free Software Foundation; either version
- *  2 of the License, or (at your option) any later version.
+ *  Derived from arch/powerpc/mm/pgtable_32.c and
+ *  arch/powerpc/mm/pgtable_64.c
  *
  */
 
-#include <linux/signal.h>
-#include <linux/sched.h>
 #include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/string.h>
-#include <linux/export.h>
+#include <linux/module.h>
 #include <linux/types.h>
-#include <linux/mman.h>
 #include <linux/mm.h>
-#include <linux/swap.h>
-#include <linux/stddef.h>
 #include <linux/vmalloc.h>
+#include <linux/init.h>
+#include <linux/highmem.h>
+#include <linux/memblock.h>
 #include <linux/slab.h>
-#include <linux/hugetlb.h>
 
+#include <asm/pgtable.h>
 #include <asm/pgalloc.h>
-#include <asm/page.h>
-#include <asm/prom.h>
+#include <asm/fixmap.h>
 #include <asm/io.h>
-#include <asm/mmu_context.h>
-#include <asm/pgtable.h>
-#include <asm/mmu.h>
-#include <asm/smp.h>
-#include <asm/machdep.h>
-#include <asm/tlb.h>
-#include <asm/processor.h>
-#include <asm/cputable.h>
+#include <asm/setup.h>
 #include <asm/sections.h>
-#include <asm/firmware.h>
-#include <asm/dma.h>
+#include <asm/machdep.h>
 
 #include "mmu_decl.h"
 
+#ifdef CONFIG_PPC32
+
+unsigned long ioremap_bot;
+EXPORT_SYMBOL(ioremap_bot);	/* aka VMALLOC_END */
+
+void __iomem *
+ioremap(phys_addr_t addr, unsigned long size)
+{
+	return __ioremap_caller(addr, size, _PAGE_NO_CACHE | _PAGE_GUARDED,
+				__builtin_return_address(0));
+}
+EXPORT_SYMBOL(ioremap);
+
+void __iomem *
+ioremap_wc(phys_addr_t addr, unsigned long size)
+{
+	return __ioremap_caller(addr, size, _PAGE_NO_CACHE,
+				__builtin_return_address(0));
+}
+EXPORT_SYMBOL(ioremap_wc);
+
+void __iomem *
+ioremap_prot(phys_addr_t addr, unsigned long size, unsigned long flags)
+{
+	/* writeable implies dirty for kernel addresses */
+	if ((flags & (_PAGE_RW | _PAGE_RO)) != _PAGE_RO)
+		flags |= _PAGE_DIRTY | _PAGE_HWWRITE;
+
+	/* we don't want to let _PAGE_USER and _PAGE_EXEC leak out */
+	flags &= ~(_PAGE_USER | _PAGE_EXEC);
+	flags |= _PAGE_PRIVILEGED;
+
+	return __ioremap_caller(addr, size, flags, __builtin_return_address(0));
+}
+EXPORT_SYMBOL(ioremap_prot);
+
+void __iomem *
+__ioremap(phys_addr_t addr, unsigned long size, unsigned long flags)
+{
+	return __ioremap_caller(addr, size, flags, __builtin_return_address(0));
+}
+EXPORT_SYMBOL(__ioremap);
+
+void __iomem *
+__ioremap_caller(phys_addr_t addr, unsigned long size, unsigned long flags,
+		 void *caller)
+{
+	unsigned long v, i;
+	phys_addr_t p;
+	int err;
+
+	/* Make sure we have the base flags */
+	if ((flags & _PAGE_PRESENT) == 0)
+		flags |= pgprot_val(PAGE_KERNEL);
+
+	/* Non-cacheable page cannot be coherent */
+	if (flags & _PAGE_NO_CACHE)
+		flags &= ~_PAGE_COHERENT;
+
+	/*
+	 * Choose an address to map it to.
+	 * Once the vmalloc system is running, we use it.
+	 * Before then, we use space going down from IOREMAP_TOP
+	 * (ioremap_bot records where we're up to).
+	 */
+	p = addr & PAGE_MASK;
+	size = PAGE_ALIGN(addr + size) - p;
+
+	/*
+	 * If the address lies within the first 16 MB, assume it's in ISA
+	 * memory space
+	 */
+	if (p < 16*1024*1024)
+		p += _ISA_MEM_BASE;
+
+#ifndef CONFIG_CRASH_DUMP
+	/*
+	 * Don't allow anybody to remap normal RAM that we're using.
+	 * mem_init() sets high_memory so only do the check after that.
+	 */
+	if (slab_is_available() && (p < virt_to_phys(high_memory)) &&
+	    page_is_ram(__phys_to_pfn(p))) {
+		printk("__ioremap(): phys addr 0x%llx is RAM lr %ps\n",
+		       (unsigned long long)p, __builtin_return_address(0));
+		return NULL;
+	}
+#endif
+
+	if (size == 0)
+		return NULL;
+
+	/*
+	 * Is it already mapped?  Perhaps overlapped by a previous
+	 * mapping.
+	 */
+	v = p_block_mapped(p);
+	if (v)
+		goto out;
+
+	if (slab_is_available()) {
+		struct vm_struct *area;
+		area = get_vm_area_caller(size, VM_IOREMAP, caller);
+		if (area == 0)
+			return NULL;
+		area->phys_addr = p;
+		v = (unsigned long) area->addr;
+	} else {
+		v = (ioremap_bot -= size);
+	}
+
+	/*
+	 * Should check if it is a candidate for a BAT mapping
+	 */
+
+	err = 0;
+	for (i = 0; i < size && err == 0; i += PAGE_SIZE)
+		err = map_kernel_page(v+i, p+i, flags);
+	if (err) {
+		if (slab_is_available())
+			vunmap((void *)v);
+		return NULL;
+	}
+
+out:
+	return (void __iomem *) (v + ((unsigned long)addr & ~PAGE_MASK));
+}
+
+void iounmap(volatile void __iomem *addr)
+{
+	/*
+	 * If mapped by BATs then there is nothing to do.
+	 * Calling vfree() generates a benign warning.
+	 */
+	if (v_block_mapped((unsigned long)addr))
+		return;
+
+	if (addr > high_memory && (unsigned long) addr < ioremap_bot)
+		vunmap((void *) (PAGE_MASK & (unsigned long)addr));
+}
+EXPORT_SYMBOL(iounmap);
+
+#else
 
 #ifdef CONFIG_PPC_BOOK3S_64
-/*
- * partition table and process table for ISA 3.0
- */
-struct prtb_entry *process_tb;
-struct patb_entry *partition_tb;
-/*
- * page table size
- */
-unsigned long __pte_index_size;
-EXPORT_SYMBOL(__pte_index_size);
-unsigned long __pmd_index_size;
-EXPORT_SYMBOL(__pmd_index_size);
-unsigned long __pud_index_size;
-EXPORT_SYMBOL(__pud_index_size);
-unsigned long __pgd_index_size;
-EXPORT_SYMBOL(__pgd_index_size);
-unsigned long __pud_cache_index;
-EXPORT_SYMBOL(__pud_cache_index);
-unsigned long __pte_table_size;
-EXPORT_SYMBOL(__pte_table_size);
-unsigned long __pmd_table_size;
-EXPORT_SYMBOL(__pmd_table_size);
-unsigned long __pud_table_size;
-EXPORT_SYMBOL(__pud_table_size);
-unsigned long __pgd_table_size;
-EXPORT_SYMBOL(__pgd_table_size);
-unsigned long __pmd_val_bits;
-EXPORT_SYMBOL(__pmd_val_bits);
-unsigned long __pud_val_bits;
-EXPORT_SYMBOL(__pud_val_bits);
-unsigned long __pgd_val_bits;
-EXPORT_SYMBOL(__pgd_val_bits);
-unsigned long __kernel_virt_start;
-EXPORT_SYMBOL(__kernel_virt_start);
-unsigned long __kernel_virt_size;
-EXPORT_SYMBOL(__kernel_virt_size);
-unsigned long __vmalloc_start;
-EXPORT_SYMBOL(__vmalloc_start);
-unsigned long __vmalloc_end;
-EXPORT_SYMBOL(__vmalloc_end);
-unsigned long __kernel_io_start;
-EXPORT_SYMBOL(__kernel_io_start);
-struct page *vmemmap;
-EXPORT_SYMBOL(vmemmap);
-unsigned long __pte_frag_nr;
-EXPORT_SYMBOL(__pte_frag_nr);
-unsigned long __pte_frag_size_shift;
-EXPORT_SYMBOL(__pte_frag_size_shift);
 unsigned long ioremap_bot;
 #else /* !CONFIG_PPC_BOOK3S_64 */
 unsigned long ioremap_bot = IOREMAP_BASE;
@@ -136,6 +204,7 @@ void __iomem * __ioremap_at(phys_addr_t pa, void *ea, unsigned long size,
 
 	return (void __iomem *)ea;
 }
+EXPORT_SYMBOL(__ioremap_at);
 
 /**
  * __iounmap_from - Low level function to tear down the page tables
@@ -150,6 +219,7 @@ void __iounmap_at(void *ea, unsigned long size)
 
 	unmap_kernel_range((unsigned long)ea, size);
 }
+EXPORT_SYMBOL(__iounmap_at);
 
 void __iomem * __ioremap_caller(phys_addr_t addr, unsigned long size,
 				unsigned long flags, void *caller)
@@ -164,7 +234,7 @@ void __iomem * __ioremap_caller(phys_addr_t addr, unsigned long size,
 	 * up from ioremap_bot.  imalloc will use
 	 * the addresses from ioremap_bot through
 	 * IMALLOC_END
-	 * 
+	 *
 	 */
 	paligned = addr & PAGE_MASK;
 	size = PAGE_ALIGN(addr + size) - paligned;
@@ -201,6 +271,7 @@ void __iomem * __ioremap(phys_addr_t addr, unsigned long size,
 {
 	return __ioremap_caller(addr, size, flags, __builtin_return_address(0));
 }
+EXPORT_SYMBOL(__ioremap);
 
 void __iomem * ioremap(phys_addr_t addr, unsigned long size)
 {
@@ -211,6 +282,7 @@ void __iomem * ioremap(phys_addr_t addr, unsigned long size)
 		return ppc_md.ioremap(addr, size, flags, caller);
 	return __ioremap_caller(addr, size, flags, caller);
 }
+EXPORT_SYMBOL(ioremap);
 
 void __iomem * ioremap_wc(phys_addr_t addr, unsigned long size)
 {
@@ -221,6 +293,7 @@ void __iomem * ioremap_wc(phys_addr_t addr, unsigned long size)
 		return ppc_md.ioremap(addr, size, flags, caller);
 	return __ioremap_caller(addr, size, flags, caller);
 }
+EXPORT_SYMBOL(ioremap_wc);
 
 void __iomem * ioremap_prot(phys_addr_t addr, unsigned long size,
 			     unsigned long flags)
@@ -243,9 +316,9 @@ void __iomem * ioremap_prot(phys_addr_t addr, unsigned long size,
 		return ppc_md.ioremap(addr, size, flags, caller);
 	return __ioremap_caller(addr, size, flags, caller);
 }
+EXPORT_SYMBOL(ioremap_prot);
 
-
-/*  
+/*
  * Unmap an IO region and remove it from imalloc'd list.
  * Access to IO memory should be serialized by driver.
  */
@@ -255,7 +328,7 @@ void __iounmap(volatile void __iomem *token)
 
 	if (!slab_is_available())
 		return;
-	
+
 	addr = (void *) ((unsigned long __force)
 			 PCI_FIX_ADDR(token) & PAGE_MASK);
 	if ((unsigned long)addr < ioremap_bot) {
@@ -265,6 +338,7 @@ void __iounmap(volatile void __iomem *token)
 	}
 	vunmap(addr);
 }
+EXPORT_SYMBOL(__iounmap);
 
 void iounmap(volatile void __iomem *token)
 {
@@ -273,63 +347,6 @@ void iounmap(volatile void __iomem *token)
 	else
 		__iounmap(token);
 }
-
-EXPORT_SYMBOL(ioremap);
-EXPORT_SYMBOL(ioremap_wc);
-EXPORT_SYMBOL(ioremap_prot);
-EXPORT_SYMBOL(__ioremap);
-EXPORT_SYMBOL(__ioremap_at);
 EXPORT_SYMBOL(iounmap);
-EXPORT_SYMBOL(__iounmap);
-EXPORT_SYMBOL(__iounmap_at);
-
-#ifndef __PAGETABLE_PUD_FOLDED
-/* 4 level page table */
-struct page *pgd_page(pgd_t pgd)
-{
-	if (pgd_huge(pgd))
-		return pte_page(pgd_pte(pgd));
-	return virt_to_page(pgd_page_vaddr(pgd));
-}
-#endif
-
-struct page *pud_page(pud_t pud)
-{
-	if (pud_huge(pud))
-		return pte_page(pud_pte(pud));
-	return virt_to_page(pud_page_vaddr(pud));
-}
 
-/*
- * For hugepage we have pfn in the pmd, we use PTE_RPN_SHIFT bits for flags
- * For PTE page, we have a PTE_FRAG_SIZE (4K) aligned virtual address.
- */
-struct page *pmd_page(pmd_t pmd)
-{
-	if (pmd_trans_huge(pmd) || pmd_huge(pmd) || pmd_devmap(pmd))
-		return pte_page(pmd_pte(pmd));
-	return virt_to_page(pmd_page_vaddr(pmd));
-}
-
-#ifdef CONFIG_STRICT_KERNEL_RWX
-void mark_rodata_ro(void)
-{
-	if (!mmu_has_feature(MMU_FTR_KERNEL_RO)) {
-		pr_warn("Warning: Unable to mark rodata read only on this CPU.\n");
-		return;
-	}
-
-	if (radix_enabled())
-		radix__mark_rodata_ro();
-	else
-		hash__mark_rodata_ro();
-}
-
-void mark_initmem_nx(void)
-{
-	if (radix_enabled())
-		radix__mark_initmem_nx();
-	else
-		hash__mark_initmem_nx();
-}
 #endif
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 120a49bfb9c6..54a5bc0767a9 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -38,9 +38,6 @@
 
 #include "mmu_decl.h"
 
-unsigned long ioremap_bot;
-EXPORT_SYMBOL(ioremap_bot);	/* aka VMALLOC_END */
-
 extern char etext[], _stext[], _sinittext[], _einittext[];
 
 __ref pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
@@ -73,142 +70,6 @@ pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
 	return ptepage;
 }
 
-void __iomem *
-ioremap(phys_addr_t addr, unsigned long size)
-{
-	return __ioremap_caller(addr, size, _PAGE_NO_CACHE | _PAGE_GUARDED,
-				__builtin_return_address(0));
-}
-EXPORT_SYMBOL(ioremap);
-
-void __iomem *
-ioremap_wc(phys_addr_t addr, unsigned long size)
-{
-	return __ioremap_caller(addr, size, _PAGE_NO_CACHE,
-				__builtin_return_address(0));
-}
-EXPORT_SYMBOL(ioremap_wc);
-
-void __iomem *
-ioremap_prot(phys_addr_t addr, unsigned long size, unsigned long flags)
-{
-	/* writeable implies dirty for kernel addresses */
-	if ((flags & (_PAGE_RW | _PAGE_RO)) != _PAGE_RO)
-		flags |= _PAGE_DIRTY | _PAGE_HWWRITE;
-
-	/* we don't want to let _PAGE_USER and _PAGE_EXEC leak out */
-	flags &= ~(_PAGE_USER | _PAGE_EXEC);
-	flags |= _PAGE_PRIVILEGED;
-
-	return __ioremap_caller(addr, size, flags, __builtin_return_address(0));
-}
-EXPORT_SYMBOL(ioremap_prot);
-
-void __iomem *
-__ioremap(phys_addr_t addr, unsigned long size, unsigned long flags)
-{
-	return __ioremap_caller(addr, size, flags, __builtin_return_address(0));
-}
-
-void __iomem *
-__ioremap_caller(phys_addr_t addr, unsigned long size, unsigned long flags,
-		 void *caller)
-{
-	unsigned long v, i;
-	phys_addr_t p;
-	int err;
-
-	/* Make sure we have the base flags */
-	if ((flags & _PAGE_PRESENT) == 0)
-		flags |= pgprot_val(PAGE_KERNEL);
-
-	/* Non-cacheable page cannot be coherent */
-	if (flags & _PAGE_NO_CACHE)
-		flags &= ~_PAGE_COHERENT;
-
-	/*
-	 * Choose an address to map it to.
-	 * Once the vmalloc system is running, we use it.
-	 * Before then, we use space going down from IOREMAP_TOP
-	 * (ioremap_bot records where we're up to).
-	 */
-	p = addr & PAGE_MASK;
-	size = PAGE_ALIGN(addr + size) - p;
-
-	/*
-	 * If the address lies within the first 16 MB, assume it's in ISA
-	 * memory space
-	 */
-	if (p < 16*1024*1024)
-		p += _ISA_MEM_BASE;
-
-#ifndef CONFIG_CRASH_DUMP
-	/*
-	 * Don't allow anybody to remap normal RAM that we're using.
-	 * mem_init() sets high_memory so only do the check after that.
-	 */
-	if (slab_is_available() && (p < virt_to_phys(high_memory)) &&
-	    page_is_ram(__phys_to_pfn(p))) {
-		printk("__ioremap(): phys addr 0x%llx is RAM lr %ps\n",
-		       (unsigned long long)p, __builtin_return_address(0));
-		return NULL;
-	}
-#endif
-
-	if (size == 0)
-		return NULL;
-
-	/*
-	 * Is it already mapped?  Perhaps overlapped by a previous
-	 * mapping.
-	 */
-	v = p_block_mapped(p);
-	if (v)
-		goto out;
-
-	if (slab_is_available()) {
-		struct vm_struct *area;
-		area = get_vm_area_caller(size, VM_IOREMAP, caller);
-		if (area == 0)
-			return NULL;
-		area->phys_addr = p;
-		v = (unsigned long) area->addr;
-	} else {
-		v = (ioremap_bot -= size);
-	}
-
-	/*
-	 * Should check if it is a candidate for a BAT mapping
-	 */
-
-	err = 0;
-	for (i = 0; i < size && err == 0; i += PAGE_SIZE)
-		err = map_kernel_page(v+i, p+i, flags);
-	if (err) {
-		if (slab_is_available())
-			vunmap((void *)v);
-		return NULL;
-	}
-
-out:
-	return (void __iomem *) (v + ((unsigned long)addr & ~PAGE_MASK));
-}
-EXPORT_SYMBOL(__ioremap);
-
-void iounmap(volatile void __iomem *addr)
-{
-	/*
-	 * If mapped by BATs then there is nothing to do.
-	 * Calling vfree() generates a benign warning.
-	 */
-	if (v_block_mapped((unsigned long)addr))
-		return;
-
-	if (addr > high_memory && (unsigned long) addr < ioremap_bot)
-		vunmap((void *) (PAGE_MASK & (unsigned long)addr));
-}
-EXPORT_SYMBOL(iounmap);
-
 int map_kernel_page(unsigned long va, phys_addr_t pa, int flags)
 {
 	pmd_t *pd;
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 53e9eeecd5d4..dd6bf736e319 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -104,185 +104,8 @@ unsigned long __pte_frag_nr;
 EXPORT_SYMBOL(__pte_frag_nr);
 unsigned long __pte_frag_size_shift;
 EXPORT_SYMBOL(__pte_frag_size_shift);
-unsigned long ioremap_bot;
-#else /* !CONFIG_PPC_BOOK3S_64 */
-unsigned long ioremap_bot = IOREMAP_BASE;
 #endif
 
-/**
- * __ioremap_at - Low level function to establish the page tables
- *                for an IO mapping
- */
-void __iomem * __ioremap_at(phys_addr_t pa, void *ea, unsigned long size,
-			    unsigned long flags)
-{
-	unsigned long i;
-
-	/* Make sure we have the base flags */
-	if ((flags & _PAGE_PRESENT) == 0)
-		flags |= pgprot_val(PAGE_KERNEL);
-
-	/* We don't support the 4K PFN hack with ioremap */
-	if (flags & H_PAGE_4K_PFN)
-		return NULL;
-
-	WARN_ON(pa & ~PAGE_MASK);
-	WARN_ON(((unsigned long)ea) & ~PAGE_MASK);
-	WARN_ON(size & ~PAGE_MASK);
-
-	for (i = 0; i < size; i += PAGE_SIZE)
-		if (map_kernel_page((unsigned long)ea+i, pa+i, flags))
-			return NULL;
-
-	return (void __iomem *)ea;
-}
-
-/**
- * __iounmap_from - Low level function to tear down the page tables
- *                  for an IO mapping. This is used for mappings that
- *                  are manipulated manually, like partial unmapping of
- *                  PCI IOs or ISA space.
- */
-void __iounmap_at(void *ea, unsigned long size)
-{
-	WARN_ON(((unsigned long)ea) & ~PAGE_MASK);
-	WARN_ON(size & ~PAGE_MASK);
-
-	unmap_kernel_range((unsigned long)ea, size);
-}
-
-void __iomem * __ioremap_caller(phys_addr_t addr, unsigned long size,
-				unsigned long flags, void *caller)
-{
-	phys_addr_t paligned;
-	void __iomem *ret;
-
-	/*
-	 * Choose an address to map it to.
-	 * Once the imalloc system is running, we use it.
-	 * Before that, we map using addresses going
-	 * up from ioremap_bot.  imalloc will use
-	 * the addresses from ioremap_bot through
-	 * IMALLOC_END
-	 * 
-	 */
-	paligned = addr & PAGE_MASK;
-	size = PAGE_ALIGN(addr + size) - paligned;
-
-	if ((size == 0) || (paligned == 0))
-		return NULL;
-
-	if (slab_is_available()) {
-		struct vm_struct *area;
-
-		area = __get_vm_area_caller(size, VM_IOREMAP,
-					    ioremap_bot, IOREMAP_END,
-					    caller);
-		if (area == NULL)
-			return NULL;
-
-		area->phys_addr = paligned;
-		ret = __ioremap_at(paligned, area->addr, size, flags);
-		if (!ret)
-			vunmap(area->addr);
-	} else {
-		ret = __ioremap_at(paligned, (void *)ioremap_bot, size, flags);
-		if (ret)
-			ioremap_bot += size;
-	}
-
-	if (ret)
-		ret += addr & ~PAGE_MASK;
-	return ret;
-}
-
-void __iomem * __ioremap(phys_addr_t addr, unsigned long size,
-			 unsigned long flags)
-{
-	return __ioremap_caller(addr, size, flags, __builtin_return_address(0));
-}
-
-void __iomem * ioremap(phys_addr_t addr, unsigned long size)
-{
-	unsigned long flags = pgprot_val(pgprot_noncached(__pgprot(0)));
-	void *caller = __builtin_return_address(0);
-
-	if (ppc_md.ioremap)
-		return ppc_md.ioremap(addr, size, flags, caller);
-	return __ioremap_caller(addr, size, flags, caller);
-}
-
-void __iomem * ioremap_wc(phys_addr_t addr, unsigned long size)
-{
-	unsigned long flags = pgprot_val(pgprot_noncached_wc(__pgprot(0)));
-	void *caller = __builtin_return_address(0);
-
-	if (ppc_md.ioremap)
-		return ppc_md.ioremap(addr, size, flags, caller);
-	return __ioremap_caller(addr, size, flags, caller);
-}
-
-void __iomem * ioremap_prot(phys_addr_t addr, unsigned long size,
-			     unsigned long flags)
-{
-	void *caller = __builtin_return_address(0);
-
-	/* writeable implies dirty for kernel addresses */
-	if (flags & _PAGE_WRITE)
-		flags |= _PAGE_DIRTY;
-
-	/* we don't want to let _PAGE_EXEC leak out */
-	flags &= ~_PAGE_EXEC;
-	/*
-	 * Force kernel mapping.
-	 */
-	flags &= ~_PAGE_USER;
-	flags |= _PAGE_PRIVILEGED;
-
-	if (ppc_md.ioremap)
-		return ppc_md.ioremap(addr, size, flags, caller);
-	return __ioremap_caller(addr, size, flags, caller);
-}
-
-
-/*  
- * Unmap an IO region and remove it from imalloc'd list.
- * Access to IO memory should be serialized by driver.
- */
-void __iounmap(volatile void __iomem *token)
-{
-	void *addr;
-
-	if (!slab_is_available())
-		return;
-	
-	addr = (void *) ((unsigned long __force)
-			 PCI_FIX_ADDR(token) & PAGE_MASK);
-	if ((unsigned long)addr < ioremap_bot) {
-		printk(KERN_WARNING "Attempt to iounmap early bolted mapping"
-		       " at 0x%p\n", addr);
-		return;
-	}
-	vunmap(addr);
-}
-
-void iounmap(volatile void __iomem *token)
-{
-	if (ppc_md.iounmap)
-		ppc_md.iounmap(token);
-	else
-		__iounmap(token);
-}
-
-EXPORT_SYMBOL(ioremap);
-EXPORT_SYMBOL(ioremap_wc);
-EXPORT_SYMBOL(ioremap_prot);
-EXPORT_SYMBOL(__ioremap);
-EXPORT_SYMBOL(__ioremap_at);
-EXPORT_SYMBOL(iounmap);
-EXPORT_SYMBOL(__iounmap);
-EXPORT_SYMBOL(__iounmap_at);
-
 #ifndef __PAGETABLE_PUD_FOLDED
 /* 4 level page table */
 struct page *pgd_page(pgd_t pgd)
-- 
2.13.3
