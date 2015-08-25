Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4EEE51A0EF6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2015 15:35:17 +1000 (AEST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Tue, 25 Aug 2015 11:05:14 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id DE5AC394005B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2015 11:05:10 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7P5YvKL20250806
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2015 11:05:00 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7P5YubB003940
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2015 11:04:57 +0530
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: imunsie@au1.ibm.com, Michael Neuling <mikey@neuling.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Subject: [PATCH] cxl: Release irqs if memory allocation fails
Date: Tue, 25 Aug 2015 11:04:48 +0530
Message-Id: <1440480888-7885-1-git-send-email-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This minor patch plugs a potential irq leak in case of a memory
allocation failure inside function the afu_allocate_irqs. Presently the
irqs allocated to the context gets leaked if allocation of either
one of context irq_bitmap or irq_names fails.

Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
 drivers/misc/cxl/irq.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cxl/irq.c b/drivers/misc/cxl/irq.c
index c8f1f9d..e8b887e 100644
--- a/drivers/misc/cxl/irq.c
+++ b/drivers/misc/cxl/irq.c
@@ -421,6 +421,9 @@ int afu_allocate_irqs(struct cxl_context *ctx, u32 count)
 	int rc, r, i, j = 1;
 	struct cxl_irq_name *irq_name;
 
+	/* Initialize the list head to hold irq names */
+	INIT_LIST_HEAD(&ctx->irq_names);
+
 	if ((rc = cxl_alloc_irq_ranges(&ctx->irqs, ctx->afu->adapter, count)))
 		return rc;
 
@@ -432,13 +435,12 @@ int afu_allocate_irqs(struct cxl_context *ctx, u32 count)
 	ctx->irq_bitmap = kcalloc(BITS_TO_LONGS(count),
 				  sizeof(*ctx->irq_bitmap), GFP_KERNEL);
 	if (!ctx->irq_bitmap)
-		return -ENOMEM;
+		goto out;
 
 	/*
 	 * Allocate names first.  If any fail, bail out before allocating
 	 * actual hardware IRQs.
 	 */
-	INIT_LIST_HEAD(&ctx->irq_names);
 	for (r = 1; r < CXL_IRQ_RANGES; r++) {
 		for (i = 0; i < ctx->irqs.range[r]; i++) {
 			irq_name = kmalloc(sizeof(struct cxl_irq_name),
@@ -460,6 +462,7 @@ int afu_allocate_irqs(struct cxl_context *ctx, u32 count)
 	return 0;
 
 out:
+	cxl_release_irq_ranges(&ctx->irqs, ctx->afu->adapter);
 	afu_irq_name_free(ctx);
 	return -ENOMEM;
 }
-- 
2.2.1
