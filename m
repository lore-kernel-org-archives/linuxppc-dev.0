Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BD2CF1A04B8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 14:21:03 +1100 (AEDT)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 25 Feb 2016 20:21:01 -0700
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id C256E3E40044
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 20:20:59 -0700 (MST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1Q3KxAf29229236
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 03:20:59 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1Q3KwwW005620
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 22:20:59 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH 1/2] powerpc/mm: Update prot_none implementation using
 _PAGE_READ
Date: Fri, 26 Feb 2016 08:50:49 +0530
Message-Id: <1456456850-2679-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we have _PAGE_READ use that to implement prot none. With this
prot_none is _PAGE_PRESENT with none of the access bits set. While
hashing we map that to PP bit 00.

With this implementation, we will now take a prot fault for prot none
ptes, whereas before, we never inserted such a pte to hash. Hence we
always got nohpte fault before.

This is in preparation to remove _PAGE_USER from book3s 64

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash.h | 18 ++++++++----------
 arch/powerpc/mm/hash_utils_64.c           | 15 +++++++++++----
 arch/powerpc/mm/hugetlbpage.c             |  2 +-
 arch/powerpc/mm/pgtable-hash64.c          |  6 ++----
 4 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 9153bda5f395..244f2c322c43 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -21,6 +21,7 @@
 #define _PAGE_EXEC		0x00001 /* execute permission */
 #define _PAGE_RW		0x00002 /* read & write access allowed */
 #define _PAGE_READ		0x00004	/* read access allowed */
+#define _PAGE_RWX		(_PAGE_READ | _PAGE_RW | _PAGE_EXEC)
 #define _PAGE_USER		0x00008 /* page may be accessed by userspace */
 #define _PAGE_GUARDED		0x00010 /* G: guarded (side-effect) page */
 /* M (memory coherence) is always set in the HPTE, so we don't need it here */
@@ -176,10 +177,12 @@
 #define PAGE_SHARED	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW)
 #define PAGE_SHARED_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW | \
 				 _PAGE_EXEC)
-#define PAGE_COPY	__pgprot(_PAGE_BASE | _PAGE_USER )
-#define PAGE_COPY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_EXEC)
-#define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_USER )
-#define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_EXEC)
+#define PAGE_COPY	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_READ )
+#define PAGE_COPY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_READ| \
+				 _PAGE_EXEC)
+#define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_READ)
+#define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_READ| \
+				 _PAGE_EXEC)
 
 #define __P000	PAGE_NONE
 #define __P001	PAGE_READONLY
@@ -392,15 +395,10 @@ static inline pte_t pte_clear_soft_dirty(pte_t pte)
 #endif /* CONFIG_HAVE_ARCH_SOFT_DIRTY */
 
 #ifdef CONFIG_NUMA_BALANCING
-/*
- * These work without NUMA balancing but the kernel does not care. See the
- * comment in include/asm-generic/pgtable.h . On powerpc, this will only
- * work for user pages and always return true for kernel pages.
- */
 static inline int pte_protnone(pte_t pte)
 {
 	return (pte_val(pte) &
-		(_PAGE_PRESENT | _PAGE_USER)) == _PAGE_PRESENT;
+		(_PAGE_PRESENT | _PAGE_RWX)) == _PAGE_PRESENT;
 }
 #endif /* CONFIG_NUMA_BALANCING */
 
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 96b52bd3da8f..79b81cd0d254 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -173,9 +173,11 @@ unsigned long htab_convert_pte_flags(unsigned long pteflags)
 	 * and there is no kernel RO (_PAGE_KERNEL_RO).
 	 * User area is mapped with PP=0x2 for read/write
 	 * or PP=0x3 for read-only (including writeable but clean pages).
+	 * We also map user prot none as with PP=00.
 	 */
 	if (pteflags & _PAGE_USER) {
-		rflags |= 0x2;
+		if ((pteflags & _PAGE_READ) || (pteflags & _PAGE_RW))
+			rflags |= 0x2;
 		if (!((pteflags & _PAGE_RW) && (pteflags & _PAGE_DIRTY)))
 			rflags |= 0x1;
 	}
@@ -933,7 +935,7 @@ void demote_segment_4k(struct mm_struct *mm, unsigned long addr)
  * Userspace sets the subpage permissions using the subpage_prot system call.
  *
  * Result is 0: full permissions, _PAGE_RW: read-only,
- * _PAGE_USER or _PAGE_USER|_PAGE_RW: no access.
+ * _PAGE_RWX: no access.
  */
 static int subpage_protection(struct mm_struct *mm, unsigned long ea)
 {
@@ -959,8 +961,13 @@ static int subpage_protection(struct mm_struct *mm, unsigned long ea)
 	/* extract 2-bit bitfield for this 4k subpage */
 	spp >>= 30 - 2 * ((ea >> 12) & 0xf);
 
-	/* turn 0,1,2,3 into combination of _PAGE_USER and _PAGE_RW */
-	spp = ((spp & 2) ? _PAGE_USER : 0) | ((spp & 1) ? _PAGE_RW : 0);
+	/*
+	 * 0 -> full premission
+	 * 1 -> Read only
+	 * 2 -> no access.
+	 * We return the flag that need to be cleared.
+	 */
+	spp = ((spp & 2) ? _PAGE_RWX : 0) | ((spp & 1) ? _PAGE_RW : 0);
 	return spp;
 }
 
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 196e69a3c472..17ca4827dd87 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -604,7 +604,7 @@ int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 		end = pte_end;
 
 	pte = READ_ONCE(*ptep);
-	mask = _PAGE_PRESENT | _PAGE_USER;
+	mask = _PAGE_PRESENT | _PAGE_USER | _PAGE_READ;
 	if (write)
 		mask |= _PAGE_RW;
 
diff --git a/arch/powerpc/mm/pgtable-hash64.c b/arch/powerpc/mm/pgtable-hash64.c
index b5e7e8efef1e..341bbf7d8891 100644
--- a/arch/powerpc/mm/pgtable-hash64.c
+++ b/arch/powerpc/mm/pgtable-hash64.c
@@ -231,8 +231,7 @@ void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
 	 * _PAGE_PRESENT, but we can be sure that it is not in hpte.
 	 * Hence we can use set_pte_at for them.
 	 */
-	VM_WARN_ON((pte_val(*ptep) & (_PAGE_PRESENT | _PAGE_USER)) ==
-		(_PAGE_PRESENT | _PAGE_USER));
+	VM_WARN_ON(pte_present(*ptep) && !pte_protnone(*ptep));
 
 	/*
 	 * Add the pte bit when tryint set a pte
@@ -433,8 +432,7 @@ void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 		pmd_t *pmdp, pmd_t pmd)
 {
 #ifdef CONFIG_DEBUG_VM
-	WARN_ON((pmd_val(*pmdp) & (_PAGE_PRESENT | _PAGE_USER)) ==
-		(_PAGE_PRESENT | _PAGE_USER));
+	WARN_ON(pte_present(pmd_pte(*pmd)) && !pte_protnone(pmd_pte(*pmd)));
 	assert_spin_locked(&mm->page_table_lock);
 	WARN_ON(!pmd_trans_huge(pmd));
 #endif
-- 
2.5.0
