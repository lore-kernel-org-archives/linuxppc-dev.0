Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfsLw2p8gzDqxS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 04:55:35 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5TIsFld036981
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 14:55:34 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23uuhu3uxu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 14:55:33 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 30 Jun 2016 04:55:31 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id ADAFF2CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 04:55:28 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5TItSKB4522364
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 04:55:28 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5TItS6l032088
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 04:55:28 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, mikey <mikey@neuling.org>,
 linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Huy Nguyen <huyn@mellanox.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Subject: [PATCH] cxl: Fix NULL pointer dereference on kernel contexts with no
 AFU interrupts
Date: Thu, 30 Jun 2016 04:55:17 +1000
Message-Id: <1467226517-29098-1-git-send-email-imunsie@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

If a kernel context is initialised and does not have any AFU interrupts
allocated it will cause a NULL pointer dereference when the context is
detached since the irq_names list will not have been initialised.

Move the initialisation of the irq_names list into the cxl_context_init
routine so that it will be valid for the entire lifetime of the context
and will not cause a NULL pointer dereference.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/context.c | 2 ++
 drivers/misc/cxl/irq.c     | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
index 26d206b..edbb99e 100644
--- a/drivers/misc/cxl/context.c
+++ b/drivers/misc/cxl/context.c
@@ -67,6 +67,8 @@ int cxl_context_init(struct cxl_context *ctx, struct cxl_afu *afu, bool master,
 	ctx->pending_fault = false;
 	ctx->pending_afu_err = false;
 
+	INIT_LIST_HEAD(&ctx->irq_names);
+
 	/*
 	 * When we have to destroy all contexts in cxl_context_detach_all() we
 	 * end up with afu_release_irqs() called from inside a
diff --git a/drivers/misc/cxl/irq.c b/drivers/misc/cxl/irq.c
index 8def455..f3a7d4a 100644
--- a/drivers/misc/cxl/irq.c
+++ b/drivers/misc/cxl/irq.c
@@ -260,9 +260,6 @@ int afu_allocate_irqs(struct cxl_context *ctx, u32 count)
 	else
 		alloc_count = count + 1;
 
-	/* Initialize the list head to hold irq names */
-	INIT_LIST_HEAD(&ctx->irq_names);
-
 	if ((rc = cxl_ops->alloc_irq_ranges(&ctx->irqs, ctx->afu->adapter,
 							alloc_count)))
 		return rc;
-- 
2.8.1
