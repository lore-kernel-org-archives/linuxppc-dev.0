Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qXqp95X86zDq5j
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 19:24:33 +1100 (AEDT)
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 27 Mar 2016 02:24:31 -0600
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 8201A19D803F
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 02:12:22 -0600 (MDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2R8OSNm32112780
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 08:24:28 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2R8OSKT013004
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 04:24:28 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 02/65] powerpc/mm: use _PAGE_READ to indicate Read access
Date: Sun, 27 Mar 2016 13:53:10 +0530
Message-Id: <1459067053-10835-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This split _PAGE_RW bit to _PAGE_READ and _PAGE_WRITE. It also remove
the dependency on _PAGE_USER for implying read only. Few things to note
here is that, we have read implied with write and execute permission.
Hence we should always find _PAGE_READ set on hash pte fault.

We still can't switch PROT_NONE to !(_PAGE_RWX). Auto numa do depend
on marking a prot none pte _PAGE_WRITE. (For more details look at
b191f9b106ea "mm: numa: preserve PTE write permissions across a NUMA hinting fault")

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-64k.h |  4 +--
 arch/powerpc/include/asm/book3s/64/hash.h     | 35 ++++++++++++++++-----------
 arch/powerpc/include/asm/pte-common.h         |  5 ++++
 arch/powerpc/mm/hash64_4k.c                   |  2 +-
 arch/powerpc/mm/hash64_64k.c                  |  4 +--
 arch/powerpc/mm/hash_utils_64.c               |  9 ++++---
 arch/powerpc/mm/hugepage-hash64.c             |  2 +-
 arch/powerpc/mm/hugetlbpage-hash64.c          |  2 +-
 arch/powerpc/mm/hugetlbpage.c                 |  4 +--
 arch/powerpc/mm/pgtable.c                     |  4 +--
 arch/powerpc/mm/pgtable_64.c                  |  5 ++--
 arch/powerpc/platforms/cell/spu_base.c        |  2 +-
 arch/powerpc/platforms/cell/spufs/fault.c     |  4 +--
 drivers/misc/cxl/fault.c                      |  4 +--
 14 files changed, 49 insertions(+), 37 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index 0a7956a80a08..279ded72f1db 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -291,10 +291,10 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 				      pmd_t *pmdp)
 {
 
-	if ((pmd_val(*pmdp) & _PAGE_RW) == 0)
+	if ((pmd_val(*pmdp) & _PAGE_WRITE) == 0)
 		return;
 
-	pmd_hugepage_update(mm, addr, pmdp, _PAGE_RW, 0);
+	pmd_hugepage_update(mm, addr, pmdp, _PAGE_WRITE, 0);
 }
 
 #endif /*  CONFIG_TRANSPARENT_HUGEPAGE */
diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 2113de051824..f092d83fa623 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -16,8 +16,10 @@
 #define _PAGE_BIT_SWAP_TYPE	0
 
 #define _PAGE_EXEC		0x00001 /* execute permission */
-#define _PAGE_RW		0x00002 /* read & write access allowed */
+#define _PAGE_WRITE		0x00002 /* write access allowed */
 #define _PAGE_READ		0x00004	/* read access allowed */
+#define _PAGE_RW		(_PAGE_READ | _PAGE_WRITE)
+#define _PAGE_RWX		(_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC)
 #define _PAGE_USER		0x00008 /* page may be accessed by userspace */
 #define _PAGE_GUARDED		0x00010 /* G: guarded (side-effect) page */
 /* M (memory coherence) is always set in the HPTE, so we don't need it here */
@@ -147,8 +149,8 @@
  */
 #define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT | _PAGE_NO_CACHE | \
 			 _PAGE_WRITETHRU | _PAGE_4K_PFN | \
-			 _PAGE_USER | _PAGE_ACCESSED |  \
-			 _PAGE_RW |  _PAGE_DIRTY | _PAGE_EXEC | \
+			 _PAGE_USER | _PAGE_ACCESSED |  _PAGE_READ |\
+			 _PAGE_WRITE |  _PAGE_DIRTY | _PAGE_EXEC | \
 			 _PAGE_SOFT_DIRTY)
 /*
  * We define 2 sets of base prot bits, one for basic pages (ie,
@@ -173,10 +175,12 @@
 #define PAGE_SHARED	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW)
 #define PAGE_SHARED_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW | \
 				 _PAGE_EXEC)
-#define PAGE_COPY	__pgprot(_PAGE_BASE | _PAGE_USER )
-#define PAGE_COPY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_EXEC)
-#define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_USER )
-#define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_EXEC)
+#define PAGE_COPY	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_READ)
+#define PAGE_COPY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_READ| \
+				 _PAGE_EXEC)
+#define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_READ)
+#define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_READ| \
+				 _PAGE_EXEC)
 
 #define __P000	PAGE_NONE
 #define __P001	PAGE_READONLY
@@ -300,19 +304,19 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 				      pte_t *ptep)
 {
 
-	if ((pte_val(*ptep) & _PAGE_RW) == 0)
+	if ((pte_val(*ptep) & _PAGE_WRITE) == 0)
 		return;
 
-	pte_update(mm, addr, ptep, _PAGE_RW, 0, 0);
+	pte_update(mm, addr, ptep, _PAGE_WRITE, 0, 0);
 }
 
 static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 					   unsigned long addr, pte_t *ptep)
 {
-	if ((pte_val(*ptep) & _PAGE_RW) == 0)
+	if ((pte_val(*ptep) & _PAGE_WRITE) == 0)
 		return;
 
-	pte_update(mm, addr, ptep, _PAGE_RW, 0, 1);
+	pte_update(mm, addr, ptep, _PAGE_WRITE, 0, 1);
 }
 
 /*
@@ -352,7 +356,7 @@ static inline void pte_clear(struct mm_struct *mm, unsigned long addr,
 static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
 {
 	unsigned long bits = pte_val(entry) &
-		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC |
+		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_READ | _PAGE_WRITE | _PAGE_EXEC |
 		 _PAGE_SOFT_DIRTY);
 
 	unsigned long old, tmp;
@@ -386,7 +390,7 @@ static inline unsigned long pgd_page_vaddr(pgd_t pgd)
 
 
 /* Generic accessors to PTE bits */
-static inline int pte_write(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_RW);}
+static inline int pte_write(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_WRITE);}
 static inline int pte_dirty(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_DIRTY); }
 static inline int pte_young(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_ACCESSED); }
 static inline int pte_special(pte_t pte)	{ return !!(pte_val(pte) & _PAGE_SPECIAL); }
@@ -447,7 +451,7 @@ static inline unsigned long pte_pfn(pte_t pte)
 /* Generic modifiers for PTE bits */
 static inline pte_t pte_wrprotect(pte_t pte)
 {
-	return __pte(pte_val(pte) & ~_PAGE_RW);
+	return __pte(pte_val(pte) & ~_PAGE_WRITE);
 }
 
 static inline pte_t pte_mkclean(pte_t pte)
@@ -462,6 +466,9 @@ static inline pte_t pte_mkold(pte_t pte)
 
 static inline pte_t pte_mkwrite(pte_t pte)
 {
+	/*
+	 * write implies read, hence set both
+	 */
 	return __pte(pte_val(pte) | _PAGE_RW);
 }
 
diff --git a/arch/powerpc/include/asm/pte-common.h b/arch/powerpc/include/asm/pte-common.h
index 1ec67b043065..9f5dea58b0db 100644
--- a/arch/powerpc/include/asm/pte-common.h
+++ b/arch/powerpc/include/asm/pte-common.h
@@ -198,3 +198,8 @@ extern unsigned long bad_call_to_PMD_PAGE_SIZE(void);
 /* Advertise support for _PAGE_SPECIAL */
 #define __HAVE_ARCH_PTE_SPECIAL
 
+#ifndef _PAGE_READ
+/* if not defined, we should not find _PAGE_WRITE too */
+#define _PAGE_READ 0
+#define _PAGE_WRITE _PAGE_RW
+#endif
diff --git a/arch/powerpc/mm/hash64_4k.c b/arch/powerpc/mm/hash64_4k.c
index 71abd4c44c27..7ebac279d38e 100644
--- a/arch/powerpc/mm/hash64_4k.c
+++ b/arch/powerpc/mm/hash64_4k.c
@@ -46,7 +46,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 		 * also add _PAGE_COMBO
 		 */
 		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED;
-		if (access & _PAGE_RW)
+		if (access & _PAGE_WRITE)
 			new_pte |= _PAGE_DIRTY;
 
 		opte = cpu_to_be64(old_pte);
diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
index 6f9b3c34a5c0..83ac9f658733 100644
--- a/arch/powerpc/mm/hash64_64k.c
+++ b/arch/powerpc/mm/hash64_64k.c
@@ -78,7 +78,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 		 * also add _PAGE_COMBO
 		 */
 		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED | _PAGE_COMBO;
-		if (access & _PAGE_RW)
+		if (access & _PAGE_WRITE)
 			new_pte |= _PAGE_DIRTY;
 
 		opte = cpu_to_be64(old_pte);
@@ -255,7 +255,7 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
 		 * a write access.
 		 */
 		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED;
-		if (access & _PAGE_RW)
+		if (access & _PAGE_WRITE)
 			new_pte |= _PAGE_DIRTY;
 		opte = cpu_to_be64(old_pte);
 		npte = cpu_to_be64(new_pte);
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 90dd9280894f..ea23403b3fc0 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -175,8 +175,9 @@ unsigned long htab_convert_pte_flags(unsigned long pteflags)
 	 * or PP=0x3 for read-only (including writeable but clean pages).
 	 */
 	if (pteflags & _PAGE_USER) {
-		rflags |= 0x2;
-		if (!((pteflags & _PAGE_RW) && (pteflags & _PAGE_DIRTY)))
+		if (pteflags & _PAGE_RWX)
+			rflags |= 0x2;
+		if (!((pteflags & _PAGE_WRITE) && (pteflags & _PAGE_DIRTY)))
 			rflags |= 0x1;
 	}
 	/*
@@ -1205,7 +1206,7 @@ EXPORT_SYMBOL_GPL(hash_page);
 int __hash_page(unsigned long ea, unsigned long msr, unsigned long trap,
 		unsigned long dsisr)
 {
-	unsigned long access = _PAGE_PRESENT;
+	unsigned long access = _PAGE_PRESENT | _PAGE_READ;
 	unsigned long flags = 0;
 	struct mm_struct *mm = current->mm;
 
@@ -1216,7 +1217,7 @@ int __hash_page(unsigned long ea, unsigned long msr, unsigned long trap,
 		flags |= HPTE_NOHPTE_UPDATE;
 
 	if (dsisr & DSISR_ISSTORE)
-		access |= _PAGE_RW;
+		access |= _PAGE_WRITE;
 	/*
 	 * We need to set the _PAGE_USER bit if MSR_PR is set or if we are
 	 * accessing a userspace segment (even from the kernel). We assume
diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/hugepage-hash64.c
index 98891139c044..39342638a498 100644
--- a/arch/powerpc/mm/hugepage-hash64.c
+++ b/arch/powerpc/mm/hugepage-hash64.c
@@ -48,7 +48,7 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 		 * a write access
 		 */
 		new_pmd = old_pmd | _PAGE_BUSY | _PAGE_ACCESSED;
-		if (access & _PAGE_RW)
+		if (access & _PAGE_WRITE)
 			new_pmd |= _PAGE_DIRTY;
 		opmd = cpu_to_be64(old_pmd);
 		npmd = cpu_to_be64(new_pmd);
diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
index 5bcb28606158..e6e54a04bd32 100644
--- a/arch/powerpc/mm/hugetlbpage-hash64.c
+++ b/arch/powerpc/mm/hugetlbpage-hash64.c
@@ -56,7 +56,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 		/* Try to lock the PTE, add ACCESSED and DIRTY if it was
 		 * a write access */
 		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED;
-		if (access & _PAGE_RW)
+		if (access & _PAGE_WRITE)
 			new_pte |= _PAGE_DIRTY;
 		opte = cpu_to_be64(old_pte);
 		npte = cpu_to_be64(new_pte);
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 6dd272b6196f..6e52e722d3f2 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -1003,9 +1003,9 @@ int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 		end = pte_end;
 
 	pte = READ_ONCE(*ptep);
-	mask = _PAGE_PRESENT | _PAGE_USER;
+	mask = _PAGE_PRESENT | _PAGE_USER | _PAGE_READ;
 	if (write)
-		mask |= _PAGE_RW;
+		mask |= _PAGE_WRITE;
 
 	if ((pte_val(pte) & mask) != mask)
 		return 0;
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 83dfd7925c72..98b5c03e344d 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -177,8 +177,8 @@ void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
 	 * _PAGE_PRESENT, but we can be sure that it is not in hpte.
 	 * Hence we can use set_pte_at for them.
 	 */
-	VM_WARN_ON((pte_val(*ptep) & (_PAGE_PRESENT | _PAGE_USER)) ==
-		(_PAGE_PRESENT | _PAGE_USER));
+	VM_WARN_ON(pte_present(*ptep) && !pte_protnone(*ptep));
+
 	/*
 	 * Add the pte bit when tryint set a pte
 	 */
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index aa742aa35b64..00d8d985bba3 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -277,7 +277,7 @@ void __iomem * ioremap_prot(phys_addr_t addr, unsigned long size,
 	void *caller = __builtin_return_address(0);
 
 	/* writeable implies dirty for kernel addresses */
-	if (flags & _PAGE_RW)
+	if (flags & _PAGE_WRITE)
 		flags |= _PAGE_DIRTY;
 
 	/* we don't want to let _PAGE_USER and _PAGE_EXEC leak out */
@@ -681,8 +681,7 @@ void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 		pmd_t *pmdp, pmd_t pmd)
 {
 #ifdef CONFIG_DEBUG_VM
-	WARN_ON((pmd_val(*pmdp) & (_PAGE_PRESENT | _PAGE_USER)) ==
-		(_PAGE_PRESENT | _PAGE_USER));
+	WARN_ON(pte_present(pmd_pte(*pmdp)) && !pte_protnone(pmd_pte(*pmdp)));
 	assert_spin_locked(&mm->page_table_lock);
 	WARN_ON(!pmd_trans_huge(pmd));
 #endif
diff --git a/arch/powerpc/platforms/cell/spu_base.c b/arch/powerpc/platforms/cell/spu_base.c
index f7af74f83693..7bc00b508128 100644
--- a/arch/powerpc/platforms/cell/spu_base.c
+++ b/arch/powerpc/platforms/cell/spu_base.c
@@ -197,7 +197,7 @@ static int __spu_trap_data_map(struct spu *spu, unsigned long ea, u64 dsisr)
 	    (REGION_ID(ea) != USER_REGION_ID)) {
 
 		spin_unlock(&spu->register_lock);
-		ret = hash_page(ea, _PAGE_PRESENT, 0x300, dsisr);
+		ret = hash_page(ea, _PAGE_PRESENT | _PAGE_READ, 0x300, dsisr);
 		spin_lock(&spu->register_lock);
 
 		if (!ret) {
diff --git a/arch/powerpc/platforms/cell/spufs/fault.c b/arch/powerpc/platforms/cell/spufs/fault.c
index d98f845ac777..c3a3bf1745b7 100644
--- a/arch/powerpc/platforms/cell/spufs/fault.c
+++ b/arch/powerpc/platforms/cell/spufs/fault.c
@@ -141,8 +141,8 @@ int spufs_handle_class1(struct spu_context *ctx)
 	/* we must not hold the lock when entering copro_handle_mm_fault */
 	spu_release(ctx);
 
-	access = (_PAGE_PRESENT | _PAGE_USER);
-	access |= (dsisr & MFC_DSISR_ACCESS_PUT) ? _PAGE_RW : 0UL;
+	access = (_PAGE_PRESENT | _PAGE_READ | _PAGE_USER);
+	access |= (dsisr & MFC_DSISR_ACCESS_PUT) ? _PAGE_WRITE : 0UL;
 	local_irq_save(flags);
 	ret = hash_page(ea, access, 0x300, dsisr);
 	local_irq_restore(flags);
diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
index 81c3f75b7330..a3d5e1e16c21 100644
--- a/drivers/misc/cxl/fault.c
+++ b/drivers/misc/cxl/fault.c
@@ -149,9 +149,9 @@ static void cxl_handle_page_fault(struct cxl_context *ctx,
 	 * update_mmu_cache() will not have loaded the hash since current->trap
 	 * is not a 0x400 or 0x300, so just call hash_page_mm() here.
 	 */
-	access = _PAGE_PRESENT;
+	access = _PAGE_PRESENT | _PAGE_READ;
 	if (dsisr & CXL_PSL_DSISR_An_S)
-		access |= _PAGE_RW;
+		access |= _PAGE_WRITE;
 	if ((!ctx->kernel) || ~(dar & (1ULL << 63)))
 		access |= _PAGE_USER;
 
-- 
2.5.0
