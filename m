Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40srKQ4XKNzF1yq
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 May 2018 01:49:29 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4PFio8g032137
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 11:49:27 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j6n7c0pva-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 11:49:27 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Fri, 25 May 2018 09:49:26 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH 1/2] powerpc/mm/radix: Move functions from radix.h to
 pgtable-radix.c
Date: Fri, 25 May 2018 21:19:16 +0530
Message-Id: <20180525154917.23163-1-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In later patch we will update them which require them to be moved
to pgtable-radix.c Doing the move in separate patch helps in review.

No function change in this patch. Only code movement.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/radix.h | 63 +++-------------------
 arch/powerpc/mm/pgtable-radix.c            | 48 +++++++++++++++++
 2 files changed, 54 insertions(+), 57 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index 705193e7192f..ff642441aaf6 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -124,6 +124,12 @@ extern void radix__mark_rodata_ro(void);
 extern void radix__mark_initmem_nx(void);
 #endif
 
+extern unsigned long radix__pte_update(struct mm_struct *mm, unsigned long addr,
+				       pte_t *ptep, unsigned long clr,
+				       unsigned long set, int huge);
+extern void radix__ptep_set_access_flags(struct mm_struct *mm, pte_t *ptep,
+					 pte_t entry, unsigned long address);
+
 static inline unsigned long __radix_pte_update(pte_t *ptep, unsigned long clr,
 					       unsigned long set)
 {
@@ -140,35 +146,6 @@ static inline unsigned long __radix_pte_update(pte_t *ptep, unsigned long clr,
 	return old_pte;
 }
 
-
-static inline unsigned long radix__pte_update(struct mm_struct *mm,
-					unsigned long addr,
-					pte_t *ptep, unsigned long clr,
-					unsigned long set,
-					int huge)
-{
-	unsigned long old_pte;
-
-	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
-
-		unsigned long new_pte;
-
-		old_pte = __radix_pte_update(ptep, ~0ul, 0);
-		/*
-		 * new value of pte
-		 */
-		new_pte = (old_pte | set) & ~clr;
-		radix__flush_tlb_pte_p9_dd1(old_pte, mm, addr);
-		if (new_pte)
-			__radix_pte_update(ptep, 0, new_pte);
-	} else
-		old_pte = __radix_pte_update(ptep, clr, set);
-	if (!huge)
-		assert_pte_locked(mm, addr);
-
-	return old_pte;
-}
-
 static inline pte_t radix__ptep_get_and_clear_full(struct mm_struct *mm,
 						   unsigned long addr,
 						   pte_t *ptep, int full)
@@ -190,34 +167,6 @@ static inline pte_t radix__ptep_get_and_clear_full(struct mm_struct *mm,
 	return __pte(old_pte);
 }
 
-/*
- * Set the dirty and/or accessed bits atomically in a linux PTE, this
- * function doesn't need to invalidate tlb.
- */
-static inline void radix__ptep_set_access_flags(struct mm_struct *mm,
-						pte_t *ptep, pte_t entry,
-						unsigned long address)
-{
-
-	unsigned long set = pte_val(entry) & (_PAGE_DIRTY | _PAGE_ACCESSED |
-					      _PAGE_RW | _PAGE_EXEC);
-
-	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
-
-		unsigned long old_pte, new_pte;
-
-		old_pte = __radix_pte_update(ptep, ~0, 0);
-		/*
-		 * new value of pte
-		 */
-		new_pte = old_pte | set;
-		radix__flush_tlb_pte_p9_dd1(old_pte, mm, address);
-		__radix_pte_update(ptep, 0, new_pte);
-	} else
-		__radix_pte_update(ptep, 0, set);
-	asm volatile("ptesync" : : : "memory");
-}
-
 static inline int radix__pte_same(pte_t pte_a, pte_t pte_b)
 {
 	return ((pte_raw(pte_a) ^ pte_raw(pte_b)) == 0);
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index ce24d72ea679..68931ca549f7 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -1084,3 +1084,51 @@ int radix__has_transparent_hugepage(void)
 	return 0;
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
+unsigned long radix__pte_update(struct mm_struct *mm, unsigned long addr,
+				pte_t *ptep, unsigned long clr,
+				unsigned long set, int huge)
+{
+	unsigned long old_pte;
+
+	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
+
+		unsigned long new_pte;
+
+		old_pte = __radix_pte_update(ptep, ~0ul, 0);
+		/*
+		 * new value of pte
+		 */
+		new_pte = (old_pte | set) & ~clr;
+		radix__flush_tlb_pte_p9_dd1(old_pte, mm, addr);
+		if (new_pte)
+			__radix_pte_update(ptep, 0, new_pte);
+	} else
+		old_pte = __radix_pte_update(ptep, clr, set);
+	if (!huge)
+		assert_pte_locked(mm, addr);
+
+	return old_pte;
+}
+
+void radix__ptep_set_access_flags(struct mm_struct *mm,
+				  pte_t *ptep, pte_t entry,
+				  unsigned long address)
+{
+	unsigned long set = pte_val(entry) & (_PAGE_DIRTY | _PAGE_ACCESSED |
+					      _PAGE_RW | _PAGE_EXEC);
+
+	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
+		unsigned long old_pte, new_pte;
+
+		old_pte = __radix_pte_update(ptep, ~0, 0);
+		/*
+		 * new value of pte
+		 */
+		new_pte = old_pte | set;
+		radix__flush_tlb_pte_p9_dd1(old_pte, mm, address);
+		__radix_pte_update(ptep, 0, new_pte);
+	} else
+		__radix_pte_update(ptep, 0, set);
+	asm volatile("ptesync" : : : "memory");
+}
-- 
2.17.0
