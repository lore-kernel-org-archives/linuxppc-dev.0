Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1BA261A1807
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2015 10:23:26 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org
Cc: imunsie@au.ibm.com, linuxppc-dev@ozlabs.org, mikey@neuling.org,
 Daniel Axtens <dja@axtens.net>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, brking@linux.vnet.ibm.com
Subject: [PATCH v2 17/21] cxl: Rework context lifetimes
Date: Tue, 26 May 2015 10:20:14 +1000
Message-Id: <1432599618-26844-18-git-send-email-mikey@neuling.org>
In-Reply-To: <1432599618-26844-1-git-send-email-mikey@neuling.org>
References: <1432599618-26844-1-git-send-email-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This reworks contexts lifetimes a bit to enable the kernel API where we may
want to reuse contexts. Here we will want to start and stop contexts without
freeing them.

Start context does the get pid & ctx so stop context will need to do the puts.
Here we move put pid & ctx to the detach context path which will become part of
the stop context path.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Acked-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/context.c | 5 +++--
 drivers/misc/cxl/file.c    | 1 -
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
index 7d857b7..2a4c80a 100644
--- a/drivers/misc/cxl/context.c
+++ b/drivers/misc/cxl/context.c
@@ -186,6 +186,9 @@ int __detach_context(struct cxl_context *ctx)
 		return -EBUSY;
 
 	WARN_ON(cxl_detach_process(ctx));
+	flush_work(&ctx->fault_work); /* Only needed for dedicated process */
+	put_pid(ctx->pid);
+	cxl_ctx_put();
 	return 0;
 }
 
@@ -204,7 +207,6 @@ void cxl_context_detach(struct cxl_context *ctx)
 		return;
 
 	afu_release_irqs(ctx, ctx);
-	flush_work(&ctx->fault_work); /* Only needed for dedicated process */
 	wake_up_all(&ctx->wq);
 }
 
@@ -245,7 +247,6 @@ static void reclaim_ctx(struct rcu_head *rcu)
 	free_page((u64)ctx->sstp);
 	ctx->sstp = NULL;
 
-	put_pid(ctx->pid);
 	kfree(ctx);
 }
 
diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
index 5377c8b..f7653fc 100644
--- a/drivers/misc/cxl/file.c
+++ b/drivers/misc/cxl/file.c
@@ -128,7 +128,6 @@ static int afu_release(struct inode *inode, struct file *file)
 	 */
 	cxl_context_free(ctx);
 
-	cxl_ctx_put();
 	return 0;
 }
 
-- 
2.1.0
