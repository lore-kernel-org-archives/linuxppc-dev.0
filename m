Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 15 Dec 2008 16:45:12 +1100
Subject: [PATCH 15/16] powerpc/mm: Rework usage of
	_PAGE_COHERENT/NO_CACHE/GUARDED
In-Reply-To: <1229319836.100184.344640589620.qpush@grosgo>
Message-Id: <20081215054611.3C3C1474E1@ozlabs.org>
Cc: Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently, we never set _PAGE_COHERENT in the PTEs, we just OR it in
in the hash code based on some CPU feature bit. We also manipulate
_PAGE_NO_CACHE and _PAGE_GUARDED by hand in all sorts of places.

This changes the logic so that instead, the PTE now contains
_PAGE_COHERENT for all normal RAM pages thay have I = 0 on platforms
that need it. The hash code clears it if the feature bit is not set.

It also adds some clean accessors to setup various valid combinations
of access flags and change various bits of code to use them instead.

This should help having the PTE actually containing the bit
combinations that we really want.

I also removed _PAGE_GUARDED from _PAGE_BASE on 44x and instead
set it explicitely from the TLB miss. I will ultimately remove it
completely as it appears that it might not be needed after all
but in the meantime, having it in the TLB miss makes things a
lot easier.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/include/asm/pgtable-ppc32.h |   42 ++++++++++++-------------------
 arch/powerpc/include/asm/pgtable-ppc64.h |   13 ---------
 arch/powerpc/include/asm/pgtable.h       |   26 +++++++++++++++++++
 arch/powerpc/kernel/head_44x.S           |    1 
 arch/powerpc/kernel/pci-common.c         |   24 ++++++-----------
 arch/powerpc/mm/hash_low_32.S            |    4 +-
 arch/powerpc/mm/mem.c                    |    4 +-
 arch/powerpc/platforms/cell/spufs/file.c |   27 ++++++-------------
 drivers/video/controlfb.c                |    4 +-
 9 files changed, 68 insertions(+), 77 deletions(-)

--- linux-work.orig/arch/powerpc/include/asm/pgtable-ppc32.h	2008-11-24 14:48:55.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/pgtable-ppc32.h	2008-12-15 15:34:16.000000000 +1100
@@ -228,9 +228,10 @@ extern int icache_44x_need_flush;
  *   - FILE *must* be in the bottom three bits because swap cache
  *     entries use the top 29 bits for TLB2.
  *
- *   - CACHE COHERENT bit (M) has no effect on PPC440 core, because it
- *     doesn't support SMP. So we can use this as software bit, like
- *     DIRTY.
+ *   - CACHE COHERENT bit (M) has no effect on original PPC440 cores,
+ *     because it doesn't support SMP. However, some later 460 variants
+ *     have -some- form of SMP support and so I keep the bit there for
+ *     future use
  *
  * With the PPC 44x Linux implementation, the 0-11th LSBs of the PTE are used
  * for memory protection related functions (see PTE structure in
@@ -436,20 +437,23 @@ extern int icache_44x_need_flush;
 			 _PAGE_USER | _PAGE_ACCESSED | \
 			 _PAGE_RW | _PAGE_HWWRITE | _PAGE_DIRTY | \
 			 _PAGE_EXEC | _PAGE_HWEXEC)
+
 /*
- * Note: the _PAGE_COHERENT bit automatically gets set in the hardware
- * PTE if CONFIG_SMP is defined (hash_page does this); there is no need
- * to have it in the Linux PTE, and in fact the bit could be reused for
- * another purpose.  -- paulus.
+ * We define 2 sets of base prot bits, one for basic pages (ie,
+ * cacheable kernel and user pages) and one for non cacheable
+ * pages. We always set _PAGE_COHERENT when SMP is enabled or
+ * the processor might need it for DMA coherency.
  */
-
-#ifdef CONFIG_44x
-#define _PAGE_BASE	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_GUARDED)
+#if defined(CONFIG_SMP) || defined(CONFIG_PPC_STD_MMU)
+#define _PAGE_BASE	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_COHERENT)
 #else
 #define _PAGE_BASE	(_PAGE_PRESENT | _PAGE_ACCESSED)
 #endif
+#define _PAGE_BASE_NC	(_PAGE_PRESENT | _PAGE_ACCESSED)
+
 #define _PAGE_WRENABLE	(_PAGE_RW | _PAGE_DIRTY | _PAGE_HWWRITE)
 #define _PAGE_KERNEL	(_PAGE_BASE | _PAGE_SHARED | _PAGE_WRENABLE)
+#define _PAGE_KERNEL_NC	(_PAGE_BASE_NC | _PAGE_SHARED | _PAGE_WRENABLE | _PAGE_NO_CACHE)
 
 #ifdef CONFIG_PPC_STD_MMU
 /* On standard PPC MMU, no user access implies kernel read/write access,
@@ -459,7 +463,7 @@ extern int icache_44x_need_flush;
 #define _PAGE_KERNEL_RO	(_PAGE_BASE | _PAGE_SHARED)
 #endif
 
-#define _PAGE_IO	(_PAGE_KERNEL | _PAGE_NO_CACHE | _PAGE_GUARDED)
+#define _PAGE_IO	(_PAGE_KERNEL_NC | _PAGE_GUARDED)
 #define _PAGE_RAM	(_PAGE_KERNEL | _PAGE_HWEXEC)
 
 #if defined(CONFIG_KGDB) || defined(CONFIG_XMON) || defined(CONFIG_BDI_SWITCH) ||\
@@ -552,9 +556,6 @@ static inline int pte_young(pte_t pte)		
 static inline int pte_file(pte_t pte)		{ return pte_val(pte) & _PAGE_FILE; }
 static inline int pte_special(pte_t pte)	{ return pte_val(pte) & _PAGE_SPECIAL; }
 
-static inline void pte_uncache(pte_t pte)       { pte_val(pte) |= _PAGE_NO_CACHE; }
-static inline void pte_cache(pte_t pte)         { pte_val(pte) &= ~_PAGE_NO_CACHE; }
-
 static inline pte_t pte_wrprotect(pte_t pte) {
 	pte_val(pte) &= ~(_PAGE_RW | _PAGE_HWWRITE); return pte; }
 static inline pte_t pte_mkclean(pte_t pte) {
@@ -693,10 +694,11 @@ static inline void __set_pte_at(struct m
 #endif
 }
 
+
 static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep, pte_t pte)
 {
-#if defined(CONFIG_PTE_64BIT) && defined(CONFIG_SMP)
+#if defined(CONFIG_PTE_64BIT) && defined(CONFIG_SMP) && defined(CONFIG_DEBUG_VM)
 	WARN_ON(pte_present(*ptep));
 #endif
 	__set_pte_at(mm, addr, ptep, pte);
@@ -760,16 +762,6 @@ static inline void __ptep_set_access_fla
 	__changed;							   \
 })
 
-/*
- * Macro to mark a page protection value as "uncacheable".
- */
-#define pgprot_noncached(prot)	(__pgprot(pgprot_val(prot) | _PAGE_NO_CACHE | _PAGE_GUARDED))
-
-struct file;
-extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
-				     unsigned long size, pgprot_t vma_prot);
-#define __HAVE_PHYS_MEM_ACCESS_PROT
-
 #define __HAVE_ARCH_PTE_SAME
 #define pte_same(A,B)	(((pte_val(A) ^ pte_val(B)) & ~_PAGE_HASHPTE) == 0)
 
Index: linux-work/arch/powerpc/kernel/head_44x.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/head_44x.S	2008-09-29 10:17:03.000000000 +1000
+++ linux-work/arch/powerpc/kernel/head_44x.S	2008-12-15 15:32:09.000000000 +1100
@@ -570,6 +570,7 @@ finish_tlb_load:
 	rlwimi	r10,r12,29,30,30		/* DIRTY -> SW position */
 	and	r11,r12,r10			/* Mask PTE bits to keep */
 	andi.	r10,r12,_PAGE_USER		/* User page ? */
+	ori	r11,r11,_PAGE_GUARDED		/* 440 errata, needs G set */
 	beq	1f				/* nope, leave U bits empty */
 	rlwimi	r11,r11,3,26,28			/* yes, copy S bits to U */
 1:	tlbwe	r11,r13,PPC44x_TLB_ATTRIB	/* Write ATTRIB */
Index: linux-work/arch/powerpc/mm/hash_low_32.S
===================================================================
--- linux-work.orig/arch/powerpc/mm/hash_low_32.S	2008-12-15 14:37:33.000000000 +1100
+++ linux-work/arch/powerpc/mm/hash_low_32.S	2008-12-15 14:38:00.000000000 +1100
@@ -323,8 +323,8 @@ _GLOBAL(create_hpte)
 	ori	r8,r8,0xe14		/* clear out reserved bits and M */
 	andc	r8,r5,r8		/* PP = user? (rw&dirty? 2: 3): 0 */
 BEGIN_FTR_SECTION
-	ori	r8,r8,_PAGE_COHERENT	/* set M (coherence required) */
-END_FTR_SECTION_IFSET(CPU_FTR_NEED_COHERENT)
+	rlwinm	r8,r8,0,~_PAGE_COHERENT	/* clear M (coherence not required) */
+END_FTR_SECTION_IFCLR(CPU_FTR_NEED_COHERENT)
 #ifdef CONFIG_PTE_64BIT
 	/* Put the XPN bits into the PTE */
 	rlwimi	r8,r10,8,20,22
Index: linux-work/arch/powerpc/include/asm/pgtable-ppc64.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/pgtable-ppc64.h	2008-11-24 14:48:55.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/pgtable-ppc64.h	2008-12-15 14:38:00.000000000 +1100
@@ -245,9 +245,6 @@ static inline int pte_young(pte_t pte) {
 static inline int pte_file(pte_t pte) { return pte_val(pte) & _PAGE_FILE;}
 static inline int pte_special(pte_t pte) { return pte_val(pte) & _PAGE_SPECIAL; }
 
-static inline void pte_uncache(pte_t pte) { pte_val(pte) |= _PAGE_NO_CACHE; }
-static inline void pte_cache(pte_t pte)   { pte_val(pte) &= ~_PAGE_NO_CACHE; }
-
 static inline pte_t pte_wrprotect(pte_t pte) {
 	pte_val(pte) &= ~(_PAGE_RW); return pte; }
 static inline pte_t pte_mkclean(pte_t pte) {
@@ -405,16 +402,6 @@ static inline void __ptep_set_access_fla
 	__changed;							   \
 })
 
-/*
- * Macro to mark a page protection value as "uncacheable".
- */
-#define pgprot_noncached(prot)	(__pgprot(pgprot_val(prot) | _PAGE_NO_CACHE | _PAGE_GUARDED))
-
-struct file;
-extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
-				     unsigned long size, pgprot_t vma_prot);
-#define __HAVE_PHYS_MEM_ACCESS_PROT
-
 #define __HAVE_ARCH_PTE_SAME
 #define pte_same(A,B)	(((pte_val(A) ^ pte_val(B)) & ~_PAGE_HPTEFLAGS) == 0)
 
Index: linux-work/arch/powerpc/include/asm/pgtable.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/pgtable.h	2008-09-29 14:21:37.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/pgtable.h	2008-12-15 14:38:00.000000000 +1100
@@ -16,6 +16,32 @@ struct mm_struct;
 #endif
 
 #ifndef __ASSEMBLY__
+
+/*
+ * Macro to mark a page protection value as "uncacheable".
+ */
+
+#define _PAGE_CACHE_CTL	(_PAGE_COHERENT | _PAGE_COHERENT | _PAGE_COHERENT | \
+ 			 _PAGE_WRITETHRU)
+
+#define pgprot_noncached(prot)	  (__pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) | \
+				            _PAGE_NO_CACHE | _PAGE_GUARDED))
+
+#define pgprot_noncached_wc(prot) (__pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) | \
+				            _PAGE_NO_CACHE))
+
+#define pgprot_cached(prot)       (__pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) | \
+				            _PAGE_COHERENT))
+
+#define pgprot_cached_wthru(prot) (__pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) | \
+				            _PAGE_COHERENT | _PAGE_WRITETHRU))
+
+
+struct file;
+extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
+				     unsigned long size, pgprot_t vma_prot);
+#define __HAVE_PHYS_MEM_ACCESS_PROT
+
 /*
  * ZERO_PAGE is a global shared page that is always zero: used
  * for zero-mapped memory areas etc..
Index: linux-work/arch/powerpc/kernel/pci-common.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/pci-common.c	2008-12-15 14:36:20.000000000 +1100
+++ linux-work/arch/powerpc/kernel/pci-common.c	2008-12-15 14:38:00.000000000 +1100
@@ -372,13 +372,10 @@ static pgprot_t __pci_mmap_set_pgprot(st
 	}
 
 	/* XXX would be nice to have a way to ask for write-through */
-	prot |= _PAGE_NO_CACHE;
 	if (write_combine)
-		prot &= ~_PAGE_GUARDED;
+		return pgprot_noncached_wc(prot);
 	else
-		prot |= _PAGE_GUARDED;
-
-	return __pgprot(prot);
+		return pgprot_noncached(prot);
 }
 
 /*
@@ -389,19 +386,17 @@ static pgprot_t __pci_mmap_set_pgprot(st
 pgprot_t pci_phys_mem_access_prot(struct file *file,
 				  unsigned long pfn,
 				  unsigned long size,
-				  pgprot_t protection)
+				  pgprot_t prot)
 {
 	struct pci_dev *pdev = NULL;
 	struct resource *found = NULL;
-	unsigned long prot = pgprot_val(protection);
 	resource_size_t offset = ((resource_size_t)pfn) << PAGE_SHIFT;
 	int i;
 
 	if (page_is_ram(pfn))
-		return __pgprot(prot);
-
-	prot |= _PAGE_NO_CACHE | _PAGE_GUARDED;
+		return prot;
 
+	prot = pgprot_noncached(prot);
 	for_each_pci_dev(pdev) {
 		for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
 			struct resource *rp = &pdev->resource[i];
@@ -422,14 +417,14 @@ pgprot_t pci_phys_mem_access_prot(struct
 	}
 	if (found) {
 		if (found->flags & IORESOURCE_PREFETCH)
-			prot &= ~_PAGE_GUARDED;
+			prot = pgprot_noncached_wc(prot);
 		pci_dev_put(pdev);
 	}
 
 	pr_debug("PCI: Non-PCI map for %llx, prot: %lx\n",
-		 (unsigned long long)offset, prot);
+		 (unsigned long long)offset, pgprot_val(prot));
 
-	return __pgprot(prot);
+	return prot;
 }
 
 
@@ -585,8 +580,7 @@ int pci_mmap_legacy_page_range(struct pc
 	pr_debug(" -> mapping phys %llx\n", (unsigned long long)offset);
 
 	vma->vm_pgoff = offset >> PAGE_SHIFT;
-	vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
-				     | _PAGE_NO_CACHE | _PAGE_GUARDED);
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
 			       vma->vm_end - vma->vm_start,
 			       vma->vm_page_prot);
Index: linux-work/arch/powerpc/mm/mem.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/mem.c	2008-12-15 14:36:20.000000000 +1100
+++ linux-work/arch/powerpc/mm/mem.c	2008-12-15 14:38:00.000000000 +1100
@@ -102,8 +102,8 @@ pgprot_t phys_mem_access_prot(struct fil
 		return ppc_md.phys_mem_access_prot(file, pfn, size, vma_prot);
 
 	if (!page_is_ram(pfn))
-		vma_prot = __pgprot(pgprot_val(vma_prot)
-				    | _PAGE_GUARDED | _PAGE_NO_CACHE);
+		vma_prot = pgprot_noncached(vma_prot);
+
 	return vma_prot;
 }
 EXPORT_SYMBOL(phys_mem_access_prot);
Index: linux-work/arch/powerpc/platforms/cell/spufs/file.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/cell/spufs/file.c	2008-12-08 15:40:33.000000000 +1100
+++ linux-work/arch/powerpc/platforms/cell/spufs/file.c	2008-12-15 14:38:00.000000000 +1100
@@ -273,12 +273,10 @@ spufs_mem_mmap_fault(struct vm_area_stru
 		return VM_FAULT_NOPAGE;
 
 	if (ctx->state == SPU_STATE_SAVED) {
-		vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
-							& ~_PAGE_NO_CACHE);
+		vma->vm_page_prot = pgprot_cached(vma->vm_page_prot);
 		pfn = vmalloc_to_pfn(ctx->csa.lscsa->ls + offset);
 	} else {
-		vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
-					     | _PAGE_NO_CACHE);
+		vma->vm_page_prot = pgprot_noncached_wc(vma->vm_page_prot);
 		pfn = (ctx->spu->local_store_phys + offset) >> PAGE_SHIFT;
 	}
 	vm_insert_pfn(vma, address, pfn);
@@ -338,8 +336,7 @@ static int spufs_mem_mmap(struct file *f
 		return -EINVAL;
 
 	vma->vm_flags |= VM_IO | VM_PFNMAP;
-	vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
-				     | _PAGE_NO_CACHE);
+	vma->vm_page_prot = pgprot_noncached_wc(vma->vm_page_prot);
 
 	vma->vm_ops = &spufs_mem_mmap_vmops;
 	return 0;
@@ -452,8 +449,7 @@ static int spufs_cntl_mmap(struct file *
 		return -EINVAL;
 
 	vma->vm_flags |= VM_IO | VM_PFNMAP;
-	vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
-				     | _PAGE_NO_CACHE | _PAGE_GUARDED);
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
 	vma->vm_ops = &spufs_cntl_mmap_vmops;
 	return 0;
@@ -1155,8 +1151,7 @@ static int spufs_signal1_mmap(struct fil
 		return -EINVAL;
 
 	vma->vm_flags |= VM_IO | VM_PFNMAP;
-	vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
-				     | _PAGE_NO_CACHE | _PAGE_GUARDED);
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
 	vma->vm_ops = &spufs_signal1_mmap_vmops;
 	return 0;
@@ -1292,8 +1287,7 @@ static int spufs_signal2_mmap(struct fil
 		return -EINVAL;
 
 	vma->vm_flags |= VM_IO | VM_PFNMAP;
-	vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
-				     | _PAGE_NO_CACHE | _PAGE_GUARDED);
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
 	vma->vm_ops = &spufs_signal2_mmap_vmops;
 	return 0;
@@ -1414,8 +1408,7 @@ static int spufs_mss_mmap(struct file *f
 		return -EINVAL;
 
 	vma->vm_flags |= VM_IO | VM_PFNMAP;
-	vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
-				     | _PAGE_NO_CACHE | _PAGE_GUARDED);
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
 	vma->vm_ops = &spufs_mss_mmap_vmops;
 	return 0;
@@ -1476,8 +1469,7 @@ static int spufs_psmap_mmap(struct file 
 		return -EINVAL;
 
 	vma->vm_flags |= VM_IO | VM_PFNMAP;
-	vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
-				     | _PAGE_NO_CACHE | _PAGE_GUARDED);
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
 	vma->vm_ops = &spufs_psmap_mmap_vmops;
 	return 0;
@@ -1536,8 +1528,7 @@ static int spufs_mfc_mmap(struct file *f
 		return -EINVAL;
 
 	vma->vm_flags |= VM_IO | VM_PFNMAP;
-	vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
-				     | _PAGE_NO_CACHE | _PAGE_GUARDED);
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
 	vma->vm_ops = &spufs_mfc_mmap_vmops;
 	return 0;
Index: linux-work/drivers/video/controlfb.c
===================================================================
--- linux-work.orig/drivers/video/controlfb.c	2008-07-07 13:45:06.000000000 +1000
+++ linux-work/drivers/video/controlfb.c	2008-12-15 14:38:00.000000000 +1100
@@ -298,10 +298,10 @@ static int controlfb_mmap(struct fb_info
                        return -EINVAL;
                start = info->fix.mmio_start;
                len = PAGE_ALIGN((start & ~PAGE_MASK)+info->fix.mmio_len);
-               pgprot_val(vma->vm_page_prot) |= _PAGE_NO_CACHE|_PAGE_GUARDED;
+	       vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
        } else {
                /* framebuffer */
-               pgprot_val(vma->vm_page_prot) |= _PAGE_WRITETHRU;
+	       vma->vm_page_prot = pgprot_cached_wthru(vma->vm_page_prot);
        }
        start &= PAGE_MASK;
        if ((vma->vm_end - vma->vm_start + off) > len)
