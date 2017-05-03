Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJ0sZ1Y7vzDqBH
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 00:29:22 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v43ETCRU146256
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 May 2017 10:29:18 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a7ecfrarb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 May 2017 10:29:17 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 3 May 2017 15:29:15 +0100
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: alistair@popple.id.au, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: [RFC 1/2] powerpc/mm: Add marker for contexts requiring global TLB
 invalidations
Date: Wed,  3 May 2017 16:29:05 +0200
In-Reply-To: <20170503142906.29220-1-fbarrat@linux.vnet.ibm.com>
References: <20170503142906.29220-1-fbarrat@linux.vnet.ibm.com>
Message-Id: <20170503142906.29220-2-fbarrat@linux.vnet.ibm.com>
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
NPU and CAPP/PSL. The NPU and the PSL keep their own
translation cache so they need to see all the TLBIs for those
contexts.

Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/mmu.h |  9 +++++++++
 arch/powerpc/include/asm/tlb.h           | 10 ++++++++--
 arch/powerpc/mm/mmu_context_book3s64.c   |  1 +
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 77529a3e3811..7b640ab1cbeb 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -78,8 +78,12 @@ struct spinlock;
 /* Maximum possible number of NPUs in a system. */
 #define NV_MAX_NPUS 8
 
+/* Bits definition for the context flags */
+#define MM_CONTEXT_GLOBAL_TLBI	1	/* TLBI must be global */
+
 typedef struct {
 	mm_context_id_t id;
+	unsigned long flags;
 	u16 user_psize;		/* page size index */
 
 	/* NPU NMMU context */
@@ -164,5 +168,10 @@ extern void radix_init_pseries(void);
 static inline void radix_init_pseries(void) { };
 #endif
 
+static inline void mm_context_set_global_tlbi(mm_context_t *ctx)
+{
+	set_bit(MM_CONTEXT_GLOBAL_TLBI, &ctx->flags);
+}
+
 #endif /* __ASSEMBLY__ */
 #endif /* _ASM_POWERPC_BOOK3S_64_MMU_H_ */
diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
index 609557569f65..bd18ed083011 100644
--- a/arch/powerpc/include/asm/tlb.h
+++ b/arch/powerpc/include/asm/tlb.h
@@ -71,8 +71,14 @@ static inline int mm_is_core_local(struct mm_struct *mm)
 
 static inline int mm_is_thread_local(struct mm_struct *mm)
 {
-	return cpumask_equal(mm_cpumask(mm),
-			      cpumask_of(smp_processor_id()));
+	int rc;
+
+	rc = cpumask_equal(mm_cpumask(mm),
+			cpumask_of(smp_processor_id()));
+#ifdef CONFIG_PPC_BOOK3S_64
+	rc = rc && !test_bit(MM_CONTEXT_GLOBAL_TLBI, &mm->context.flags);
+#endif
+	return rc;
 }
 
 #else
diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index c6dca2ae78ef..53983a0c220c 100644
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
