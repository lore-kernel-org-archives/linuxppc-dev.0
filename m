Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spGCc2z4nzDrFn
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2016 22:00:12 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u94AvbDP046252
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Oct 2016 07:00:09 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25v8ypg4ps-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Oct 2016 07:00:09 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Tue, 4 Oct 2016 12:00:07 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 36B63219004D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2016 11:59:24 +0100 (BST)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u94B05Zg12976570
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Oct 2016 11:00:05 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u94B05xX031365
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Oct 2016 05:00:05 -0600
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] cxl: Flush PSL cache before resetting the adapter
Date: Tue,  4 Oct 2016 13:00:04 +0200
Message-Id: <1475578804-13073-1-git-send-email-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If the capi link is going down while the PSL owns a dirty cache line,
any access from the host for that data could lead to an Uncorrectable
Error.
So when resetting the capi adapter through sysfs, make sure the PSL
cache is flushed. It won't help if there are any active Process
Elements on the card, as the cache would likely get new dirty cache
lines immediately, but if resetting an idle adapter, it should avoid
any bad surprises from data left over from terminated Process Elements.

Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
---
Changelog:
v2:
  - fix typo in commit message
  - use ETIMEDOUT instead of EBUSY when the psl doesn't ack the flush request
  
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
index e606fdc..13b9d01 100644
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
+			return -ETIMEDOUT;
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
