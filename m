Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcrCG0zfFzDqZw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 00:58:17 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7NEunmh064129
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 10:58:16 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2chb4mk213-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 10:58:15 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Wed, 23 Aug 2017 15:58:12 +0100
From: Christophe Lombard <clombard@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 vaibhav@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com
Subject: [PATCH] cxl: Add support for POWER9 DD2
Date: Wed, 23 Aug 2017 16:58:06 +0200
Message-Id: <1503500286-1684-1-git-send-email-clombard@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PSL initialization sequence has been updated to DD2.
This patch adapts to the changes, retaining compatibility with DD1.

Tests performed on some of the new hardware.

Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
---
 drivers/misc/cxl/cxl.h |  2 ++
 drivers/misc/cxl/pci.c | 57 +++++++++++++++++++++++++++++++-------------------
 2 files changed, 38 insertions(+), 21 deletions(-)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index b1afecc..0167df8 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -100,6 +100,8 @@ static const cxl_p1_reg_t CXL_XSL_FEC       = {0x0158};
 static const cxl_p1_reg_t CXL_XSL_DSNCTL    = {0x0168};
 /* PSL registers - CAIA 2 */
 static const cxl_p1_reg_t CXL_PSL9_CONTROL  = {0x0020};
+static const cxl_p1_reg_t CXL_XSL9_INV      = {0x0110};
+static const cxl_p1_reg_t CXL_XSL9_DEF      = {0x0140};
 static const cxl_p1_reg_t CXL_XSL9_DSNCTL   = {0x0168};
 static const cxl_p1_reg_t CXL_PSL9_FIR1     = {0x0300};
 static const cxl_p1_reg_t CXL_PSL9_FIR2     = {0x0308};
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index d18b3d9..a981c65 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -475,37 +475,52 @@ static int init_implementation_adapter_regs_psl9(struct cxl *adapter,
 	psl_fircntl |= 0x1ULL; /* ce_thresh */
 	cxl_p1_write(adapter, CXL_PSL9_FIR_CNTL, psl_fircntl);
 
-	/* vccredits=0x1  pcklat=0x4 */
-	cxl_p1_write(adapter, CXL_PSL9_DSNDCTL, 0x0000000000001810ULL);
-
-	/*
-	 * For debugging with trace arrays.
-	 * Configure RX trace 0 segmented mode.
-	 * Configure CT trace 0 segmented mode.
-	 * Configure LA0 trace 0 segmented mode.
-	 * Configure LA1 trace 0 segmented mode.
+	/* Setup the PSL to transmit packets on the PCIe before the
+	 * CAPP is enabled
 	 */
-	cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0x8040800080000000ULL);
-	cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0x8040800080000003ULL);
-	cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0x8040800080000005ULL);
-	cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0x8040800080000006ULL);
+	cxl_p1_write(adapter, CXL_PSL9_DSNDCTL, 0x0001001000002A10ULL);
+
+	/* For debugging with trace arrays */
+	/* Configure RX trace 0 segmented mode */
+	cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0x8200000000000000ULL);
+	/* Configure RX trace 1 segmented mode */
+	cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0xAA00000000000001ULL);
+	/* Configure CT trace 0 segmented mode */
+	cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0xA2B8000000000003ULL);
+	/* Configure LA0 trace 0 segmented mode */
+	cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0x83FFC00000000005ULL);
+	/* Configure JM0 trace 0 segmented mode */
+	cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0x8200000000000007ULL);
+	/* Configure DMA trace 0 segmented mode */
+	cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0x8200000000000008ULL);
+	/* Configure DMA trace 1 segmented mode */
+	cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0x8200000000000009ULL);
 
 	/*
 	 * A response to an ASB_Notify request is returned by the
 	 * system as an MMIO write to the address defined in
 	 * the PSL_TNR_ADDR register
 	 */
-	/* PSL_TNR_ADDR */
+	/* keep the Reset Value: 0x00020000E0000000 */
+
+	/* Enable XSL rty limit */
+	cxl_p1_write(adapter, CXL_XSL9_DEF, 0x51F8000000000005ULL);
 
-	/* NORST */
-	cxl_p1_write(adapter, CXL_PSL9_DEBUG, 0x8000000000000000ULL);
+	/* Change XSL_INV dummy readtheshold */
+	cxl_p1_write(adapter, CXL_XSL9_INV, 0x0000040007FFC200ULL);
 
-	/* allocate the apc machines */
-	cxl_p1_write(adapter, CXL_PSL9_APCDEDTYPE, 0x40000003FFFF0000ULL);
+	if (phb_index == 3) {
+		/* disable machines 31-47 and 20-27 for DMA */
+		cxl_p1_write(adapter, CXL_PSL9_APCDEDTYPE, 0x40000FF3FFFF0000ULL);
+	}
+
+	/* Snoop machines */
+	cxl_p1_write(adapter, CXL_PSL9_APCDEDALLOC, 0x800F000200000000ULL);
 
-	/* Disable vc dd1 fix */
-	if (cxl_is_power9_dd1())
-		cxl_p1_write(adapter, CXL_PSL9_GP_CT, 0x0400000000000001ULL);
+	if (cxl_is_power9_dd1()) {
+		/* Disabling deadlock counter CAR */
+		cxl_p1_write(adapter, CXL_PSL9_GP_CT, 0x0020000000000001ULL);
+	}
 
 	return 0;
 }
-- 
2.7.4
