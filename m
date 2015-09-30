Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AA7431A0629
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 11:59:06 +1000 (AEST)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 80B0114029C
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2015 11:59:06 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 30 Sep 2015 11:59:05 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id B37E72BB004D
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2015 11:59:03 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8U1wpKJ39256100
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2015 11:58:59 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8U1wVlf032180
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2015 11:58:31 +1000
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: imunsie@au1.ibm.com, mikey@neuling.org, vaibhav@linux.vnet.ibm.com,
 mrochs@linux.vnet.ibm.com
Subject: [PATCH 3/3] cxl: fix leak of ctx->mapping when releasing kernel API
 contexts
Date: Wed, 30 Sep 2015 11:58:07 +1000
Message-Id: <1443578287-7847-3-git-send-email-andrew.donnellan@au1.ibm.com>
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

When a context is created via the kernel API, ctx->mapping is allocated
within the kernel and thus needs to be freed when the context is freed.
reclaim_ctx() attempts to do this for contexts with the ctx->kernelapi flag
set, but afu_release() (which can be called from the kernel API through
cxl_fd_release()) sets ctx->mapping to NULL before calling
cxl_context_free() to free the context.

Add a check to afu_release() so that the mappings in contexts created via
the kernel API are left alone so reclaim_ctx() can free them.

Reported-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
Fixes: 6f7f0b3df6d4 ("cxl: Add AFU virtual PHB and kernel API")
Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
---
 drivers/misc/cxl/file.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
index a30bf28..fcda6b0 100644
--- a/drivers/misc/cxl/file.c
+++ b/drivers/misc/cxl/file.c
@@ -120,9 +120,16 @@ int afu_release(struct inode *inode, struct file *file)
 		 __func__, ctx->pe);
 	cxl_context_detach(ctx);
 
-	mutex_lock(&ctx->mapping_lock);
-	ctx->mapping = NULL;
-	mutex_unlock(&ctx->mapping_lock);
+
+	/* 
+	 * Delete the context's mapping pointer, unless it's created by the
+	 * kernel API, in which case leave it so it can be freed by reclaim_ctx()
+	 */
+	if (!ctx->kernelapi) {
+		mutex_lock(&ctx->mapping_lock);
+		ctx->mapping = NULL;
+		mutex_unlock(&ctx->mapping_lock);
+	}
 
 	put_device(&ctx->afu->dev);
 
-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
