Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yBkH23Vw0zDr6N
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 17:15:10 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9B6Dwx6065434
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 02:15:07 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dhcwnjepn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 02:15:07 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Wed, 11 Oct 2017 07:15:05 +0100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v9B6F0qG24248490
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 06:15:02 GMT
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v9B6F4S4003880
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 17:15:04 +1100
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 "Alastair D'Silva" <alastair@au1.ibm.com>
Subject: [PATCH v2] cxl: Dump PSL_FIR register on PSL9 error irq
Date: Wed, 11 Oct 2017 11:44:41 +0530
Message-Id: <20171011061441.16795-1-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For PSL9 currently we aren't dumping the PSL FIR register when a
PSL error interrupt is triggered. Contents of this register are useful
in debugging AFU issues.

This patch fixes issue by adding a new service_layer_ops callback
cxl_native_err_irq_dump_regs_psl9() to dump the PSL_FIR registers on a
PSL error interrupt thereby bringing the behavior in line with PSL on
POWER-8. Also the existing service_layer_ops callback
for PSL8 has been renamed to cxl_native_err_irq_dump_regs_psl8().

Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
Changelog:
[v2] -> As created a different function to dump the FIR register for PSL9 (Fred)
---

 drivers/misc/cxl/cxl.h    |  3 ++-
 drivers/misc/cxl/native.c | 15 ++++++++++++---
 drivers/misc/cxl/pci.c    |  3 ++-
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 252373c2b861..111c689b1771 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -1072,7 +1072,8 @@ u64 cxl_calculate_sr(bool master, bool kernel, bool real_mode, bool p9);
 
 void cxl_native_irq_dump_regs_psl9(struct cxl_context *ctx);
 void cxl_native_irq_dump_regs_psl8(struct cxl_context *ctx);
-void cxl_native_err_irq_dump_regs(struct cxl *adapter);
+void cxl_native_err_irq_dump_regs_psl8(struct cxl *adapter);
+void cxl_native_err_irq_dump_regs_psl9(struct cxl *adapter);
 int cxl_pci_vphb_add(struct cxl_afu *afu);
 void cxl_pci_vphb_remove(struct cxl_afu *afu);
 void cxl_release_mapping(struct cxl_context *ctx);
diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index 6cd57c756927..02b6b45b4c20 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -1263,14 +1263,23 @@ static irqreturn_t native_slice_irq_err(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-void cxl_native_err_irq_dump_regs(struct cxl *adapter)
+void cxl_native_err_irq_dump_regs_psl9(struct cxl *adapter)
+{
+	u64 fir1;
+
+	fir1 = cxl_p1_read(adapter, CXL_PSL9_FIR1);
+	dev_crit(&adapter->dev, "PSL_FIR: 0x%016llx\n", fir1);
+}
+
+void cxl_native_err_irq_dump_regs_psl8(struct cxl *adapter)
 {
 	u64 fir1, fir2;
 
 	fir1 = cxl_p1_read(adapter, CXL_PSL_FIR1);
 	fir2 = cxl_p1_read(adapter, CXL_PSL_FIR2);
-
-	dev_crit(&adapter->dev, "PSL_FIR1: 0x%016llx\nPSL_FIR2: 0x%016llx\n", fir1, fir2);
+	dev_crit(&adapter->dev,
+		 "PSL_FIR1: 0x%016llx\nPSL_FIR2: 0x%016llx\n",
+		 fir1, fir2);
 }
 
 static irqreturn_t native_irq_err(int irq, void *data)
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index b4ce9ea113a9..d185b47eb536 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -1763,6 +1763,7 @@ static const struct cxl_service_layer_ops psl9_ops = {
 	.debugfs_add_adapter_regs = cxl_debugfs_add_adapter_regs_psl9,
 	.debugfs_add_afu_regs = cxl_debugfs_add_afu_regs_psl9,
 	.psl_irq_dump_registers = cxl_native_irq_dump_regs_psl9,
+	.err_irq_dump_registers = cxl_native_err_irq_dump_regs_psl9,
 	.debugfs_stop_trace = cxl_stop_trace_psl9,
 	.write_timebase_ctrl = write_timebase_ctrl_psl9,
 	.timebase_read = timebase_read_psl9,
@@ -1786,7 +1787,7 @@ static const struct cxl_service_layer_ops psl8_ops = {
 	.debugfs_add_adapter_regs = cxl_debugfs_add_adapter_regs_psl8,
 	.debugfs_add_afu_regs = cxl_debugfs_add_afu_regs_psl8,
 	.psl_irq_dump_registers = cxl_native_irq_dump_regs_psl8,
-	.err_irq_dump_registers = cxl_native_err_irq_dump_regs,
+	.err_irq_dump_registers = cxl_native_err_irq_dump_regs_psl8,
 	.debugfs_stop_trace = cxl_stop_trace_psl8,
 	.write_timebase_ctrl = write_timebase_ctrl_psl8,
 	.timebase_read = timebase_read_psl8,
-- 
2.13.6
