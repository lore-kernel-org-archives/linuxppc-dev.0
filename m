Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6B8751A08BB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 02:50:42 +1100 (AEDT)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 12 Jan 2016 01:50:41 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id BF3673578052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 02:50:29 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0BFoCVU36503802
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 02:50:20 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0BFnuOi022239
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 02:49:57 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2] mm/powerpc: Fix _PAGE_PTE breaking swapoff
Date: Mon, 11 Jan 2016 21:19:34 +0530
Message-Id: <1452527374-4886-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Core kernel expect swp_entry_t to be consisting of
only swap type and swap offset. We should not leak pte bits to
swp_entry_t. This breaks swapoff which use the swap type and offset
to build a swp_entry_t and later compare that to the swp_entry_t
obtained from linux page table pte. Leaking pte bits to swp_entry_t
breaks that comparison and results in us looping in try_to_unuse.

The stack trace can be anywhere below try_to_unuse() in mm/swapfile.c,
since swapoff is circling around and around that function, reading from
each used swap block into a page, then trying to find where that page
belongs, looking at every non-file pte of every mm that ever swapped.

Reported-by: Hugh Dickins <hughd@google.com>
Suggested-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
Changes from V1:
* improve change log and code comment

 arch/powerpc/include/asm/book3s/64/pgtable.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 03c1a5a21c0c..cecb971674a8 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -158,9 +158,14 @@ static inline void pgd_set(pgd_t *pgdp, unsigned long val)
 #define __swp_entry(type, offset)	((swp_entry_t) { \
 					((type) << _PAGE_BIT_SWAP_TYPE) \
 					| ((offset) << PTE_RPN_SHIFT) })
-
-#define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val((pte)) })
-#define __swp_entry_to_pte(x)		__pte((x).val)
+/*
+ * swp_entry_t should be independent of pte bits. We build a swp_entry_t from
+ * swap type and offset we get from swap and convert that to pte to
+ * find a matching pte in linux page table.
+ * Clear bits not found in swap entries here
+ */
+#define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val((pte)) & ~_PAGE_PTE })
+#define __swp_entry_to_pte(x)	__pte((x).val | _PAGE_PTE)
 
 #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
 #define _PAGE_SWP_SOFT_DIRTY   (1UL << (SWP_TYPE_BITS + _PAGE_BIT_SWAP_TYPE))
-- 
2.5.0
