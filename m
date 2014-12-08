Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 95B1F1A0A36
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 19:19:46 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3EB331400A0
 for <linuxppc-dev@ozlabs.org>; Mon,  8 Dec 2014 19:19:46 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Mon, 8 Dec 2014 18:19:45 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: mpe <mpe@ellerman.id.au>
Subject: [PATCH 7/7] CXL: Unmap MMIO regions when detaching a context
Date: Mon,  8 Dec 2014 19:18:01 +1100
Message-Id: <1418026681-14787-7-git-send-email-imunsie@au.ibm.com>
In-Reply-To: <1418026681-14787-1-git-send-email-imunsie@au.ibm.com>
References: <1418026681-14787-1-git-send-email-imunsie@au.ibm.com>
Cc: cbe-oss-dev <cbe-oss-dev@lists.ozlabs.org>, mikey <mikey@neuling.org>,
 arnd <arnd@arndb.de>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 greg <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, anton <anton@samba.org>,
 imunsie <imunsie@au1.ibm.com>, jk <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

If we need to force detach a context (e.g. due to EEH or simply force
unbinding the driver) we should prevent the userspace contexts from
being able to access the Problem State Area MMIO region further, which
they may have mapped with mmap().

This patch unmaps any mapped MMIO regions when detaching a userspace
context.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/context.c | 11 ++++++++++-
 drivers/misc/cxl/cxl.h     |  7 ++++++-
 drivers/misc/cxl/file.c    |  6 +++++-
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
index 4aa31a3..51fd6b5 100644
--- a/drivers/misc/cxl/context.c
+++ b/drivers/misc/cxl/context.c
@@ -34,7 +34,8 @@ struct cxl_context *cxl_context_alloc(void)
 /*
  * Initialises a CXL context.
  */
-int cxl_context_init(struct cxl_context *ctx, struct cxl_afu *afu, bool master)
+int cxl_context_init(struct cxl_context *ctx, struct cxl_afu *afu, bool master,
+		     struct address_space *mapping)
 {
 	int i;
 
@@ -42,6 +43,8 @@ int cxl_context_init(struct cxl_context *ctx, struct cxl_afu *afu, bool master)
 	ctx->afu = afu;
 	ctx->master = master;
 	ctx->pid = NULL; /* Set in start work ioctl */
+	mutex_init(&ctx->mapping_lock);
+	ctx->mapping = mapping;
 
 	/*
 	 * Allocate the segment table before we put it in the IDR so that we
@@ -147,6 +150,12 @@ static void __detach_context(struct cxl_context *ctx)
 	afu_release_irqs(ctx);
 	flush_work(&ctx->fault_work); /* Only needed for dedicated process */
 	wake_up_all(&ctx->wq);
+
+	/* Release Problem State Area mapping */
+	mutex_lock(&ctx->mapping_lock);
+	if (ctx->mapping)
+		unmap_mapping_range(ctx->mapping, 0, 0, 1);
+	mutex_unlock(&ctx->mapping_lock);
 }
 
 /*
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index c1f8aa6..0df0438 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -405,6 +405,10 @@ struct cxl_context {
 	phys_addr_t psn_phys;
 	u64 psn_size;
 
+	/* Used to unmap any mmaps when force detaching */
+	struct address_space *mapping;
+	struct mutex mapping_lock;
+
 	spinlock_t sste_lock; /* Protects segment table entries */
 	struct cxl_sste *sstp;
 	u64 sstp0, sstp1;
@@ -606,7 +610,8 @@ int cxl_alloc_sst(struct cxl_context *ctx);
 void init_cxl_native(void);
 
 struct cxl_context *cxl_context_alloc(void);
-int cxl_context_init(struct cxl_context *ctx, struct cxl_afu *afu, bool master);
+int cxl_context_init(struct cxl_context *ctx, struct cxl_afu *afu, bool master,
+		     struct address_space *mapping);
 void cxl_context_free(struct cxl_context *ctx);
 int cxl_context_iomap(struct cxl_context *ctx, struct vm_area_struct *vma);
 
diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
index 2e067a5..b09be44 100644
--- a/drivers/misc/cxl/file.c
+++ b/drivers/misc/cxl/file.c
@@ -77,7 +77,7 @@ static int __afu_open(struct inode *inode, struct file *file, bool master)
 		goto err_put_afu;
 	}
 
-	if ((rc = cxl_context_init(ctx, afu, master)))
+	if ((rc = cxl_context_init(ctx, afu, master, inode->i_mapping)))
 		goto err_put_afu;
 
 	pr_devel("afu_open pe: %i\n", ctx->pe);
@@ -113,6 +113,10 @@ static int afu_release(struct inode *inode, struct file *file)
 		 __func__, ctx->pe);
 	cxl_context_detach(ctx);
 
+	mutex_lock(&ctx->mapping_lock);
+	ctx->mapping = NULL;
+	mutex_unlock(&ctx->mapping_lock);
+
 	put_device(&ctx->afu->dev);
 
 	/*
-- 
2.1.3
