Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDxh5qwkzDqBW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:26:48 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 07/70] powerpc/mm: Use _PAGE_READ to indicate Read access
Date: Fri, 29 Apr 2016 23:25:30 +1000
Message-Id: <1461936393-10131-7-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
References: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

This splits the _PAGE_RW bit into _PAGE_READ and _PAGE_WRITE. It also
removes the dependency on _PAGE_USER for implying read only. Few things
to note here is that, we have read implied with write and execute
permission. Hence we should always find _PAGE_READ set on hash pte
fault.

We still can't switch PROT_NONE to !(_PAGE_RWX). Auto numa depends on
marking a prot none pte _PAGE_WRITE. (For more details look at
b191f9b106ea "mm: numa: preserve PTE write permissions across a NUMA
hinting fault")

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jeremy Kerr <jk@ozlabs.org>
Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Acked-by: Ian Munsie <imunsie@au1.ibm.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
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
index f4949f117057..f4650504a61e 100644
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
index 22064bd329f2..fb76f9cf49c9 100644
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
@@ -145,8 +147,8 @@
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
@@ -171,10 +173,12 @@
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
@@ -296,19 +300,19 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
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
@@ -349,7 +353,7 @@ static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
 {
 	__be64 old, tmp, val, mask;
 
-	mask = cpu_to_be64(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW |
+	mask = cpu_to_be64(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_READ | _PAGE_WRITE |
 			   _PAGE_EXEC | _PAGE_SOFT_DIRTY);
 
 	val = pte_raw(entry) & mask;
@@ -384,7 +388,7 @@ static inline unsigned long pgd_page_vaddr(pgd_t pgd)
 
 
 /* Generic accessors to PTE bits */
-static inline int pte_write(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_RW);}
+static inline int pte_write(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_WRITE);}
 static inline int pte_dirty(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_DIRTY); }
 static inline int pte_young(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_ACCESSED); }
 static inline int pte_special(pte_t pte)	{ return !!(pte_val(pte) & _PAGE_SPECIAL); }
@@ -445,7 +449,7 @@ static inline unsigned long pte_pfn(pte_t pte)
 /* Generic modifiers for PTE bits */
 static inline pte_t pte_wrprotect(pte_t pte)
 {
-	return __pte(pte_val(pte) & ~_PAGE_RW);
+	return __pte(pte_val(pte) & ~_PAGE_WRITE);
 }
 
 static inline pte_t pte_mkclean(pte_t pte)
@@ -460,6 +464,9 @@ static inline pte_t pte_mkold(pte_t pte)
 
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
index dbd3133a8562..491b7d137cd8 100644
--- a/arch/powerpc/mm/hash64_4k.c
+++ b/arch/powerpc/mm/hash64_4k.c
@@ -45,7 +45,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 		 * also add _PAGE_COMBO
 		 */
 		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED;
-		if (access & _PAGE_RW)
+		if (access & _PAGE_WRITE)
 			new_pte |= _PAGE_DIRTY;
 	} while (!pte_xchg(ptep, __pte(old_pte), __pte(new_pte)));
 
diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
index 292f40705674..2d3472173d79 100644
--- a/arch/powerpc/mm/hash64_64k.c
+++ b/arch/powerpc/mm/hash64_64k.c
@@ -77,7 +77,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 		 * also add _PAGE_COMBO
 		 */
 		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED | _PAGE_COMBO;
-		if (access & _PAGE_RW)
+		if (access & _PAGE_WRITE)
 			new_pte |= _PAGE_DIRTY;
 	} while (!pte_xchg(ptep, __pte(old_pte), __pte(new_pte)));
 
@@ -251,7 +251,7 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
 		 * a write access.
 		 */
 		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED;
-		if (access & _PAGE_RW)
+		if (access & _PAGE_WRITE)
 			new_pte |= _PAGE_DIRTY;
 	} while (!pte_xchg(ptep, __pte(old_pte), __pte(new_pte)));
 
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 7635b1c6b5da..ed190e42bbc5 100644
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
@@ -1209,7 +1210,7 @@ EXPORT_SYMBOL_GPL(hash_page);
 int __hash_page(unsigned long ea, unsigned long msr, unsigned long trap,
 		unsigned long dsisr)
 {
-	unsigned long access = _PAGE_PRESENT;
+	unsigned long access = _PAGE_PRESENT | _PAGE_READ;
 	unsigned long flags = 0;
 	struct mm_struct *mm = current->mm;
 
@@ -1220,7 +1221,7 @@ int __hash_page(unsigned long ea, unsigned long msr, unsigned long trap,
 		flags |= HPTE_NOHPTE_UPDATE;
 
 	if (dsisr & DSISR_ISSTORE)
-		access |= _PAGE_RW;
+		access |= _PAGE_WRITE;
 	/*
 	 * We need to set the _PAGE_USER bit if MSR_PR is set or if we are
 	 * accessing a userspace segment (even from the kernel). We assume
diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/hugepage-hash64.c
index 92c3c1858707..b4b6668d1b24 100644
--- a/arch/powerpc/mm/hugepage-hash64.c
+++ b/arch/powerpc/mm/hugepage-hash64.c
@@ -47,7 +47,7 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 		 * a write access
 		 */
 		new_pmd = old_pmd | _PAGE_BUSY | _PAGE_ACCESSED;
-		if (access & _PAGE_RW)
+		if (access & _PAGE_WRITE)
 			new_pmd |= _PAGE_DIRTY;
 	} while (!pmd_xchg(pmdp, __pmd(old_pmd), __pmd(new_pmd)));
 
diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
index 9c0518761279..cdca743cdaf1 100644
--- a/arch/powerpc/mm/hugetlbpage-hash64.c
+++ b/arch/powerpc/mm/hugetlbpage-hash64.c
@@ -55,7 +55,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 		/* Try to lock the PTE, add ACCESSED and DIRTY if it was
 		 * a write access */
 		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED;
-		if (access & _PAGE_RW)
+		if (access & _PAGE_WRITE)
 			new_pte |= _PAGE_DIRTY;
 	} while(!pte_xchg(ptep, __pte(old_pte), __pte(new_pte)));
 
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index d991b9e80dbb..0bf269b00de9 100644
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
index de37ff445362..ef7b922c655c 100644
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
index 494fc111ef90..16bc751f10df 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -277,7 +277,7 @@ void __iomem * ioremap_prot(phys_addr_t addr, unsigned long size,
 	void *caller = __builtin_return_address(0);
 
 	/* writeable implies dirty for kernel addresses */
-	if (flags & _PAGE_RW)
+	if (flags & _PAGE_WRITE)
 		flags |= _PAGE_DIRTY;
 
 	/* we don't want to let _PAGE_USER and _PAGE_EXEC leak out */
@@ -676,8 +676,7 @@ void set_pmd_at(struct mm_struct *mm, unsigned long addr,
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
index 3ede04ffdeea..3cbe38fad609 100644
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
index 9a236543da23..0feeacedcef1 100644
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
 	if ((!ctx->kernel) || (REGION_ID(dar) == USER_REGION_ID))
 		access |= _PAGE_USER;
 
-- 
2.5.0
