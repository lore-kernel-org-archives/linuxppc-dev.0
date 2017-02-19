Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vR2x31G1WzDqBr
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 21:26:31 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1JANsI8052326
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 05:26:28 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28pnxny7hx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 05:26:28 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 19 Feb 2017 20:26:25 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 3DBD72BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 21:26:17 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1JAQ9fg15859908
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 21:26:17 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1JAPiYc025883
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 21:25:44 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: akpm@linux-foundation.org, Rik van Riel <riel@surriel.com>,
 Mel Gorman <mgorman@techsingularity.net>, paulus@ozlabs.org,
 benh@kernel.crashing.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V3 0/3] Numabalancing preserve write fix
In-Reply-To: <1487498625-10891-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1487498625-10891-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Sun, 19 Feb 2017 15:55:19 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87r32ucwa8.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


I am not sure whether we want to merge this debug patch. This will help
us in identifying wrong pte_wrprotect usage in the kernel.

>From a0fbbbbb302fd204159a1327b67decb8f14ffa21 Mon Sep 17 00:00:00 2001
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Sat, 18 Feb 2017 10:39:47 +0530
Subject: [PATCH] powerpc/autonuma: Add debug check for wrong writable pte
 check

With ppc64, protnone ptes don't use _PAGE_WRITE bit for savedwrite. Hence
we need to make sure we don't do pte_write* functions on protnone ptes.
Add debug check to catch wrong usage.

This should be only used for debugging and can give wrong results w.r.t change
bit on radix. Even on hash with kvm we will insert the page table entry in
guest hash page table with write bit set, even if the pte is marked protnone.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 130 +++++++++++++++++----------
 1 file changed, 85 insertions(+), 45 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index d87bee85fc44..1c99deac3966 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -341,10 +341,36 @@ static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
 	__r;							\
 })
 
+#undef SAVED_WRITE_DEBUG
+#ifdef CONFIG_NUMA_BALANCING
+static inline int pte_protnone(pte_t pte)
+{
+	/*
+	 * We want to catch wrong usage of pte_write w.r.t protnone ptes.
+	 * The way we do that is to make saved write as _PAGE_WRITE for hash
+	 * translation mode. This only will work with hash translation mode.
+	 */
+#ifdef SAVED_WRITE_DEBUG
+	if (!radix_enabled())
+		return (pte_raw(pte) & cpu_to_be64(_PAGE_PRESENT | _PAGE_PRIVILEGED)) ==
+			cpu_to_be64(_PAGE_PRESENT | _PAGE_PRIVILEGED);
+#endif
+	return (pte_raw(pte) & cpu_to_be64(_PAGE_PRESENT | _PAGE_PTE | _PAGE_RWX)) ==
+		cpu_to_be64(_PAGE_PRESENT | _PAGE_PTE);
+}
+#endif
+
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 				      pte_t *ptep)
 {
+#ifdef SAVED_WRITE_DEBUG
+	/*
+	 * Cannot use this with protnone pte, For protnone, writes
+	 * will be marked via savedwrite bit.
+	 */
+	VM_WARN_ON(pte_protnone(*ptep));
+#endif
 	if ((pte_raw(*ptep) & cpu_to_be64(_PAGE_WRITE)) == 0)
 		return;
 
@@ -430,51 +456,6 @@ static inline pte_t pte_clear_soft_dirty(pte_t pte)
 }
 #endif /* CONFIG_HAVE_ARCH_SOFT_DIRTY */
 
-#ifdef CONFIG_NUMA_BALANCING
-static inline int pte_protnone(pte_t pte)
-{
-	return (pte_raw(pte) & cpu_to_be64(_PAGE_PRESENT | _PAGE_PTE | _PAGE_RWX)) ==
-		cpu_to_be64(_PAGE_PRESENT | _PAGE_PTE);
-}
-
-#define pte_mk_savedwrite pte_mk_savedwrite
-static inline pte_t pte_mk_savedwrite(pte_t pte)
-{
-	/*
-	 * Used by Autonuma subsystem to preserve the write bit
-	 * while marking the pte PROT_NONE. Only allow this
-	 * on PROT_NONE pte
-	 */
-	VM_BUG_ON((pte_raw(pte) & cpu_to_be64(_PAGE_PRESENT | _PAGE_RWX | _PAGE_PRIVILEGED)) !=
-		  cpu_to_be64(_PAGE_PRESENT | _PAGE_PRIVILEGED));
-	return __pte(pte_val(pte) & ~_PAGE_PRIVILEGED);
-}
-
-#define pte_clear_savedwrite pte_clear_savedwrite
-static inline pte_t pte_clear_savedwrite(pte_t pte)
-{
-	/*
-	 * Used by KSM subsystem to make a protnone pte readonly.
-	 */
-	VM_BUG_ON(!pte_protnone(pte));
-	return __pte(pte_val(pte) | _PAGE_PRIVILEGED);
-}
-
-#define pte_savedwrite pte_savedwrite
-static inline bool pte_savedwrite(pte_t pte)
-{
-	/*
-	 * Saved write ptes are prot none ptes that doesn't have
-	 * privileged bit sit. We mark prot none as one which has
-	 * present and pviliged bit set and RWX cleared. To mark
-	 * protnone which used to have _PAGE_WRITE set we clear
-	 * the privileged bit.
-	 */
-	VM_BUG_ON(!pte_protnone(pte));
-	return !(pte_raw(pte) & cpu_to_be64(_PAGE_RWX | _PAGE_PRIVILEGED));
-}
-#endif /* CONFIG_NUMA_BALANCING */
-
 static inline int pte_present(pte_t pte)
 {
 	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_PRESENT));
@@ -500,6 +481,14 @@ static inline unsigned long pte_pfn(pte_t pte)
 /* Generic modifiers for PTE bits */
 static inline pte_t pte_wrprotect(pte_t pte)
 {
+
+#ifdef SAVED_WRITE_DEBUG
+	/*
+	 * Cannot use this with protnone pte, For protnone, writes
+	 * will be marked via savedwrite bit.
+	 */
+	VM_WARN_ON(pte_protnone(pte));
+#endif
 	return __pte(pte_val(pte) & ~_PAGE_WRITE);
 }
 
@@ -552,6 +541,57 @@ static inline bool pte_user(pte_t pte)
 	return !(pte_raw(pte) & cpu_to_be64(_PAGE_PRIVILEGED));
 }
 
+#ifdef CONFIG_NUMA_BALANCING
+#define pte_mk_savedwrite pte_mk_savedwrite
+static inline pte_t pte_mk_savedwrite(pte_t pte)
+{
+#ifdef SAVED_WRITE_DEBUG
+	if (!radix_enabled())
+		return pte_mkwrite(pte);
+#endif
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
+#ifdef SAVED_WRITE_DEBUG
+	if (!radix_enabled())
+		return __pte(pte_val(pte) & ~_PAGE_WRITE);
+#endif
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
+#ifdef SAVED_WRITE_DEBUG
+	if (!radix_enabled())
+		return pte_write(pte);
+#endif
+	return !(pte_raw(pte) & cpu_to_be64(_PAGE_RWX | _PAGE_PRIVILEGED));
+}
+#endif /* CONFIG_NUMA_BALANCING */
+
 /* Encode and de-code a swap entry */
 #define MAX_SWAPFILES_CHECK() do { \
 	BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > SWP_TYPE_BITS); \
-- 
2.7.4
