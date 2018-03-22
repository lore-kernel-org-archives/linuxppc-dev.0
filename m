Return-Path: <bsingharora@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406hDT44MwzF1yd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 09:29:28 +1100 (AEDT)
Received: by mail-pl0-x243.google.com with SMTP id f5-v6so6223950plj.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 15:29:28 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, npiggin@gmail.com,
 aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH 1/2] powerpc/mm: Add tracking of the number of coprocessors
 using a context
Date: Fri, 23 Mar 2018 09:29:05 +1100
Message-Id: <20180322222906.22084-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Currently, when using coprocessors (which use the Nest MMU), we
simply increment the active_cpu count to force all TLB invalidations
to be come broadcast.

Unfortunately, due to an errata in POWER9, we will need to know
more specifically that coprocessors are in use.

This maintains a separate copros counter in the MMU context for
that purpose.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Tested-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/include/asm/book3s/64/mmu.h |  3 +++
 arch/powerpc/include/asm/mmu_context.h   | 18 +++++++++++++-----
 arch/powerpc/mm/mmu_context_book3s64.c   |  1 +
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index bef6e39ed63a..729902e733cd 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -87,6 +87,9 @@ typedef struct {
 	/* Number of bits in the mm_cpumask */
 	atomic_t active_cpus;
 
+	/* Number of users of the external (Nest) MMU */
+	atomic_t copros;
+
 	/* NPU NMMU context */
 	struct npu_context *npu_context;
 
diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 051b3d63afe3..3a15b6db9501 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -92,15 +92,23 @@ static inline void dec_mm_active_cpus(struct mm_struct *mm)
 static inline void mm_context_add_copro(struct mm_struct *mm)
 {
 	/*
-	 * On hash, should only be called once over the lifetime of
-	 * the context, as we can't decrement the active cpus count
-	 * and flush properly for the time being.
+	 * If any copro is in use, increment the active CPU count
+	 * in order to force TLB invalidations to be global as to
+	 * propagate to the Nest MMU.
 	 */
-	inc_mm_active_cpus(mm);
+	if (atomic_inc_return(&mm->context.copros) == 1)
+		inc_mm_active_cpus(mm);
 }
 
 static inline void mm_context_remove_copro(struct mm_struct *mm)
 {
+	int c;
+
+	c = atomic_dec_if_positive(&mm->context.copros);
+
+	/* Detect imbalance between add and remove */
+	WARN_ON(c < 0);
+
 	/*
 	 * Need to broadcast a global flush of the full mm before
 	 * decrementing active_cpus count, as the next TLBI may be
@@ -111,7 +119,7 @@ static inline void mm_context_remove_copro(struct mm_struct *mm)
 	 * for the time being. Invalidations will remain global if
 	 * used on hash.
 	 */
-	if (radix_enabled()) {
+	if (c == 0 && radix_enabled()) {
 		flush_all_mm(mm);
 		dec_mm_active_cpus(mm);
 	}
diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index 929d9ef7083f..3f980baade4c 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -173,6 +173,7 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 	mm_iommu_init(mm);
 #endif
 	atomic_set(&mm->context.active_cpus, 0);
+	atomic_set(&mm->context.copros, 0);
 
 	return 0;
 }
-- 
2.13.6
