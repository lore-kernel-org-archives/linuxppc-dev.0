Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtcgs5RnWzDr1n
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 20:07:05 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5MA3r0G060845
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 06:07:03 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2b7ts87kwx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 06:07:02 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Thu, 22 Jun 2017 11:07:00 +0100
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 linuxppc-dev@lists.ozlabs.org
Cc: clombard@linux.vnet.ibm.com
Subject: [RFC v2 2/3] cxl: Mark context requiring global TLBIs
Date: Thu, 22 Jun 2017 12:06:48 +0200
In-Reply-To: <20170622100649.3846-1-fbarrat@linux.vnet.ibm.com>
References: <20170622100649.3846-1-fbarrat@linux.vnet.ibm.com>
Message-Id: <20170622100649.3846-3-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PSL needs to see all TLBIs pertinent to the memory contexts used
on the cxl adapter. For the hash memory model, it was done by making
all TLBIs global as soon as the cxl driver is in use. For radix, we
need something similar, but we can refine and only convert to global
the invalidations for contexts actually used by the device.

So mark the contexts being attached to the cxl adapter as requiring
global TLBIs.

Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
---
 drivers/misc/cxl/api.c  | 12 ++++++++++--
 drivers/misc/cxl/file.c | 12 ++++++++++--
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index 1a138c83f877..2cebe214195e 100644
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
+			smp_wmb();
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
diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
index 0761271d68c5..3ba6a60e0a6d 100644
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
+		smp_wmb();
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
