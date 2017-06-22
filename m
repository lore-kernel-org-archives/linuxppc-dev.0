Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtcgq32WBzDr24
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 20:07:03 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5MA3muO035310
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 06:07:00 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2b87sh4ygu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 06:07:00 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Thu, 22 Jun 2017 11:06:59 +0100
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 linuxppc-dev@lists.ozlabs.org
Cc: clombard@linux.vnet.ibm.com
Subject: [RFC v2 1/3] powerpc/mm: Add marker for contexts requiring global TLB
 invalidations
Date: Thu, 22 Jun 2017 12:06:47 +0200
In-Reply-To: <20170622100649.3846-1-fbarrat@linux.vnet.ibm.com>
References: <20170622100649.3846-1-fbarrat@linux.vnet.ibm.com>
Message-Id: <20170622100649.3846-2-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Introduce a new 'flags' attribute per context and define its first bit
to be a marker requiring all TLBIs for that context to be broadcasted
globally. Once that marker is set on a context, it cannot be removed.

Such a marker is useful for memory contexts used by devices behind the
NPU and CAPP/PSL. The NPU and the PSL keep their own translation cache
so they need to see all the TLBIs for those contexts.

Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/mmu.h | 18 ++++++++++++++++++
 arch/powerpc/include/asm/tlb.h           | 23 +++++++++++++++++++++--
 arch/powerpc/mm/mmu_context_book3s64.c   |  1 +
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 77529a3e3811..cd83f8eb6a3f 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -78,8 +78,12 @@ struct spinlock;
 /* Maximum possible number of NPUs in a system. */
 #define NV_MAX_NPUS 8
 
+/* Bits definition for the context flags */
+#define MM_GLOBAL_TLBIE	0	/* TLBI must be global */
+
 typedef struct {
 	mm_context_id_t id;
+	unsigned long flags;
 	u16 user_psize;		/* page size index */
 
 	/* NPU NMMU context */
@@ -164,5 +168,19 @@ extern void radix_init_pseries(void);
 static inline void radix_init_pseries(void) { };
 #endif
 
+/*
+ * Mark the memory context as requiring global TLBIs, when used by
+ * GPUs or CAPI accelerators managing their own TLB or ERAT.
+*/
+static inline void mm_context_set_global_tlbi(mm_context_t *ctx)
+{
+	set_bit(MM_GLOBAL_TLBIE, &ctx->flags);
+}
+
+static inline bool mm_context_get_global_tlbi(mm_context_t *ctx)
+{
+	return test_bit(MM_GLOBAL_TLBIE, &ctx->flags);
+}
+
 #endif /* __ASSEMBLY__ */
 #endif /* _ASM_POWERPC_BOOK3S_64_MMU_H_ */
diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
index 609557569f65..87d4ddcbf7f8 100644
--- a/arch/powerpc/include/asm/tlb.h
+++ b/arch/powerpc/include/asm/tlb.h
@@ -71,8 +71,27 @@ static inline int mm_is_core_local(struct mm_struct *mm)
 
 static inline int mm_is_thread_local(struct mm_struct *mm)
 {
-	return cpumask_equal(mm_cpumask(mm),
-			      cpumask_of(smp_processor_id()));
+	int rc;
+
+	rc = cpumask_equal(mm_cpumask(mm),
+			cpumask_of(smp_processor_id()));
+#ifdef CONFIG_PPC_BOOK3S_64
+	if (rc) {
+		/*
+		 * Check if context requires global TLBI.
+		 *
+		 * We need to make sure the PTE update is happening
+		 * before reading the context global flag. Otherwise,
+		 * reading the flag may be re-ordered and happen
+		 * first, and we could end up in a situation where the
+		 * old PTE was seen by a device, but the TLBI is not
+		 * global.
+		 */
+		smp_mb();
+		rc = !mm_context_get_global_tlbi(&mm->context);
+	}
+#endif
+	return rc;
 }
 
 #else
diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index a3edf813d455..c32a3f729d81 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -156,6 +156,7 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 		return index;
 
 	mm->context.id = index;
+	mm->context.flags = 0;
 #ifdef CONFIG_PPC_ICSWX
 	mm->context.cop_lockp = kmalloc(sizeof(spinlock_t), GFP_KERNEL);
 	if (!mm->context.cop_lockp) {
-- 
2.11.0
