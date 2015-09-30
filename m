Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 024A71A070E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 12:29:19 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 30 Sep 2015 12:29:19 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id CB405357804F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 12:29:17 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8U2T96N65011722
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 12:29:17 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8U2Si3j008820
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 12:28:45 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 21/31] powerpc/mm: make pte page hash index slot 8 bits
Date: Wed, 30 Sep 2015 07:57:14 +0530
Message-Id: <1443580044-30659-22-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1443580044-30659-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1443580044-30659-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently we use 4 bits for each slot and pack all the 16 slot
information related to a 64K linux page in a 64bit value. To do this
we use 16 bits of pte_t. Move the hash slot valid bit out of pte_t
and place them in the second half of pte page. We also use 8 bit
per each slot.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-64k.h | 48 +++++++++++++++------------
 arch/powerpc/include/asm/book3s/64/hash.h     |  5 ---
 arch/powerpc/include/asm/page.h               |  4 +--
 arch/powerpc/mm/hash64_64k.c                  | 34 +++++++++++++++----
 4 files changed, 56 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index ced5a17a8d1a..dafc2f31c843 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -78,33 +78,39 @@
  * generic accessors and iterators here
  */
 #define __real_pte __real_pte
-static inline real_pte_t __real_pte(unsigned long addr, pte_t pte, pte_t *ptep)
-{
-	real_pte_t rpte;
-
-	rpte.pte = pte;
-	rpte.hidx = 0;
-	if (pte_val(pte) & _PAGE_COMBO) {
-		/*
-		 * Make sure we order the hidx load against the _PAGE_COMBO
-		 * check. The store side ordering is done in __hash_page_4K
-		 */
-		smp_rmb();
-		rpte.hidx = pte_val(*((ptep) + PTRS_PER_PTE));
-	}
-	return rpte;
-}
-
+extern real_pte_t __real_pte(unsigned long addr, pte_t pte, pte_t *ptep);
 static inline unsigned long __rpte_to_hidx(real_pte_t rpte, unsigned long index)
 {
 	if ((pte_val(rpte.pte) & _PAGE_COMBO))
-		return (rpte.hidx >> (index<<2)) & 0xf;
+		return (unsigned long) rpte.hidx[index] >> 4;
 	return (pte_val(rpte.pte) >> 12) & 0xf;
 }
 
-#define __rpte_to_pte(r)	((r).pte)
-#define __rpte_sub_valid(rpte, index) \
-	(pte_val(rpte.pte) & (_PAGE_HPTE_SUB0 >> (index)))
+static inline pte_t __rpte_to_pte(real_pte_t rpte)
+{
+	return rpte.pte;
+}
+/*
+ * we look at the second half of the pte page to determine whether
+ * the sub 4k hpte is valid. We use 8 bits per each index, and we have
+ * 16 index mapping full 64K page. Hence for each
+ * 64K linux page we use 128 bit from the second half of pte page.
+ * The encoding in the second half of the page is as below:
+ * [ index 15 ] .........................[index 0]
+ * [bit 127 ..................................bit 0]
+ * fomat of each index
+ * bit 7 ........ bit0
+ * [one bit secondary][ 3 bit hidx][1 bit valid][000]
+ */
+static inline bool __rpte_sub_valid(real_pte_t rpte, unsigned long index)
+{
+	unsigned char index_val = rpte.hidx[index];
+
+	if ((index_val >> 3) & 0x1)
+		return true;
+	return false;
+}
+
 /*
  * Trick: we set __end to va + 64k, which happens works for
  * a 16M page as well as we want only one iteration
diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 25e38809e4f7..32a1f94201d0 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -214,11 +214,6 @@
 
 #define PMD_BAD_BITS		(PTE_TABLE_SIZE-1)
 #define PUD_BAD_BITS		(PMD_TABLE_SIZE-1)
-/*
- * We save the slot number & secondary bit in the second half of the
- * PTE page. We use the 8 bytes per each pte entry.
- */
-#define PTE_PAGE_HIDX_OFFSET (PTRS_PER_PTE * 8)
 
 #ifndef __ASSEMBLY__
 #define	pmd_bad(pmd)		(!is_kernel_addr(pmd_val(pmd)) \
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index f0faa80ceac1..83a4cc5fc306 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -293,7 +293,7 @@ static inline pte_basic_t pte_val(pte_t x)
  * the "second half" part of the PTE for pseudo 64k pages
  */
 #if defined(CONFIG_PPC_64K_PAGES) && defined(CONFIG_PPC_STD_MMU_64)
-typedef struct { pte_t pte; unsigned long hidx; } real_pte_t;
+typedef struct { pte_t pte; unsigned char *hidx; } real_pte_t;
 #else
 typedef struct { pte_t pte; } real_pte_t;
 #endif
@@ -345,7 +345,7 @@ static inline pte_basic_t pte_val(pte_t pte)
 }
 
 #if defined(CONFIG_PPC_64K_PAGES) && defined(CONFIG_PPC_STD_MMU_64)
-typedef struct { pte_t pte; unsigned long hidx; } real_pte_t;
+typedef struct { pte_t pte; unsigned char *hidx; } real_pte_t;
 #else
 typedef pte_t real_pte_t;
 #endif
diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
index 87cba0688fce..423f47a89299 100644
--- a/arch/powerpc/mm/hash64_64k.c
+++ b/arch/powerpc/mm/hash64_64k.c
@@ -16,12 +16,32 @@
 #include <asm/machdep.h>
 #include <asm/mmu.h>
 
+real_pte_t __real_pte(unsigned long addr, pte_t pte, pte_t *ptep)
+{
+	int indx;
+	real_pte_t rpte;
+	pte_t *pte_headp;
+
+	rpte.pte = pte;
+	rpte.hidx = NULL;
+	if (pte_val(pte) & _PAGE_COMBO) {
+		indx = pte_index(addr);
+		pte_headp = ptep - indx;
+		/*
+		 * Make sure we order the hidx load against the _PAGE_COMBO
+		 * check. The store side ordering is done in __hash_page_4K
+		 */
+		smp_rmb();
+		rpte.hidx = (unsigned char *)(pte_headp + PTRS_PER_PTE) + (16 * indx);
+	}
+	return rpte;
+}
+
 int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 		   pte_t *ptep, unsigned long trap, unsigned long flags,
 		   int ssize, int subpg_prot)
 {
 	real_pte_t rpte;
-	unsigned long *hidxp;
 	unsigned long hpte_group;
 	unsigned int subpg_index;
 	unsigned long shift = 12; /* 4K */
@@ -90,7 +110,10 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 
 	subpg_index = (ea & (PAGE_SIZE - 1)) >> shift;
 	vpn  = hpt_vpn(ea, vsid, ssize);
-	rpte = __real_pte(ea, __pte(old_pte), ptep);
+	if (!(old_pte & _PAGE_COMBO))
+		rpte = __real_pte(ea, __pte(old_pte | _PAGE_COMBO), ptep);
+	else
+		rpte = __real_pte(ea, __pte(old_pte), ptep);
 	/*
 	 *None of the sub 4k page is hashed
 	 */
@@ -188,11 +211,8 @@ repeat:
 	 * Since we have _PAGE_BUSY set on ptep, we can be sure
 	 * nobody is undating hidx.
 	 */
-	hidxp = (unsigned long *)(ptep + PTRS_PER_PTE);
-	/* __real_pte use pte_val() any idea why ? FIXME!! */
-	rpte.hidx &= ~(0xfUL << (subpg_index << 2));
-	*hidxp = rpte.hidx  | (slot << (subpg_index << 2));
-	new_pte |= (_PAGE_HPTE_SUB0 >> subpg_index);
+	rpte.hidx[subpg_index] = (unsigned char)(slot << 4 | 0x1 << 3);
+	new_pte |= _PAGE_HPTE_SUB0;
 	/*
 	 * check __real_pte for details on matching smp_rmb()
 	 */
-- 
2.5.0
