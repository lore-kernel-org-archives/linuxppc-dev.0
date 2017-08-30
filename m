Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xj1cQ1VD0zDqT0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 20:16:06 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7UAFQbI087831
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 06:16:04 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cnpaeb9cr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 06:16:03 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 30 Aug 2017 11:16:01 +0100
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, andrew.donnellan@au1.ibm.com,
 clombard@linux.vnet.ibm.com, vaibhav@linux.vnet.ibm.com
Cc: alistair@popple.id.au
Subject: [PATCH v2 3/3] cxl: Enable global TLBIs for cxl contexts
Date: Wed, 30 Aug 2017 12:15:50 +0200
In-Reply-To: <20170830101550.16821-1-fbarrat@linux.vnet.ibm.com>
References: <20170830101550.16821-1-fbarrat@linux.vnet.ibm.com>
Message-Id: <20170830101550.16821-3-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PSL and nMMU need to see all TLB invalidations for the memory
contexts used on the adapter. For the hash memory model, it is done by
making all TLBIs global as soon as the cxl driver is in use. For
radix, we need something similar, but we can refine and only convert
to global the invalidations for contexts actually used by the device.

So increment the 'active_cpus' count for the contexts attached to the
cxl adapter. As soon as there's more than 1 active cpu, the TLBIs for
the context become global. Active cpu count must be decremented when
detaching to restore locality if possible and to avoid overflowing the
counter.

Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
---
Changelog:
v2: Replace flush_tlb_mm() by the new flush_all_mm() to flush the TLBs
and PWCs (thanks to Ben)

 arch/powerpc/include/asm/mmu_context.h | 35 ++++++++++++++++++++++++++++++++++
 arch/powerpc/mm/mmu_context.c          |  9 ---------
 drivers/misc/cxl/api.c                 | 22 ++++++++++++++++++---
 drivers/misc/cxl/context.c             |  3 +++
 drivers/misc/cxl/file.c                | 19 ++++++++++++++++--
 5 files changed, 74 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 309592589e30..71a1d01ff206 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -77,6 +77,41 @@ extern void switch_cop(struct mm_struct *next);
 extern int use_cop(unsigned long acop, struct mm_struct *mm);
 extern void drop_cop(unsigned long acop, struct mm_struct *mm);
 
+#ifdef CONFIG_PPC_BOOK3S_64
+static inline void inc_mm_active_cpus(struct mm_struct *mm)
+{
+	atomic_inc(&mm->context.active_cpus);
+}
+
+static inline void dec_mm_active_cpus(struct mm_struct *mm)
+{
+	atomic_dec(&mm->context.active_cpus);
+}
+
+static inline void mm_context_add_copro(struct mm_struct *mm)
+{
+	inc_mm_active_cpus(mm);
+}
+
+static inline void mm_context_remove_copro(struct mm_struct *mm)
+{
+	/*
+	 * Need to broadcast a global flush of the full mm before
+	 * decrementing active_cpus count, as the next TLBI may be
+	 * local and the nMMU and/or PSL need to be cleaned up.
+	 * Should be rare enough so that it's acceptable.
+	 */
+	flush_all_mm(mm);
+	dec_mm_active_cpus(mm);
+}
+#else
+static inline void inc_mm_active_cpus(struct mm_struct *mm) { }
+static inline void dec_mm_active_cpus(struct mm_struct *mm) { }
+static inline void mm_context_add_copro(struct mm_struct *mm) { }
+static inline void mm_context_remove_copro(struct mm_struct *mm) { }
+#endif
+
+
 extern void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 			       struct task_struct *tsk);
 
diff --git a/arch/powerpc/mm/mmu_context.c b/arch/powerpc/mm/mmu_context.c
index 0f613bc63c50..d60a62bf4fc7 100644
--- a/arch/powerpc/mm/mmu_context.c
+++ b/arch/powerpc/mm/mmu_context.c
@@ -34,15 +34,6 @@ static inline void switch_mm_pgdir(struct task_struct *tsk,
 				   struct mm_struct *mm) { }
 #endif
 
-#ifdef CONFIG_PPC_BOOK3S_64
-static inline void inc_mm_active_cpus(struct mm_struct *mm)
-{
-	atomic_inc(&mm->context.active_cpus);
-}
-#else
-static inline void inc_mm_active_cpus(struct mm_struct *mm) { }
-#endif
-
 void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 			struct task_struct *tsk)
 {
diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index a0c44d16bf30..1137a2cc1d3e 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/mount.h>
 #include <linux/sched/mm.h>
+#include <linux/mmu_context.h>
 
 #include "cxl.h"
 
@@ -331,9 +332,12 @@ int cxl_start_context(struct cxl_context *ctx, u64 wed,
 		/* ensure this mm_struct can't be freed */
 		cxl_context_mm_count_get(ctx);
 
-		/* decrement the use count */
-		if (ctx->mm)
+		if (ctx->mm) {
+			/* decrement the use count from above */
 			mmput(ctx->mm);
+			/* make TLBIs for this context global */
+			mm_context_add_copro(ctx->mm);
+		}
 	}
 
 	/*
@@ -342,13 +346,25 @@ int cxl_start_context(struct cxl_context *ctx, u64 wed,
 	 */
 	cxl_ctx_get();
 
+	/*
+	 * Barrier is needed to make sure all TLBIs are global before
+	 * we attach and the context starts being used by the adapter.
+	 *
+	 * Needed after mm_context_add_copro() for radix and
+	 * cxl_ctx_get() for hash/p8
+	 */
+	smp_mb();
+
 	if ((rc = cxl_ops->attach_process(ctx, kernel, wed, 0))) {
 		put_pid(ctx->pid);
 		ctx->pid = NULL;
 		cxl_adapter_context_put(ctx->afu->adapter);
 		cxl_ctx_put();
-		if (task)
+		if (task) {
 			cxl_context_mm_count_put(ctx);
+			if (ctx->mm)
+				mm_context_remove_copro(ctx->mm);
+		}
 		goto out;
 	}
 
diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
index 8c32040b9c09..12a41b2753f0 100644
--- a/drivers/misc/cxl/context.c
+++ b/drivers/misc/cxl/context.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/idr.h>
 #include <linux/sched/mm.h>
+#include <linux/mmu_context.h>
 #include <asm/cputable.h>
 #include <asm/current.h>
 #include <asm/copro.h>
@@ -267,6 +268,8 @@ int __detach_context(struct cxl_context *ctx)
 
 	/* Decrease the mm count on the context */
 	cxl_context_mm_count_put(ctx);
+	if (ctx->mm)
+		mm_context_remove_copro(ctx->mm);
 	ctx->mm = NULL;
 
 	return 0;
diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
index 4bfad9f6dc9f..84b801b5d0e5 100644
--- a/drivers/misc/cxl/file.c
+++ b/drivers/misc/cxl/file.c
@@ -19,6 +19,7 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/sched/mm.h>
+#include <linux/mmu_context.h>
 #include <asm/cputable.h>
 #include <asm/current.h>
 #include <asm/copro.h>
@@ -220,9 +221,12 @@ static long afu_ioctl_start_work(struct cxl_context *ctx,
 	/* ensure this mm_struct can't be freed */
 	cxl_context_mm_count_get(ctx);
 
-	/* decrement the use count */
-	if (ctx->mm)
+	if (ctx->mm) {
+		/* decrement the use count from above */
 		mmput(ctx->mm);
+		/* make TLBIs for this context global */
+		mm_context_add_copro(ctx->mm);
+	}
 
 	/*
 	 * Increment driver use count. Enables global TLBIs for hash
@@ -230,6 +234,15 @@ static long afu_ioctl_start_work(struct cxl_context *ctx,
 	 */
 	cxl_ctx_get();
 
+	/*
+	 * Barrier is needed to make sure all TLBIs are global before
+	 * we attach and the context starts being used by the adapter.
+	 *
+	 * Needed after mm_context_add_copro() for radix and
+	 * cxl_ctx_get() for hash/p8
+	 */
+	smp_mb();
+
 	trace_cxl_attach(ctx, work.work_element_descriptor, work.num_interrupts, amr);
 
 	if ((rc = cxl_ops->attach_process(ctx, false, work.work_element_descriptor,
@@ -240,6 +253,8 @@ static long afu_ioctl_start_work(struct cxl_context *ctx,
 		ctx->pid = NULL;
 		cxl_ctx_put();
 		cxl_context_mm_count_put(ctx);
+		if (ctx->mm)
+			mm_context_remove_copro(ctx->mm);
 		goto out;
 	}
 
-- 
2.11.0
