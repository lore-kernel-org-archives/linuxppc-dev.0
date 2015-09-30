Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA7BD1A05D7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 11:59:05 +1000 (AEST)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 69E44140778
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2015 11:59:05 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 30 Sep 2015 11:59:04 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 85F802BB0051
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2015 11:59:01 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8U1wnMw41025772
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2015 11:58:57 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8U1wSwS032120
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2015 11:58:29 +1000
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: imunsie@au1.ibm.com, mikey@neuling.org, vaibhav@linux.vnet.ibm.com,
 mrochs@linux.vnet.ibm.com
Subject: [PATCH 2/3] cxl: fix leak of ctx->irq_bitmap when releasing context
 via kernel API
Date: Wed, 30 Sep 2015 11:58:06 +1000
Message-Id: <1443578287-7847-2-git-send-email-andrew.donnellan@au1.ibm.com>
In-Reply-To: <1443578287-7847-1-git-send-email-andrew.donnellan@au1.ibm.com>
References: <1443578287-7847-1-git-send-email-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At present, ctx->irq_bitmap is freed in afu_release_irqs(), which is called
from afu_release() via cxl_context_detach().

Move the freeing of ctx->irq_bitmap from afu_release_irqs() to
reclaim_ctx() (called through cxl_context_free()) so it's freed when
releasing a context via the kernel API (cxl_release_context()) or the
userspace API (afu_release()).

Reported-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
Fixes: 6f7f0b3df6d4 ("cxl: Add AFU virtual PHB and kernel API")
Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
---
 drivers/misc/cxl/context.c | 3 +++
 drivers/misc/cxl/irq.c     | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
index e762f85..2faa127 100644
--- a/drivers/misc/cxl/context.c
+++ b/drivers/misc/cxl/context.c
@@ -275,6 +275,9 @@ static void reclaim_ctx(struct rcu_head *rcu)
 	if (ctx->kernelapi)
 		kfree(ctx->mapping);
 
+	if (ctx->irq_bitmap)
+		kfree(ctx->irq_bitmap);
+
 	kfree(ctx);
 }
 
diff --git a/drivers/misc/cxl/irq.c b/drivers/misc/cxl/irq.c
index 38b57d6..09a4060 100644
--- a/drivers/misc/cxl/irq.c
+++ b/drivers/misc/cxl/irq.c
@@ -524,7 +524,5 @@ void afu_release_irqs(struct cxl_context *ctx, void *cookie)
 	afu_irq_name_free(ctx);
 	cxl_release_irq_ranges(&ctx->irqs, ctx->afu->adapter);
 
-	kfree(ctx->irq_bitmap);
-	ctx->irq_bitmap = NULL;
 	ctx->irq_count = 0;
 }
-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
