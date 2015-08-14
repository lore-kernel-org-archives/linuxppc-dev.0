Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 388681A1D94
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 16:02:21 +1000 (AEST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Fri, 14 Aug 2015 11:32:16 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 1E9331258018
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 11:35:28 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7E61oDw54329488
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 11:31:51 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7E61p5a018192
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 11:31:52 +0530
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: capi-linux@lists.linux.ibm.com, Daniel Axtens <dja@ozlabs.au.ibm.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Subject: [PATCH] cxl: Plug irq_bitmap getting leaked in cxl_context
Date: Fri, 14 Aug 2015 11:31:31 +0530
Message-Id: <1439532091-11734-1-git-send-email-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch plugs the leak of irq_bitmap, allocated as part of
initialization of cxl_context struct; during the call to
afu_allocate_irqs. The bitmap is now release during the call to function
afu_release_irqs.

Reported-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
 drivers/misc/cxl/irq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/cxl/irq.c b/drivers/misc/cxl/irq.c
index 680cd26..c8f1f9d 100644
--- a/drivers/misc/cxl/irq.c
+++ b/drivers/misc/cxl/irq.c
@@ -511,4 +511,8 @@ void afu_release_irqs(struct cxl_context *ctx, void *cookie)
 
 	afu_irq_name_free(ctx);
 	cxl_release_irq_ranges(&ctx->irqs, ctx->afu->adapter);
+
+	kfree(ctx->irq_bitmap);
+	ctx->irq_bitmap = NULL;
+	ctx->irq_count = 0;
 }
-- 
2.2.1
