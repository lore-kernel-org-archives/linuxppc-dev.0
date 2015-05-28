Return-Path: <felix@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9E9711A1768
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 23:13:08 +1000 (AEST)
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 959A514018C
 for <linuxppc-dev@ozlabs.org>; Thu, 28 May 2015 23:13:07 +1000 (AEST)
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Thu, 28 May 2015 14:13:04 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id A2D472190067
 for <linuxppc-dev@ozlabs.org>; Thu, 28 May 2015 14:12:40 +0100 (BST)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4SDD0VJ21233788
 for <linuxppc-dev@ozlabs.org>; Thu, 28 May 2015 13:13:00 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4SDCxX7010068
 for <linuxppc-dev@ozlabs.org>; Thu, 28 May 2015 07:13:00 -0600
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
To: mikey@neuling.org
Cc: imunsie@au1.ibm.com, linuxppc-dev@ozlabs.org, vaibhav@linux.vnet.ibm.com
Subject: [PATCH] cxl: Set up and enable PSL Timebase
Date: Thu, 28 May 2015 15:12:58 +0200
Message-Id: <1432818778-27819-1-git-send-email-felix@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch configures the PSL Timebase function and enables it,
after the CAPP has been initialized by OPAL. Failures are reported
and ignored.
---
 drivers/misc/cxl/cxl.h |    5 +++++
 drivers/misc/cxl/pci.c |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index a1cee47..38a7cf9 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -82,8 +82,10 @@ static const cxl_p1_reg_t CXL_PSL_AFUSEL  = {0x00B0};
 /* 0x00C0:7EFF Implementation dependent area */
 static const cxl_p1_reg_t CXL_PSL_FIR1      = {0x0100};
 static const cxl_p1_reg_t CXL_PSL_FIR2      = {0x0108};
+static const cxl_p1_reg_t CXL_PSL_Timebase  = {0x0110};
 static const cxl_p1_reg_t CXL_PSL_VERSION   = {0x0118};
 static const cxl_p1_reg_t CXL_PSL_RESLCKTO  = {0x0128};
+static const cxl_p1_reg_t CXL_PSL_TB_CTLSTAT = {0x0140};
 static const cxl_p1_reg_t CXL_PSL_FIR_CNTL  = {0x0148};
 static const cxl_p1_reg_t CXL_PSL_DSNDCTL   = {0x0150};
 static const cxl_p1_reg_t CXL_PSL_SNWRALLOC = {0x0158};
@@ -151,6 +153,9 @@ static const cxl_p2n_reg_t CXL_PSL_WED_An     = {0x0A0};
 #define CXL_PSL_SPAP_Size_Shift 4
 #define CXL_PSL_SPAP_V    0x0000000000000001ULL
 
+/****** CXL_PSL_Control ****************************************************/
+#define CXL_PSL_Control_tb 0x0000000000000001ULL
+
 /****** CXL_PSL_DLCNTL *****************************************************/
 #define CXL_PSL_DLCNTL_D (0x1ull << (63-28))
 #define CXL_PSL_DLCNTL_C (0x1ull << (63-29))
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index fc938de..afd89cc 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -360,6 +360,38 @@ static int init_implementation_adapter_regs(struct cxl *adapter, struct pci_dev
 	return 0;
 }
 
+#define TBSYNC_CNT(n) (((u64)n & 0x7) << (63-6))
+
+static int cxl_setup_psl_timebase(struct cxl *adapter, struct pci_dev *dev)
+{
+	u64 psl_tb;
+	int delta;
+	unsigned int retry = 0;
+
+	/*
+	 * Setup PSL Timebase Control and Status register
+	 * with the recommended Timebase Sync Count value
+	 */
+	cxl_p1_write(adapter, CXL_PSL_TB_CTLSTAT, TBSYNC_CNT(2));
+
+	/* Enable PSL Timebase */
+	cxl_p1_write(adapter, CXL_PSL_Control, CXL_PSL_Control_tb);
+	/* Wait until CORE TB and PSL TB difference <= 16usecs */
+	do {
+		if (retry++ > 5) {
+			pr_err("PSL: Timebase sync: giving up!\n");
+			return 1;
+		}
+		psl_tb = cxl_p1_read(adapter, CXL_PSL_Timebase);
+		delta = mftb() - psl_tb;
+		if (delta < 0)
+			delta = -delta;
+	} while (cputime_to_usecs(delta) > 16);
+
+	dev_info(&dev->dev, "PSL: Timebase synced\n");
+	return 0;
+}
+
 static int init_implementation_afu_regs(struct cxl_afu *afu)
 {
 	/* read/write masks for this slice */
@@ -995,6 +1027,9 @@ static struct cxl *cxl_init_adapter(struct pci_dev *dev)
 	if ((rc = pnv_phb_to_cxl(dev, OPAL_PHB_CAPI_MODE_CAPI)))
 		goto err3;
 
+	/* Don't care if this one fails: */
+	cxl_setup_psl_timebase(adapter, dev);
+
 	if ((rc = cxl_register_psl_err_irq(adapter)))
 		goto err3;
 
-- 
1.7.2.5
