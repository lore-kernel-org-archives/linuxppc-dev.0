Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2B8221A01D6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 17:39:13 +1100 (AEDT)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 1 Mar 2016 23:39:12 -0700
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 562333E40047
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 23:39:09 -0700 (MST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u226d9NT33816756
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Mar 2016 06:39:09 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u226Ywuj010093
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Mar 2016 01:34:58 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH] powerpc/mm: Drop WIMG in favour of new constants
Date: Wed,  2 Mar 2016 12:08:41 +0530
Message-Id: <1456900721-11796-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PowerISA 3.0 introduce three pte bits with the below meaning
000 ->  Normal Memory
001 ->  Strong Access Order
010 -> Non idempotent I/O ( Also cache inhibited and guarded)
100 -> Tolerant I/O (Cache inhibited)

We drop the existing WIMG bits in linux page table in favour of above
contants. We loose _PAGE_WRITETHRU with this conversion. We only use
writethru via pgprot_cached_wthru() which is used by fbdev/controlfb.c
which is Apple control display and also PPC32. For now I put a WARN_ON
to catch these usage.

With respect to _PAGE_COHERENCE, we have already been marking hpte
always coherent for some time now. htab_convert_pte_flags always added
HPTE_R_M.

NOTE: KVM changes need closer review.

Not-signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash.h | 37 +++++++++++++------------------
 arch/powerpc/include/asm/kvm_book3s_64.h  | 29 ++++++++++++------------
 arch/powerpc/kvm/book3s_64_mmu_hv.c       | 11 +++++----
 arch/powerpc/kvm/book3s_hv_rm_mmu.c       | 12 +++++-----
 arch/powerpc/mm/hash64_64k.c              |  2 +-
 arch/powerpc/mm/hash_utils_64.c           | 14 ++++++------
 arch/powerpc/mm/pgtable-hash64.c          |  2 +-
 arch/powerpc/mm/pgtable_64.c              |  4 ----
 arch/powerpc/platforms/pseries/lpar.c     |  4 ----
 9 files changed, 50 insertions(+), 65 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 21dce3198314..f0a309992af4 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -23,11 +23,9 @@
 #define _PAGE_READ		0x00004	/* read access allowed */
 #define _PAGE_RWX		(_PAGE_READ | _PAGE_RW | _PAGE_EXEC)
 #define _PAGE_PRIV		0x00008 /* page can only be accessed by kernel*/
-#define _PAGE_GUARDED		0x00010 /* G: guarded (side-effect) page */
-/* M (memory coherence) is always set in the HPTE, so we don't need it here */
-#define _PAGE_COHERENT		0x0
-#define _PAGE_NO_CACHE		0x00020 /* I: cache inhibit */
-#define _PAGE_WRITETHRU		0x00040 /* W: cache write-through */
+#define _PAGE_SAO		0x00010 /* Strong access order */
+#define _PAGE_NON_IDEMPOTENT	0x00020 /* non idempotent memory */
+#define _PAGE_TOLERANT		0x00040 /* tolerant memory, cache inhibited */
 #define _PAGE_DIRTY		0x00080 /* C: page changed */
 #define _PAGE_ACCESSED		0x00100 /* R: page referenced */
 #define _PAGE_SPECIAL		0x00400 /* software: special page */
@@ -125,9 +123,6 @@
 #define _PAGE_KERNEL_RO		 (_PAGE_PRIV | _PAGE_READ)
 #define _PAGE_KERNEL_RWX	(_PAGE_PRIV | _PAGE_DIRTY | _PAGE_RW | _PAGE_EXEC)
 
-/* Strong Access Ordering */
-#define _PAGE_SAO		(_PAGE_WRITETHRU | _PAGE_NO_CACHE | _PAGE_COHERENT)
-
 /* No page size encoding in the linux PTE */
 #define _PAGE_PSIZE		0
 
@@ -153,9 +148,8 @@
 /*
  * Mask of bits returned by pte_pgprot()
  */
-#define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT | _PAGE_NO_CACHE | \
-			 _PAGE_WRITETHRU | _PAGE_4K_PFN | \
-			 _PAGE_PRIV| _PAGE_ACCESSED |  \
+#define PAGE_PROT_BITS	(_PAGE_SAO | _PAGE_NON_IDEMPOTENT | _PAGE_TOLERANT | \
+			 _PAGE_4K_PFN | _PAGE_PRIV | _PAGE_ACCESSED |  \
 			 _PAGE_RW |  _PAGE_DIRTY | _PAGE_EXEC | \
 			 _PAGE_SOFT_DIRTY)
 /*
@@ -165,7 +159,7 @@
  * the processor might need it for DMA coherency.
  */
 #define _PAGE_BASE_NC	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_PSIZE)
-#define _PAGE_BASE	(_PAGE_BASE_NC | _PAGE_COHERENT)
+#define _PAGE_BASE	(_PAGE_BASE_NC)
 
 /* Permission masks used to generate the __P and __S table,
  *
@@ -206,9 +200,9 @@
 /* Permission masks used for kernel mappings */
 #define PAGE_KERNEL	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RW)
 #define PAGE_KERNEL_NC	__pgprot(_PAGE_BASE_NC | _PAGE_KERNEL_RW | \
-				 _PAGE_NO_CACHE)
+				 _PAGE_TOLERANT)
 #define PAGE_KERNEL_NCG	__pgprot(_PAGE_BASE_NC | _PAGE_KERNEL_RW | \
-				 _PAGE_NO_CACHE | _PAGE_GUARDED)
+				 _PAGE_NON_IDEMPOTENT)
 #define PAGE_KERNEL_X	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RWX)
 #define PAGE_KERNEL_RO	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RO)
 #define PAGE_KERNEL_ROX	__pgprot(_PAGE_BASE | _PAGE_KERNEL_ROX)
@@ -490,40 +484,39 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
  * Macro to mark a page protection value as "uncacheable".
  */
 
-#define _PAGE_CACHE_CTL	(_PAGE_COHERENT | _PAGE_GUARDED | _PAGE_NO_CACHE | \
-			 _PAGE_WRITETHRU)
+#define _PAGE_CACHE_CTL	(_PAGE_SAO | _PAGE_NON_IDEMPOTENT | _PAGE_TOLERANT)
 
 #define pgprot_noncached pgprot_noncached
 static inline pgprot_t pgprot_noncached(pgprot_t prot)
 {
 	return __pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) |
-			_PAGE_NO_CACHE | _PAGE_GUARDED);
+			_PAGE_NON_IDEMPOTENT);
 }
 
 #define pgprot_noncached_wc pgprot_noncached_wc
 static inline pgprot_t pgprot_noncached_wc(pgprot_t prot)
 {
 	return __pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) |
-			_PAGE_NO_CACHE);
+			_PAGE_TOLERANT);
 }
 
 #define pgprot_cached pgprot_cached
 static inline pgprot_t pgprot_cached(pgprot_t prot)
 {
-	return __pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) |
-			_PAGE_COHERENT);
+	return __pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL));
 }
 
 #define pgprot_cached_wthru pgprot_cached_wthru
 static inline pgprot_t pgprot_cached_wthru(pgprot_t prot)
 {
-	return __pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) |
-			_PAGE_COHERENT | _PAGE_WRITETHRU);
+	WARN(1, "Not supported\n");
+	return __pgprot(pgprot_val(prot) & ~_PAGE_CACHE_CTL);
 }
 
 #define pgprot_cached_noncoherent pgprot_cached_noncoherent
 static inline pgprot_t pgprot_cached_noncoherent(pgprot_t prot)
 {
+	WARN(1, "Not supported\n");
 	return __pgprot(pgprot_val(prot) & ~_PAGE_CACHE_CTL);
 }
 
diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 508c3741fd6f..33f38ac2cfef 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -278,19 +278,24 @@ static inline unsigned long hpte_make_readonly(unsigned long ptel)
 	return ptel;
 }
 
-static inline int hpte_cache_flags_ok(unsigned long ptel, unsigned long io_type)
+static inline bool hpte_cache_flags_ok(unsigned long hptel, bool is_ci)
 {
-	unsigned int wimg = ptel & HPTE_R_WIMG;
+	unsigned int wimg = hptel & HPTE_R_WIMG;
 
 	/* Handle SAO */
 	if (wimg == (HPTE_R_W | HPTE_R_I | HPTE_R_M) &&
 	    cpu_has_feature(CPU_FTR_ARCH_206))
 		wimg = HPTE_R_M;
 
-	if (!io_type)
+	if (!is_ci)
 		return wimg == HPTE_R_M;
-
-	return (wimg & (HPTE_R_W | HPTE_R_I)) == io_type;
+	/*
+	 * if host is mapped cache inhibited, make sure hptel also have
+	 * cache inhibited.
+	 */
+	if (wimg & HPTE_R_W) /* FIXME!! is this ok for all guest. ? */
+		return false;
+	return !!(wimg & HPTE_R_I);
 }
 
 /*
@@ -332,16 +337,12 @@ static inline pte_t kvmppc_read_update_linux_pte(pte_t *ptep, int writing)
 	return new_pte;
 }
 
-
-/* Return HPTE cache control bits corresponding to Linux pte bits */
-static inline unsigned long hpte_cache_bits(unsigned long pte_val)
+/*
+ * check whether the mapping is cache inhibited
+ */
+static inline bool hpte_is_cache_inhibited(unsigned long pte_val)
 {
-#if _PAGE_NO_CACHE == HPTE_R_I && _PAGE_WRITETHRU == HPTE_R_W
-	return pte_val & (HPTE_R_W | HPTE_R_I);
-#else
-	return ((pte_val & _PAGE_NO_CACHE) ? HPTE_R_I : 0) +
-		((pte_val & _PAGE_WRITETHRU) ? HPTE_R_W : 0);
-#endif
+	return !!(pte_val & (_PAGE_TOLERANT | _PAGE_NON_IDEMPOTENT));
 }
 
 static inline bool hpte_read_permission(unsigned long pp, unsigned long key)
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index c7b78d8336b2..40ad06c41ca1 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -447,7 +447,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	struct revmap_entry *rev;
 	struct page *page, *pages[1];
 	long index, ret, npages;
-	unsigned long is_io;
+	bool is_ci;
 	unsigned int writing, write_ok;
 	struct vm_area_struct *vma;
 	unsigned long rcbits;
@@ -503,7 +503,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	smp_rmb();
 
 	ret = -EFAULT;
-	is_io = 0;
+	is_ci = false;
 	pfn = 0;
 	page = NULL;
 	pte_size = PAGE_SIZE;
@@ -521,7 +521,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			pfn = vma->vm_pgoff +
 				((hva - vma->vm_start) >> PAGE_SHIFT);
 			pte_size = psize;
-			is_io = hpte_cache_bits(pgprot_val(vma->vm_page_prot));
+			is_ci = hpte_is_cache_inhibited(pgprot_val(vma->vm_page_prot));
 			write_ok = vma->vm_flags & VM_WRITE;
 		}
 		up_read(&current->mm->mmap_sem);
@@ -558,10 +558,9 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		goto out_put;
 
 	/* Check WIMG vs. the actual page we're accessing */
-	if (!hpte_cache_flags_ok(r, is_io)) {
-		if (is_io)
+	if (!hpte_cache_flags_ok(r, is_ci)) {
+		if (is_ci)
 			goto out_put;
-
 		/*
 		 * Allow guest to map emulated device memory as
 		 * uncacheable, but actually make it cacheable.
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 4cb8db05f3e5..3ebd620589a9 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -175,7 +175,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 	unsigned long g_ptel;
 	struct kvm_memory_slot *memslot;
 	unsigned hpage_shift;
-	unsigned long is_io;
+	bool is_ci;
 	unsigned long *rmap;
 	pte_t *ptep;
 	unsigned int writing;
@@ -199,7 +199,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 	gfn = gpa >> PAGE_SHIFT;
 	memslot = __gfn_to_memslot(kvm_memslots_raw(kvm), gfn);
 	pa = 0;
-	is_io = ~0ul;
+	is_ci = false;
 	rmap = NULL;
 	if (!(memslot && !(memslot->flags & KVM_MEMSLOT_INVALID))) {
 		/* Emulated MMIO - mark this with key=31 */
@@ -250,7 +250,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 			if (writing && !pte_write(pte))
 				/* make the actual HPTE be read-only */
 				ptel = hpte_make_readonly(ptel);
-			is_io = hpte_cache_bits(pte_val(pte));
+			is_ci = hpte_is_cache_inhibited(pte_val(pte));
 			pa = pte_pfn(pte) << PAGE_SHIFT;
 			pa |= hva & (host_pte_size - 1);
 			pa |= gpa & ~PAGE_MASK;
@@ -267,9 +267,9 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 	else
 		pteh |= HPTE_V_ABSENT;
 
-	/* Check WIMG */
-	if (is_io != ~0ul && !hpte_cache_flags_ok(ptel, is_io)) {
-		if (is_io)
+	/*If we had host pte mapping then  Check WIMG */
+	if (ptep && !hpte_cache_flags_ok(ptel, is_ci)) {
+		if (is_ci)
 			return H_PARAMETER;
 		/*
 		 * Allow guest to map emulated device memory as
diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
index 3465b5d44223..c84fd3a90c9d 100644
--- a/arch/powerpc/mm/hash64_64k.c
+++ b/arch/powerpc/mm/hash64_64k.c
@@ -256,7 +256,7 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
 		 * If so, bail out and refault as a 4k page
 		 */
 		if (!mmu_has_feature(MMU_FTR_CI_LARGE_PAGE) &&
-		    unlikely(old_pte & _PAGE_NO_CACHE))
+		    unlikely(old_pte & _PAGE_TOLERANT))
 			return 0;
 		/*
 		 * Try to lock the PTE, add ACCESSED and DIRTY if it was
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index ec4f76891a8a..070f2d42660a 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -188,12 +188,12 @@ unsigned long htab_convert_pte_flags(unsigned long pteflags)
 	/*
 	 * Add in WIG bits
 	 */
-	if (pteflags & _PAGE_WRITETHRU)
-		rflags |= HPTE_R_W;
-	if (pteflags & _PAGE_NO_CACHE)
+	if (pteflags & _PAGE_TOLERANT)
 		rflags |= HPTE_R_I;
-	if (pteflags & _PAGE_GUARDED)
-		rflags |= HPTE_R_G;
+	if (pteflags & _PAGE_NON_IDEMPOTENT)
+		rflags |= (HPTE_R_I | HPTE_R_G);
+	if (pteflags & _PAGE_SAO)
+		rflags |= (HPTE_R_I | HPTE_R_W);
 
 	return rflags;
 }
@@ -1159,7 +1159,7 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
 	 * using non cacheable large pages, then we switch to 4k
 	 */
 	if (mmu_ci_restrictions && psize == MMU_PAGE_64K &&
-	    (pte_val(*ptep) & _PAGE_NO_CACHE)) {
+	    (pte_val(*ptep) & _PAGE_TOLERANT)) {
 		if (user_region) {
 			demote_segment_4k(mm, ea);
 			psize = MMU_PAGE_4K;
@@ -1315,7 +1315,7 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 	 * That way we don't have to duplicate all of the logic for segment
 	 * page size demotion here
 	 */
-	if (pte_val(*ptep) & (_PAGE_4K_PFN | _PAGE_NO_CACHE))
+	if (pte_val(*ptep) & (_PAGE_4K_PFN | _PAGE_TOLERANT))
 		goto out_exit;
 #endif /* CONFIG_PPC_64K_PAGES */
 
diff --git a/arch/powerpc/mm/pgtable-hash64.c b/arch/powerpc/mm/pgtable-hash64.c
index 3efd7183dcfe..fda2cd12077b 100644
--- a/arch/powerpc/mm/pgtable-hash64.c
+++ b/arch/powerpc/mm/pgtable-hash64.c
@@ -181,7 +181,7 @@ int map_kernel_page(unsigned long ea, unsigned long pa, unsigned long flags)
 static inline int pte_looks_normal(pte_t pte)
 {
 	if ((pte_val(pte) &
-	     (_PAGE_PRESENT | _PAGE_SPECIAL | _PAGE_NO_CACHE )) ==
+	     (_PAGE_PRESENT | _PAGE_SPECIAL | _PAGE_TOLERANT)) ==
 	    _PAGE_PRESENT) {
 		if (!(pte_val(pte) & _PAGE_PRIV))
 			return 1;
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index ef229855407f..988b5a3a5fe5 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -84,10 +84,6 @@ void __iomem * __ioremap_at(phys_addr_t pa, void *ea, unsigned long size,
 	if ((flags & _PAGE_PRESENT) == 0)
 		flags |= pgprot_val(PAGE_KERNEL);
 
-	/* Non-cacheable page cannot be coherent */
-	if (flags & _PAGE_NO_CACHE)
-		flags &= ~_PAGE_COHERENT;
-
 	/* We don't support the 4K PFN hack with ioremap */
 	if (flags & _PAGE_4K_PFN)
 		return NULL;
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 39f810d76844..8d048ca27a9b 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -152,10 +152,6 @@ static long pSeries_lpar_hpte_insert(unsigned long hpte_group,
 	/* Exact = 0                   */
 	flags = 0;
 
-	/* Make pHyp happy */
-	if ((rflags & _PAGE_NO_CACHE) && !(rflags & _PAGE_WRITETHRU))
-		hpte_r &= ~HPTE_R_M;
-
 	if (firmware_has_feature(FW_FEATURE_XCMO) && !(hpte_r & HPTE_R_N))
 		flags |= H_COALESCE_CAND;
 
-- 
2.5.0
