Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3snsjS4LdRzDrL1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2016 06:36:11 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u93JX97I035450
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Oct 2016 15:36:09 -0400
Received: from e06smtp08.uk.ibm.com (e06smtp08.uk.ibm.com [195.75.94.104])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25upma0ber-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Oct 2016 15:36:09 -0400
Received: from localhost
 by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Mon, 3 Oct 2016 20:36:06 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id C8D7F17D8024
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Oct 2016 20:38:07 +0100 (BST)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u93Ja3B514745982
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Oct 2016 19:36:03 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u93Ja30a001221
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Oct 2016 13:36:03 -0600
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] cxl: Flush PSL cache before resetting the adapter
Date: Mon,  3 Oct 2016 21:36:02 +0200
Message-Id: <1475523362-4419-1-git-send-email-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If the capi link is going down while the PSL owns a dirty cache line,
any access from the host for that data could lead to an Unrecoverable
Error.
So when resetting the capi adapter through sysfs, make sure the PSL
cache is flushed. It won't help if there are any active Process
Elements on the card, as the cache would likely get new dirty cache
lines immediately, but if resetting an idle adapter, it should avoid
any bad surprises from data left over from terminated Process Elements.

Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
---
 drivers/misc/cxl/cxl.h    |  6 +++++-
 drivers/misc/cxl/native.c | 31 +++++++++++++++++++++++++++++++
 drivers/misc/cxl/pci.c    |  3 +++
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 344a0ff..01d372a 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -162,7 +162,10 @@ static const cxl_p2n_reg_t CXL_PSL_WED_An     = {0x0A0};
 #define CXL_PSL_SPAP_V    0x0000000000000001ULL
 
 /****** CXL_PSL_Control ****************************************************/
-#define CXL_PSL_Control_tb 0x0000000000000001ULL
+#define CXL_PSL_Control_tb              (0x1ull << (63-63))
+#define CXL_PSL_Control_Fr              (0x1ull << (63-31))
+#define CXL_PSL_Control_Fs_MASK         (0x3ull << (63-29))
+#define CXL_PSL_Control_Fs_Complete     (0x3ull << (63-29))
 
 /****** CXL_PSL_DLCNTL *****************************************************/
 #define CXL_PSL_DLCNTL_D (0x1ull << (63-28))
@@ -854,6 +857,7 @@ int cxl_register_one_irq(struct cxl *adapter, irq_handler_t handler,
 int cxl_check_error(struct cxl_afu *afu);
 int cxl_afu_slbia(struct cxl_afu *afu);
 int cxl_tlb_slb_invalidate(struct cxl *adapter);
+int cxl_data_cache_flush(struct cxl *adapter);
 int cxl_afu_disable(struct cxl_afu *afu);
 int cxl_psl_purge(struct cxl_afu *afu);
 
diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index e606fdc..a217a74 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -290,6 +290,37 @@ int cxl_tlb_slb_invalidate(struct cxl *adapter)
 	return 0;
 }
 
+int cxl_data_cache_flush(struct cxl *adapter)
+{
+	u64 reg;
+	unsigned long timeout = jiffies + (HZ * CXL_TIMEOUT);
+
+	pr_devel("Flushing data cache\n");
+
+	reg = cxl_p1_read(adapter, CXL_PSL_Control);
+	reg |= CXL_PSL_Control_Fr;
+	cxl_p1_write(adapter, CXL_PSL_Control, reg);
+
+	reg = cxl_p1_read(adapter, CXL_PSL_Control);
+	while ((reg & CXL_PSL_Control_Fs_MASK) != CXL_PSL_Control_Fs_Complete) {
+		if (time_after_eq(jiffies, timeout)) {
+			dev_warn(&adapter->dev, "WARNING: cache flush timed out!\n");
+			return -EBUSY;
+		}
+
+		if (!cxl_ops->link_ok(adapter, NULL)) {
+			dev_warn(&adapter->dev, "WARNING: link down when flushing cache\n");
+			return -EIO;
+		}
+		cpu_relax();
+		reg = cxl_p1_read(adapter, CXL_PSL_Control);
+	}
+
+	reg &= ~CXL_PSL_Control_Fr;
+	cxl_p1_write(adapter, CXL_PSL_Control, reg);
+	return 0;
+}
+
 static int cxl_write_sstp(struct cxl_afu *afu, u64 sstp0, u64 sstp1)
 {
 	int rc;
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 6f0c4ac..731e2e2 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -1239,6 +1239,9 @@ int cxl_pci_reset(struct cxl *adapter)
 
 	dev_info(&dev->dev, "CXL reset\n");
 
+	/* the adapter is about to be reset, so ignore errors */
+	cxl_data_cache_flush(adapter);
+
 	/* pcie_warm_reset requests a fundamental pci reset which includes a
 	 * PERST assert/deassert.  PERST triggers a loading of the image
 	 * if "user" or "factory" is selected in sysfs */
-- 
2.7.4
