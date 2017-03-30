Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vv3G21vPxzDqLd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 23:04:26 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH v6 09/19] powerpc/mm: Split radix vs hash mm context
 initialisation
Date: Thu, 30 Mar 2017 23:03:57 +1100
Message-Id: <1490875447-4016-9-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1490875447-4016-1-git-send-email-mpe@ellerman.id.au>
References: <1490875447-4016-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Complete the split of the radix vs hash mm context initialisation.

This is mostly code movement, with the exception that we now limit the
context allocation to PRTB_ENTRIES - 1 on radix.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/mmu.h |  2 +
 arch/powerpc/mm/mmu_context_book3s64.c   | 67 ++++++++++++++++++++------------
 2 files changed, 45 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 805d4105e9bb..cce434e7de06 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -65,6 +65,8 @@ extern struct patb_entry *partition_tb;
  * MAX_USER_CONTEXT * 16 bytes of space.
  */
 #define PRTB_SIZE_SHIFT	(CONTEXT_BITS + 4)
+#define PRTB_ENTRIES	(1ul << CONTEXT_BITS)
+
 /*
  * Power9 currently only support 64K partition table size.
  */
diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index 981c3b02e46a..e5da551edde3 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -63,47 +63,66 @@ int hash__alloc_context_id(void)
 }
 EXPORT_SYMBOL_GPL(hash__alloc_context_id);
 
-static int radix__init_new_context(struct mm_struct *mm, int index)
+static int hash__init_new_context(struct mm_struct *mm)
+{
+	int index;
+
+	index = hash__alloc_context_id();
+	if (index < 0)
+		return index;
+
+	/*
+	 * The old code would re-promote on fork, we don't do that when using
+	 * slices as it could cause problem promoting slices that have been
+	 * forced down to 4K.
+	 *
+	 * For book3s we have MMU_NO_CONTEXT set to be ~0. Hence check
+	 * explicitly against context.id == 0. This ensures that we properly
+	 * initialize context slice details for newly allocated mm's (which will
+	 * have id == 0) and don't alter context slice inherited via fork (which
+	 * will have id != 0).
+	 *
+	 * We should not be calling init_new_context() on init_mm. Hence a
+	 * check against 0 is OK.
+	 */
+	if (mm->context.id == 0)
+		slice_set_user_psize(mm, mmu_virtual_psize);
+
+	subpage_prot_init_new_context(mm);
+
+	return index;
+}
+
+static int radix__init_new_context(struct mm_struct *mm)
 {
 	unsigned long rts_field;
+	int index;
+
+	index = alloc_context_id(1, PRTB_ENTRIES - 1);
+	if (index < 0)
+		return index;
 
 	/*
 	 * set the process table entry,
 	 */
 	rts_field = radix__get_tree_size();
 	process_tb[index].prtb0 = cpu_to_be64(rts_field | __pa(mm->pgd) | RADIX_PGD_INDEX_SIZE);
-	return 0;
+
+	return index;
 }
 
 int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
 	int index;
 
-	index = hash__alloc_context_id();
+	if (radix_enabled())
+		index = radix__init_new_context(mm);
+	else
+		index = hash__init_new_context(mm);
+
 	if (index < 0)
 		return index;
 
-	if (radix_enabled()) {
-		radix__init_new_context(mm, index);
-	} else {
-
-		/* The old code would re-promote on fork, we don't do that
-		 * when using slices as it could cause problem promoting slices
-		 * that have been forced down to 4K
-		 *
-		 * For book3s we have MMU_NO_CONTEXT set to be ~0. Hence check
-		 * explicitly against context.id == 0. This ensures that we
-		 * properly initialize context slice details for newly allocated
-		 * mm's (which will have id == 0) and don't alter context slice
-		 * inherited via fork (which will have id != 0).
-		 *
-		 * We should not be calling init_new_context() on init_mm. Hence a
-		 * check against 0 is ok.
-		 */
-		if (mm->context.id == 0)
-			slice_set_user_psize(mm, mmu_virtual_psize);
-		subpage_prot_init_new_context(mm);
-	}
 	mm->context.id = index;
 #ifdef CONFIG_PPC_ICSWX
 	mm->context.cop_lockp = kmalloc(sizeof(spinlock_t), GFP_KERNEL);
-- 
2.7.4
