Return-Path: <SRS0=tR2X=R4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E12C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 05:42:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ABD82085A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 05:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ABD82085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44SNSf0HRdzDqKK
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 16:42:26 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44SNJw4rJPzDqHS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 16:35:44 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2P5Z91A152462
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 01:35:42 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2reqdxuedf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 01:35:42 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alastair@au1.ibm.com>;
 Mon, 25 Mar 2019 05:35:40 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 25 Mar 2019 05:35:37 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2P5ZaC354001784
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Mar 2019 05:35:36 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B62D4C04A;
 Mon, 25 Mar 2019 05:35:36 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 69F534C044;
 Mon, 25 Mar 2019 05:35:35 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 25 Mar 2019 05:35:35 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 5DBA1A030E;
 Mon, 25 Mar 2019 16:35:34 +1100 (AEDT)
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: alastair@d-silva.org
Subject: [PATCH v4 4/4] ocxl: Remove some unused exported symbols
Date: Mon, 25 Mar 2019 16:34:55 +1100
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190325053456.14599-1-alastair@au1.ibm.com>
References: <20190320053448.2098-1-alastair@au1.ibm.com>
 <20190325053456.14599-1-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19032505-0008-0000-0000-000002D11AE2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032505-0009-0000-0000-0000223D40FC
Message-Id: <20190325053456.14599-5-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-25_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=811 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903250043
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

Remove some unused exported symbols.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/misc/ocxl/config.c        |  4 +---
 drivers/misc/ocxl/ocxl_internal.h | 23 +++++++++++++++++++++++
 include/misc/ocxl.h               | 23 -----------------------
 3 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/misc/ocxl/config.c b/drivers/misc/ocxl/config.c
index 4dc11897237d..5e65acb8e134 100644
--- a/drivers/misc/ocxl/config.c
+++ b/drivers/misc/ocxl/config.c
@@ -2,8 +2,8 @@
 // Copyright 2017 IBM Corp.
 #include <linux/pci.h>
 #include <asm/pnv-ocxl.h>
-#include <misc/ocxl.h>
 #include <misc/ocxl-config.h>
+#include "ocxl_internal.h"
 
 #define EXTRACT_BIT(val, bit) (!!(val & BIT(bit)))
 #define EXTRACT_BITS(val, s, e) ((val & GENMASK(e, s)) >> s)
@@ -299,7 +299,6 @@ int ocxl_config_check_afu_index(struct pci_dev *dev,
 	}
 	return 1;
 }
-EXPORT_SYMBOL_GPL(ocxl_config_check_afu_index);
 
 static int read_afu_name(struct pci_dev *dev, struct ocxl_fn_config *fn,
 			struct ocxl_afu_config *afu)
@@ -535,7 +534,6 @@ int ocxl_config_get_pasid_info(struct pci_dev *dev, int *count)
 {
 	return pnv_ocxl_get_pasid_count(dev, count);
 }
-EXPORT_SYMBOL_GPL(ocxl_config_get_pasid_info);
 
 void ocxl_config_set_afu_pasid(struct pci_dev *dev, int pos, int pasid_base,
 			u32 pasid_count_log)
diff --git a/drivers/misc/ocxl/ocxl_internal.h b/drivers/misc/ocxl/ocxl_internal.h
index 321b29e77f45..06fd98c989c8 100644
--- a/drivers/misc/ocxl/ocxl_internal.h
+++ b/drivers/misc/ocxl/ocxl_internal.h
@@ -107,6 +107,29 @@ void ocxl_pasid_afu_free(struct ocxl_fn *fn, u32 start, u32 size);
 int ocxl_actag_afu_alloc(struct ocxl_fn *fn, u32 size);
 void ocxl_actag_afu_free(struct ocxl_fn *fn, u32 start, u32 size);
 
+/*
+ * Get the max PASID value that can be used by the function
+ */
+int ocxl_config_get_pasid_info(struct pci_dev *dev, int *count);
+
+/*
+ * Check if an AFU index is valid for the given function.
+ *
+ * AFU indexes can be sparse, so a driver should check all indexes up
+ * to the maximum found in the function description
+ */
+int ocxl_config_check_afu_index(struct pci_dev *dev,
+				struct ocxl_fn_config *fn, int afu_idx);
+
+/**
+ * Update values within a Process Element
+ *
+ * link_handle: the link handle associated with the process element
+ * pasid: the PASID for the AFU context
+ * tid: the new thread id for the process element
+ */
+int ocxl_link_update_pe(void *link_handle, int pasid, __u16 tid);
+
 struct ocxl_context *ocxl_context_alloc(void);
 int ocxl_context_init(struct ocxl_context *ctx, struct ocxl_afu *afu,
 			struct address_space *mapping);
diff --git a/include/misc/ocxl.h b/include/misc/ocxl.h
index 4544573cc93c..9530d3be1b30 100644
--- a/include/misc/ocxl.h
+++ b/include/misc/ocxl.h
@@ -56,15 +56,6 @@ struct ocxl_fn_config {
 int ocxl_config_read_function(struct pci_dev *dev,
 				struct ocxl_fn_config *fn);
 
-/*
- * Check if an AFU index is valid for the given function.
- *
- * AFU indexes can be sparse, so a driver should check all indexes up
- * to the maximum found in the function description
- */
-int ocxl_config_check_afu_index(struct pci_dev *dev,
-				struct ocxl_fn_config *fn, int afu_idx);
-
 /*
  * Read the configuration space of a function for the AFU specified by
  * the index 'afu_idx'. Fills in a ocxl_afu_config structure
@@ -74,11 +65,6 @@ int ocxl_config_read_afu(struct pci_dev *dev,
 				struct ocxl_afu_config *afu,
 				u8 afu_idx);
 
-/*
- * Get the max PASID value that can be used by the function
- */
-int ocxl_config_get_pasid_info(struct pci_dev *dev, int *count);
-
 /*
  * Tell an AFU, by writing in the configuration space, the PASIDs that
  * it can use. Range starts at 'pasid_base' and its size is a multiple
@@ -188,15 +174,6 @@ int ocxl_link_add_pe(void *link_handle, int pasid, u32 pidr, u32 tidr,
 		void (*xsl_err_cb)(void *data, u64 addr, u64 dsisr),
 		void *xsl_err_data);
 
-/**
- * Update values within a Process Element
- *
- * link_handle: the link handle associated with the process element
- * pasid: the PASID for the AFU context
- * tid: the new thread id for the process element
- */
-int ocxl_link_update_pe(void *link_handle, int pasid, __u16 tid);
-
 /*
  * Remove a Process Element from the Shared Process Area for a link
  */
-- 
2.20.1

