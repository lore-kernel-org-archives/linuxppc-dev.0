Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BE61D1A0163
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 16:45:04 +1000 (AEST)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A18C9140D24
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Jul 2015 16:45:04 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 23 Jul 2015 16:45:04 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E997F2CE8050
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Jul 2015 16:45:00 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6N6isHV60096736
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Jul 2015 16:45:02 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6N6iSrN031166
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Jul 2015 16:44:28 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: mpe <mpe@ellerman.id.au>
Cc: mikey <mikey@neuling.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Matt Ochs <mrochs@us.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>
Subject: [PATCH] cxl: Add alternate MMIO error handling
Date: Thu, 23 Jul 2015 16:43:56 +1000
Message-Id: <1437633836-5051-1-git-send-email-imunsie@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

userspace programs using cxl currently have to use two strategies for
dealing with MMIO errors simultaneously. They have to check every read
for a return of all Fs in case the adapter has gone away and the kernel
has not yet noticed, and they have to deal with SIGBUS in case the
kernel has already noticed, invalidated the mapping and marked the
context as failed.

In order to simplify things, this patch adds an alternative approach
where the kernel will return a page filled with Fs instead of delivering
a SIGBUS. This allows userspace to only need to deal with one of these
two error paths, and is intended for use in libraries that use cxl
transparently and may not be able to safely install a signal handler.

This approach will only work if certain constraints are met. Namely, if
the application is both reading and writing to an address in the problem
state area it cannot assume that a non-FF read is OK, as it may just be
reading out a value it has previously written. Further - since only one
page is used per context a write to a given offset would be visible when
reading the same offset from a different page in the mapping (this only
applies within a single context, not between contexts).

An application could deal with this by e.g. making sure it also reads
from a read-only offset after any reads to a read/write offset.

Due to these constraints, this functionality must be explicitly
requested by userspace when starting the context by passing in the
CXL_START_WORK_ERR_FF flag.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/context.c | 14 ++++++++++++++
 drivers/misc/cxl/cxl.h     |  4 +++-
 drivers/misc/cxl/file.c    |  4 +++-
 include/uapi/misc/cxl.h    |  4 +++-
 4 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
index 1287148..6570f10 100644
--- a/drivers/misc/cxl/context.c
+++ b/drivers/misc/cxl/context.c
@@ -126,6 +126,18 @@ static int cxl_mmap_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
 	if (ctx->status != STARTED) {
 		mutex_unlock(&ctx->status_mutex);
 		pr_devel("%s: Context not started, failing problem state access\n", __func__);
+		if (ctx->mmio_err_ff) {
+			if (!ctx->ff_page) {
+				ctx->ff_page = alloc_page(GFP_USER);
+				if (!ctx->ff_page)
+					return VM_FAULT_OOM;
+				memset(page_address(ctx->ff_page), 0xff, PAGE_SIZE);
+			}
+			get_page(ctx->ff_page);
+			vmf->page = ctx->ff_page;
+			vma->vm_page_prot = pgprot_cached(vma->vm_page_prot);
+			return 0;
+		}
 		return VM_FAULT_SIGBUS;
 	}
 
@@ -253,6 +265,8 @@ static void reclaim_ctx(struct rcu_head *rcu)
 	struct cxl_context *ctx = container_of(rcu, struct cxl_context, rcu);
 
 	free_page((u64)ctx->sstp);
+	if (ctx->ff_page)
+		__free_page(ctx->ff_page);
 	ctx->sstp = NULL;
 
 	kfree(ctx);
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 4fd66ca..b7293a4 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -34,7 +34,7 @@ extern uint cxl_verbose;
  * Bump version each time a user API change is made, whether it is
  * backwards compatible ot not.
  */
-#define CXL_API_VERSION 1
+#define CXL_API_VERSION 2
 #define CXL_API_VERSION_COMPATIBLE 1
 
 /*
@@ -418,6 +418,8 @@ struct cxl_context {
 	/* Used to unmap any mmaps when force detaching */
 	struct address_space *mapping;
 	struct mutex mapping_lock;
+	struct page *ff_page;
+	bool mmio_err_ff;
 
 	spinlock_t sste_lock; /* Protects segment table entries */
 	struct cxl_sste *sstp;
diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
index e3f4b69..34c7a5e 100644
--- a/drivers/misc/cxl/file.c
+++ b/drivers/misc/cxl/file.c
@@ -179,6 +179,8 @@ static long afu_ioctl_start_work(struct cxl_context *ctx,
 	if (work.flags & CXL_START_WORK_AMR)
 		amr = work.amr & mfspr(SPRN_UAMOR);
 
+	ctx->mmio_err_ff = !!(work.flags & CXL_START_WORK_ERR_FF);
+
 	/*
 	 * We grab the PID here and not in the file open to allow for the case
 	 * where a process (master, some daemon, etc) has opened the chardev on
@@ -519,7 +521,7 @@ int __init cxl_file_init(void)
 	 * If these change we really need to update API.  Either change some
 	 * flags or update API version number CXL_API_VERSION.
 	 */
-	BUILD_BUG_ON(CXL_API_VERSION != 1);
+	BUILD_BUG_ON(CXL_API_VERSION != 2);
 	BUILD_BUG_ON(sizeof(struct cxl_ioctl_start_work) != 64);
 	BUILD_BUG_ON(sizeof(struct cxl_event_header) != 8);
 	BUILD_BUG_ON(sizeof(struct cxl_event_afu_interrupt) != 8);
diff --git a/include/uapi/misc/cxl.h b/include/uapi/misc/cxl.h
index 99a8ca1..1e889aa 100644
--- a/include/uapi/misc/cxl.h
+++ b/include/uapi/misc/cxl.h
@@ -29,8 +29,10 @@ struct cxl_ioctl_start_work {
 
 #define CXL_START_WORK_AMR		0x0000000000000001ULL
 #define CXL_START_WORK_NUM_IRQS		0x0000000000000002ULL
+#define CXL_START_WORK_ERR_FF		0x0000000000000004ULL
 #define CXL_START_WORK_ALL		(CXL_START_WORK_AMR |\
-					 CXL_START_WORK_NUM_IRQS)
+					 CXL_START_WORK_NUM_IRQS |\
+					 CXL_START_WORK_ERR_FF)
 
 
 /* Possible modes that an afu can be in */
-- 
2.1.4
