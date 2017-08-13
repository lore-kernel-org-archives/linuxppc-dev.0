Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xVLrM4HBlzDrCv
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Aug 2017 11:34:27 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id h75so6782911pfh.5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 18:34:27 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v2 5/9] powerpc/64s: Relax PACA address limitations
Date: Sun, 13 Aug 2017 11:33:42 +1000
Message-Id: <20170813013346.14002-5-npiggin@gmail.com>
In-Reply-To: <20170812113416.15978-1-npiggin@gmail.com>
References: <20170812113416.15978-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Book3S radix-mode has no SLB interrupt limitation, and hash-mode has
a 1T limitation on modern CPUs, so PACA allocation limits can be lifted.

Update the paca alloation limits. Share TLB/SLB calculation with the
stack allocation code.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/paca.c     | 13 +++++--------
 arch/powerpc/kernel/setup.h    |  4 ++++
 arch/powerpc/kernel/setup_64.c |  7 ++++---
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 8d63627e067f..64401f551765 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -18,6 +18,8 @@
 #include <asm/pgtable.h>
 #include <asm/kexec.h>
 
+#include "setup.h"
+
 #ifdef CONFIG_PPC_BOOK3S
 
 /*
@@ -199,16 +201,11 @@ void __init allocate_pacas(void)
 	u64 limit;
 	int cpu;
 
-	limit = ppc64_rma_size;
-
-#ifdef CONFIG_PPC_BOOK3S_64
 	/*
-	 * We can't take SLB misses on the paca, and we want to access them
-	 * in real mode, so allocate them within the RMA and also within
-	 * the first segment.
+	 * We access pacas in real mode, and cannot take faults on them when
+	 * in virtual mode, so allocate them accordingly.
 	 */
-	limit = min(0x10000000ULL, limit);
-#endif
+	limit = min(safe_kva_limit(), ppc64_rma_size);
 
 	paca_size = PAGE_ALIGN(sizeof(struct paca_struct) * nr_cpu_ids);
 
diff --git a/arch/powerpc/kernel/setup.h b/arch/powerpc/kernel/setup.h
index cfba134b3024..b97dfb50298c 100644
--- a/arch/powerpc/kernel/setup.h
+++ b/arch/powerpc/kernel/setup.h
@@ -45,6 +45,10 @@ void emergency_stack_init(void);
 static inline void emergency_stack_init(void) { };
 #endif
 
+#ifdef CONFIG_PPC64
+u64 safe_kva_limit(void);
+#endif
+
 /*
  * Having this in kvm_ppc.h makes include dependencies too
  * tricky to solve for setup-common.c so have it here.
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 7393bac3c7f4..35ad5f28f0c1 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -555,10 +555,11 @@ void __init initialize_cache_info(void)
  * used to allocate interrupt or emergency stacks for which our
  * exception entry path doesn't deal with being interrupted.
  */
-static __init u64 safe_stack_limit(void)
+__init u64 safe_kva_limit(void)
 {
 #ifdef CONFIG_PPC_BOOK3E
 	/* Freescale BookE bolts the entire linear mapping */
+	/* XXX: BookE ppc64_rma_limit setup seems to disagree? */
 	if (mmu_has_feature(MMU_FTR_TYPE_FSL_E))
 		return linear_map_top;
 	/* Other BookE, we assume the first GB is bolted */
@@ -576,7 +577,7 @@ static __init u64 safe_stack_limit(void)
 
 void __init irqstack_early_init(void)
 {
-	u64 limit = safe_stack_limit();
+	u64 limit = safe_kva_limit();
 	unsigned int i;
 
 	/*
@@ -661,7 +662,7 @@ void __init emergency_stack_init(void)
 	 * initialized in kernel/irq.c. These are initialized here in order
 	 * to have emergency stacks available as early as possible.
 	 */
-	limit = min(safe_stack_limit(), ppc64_rma_size);
+	limit = min(safe_kva_limit(), ppc64_rma_size);
 
 	for_each_possible_cpu(i) {
 		struct thread_info *ti;
-- 
2.13.3
