Return-Path: <SRS0=tR2X=R4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F8FC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 05:54:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 274C220879
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 05:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 274C220879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44SNk23Rk2zDqLt
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 16:54:02 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44SNWt2mJhzDqLW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 16:45:13 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2P5ipOh119628
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 01:45:12 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rer1ptca4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 01:45:11 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alastair@au1.ibm.com>;
 Mon, 25 Mar 2019 05:45:10 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 25 Mar 2019 05:45:07 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2P5j6nA45744312
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Mar 2019 05:45:06 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1FF1542047;
 Mon, 25 Mar 2019 05:45:06 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C2E84203F;
 Mon, 25 Mar 2019 05:45:05 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 25 Mar 2019 05:45:05 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 6E887A02C3;
 Mon, 25 Mar 2019 16:45:04 +1100 (AEDT)
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: alastair@d-silva.org
Subject: [PATCH v3 4/7] ocxl: Allow external drivers to use OpenCAPI contexts
Date: Mon, 25 Mar 2019 16:44:33 +1100
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190325054438.15022-1-alastair@au1.ibm.com>
References: <20190320053448.2098-1-alastair@au1.ibm.com>
 <20190325054438.15022-1-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19032505-4275-0000-0000-0000031ED3F2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032505-4276-0000-0000-0000382D6445
Message-Id: <20190325054438.15022-5-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-25_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=669 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903250044
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Greg Kurz <groug@kaod.org>,
 linux-kernel@vger.kernel.org, Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Alastair D'Silva <alastair@d-silva.org>

Most OpenCAPI operations require a valid context, so
exposing these functions to external drivers is necessary.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 drivers/misc/ocxl/context.c       |  9 +++++--
 drivers/misc/ocxl/file.c          |  2 +-
 drivers/misc/ocxl/ocxl_internal.h |  6 -----
 include/misc/ocxl.h               | 45 +++++++++++++++++++++++++++++++
 4 files changed, 53 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/ocxl/context.c b/drivers/misc/ocxl/context.c
index c73a859d2224..8b97b0f19db8 100644
--- a/drivers/misc/ocxl/context.c
+++ b/drivers/misc/ocxl/context.c
@@ -8,6 +8,7 @@ struct ocxl_context *ocxl_context_alloc(void)
 {
 	return kzalloc(sizeof(struct ocxl_context), GFP_KERNEL);
 }
+EXPORT_SYMBOL_GPL(ocxl_context_alloc);
 
 int ocxl_context_init(struct ocxl_context *ctx, struct ocxl_afu *afu,
 		struct address_space *mapping)
@@ -43,6 +44,7 @@ int ocxl_context_init(struct ocxl_context *ctx, struct ocxl_afu *afu,
 	ocxl_afu_get(afu);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ocxl_context_init);
 
 /*
  * Callback for when a translation fault triggers an error
@@ -63,7 +65,7 @@ static void xsl_fault_error(void *data, u64 addr, u64 dsisr)
 	wake_up_all(&ctx->events_wq);
 }
 
-int ocxl_context_attach(struct ocxl_context *ctx, u64 amr)
+int ocxl_context_attach(struct ocxl_context *ctx, u64 amr, struct mm_struct *mm)
 {
 	int rc;
 
@@ -75,7 +77,7 @@ int ocxl_context_attach(struct ocxl_context *ctx, u64 amr)
 	}
 
 	rc = ocxl_link_add_pe(ctx->afu->fn->link, ctx->pasid,
-			current->mm->context.id, ctx->tidr, amr, current->mm,
+			mm->context.id, ctx->tidr, amr, mm,
 			xsl_fault_error, ctx);
 	if (rc)
 		goto out;
@@ -85,6 +87,7 @@ int ocxl_context_attach(struct ocxl_context *ctx, u64 amr)
 	mutex_unlock(&ctx->status_mutex);
 	return rc;
 }
+EXPORT_SYMBOL_GPL(ocxl_context_attach);
 
 static vm_fault_t map_afu_irq(struct vm_area_struct *vma, unsigned long address,
 		u64 offset, struct ocxl_context *ctx)
@@ -243,6 +246,7 @@ int ocxl_context_detach(struct ocxl_context *ctx)
 	}
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ocxl_context_detach);
 
 void ocxl_context_detach_all(struct ocxl_afu *afu)
 {
@@ -280,3 +284,4 @@ void ocxl_context_free(struct ocxl_context *ctx)
 	ocxl_afu_put(ctx->afu);
 	kfree(ctx);
 }
+EXPORT_SYMBOL_GPL(ocxl_context_free);
diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
index e6e6121cd9a3..e51578186fd4 100644
--- a/drivers/misc/ocxl/file.c
+++ b/drivers/misc/ocxl/file.c
@@ -94,7 +94,7 @@ static long afu_ioctl_attach(struct ocxl_context *ctx,
 		return -EINVAL;
 
 	amr = arg.amr & mfspr(SPRN_UAMOR);
-	rc = ocxl_context_attach(ctx, amr);
+	rc = ocxl_context_attach(ctx, amr, current->mm);
 	return rc;
 }
 
diff --git a/drivers/misc/ocxl/ocxl_internal.h b/drivers/misc/ocxl/ocxl_internal.h
index e04e547df29e..cda1e7667fc8 100644
--- a/drivers/misc/ocxl/ocxl_internal.h
+++ b/drivers/misc/ocxl/ocxl_internal.h
@@ -130,15 +130,9 @@ int ocxl_config_check_afu_index(struct pci_dev *dev,
  */
 int ocxl_link_update_pe(void *link_handle, int pasid, __u16 tid);
 
-struct ocxl_context *ocxl_context_alloc(void);
-int ocxl_context_init(struct ocxl_context *ctx, struct ocxl_afu *afu,
-			struct address_space *mapping);
-int ocxl_context_attach(struct ocxl_context *ctx, u64 amr);
 int ocxl_context_mmap(struct ocxl_context *ctx,
 			struct vm_area_struct *vma);
-int ocxl_context_detach(struct ocxl_context *ctx);
 void ocxl_context_detach_all(struct ocxl_afu *afu);
-void ocxl_context_free(struct ocxl_context *ctx);
 
 int ocxl_sysfs_register_afu(struct ocxl_afu *afu);
 void ocxl_sysfs_unregister_afu(struct ocxl_afu *afu);
diff --git a/include/misc/ocxl.h b/include/misc/ocxl.h
index 8bafd748e380..a8fe0ce4ea67 100644
--- a/include/misc/ocxl.h
+++ b/include/misc/ocxl.h
@@ -116,6 +116,51 @@ const struct ocxl_fn_config *ocxl_function_config(struct ocxl_fn *fn);
  */
 void ocxl_function_close(struct ocxl_fn *fn);
 
+// Context allocation
+
+/**
+ * Allocate space for a new OpenCAPI context
+ *
+ * Returns NULL on failure
+ */
+struct ocxl_context *ocxl_context_alloc(void);
+
+/**
+ * Initialize an OpenCAPI context
+ *
+ * @ctx: The OpenCAPI context to initialize
+ * @afu: The AFU the context belongs to
+ * @mapping: The mapping to unmap when the context is closed (may be NULL)
+ */
+int ocxl_context_init(struct ocxl_context *ctx, struct ocxl_afu *afu,
+			struct address_space *mapping);
+
+/**
+ * Free an OpenCAPI context
+ *
+ * @ctx: The OpenCAPI context to free
+ */
+void ocxl_context_free(struct ocxl_context *ctx);
+
+/**
+ * Grant access to an MM to an OpenCAPI context
+ * @ctx: The OpenCAPI context to attach
+ * @amr: The value of the AMR register to restrict access
+ * @mm: The mm to attach to the context
+ *
+ * Returns 0 on success, negative on failure
+ */
+int ocxl_context_attach(struct ocxl_context *ctx, u64 amr,
+				struct mm_struct *mm);
+
+/**
+ * Detach an MM from an OpenCAPI context
+ * @ctx: The OpenCAPI context to attach
+ *
+ * Returns 0 on success, negative on failure
+ */
+int ocxl_context_detach(struct ocxl_context *ctx);
+
 // AFU Metadata
 
 /**
-- 
2.20.1

