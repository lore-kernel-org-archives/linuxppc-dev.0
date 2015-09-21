Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 80BBD1A009D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:42:43 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 21 Sep 2015 16:42:41 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 2DA982CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:42:39 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8L6gLpg786830
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:42:29 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8L6g6l6015104
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:42:06 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 18/31] powerpc/mm: Increase the pte frag size.
Date: Mon, 21 Sep 2015 12:10:45 +0530
Message-Id: <1442817658-2588-19-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1442817658-2588-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1442817658-2588-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We will use the increased size to store more information of 4K pte
when using 64K page size. The idea is to free up bits in pte_t.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pgalloc-64.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/pgalloc-64.h b/arch/powerpc/include/asm/pgalloc-64.h
index d8cde71f6734..4f1cc6c46728 100644
--- a/arch/powerpc/include/asm/pgalloc-64.h
+++ b/arch/powerpc/include/asm/pgalloc-64.h
@@ -164,15 +164,15 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 
 #else /* if CONFIG_PPC_64K_PAGES */
 /*
- * we support 16 fragments per PTE page.
+ * we support 8 fragments per PTE page.
  */
-#define PTE_FRAG_NR	16
+#define PTE_FRAG_NR	8
 /*
- * We use a 2K PTE page fragment and another 2K for storing
- * real_pte_t hash index
+ * We use a 2K PTE page fragment and another 4K for storing
+ * real_pte_t hash index. Rounding the entire thing to 8K
  */
-#define PTE_FRAG_SIZE_SHIFT  12
-#define PTE_FRAG_SIZE (2 * PTRS_PER_PTE * sizeof(pte_t))
+#define PTE_FRAG_SIZE_SHIFT  13
+#define PTE_FRAG_SIZE (1UL << PTE_FRAG_SIZE_SHIFT)
 
 extern pte_t *page_table_alloc(struct mm_struct *, unsigned long, int);
 extern void page_table_free(struct mm_struct *, unsigned long *, int);
-- 
2.5.0
