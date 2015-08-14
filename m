Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1D9221A2C1C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 16:59:38 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Fri, 14 Aug 2015 16:59:36 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id A140D3578056
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 16:59:32 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7E6xPup48431352
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 16:59:33 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7E6wxAZ032740
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 16:59:00 +1000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 imunsie@au1.ibm.com, Michael Ellerman <mpe@ellerman.id.au>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Subject: [PATCH][RESEND] cxl:Plug irq_bitmap getting leaked in cxl_context
Date: Fri, 14 Aug 2015 12:28:38 +0530
Message-Id: <1439535518-19192-1-git-send-email-vaibhav@linux.vnet.ibm.com>
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
