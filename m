Return-Path: <SRS0=wHv8=RQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A6EC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 04:30:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9B262177E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 04:30:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B262177E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44JzRR0sd3zDqLC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 15:30:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=au1.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=au1.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Jz721vFszDqJM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 15:16:30 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2D4DXvi042021
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 00:16:28 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2r6pnm1dw5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 00:16:28 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alastair@au1.ibm.com>;
 Wed, 13 Mar 2019 04:16:25 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 13 Mar 2019 04:16:24 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2D4GNUe58261708
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Mar 2019 04:16:23 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F34FA405C;
 Wed, 13 Mar 2019 04:16:23 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 30024A405B;
 Wed, 13 Mar 2019 04:16:22 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 13 Mar 2019 04:16:22 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id ACC1EA024A;
 Wed, 13 Mar 2019 15:16:20 +1100 (AEDT)
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: 
Subject: [PATCH 6/7] ocxl: afu_irq only deals with IRQ IDs, not offsets
Date: Wed, 13 Mar 2019 15:15:21 +1100
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190313041524.14644-1-alastair@au1.ibm.com>
References: <20190313041524.14644-1-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19031304-4275-0000-0000-0000031A489E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031304-4276-0000-0000-00003828B571
Message-Id: <20190313041524.14644-7-alastair@au1.ibm.com>
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

The use of offsets is required only in the frontend, so alter
the IRQ API to only work with IRQ IDs in the backend.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/misc/ocxl/afu_irq.c       | 31 +++++++++++++------------------
 drivers/misc/ocxl/context.c       |  7 +++++--
 drivers/misc/ocxl/file.c          | 13 ++++++++-----
 drivers/misc/ocxl/ocxl_internal.h | 10 ++++++----
 drivers/misc/ocxl/trace.h         | 12 ++++--------
 5 files changed, 36 insertions(+), 37 deletions(-)

diff --git a/drivers/misc/ocxl/afu_irq.c b/drivers/misc/ocxl/afu_irq.c
index 11ab996657a2..1885c472df58 100644
--- a/drivers/misc/ocxl/afu_irq.c
+++ b/drivers/misc/ocxl/afu_irq.c
@@ -14,14 +14,14 @@ struct afu_irq {
 	struct eventfd_ctx *ev_ctx;
 };
 
-static int irq_offset_to_id(struct ocxl_context *ctx, u64 offset)
+int ocxl_irq_offset_to_id(struct ocxl_context *ctx, u64 offset)
 {
 	return (offset - ctx->afu->irq_base_offset) >> PAGE_SHIFT;
 }
 
-static u64 irq_id_to_offset(struct ocxl_context *ctx, int id)
+u64 ocxl_irq_id_to_offset(struct ocxl_context *ctx, int irq_id)
 {
-	return ctx->afu->irq_base_offset + (id << PAGE_SHIFT);
+	return ctx->afu->irq_base_offset + (irq_id << PAGE_SHIFT);
 }
 
 static irqreturn_t afu_irq_handler(int virq, void *data)
@@ -69,7 +69,7 @@ static void release_afu_irq(struct afu_irq *irq)
 	kfree(irq->name);
 }
 
-int ocxl_afu_irq_alloc(struct ocxl_context *ctx, u64 *irq_offset)
+int ocxl_afu_irq_alloc(struct ocxl_context *ctx, int *irq_id)
 {
 	struct afu_irq *irq;
 	int rc;
@@ -101,10 +101,7 @@ int ocxl_afu_irq_alloc(struct ocxl_context *ctx, u64 *irq_offset)
 	if (rc)
 		goto err_alloc;
 
-	*irq_offset = irq_id_to_offset(ctx, irq->id);
-
-	trace_ocxl_afu_irq_alloc(ctx->pasid, irq->id, irq->virq, irq->hw_irq,
-				*irq_offset);
+	trace_ocxl_afu_irq_alloc(ctx->pasid, irq->id, irq->virq, irq->hw_irq);
 	mutex_unlock(&ctx->irq_lock);
 	return 0;
 
@@ -123,7 +120,7 @@ static void afu_irq_free(struct afu_irq *irq, struct ocxl_context *ctx)
 	trace_ocxl_afu_irq_free(ctx->pasid, irq->id);
 	if (ctx->mapping)
 		unmap_mapping_range(ctx->mapping,
-				irq_id_to_offset(ctx, irq->id),
+				ocxl_irq_id_to_offset(ctx, irq->id),
 				1 << PAGE_SHIFT, 1);
 	release_afu_irq(irq);
 	if (irq->ev_ctx)
@@ -132,14 +129,13 @@ static void afu_irq_free(struct afu_irq *irq, struct ocxl_context *ctx)
 	kfree(irq);
 }
 
-int ocxl_afu_irq_free(struct ocxl_context *ctx, u64 irq_offset)
+int ocxl_afu_irq_free(struct ocxl_context *ctx, int irq_id)
 {
 	struct afu_irq *irq;
-	int id = irq_offset_to_id(ctx, irq_offset);
 
 	mutex_lock(&ctx->irq_lock);
 
-	irq = idr_find(&ctx->irq_idr, id);
+	irq = idr_find(&ctx->irq_idr, irq_id);
 	if (!irq) {
 		mutex_unlock(&ctx->irq_lock);
 		return -EINVAL;
@@ -161,14 +157,14 @@ void ocxl_afu_irq_free_all(struct ocxl_context *ctx)
 	mutex_unlock(&ctx->irq_lock);
 }
 
-int ocxl_afu_irq_set_fd(struct ocxl_context *ctx, u64 irq_offset, int eventfd)
+int ocxl_afu_irq_set_fd(struct ocxl_context *ctx, int irq_id, int eventfd)
 {
 	struct afu_irq *irq;
 	struct eventfd_ctx *ev_ctx;
-	int rc = 0, id = irq_offset_to_id(ctx, irq_offset);
+	int rc = 0;
 
 	mutex_lock(&ctx->irq_lock);
-	irq = idr_find(&ctx->irq_idr, id);
+	irq = idr_find(&ctx->irq_idr, irq_id);
 	if (!irq) {
 		rc = -EINVAL;
 		goto unlock;
@@ -186,14 +182,13 @@ int ocxl_afu_irq_set_fd(struct ocxl_context *ctx, u64 irq_offset, int eventfd)
 	return rc;
 }
 
-u64 ocxl_afu_irq_get_addr(struct ocxl_context *ctx, u64 irq_offset)
+u64 ocxl_afu_irq_get_addr(struct ocxl_context *ctx, int irq_id)
 {
 	struct afu_irq *irq;
-	int id = irq_offset_to_id(ctx, irq_offset);
 	u64 addr = 0;
 
 	mutex_lock(&ctx->irq_lock);
-	irq = idr_find(&ctx->irq_idr, id);
+	irq = idr_find(&ctx->irq_idr, irq_id);
 	if (irq)
 		addr = irq->trigger_page;
 	mutex_unlock(&ctx->irq_lock);
diff --git a/drivers/misc/ocxl/context.c b/drivers/misc/ocxl/context.c
index 9a37e9632cd9..c04887591837 100644
--- a/drivers/misc/ocxl/context.c
+++ b/drivers/misc/ocxl/context.c
@@ -93,8 +93,9 @@ static vm_fault_t map_afu_irq(struct vm_area_struct *vma, unsigned long address,
 		u64 offset, struct ocxl_context *ctx)
 {
 	u64 trigger_addr;
+	int irq_id = ocxl_irq_offset_to_id(ctx, offset);
 
-	trigger_addr = ocxl_afu_irq_get_addr(ctx, offset);
+	trigger_addr = ocxl_afu_irq_get_addr(ctx, irq_id);
 	if (!trigger_addr)
 		return VM_FAULT_SIGBUS;
 
@@ -154,12 +155,14 @@ static const struct vm_operations_struct ocxl_vmops = {
 static int check_mmap_afu_irq(struct ocxl_context *ctx,
 			struct vm_area_struct *vma)
 {
+	int irq_id = ocxl_irq_offset_to_id(ctx, vma->vm_pgoff << PAGE_SHIFT);
+
 	/* only one page */
 	if (vma_pages(vma) != 1)
 		return -EINVAL;
 
 	/* check offset validty */
-	if (!ocxl_afu_irq_get_addr(ctx, vma->vm_pgoff << PAGE_SHIFT))
+	if (!ocxl_afu_irq_get_addr(ctx, irq_id))
 		return -EINVAL;
 
 	/*
diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
index 424bb0b40afb..d28618c161de 100644
--- a/drivers/misc/ocxl/file.c
+++ b/drivers/misc/ocxl/file.c
@@ -197,6 +197,7 @@ static long afu_ioctl(struct file *file, unsigned int cmd,
 {
 	struct ocxl_context *ctx = file->private_data;
 	struct ocxl_ioctl_irq_fd irq_fd;
+	int irq_id;
 	u64 irq_offset;
 	long rc;
 	bool closed;
@@ -218,12 +219,13 @@ static long afu_ioctl(struct file *file, unsigned int cmd,
 		break;
 
 	case OCXL_IOCTL_IRQ_ALLOC:
-		rc = ocxl_afu_irq_alloc(ctx, &irq_offset);
+		rc = ocxl_afu_irq_alloc(ctx, &irq_id);
 		if (!rc) {
+			irq_offset = ocxl_irq_id_to_offset(ctx, irq_id);
 			rc = copy_to_user((u64 __user *) args, &irq_offset,
 					sizeof(irq_offset));
 			if (rc) {
-				ocxl_afu_irq_free(ctx, irq_offset);
+				ocxl_afu_irq_free(ctx, irq_id);
 				return -EFAULT;
 			}
 		}
@@ -234,7 +236,8 @@ static long afu_ioctl(struct file *file, unsigned int cmd,
 				sizeof(irq_offset));
 		if (rc)
 			return -EFAULT;
-		rc = ocxl_afu_irq_free(ctx, irq_offset);
+		irq_id = ocxl_irq_offset_to_id(ctx, irq_offset);
+		rc = ocxl_afu_irq_free(ctx, irq_id);
 		break;
 
 	case OCXL_IOCTL_IRQ_SET_FD:
@@ -244,8 +247,8 @@ static long afu_ioctl(struct file *file, unsigned int cmd,
 			return -EFAULT;
 		if (irq_fd.reserved)
 			return -EINVAL;
-		rc = ocxl_afu_irq_set_fd(ctx, irq_fd.irq_offset,
-					irq_fd.eventfd);
+		irq_id = ocxl_irq_offset_to_id(ctx, irq_fd.irq_offset);
+		rc = ocxl_afu_irq_set_fd(ctx, irq_id, irq_fd.eventfd);
 		break;
 
 	case OCXL_IOCTL_GET_METADATA:
diff --git a/drivers/misc/ocxl/ocxl_internal.h b/drivers/misc/ocxl/ocxl_internal.h
index 4fc7e9597ede..871155b464da 100644
--- a/drivers/misc/ocxl/ocxl_internal.h
+++ b/drivers/misc/ocxl/ocxl_internal.h
@@ -140,12 +140,14 @@ void ocxl_context_detach_all(struct ocxl_afu *afu);
 int ocxl_sysfs_register_afu(struct ocxl_afu *afu);
 void ocxl_sysfs_unregister_afu(struct ocxl_afu *afu);
 
-int ocxl_afu_irq_alloc(struct ocxl_context *ctx, u64 *irq_offset);
-int ocxl_afu_irq_free(struct ocxl_context *ctx, u64 irq_offset);
+int ocxl_irq_offset_to_id(struct ocxl_context *ctx, u64 offset);
+u64 ocxl_irq_id_to_offset(struct ocxl_context *ctx, int irq_id);
+int ocxl_afu_irq_alloc(struct ocxl_context *ctx, int *irq_id);
+int ocxl_afu_irq_free(struct ocxl_context *ctx, int irq_id);
 void ocxl_afu_irq_free_all(struct ocxl_context *ctx);
-int ocxl_afu_irq_set_fd(struct ocxl_context *ctx, u64 irq_offset,
+int ocxl_afu_irq_set_fd(struct ocxl_context *ctx, int irq_id,
 			int eventfd);
-u64 ocxl_afu_irq_get_addr(struct ocxl_context *ctx, u64 irq_offset);
+u64 ocxl_afu_irq_get_addr(struct ocxl_context *ctx, int irq_id);
 
 /**
  * Free an AFU
diff --git a/drivers/misc/ocxl/trace.h b/drivers/misc/ocxl/trace.h
index 68bf2f173a1a..a081e644f5f3 100644
--- a/drivers/misc/ocxl/trace.h
+++ b/drivers/misc/ocxl/trace.h
@@ -107,16 +107,14 @@ DEFINE_EVENT(ocxl_fault_handler, ocxl_fault_ack,
 );
 
 TRACE_EVENT(ocxl_afu_irq_alloc,
-	TP_PROTO(int pasid, int irq_id, unsigned int virq, int hw_irq,
-		u64 irq_offset),
-	TP_ARGS(pasid, irq_id, virq, hw_irq, irq_offset),
+	TP_PROTO(int pasid, int irq_id, unsigned int virq, int hw_irq),
+	TP_ARGS(pasid, irq_id, virq, hw_irq),
 
 	TP_STRUCT__entry(
 		__field(int, pasid)
 		__field(int, irq_id)
 		__field(unsigned int, virq)
 		__field(int, hw_irq)
-		__field(u64, irq_offset)
 	),
 
 	TP_fast_assign(
@@ -124,15 +122,13 @@ TRACE_EVENT(ocxl_afu_irq_alloc,
 		__entry->irq_id = irq_id;
 		__entry->virq = virq;
 		__entry->hw_irq = hw_irq;
-		__entry->irq_offset = irq_offset;
 	),
 
-	TP_printk("pasid=%#x irq_id=%d virq=%u hw_irq=%d irq_offset=%#llx",
+	TP_printk("pasid=%#x irq_id=%d virq=%u hw_irq=%d",
 		__entry->pasid,
 		__entry->irq_id,
 		__entry->virq,
-		__entry->hw_irq,
-		__entry->irq_offset
+		__entry->hw_irq
 	)
 );
 
-- 
2.20.1

