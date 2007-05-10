Return-Path: <dgibson@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 1/7] Remove fixup_bigphys_addr() for arch/powerpc
In-Reply-To: <20070510060449.GA3118@localhost.localdomain>
Message-Id: <20070510060556.77630DDEBF@ozlabs.org>
Date: Thu, 10 May 2007 16:05:56 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There are no actual implementations of fixup_bigphys_addr() in
arch/powerpc, and with a 64-bit aware ioremap() and so forth, it
should no longer be necessary.  This patch removes the last dregs of
fixup_bigphys_addr() from arch/powerpc.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---

 include/asm-powerpc/mmu-44x.h       |    2 --
 include/asm-powerpc/pgtable-ppc32.h |   15 ---------------
 2 files changed, 17 deletions(-)

Index: working-2.6/include/asm-powerpc/mmu-44x.h
===================================================================
--- working-2.6.orig/include/asm-powerpc/mmu-44x.h	2007-05-09 13:14:53.000000000 +1000
+++ working-2.6/include/asm-powerpc/mmu-44x.h	2007-05-09 13:15:10.000000000 +1000
@@ -55,8 +55,6 @@
 
 typedef unsigned long long phys_addr_t;
 
-extern phys_addr_t fixup_bigphys_addr(phys_addr_t, phys_addr_t);
-
 typedef struct {
 	unsigned long id;
 	unsigned long vdso_base;
Index: working-2.6/include/asm-powerpc/pgtable-ppc32.h
===================================================================
--- working-2.6.orig/include/asm-powerpc/pgtable-ppc32.h	2007-05-09 13:14:25.000000000 +1000
+++ working-2.6/include/asm-powerpc/pgtable-ppc32.h	2007-05-09 13:14:42.000000000 +1000
@@ -782,23 +782,8 @@ extern void kernel_set_cachemode (unsign
 /* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
 #define kern_addr_valid(addr)	(1)
 
-#ifdef CONFIG_PHYS_64BIT
-extern int remap_pfn_range(struct vm_area_struct *vma, unsigned long from,
-			unsigned long paddr, unsigned long size, pgprot_t prot);
-
-static inline int io_remap_pfn_range(struct vm_area_struct *vma,
-					unsigned long vaddr,
-					unsigned long pfn,
-					unsigned long size,
-					pgprot_t prot)
-{
-	phys_addr_t paddr64 = fixup_bigphys_addr(pfn << PAGE_SHIFT, size);
-	return remap_pfn_range(vma, vaddr, paddr64 >> PAGE_SHIFT, size, prot);
-}
-#else
 #define io_remap_pfn_range(vma, vaddr, pfn, size, prot)		\
 		remap_pfn_range(vma, vaddr, pfn, size, prot)
-#endif
 
 /*
  * No page table caches to initialise
