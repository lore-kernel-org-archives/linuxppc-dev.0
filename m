Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vR2Rg0KbVzDqHV
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 21:04:30 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1JA3dPY142597
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 05:04:29 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28pphtwcn2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 05:04:28 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 19 Feb 2017 03:04:28 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: akpm@linux-foundation.org, Rik van Riel <riel@surriel.com>,
 Mel Gorman <mgorman@techsingularity.net>, paulus@ozlabs.org,
 benh@kernel.crashing.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V3 3/3] powerpc/mm/autonuma: Switch ppc64 to its own
 implementeation of saved write
Date: Sun, 19 Feb 2017 15:33:45 +0530
In-Reply-To: <1487498625-10891-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1487498625-10891-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1487498625-10891-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With this our protnone becomes a present pte with READ/WRITE/EXEC bit cleared.
By default we also set _PAGE_PRIVILEGED on such pte. This is now used to help
us identify a protnone pte that as saved write bit. For such pte, we will clear
the _PAGE_PRIVILEGED bit. The pte still remain non-accessible from both user
and kernel.

Acked-By: Michael Neuling <mikey@neuling.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 52 ++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 6a55bbe91556..d87bee85fc44 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1,6 +1,9 @@
 #ifndef _ASM_POWERPC_BOOK3S_64_PGTABLE_H_
 #define _ASM_POWERPC_BOOK3S_64_PGTABLE_H_
 
+#ifndef __ASSEMBLY__
+#include <linux/mmdebug.h>
+#endif
 /*
  * Common bits between hash and Radix page table
  */
@@ -428,15 +431,47 @@ static inline pte_t pte_clear_soft_dirty(pte_t pte)
 #endif /* CONFIG_HAVE_ARCH_SOFT_DIRTY */
 
 #ifdef CONFIG_NUMA_BALANCING
-/*
- * These work without NUMA balancing but the kernel does not care. See the
- * comment in include/asm-generic/pgtable.h . On powerpc, this will only
- * work for user pages and always return true for kernel pages.
- */
 static inline int pte_protnone(pte_t pte)
 {
-	return (pte_raw(pte) & cpu_to_be64(_PAGE_PRESENT | _PAGE_PRIVILEGED)) ==
-		cpu_to_be64(_PAGE_PRESENT | _PAGE_PRIVILEGED);
+	return (pte_raw(pte) & cpu_to_be64(_PAGE_PRESENT | _PAGE_PTE | _PAGE_RWX)) ==
+		cpu_to_be64(_PAGE_PRESENT | _PAGE_PTE);
+}
+
+#define pte_mk_savedwrite pte_mk_savedwrite
+static inline pte_t pte_mk_savedwrite(pte_t pte)
+{
+	/*
+	 * Used by Autonuma subsystem to preserve the write bit
+	 * while marking the pte PROT_NONE. Only allow this
+	 * on PROT_NONE pte
+	 */
+	VM_BUG_ON((pte_raw(pte) & cpu_to_be64(_PAGE_PRESENT | _PAGE_RWX | _PAGE_PRIVILEGED)) !=
+		  cpu_to_be64(_PAGE_PRESENT | _PAGE_PRIVILEGED));
+	return __pte(pte_val(pte) & ~_PAGE_PRIVILEGED);
+}
+
+#define pte_clear_savedwrite pte_clear_savedwrite
+static inline pte_t pte_clear_savedwrite(pte_t pte)
+{
+	/*
+	 * Used by KSM subsystem to make a protnone pte readonly.
+	 */
+	VM_BUG_ON(!pte_protnone(pte));
+	return __pte(pte_val(pte) | _PAGE_PRIVILEGED);
+}
+
+#define pte_savedwrite pte_savedwrite
+static inline bool pte_savedwrite(pte_t pte)
+{
+	/*
+	 * Saved write ptes are prot none ptes that doesn't have
+	 * privileged bit sit. We mark prot none as one which has
+	 * present and pviliged bit set and RWX cleared. To mark
+	 * protnone which used to have _PAGE_WRITE set we clear
+	 * the privileged bit.
+	 */
+	VM_BUG_ON(!pte_protnone(pte));
+	return !(pte_raw(pte) & cpu_to_be64(_PAGE_RWX | _PAGE_PRIVILEGED));
 }
 #endif /* CONFIG_NUMA_BALANCING */
 
@@ -867,6 +902,8 @@ static inline pte_t *pmdp_ptep(pmd_t *pmd)
 #define pmd_mkclean(pmd)	pte_pmd(pte_mkclean(pmd_pte(pmd)))
 #define pmd_mkyoung(pmd)	pte_pmd(pte_mkyoung(pmd_pte(pmd)))
 #define pmd_mkwrite(pmd)	pte_pmd(pte_mkwrite(pmd_pte(pmd)))
+#define pmd_mk_savedwrite(pmd)	pte_pmd(pte_mk_savedwrite(pmd_pte(pmd)))
+#define pmd_clear_savedwrite(pmd)	pte_pmd(pte_clear_savedwrite(pmd_pte(pmd)))
 
 #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
 #define pmd_soft_dirty(pmd)    pte_soft_dirty(pmd_pte(pmd))
@@ -883,6 +920,7 @@ static inline int pmd_protnone(pmd_t pmd)
 
 #define __HAVE_ARCH_PMD_WRITE
 #define pmd_write(pmd)		pte_write(pmd_pte(pmd))
+#define pmd_savedwrite(pmd)	pte_savedwrite(pmd_pte(pmd))
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 extern pmd_t pfn_pmd(unsigned long pfn, pgprot_t pgprot);
-- 
2.7.4
