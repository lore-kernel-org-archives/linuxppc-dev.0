Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 18EA91A0C6A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 19:51:54 +1000 (AEST)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A71BC1401EF
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2015 19:51:53 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 27 Aug 2015 19:51:51 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id B57EC2BB004D
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2015 19:51:48 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7R9pegU59441294
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2015 19:51:48 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7R9pFMk014297
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2015 19:51:16 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: mpe <mpe@ellerman.id.au>
Cc: mikey <mikey@neuling.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Matt Ochs <mrochs@us.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>
Subject: [PATCH 2/2] cxl: Fix force unmapping mmaps of contexts allocated
 through the kernel api
Date: Thu, 27 Aug 2015 19:50:19 +1000
Message-Id: <1440669019-23800-2-git-send-email-imunsie@au.ibm.com>
In-Reply-To: <1440669019-23800-1-git-send-email-imunsie@au.ibm.com>
References: <1440669019-23800-1-git-send-email-imunsie@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

The cxl user api uses the address_space associated with the file when we
need to force unmap all cxl mmap regions (e.g. on eeh, driver detach,
etc). Currently, contexts allocated through the kernel api do not do
this and instead skip the mmap invalidation, potentially allowing them
to poke at the hardware after such an event, which may cause all sorts
of trouble.

This patch allocates an address_space for cxl contexts allocated through
the kernel api so that the same invalidate path will for these contexts
as well. We don't use the anonymous inode's address_space, as doing so
could invalidate any mmaps of completely unrelated drivers using
anonymous file descriptors.

This patch also introduces a kernelapi flag, so we know when freeing the
context if the address_space was allocated by us and needs to be freed.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/api.c     | 33 ++++++++++++++++++++++++++++++---
 drivers/misc/cxl/context.c |  2 ++
 drivers/misc/cxl/cxl.h     |  1 +
 3 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index 005adc7..8af12c8 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -12,11 +12,13 @@
 #include <linux/anon_inodes.h>
 #include <linux/file.h>
 #include <misc/cxl.h>
+#include <linux/fs.h>
 
 #include "cxl.h"
 
 struct cxl_context *cxl_dev_context_init(struct pci_dev *dev)
 {
+	struct address_space *mapping;
 	struct cxl_afu *afu;
 	struct cxl_context  *ctx;
 	int rc;
@@ -30,14 +32,32 @@ struct cxl_context *cxl_dev_context_init(struct pci_dev *dev)
 		goto err_dev;
 	}
 
+	ctx->kernelapi = true;
+
+	/*
+	 * Make our own address space since we won't have one from the
+	 * filesystem like the user api has, and even if we do associate a file
+	 * with this context we don't want to use the global anonymous inode's
+	 * address space as that can invalidate unrelated users:
+	 */
+	mapping = kmalloc(sizeof(struct address_space), GFP_KERNEL);
+	if (!mapping) {
+		rc = -ENOMEM;
+		goto err_ctx;
+	}
+	address_space_init_once(mapping);
+
 	/* Make it a slave context.  We can promote it later? */
-	rc = cxl_context_init(ctx, afu, false, NULL);
+	rc = cxl_context_init(ctx, afu, false, mapping);
 	if (rc)
-		goto err_ctx;
+		goto err_mapping;
+
 	cxl_assign_psn_space(ctx);
 
 	return ctx;
 
+err_mapping:
+	kfree(mapping);
 err_ctx:
 	kfree(ctx);
 err_dev:
@@ -260,9 +280,16 @@ struct file *cxl_get_fd(struct cxl_context *ctx, struct file_operations *fops,
 
 	file = anon_inode_getfile("cxl", fops, ctx, flags);
 	if (IS_ERR(file))
-		put_unused_fd(fdtmp);
+		goto err_fd;
+
+	file->f_mapping = ctx->mapping;
+
 	*fd = fdtmp;
 	return file;
+
+err_fd:
+	put_unused_fd(fdtmp);
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(cxl_get_fd);
 
diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
index 941fda0..e762f85 100644
--- a/drivers/misc/cxl/context.c
+++ b/drivers/misc/cxl/context.c
@@ -272,6 +272,8 @@ static void reclaim_ctx(struct rcu_head *rcu)
 	if (ctx->ff_page)
 		__free_page(ctx->ff_page);
 	ctx->sstp = NULL;
+	if (ctx->kernelapi)
+		kfree(ctx->mapping);
 
 	kfree(ctx);
 }
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index e7af256..d6566c6 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -420,6 +420,7 @@ struct cxl_context {
 	struct mutex mapping_lock;
 	struct page *ff_page;
 	bool mmio_err_ff;
+	bool kernelapi;
 
 	spinlock_t sste_lock; /* Protects segment table entries */
 	struct cxl_sste *sstp;
-- 
2.1.4
