Return-Path: <SRS0=E5N6=QB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3471EC282C0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 05:16:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACA24218CD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 05:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA24218CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43m6gg5v4bzDqMm
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 16:16:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43m6Zg2vjpzDqMK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2019 16:11:55 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0P59S7m118479
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2019 00:11:52 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2q7v0cr7ey-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2019 00:11:52 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.ibm.com>;
 Fri, 25 Jan 2019 05:11:50 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 25 Jan 2019 05:11:47 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0P5Bkik3867130
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Jan 2019 05:11:46 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E6D575204E;
 Fri, 25 Jan 2019 05:11:45 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.109.223.28])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 314D052050;
 Fri, 25 Jan 2019 05:11:44 +0000 (GMT)
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Frederic Barrat <fbarrat@linux.ibm.com>
Subject: [RFC PATCH 2/2] cxl: Force a CAPP reset when unloading CXL module
Date: Fri, 25 Jan 2019 10:41:31 +0530
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125051131.29351-1-vaibhav@linux.ibm.com>
References: <20190125051131.29351-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19012505-4275-0000-0000-00000303EA30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012505-4276-0000-0000-000038122457
Message-Id: <20190125051131.29351-3-vaibhav@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-25_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901250040
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
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>,
 Alastair D'Silva <alastair@linux.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch forces shutdown of CAPP when CXL module is unloaded. This
is accomplished via a call to pnv_phb_to_cxl_mode() with mode ==
OPAL_PHB_CAPI_MODE_PCIE.

Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 drivers/misc/cxl/cxl.h  |  1 +
 drivers/misc/cxl/main.c |  3 +++
 drivers/misc/cxl/pci.c  | 25 ++++++++++++++++++++++++-
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index d1d927ccb589..e545c2b81faf 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -1136,4 +1136,5 @@ void cxl_context_mm_count_get(struct cxl_context *ctx);
 /* Decrements the reference count to "struct mm_struct" */
 void cxl_context_mm_count_put(struct cxl_context *ctx);
 
+void cxl_pci_shutdown_capp(void);
 #endif
diff --git a/drivers/misc/cxl/main.c b/drivers/misc/cxl/main.c
index f35406be465a..f14ff0dcf231 100644
--- a/drivers/misc/cxl/main.c
+++ b/drivers/misc/cxl/main.c
@@ -372,6 +372,9 @@ static void exit_cxl(void)
 	if (cxl_is_power8())
 		unregister_cxl_calls(&cxl_calls);
 	idr_destroy(&cxl_adapter_idr);
+
+	if (cpu_has_feature(CPU_FTR_HVMODE))
+		cxl_pci_shutdown_capp();
 }
 
 module_init(init_cxl);
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index c79ba1c699ad..01be2e2d1069 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -25,7 +25,7 @@
 
 #include "cxl.h"
 #include <misc/cxl.h>
-
+#include <misc/cxllib.h>
 
 #define CXL_PCI_VSEC_ID	0x1280
 #define CXL_VSEC_MIN_SIZE 0x80
@@ -2065,6 +2065,29 @@ static void cxl_pci_resume(struct pci_dev *pdev)
 	}
 }
 
+void cxl_pci_shutdown_capp(void)
+{
+	struct pci_dev *pdev;
+	struct pci_bus *root_bus;
+	int rc;
+
+	/* Iterate over all CAPP supported PHB's and force them to PCI mode */
+	list_for_each_entry(root_bus, &pci_root_buses, node) {
+		for_each_pci_bridge(pdev, root_bus) {
+
+			if (!cxllib_slot_is_supported(pdev, 0))
+				continue;
+
+			rc = pnv_phb_to_cxl_mode(pdev,
+						 OPAL_PHB_CAPI_MODE_PCIE);
+			if (rc)
+				dev_err(&pdev->dev,
+					"cxl: Error resetting CAPP. Err=%d\n",
+					rc);
+		}
+	}
+}
+
 static const struct pci_error_handlers cxl_err_handler = {
 	.error_detected = cxl_pci_error_detected,
 	.slot_reset = cxl_pci_slot_reset,
-- 
2.20.1

