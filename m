Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xgdkH4g86zDqNc
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 14:16:23 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7S4Daxf043650
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 00:16:21 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cm2rphdu4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 00:16:20 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Mon, 28 Aug 2017 14:16:18 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7S4GFIL42336418
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 14:16:15 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7S4GFEc020554
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 14:16:16 +1000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 "Alastair D'Silva" <alastair@au1.ibm.com>
Subject: [RFC] cxl: Enable use of custom PE-id for contexts
Date: Mon, 28 Aug 2017 09:45:55 +0530
Message-Id: <20170828041555.3342-1-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some AFUs differentiate between multiple PE's based on their
PE-ids. Unfortunately presently cxl provides no way for external
users (libcxl/kernel-api) to control the id assigned to a specific
PE. The ids are currently assigned serially to PE's and are dolled out
using an idr table.

With this patch external users of the cxl api can request a specific
__u16 peid to be used when issuing CXL_IOCTL_START_WORK or calling
cxl_start_context(). Struct cxl_ioctl_start_work has a new member named
use_pe that can be used to provide the PE-id to be used. Also a new
CXL_START_WORK flag named CXL_START_WORK_CUSTOM_PE has been introduced
to indicated to cxl to try to switch the PE-id of the context to the
value provided in use_pe before attaching the context to the AFU.

The switching of context PE-id is done by inserting the
same context with the requested PE-id from struct cxl_ioctl_start_work
and removing the previously allocated PE-id from the afu->contexts_idr
table. In case an existing context with the requested PE-id already
exists the first step above will fail causing the context attach to
abort and an error is returned back to caller.

Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
 drivers/misc/cxl/api.c     |  7 ++++++
 drivers/misc/cxl/context.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/misc/cxl/cxl.h     |  3 +++
 drivers/misc/cxl/file.c    | 12 ++++++++--
 include/uapi/misc/cxl.h    |  9 ++++----
 5 files changed, 80 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index 1a138c83f877..3c34f486a0ce 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -505,6 +505,13 @@ int cxl_start_work(struct cxl_context *ctx,
 {
 	int rc;
 
+	/* If requesting a custom PE id ? */
+	if (work->flags & CXL_START_WORK_CUSTOM_PE) {
+		rc = cxl_context_switch_pe(ctx, work->use_pe);
+		if (rc)
+			return rc;
+	}
+
 	/* code taken from afu_ioctl_start_work */
 	if (!(work->flags & CXL_START_WORK_NUM_IRQS))
 		work->num_interrupts = ctx->afu->pp_irqs;
diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
index 8c32040b9c09..3699891a84be 100644
--- a/drivers/misc/cxl/context.c
+++ b/drivers/misc/cxl/context.c
@@ -117,6 +117,61 @@ int cxl_context_init(struct cxl_context *ctx, struct cxl_afu *afu, bool master)
 	return 0;
 }
 
+/*
+ * Switch the PE# if context ctx to newpe
+ */
+int cxl_context_switch_pe(struct cxl_context *ctx, __u16 newpe)
+{
+	int rc, oldpe = 0;
+
+	pr_debug("Switching PE#%u to PE#%u\n", ctx->pe, newpe);
+	/* Assigning custom PE only supported on bare-metal right now */
+	if (!cpu_has_feature(CPU_FTR_HVMODE)) {
+		pr_err("Assigning custom PE# only supported on bare metal\n");
+		return -EINVAL;
+	}
+
+	/* Silently ignore if newpe == ctx->pe */
+	if (newpe ==  ctx->pe)
+		return 0;
+
+	/* Bunch of sanity validations */
+	if (newpe < ctx->afu->adapter->min_pe ||
+	    newpe >= (ctx->afu->adapter->min_pe + ctx->afu->num_procs)) {
+		pr_debug("Cant assign out of range PE#%u\n", newpe);
+		return -EINVAL;
+	}
+
+	if (ctx->pe_inserted) {
+		pr_debug("Cant switch PE for attached PE#%u\n", ctx->pe);
+		return -EINVAL;
+	}
+
+	/* serialize access to the idr table */
+	mutex_lock(&ctx->afu->contexts_lock);
+	idr_preload(GFP_KERNEL);
+	rc = idr_alloc(&ctx->afu->contexts_idr, ctx, newpe, newpe + 1,
+		       GFP_NOWAIT);
+	/* if successful allocation then remove the existing idr entry */
+	if (rc >= 0) {
+		idr_remove(&ctx->afu->contexts_idr, ctx->pe);
+		oldpe = ctx->pe;
+		ctx->pe = newpe;
+		ctx->external_pe = ctx->pe;
+		ctx->elem = &ctx->afu->native->spa[newpe];
+	}
+	idr_preload_end();
+	mutex_unlock(&ctx->afu->contexts_lock);
+
+	if (rc >= 0)
+		pr_debug("Switched PE#%u -> PE%u\n", oldpe, ctx->pe);
+	else
+		pr_debug("Unable to switch PE#%u->PE%u. Error=%d\n",
+			 oldpe, ctx->pe, rc);
+
+	return rc >= 0 ? 0 : rc;
+}
+
 void cxl_context_set_mapping(struct cxl_context *ctx,
 			struct address_space *mapping)
 {
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index b1afeccbb97f..6d7c0accb30e 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -1171,4 +1171,7 @@ void cxl_context_mm_count_get(struct cxl_context *ctx);
 /* Decrements the reference count to "struct mm_struct" */
 void cxl_context_mm_count_put(struct cxl_context *ctx);
 
+/* Switch the PE# of given context ctx to newpe */
+int cxl_context_switch_pe(struct cxl_context *ctx, __u16 newpe);
+
 #endif
diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
index 0761271d68c5..7ae7020aa062 100644
--- a/drivers/misc/cxl/file.c
+++ b/drivers/misc/cxl/file.c
@@ -173,12 +173,20 @@ static long afu_ioctl_start_work(struct cxl_context *ctx,
 	 * flags are set it's invalid
 	 */
 	if (work.reserved1 || work.reserved2 || work.reserved3 ||
-	    work.reserved4 || work.reserved5 || work.reserved6 ||
-	    (work.flags & ~CXL_START_WORK_ALL)) {
+	    work.reserved4 || work.reserved5 ||
+	    ((work.flags & ~CXL_START_WORK_ALL) &&
+	     !(work.flags & CXL_START_WORK_CUSTOM_PE))) {
 		rc = -EINVAL;
 		goto out;
 	}
 
+	/* If requesting a custom PE id ? */
+	if (work.flags & CXL_START_WORK_CUSTOM_PE) {
+		rc = cxl_context_switch_pe(ctx, work.use_pe);
+		if (rc)
+			goto out;
+	}
+
 	if (!(work.flags & CXL_START_WORK_NUM_IRQS))
 		work.num_interrupts = ctx->afu->pp_irqs;
 	else if ((work.num_interrupts < ctx->afu->pp_irqs) ||
diff --git a/include/uapi/misc/cxl.h b/include/uapi/misc/cxl.h
index 180d526a55c3..0d585dc46369 100644
--- a/include/uapi/misc/cxl.h
+++ b/include/uapi/misc/cxl.h
@@ -19,18 +19,19 @@ struct cxl_ioctl_start_work {
 	__u64 work_element_descriptor;
 	__u64 amr;
 	__s16 num_interrupts;
-	__s16 reserved1;
-	__s32 reserved2;
+	__u16 use_pe;
+	__s32 reserved1;
+	__u64 reserved2;
 	__u64 reserved3;
 	__u64 reserved4;
 	__u64 reserved5;
-	__u64 reserved6;
 };
 
 #define CXL_START_WORK_AMR		0x0000000000000001ULL
 #define CXL_START_WORK_NUM_IRQS		0x0000000000000002ULL
 #define CXL_START_WORK_ERR_FF		0x0000000000000004ULL
-#define CXL_START_WORK_ALL		(CXL_START_WORK_AMR |\
+#define CXL_START_WORK_CUSTOM_PE	0x0000000000000008ULL
+#define CXL_START_WORK_ALL		(CXL_START_WORK_AMR |		\
 					 CXL_START_WORK_NUM_IRQS |\
 					 CXL_START_WORK_ERR_FF)
 
-- 
2.13.5
