Return-Path: <SRS0=MnD0=R6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B69C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 05:40:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 802C5206DF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 05:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 802C5206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44TcKG3bsrzDqFS
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 16:40:18 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Tc8J2VV5zDqMd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 16:32:32 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2R5TQuj026213
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 01:32:30 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2rg1n02mnv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 01:32:29 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alastair@au1.ibm.com>;
 Wed, 27 Mar 2019 05:32:27 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 27 Mar 2019 05:32:25 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2R5WOPE51380442
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Mar 2019 05:32:24 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D9FCCA4054;
 Wed, 27 Mar 2019 05:32:23 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F2F74A405C;
 Wed, 27 Mar 2019 05:32:22 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 27 Mar 2019 05:32:22 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id D532CA00BD;
 Wed, 27 Mar 2019 16:32:21 +1100 (AEDT)
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: alastair@d-silva.org
Subject: [PATCH v4 3/7] ocxl: Create a clear delineation between ocxl backend
 & frontend
Date: Wed, 27 Mar 2019 16:31:32 +1100
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327053137.15173-1-alastair@au1.ibm.com>
References: <20190327053137.15173-1-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19032705-4275-0000-0000-0000031FB25D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032705-4276-0000-0000-0000382E4AC1
Message-Id: <20190327053137.15173-4-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-27_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903270038
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
 Frederic Barrat <fbarrat@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Alastair D'Silva <alastair@d-silva.org>

The OCXL driver contains both frontend code for interacting with userspace,
as well as backend code for interacting with the hardware.

This patch separates the backend code from the frontend so that it can be
used by other device drivers that communicate via OpenCAPI.

Relocate dev, cdev & sysfs files to the frontend code to allow external
drivers to maintain their own devices.

Reference counting on the device in the backend is replaced with kref
counting.

Move file & sysfs layer initialisation from core.c (backend) to
pci.c (frontend).

Create an ocxl_function oriented interface for initing devices &
enumerating AFUs.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/misc/ocxl/context.c       |   2 +-
 drivers/misc/ocxl/core.c          | 201 +++++++++++++++++++-----------
 drivers/misc/ocxl/file.c          | 142 ++++++++++++++-------
 drivers/misc/ocxl/ocxl_internal.h |  31 ++---
 drivers/misc/ocxl/pci.c           |  56 ++++-----
 drivers/misc/ocxl/sysfs.c         |  54 ++++----
 include/misc/ocxl.h               | 119 ++++++++++++++++--
 7 files changed, 409 insertions(+), 196 deletions(-)

diff --git a/drivers/misc/ocxl/context.c b/drivers/misc/ocxl/context.c
index c10a940e3b38..c73a859d2224 100644
--- a/drivers/misc/ocxl/context.c
+++ b/drivers/misc/ocxl/context.c
@@ -238,7 +238,7 @@ int ocxl_context_detach(struct ocxl_context *ctx)
 	}
 	rc = ocxl_link_remove_pe(ctx->afu->fn->link, ctx->pasid);
 	if (rc) {
-		dev_warn(&ctx->afu->dev,
+		dev_warn(&dev->dev,
 			"Couldn't remove PE entry cleanly: %d\n", rc);
 	}
 	return 0;
diff --git a/drivers/misc/ocxl/core.c b/drivers/misc/ocxl/core.c
index 2f2fe12eac1e..b7a09b21ab36 100644
--- a/drivers/misc/ocxl/core.c
+++ b/drivers/misc/ocxl/core.c
@@ -13,16 +13,6 @@ static void ocxl_fn_put(struct ocxl_fn *fn)
 	put_device(&fn->dev);
 }
 
-struct ocxl_afu *ocxl_afu_get(struct ocxl_afu *afu)
-{
-	return (get_device(&afu->dev) == NULL) ? NULL : afu;
-}
-
-void ocxl_afu_put(struct ocxl_afu *afu)
-{
-	put_device(&afu->dev);
-}
-
 static struct ocxl_afu *alloc_afu(struct ocxl_fn *fn)
 {
 	struct ocxl_afu *afu;
@@ -31,6 +21,7 @@ static struct ocxl_afu *alloc_afu(struct ocxl_fn *fn)
 	if (!afu)
 		return NULL;
 
+	kref_init(&afu->kref);
 	mutex_init(&afu->contexts_lock);
 	mutex_init(&afu->afu_control_lock);
 	idr_init(&afu->contexts_idr);
@@ -39,32 +30,26 @@ static struct ocxl_afu *alloc_afu(struct ocxl_fn *fn)
 	return afu;
 }
 
-static void free_afu(struct ocxl_afu *afu)
+static void free_afu(struct kref *kref)
 {
+	struct ocxl_afu *afu = container_of(kref, struct ocxl_afu, kref);
+
 	idr_destroy(&afu->contexts_idr);
 	ocxl_fn_put(afu->fn);
 	kfree(afu);
 }
 
-static void free_afu_dev(struct device *dev)
+void ocxl_afu_get(struct ocxl_afu *afu)
 {
-	struct ocxl_afu *afu = to_ocxl_afu(dev);
-
-	ocxl_unregister_afu(afu);
-	free_afu(afu);
+	kref_get(&afu->kref);
 }
+EXPORT_SYMBOL_GPL(ocxl_afu_get);
 
-static int set_afu_device(struct ocxl_afu *afu, const char *location)
+void ocxl_afu_put(struct ocxl_afu *afu)
 {
-	struct ocxl_fn *fn = afu->fn;
-	int rc;
-
-	afu->dev.parent = &fn->dev;
-	afu->dev.release = free_afu_dev;
-	rc = dev_set_name(&afu->dev, "%s.%s.%hhu", afu->config.name, location,
-		afu->config.idx);
-	return rc;
+	kref_put(&afu->kref, free_afu);
 }
+EXPORT_SYMBOL_GPL(ocxl_afu_put);
 
 static int assign_afu_actag(struct ocxl_afu *afu)
 {
@@ -233,27 +218,25 @@ static int configure_afu(struct ocxl_afu *afu, u8 afu_idx, struct pci_dev *dev)
 	if (rc)
 		return rc;
 
-	rc = set_afu_device(afu, dev_name(&dev->dev));
-	if (rc)
-		return rc;
-
 	rc = assign_afu_actag(afu);
 	if (rc)
 		return rc;
 
 	rc = assign_afu_pasid(afu);
-	if (rc) {
-		reclaim_afu_actag(afu);
-		return rc;
-	}
+	if (rc)
+		goto err_free_actag;
 
 	rc = map_mmio_areas(afu);
-	if (rc) {
-		reclaim_afu_pasid(afu);
-		reclaim_afu_actag(afu);
-		return rc;
-	}
+	if (rc)
+		goto err_free_pasid;
+
 	return 0;
+
+err_free_pasid:
+	reclaim_afu_pasid(afu);
+err_free_actag:
+	reclaim_afu_actag(afu);
+	return rc;
 }
 
 static void deconfigure_afu(struct ocxl_afu *afu)
@@ -265,16 +248,8 @@ static void deconfigure_afu(struct ocxl_afu *afu)
 
 static int activate_afu(struct pci_dev *dev, struct ocxl_afu *afu)
 {
-	int rc;
-
 	ocxl_config_set_afu_state(dev, afu->config.dvsec_afu_control_pos, 1);
-	/*
-	 * Char device creation is the last step, as processes can
-	 * call our driver immediately, so all our inits must be finished.
-	 */
-	rc = ocxl_create_cdev(afu);
-	if (rc)
-		return rc;
+
 	return 0;
 }
 
@@ -282,11 +257,10 @@ static void deactivate_afu(struct ocxl_afu *afu)
 {
 	struct pci_dev *dev = to_pci_dev(afu->fn->dev.parent);
 
-	ocxl_destroy_cdev(afu);
 	ocxl_config_set_afu_state(dev, afu->config.dvsec_afu_control_pos, 0);
 }
 
-int init_afu(struct pci_dev *dev, struct ocxl_fn *fn, u8 afu_idx)
+static int init_afu(struct pci_dev *dev, struct ocxl_fn *fn, u8 afu_idx)
 {
 	int rc;
 	struct ocxl_afu *afu;
@@ -297,41 +271,29 @@ int init_afu(struct pci_dev *dev, struct ocxl_fn *fn, u8 afu_idx)
 
 	rc = configure_afu(afu, afu_idx, dev);
 	if (rc) {
-		free_afu(afu);
+		ocxl_afu_put(afu);
 		return rc;
 	}
 
-	rc = ocxl_register_afu(afu);
-	if (rc)
-		goto err;
-
-	rc = ocxl_sysfs_add_afu(afu);
-	if (rc)
-		goto err;
-
 	rc = activate_afu(dev, afu);
-	if (rc)
-		goto err_sys;
+	if (rc) {
+		deconfigure_afu(afu);
+		ocxl_afu_put(afu);
+		return rc;
+	}
 
 	list_add_tail(&afu->list, &fn->afu_list);
-	return 0;
 
-err_sys:
-	ocxl_sysfs_remove_afu(afu);
-err:
-	deconfigure_afu(afu);
-	device_unregister(&afu->dev);
-	return rc;
+	return 0;
 }
 
-void remove_afu(struct ocxl_afu *afu)
+static void remove_afu(struct ocxl_afu *afu)
 {
 	list_del(&afu->list);
 	ocxl_context_detach_all(afu);
 	deactivate_afu(afu);
-	ocxl_sysfs_remove_afu(afu);
 	deconfigure_afu(afu);
-	device_unregister(&afu->dev);
+	ocxl_afu_put(afu); // matches the implicit get in alloc_afu
 }
 
 static struct ocxl_fn *alloc_function(void)
@@ -358,7 +320,7 @@ static void free_function(struct ocxl_fn *fn)
 
 static void free_function_dev(struct device *dev)
 {
-	struct ocxl_fn *fn = to_ocxl_function(dev);
+	struct ocxl_fn *fn = container_of(dev, struct ocxl_fn, dev);
 
 	free_function(fn);
 }
@@ -372,7 +334,6 @@ static int set_function_device(struct ocxl_fn *fn, struct pci_dev *dev)
 	rc = dev_set_name(&fn->dev, "ocxlfn.%s", dev_name(&dev->dev));
 	if (rc)
 		return rc;
-	pci_set_drvdata(dev, fn);
 	return 0;
 }
 
@@ -490,7 +451,7 @@ static void deconfigure_function(struct ocxl_fn *fn)
 	pci_disable_device(dev);
 }
 
-struct ocxl_fn *init_function(struct pci_dev *dev)
+static struct ocxl_fn *init_function(struct pci_dev *dev)
 {
 	struct ocxl_fn *fn;
 	int rc;
@@ -514,8 +475,100 @@ struct ocxl_fn *init_function(struct pci_dev *dev)
 	return fn;
 }
 
-void remove_function(struct ocxl_fn *fn)
+// Device detection & initialisation
+
+struct ocxl_fn *ocxl_function_open(struct pci_dev *dev)
+{
+	int rc, afu_count = 0;
+	u8 afu;
+	struct ocxl_fn *fn;
+
+	if (!radix_enabled()) {
+		dev_err(&dev->dev, "Unsupported memory model (hash)\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	fn = init_function(dev);
+	if (IS_ERR(fn)) {
+		dev_err(&dev->dev, "function init failed: %li\n",
+			PTR_ERR(fn));
+		return fn;
+	}
+
+	for (afu = 0; afu <= fn->config.max_afu_index; afu++) {
+		rc = ocxl_config_check_afu_index(dev, &fn->config, afu);
+		if (rc > 0) {
+			rc = init_afu(dev, fn, afu);
+			if (rc) {
+				dev_err(&dev->dev,
+					"Can't initialize AFU index %d\n", afu);
+				continue;
+			}
+			afu_count++;
+		}
+	}
+	dev_info(&dev->dev, "%d AFU(s) configured\n", afu_count);
+	return fn;
+}
+EXPORT_SYMBOL_GPL(ocxl_function_open);
+
+struct list_head *ocxl_function_afu_list(struct ocxl_fn *fn)
+{
+	return &fn->afu_list;
+}
+EXPORT_SYMBOL_GPL(ocxl_function_afu_list);
+
+struct ocxl_afu *ocxl_function_fetch_afu(struct ocxl_fn *fn, u8 afu_idx)
+{
+	struct ocxl_afu *afu;
+
+	list_for_each_entry(afu, &fn->afu_list, list) {
+		if (afu->config.idx == afu_idx)
+			return afu;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(ocxl_function_fetch_afu);
+
+const struct ocxl_fn_config *ocxl_function_config(struct ocxl_fn *fn)
 {
+	return &fn->config;
+}
+EXPORT_SYMBOL_GPL(ocxl_function_config);
+
+void ocxl_function_close(struct ocxl_fn *fn)
+{
+	struct ocxl_afu *afu, *tmp;
+
+	list_for_each_entry_safe(afu, tmp, &fn->afu_list, list) {
+		remove_afu(afu);
+	}
+
 	deconfigure_function(fn);
 	device_unregister(&fn->dev);
 }
+EXPORT_SYMBOL_GPL(ocxl_function_close);
+
+// AFU Metadata
+
+struct ocxl_afu_config *ocxl_afu_config(struct ocxl_afu *afu)
+{
+	return &afu->config;
+}
+EXPORT_SYMBOL_GPL(ocxl_afu_config);
+
+void ocxl_afu_set_private(struct ocxl_afu *afu, void *private)
+{
+	afu->private = private;
+}
+EXPORT_SYMBOL_GPL(ocxl_afu_set_private);
+
+void *ocxl_afu_get_private(struct ocxl_afu *afu)
+{
+	if (afu)
+		return afu->private;
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(ocxl_afu_get_private);
diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
index 009e09b7ded5..7a38ea5af9db 100644
--- a/drivers/misc/ocxl/file.c
+++ b/drivers/misc/ocxl/file.c
@@ -17,70 +17,60 @@ static struct class *ocxl_class;
 static struct mutex minors_idr_lock;
 static struct idr minors_idr;
 
-static struct ocxl_afu *find_and_get_afu(dev_t devno)
+static struct ocxl_file_info *find_file_info(dev_t devno)
 {
-	struct ocxl_afu *afu;
-	int afu_minor;
+	struct ocxl_file_info *info;
 
-	afu_minor = MINOR(devno);
 	/*
 	 * We don't declare an RCU critical section here, as our AFU
 	 * is protected by a reference counter on the device. By the time the
-	 * minor number of a device is removed from the idr, the ref count of
+	 * info reference is removed from the idr, the ref count of
 	 * the device is already at 0, so no user API will access that AFU and
 	 * this function can't return it.
 	 */
-	afu = idr_find(&minors_idr, afu_minor);
-	if (afu)
-		ocxl_afu_get(afu);
-	return afu;
+	info = idr_find(&minors_idr, MINOR(devno));
+	return info;
 }
 
-static int allocate_afu_minor(struct ocxl_afu *afu)
+static int allocate_minor(struct ocxl_file_info *info)
 {
 	int minor;
 
 	mutex_lock(&minors_idr_lock);
-	minor = idr_alloc(&minors_idr, afu, 0, OCXL_NUM_MINORS, GFP_KERNEL);
+	minor = idr_alloc(&minors_idr, info, 0, OCXL_NUM_MINORS, GFP_KERNEL);
 	mutex_unlock(&minors_idr_lock);
 	return minor;
 }
 
-static void free_afu_minor(struct ocxl_afu *afu)
+static void free_minor(struct ocxl_file_info *info)
 {
 	mutex_lock(&minors_idr_lock);
-	idr_remove(&minors_idr, MINOR(afu->dev.devt));
+	idr_remove(&minors_idr, MINOR(info->dev.devt));
 	mutex_unlock(&minors_idr_lock);
 }
 
 static int afu_open(struct inode *inode, struct file *file)
 {
-	struct ocxl_afu *afu;
+	struct ocxl_file_info *info;
 	struct ocxl_context *ctx;
 	int rc;
 
 	pr_debug("%s for device %x\n", __func__, inode->i_rdev);
 
-	afu = find_and_get_afu(inode->i_rdev);
-	if (!afu)
+	info = find_file_info(inode->i_rdev);
+	if (!info)
 		return -ENODEV;
 
 	ctx = ocxl_context_alloc();
-	if (!ctx) {
-		rc = -ENOMEM;
-		goto put_afu;
-	}
+	if (!ctx)
+		return -ENOMEM;
 
-	rc = ocxl_context_init(ctx, afu, inode->i_mapping);
+	rc = ocxl_context_init(ctx, info->afu, inode->i_mapping);
 	if (rc)
-		goto put_afu;
+		return rc;
+
 	file->private_data = ctx;
-	ocxl_afu_put(afu);
 	return 0;
-
-put_afu:
-	ocxl_afu_put(afu);
-	return rc;
 }
 
 static long afu_ioctl_attach(struct ocxl_context *ctx,
@@ -204,11 +194,16 @@ static long afu_ioctl(struct file *file, unsigned int cmd,
 	struct ocxl_ioctl_irq_fd irq_fd;
 	u64 irq_offset;
 	long rc;
+	bool closed;
 
 	pr_debug("%s for context %d, command %s\n", __func__, ctx->pasid,
 		CMD_STR(cmd));
 
-	if (ctx->status == CLOSED)
+	mutex_lock(&ctx->status_mutex);
+	closed = (ctx->status == CLOSED);
+	mutex_unlock(&ctx->status_mutex);
+
+	if (closed)
 		return -EIO;
 
 	switch (cmd) {
@@ -468,39 +463,102 @@ static const struct file_operations ocxl_afu_fops = {
 	.release        = afu_release,
 };
 
-int ocxl_create_cdev(struct ocxl_afu *afu)
+// Free the info struct
+static void info_release(struct device *dev)
+{
+	struct ocxl_file_info *info = container_of(dev, struct ocxl_file_info, dev);
+
+	free_minor(info);
+	ocxl_afu_put(info->afu);
+	kfree(info);
+}
+
+static int ocxl_file_make_visible(struct ocxl_file_info *info)
 {
 	int rc;
 
-	cdev_init(&afu->cdev, &ocxl_afu_fops);
-	rc = cdev_add(&afu->cdev, afu->dev.devt, 1);
+	cdev_init(&info->cdev, &ocxl_afu_fops);
+	rc = cdev_add(&info->cdev, info->dev.devt, 1);
 	if (rc) {
-		dev_err(&afu->dev, "Unable to add afu char device: %d\n", rc);
+		dev_err(&info->dev, "Unable to add afu char device: %d\n", rc);
 		return rc;
 	}
+
 	return 0;
 }
 
-void ocxl_destroy_cdev(struct ocxl_afu *afu)
+static void ocxl_file_make_invisible(struct ocxl_file_info *info)
 {
-	cdev_del(&afu->cdev);
+	cdev_del(&info->cdev);
 }
 
-int ocxl_register_afu(struct ocxl_afu *afu)
+int ocxl_file_register_afu(struct ocxl_afu *afu)
 {
 	int minor;
+	int rc;
+	struct ocxl_file_info *info;
+	struct ocxl_fn *fn = afu->fn;
+	struct pci_dev *pci_dev = to_pci_dev(fn->dev.parent);
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (info == NULL)
+		return -ENOMEM;
 
-	minor = allocate_afu_minor(afu);
-	if (minor < 0)
+	minor = allocate_minor(info);
+	if (minor < 0) {
+		kfree(info);
 		return minor;
-	afu->dev.devt = MKDEV(MAJOR(ocxl_dev), minor);
-	afu->dev.class = ocxl_class;
-	return device_register(&afu->dev);
+	}
+
+	info->dev.parent = &fn->dev;
+	info->dev.devt = MKDEV(MAJOR(ocxl_dev), minor);
+	info->dev.class = ocxl_class;
+	info->dev.release = info_release;
+
+	info->afu = afu;
+	ocxl_afu_get(afu);
+
+	rc = dev_set_name(&info->dev, "%s.%s.%hhu",
+		afu->config.name, dev_name(&pci_dev->dev), afu->config.idx);
+	if (rc)
+		goto err_put;
+
+	rc = device_register(&info->dev);
+	if (rc)
+		goto err_put;
+
+	rc = ocxl_sysfs_register_afu(info);
+	if (rc)
+		goto err_unregister;
+
+	rc = ocxl_file_make_visible(info);
+	if (rc)
+		goto err_unregister;
+
+	ocxl_afu_set_private(afu, info);
+
+	return 0;
+
+err_unregister:
+	ocxl_sysfs_unregister_afu(info); // safe to call even if register failed
+	device_unregister(&info->dev);
+err_put:
+	ocxl_afu_put(afu);
+	free_minor(info);
+	kfree(info);
+	return rc;
 }
 
-void ocxl_unregister_afu(struct ocxl_afu *afu)
+void ocxl_file_unregister_afu(struct ocxl_afu *afu)
 {
-	free_afu_minor(afu);
+	struct ocxl_file_info *info = ocxl_afu_get_private(afu);
+
+	if (!info)
+		return;
+
+	ocxl_file_make_invisible(info);
+	ocxl_sysfs_unregister_afu(info);
+	device_unregister(&info->dev);
 }
 
 static char *ocxl_devnode(struct device *dev, umode_t *mode)
diff --git a/drivers/misc/ocxl/ocxl_internal.h b/drivers/misc/ocxl/ocxl_internal.h
index 81086534dab5..53b6c64a1bf0 100644
--- a/drivers/misc/ocxl/ocxl_internal.h
+++ b/drivers/misc/ocxl/ocxl_internal.h
@@ -11,9 +11,6 @@
 #define MAX_IRQ_PER_LINK	2000
 #define MAX_IRQ_PER_CONTEXT	MAX_IRQ_PER_LINK
 
-#define to_ocxl_function(d) container_of(d, struct ocxl_fn, dev)
-#define to_ocxl_afu(d) container_of(d, struct ocxl_afu, dev)
-
 extern struct pci_driver ocxl_pci_driver;
 
 struct ocxl_fn {
@@ -30,11 +27,17 @@ struct ocxl_fn {
 	void *link;
 };
 
+struct ocxl_file_info {
+	struct ocxl_afu *afu;
+	struct device dev;
+	struct cdev cdev;
+	struct bin_attribute attr_global_mmio;
+};
+
 struct ocxl_afu {
+	struct kref kref;
 	struct ocxl_fn *fn;
 	struct list_head list;
-	struct device dev;
-	struct cdev cdev;
 	struct ocxl_afu_config config;
 	int pasid_base;
 	int pasid_count; /* opened contexts */
@@ -48,7 +51,7 @@ struct ocxl_afu {
 	u64 irq_base_offset;
 	void __iomem *global_mmio_ptr;
 	u64 pp_mmio_start;
-	struct bin_attribute attr_global_mmio;
+	void *private;
 };
 
 enum ocxl_context_status {
@@ -91,13 +94,10 @@ struct ocxl_process_element {
 	__be32 software_state;
 };
 
-struct ocxl_afu *ocxl_afu_get(struct ocxl_afu *afu);
-void ocxl_afu_put(struct ocxl_afu *afu);
-
 int ocxl_create_cdev(struct ocxl_afu *afu);
 void ocxl_destroy_cdev(struct ocxl_afu *afu);
-int ocxl_register_afu(struct ocxl_afu *afu);
-void ocxl_unregister_afu(struct ocxl_afu *afu);
+int ocxl_file_register_afu(struct ocxl_afu *afu);
+void ocxl_file_unregister_afu(struct ocxl_afu *afu);
 
 int ocxl_file_init(void);
 void ocxl_file_exit(void);
@@ -140,8 +140,8 @@ int ocxl_context_detach(struct ocxl_context *ctx);
 void ocxl_context_detach_all(struct ocxl_afu *afu);
 void ocxl_context_free(struct ocxl_context *ctx);
 
-int ocxl_sysfs_add_afu(struct ocxl_afu *afu);
-void ocxl_sysfs_remove_afu(struct ocxl_afu *afu);
+int ocxl_sysfs_register_afu(struct ocxl_file_info *info);
+void ocxl_sysfs_unregister_afu(struct ocxl_file_info *info);
 
 int ocxl_afu_irq_alloc(struct ocxl_context *ctx, u64 *irq_offset);
 int ocxl_afu_irq_free(struct ocxl_context *ctx, u64 irq_offset);
@@ -150,9 +150,4 @@ int ocxl_afu_irq_set_fd(struct ocxl_context *ctx, u64 irq_offset,
 			int eventfd);
 u64 ocxl_afu_irq_get_addr(struct ocxl_context *ctx, u64 irq_offset);
 
-struct ocxl_fn *init_function(struct pci_dev *dev);
-void remove_function(struct ocxl_fn *fn);
-int init_afu(struct pci_dev *dev, struct ocxl_fn *fn, u8 afu_idx);
-void remove_afu(struct ocxl_afu *afu);
-
 #endif /* _OCXL_INTERNAL_H_ */
diff --git a/drivers/misc/ocxl/pci.c b/drivers/misc/ocxl/pci.c
index 4ed7cb1a667f..f2a3ef4b9bdd 100644
--- a/drivers/misc/ocxl/pci.c
+++ b/drivers/misc/ocxl/pci.c
@@ -16,47 +16,45 @@ MODULE_DEVICE_TABLE(pci, ocxl_pci_tbl);
 
 static int ocxl_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	int rc, afu_count = 0;
-	u8 afu;
+	int rc;
+	struct ocxl_afu *afu, *tmp;
 	struct ocxl_fn *fn;
+	struct list_head *afu_list;
 
-	if (!radix_enabled()) {
-		dev_err(&dev->dev, "Unsupported memory model (hash)\n");
-		return -ENODEV;
-	}
-
-	fn = init_function(dev);
-	if (IS_ERR(fn)) {
-		dev_err(&dev->dev, "function init failed: %li\n",
-			PTR_ERR(fn));
+	fn = ocxl_function_open(dev);
+	if (IS_ERR(fn))
 		return PTR_ERR(fn);
-	}
 
-	for (afu = 0; afu <= fn->config.max_afu_index; afu++) {
-		rc = ocxl_config_check_afu_index(dev, &fn->config, afu);
-		if (rc > 0) {
-			rc = init_afu(dev, fn, afu);
-			if (rc) {
-				dev_err(&dev->dev,
-					"Can't initialize AFU index %d\n", afu);
-				continue;
-			}
-			afu_count++;
+	pci_set_drvdata(dev, fn);
+
+	afu_list = ocxl_function_afu_list(fn);
+
+	list_for_each_entry_safe(afu, tmp, afu_list, list) {
+		// Cleanup handled within ocxl_file_register_afu()
+		rc = ocxl_file_register_afu(afu);
+		if (rc) {
+			dev_err(&dev->dev, "Failed to register AFU '%s' index %d",
+					afu->config.name, afu->config.idx);
 		}
 	}
-	dev_info(&dev->dev, "%d AFU(s) configured\n", afu_count);
+
 	return 0;
 }
 
-static void ocxl_remove(struct pci_dev *dev)
+void ocxl_remove(struct pci_dev *dev)
 {
-	struct ocxl_afu *afu, *tmp;
-	struct ocxl_fn *fn = pci_get_drvdata(dev);
+	struct ocxl_fn *fn;
+	struct ocxl_afu *afu;
+	struct list_head *afu_list;
 
-	list_for_each_entry_safe(afu, tmp, &fn->afu_list, list) {
-		remove_afu(afu);
+	fn = pci_get_drvdata(dev);
+	afu_list = ocxl_function_afu_list(fn);
+
+	list_for_each_entry(afu, afu_list, list) {
+		ocxl_file_unregister_afu(afu);
 	}
-	remove_function(fn);
+
+	ocxl_function_close(fn);
 }
 
 struct pci_driver ocxl_pci_driver = {
diff --git a/drivers/misc/ocxl/sysfs.c b/drivers/misc/ocxl/sysfs.c
index 0ab1fd1b2682..58f1ba264206 100644
--- a/drivers/misc/ocxl/sysfs.c
+++ b/drivers/misc/ocxl/sysfs.c
@@ -3,11 +3,18 @@
 #include <linux/sysfs.h>
 #include "ocxl_internal.h"
 
+static inline struct ocxl_afu *to_afu(struct device *device)
+{
+	struct ocxl_file_info *info = container_of(device, struct ocxl_file_info, dev);
+
+	return info->afu;
+}
+
 static ssize_t global_mmio_size_show(struct device *device,
 				struct device_attribute *attr,
 				char *buf)
 {
-	struct ocxl_afu *afu = to_ocxl_afu(device);
+	struct ocxl_afu *afu = to_afu(device);
 
 	return scnprintf(buf, PAGE_SIZE, "%d\n",
 			afu->config.global_mmio_size);
@@ -17,7 +24,7 @@ static ssize_t pp_mmio_size_show(struct device *device,
 				struct device_attribute *attr,
 				char *buf)
 {
-	struct ocxl_afu *afu = to_ocxl_afu(device);
+	struct ocxl_afu *afu = to_afu(device);
 
 	return scnprintf(buf, PAGE_SIZE, "%d\n",
 			afu->config.pp_mmio_stride);
@@ -27,7 +34,7 @@ static ssize_t afu_version_show(struct device *device,
 				struct device_attribute *attr,
 				char *buf)
 {
-	struct ocxl_afu *afu = to_ocxl_afu(device);
+	struct ocxl_afu *afu = to_afu(device);
 
 	return scnprintf(buf, PAGE_SIZE, "%hhu:%hhu\n",
 			afu->config.version_major,
@@ -38,7 +45,7 @@ static ssize_t contexts_show(struct device *device,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct ocxl_afu *afu = to_ocxl_afu(device);
+	struct ocxl_afu *afu = to_afu(device);
 
 	return scnprintf(buf, PAGE_SIZE, "%d/%d\n",
 			afu->pasid_count, afu->pasid_max);
@@ -55,7 +62,7 @@ static ssize_t global_mmio_read(struct file *filp, struct kobject *kobj,
 				struct bin_attribute *bin_attr, char *buf,
 				loff_t off, size_t count)
 {
-	struct ocxl_afu *afu = to_ocxl_afu(kobj_to_dev(kobj));
+	struct ocxl_afu *afu = to_afu(kobj_to_dev(kobj));
 
 	if (count == 0 || off < 0 ||
 		off >= afu->config.global_mmio_size)
@@ -86,7 +93,7 @@ static int global_mmio_mmap(struct file *filp, struct kobject *kobj,
 			struct bin_attribute *bin_attr,
 			struct vm_area_struct *vma)
 {
-	struct ocxl_afu *afu = to_ocxl_afu(kobj_to_dev(kobj));
+	struct ocxl_afu *afu = to_afu(kobj_to_dev(kobj));
 
 	if ((vma_pages(vma) + vma->vm_pgoff) >
 		(afu->config.global_mmio_size >> PAGE_SHIFT))
@@ -99,27 +106,25 @@ static int global_mmio_mmap(struct file *filp, struct kobject *kobj,
 	return 0;
 }
 
-int ocxl_sysfs_add_afu(struct ocxl_afu *afu)
+int ocxl_sysfs_register_afu(struct ocxl_file_info *info)
 {
 	int i, rc;
 
 	for (i = 0; i < ARRAY_SIZE(afu_attrs); i++) {
-		rc = device_create_file(&afu->dev, &afu_attrs[i]);
+		rc = device_create_file(&info->dev, &afu_attrs[i]);
 		if (rc)
 			goto err;
 	}
 
-	sysfs_attr_init(&afu->attr_global_mmio.attr);
-	afu->attr_global_mmio.attr.name = "global_mmio_area";
-	afu->attr_global_mmio.attr.mode = 0600;
-	afu->attr_global_mmio.size = afu->config.global_mmio_size;
-	afu->attr_global_mmio.read = global_mmio_read;
-	afu->attr_global_mmio.mmap = global_mmio_mmap;
-	rc = device_create_bin_file(&afu->dev, &afu->attr_global_mmio);
+	sysfs_attr_init(&info->attr_global_mmio.attr);
+	info->attr_global_mmio.attr.name = "global_mmio_area";
+	info->attr_global_mmio.attr.mode = 0600;
+	info->attr_global_mmio.size = info->afu->config.global_mmio_size;
+	info->attr_global_mmio.read = global_mmio_read;
+	info->attr_global_mmio.mmap = global_mmio_mmap;
+	rc = device_create_bin_file(&info->dev, &info->attr_global_mmio);
 	if (rc) {
-		dev_err(&afu->dev,
-			"Unable to create global mmio attr for afu: %d\n",
-			rc);
+		dev_err(&info->dev, "Unable to create global mmio attr for afu: %d\n", rc);
 		goto err;
 	}
 
@@ -127,15 +132,20 @@ int ocxl_sysfs_add_afu(struct ocxl_afu *afu)
 
 err:
 	for (i--; i >= 0; i--)
-		device_remove_file(&afu->dev, &afu_attrs[i]);
+		device_remove_file(&info->dev, &afu_attrs[i]);
+
 	return rc;
 }
 
-void ocxl_sysfs_remove_afu(struct ocxl_afu *afu)
+void ocxl_sysfs_unregister_afu(struct ocxl_file_info *info)
 {
 	int i;
 
+	/*
+	 * device_remove_bin_file is safe to call if the file is not added as
+	 * the files are removed by name, and early exit if not found
+	 */
 	for (i = 0; i < ARRAY_SIZE(afu_attrs); i++)
-		device_remove_file(&afu->dev, &afu_attrs[i]);
-	device_remove_bin_file(&afu->dev, &afu->attr_global_mmio);
+		device_remove_file(&info->dev, &afu_attrs[i]);
+	device_remove_bin_file(&info->dev, &info->attr_global_mmio);
 }
diff --git a/include/misc/ocxl.h b/include/misc/ocxl.h
index 9530d3be1b30..8bafd748e380 100644
--- a/include/misc/ocxl.h
+++ b/include/misc/ocxl.h
@@ -16,11 +16,7 @@
 
 #define OCXL_AFU_NAME_SZ      (24+1)  /* add 1 for NULL termination */
 
-/*
- * The following 2 structures are a fairly generic way of representing
- * the configuration data for a function and AFU, as read from the
- * configuration space.
- */
+
 struct ocxl_afu_config {
 	u8 idx;
 	int dvsec_afu_control_pos; /* offset of AFU control DVSEC */
@@ -49,12 +45,108 @@ struct ocxl_fn_config {
 	s8 max_afu_index;
 };
 
-/*
- * Read the configuration space of a function and fill in a
- * ocxl_fn_config structure with all the function details
+// These are opaque outside the ocxl driver
+struct ocxl_afu;
+struct ocxl_fn;
+
+// Device detection & initialisation
+
+/**
+ * Open an OpenCAPI function on an OpenCAPI device
+ *
+ * @dev: The PCI device that contains the function
+ *
+ * Returns an opaque pointer to the function, or an error pointer (check with IS_ERR)
  */
-int ocxl_config_read_function(struct pci_dev *dev,
-				struct ocxl_fn_config *fn);
+struct ocxl_fn *ocxl_function_open(struct pci_dev *dev);
+
+/**
+ * Get the list of AFUs associated with a PCI function device
+ *
+ * Returns a list of struct ocxl_afu *
+ *
+ * @fn: The OpenCAPI function containing the AFUs
+ */
+struct list_head *ocxl_function_afu_list(struct ocxl_fn *fn);
+
+/**
+ * Fetch an AFU instance from an OpenCAPI function
+ *
+ * @fn: The OpenCAPI function to get the AFU from
+ * @afu_idx: The index of the AFU to get
+ *
+ * If successful, the AFU should be released with ocxl_afu_put()
+ *
+ * Returns a pointer to the AFU, or NULL on error
+ */
+struct ocxl_afu *ocxl_function_fetch_afu(struct ocxl_fn *fn, u8 afu_idx);
+
+/**
+ * Take a reference to an AFU
+ *
+ * @afu: The AFU to increment the reference count on
+ */
+void ocxl_afu_get(struct ocxl_afu *afu);
+
+/**
+ * Release a reference to an AFU
+ *
+ * @afu: The AFU to decrement the reference count on
+ */
+void ocxl_afu_put(struct ocxl_afu *afu);
+
+
+/**
+ * Get the configuration information for an OpenCAPI function
+ *
+ * @fn: The OpenCAPI function to get the config for
+ *
+ * Returns the function config, or NULL on error
+ */
+const struct ocxl_fn_config *ocxl_function_config(struct ocxl_fn *fn);
+
+/**
+ * Close an OpenCAPI function
+ *
+ * This will free any AFUs previously retrieved from the function, and
+ * detach and associated contexts. The contexts must by freed by the caller.
+ *
+ * @fn: The OpenCAPI function to close
+ *
+ */
+void ocxl_function_close(struct ocxl_fn *fn);
+
+// AFU Metadata
+
+/**
+ * Get a pointer to the config for an AFU
+ *
+ * @afu: a pointer to the AFU to get the config for
+ *
+ * Returns a pointer to the AFU config
+ */
+struct ocxl_afu_config *ocxl_afu_config(struct ocxl_afu *afu);
+
+/**
+ * Assign opaque hardware specific information to an OpenCAPI AFU.
+ *
+ * @dev: The PCI device associated with the OpenCAPI device
+ * @private: the opaque hardware specific information to assign to the driver
+ */
+void ocxl_afu_set_private(struct ocxl_afu *afu, void *private);
+
+/**
+ * Fetch the hardware specific information associated with an external OpenCAPI
+ * AFU. This may be consumed by an external OpenCAPI driver.
+ *
+ * @afu: The AFU
+ *
+ * Returns the opaque pointer associated with the device, or NULL if not set
+ */
+void *ocxl_afu_get_private(struct ocxl_afu *dev);
+
+
+// Functions left here are for compatibility with the cxlflash driver
 
 /*
  * Read the configuration space of a function for the AFU specified by
@@ -141,6 +233,13 @@ int ocxl_config_set_TL(struct pci_dev *dev, int tl_dvsec);
 int ocxl_config_terminate_pasid(struct pci_dev *dev,
 				int afu_control_offset, int pasid);
 
+/*
+ * Read the configuration space of a function and fill in a
+ * ocxl_fn_config structure with all the function details
+ */
+int ocxl_config_read_function(struct pci_dev *dev,
+				struct ocxl_fn_config *fn);
+
 /*
  * Set up the opencapi link for the function.
  *
-- 
2.20.1

