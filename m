Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F29921A0B68
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 14:21:07 +1100 (AEDT)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 25 Feb 2016 20:21:05 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id B63381FF0026
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 20:09:12 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id u1Q3L33A44892352
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 20:21:03 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1Q3L1i3025957
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 20:21:02 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH 2/2] powerpc/mm: Replace _PAGE_USER with _PAGE_PRIV
Date: Fri, 26 Feb 2016 08:50:50 +0530
Message-Id: <1456456850-2679-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1456456850-2679-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1456456850-2679-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

_PAGE_PRIV means the page can be accessed only by kernel. This is done
to keep pte bits similar to PowerISA 3.0 radix PTE format. User
pages are now makred by clearing _PAGE_PRIV bit.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash.h | 23 ++++++++++-------------
 arch/powerpc/mm/hash64_4k.c               |  5 +++++
 arch/powerpc/mm/hash64_64k.c              | 10 ++++++++++
 arch/powerpc/mm/hash_utils_64.c           | 15 +++++++++++----
 arch/powerpc/mm/hugepage-hash64.c         |  5 +++++
 arch/powerpc/mm/hugetlbpage-hash64.c      |  5 +++++
 arch/powerpc/mm/hugetlbpage.c             |  2 +-
 arch/powerpc/mm/pgtable-hash64.c          | 12 ++++++++----
 arch/powerpc/mm/pgtable_32.c              |  2 +-
 arch/powerpc/mm/pgtable_64.c              |  2 +-
 arch/powerpc/perf/callchain.c             |  2 +-
 11 files changed, 58 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 244f2c322c43..2a38883c9187 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -22,7 +22,7 @@
 #define _PAGE_RW		0x00002 /* read & write access allowed */
 #define _PAGE_READ		0x00004	/* read access allowed */
 #define _PAGE_RWX		(_PAGE_READ | _PAGE_RW | _PAGE_EXEC)
-#define _PAGE_USER		0x00008 /* page may be accessed by userspace */
+#define _PAGE_PRIV		0x00008 /* page can only be accessed by kernel*/
 #define _PAGE_GUARDED		0x00010 /* G: guarded (side-effect) page */
 /* M (memory coherence) is always set in the HPTE, so we don't need it here */
 #define _PAGE_COHERENT		0x0
@@ -117,9 +117,9 @@
 #endif /* CONFIG_PPC_MM_SLICES */
 
 /* No separate kernel read-only */
-#define _PAGE_KERNEL_RW		(_PAGE_RW | _PAGE_DIRTY) /* user access blocked by key */
+#define _PAGE_KERNEL_RW		(_PAGE_PRIV | _PAGE_RW | _PAGE_DIRTY) /* user access blocked by key */
 #define _PAGE_KERNEL_RO		 _PAGE_KERNEL_RW
-#define _PAGE_KERNEL_RWX	(_PAGE_DIRTY | _PAGE_RW | _PAGE_EXEC)
+#define _PAGE_KERNEL_RWX	(_PAGE_PRIV | _PAGE_DIRTY | _PAGE_RW | _PAGE_EXEC)
 
 /* Strong Access Ordering */
 #define _PAGE_SAO		(_PAGE_WRITETHRU | _PAGE_NO_CACHE | _PAGE_COHERENT)
@@ -151,7 +151,7 @@
  */
 #define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT | _PAGE_NO_CACHE | \
 			 _PAGE_WRITETHRU | _PAGE_4K_PFN | \
-			 _PAGE_USER | _PAGE_ACCESSED |  \
+			 _PAGE_PRIV| _PAGE_ACCESSED |  \
 			 _PAGE_RW |  _PAGE_DIRTY | _PAGE_EXEC | \
 			 _PAGE_SOFT_DIRTY)
 /*
@@ -174,15 +174,12 @@
  * Note due to the way vm flags are laid out, the bits are XWR
  */
 #define PAGE_NONE	__pgprot(_PAGE_BASE)
-#define PAGE_SHARED	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW)
-#define PAGE_SHARED_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW | \
-				 _PAGE_EXEC)
-#define PAGE_COPY	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_READ )
-#define PAGE_COPY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_READ| \
-				 _PAGE_EXEC)
-#define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_READ)
-#define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_READ| \
-				 _PAGE_EXEC)
+#define PAGE_SHARED	__pgprot(_PAGE_BASE | _PAGE_RW)
+#define PAGE_SHARED_X	__pgprot(_PAGE_BASE | _PAGE_RW | _PAGE_EXEC)
+#define PAGE_COPY	__pgprot(_PAGE_BASE | _PAGE_READ )
+#define PAGE_COPY_X	__pgprot(_PAGE_BASE | _PAGE_READ| _PAGE_EXEC)
+#define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_READ)
+#define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_READ| _PAGE_EXEC)
 
 #define __P000	PAGE_NONE
 #define __P001	PAGE_READONLY
diff --git a/arch/powerpc/mm/hash64_4k.c b/arch/powerpc/mm/hash64_4k.c
index 1a862eb6fef1..8c83be3f67ef 100644
--- a/arch/powerpc/mm/hash64_4k.c
+++ b/arch/powerpc/mm/hash64_4k.c
@@ -40,6 +40,11 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 		if (unlikely(access & ~old_pte))
 			return 1;
 		/*
+		 * access from user, but pte in _PAGE_PRIV
+		 */
+		if (unlikely((access & _PAGE_PRIV) != (old_pte & _PAGE_PRIV)))
+			return 1;
+		/*
 		 * Try to lock the PTE, add ACCESSED and DIRTY if it was
 		 * a write access. Since this is 4K insert of 64K page size
 		 * also add _PAGE_COMBO
diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
index 976eb5f6e492..3465b5d44223 100644
--- a/arch/powerpc/mm/hash64_64k.c
+++ b/arch/powerpc/mm/hash64_64k.c
@@ -72,6 +72,11 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 		if (unlikely(access & ~old_pte))
 			return 1;
 		/*
+		 * access from user, but pte in _PAGE_PRIV
+		 */
+		if (unlikely((access & _PAGE_PRIV) != (old_pte & _PAGE_PRIV)))
+			return 1;
+		/*
 		 * Try to lock the PTE, add ACCESSED and DIRTY if it was
 		 * a write access. Since this is 4K insert of 64K page size
 		 * also add _PAGE_COMBO
@@ -242,6 +247,11 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
 		if (unlikely(access & ~old_pte))
 			return 1;
 		/*
+		 * access from user, but pte in _PAGE_PRIV
+		 */
+		if (unlikely((access & _PAGE_PRIV) != (old_pte & _PAGE_PRIV)))
+			return 1;
+		/*
 		 * Check if PTE has the cache-inhibit bit set
 		 * If so, bail out and refault as a 4k page
 		 */
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 79b81cd0d254..ec4f76891a8a 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -175,7 +175,7 @@ unsigned long htab_convert_pte_flags(unsigned long pteflags)
 	 * or PP=0x3 for read-only (including writeable but clean pages).
 	 * We also map user prot none as with PP=00.
 	 */
-	if (pteflags & _PAGE_USER) {
+	if (!(pteflags & _PAGE_PRIV)) {
 		if ((pteflags & _PAGE_READ) || (pteflags & _PAGE_RW))
 			rflags |= 0x2;
 		if (!((pteflags & _PAGE_RW) && (pteflags & _PAGE_DIRTY)))
@@ -1109,7 +1109,14 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
 		rc = 1;
 		goto bail;
 	}
-
+	/*
+	 * access from user, but pte in _PAGE_PRIV
+	 */
+	if ((access & _PAGE_PRIV) != (pte_val(*ptep) & _PAGE_PRIV)) {
+		DBG_LOW(" no access !\n");
+		rc = 1;
+		goto bail;
+	}
 	if (hugeshift) {
 		if (is_thp)
 			rc = __hash_page_thp(ea, access, vsid, (pmd_t *)ptep,
@@ -1246,8 +1253,8 @@ int __hash_page(unsigned long ea, unsigned long msr, unsigned long trap,
 	 * accessing a userspace segment (even from the kernel). We assume
 	 * kernel addresses always have the high bit set.
 	 */
-	if ((msr & MSR_PR) || (REGION_ID(ea) == USER_REGION_ID))
-		access |= _PAGE_USER;
+	if (!(msr & MSR_PR) && !(REGION_ID(ea) == USER_REGION_ID))
+		access |= _PAGE_PRIV;
 
 	if (trap == 0x400)
 		access |= _PAGE_EXEC;
diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/hugepage-hash64.c
index d9675f1d606e..f71600e98ff6 100644
--- a/arch/powerpc/mm/hugepage-hash64.c
+++ b/arch/powerpc/mm/hugepage-hash64.c
@@ -43,6 +43,11 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 		if (unlikely(access & ~old_pmd))
 			return 1;
 		/*
+		 * access from user, but pmd in _PAGE_PRIV
+		 */
+		if (unlikely((access & _PAGE_PRIV) != (old_pmd & _PAGE_PRIV)))
+			return 1;
+		/*
 		 * Try to lock the PTE, add ACCESSED and DIRTY if it was
 		 * a write access
 		 */
diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
index 0a1f87ffde8c..45ab33705f03 100644
--- a/arch/powerpc/mm/hugetlbpage-hash64.c
+++ b/arch/powerpc/mm/hugetlbpage-hash64.c
@@ -63,6 +63,11 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 		/* If PTE permissions don't match, take page fault */
 		if (unlikely(access & ~old_pte))
 			return 1;
+		/*
+		 * access from user, but pte in _PAGE_PRIV
+		 */
+		if (unlikely((access & _PAGE_PRIV) != (old_pte & _PAGE_PRIV)))
+			return 1;
 		/* Try to lock the PTE, add ACCESSED and DIRTY if it was
 		 * a write access */
 		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED;
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 17ca4827dd87..a63580c11518 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -604,7 +604,7 @@ int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 		end = pte_end;
 
 	pte = READ_ONCE(*ptep);
-	mask = _PAGE_PRESENT | _PAGE_USER | _PAGE_READ;
+	mask = _PAGE_PRESENT | _PAGE_READ;
 	if (write)
 		mask |= _PAGE_RW;
 
diff --git a/arch/powerpc/mm/pgtable-hash64.c b/arch/powerpc/mm/pgtable-hash64.c
index 341bbf7d8891..a453830c8710 100644
--- a/arch/powerpc/mm/pgtable-hash64.c
+++ b/arch/powerpc/mm/pgtable-hash64.c
@@ -180,9 +180,13 @@ int map_kernel_page(unsigned long ea, unsigned long pa, unsigned long flags)
  */
 static inline int pte_looks_normal(pte_t pte)
 {
-	return (pte_val(pte) &
-	    (_PAGE_PRESENT | _PAGE_SPECIAL | _PAGE_NO_CACHE | _PAGE_USER)) ==
-	    (_PAGE_PRESENT | _PAGE_USER);
+	if ((pte_val(pte) &
+	     (_PAGE_PRESENT | _PAGE_SPECIAL | _PAGE_NO_CACHE )) ==
+	    _PAGE_PRESENT) {
+		if (!(pte_val(pte) & _PAGE_PRIV))
+			return 1;
+	}
+	return 0;
 }
 
 static struct page *maybe_pte_to_page(pte_t pte)
@@ -420,7 +424,7 @@ void pmdp_huge_split_prepare(struct vm_area_struct *vma,
 	 * the translation is still valid, because we will withdraw
 	 * pgtable_t after this.
 	 */
-	pmd_hugepage_update(vma->vm_mm, address, pmdp, _PAGE_USER, 0);
+	pmd_hugepage_update(vma->vm_mm, address, pmdp, 0, _PAGE_PRIV);
 }
 
 
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 7692d1bb1bc6..16ea4c497590 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -158,7 +158,7 @@ ioremap_prot(phys_addr_t addr, unsigned long size, unsigned long flags)
 		flags |= _PAGE_DIRTY | _PAGE_HWWRITE;
 
 	/* we don't want to let _PAGE_USER and _PAGE_EXEC leak out */
-	flags &= ~(_PAGE_USER | _PAGE_EXEC);
+	flags &= ~(_PAGE_PRIV | _PAGE_EXEC);
 
 #ifdef _PAGE_BAP_SR
 	/* _PAGE_USER contains _PAGE_BAP_SR on BookE using the new PTE format
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 4d93ba050775..1ff49d2c978a 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -198,7 +198,7 @@ void __iomem * ioremap_prot(phys_addr_t addr, unsigned long size,
 		flags |= _PAGE_DIRTY;
 
 	/* we don't want to let _PAGE_USER and _PAGE_EXEC leak out */
-	flags &= ~(_PAGE_USER | _PAGE_EXEC);
+	flags &= ~(_PAGE_PRIV | _PAGE_EXEC);
 
 #ifdef _PAGE_BAP_SR
 	/* _PAGE_USER contains _PAGE_BAP_SR on BookE using the new PTE format
diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
index e04a6752b399..fe9ef6217df5 100644
--- a/arch/powerpc/perf/callchain.c
+++ b/arch/powerpc/perf/callchain.c
@@ -137,7 +137,7 @@ static int read_user_stack_slow(void __user *ptr, void *buf, int nb)
 	offset = addr & ((1UL << shift) - 1);
 
 	pte = READ_ONCE(*ptep);
-	if (!pte_present(pte) || !(pte_val(pte) & _PAGE_USER))
+	if (!pte_present(pte) || (pte_val(pte) & _PAGE_PRIV))
 		goto err_out;
 	pfn = pte_pfn(pte);
 	if (!page_is_ram(pfn))
-- 
2.5.0
