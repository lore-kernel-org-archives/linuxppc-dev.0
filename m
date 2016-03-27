Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qXqqZ51H2zDqFn
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 19:25:46 +1100 (AEDT)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 27 Mar 2016 02:25:44 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 9252F3E4003B
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 02:25:41 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2R8Pf0H46399618
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 01:25:41 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2R8PfPU029561
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 02:25:41 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 34/65] powerpc/mm/radix: Add mmu context handling callback for
 radix
Date: Sun, 27 Mar 2016 13:53:42 +0530
Message-Id: <1459067053-10835-34-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mmu_context.h |  4 ++++
 arch/powerpc/mm/mmu_context_hash64.c   | 42 +++++++++++++++++++++++++++-------
 2 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 0dd522ff4559..8f16a065d33d 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -37,10 +37,14 @@ extern void switch_slb(struct task_struct *tsk, struct mm_struct *mm);
 extern void set_context(unsigned long id, pgd_t *pgd);
 
 #ifdef CONFIG_PPC_BOOK3S_64
+extern void switch_radix_mmu_context(struct mm_struct *prev,
+				     struct mm_struct *next);
 static inline void switch_mmu_context(struct mm_struct *prev,
 				      struct mm_struct *next,
 				      struct task_struct *tsk)
 {
+	if (radix_enabled())
+		return switch_radix_mmu_context(prev, next);
 	return switch_slb(tsk, next);
 }
 
diff --git a/arch/powerpc/mm/mmu_context_hash64.c b/arch/powerpc/mm/mmu_context_hash64.c
index 4e4efbc2658e..08cc3182b744 100644
--- a/arch/powerpc/mm/mmu_context_hash64.c
+++ b/arch/powerpc/mm/mmu_context_hash64.c
@@ -58,6 +58,17 @@ again:
 	return index;
 }
 EXPORT_SYMBOL_GPL(__init_new_context);
+static int rinit_new_context(struct mm_struct *mm, int index)
+{
+	unsigned long rts_field;
+
+	/*
+	 * set the process table entry,
+	 */
+	rts_field = 3ull << PPC_BITLSHIFT(2);
+	process_tb[index].prtb0 = cpu_to_be64(rts_field | __pa(mm->pgd) | R_PGD_INDEX_SIZE);
+	return 0;
+}
 
 int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
@@ -67,13 +78,18 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 	if (index < 0)
 		return index;
 
-	/* The old code would re-promote on fork, we don't do that
-	 * when using slices as it could cause problem promoting slices
-	 * that have been forced down to 4K
-	 */
-	if (slice_mm_new_context(mm))
-		slice_set_user_psize(mm, mmu_virtual_psize);
-	subpage_prot_init_new_context(mm);
+	if (radix_enabled()) {
+		rinit_new_context(mm, index);
+	} else {
+
+		/* The old code would re-promote on fork, we don't do that
+		 * when using slices as it could cause problem promoting slices
+		 * that have been forced down to 4K
+		 */
+		if (slice_mm_new_context(mm))
+			slice_set_user_psize(mm, mmu_virtual_psize);
+		subpage_prot_init_new_context(mm);
+	}
 	mm->context.id = index;
 #ifdef CONFIG_PPC_ICSWX
 	mm->context.cop_lockp = kmalloc(sizeof(spinlock_t), GFP_KERNEL);
@@ -145,8 +161,18 @@ void destroy_context(struct mm_struct *mm)
 	mm->context.cop_lockp = NULL;
 #endif /* CONFIG_PPC_ICSWX */
 
+	if (radix_enabled())
+		process_tb[mm->context.id].prtb1 = 0;
+	else
+		subpage_prot_free(mm);
 	destroy_pagetable_page(mm);
 	__destroy_context(mm->context.id);
-	subpage_prot_free(mm);
 	mm->context.id = MMU_NO_CONTEXT;
 }
+
+void switch_radix_mmu_context(struct mm_struct *prev, struct mm_struct *next)
+{
+	mtspr(SPRN_PID, next->context.id);
+	asm volatile("isync": : :"memory");
+
+}
-- 
2.5.0
