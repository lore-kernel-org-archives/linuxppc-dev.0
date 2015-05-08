Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8AF011A00E9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2015 22:56:34 +1000 (AEST)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5F01D1401AB
 for <linuxppc-dev@ozlabs.org>; Fri,  8 May 2015 22:56:34 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Fri, 8 May 2015 22:56:33 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 91D042CE804E
 for <linuxppc-dev@ozlabs.org>; Fri,  8 May 2015 22:56:29 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t48CuLtL15728724
 for <linuxppc-dev@ozlabs.org>; Fri, 8 May 2015 22:56:29 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t48CtuuY009677
 for <linuxppc-dev@ozlabs.org>; Fri, 8 May 2015 22:55:57 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: mpe <mpe@ellerman.id.au>
Subject: [PATCH] cxl: Use call_rcu to reduce latency when releasing the afu fd
Date: Fri,  8 May 2015 22:55:18 +1000
Message-Id: <1431089718-25169-1-git-send-email-imunsie@au.ibm.com>
Cc: mikey <mikey@neuling.org>, Brian Allison <ballis@us.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Ian Munsie <imunsie@au1.ibm.com>,
 Fei K Chen <uchen@cn.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

The afu fd release path was identified as a significant bottleneck in
the overall performance of cxl. While an optimal AFU design would
minimise the need to close & reopen the AFU fd, it is not always
practical to avoid.

The bottleneck seems to be down to the call to synchronize_rcu(), which
will block until every other thread is guaranteed to be out of an RCU
critical section. Replace it with call_rcu() to free the context
structures later so we can return to the application sooner.

This reduces the time spent in the fd release path from 13356 usec to
13.3 usec - about a 100x speed up.

Reported-by: Fei K Chen <uchen@cn.ibm.com>
Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/context.c | 15 ++++++++++-----
 drivers/misc/cxl/cxl.h     |  2 ++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
index 22eb338..cea299e 100644
--- a/drivers/misc/cxl/context.c
+++ b/drivers/misc/cxl/context.c
@@ -243,12 +243,9 @@ void cxl_context_detach_all(struct cxl_afu *afu)
 	mutex_unlock(&afu->contexts_lock);
 }
 
-void cxl_context_free(struct cxl_context *ctx)
+static void reclaim_ctx(struct rcu_head *rcu)
 {
-	mutex_lock(&ctx->afu->contexts_lock);
-	idr_remove(&ctx->afu->contexts_idr, ctx->pe);
-	mutex_unlock(&ctx->afu->contexts_lock);
-	synchronize_rcu();
+	struct cxl_context *ctx = container_of(rcu, struct cxl_context, rcu);
 
 	free_page((u64)ctx->sstp);
 	ctx->sstp = NULL;
@@ -256,3 +253,11 @@ void cxl_context_free(struct cxl_context *ctx)
 	put_pid(ctx->pid);
 	kfree(ctx);
 }
+
+void cxl_context_free(struct cxl_context *ctx)
+{
+	mutex_lock(&ctx->afu->contexts_lock);
+	idr_remove(&ctx->afu->contexts_idr, ctx->pe);
+	mutex_unlock(&ctx->afu->contexts_lock);
+	call_rcu(&ctx->rcu, reclaim_ctx);
+}
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 47f655f..ebd2e0d 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -460,6 +460,8 @@ struct cxl_context {
 	bool pending_irq;
 	bool pending_fault;
 	bool pending_afu_err;
+
+	struct rcu_head rcu;
 };
 
 struct cxl {
-- 
2.1.4
