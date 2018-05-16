Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40m96g2xd0zF14v
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 20:05:30 +1000 (AEST)
Message-Id: <480a4ec2d24eb9d62ca79bb131b3789ad8413893.1526464250.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1526464250.git.christophe.leroy@c-s.fr>
References: <cover.1526464250.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 02/14] powerpc: move io mapping functions into ioremap.c
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 16 May 2018 12:05:27 +0200 (CEST)
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
 arch/powerpc/mm/Makefile     |   2 +-
 arch/powerpc/mm/ioremap.c    | 352 +++++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/mm/pgtable_32.c | 139 -----------------
 arch/powerpc/mm/pgtable_64.c | 177 ----------------------
 4 files changed, 353 insertions(+), 317 deletions(-)
 create mode 100644 arch/powerpc/mm/ioremap.c

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
diff --git a/arch/powerpc/mm/ioremap.c b/arch/powerpc/mm/ioremap.c
new file mode 100644
index 000000000000..0c8f6113e0f3
--- /dev/null
+++ b/arch/powerpc/mm/ioremap.c
@@ -0,0 +1,352 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * This file contains the routines for mapping IO areas
+ *
+ *  Derived from arch/powerpc/mm/pgtable_32.c and
+ *  arch/powerpc/mm/pgtable_64.c
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/mm.h>
+#include <linux/vmalloc.h>
+#include <linux/init.h>
+#include <linux/highmem.h>
+#include <linux/memblock.h>
+#include <linux/slab.h>
+
+#include <asm/pgtable.h>
+#include <asm/pgalloc.h>
+#include <asm/fixmap.h>
+#include <asm/io.h>
+#include <asm/setup.h>
+#include <asm/sections.h>
+#include <asm/machdep.h>
+
+#include "mmu_decl.h"
+
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
+
+#ifdef CONFIG_PPC_BOOK3S_64
+unsigned long ioremap_bot;
+#else /* !CONFIG_PPC_BOOK3S_64 */
+unsigned long ioremap_bot = IOREMAP_BASE;
+#endif
+
+/**
+ * __ioremap_at - Low level function to establish the page tables
+ *                for an IO mapping
+ */
+void __iomem * __ioremap_at(phys_addr_t pa, void *ea, unsigned long size,
+			    unsigned long flags)
+{
+	unsigned long i;
+
+	/* Make sure we have the base flags */
+	if ((flags & _PAGE_PRESENT) == 0)
+		flags |= pgprot_val(PAGE_KERNEL);
+
+	/* We don't support the 4K PFN hack with ioremap */
+	if (flags & H_PAGE_4K_PFN)
+		return NULL;
+
+	WARN_ON(pa & ~PAGE_MASK);
+	WARN_ON(((unsigned long)ea) & ~PAGE_MASK);
+	WARN_ON(size & ~PAGE_MASK);
+
+	for (i = 0; i < size; i += PAGE_SIZE)
+		if (map_kernel_page((unsigned long)ea+i, pa+i, flags))
+			return NULL;
+
+	return (void __iomem *)ea;
+}
+EXPORT_SYMBOL(__ioremap_at);
+
+/**
+ * __iounmap_from - Low level function to tear down the page tables
+ *                  for an IO mapping. This is used for mappings that
+ *                  are manipulated manually, like partial unmapping of
+ *                  PCI IOs or ISA space.
+ */
+void __iounmap_at(void *ea, unsigned long size)
+{
+	WARN_ON(((unsigned long)ea) & ~PAGE_MASK);
+	WARN_ON(size & ~PAGE_MASK);
+
+	unmap_kernel_range((unsigned long)ea, size);
+}
+EXPORT_SYMBOL(__iounmap_at);
+
+void __iomem * __ioremap_caller(phys_addr_t addr, unsigned long size,
+				unsigned long flags, void *caller)
+{
+	phys_addr_t paligned;
+	void __iomem *ret;
+
+	/*
+	 * Choose an address to map it to.
+	 * Once the imalloc system is running, we use it.
+	 * Before that, we map using addresses going
+	 * up from ioremap_bot.  imalloc will use
+	 * the addresses from ioremap_bot through
+	 * IMALLOC_END
+	 *
+	 */
+	paligned = addr & PAGE_MASK;
+	size = PAGE_ALIGN(addr + size) - paligned;
+
+	if ((size == 0) || (paligned == 0))
+		return NULL;
+
+	if (slab_is_available()) {
+		struct vm_struct *area;
+
+		area = __get_vm_area_caller(size, VM_IOREMAP,
+					    ioremap_bot, IOREMAP_END,
+					    caller);
+		if (area == NULL)
+			return NULL;
+
+		area->phys_addr = paligned;
+		ret = __ioremap_at(paligned, area->addr, size, flags);
+		if (!ret)
+			vunmap(area->addr);
+	} else {
+		ret = __ioremap_at(paligned, (void *)ioremap_bot, size, flags);
+		if (ret)
+			ioremap_bot += size;
+	}
+
+	if (ret)
+		ret += addr & ~PAGE_MASK;
+	return ret;
+}
+
+void __iomem * __ioremap(phys_addr_t addr, unsigned long size,
+			 unsigned long flags)
+{
+	return __ioremap_caller(addr, size, flags, __builtin_return_address(0));
+}
+EXPORT_SYMBOL(__ioremap);
+
+void __iomem * ioremap(phys_addr_t addr, unsigned long size)
+{
+	unsigned long flags = pgprot_val(pgprot_noncached(__pgprot(0)));
+	void *caller = __builtin_return_address(0);
+
+	if (ppc_md.ioremap)
+		return ppc_md.ioremap(addr, size, flags, caller);
+	return __ioremap_caller(addr, size, flags, caller);
+}
+EXPORT_SYMBOL(ioremap);
+
+void __iomem * ioremap_wc(phys_addr_t addr, unsigned long size)
+{
+	unsigned long flags = pgprot_val(pgprot_noncached_wc(__pgprot(0)));
+	void *caller = __builtin_return_address(0);
+
+	if (ppc_md.ioremap)
+		return ppc_md.ioremap(addr, size, flags, caller);
+	return __ioremap_caller(addr, size, flags, caller);
+}
+EXPORT_SYMBOL(ioremap_wc);
+
+void __iomem * ioremap_prot(phys_addr_t addr, unsigned long size,
+			     unsigned long flags)
+{
+	void *caller = __builtin_return_address(0);
+
+	/* writeable implies dirty for kernel addresses */
+	if (flags & _PAGE_WRITE)
+		flags |= _PAGE_DIRTY;
+
+	/* we don't want to let _PAGE_EXEC leak out */
+	flags &= ~_PAGE_EXEC;
+	/*
+	 * Force kernel mapping.
+	 */
+	flags &= ~_PAGE_USER;
+	flags |= _PAGE_PRIVILEGED;
+
+	if (ppc_md.ioremap)
+		return ppc_md.ioremap(addr, size, flags, caller);
+	return __ioremap_caller(addr, size, flags, caller);
+}
+EXPORT_SYMBOL(ioremap_prot);
+
+/*
+ * Unmap an IO region and remove it from imalloc'd list.
+ * Access to IO memory should be serialized by driver.
+ */
+void __iounmap(volatile void __iomem *token)
+{
+	void *addr;
+
+	if (!slab_is_available())
+		return;
+
+	addr = (void *) ((unsigned long __force)
+			 PCI_FIX_ADDR(token) & PAGE_MASK);
+	if ((unsigned long)addr < ioremap_bot) {
+		printk(KERN_WARNING "Attempt to iounmap early bolted mapping"
+		       " at 0x%p\n", addr);
+		return;
+	}
+	vunmap(addr);
+}
+EXPORT_SYMBOL(__iounmap);
+
+void iounmap(volatile void __iomem *token)
+{
+	if (ppc_md.iounmap)
+		ppc_md.iounmap(token);
+	else
+		__iounmap(token);
+}
+EXPORT_SYMBOL(iounmap);
+
+#endif
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
index 9bf659d5078c..dd1102a246e4 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -109,185 +109,8 @@ unsigned long __pte_frag_nr;
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
