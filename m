Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDxm00g3zDqBn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:26:52 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 11/70] powerpc/mm: Replace _PAGE_USER with _PAGE_PRIVILEGED
Date: Fri, 29 Apr 2016 23:25:34 +1000
Message-Id: <1461936393-10131-11-git-send-email-mpe@ellerman.id.au>
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

_PAGE_PRIVILEGED means the page can be accessed only by the kernel. This
is done to keep pte bits similar to PowerISA 3.0 Radix PTE format. User
pages are now marked by clearing _PAGE_PRIVILEGED bit.

Previously we allowed the kernel to have a privileged page in the lower
address range (USER_REGION). With this patch such access is denied.

We also prevent a kernel access to a non-privileged page in higher
address range (ie, REGION_ID != 0).

Both the above access scenarios should never happen.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jeremy Kerr <jk@ozlabs.org>
Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Acked-by: Ian Munsie <imunsie@au1.ibm.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/hash.h    | 34 ++++++++++++++--------------
 arch/powerpc/include/asm/book3s/64/pgtable.h | 18 ++++++++++++++-
 arch/powerpc/mm/hash64_4k.c                  |  2 +-
 arch/powerpc/mm/hash64_64k.c                 |  4 ++--
 arch/powerpc/mm/hash_utils_64.c              | 16 ++++++++-----
 arch/powerpc/mm/hugepage-hash64.c            |  2 +-
 arch/powerpc/mm/hugetlbpage-hash64.c         |  3 ++-
 arch/powerpc/mm/hugetlbpage.c                |  2 +-
 arch/powerpc/mm/pgtable.c                    | 15 ++++++++++--
 arch/powerpc/mm/pgtable_64.c                 | 15 +++++++++---
 arch/powerpc/platforms/cell/spufs/fault.c    |  2 +-
 drivers/misc/cxl/fault.c                     |  4 +++-
 12 files changed, 80 insertions(+), 37 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index fb76f9cf49c9..5e7e74d30eb9 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -20,7 +20,7 @@
 #define _PAGE_READ		0x00004	/* read access allowed */
 #define _PAGE_RW		(_PAGE_READ | _PAGE_WRITE)
 #define _PAGE_RWX		(_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC)
-#define _PAGE_USER		0x00008 /* page may be accessed by userspace */
+#define _PAGE_PRIVILEGED	0x00008 /* kernel access only */
 #define _PAGE_GUARDED		0x00010 /* G: guarded (side-effect) page */
 /* M (memory coherence) is always set in the HPTE, so we don't need it here */
 #define _PAGE_COHERENT		0x0
@@ -114,10 +114,13 @@
 #define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
 #endif /* CONFIG_PPC_MM_SLICES */
 
-/* No separate kernel read-only */
-#define _PAGE_KERNEL_RW		(_PAGE_RW | _PAGE_DIRTY) /* user access blocked by key */
+/*
+ * No separate kernel read-only, user access blocked by key
+ */
+#define _PAGE_KERNEL_RW		(_PAGE_PRIVILEGED | _PAGE_RW | _PAGE_DIRTY)
 #define _PAGE_KERNEL_RO		 _PAGE_KERNEL_RW
-#define _PAGE_KERNEL_RWX	(_PAGE_DIRTY | _PAGE_RW | _PAGE_EXEC)
+#define _PAGE_KERNEL_RWX	(_PAGE_PRIVILEGED | _PAGE_DIRTY | \
+				 _PAGE_RW | _PAGE_EXEC)
 
 /* Strong Access Ordering */
 #define _PAGE_SAO		(_PAGE_WRITETHRU | _PAGE_NO_CACHE | _PAGE_COHERENT)
@@ -147,7 +150,7 @@
  */
 #define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT | _PAGE_NO_CACHE | \
 			 _PAGE_WRITETHRU | _PAGE_4K_PFN | \
-			 _PAGE_USER | _PAGE_ACCESSED |  _PAGE_READ |\
+			 _PAGE_PRIVILEGED | _PAGE_ACCESSED |  _PAGE_READ |\
 			 _PAGE_WRITE |  _PAGE_DIRTY | _PAGE_EXEC | \
 			 _PAGE_SOFT_DIRTY)
 /*
@@ -169,16 +172,13 @@
  *
  * Note due to the way vm flags are laid out, the bits are XWR
  */
-#define PAGE_NONE	__pgprot(_PAGE_BASE)
-#define PAGE_SHARED	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW)
-#define PAGE_SHARED_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW | \
-				 _PAGE_EXEC)
-#define PAGE_COPY	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_READ)
-#define PAGE_COPY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_READ| \
-				 _PAGE_EXEC)
-#define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_READ)
-#define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_READ| \
-				 _PAGE_EXEC)
+#define PAGE_NONE	__pgprot(_PAGE_BASE | _PAGE_PRIVILEGED)
+#define PAGE_SHARED	__pgprot(_PAGE_BASE | _PAGE_RW)
+#define PAGE_SHARED_X	__pgprot(_PAGE_BASE | _PAGE_RW | _PAGE_EXEC)
+#define PAGE_COPY	__pgprot(_PAGE_BASE | _PAGE_READ)
+#define PAGE_COPY_X	__pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_EXEC)
+#define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_READ)
+#define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_EXEC)
 
 #define __P000	PAGE_NONE
 #define __P001	PAGE_READONLY
@@ -419,8 +419,8 @@ static inline pte_t pte_clear_soft_dirty(pte_t pte)
  */
 static inline int pte_protnone(pte_t pte)
 {
-	return (pte_val(pte) &
-		(_PAGE_PRESENT | _PAGE_USER)) == _PAGE_PRESENT;
+	return (pte_val(pte) & (_PAGE_PRESENT | _PAGE_PRIVILEGED)) ==
+		(_PAGE_PRESENT | _PAGE_PRIVILEGED);
 }
 #endif /* CONFIG_NUMA_BALANCING */
 
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 60e84260a07d..b609729e0d76 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -187,7 +187,7 @@ extern struct page *pgd_page(pgd_t pgd);
 
 static inline bool pte_user(pte_t pte)
 {
-	return !!(pte_val(pte) & _PAGE_USER);
+	return !(pte_val(pte) & _PAGE_PRIVILEGED);
 }
 
 #ifdef CONFIG_MEM_SOFT_DIRTY
@@ -211,6 +211,22 @@ static inline pte_t pte_swp_clear_soft_dirty(pte_t pte)
 }
 #endif /* CONFIG_HAVE_ARCH_SOFT_DIRTY */
 
+static inline bool check_pte_access(unsigned long access, unsigned long ptev)
+{
+	/*
+	 * This check for _PAGE_RWX and _PAGE_PRESENT bits
+	 */
+	if (access & ~ptev)
+		return false;
+	/*
+	 * This check for access to privilege space
+	 */
+	if ((access & _PAGE_PRIVILEGED) != (ptev & _PAGE_PRIVILEGED))
+		return false;
+
+	return true;
+}
+
 void pgtable_cache_add(unsigned shift, void (*ctor)(void *));
 void pgtable_cache_init(void);
 
diff --git a/arch/powerpc/mm/hash64_4k.c b/arch/powerpc/mm/hash64_4k.c
index 491b7d137cd8..529e49204f6b 100644
--- a/arch/powerpc/mm/hash64_4k.c
+++ b/arch/powerpc/mm/hash64_4k.c
@@ -37,7 +37,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 		if (unlikely(old_pte & _PAGE_BUSY))
 			return 0;
 		/* If PTE permissions don't match, take page fault */
-		if (unlikely(access & ~old_pte))
+		if (unlikely(!check_pte_access(access, old_pte)))
 			return 1;
 		/*
 		 * Try to lock the PTE, add ACCESSED and DIRTY if it was
diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
index 2d3472173d79..e7782862362b 100644
--- a/arch/powerpc/mm/hash64_64k.c
+++ b/arch/powerpc/mm/hash64_64k.c
@@ -69,7 +69,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 		if (unlikely(old_pte & _PAGE_BUSY))
 			return 0;
 		/* If PTE permissions don't match, take page fault */
-		if (unlikely(access & ~old_pte))
+		if (unlikely(!check_pte_access(access, old_pte)))
 			return 1;
 		/*
 		 * Try to lock the PTE, add ACCESSED and DIRTY if it was
@@ -237,7 +237,7 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
 		if (unlikely(old_pte & _PAGE_BUSY))
 			return 0;
 		/* If PTE permissions don't match, take page fault */
-		if (unlikely(access & ~old_pte))
+		if (unlikely(!check_pte_access(access, old_pte)))
 			return 1;
 		/*
 		 * Check if PTE has the cache-inhibit bit set
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 36e00371ba5a..dc0f6a00ccbd 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -174,7 +174,7 @@ unsigned long htab_convert_pte_flags(unsigned long pteflags)
 	 * User area is mapped with PP=0x2 for read/write
 	 * or PP=0x3 for read-only (including writeable but clean pages).
 	 */
-	if (pteflags & _PAGE_USER) {
+	if (!(pteflags & _PAGE_PRIVILEGED)) {
 		if (pteflags & _PAGE_RWX)
 			rflags |= 0x2;
 		if (!((pteflags & _PAGE_WRITE) && (pteflags & _PAGE_DIRTY)))
@@ -1090,7 +1090,7 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
 	/* Pre-check access permissions (will be re-checked atomically
 	 * in __hash_page_XX but this pre-check is a fast path
 	 */
-	if (access & ~pte_val(*ptep)) {
+	if (!check_pte_access(access, pte_val(*ptep))) {
 		DBG_LOW(" no access !\n");
 		rc = 1;
 		goto bail;
@@ -1228,12 +1228,16 @@ int __hash_page(unsigned long ea, unsigned long msr, unsigned long trap,
 	if (dsisr & DSISR_ISSTORE)
 		access |= _PAGE_WRITE;
 	/*
-	 * We need to set the _PAGE_USER bit if MSR_PR is set or if we are
-	 * accessing a userspace segment (even from the kernel). We assume
-	 * kernel addresses always have the high bit set.
+	 * We set _PAGE_PRIVILEGED only when
+	 * kernel mode access kernel space.
+	 *
+	 * _PAGE_PRIVILEGED is NOT set
+	 * 1) when kernel mode access user space
+	 * 2) user space access kernel space.
 	 */
+	access |= _PAGE_PRIVILEGED;
 	if ((msr & MSR_PR) || (REGION_ID(ea) == USER_REGION_ID))
-		access |= _PAGE_USER;
+		access &= ~_PAGE_PRIVILEGED;
 
 	if (trap == 0x400)
 		access |= _PAGE_EXEC;
diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/hugepage-hash64.c
index b4b6668d1b24..6cb6bdd254bb 100644
--- a/arch/powerpc/mm/hugepage-hash64.c
+++ b/arch/powerpc/mm/hugepage-hash64.c
@@ -40,7 +40,7 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 		if (unlikely(old_pmd & _PAGE_BUSY))
 			return 0;
 		/* If PMD permissions don't match, take page fault */
-		if (unlikely(access & ~old_pmd))
+		if (unlikely(!check_pte_access(access, old_pmd)))
 			return 1;
 		/*
 		 * Try to lock the PTE, add ACCESSED and DIRTY if it was
diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
index cdca743cdaf1..bf9078440256 100644
--- a/arch/powerpc/mm/hugetlbpage-hash64.c
+++ b/arch/powerpc/mm/hugetlbpage-hash64.c
@@ -50,8 +50,9 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 		if (unlikely(old_pte & _PAGE_BUSY))
 			return 0;
 		/* If PTE permissions don't match, take page fault */
-		if (unlikely(access & ~old_pte))
+		if (unlikely(!check_pte_access(access, old_pte)))
 			return 1;
+
 		/* Try to lock the PTE, add ACCESSED and DIRTY if it was
 		 * a write access */
 		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED;
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 0bf269b00de9..6d910960217e 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -1003,7 +1003,7 @@ int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 		end = pte_end;
 
 	pte = READ_ONCE(*ptep);
-	mask = _PAGE_PRESENT | _PAGE_USER | _PAGE_READ;
+	mask = _PAGE_PRESENT | _PAGE_READ;
 	if (write)
 		mask |= _PAGE_WRITE;
 
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index ef7b922c655c..125fb4b54445 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -43,9 +43,20 @@ static inline int is_exec_fault(void)
  */
 static inline int pte_looks_normal(pte_t pte)
 {
+
+#if defined(CONFIG_PPC_BOOK3S_64)
+	if ((pte_val(pte) &
+	     (_PAGE_PRESENT | _PAGE_SPECIAL | _PAGE_NO_CACHE)) ==
+	    _PAGE_PRESENT) {
+		if (pte_user(pte))
+			return 1;
+	}
+	return 0;
+#else
 	return (pte_val(pte) &
-	    (_PAGE_PRESENT | _PAGE_SPECIAL | _PAGE_NO_CACHE | _PAGE_USER)) ==
-	    (_PAGE_PRESENT | _PAGE_USER);
+		(_PAGE_PRESENT | _PAGE_SPECIAL | _PAGE_NO_CACHE | _PAGE_USER)) ==
+		(_PAGE_PRESENT | _PAGE_USER);
+#endif
 }
 
 static struct page *maybe_pte_to_page(pte_t pte)
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 16bc751f10df..603db71ff21d 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -280,8 +280,17 @@ void __iomem * ioremap_prot(phys_addr_t addr, unsigned long size,
 	if (flags & _PAGE_WRITE)
 		flags |= _PAGE_DIRTY;
 
-	/* we don't want to let _PAGE_USER and _PAGE_EXEC leak out */
-	flags &= ~(_PAGE_USER | _PAGE_EXEC);
+	/* we don't want to let _PAGE_EXEC leak out */
+	flags &= ~_PAGE_EXEC;
+	/*
+	 * Force kernel mapping.
+	 */
+#if defined(CONFIG_PPC_BOOK3S_64)
+	flags |= _PAGE_PRIVILEGED;
+#else
+	flags &= ~_PAGE_USER;
+#endif
+
 
 #ifdef _PAGE_BAP_SR
 	/* _PAGE_USER contains _PAGE_BAP_SR on BookE using the new PTE format
@@ -664,7 +673,7 @@ void pmdp_huge_split_prepare(struct vm_area_struct *vma,
 	 * the translation is still valid, because we will withdraw
 	 * pgtable_t after this.
 	 */
-	pmd_hugepage_update(vma->vm_mm, address, pmdp, _PAGE_USER, 0);
+	pmd_hugepage_update(vma->vm_mm, address, pmdp, 0, _PAGE_PRIVILEGED);
 }
 
 
diff --git a/arch/powerpc/platforms/cell/spufs/fault.c b/arch/powerpc/platforms/cell/spufs/fault.c
index c3a3bf1745b7..e29e4d5afa2d 100644
--- a/arch/powerpc/platforms/cell/spufs/fault.c
+++ b/arch/powerpc/platforms/cell/spufs/fault.c
@@ -141,7 +141,7 @@ int spufs_handle_class1(struct spu_context *ctx)
 	/* we must not hold the lock when entering copro_handle_mm_fault */
 	spu_release(ctx);
 
-	access = (_PAGE_PRESENT | _PAGE_READ | _PAGE_USER);
+	access = (_PAGE_PRESENT | _PAGE_READ);
 	access |= (dsisr & MFC_DSISR_ACCESS_PUT) ? _PAGE_WRITE : 0UL;
 	local_irq_save(flags);
 	ret = hash_page(ea, access, 0x300, dsisr);
diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
index 0feeacedcef1..377e650a2a1d 100644
--- a/drivers/misc/cxl/fault.c
+++ b/drivers/misc/cxl/fault.c
@@ -152,8 +152,10 @@ static void cxl_handle_page_fault(struct cxl_context *ctx,
 	access = _PAGE_PRESENT | _PAGE_READ;
 	if (dsisr & CXL_PSL_DSISR_An_S)
 		access |= _PAGE_WRITE;
+
+	access |= _PAGE_PRIVILEGED;
 	if ((!ctx->kernel) || (REGION_ID(dar) == USER_REGION_ID))
-		access |= _PAGE_USER;
+		access &= ~_PAGE_PRIVILEGED;
 
 	if (dsisr & DSISR_NOHPTE)
 		inv_flags |= HPTE_NOHPTE_UPDATE;
-- 
2.5.0
