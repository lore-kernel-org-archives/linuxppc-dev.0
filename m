Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 11D531A0836
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 05:40:36 +1100 (AEDT)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 13 Oct 2015 00:10:34 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 9DAF4E0056
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 00:10:27 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9CIeUm62752890
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 00:10:30 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9CIeTRF013595
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 00:10:30 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v3 18/31] powerpc/mm: Increase the pte frag size.
Date: Tue, 13 Oct 2015 00:10:02 +0530
Message-Id: <1444675215-19484-19-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1444675215-19484-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1444675215-19484-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
