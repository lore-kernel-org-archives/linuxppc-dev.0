Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qXqpb07MKzDqFb
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 19:24:54 +1100 (AEDT)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 27 Mar 2016 04:24:52 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id C933AC90041
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 04:24:46 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2R8OpJC27263206
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 08:24:51 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2R8JYa7021965
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 04:19:34 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 12/65] powerpc/mm: Use generic version of
 ptep_clear_flush_young
Date: Sun, 27 Mar 2016 13:53:20 +0530
Message-Id: <1459067053-10835-12-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

The radix variant is going to require a flush_tlb_range. With
flush_tlb_range added, ptep_clear_flush_young is same as the generic
version. So drop the powerpc specific variant

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash.h | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index fd2d0ebfc49c..d54ebb16692c 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -280,6 +280,13 @@ static inline unsigned long pte_update(struct mm_struct *mm,
 	return old;
 }
 
+/*
+ * We currently remove entries from the hashtable regardless of whether
+ * the entry was young or dirty.
+ *
+ * We should be more intelligent about this but for the moment we override
+ * these functions and force a tlb flush unconditionally
+ */
 static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
 					      unsigned long addr, pte_t *ptep)
 {
@@ -318,22 +325,6 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 	pte_update(mm, addr, ptep, _PAGE_WRITE, 0, 1);
 }
 
-/*
- * We currently remove entries from the hashtable regardless of whether
- * the entry was young or dirty. The generic routines only flush if the
- * entry was young or dirty which is not good enough.
- *
- * We should be more intelligent about this but for the moment we override
- * these functions and force a tlb flush unconditionally
- */
-#define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
-#define ptep_clear_flush_young(__vma, __address, __ptep)		\
-({									\
-	int __young = __ptep_test_and_clear_young((__vma)->vm_mm, __address, \
-						  __ptep);		\
-	__young;							\
-})
-
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 				       unsigned long addr, pte_t *ptep)
-- 
2.5.0
