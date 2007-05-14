Return-Path: <dgibson@ozlabs.org>
Date: Mon, 14 May 2007 11:43:20 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Remove fixup_bigphys_addr() for arch/powerpc
Message-ID: <20070514014320.GI6517@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
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

In fact, the only reason this hasn't caused link errors already is
that nobody must have tried using one of the small number of drivers
using io_remap_pfn_range() on one of the small number of platforms
which are 32-bit but define CONFIG_PHYS_64BIT.  Nonetheless this fixes
a bug, and should go into 2.6.22.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

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

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
