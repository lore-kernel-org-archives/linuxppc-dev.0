Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDyF5YBZzDqBS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:27:17 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 39/70] powerpc/mm/radix: Add mmu context handling callback
 for radix
Date: Fri, 29 Apr 2016 23:26:02 +1000
Message-Id: <1461936393-10131-39-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
References: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/mmu_context.h |  4 ++++
 arch/powerpc/mm/mmu_context_hash64.c   | 43 +++++++++++++++++++++++++++-------
 2 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 4e2a29443384..9d2cd0c36ec2 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -37,10 +37,14 @@ extern void switch_slb(struct task_struct *tsk, struct mm_struct *mm);
 extern void set_context(unsigned long id, pgd_t *pgd);
 
 #ifdef CONFIG_PPC_BOOK3S_64
+extern void radix__switch_mmu_context(struct mm_struct *prev,
+				     struct mm_struct *next);
 static inline void switch_mmu_context(struct mm_struct *prev,
 				      struct mm_struct *next,
 				      struct task_struct *tsk)
 {
+	if (radix_enabled())
+		return radix__switch_mmu_context(prev, next);
 	return switch_slb(tsk, next);
 }
 
diff --git a/arch/powerpc/mm/mmu_context_hash64.c b/arch/powerpc/mm/mmu_context_hash64.c
index 9ca6fe16cb29..b5288b460bef 100644
--- a/arch/powerpc/mm/mmu_context_hash64.c
+++ b/arch/powerpc/mm/mmu_context_hash64.c
@@ -58,6 +58,17 @@ again:
 	return index;
 }
 EXPORT_SYMBOL_GPL(__init_new_context);
+static int radix__init_new_context(struct mm_struct *mm, int index)
+{
+	unsigned long rts_field;
+
+	/*
+	 * set the process table entry,
+	 */
+	rts_field = 3ull << PPC_BITLSHIFT(2);
+	process_tb[index].prtb0 = cpu_to_be64(rts_field | __pa(mm->pgd) | RADIX_PGD_INDEX_SIZE);
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
+		radix__init_new_context(mm, index);
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
@@ -144,8 +160,19 @@ void destroy_context(struct mm_struct *mm)
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
+#ifdef CONFIG_PPC_RADIX_MMU
+void radix__switch_mmu_context(struct mm_struct *prev, struct mm_struct *next)
+{
+	mtspr(SPRN_PID, next->context.id);
+	asm volatile("isync": : :"memory");
+}
+#endif
-- 
2.5.0
