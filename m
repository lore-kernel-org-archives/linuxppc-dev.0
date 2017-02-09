Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJjTD1407zDqGh
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Feb 2017 13:58:55 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v192wfCn053757
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2017 21:58:54 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28gcn7ev2s-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Feb 2017 21:58:53 -0500
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 8 Feb 2017 21:58:52 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 2/3] powerpc/mm/radix: Use ptep_get_and_clear_full when
 clearing pte for full mm
Date: Thu,  9 Feb 2017 08:28:20 +0530
In-Reply-To: <1486609101-5231-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1486609101-5231-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1486609101-5231-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This helps us to do some optimization for application exit case, where we can
skip the DD1 style pte update sequence.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 17 +++++++++++++++++
 arch/powerpc/include/asm/book3s/64/radix.h   | 23 ++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 6f15bde94da2..e91ada786d48 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -373,6 +373,23 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 	return __pte(old);
 }
 
+#define __HAVE_ARCH_PTEP_GET_AND_CLEAR_FULL
+static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
+					    unsigned long addr,
+					    pte_t *ptep, int full)
+{
+	if (full && radix_enabled()) {
+		/*
+		 * Let's skip the DD1 style pte update here. We know that
+		 * this is a full mm pte clear and hence can be sure there is
+		 * no parallel set_pte.
+		 */
+		return radix__ptep_get_and_clear_full(mm, addr, ptep, full);
+	}
+	return ptep_get_and_clear(mm, addr, ptep);
+}
+
+
 static inline void pte_clear(struct mm_struct *mm, unsigned long addr,
 			     pte_t * ptep)
 {
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index 70a3cdcdbe47..fcf822d6c204 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -139,7 +139,7 @@ static inline unsigned long radix__pte_update(struct mm_struct *mm,
 
 		unsigned long new_pte;
 
-		old_pte = __radix_pte_update(ptep, ~0, 0);
+		old_pte = __radix_pte_update(ptep, ~0ul, 0);
 		/*
 		 * new value of pte
 		 */
@@ -157,6 +157,27 @@ static inline unsigned long radix__pte_update(struct mm_struct *mm,
 	return old_pte;
 }
 
+static inline pte_t radix__ptep_get_and_clear_full(struct mm_struct *mm,
+						   unsigned long addr,
+						   pte_t *ptep, int full)
+{
+	unsigned long old_pte;
+
+	if (full) {
+		/*
+		 * If we are trying to clear the pte, we can skip
+		 * the DD1 pte update sequence and batch the tlb flush. The
+		 * tlb flush batching is done by mmu gather code. We
+		 * still keep the cmp_xchg update to make sure we get
+		 * correct R/C bit which might be updated via Nest MMU.
+		 */
+		old_pte = __radix_pte_update(ptep, ~0ul, 0);
+	} else
+		old_pte = radix__pte_update(mm, addr, ptep, ~0ul, 0, 0);
+
+	return __pte(old_pte);
+}
+
 /*
  * Set the dirty and/or accessed bits atomically in a linux PTE, this
  * function doesn't need to invalidate tlb.
-- 
2.7.4
