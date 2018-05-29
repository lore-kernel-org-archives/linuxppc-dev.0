Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wGLq0s70zDr4N
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 00:29:06 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4TENvoU047084
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 10:29:03 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j97n7u8q3-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 10:29:03 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Tue, 29 May 2018 10:29:02 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH V2 2/4] powerpc/mm/radix: Move function from radix.h to
 pgtable-radix.c
Date: Tue, 29 May 2018 19:58:39 +0530
In-Reply-To: <20180529142841.19428-1-aneesh.kumar@linux.ibm.com>
References: <20180529142841.19428-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20180529142841.19428-2-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In later patch we will update them which require them to be moved
to pgtable-radix.c. Keeping the function in radix.h results in
compile warning as below.

./arch/powerpc/include/asm/book3s/64/radix.h: In function ‘radix__ptep_set_access_flags’:
./arch/powerpc/include/asm/book3s/64/radix.h:196:28: error: dereferencing pointer to incomplete type ‘struct vm_area_struct’
  struct mm_struct *mm = vma->vm_mm;
                            ^~
./arch/powerpc/include/asm/book3s/64/radix.h:204:6: error: implicit declaration of function ‘atomic_read’; did you mean ‘__atomic_load’? [-Werror=implicit-function-declaration]
      atomic_read(&mm->context.copros) > 0) {
      ^~~~~~~~~~~
      __atomic_load
./arch/powerpc/include/asm/book3s/64/radix.h:204:21: error: dereferencing pointer to incomplete type ‘struct mm_struct’
      atomic_read(&mm->context.copros) > 0) {

Instead of fixing header dependencies, we move the function to pgtable-radix.c
Also the function is now large to be a static inline . Doing the
move in separate patch helps in review.

No functional change in this patch. Only code movement.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/radix.h | 31 +++-------------------
 arch/powerpc/mm/pgtable-radix.c            | 22 +++++++++++++++
 2 files changed, 25 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index 705193e7192f..36ed025b4e13 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -124,6 +124,9 @@ extern void radix__mark_rodata_ro(void);
 extern void radix__mark_initmem_nx(void);
 #endif
 
+extern void radix__ptep_set_access_flags(struct mm_struct *mm, pte_t *ptep,
+					 pte_t entry, unsigned long address);
+
 static inline unsigned long __radix_pte_update(pte_t *ptep, unsigned long clr,
 					       unsigned long set)
 {
@@ -190,34 +193,6 @@ static inline pte_t radix__ptep_get_and_clear_full(struct mm_struct *mm,
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
index ce24d72ea679..a6eec41dd347 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -1084,3 +1084,25 @@ int radix__has_transparent_hugepage(void)
 	return 0;
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
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
