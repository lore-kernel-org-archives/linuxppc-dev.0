Return-Path: <SRS0=wHv8=RQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FE7C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 04:32:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90F052177E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 04:32:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F052177E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44JzTP51gTzDq5v
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 15:32:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=au1.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=au1.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Jz746RR0zDqH1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 15:16:32 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2D4DV5R093860
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 00:16:30 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2r6pqh17h2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 00:16:30 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alastair@au1.ibm.com>;
 Wed, 13 Mar 2019 04:16:28 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 13 Mar 2019 04:16:25 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2D4GODX50594024
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 13 Mar 2019 04:16:24 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 70EF6A405B;
 Wed, 13 Mar 2019 04:16:24 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF6EEA4040;
 Wed, 13 Mar 2019 04:16:23 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 13 Mar 2019 04:16:23 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 48506A01B5;
 Wed, 13 Mar 2019 15:16:22 +1100 (AEDT)
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: 
Subject: [PATCH 7/7] ocxl: move event_fd handling to frontend
Date: Wed, 13 Mar 2019 15:15:22 +1100
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190313041524.14644-1-alastair@au1.ibm.com>
References: <20190313041524.14644-1-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19031304-0028-0000-0000-0000035354FA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031304-0029-0000-0000-00002411DB33
Message-Id: <20190313041524.14644-8-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-13_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903130029
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Alastair D'Silva <alastair@d-silva.org>,
 Frederic Barrat <fbarrat@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Alastair D'Silva <alastair@d-silva.org>

Event_fd is only used in the driver frontend, so it does not
need to exist in the backend code. Relocate it to the frontend
and provide an opaque mechanism for consumers instead.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/misc/ocxl/afu_irq.c       | 69 +++++++++++++++++--------------
 drivers/misc/ocxl/file.c          | 22 +++++++++-
 drivers/misc/ocxl/ocxl_internal.h |  5 ---
 include/misc/ocxl.h               | 44 ++++++++++++++++++++
 4 files changed, 102 insertions(+), 38 deletions(-)

diff --git a/drivers/misc/ocxl/afu_irq.c b/drivers/misc/ocxl/afu_irq.c
index 1885c472df58..bccb89085a29 100644
--- a/drivers/misc/ocxl/afu_irq.c
+++ b/drivers/misc/ocxl/afu_irq.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 // Copyright 2017 IBM Corp.
 #include <linux/interrupt.h>
-#include <linux/eventfd.h>
+#include <asm/pnv-ocxl.h>
 #include "ocxl_internal.h"
 #include "trace.h"
 
@@ -11,7 +11,9 @@ struct afu_irq {
 	unsigned int virq;
 	char *name;
 	u64 trigger_page;
-	struct eventfd_ctx *ev_ctx;
+	irqreturn_t (*handler)(void *private);
+	void (*free_private)(void *private);
+	void *private;
 };
 
 int ocxl_irq_offset_to_id(struct ocxl_context *ctx, u64 offset)
@@ -24,14 +26,42 @@ u64 ocxl_irq_id_to_offset(struct ocxl_context *ctx, int irq_id)
 	return ctx->afu->irq_base_offset + (irq_id << PAGE_SHIFT);
 }
 
+int ocxl_irq_set_handler(struct ocxl_context *ctx, int irq_id,
+		irqreturn_t (*handler)(void *private),
+		void (*free_private)(void *private),
+		void *private)
+{
+	struct afu_irq *irq;
+	int rc;
+
+	mutex_lock(&ctx->irq_lock);
+	irq = idr_find(&ctx->irq_idr, irq_id);
+	if (!irq) {
+		rc = -EINVAL;
+		goto unlock;
+	}
+
+	irq->handler = handler;
+	irq->private = private;
+
+	rc = 0;
+	goto unlock;
+
+unlock:
+	mutex_unlock(&ctx->irq_lock);
+	return rc;
+}
+
 static irqreturn_t afu_irq_handler(int virq, void *data)
 {
 	struct afu_irq *irq = (struct afu_irq *) data;
 
 	trace_ocxl_afu_irq_receive(virq);
-	if (irq->ev_ctx)
-		eventfd_signal(irq->ev_ctx, 1);
-	return IRQ_HANDLED;
+
+	if (irq->handler)
+		return irq->handler(irq->private);
+
+	return IRQ_HANDLED; // Just drop it on the ground
 }
 
 static int setup_afu_irq(struct ocxl_context *ctx, struct afu_irq *irq)
@@ -123,8 +153,8 @@ static void afu_irq_free(struct afu_irq *irq, struct ocxl_context *ctx)
 				ocxl_irq_id_to_offset(ctx, irq->id),
 				1 << PAGE_SHIFT, 1);
 	release_afu_irq(irq);
-	if (irq->ev_ctx)
-		eventfd_ctx_put(irq->ev_ctx);
+	if (irq->free_private)
+		irq->free_private(irq->private);
 	ocxl_link_free_irq(ctx->afu->fn->link, irq->hw_irq);
 	kfree(irq);
 }
@@ -157,31 +187,6 @@ void ocxl_afu_irq_free_all(struct ocxl_context *ctx)
 	mutex_unlock(&ctx->irq_lock);
 }
 
-int ocxl_afu_irq_set_fd(struct ocxl_context *ctx, int irq_id, int eventfd)
-{
-	struct afu_irq *irq;
-	struct eventfd_ctx *ev_ctx;
-	int rc = 0;
-
-	mutex_lock(&ctx->irq_lock);
-	irq = idr_find(&ctx->irq_idr, irq_id);
-	if (!irq) {
-		rc = -EINVAL;
-		goto unlock;
-	}
-
-	ev_ctx = eventfd_ctx_fdget(eventfd);
-	if (IS_ERR(ev_ctx)) {
-		rc = -EINVAL;
-		goto unlock;
-	}
-
-	irq->ev_ctx = ev_ctx;
-unlock:
-	mutex_unlock(&ctx->irq_lock);
-	return rc;
-}
-
 u64 ocxl_afu_irq_get_addr(struct ocxl_context *ctx, int irq_id)
 {
 	struct afu_irq *irq;
diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
index d28618c161de..16833a5d47f0 100644
--- a/drivers/misc/ocxl/file.c
+++ b/drivers/misc/ocxl/file.c
@@ -3,6 +3,7 @@
 #include <linux/fs.h>
 #include <linux/poll.h>
 #include <linux/sched/signal.h>
+#include <linux/eventfd.h>
 #include <linux/uaccess.h>
 #include <uapi/misc/ocxl.h>
 #include <asm/reg.h>
@@ -192,11 +193,27 @@ static long afu_ioctl_get_features(struct ocxl_context *ctx,
 			x == OCXL_IOCTL_GET_FEATURES ? "GET_FEATURES" :	\
 			"UNKNOWN")
 
+static irqreturn_t irq_handler(void *private)
+{
+	struct eventfd_ctx *ev_ctx = private;
+
+	eventfd_signal(ev_ctx, 1);
+	return IRQ_HANDLED;
+}
+
+static void irq_free(void *private)
+{
+	struct eventfd_ctx *ev_ctx = private;
+
+	eventfd_ctx_put(ev_ctx);
+}
+
 static long afu_ioctl(struct file *file, unsigned int cmd,
 		unsigned long args)
 {
 	struct ocxl_context *ctx = file->private_data;
 	struct ocxl_ioctl_irq_fd irq_fd;
+	struct eventfd_ctx *ev_ctx;
 	int irq_id;
 	u64 irq_offset;
 	long rc;
@@ -248,7 +265,10 @@ static long afu_ioctl(struct file *file, unsigned int cmd,
 		if (irq_fd.reserved)
 			return -EINVAL;
 		irq_id = ocxl_irq_offset_to_id(ctx, irq_fd.irq_offset);
-		rc = ocxl_afu_irq_set_fd(ctx, irq_id, irq_fd.eventfd);
+		ev_ctx = eventfd_ctx_fdget(irq_fd.eventfd);
+		if (!ev_ctx)
+			return -EFAULT;
+		rc = ocxl_irq_set_handler(ctx, irq_id, irq_handler, irq_free, ev_ctx);
 		break;
 
 	case OCXL_IOCTL_GET_METADATA:
diff --git a/drivers/misc/ocxl/ocxl_internal.h b/drivers/misc/ocxl/ocxl_internal.h
index 871155b464da..f3775223f4b1 100644
--- a/drivers/misc/ocxl/ocxl_internal.h
+++ b/drivers/misc/ocxl/ocxl_internal.h
@@ -142,12 +142,7 @@ void ocxl_sysfs_unregister_afu(struct ocxl_afu *afu);
 
 int ocxl_irq_offset_to_id(struct ocxl_context *ctx, u64 offset);
 u64 ocxl_irq_id_to_offset(struct ocxl_context *ctx, int irq_id);
-int ocxl_afu_irq_alloc(struct ocxl_context *ctx, int *irq_id);
-int ocxl_afu_irq_free(struct ocxl_context *ctx, int irq_id);
 void ocxl_afu_irq_free_all(struct ocxl_context *ctx);
-int ocxl_afu_irq_set_fd(struct ocxl_context *ctx, int irq_id,
-			int eventfd);
-u64 ocxl_afu_irq_get_addr(struct ocxl_context *ctx, int irq_id);
 
 /**
  * Free an AFU
diff --git a/include/misc/ocxl.h b/include/misc/ocxl.h
index 54f8bafa3caa..3099c858093c 100644
--- a/include/misc/ocxl.h
+++ b/include/misc/ocxl.h
@@ -169,6 +169,50 @@ int ocxl_context_detach(struct ocxl_context *ctx);
 
 // OpenCAPI MMIO accesses
 
+/**
+ * Allocate an IRQ associated with an AFU context
+ * @ctx: the AFU context
+ * @irq_id: out, the IRQ ID
+ *
+ * Returns 0 on success, negative on failure
+ */
+extern int ocxl_afu_irq_alloc(struct ocxl_context *ctx, int *irq_id);
+
+/**
+ * Frees an IRQ associated with an AFU context
+ * @ctx: the AFU context
+ * @irq_id: the IRQ ID
+ *
+ * Returns 0 on success, negative on failure
+ */
+extern int ocxl_afu_irq_free(struct ocxl_context *ctx, int irq_id);
+
+/**
+ * Gets the address of the trigger page for an IRQ
+ * This can then be provided to an AFU which will write to that
+ * page to trigger the IRQ.
+ * @ctx: The AFU context that the IRQ is associated with
+ * @irq_id: The IRQ ID
+ *
+ * returns the trigger page address, or 0 if the IRQ is not valid
+ */
+extern u64 ocxl_afu_irq_get_addr(struct ocxl_context *ctx, int irq_id);
+
+/**
+ * Provide a callback to be called when an IRQ is triggered
+ * @ctx: The AFU context that the IRQ is associated with
+ * @irq_id: The IRQ ID
+ * @handler: the callback to be called when the IRQ is triggered
+ * @free_private: the callback to be called when the IRQ is freed
+ * @private: Private data to be passed to the callbacks
+ *
+ * Returns 0 on success, negative on failure
+ */
+int ocxl_irq_set_handler(struct ocxl_context *ctx, int irq_id,
+		irqreturn_t (*handler)(void *private),
+		void (*free_private)(void *private),
+		void *private);
+
 /**
  * Read a 32 bit value from global MMIO
  *
-- 
2.20.1

