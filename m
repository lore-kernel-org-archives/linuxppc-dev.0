Return-Path: <SRS0=wHv8=RQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7210C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 04:26:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C3912070D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 04:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3912070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44JzM2185ZzDqKq
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 15:26:54 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Jz6y3tTQzDqJc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 15:16:26 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2D4DeYX004180
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 00:16:24 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2r6q6aqyrh-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 00:16:24 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alastair@au1.ibm.com>;
 Wed, 13 Mar 2019 04:16:22 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 13 Mar 2019 04:16:20 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2D4GJpH20316290
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Mar 2019 04:16:19 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0377BA405F;
 Wed, 13 Mar 2019 04:16:19 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 61C09A4054;
 Wed, 13 Mar 2019 04:16:18 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 13 Mar 2019 04:16:18 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 5385AA024A;
 Wed, 13 Mar 2019 15:16:17 +1100 (AEDT)
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: 
Subject: [PATCH 4/7] ocxl: Don't pass pci_dev around
Date: Wed, 13 Mar 2019 15:15:19 +1100
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190313041524.14644-1-alastair@au1.ibm.com>
References: <20190313041524.14644-1-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19031304-0028-0000-0000-0000035354F8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031304-0029-0000-0000-00002411DB31
Message-Id: <20190313041524.14644-5-alastair@au1.ibm.com>
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

This data is already available in a struct

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/misc/ocxl/core.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/misc/ocxl/core.c b/drivers/misc/ocxl/core.c
index b47cfda83e46..2fd0c700e8a0 100644
--- a/drivers/misc/ocxl/core.c
+++ b/drivers/misc/ocxl/core.c
@@ -66,10 +66,11 @@ static int set_afu_device(struct ocxl_afu *afu, const char *location)
 	return rc;
 }
 
-static int assign_afu_actag(struct ocxl_afu *afu, struct pci_dev *dev)
+static int assign_afu_actag(struct ocxl_afu *afu)
 {
 	struct ocxl_fn *fn = afu->fn;
 	int actag_count, actag_offset;
+	struct pci_dev *pci_dev = to_pci_dev(fn->dev.parent);
 
 	/*
 	 * if there were not enough actags for the function, each afu
@@ -79,16 +80,16 @@ static int assign_afu_actag(struct ocxl_afu *afu, struct pci_dev *dev)
 		fn->actag_enabled / fn->actag_supported;
 	actag_offset = ocxl_actag_afu_alloc(fn, actag_count);
 	if (actag_offset < 0) {
-		dev_err(&afu->dev, "Can't allocate %d actags for AFU: %d\n",
+		dev_err(&pci_dev->dev, "Can't allocate %d actags for AFU: %d\n",
 			actag_count, actag_offset);
 		return actag_offset;
 	}
 	afu->actag_base = fn->actag_base + actag_offset;
 	afu->actag_enabled = actag_count;
 
-	ocxl_config_set_afu_actag(dev, afu->config.dvsec_afu_control_pos,
+	ocxl_config_set_afu_actag(pci_dev, afu->config.dvsec_afu_control_pos,
 				afu->actag_base, afu->actag_enabled);
-	dev_dbg(&afu->dev, "actag base=%d enabled=%d\n",
+	dev_dbg(&pci_dev->dev, "actag base=%d enabled=%d\n",
 		afu->actag_base, afu->actag_enabled);
 	return 0;
 }
@@ -103,10 +104,11 @@ static void reclaim_afu_actag(struct ocxl_afu *afu)
 	ocxl_actag_afu_free(afu->fn, start_offset, size);
 }
 
-static int assign_afu_pasid(struct ocxl_afu *afu, struct pci_dev *dev)
+static int assign_afu_pasid(struct ocxl_afu *afu)
 {
 	struct ocxl_fn *fn = afu->fn;
 	int pasid_count, pasid_offset;
+	struct pci_dev *pci_dev = to_pci_dev(fn->dev.parent);
 
 	/*
 	 * We only support the case where the function configuration
@@ -115,7 +117,7 @@ static int assign_afu_pasid(struct ocxl_afu *afu, struct pci_dev *dev)
 	pasid_count = 1 << afu->config.pasid_supported_log;
 	pasid_offset = ocxl_pasid_afu_alloc(fn, pasid_count);
 	if (pasid_offset < 0) {
-		dev_err(&afu->dev, "Can't allocate %d PASIDs for AFU: %d\n",
+		dev_err(&pci_dev->dev, "Can't allocate %d PASIDs for AFU: %d\n",
 			pasid_count, pasid_offset);
 		return pasid_offset;
 	}
@@ -123,10 +125,10 @@ static int assign_afu_pasid(struct ocxl_afu *afu, struct pci_dev *dev)
 	afu->pasid_count = 0;
 	afu->pasid_max = pasid_count;
 
-	ocxl_config_set_afu_pasid(dev, afu->config.dvsec_afu_control_pos,
+	ocxl_config_set_afu_pasid(pci_dev, afu->config.dvsec_afu_control_pos,
 				afu->pasid_base,
 				afu->config.pasid_supported_log);
-	dev_dbg(&afu->dev, "PASID base=%d, enabled=%d\n",
+	dev_dbg(&pci_dev->dev, "PASID base=%d, enabled=%d\n",
 		afu->pasid_base, pasid_count);
 	return 0;
 }
@@ -172,9 +174,10 @@ static void release_fn_bar(struct ocxl_fn *fn, int bar)
 	WARN_ON(fn->bar_used[idx] < 0);
 }
 
-static int map_mmio_areas(struct ocxl_afu *afu, struct pci_dev *dev)
+static int map_mmio_areas(struct ocxl_afu *afu)
 {
 	int rc;
+	struct pci_dev *pci_dev = to_pci_dev(afu->fn->dev.parent);
 
 	rc = reserve_fn_bar(afu->fn, afu->config.global_mmio_bar);
 	if (rc)
@@ -187,10 +190,10 @@ static int map_mmio_areas(struct ocxl_afu *afu, struct pci_dev *dev)
 	}
 
 	afu->global_mmio_start =
-		pci_resource_start(dev, afu->config.global_mmio_bar) +
+		pci_resource_start(pci_dev, afu->config.global_mmio_bar) +
 		afu->config.global_mmio_offset;
 	afu->pp_mmio_start =
-		pci_resource_start(dev, afu->config.pp_mmio_bar) +
+		pci_resource_start(pci_dev, afu->config.pp_mmio_bar) +
 		afu->config.pp_mmio_offset;
 
 	afu->global_mmio_ptr = ioremap(afu->global_mmio_start,
@@ -198,7 +201,7 @@ static int map_mmio_areas(struct ocxl_afu *afu, struct pci_dev *dev)
 	if (!afu->global_mmio_ptr) {
 		release_fn_bar(afu->fn, afu->config.pp_mmio_bar);
 		release_fn_bar(afu->fn, afu->config.global_mmio_bar);
-		dev_err(&dev->dev, "Error mapping global mmio area\n");
+		dev_err(&pci_dev->dev, "Error mapping global mmio area\n");
 		return -ENOMEM;
 	}
 
@@ -234,17 +237,17 @@ static int configure_afu(struct ocxl_afu *afu, u8 afu_idx, struct pci_dev *dev)
 	if (rc)
 		return rc;
 
-	rc = assign_afu_actag(afu, dev);
+	rc = assign_afu_actag(afu);
 	if (rc)
 		return rc;
 
-	rc = assign_afu_pasid(afu, dev);
+	rc = assign_afu_pasid(afu);
 	if (rc) {
 		reclaim_afu_actag(afu);
 		return rc;
 	}
 
-	rc = map_mmio_areas(afu, dev);
+	rc = map_mmio_areas(afu);
 	if (rc) {
 		reclaim_afu_pasid(afu);
 		reclaim_afu_actag(afu);
@@ -331,7 +334,7 @@ void remove_afu(struct ocxl_afu *afu)
 	device_unregister(&afu->dev);
 }
 
-static struct ocxl_fn *alloc_function(struct pci_dev *dev)
+static struct ocxl_fn *alloc_function(void)
 {
 	struct ocxl_fn *fn;
 
@@ -342,6 +345,7 @@ static struct ocxl_fn *alloc_function(struct pci_dev *dev)
 	INIT_LIST_HEAD(&fn->afu_list);
 	INIT_LIST_HEAD(&fn->pasid_list);
 	INIT_LIST_HEAD(&fn->actag_list);
+
 	return fn;
 }
 
@@ -491,7 +495,7 @@ struct ocxl_fn *init_function(struct pci_dev *dev)
 	struct ocxl_fn *fn;
 	int rc;
 
-	fn = alloc_function(dev);
+	fn = alloc_function();
 	if (!fn)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.20.1

