Return-Path: <felix@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 009841A0452
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 00:02:11 +1000 (AEST)
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E95D51402A3
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2015 00:02:09 +1000 (AEST)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Wed, 10 Jun 2015 15:02:05 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id BD1F42190056
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2015 15:01:41 +0100 (BST)
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
 [9.149.37.247])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5AE22TM22151342
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2015 14:02:02 GMT
Received: from d06av12.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5AE206M001219
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2015 08:02:02 -0600
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
To: mikey@neuling.org
Cc: imunsie@au1.ibm.com, linuxppc-dev@ozlabs.org, vaibhav@linux.vnet.ibm.com
Subject: [PATCH V2] cxl: Set up and enable PSL Timebase
Date: Wed, 10 Jun 2015 16:01:59 +0200
Message-Id: <1433944919-8013-1-git-send-email-felix@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch configures the PSL Timebase function and enables it,
after the CAPP has been initialized by OPAL.

V2:
 - Clear CXL_PSL_ErrIVTE_tberror bit
 - Define the sync count unit
 - Wait 1ms before each test
 - Use negative error code
 - Do not ignore errors
 - Except if timebase is not supported by OPAL
 - Be silent on success

Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
---
 drivers/misc/cxl/cxl.h |    5 ++++
 drivers/misc/cxl/pci.c |   57 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 61 insertions(+), 1 deletions(-)

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
index fc938de..ea1a79f 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -360,6 +360,55 @@ static int init_implementation_adapter_regs(struct cxl *adapter, struct pci_dev
 	return 0;
 }
 
+#define TBSYNC_CNT(n) (((u64)n & 0x7) << (63-6))
+#define _2048_250MHZ_CYCLES 1
+
+static int cxl_setup_psl_timebase(struct cxl *adapter, struct pci_dev *dev)
+{
+	u64 psl_tb;
+	int delta;
+	unsigned int retry = 0;
+	struct device_node *np;
+
+	if (!(np = pnv_pci_to_phb_node(dev)))
+		return -ENODEV;
+
+	/* Do not fail when CAPP timebase sync is not supported by OPAL */
+	of_node_get(np);
+	if (! of_get_property(np, "ibm,capp-timebase-sync", NULL)) {
+		of_node_put(np);
+		pr_err("PSL: Timebase sync: OPAL support missing\n");
+		return 0;
+	}
+	of_node_put(np);
+
+	/*
+	 * Setup PSL Timebase Control and Status register
+	 * with the recommended Timebase Sync Count value
+	 */
+	cxl_p1_write(adapter, CXL_PSL_TB_CTLSTAT,
+		     TBSYNC_CNT(2 * _2048_250MHZ_CYCLES));
+
+	/* Enable PSL Timebase */
+	cxl_p1_write(adapter, CXL_PSL_Control, 0x0000000000000000);
+	cxl_p1_write(adapter, CXL_PSL_Control, CXL_PSL_Control_tb);
+
+	/* Wait until CORE TB and PSL TB difference <= 16usecs */
+	do {
+		msleep(1);
+		if (retry++ > 5) {
+			pr_err("PSL: Timebase sync: giving up!\n");
+			return -EIO;
+		}
+		psl_tb = cxl_p1_read(adapter, CXL_PSL_Timebase);
+		delta = mftb() - psl_tb;
+		if (delta < 0)
+			delta = -delta;
+	} while (cputime_to_usecs(delta) > 16);
+
+	return 0;
+}
+
 static int init_implementation_afu_regs(struct cxl_afu *afu)
 {
 	/* read/write masks for this slice */
@@ -952,9 +1001,12 @@ static struct cxl *cxl_alloc_adapter(struct pci_dev *dev)
 	return adapter;
 }
 
+#define CXL_PSL_ErrIVTE_tberror (0x1ull << (63-31))
+
 static int sanitise_adapter_regs(struct cxl *adapter)
 {
-	cxl_p1_write(adapter, CXL_PSL_ErrIVTE, 0x0000000000000000);
+	/* Clear PSL tberror bit by writing 1 to it */
+	cxl_p1_write(adapter, CXL_PSL_ErrIVTE, CXL_PSL_ErrIVTE_tberror);
 	return cxl_tlb_slb_invalidate(adapter);
 }
 
@@ -995,6 +1047,9 @@ static struct cxl *cxl_init_adapter(struct pci_dev *dev)
 	if ((rc = pnv_phb_to_cxl(dev, OPAL_PHB_CAPI_MODE_CAPI)))
 		goto err3;
 
+	if ((rc = cxl_setup_psl_timebase(adapter, dev)))
+		goto err3;
+
 	if ((rc = cxl_register_psl_err_irq(adapter)))
 		goto err3;
 
-- 
1.7.2.5
