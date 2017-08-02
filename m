Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xN4YP5276zDr5g
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 06:29:45 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v72KT0s5018736
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 16:29:43 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c3g4j9hp9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Aug 2017 16:29:43 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 2 Aug 2017 21:29:41 +0100
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 linuxppc-dev@lists.ozlabs.org
Cc: clombard@linux.vnet.ibm.com, alistair@popple.id.au,
 vaibhav@linux.vnet.ibm.com
Subject: [PATCH v3 2/3] cxl: Mark context requiring global TLBIs
Date: Wed,  2 Aug 2017 22:29:29 +0200
In-Reply-To: <20170802202930.5616-1-fbarrat@linux.vnet.ibm.com>
References: <20170802202930.5616-1-fbarrat@linux.vnet.ibm.com>
Message-Id: <20170802202930.5616-3-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PSL and XSL need to see all TLBIs pertinent to the memory contexts
used on the adapter. For the hash memory model, it is done by making
all TLBIs global as soon as the cxl driver is in use. For radix, we
need something similar, but we can refine and only convert to global
the invalidations for contexts actually used by the device.

So mark the contexts being attached to the cxl adapter as requiring
global TLBIs.

Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
---
 drivers/misc/cxl/api.c    | 12 ++++++++++--
 drivers/misc/cxl/cxllib.c |  7 +++++++
 drivers/misc/cxl/file.c   | 12 ++++++++++--
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index 1a138c83f877..d3f3fdede755 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -332,8 +332,17 @@ int cxl_start_context(struct cxl_context *ctx, u64 wed,
 		cxl_context_mm_count_get(ctx);
 
 		/* decrement the use count */
-		if (ctx->mm)
+		if (ctx->mm) {
 			mmput(ctx->mm);
+#ifdef CONFIG_PPC_BOOK3S_64
+			mm_context_set_global_tlbi(&ctx->mm->context);
+			/*
+			 * Barrier guarantees that the device will
+			 * receive all TLBIs from that point on
+			 */
+			wmb();
+#endif
+		}
 	}
 
 	cxl_ctx_get();
@@ -347,7 +356,6 @@ int cxl_start_context(struct cxl_context *ctx, u64 wed,
 			cxl_context_mm_count_put(ctx);
 		goto out;
 	}
-
 	ctx->status = STARTED;
 out:
 	mutex_unlock(&ctx->status_mutex);
diff --git a/drivers/misc/cxl/cxllib.c b/drivers/misc/cxl/cxllib.c
index 5dba23ca2e5f..00b8125752d9 100644
--- a/drivers/misc/cxl/cxllib.c
+++ b/drivers/misc/cxl/cxllib.c
@@ -198,6 +198,13 @@ int cxllib_get_PE_attributes(struct task_struct *task,
 		 * as XSL uses the memory context
 		 */
 		attr->pid = mm->context.id;
+#ifdef CONFIG_PPC_BOOK3S_64
+		mm_context_set_global_tlbi(&mm->context);
+		/*
+		 * barrier guarantees that XSL receives all invalidations
+		 */
+		wmb();
+#endif
 		mmput(mm);
 	} else {
 		attr->pid = 0;
diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
index 0761271d68c5..efdf9483275c 100644
--- a/drivers/misc/cxl/file.c
+++ b/drivers/misc/cxl/file.c
@@ -222,8 +222,17 @@ static long afu_ioctl_start_work(struct cxl_context *ctx,
 	cxl_context_mm_count_get(ctx);
 
 	/* decrement the use count */
-	if (ctx->mm)
+	if (ctx->mm) {
 		mmput(ctx->mm);
+#ifdef CONFIG_PPC_BOOK3S_64
+		mm_context_set_global_tlbi(&ctx->mm->context);
+		/*
+		 * Barrier guarantees that the device will receive all
+		 * TLBIs from that point on
+		 */
+		wmb();
+#endif
+	}
 
 	trace_cxl_attach(ctx, work.work_element_descriptor, work.num_interrupts, amr);
 
@@ -236,7 +245,6 @@ static long afu_ioctl_start_work(struct cxl_context *ctx,
 		cxl_context_mm_count_put(ctx);
 		goto out;
 	}
-
 	ctx->status = STARTED;
 	rc = 0;
 out:
-- 
2.11.0
