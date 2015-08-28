Return-Path: <felix@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 987831A0144
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2015 17:36:29 +1000 (AEST)
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 839E714016A
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2015 17:36:27 +1000 (AEST)
Received: from /spool/local
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Fri, 28 Aug 2015 08:36:24 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 361C91B0805F
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2015 08:37:53 +0100 (BST)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
 [9.149.37.228])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7S7aHtX33685700
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2015 07:36:20 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7S7a7q0015309
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2015 01:36:08 -0600
Message-ID: <55E00FC0.5090906@linux.vnet.ibm.com>
Date: Fri, 28 Aug 2015 09:37:36 +0200
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
MIME-Version: 1.0
To: mpe@ellerman.id.au
CC: imunsie@au1.ibm.com, mikey@neuling.org, linuxppc-dev@ozlabs.org
Subject: [PATCH][RESEND] cxl: Set up and enable PSL Timebase
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Acked-by: Ian Munsie <imunsie@au1.ibm.com>
Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
---
  drivers/misc/cxl/cxl.h |  5 +++++
  drivers/misc/cxl/pci.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++-
  2 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index e7af256..19489c6 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -83,8 +83,10 @@ static const cxl_p1_reg_t CXL_PSL_AFUSEL  = {0x00B0};
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
@@ -152,6 +154,9 @@ static const cxl_p2n_reg_t CXL_PSL_WED_An     = {0x0A0};
  #define CXL_PSL_SPAP_Size_Shift 4
  #define CXL_PSL_SPAP_V    0x0000000000000001ULL

+/****** CXL_PSL_Control ****************************************************/
+#define CXL_PSL_Control_tb 0x0000000000000001ULL
+
  /****** CXL_PSL_DLCNTL *****************************************************/
  #define CXL_PSL_DLCNTL_D (0x1ull << (63-28))
  #define CXL_PSL_DLCNTL_C (0x1ull << (63-29))
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 03ddb2d..0f2ba4a 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -370,6 +370,55 @@ static int init_implementation_adapter_regs(struct cxl *adapter, struct pci_dev
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
+	if (!(np = pnv_pci_get_phb_node(dev)))
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
@@ -1069,9 +1118,12 @@ err1:
  	return NULL;
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

@@ -1124,6 +1176,9 @@ static int cxl_configure_adapter(struct cxl *adapter, struct pci_dev *dev)
  	if ((rc = pnv_phb_to_cxl_mode(dev, OPAL_PHB_CAPI_MODE_SNOOP_ON)))
  		goto err;

+	if ((rc = cxl_setup_psl_timebase(adapter, dev)))
+		goto err;
+
  	if ((rc = cxl_register_psl_err_irq(adapter)))
  		goto err;

-- 
2.1.0
