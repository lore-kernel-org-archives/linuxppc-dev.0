Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wJ8f5zlBzDr7s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 01:50:26 +1000 (AEST)
Message-Id: <2f21c4962d7c74b5d3f69c936928ac6b5b853d3b.1527608397.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1527608397.git.christophe.leroy@c-s.fr>
References: <cover.1527608397.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 04/14] powerpc: common ioremap functions.
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 29 May 2018 15:50:22 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

__ioremap(), ioremap(), ioremap_wc() et ioremap_prot() are
very similar between PPC32 and PPC64, they can easily be
made common.

_PAGE_WRITE equals to _PAGE_RW on PPC32
_PAGE_RO and _PAGE_HWWRITE are 0 on PPC64

iounmap() can also be made common by renaming the PPC32
iounmap() as __iounmap() then __iounmap() can also
be made common to PPC32 and PPC64.

This patch also makes __ioremap_caller() common to PPC32 and PPC64

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h |   2 +
 arch/powerpc/include/asm/machdep.h           |   2 +-
 arch/powerpc/mm/ioremap.c                    | 190 ++++++---------------------
 3 files changed, 46 insertions(+), 148 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index c233915abb68..2111dc9758cc 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -17,6 +17,8 @@
 #define _PAGE_NA		0
 #define _PAGE_RO		0
 #define _PAGE_USER		0
+#define _PAGE_HWWRITE		0
+#define _PAGE_COHERENT		0
 
 #define _PAGE_EXEC		0x00001 /* execute permission */
 #define _PAGE_WRITE		0x00002 /* write access allowed */
diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index ffe7c71e1132..84d99ed82d5d 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -33,11 +33,11 @@ struct pci_host_bridge;
 
 struct machdep_calls {
 	char		*name;
-#ifdef CONFIG_PPC64
 	void __iomem *	(*ioremap)(phys_addr_t addr, unsigned long size,
 				   unsigned long flags, void *caller);
 	void		(*iounmap)(volatile void __iomem *token);
 
+#ifdef CONFIG_PPC64
 #ifdef CONFIG_PM
 	void		(*iommu_save)(void);
 	void		(*iommu_restore)(void);
diff --git a/arch/powerpc/mm/ioremap.c b/arch/powerpc/mm/ioremap.c
index a498e3cade9e..a140feec2f8a 100644
--- a/arch/powerpc/mm/ioremap.c
+++ b/arch/powerpc/mm/ioremap.c
@@ -35,147 +35,6 @@ unsigned long ioremap_bot = IOREMAP_BASE;
 #endif
 EXPORT_SYMBOL(ioremap_bot);	/* aka VMALLOC_END */
 
-#ifdef CONFIG_PPC32
-
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
-EXPORT_SYMBOL(__ioremap);
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
-	 * Before then, we use space going up from IOREMAP_BASE
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
-		v = ioremap_bot;
-		ioremap_bot += size;
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
-	if ((unsigned long) addr >= ioremap_bot)
-		vunmap((void *) (PAGE_MASK & (unsigned long)addr));
-}
-EXPORT_SYMBOL(iounmap);
-
-#else
-
 /**
  * __ioremap_at - Low level function to establish the page tables
  *                for an IO mapping
@@ -189,6 +48,10 @@ void __iomem * __ioremap_at(phys_addr_t pa, void *ea, unsigned long size,
 	if ((flags & _PAGE_PRESENT) == 0)
 		flags |= pgprot_val(PAGE_KERNEL);
 
+	/* Non-cacheable page cannot be coherent */
+	if (flags & _PAGE_NO_CACHE)
+		flags &= ~_PAGE_COHERENT;
+
 	/* We don't support the 4K PFN hack with ioremap */
 	if (flags & H_PAGE_4K_PFN)
 		return NULL;
@@ -241,6 +104,33 @@ void __iomem * __ioremap_caller(phys_addr_t addr, unsigned long size,
 	if ((size == 0) || (paligned == 0))
 		return NULL;
 
+	/*
+	 * If the address lies within the first 16 MB, assume it's in ISA
+	 * memory space
+	 */
+	if (IS_ENABLED(CONFIG_PPC32) && paligned < 16*1024*1024)
+		paligned += _ISA_MEM_BASE;
+
+	/*
+	 * Don't allow anybody to remap normal RAM that we're using.
+	 * mem_init() sets high_memory so only do the check after that.
+	 */
+	if (!IS_ENABLED(CONFIG_CRASH_DUMP) &&
+	    slab_is_available() && (paligned < virt_to_phys(high_memory)) &&
+	    page_is_ram(__phys_to_pfn(paligned))) {
+		printk("__ioremap(): phys addr 0x%llx is RAM lr %ps\n",
+		       (u64)paligned, __builtin_return_address(0));
+		return NULL;
+	}
+
+	/*
+	 * Is it already mapped?  Perhaps overlapped by a previous
+	 * mapping.
+	 */
+	ret = (void __iomem *)p_block_mapped(paligned);
+	if (ret)
+		goto out;
+
 	if (slab_is_available()) {
 		struct vm_struct *area;
 
@@ -259,9 +149,9 @@ void __iomem * __ioremap_caller(phys_addr_t addr, unsigned long size,
 		if (ret)
 			ioremap_bot += size;
 	}
-
+out:
 	if (ret)
-		ret += addr & ~PAGE_MASK;
+		ret += (unsigned long)addr & ~PAGE_MASK;
 	return ret;
 }
 
@@ -300,8 +190,8 @@ void __iomem * ioremap_prot(phys_addr_t addr, unsigned long size,
 	void *caller = __builtin_return_address(0);
 
 	/* writeable implies dirty for kernel addresses */
-	if (flags & _PAGE_WRITE)
-		flags |= _PAGE_DIRTY;
+	if ((flags & (_PAGE_WRITE | _PAGE_RO)) != _PAGE_RO)
+		flags |= _PAGE_DIRTY | _PAGE_HWWRITE;
 
 	/* we don't want to let _PAGE_EXEC leak out */
 	flags &= ~_PAGE_EXEC;
@@ -330,6 +220,14 @@ void __iounmap(volatile void __iomem *token)
 
 	addr = (void *) ((unsigned long __force)
 			 PCI_FIX_ADDR(token) & PAGE_MASK);
+
+	/*
+	 * If mapped by BATs then there is nothing to do.
+	 * Calling vfree() generates a benign warning.
+	 */
+	if (v_block_mapped((unsigned long)addr))
+		return;
+
 	if ((unsigned long)addr < ioremap_bot) {
 		printk(KERN_WARNING "Attempt to iounmap early bolted mapping"
 		       " at 0x%p\n", addr);
@@ -347,5 +245,3 @@ void iounmap(volatile void __iomem *token)
 		__iounmap(token);
 }
 EXPORT_SYMBOL(iounmap);
-
-#endif
-- 
2.13.3
