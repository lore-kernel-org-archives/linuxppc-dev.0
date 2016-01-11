Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BBDFA1A0202
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 21:07:07 +1100 (AEDT)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 11 Jan 2016 20:07:05 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id B40FA2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 21:07:00 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0BA6cER23003156
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 21:06:51 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0BA6MqZ010132
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 21:06:23 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] mm/powerpc: Fix _PAGE_PTE breaking swapoff
Date: Mon, 11 Jan 2016 15:35:50 +0530
Message-Id: <1452506750-2355-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When converting a swp_entry_t to pte, we need to add _PAGE_PTE,
because we later compare the pte with linux page table entries to
find a matching pte. We do set _PAGE_PTE on pte entries on linux page
table even if it is a swap entry. So add them when converting
swp_entry_t to pte_t

The stack trace can be anywhere below try_to_unuse() in mm/swapfile.c,
since swapoff is circling around and around that function, reading from
each used swap block into a page, then trying to find where that page
belongs, looking at every non-file pte of every mm that ever swapped.

Reported-by: Hugh Dickins <hughd@google.com>
Suggested-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 03c1a5a21c0c..48edcd8fbc4f 100644
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
+ * swp_entry_t should be arch independent. We build a swp_entry_t from
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
