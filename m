Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qXqqY3VQRzDqHc
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 19:25:45 +1100 (AEDT)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 27 Mar 2016 02:25:43 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id E4A7D1FF001F
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 02:13:48 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2R8PexZ41287854
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 01:25:40 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2R8PdmY001217
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 02:25:39 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 33/65] powerpc/mm: Abstraction for switch_mmu_context
Date: Sun, 27 Mar 2016 13:53:41 +0530
Message-Id: <1459067053-10835-33-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/mmu_context.h | 25 +++++++++++++------------
 arch/powerpc/kernel/swsusp.c           |  2 +-
 arch/powerpc/mm/mmu_context_nohash.c   |  3 ++-
 drivers/cpufreq/pmac32-cpufreq.c       |  2 +-
 drivers/macintosh/via-pmu.c            |  4 ++--
 5 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 878c27771717..0dd522ff4559 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -33,16 +33,23 @@ extern long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
 extern long mm_iommu_mapped_inc(struct mm_iommu_table_group_mem_t *mem);
 extern void mm_iommu_mapped_dec(struct mm_iommu_table_group_mem_t *mem);
 #endif
-
-extern void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next);
 extern void switch_slb(struct task_struct *tsk, struct mm_struct *mm);
 extern void set_context(unsigned long id, pgd_t *pgd);
 
 #ifdef CONFIG_PPC_BOOK3S_64
+static inline void switch_mmu_context(struct mm_struct *prev,
+				      struct mm_struct *next,
+				      struct task_struct *tsk)
+{
+	return switch_slb(tsk, next);
+}
+
 extern int __init_new_context(void);
 extern void __destroy_context(int context_id);
 static inline void mmu_context_init(void) { }
 #else
+extern void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next,
+			       struct task_struct *tsk);
 extern unsigned long __init_new_context(void);
 extern void __destroy_context(unsigned long context_id);
 extern void mmu_context_init(void);
@@ -88,17 +95,11 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	if (cpu_has_feature(CPU_FTR_ALTIVEC))
 		asm volatile ("dssall");
 #endif /* CONFIG_ALTIVEC */
-
-	/* The actual HW switching method differs between the various
-	 * sub architectures.
+	/*
+	 * The actual HW switching method differs between the various
+	 * sub architectures. Out of line for now
 	 */
-#ifdef CONFIG_PPC_STD_MMU_64
-	switch_slb(tsk, next);
-#else
-	/* Out of line for now */
-	switch_mmu_context(prev, next);
-#endif
-
+	switch_mmu_context(prev, next, tsk);
 }
 
 #define deactivate_mm(tsk,mm)	do { } while (0)
diff --git a/arch/powerpc/kernel/swsusp.c b/arch/powerpc/kernel/swsusp.c
index 6669b1752512..6ae9bd5086a4 100644
--- a/arch/powerpc/kernel/swsusp.c
+++ b/arch/powerpc/kernel/swsusp.c
@@ -31,6 +31,6 @@ void save_processor_state(void)
 void restore_processor_state(void)
 {
 #ifdef CONFIG_PPC32
-	switch_mmu_context(current->active_mm, current->active_mm);
+	switch_mmu_context(current->active_mm, current->active_mm, NULL);
 #endif
 }
diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_context_nohash.c
index 986afbc22c76..a36c43a27893 100644
--- a/arch/powerpc/mm/mmu_context_nohash.c
+++ b/arch/powerpc/mm/mmu_context_nohash.c
@@ -226,7 +226,8 @@ static void context_check_map(void)
 static void context_check_map(void) { }
 #endif
 
-void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next)
+void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next,
+			struct task_struct *tsk)
 {
 	unsigned int i, id, cpu = smp_processor_id();
 	unsigned long *map;
diff --git a/drivers/cpufreq/pmac32-cpufreq.c b/drivers/cpufreq/pmac32-cpufreq.c
index 1f49d97a70ea..bde503c66945 100644
--- a/drivers/cpufreq/pmac32-cpufreq.c
+++ b/drivers/cpufreq/pmac32-cpufreq.c
@@ -298,7 +298,7 @@ static int pmu_set_cpu_speed(int low_speed)
  		_set_L3CR(save_l3cr);
 
 	/* Restore userland MMU context */
-	switch_mmu_context(NULL, current->active_mm);
+	switch_mmu_context(NULL, current->active_mm, NULL);
 
 #ifdef DEBUG_FREQ
 	printk(KERN_DEBUG "HID1, after: %x\n", mfspr(SPRN_HID1));
diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 01ee736fe0ef..f8b6d1403c16 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -1851,7 +1851,7 @@ static int powerbook_sleep_grackle(void)
  		_set_L2CR(save_l2cr);
 	
 	/* Restore userland MMU context */
-	switch_mmu_context(NULL, current->active_mm);
+	switch_mmu_context(NULL, current->active_mm, NULL);
 
 	/* Power things up */
 	pmu_unlock();
@@ -1940,7 +1940,7 @@ powerbook_sleep_Core99(void)
  		_set_L3CR(save_l3cr);
 	
 	/* Restore userland MMU context */
-	switch_mmu_context(NULL, current->active_mm);
+	switch_mmu_context(NULL, current->active_mm, NULL);
 
 	/* Tell PMU we are ready */
 	pmu_unlock();
-- 
2.5.0
