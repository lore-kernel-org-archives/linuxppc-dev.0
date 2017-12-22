Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z35b06bSTzF0BG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2017 22:17:48 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id j124so15192717pfc.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2017 03:17:48 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 6/9] powerpc/64s: Relax PACA address limitations
Date: Fri, 22 Dec 2017 21:17:13 +1000
Message-Id: <20171222111716.13101-7-npiggin@gmail.com>
In-Reply-To: <20171222111716.13101-1-npiggin@gmail.com>
References: <20171222111716.13101-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Book3S PACA memory allocation is restricted by the RMA limit and also
must not take SLB faults when accessed in virtual mode. Currently a
fixed 256MB limit is used for this, which is imprecise and sub-optimal.

Update the paca allocation limits to use use the ppc64_rma_size for RMA
limit, and share the safe_stack_limit() that is currently used for stack
allocations that must not take virtual mode faults.

The safe_stack_limit() name is changed to ppc64_bolted_size() to match
ppc64_rma_size and some comments are updated, but code unchanged.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/paca.c     | 13 +++++++------
 arch/powerpc/kernel/setup.h    |  4 ++++
 arch/powerpc/kernel/setup_64.c | 22 ++++++++++++++--------
 3 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index d6597038931d..95ffedf14885 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -18,6 +18,8 @@
 #include <asm/pgtable.h>
 #include <asm/kexec.h>
 
+#include "setup.h"
+
 #ifdef CONFIG_PPC_BOOK3S
 
 /*
@@ -208,15 +210,14 @@ void __init allocate_pacas(void)
 	u64 limit;
 	int cpu;
 
-	limit = ppc64_rma_size;
-
 #ifdef CONFIG_PPC_BOOK3S_64
 	/*
-	 * We can't take SLB misses on the paca, and we want to access them
-	 * in real mode, so allocate them within the RMA and also within
-	 * the first segment.
+	 * We access pacas in real mode, and cannot take SLB faults
+	 * on them when in virtual mode, so allocate them accordingly.
 	 */
-	limit = min(0x10000000ULL, limit);
+	limit = min(ppc64_bolted_size(), ppc64_rma_size);
+#else
+	limit = ppc64_rma_size;
 #endif
 
 	paca_size = PAGE_ALIGN(sizeof(struct paca_struct) * nr_cpu_ids);
diff --git a/arch/powerpc/kernel/setup.h b/arch/powerpc/kernel/setup.h
index 21c18071d9d5..3fc11e30308f 100644
--- a/arch/powerpc/kernel/setup.h
+++ b/arch/powerpc/kernel/setup.h
@@ -51,6 +51,10 @@ void record_spr_defaults(void);
 static inline void record_spr_defaults(void) { };
 #endif
 
+#ifdef CONFIG_PPC64
+u64 ppc64_bolted_size(void);
+#endif
+
 /*
  * Having this in kvm_ppc.h makes include dependencies too
  * tricky to solve for setup-common.c so have it here.
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index d3124c302146..a2b731052084 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -565,24 +565,30 @@ void __init initialize_cache_info(void)
 	DBG(" <- initialize_cache_info()\n");
 }
 
-/* This returns the limit below which memory accesses to the linear
- * mapping are guarnateed not to cause a TLB or SLB miss. This is
- * used to allocate interrupt or emergency stacks for which our
- * exception entry path doesn't deal with being interrupted.
+/*
+ * This returns the limit below which memory accesses to the linear
+ * mapping are guarnateed not to cause an architectural exception (e.g.,
+ * TLB or SLB miss fault).
+ *
+ * This is used to allocate PACAs and various interrupt stacks that
+ * that are accessed early in interrupt handlers that must not cause
+ * re-entrant interrupts.
  */
-static __init u64 safe_stack_limit(void)
+__init u64 ppc64_bolted_size(void)
 {
 #ifdef CONFIG_PPC_BOOK3E
 	/* Freescale BookE bolts the entire linear mapping */
+	/* XXX: BookE ppc64_rma_limit setup seems to disagree? */
 	if (mmu_has_feature(MMU_FTR_TYPE_FSL_E))
 		return linear_map_top;
 	/* Other BookE, we assume the first GB is bolted */
 	return 1ul << 30;
 #else
+	/* BookS radix, does not take faults on linear mapping */
 	if (early_radix_enabled())
 		return ULONG_MAX;
 
-	/* BookS, the first segment is bolted */
+	/* BookS hash, the first segment is bolted */
 	if (mmu_has_feature(MMU_FTR_1T_SEGMENT))
 		return 1UL << SID_SHIFT_1T;
 	return 1UL << SID_SHIFT;
@@ -591,7 +597,7 @@ static __init u64 safe_stack_limit(void)
 
 void __init irqstack_early_init(void)
 {
-	u64 limit = safe_stack_limit();
+	u64 limit = ppc64_bolted_size();
 	unsigned int i;
 
 	/*
@@ -676,7 +682,7 @@ void __init emergency_stack_init(void)
 	 * initialized in kernel/irq.c. These are initialized here in order
 	 * to have emergency stacks available as early as possible.
 	 */
-	limit = min(safe_stack_limit(), ppc64_rma_size);
+	limit = min(ppc64_bolted_size(), ppc64_rma_size);
 
 	for_each_possible_cpu(i) {
 		struct thread_info *ti;
-- 
2.15.0
