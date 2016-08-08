Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7CX50rlTzDqQp
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Aug 2016 19:57:56 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u789sVDg084323
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Aug 2016 05:57:54 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24nbvvw7yu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Aug 2016 05:57:54 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Mon, 8 Aug 2016 10:57:52 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id CDCB2219005E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Aug 2016 10:57:15 +0100 (BST)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u789vocG10027284
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Aug 2016 09:57:50 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u789vnLu005736
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Aug 2016 03:57:50 -0600
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com, mikey@neuling.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] cxl: Set psl_fir_cntl to production environment value
Date: Mon,  8 Aug 2016 11:57:48 +0200
Message-Id: <1470650268-25085-1-git-send-email-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Switch the setting of psl_fir_cntl from debug to production
environment recommended value. It mostly affects the PSL behavior when
an error is raised in psl_fir1/2.

Tested with cxlflash.

Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
---
 drivers/misc/cxl/pci.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index d152e2d..4be25c4 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -379,7 +379,7 @@ static int calc_capp_routing(struct pci_dev *dev, u64 *chipid, u64 *capp_unit_id
 
 static int init_implementation_adapter_psl_regs(struct cxl *adapter, struct pci_dev *dev)
 {
-	u64 psl_dsnctl;
+	u64 psl_dsnctl, psl_fircntl;
 	u64 chipid;
 	u64 capp_unit_id;
 	int rc;
@@ -398,8 +398,11 @@ static int init_implementation_adapter_psl_regs(struct cxl *adapter, struct pci_
 	cxl_p1_write(adapter, CXL_PSL_RESLCKTO, 0x20000000200ULL);
 	/* snoop write mask */
 	cxl_p1_write(adapter, CXL_PSL_SNWRALLOC, 0x00000000FFFFFFFFULL);
-	/* set fir_accum */
-	cxl_p1_write(adapter, CXL_PSL_FIR_CNTL, 0x0800000000000000ULL);
+	/* set fir_cntl to recommended value for production env */
+	psl_fircntl = (0x2ULL << (63-3)); /* ce_report */
+	psl_fircntl |= (0x1ULL << (63-6)); /* FIR_report */
+	psl_fircntl |= 0x1ULL; /* ce_thresh */
+	cxl_p1_write(adapter, CXL_PSL_FIR_CNTL, psl_fircntl);
 	/* for debugging with trace arrays */
 	cxl_p1_write(adapter, CXL_PSL_TRACE, 0x0000FF7C00000000ULL);
 
-- 
2.7.4
