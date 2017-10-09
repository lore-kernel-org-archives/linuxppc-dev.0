Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y9nzQ41c4zDr5w
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 04:58:26 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v99HsGA4027823
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Oct 2017 13:58:24 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dgd10u4gf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Oct 2017 13:58:24 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Mon, 9 Oct 2017 18:58:21 +0100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v99HwIQI11665614
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Oct 2017 17:58:19 GMT
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v99HwA5T024695
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 04:58:11 +1100
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 "Alastair D'Silva" <alastair@au1.ibm.com>
Subject: [PATCH] cxl: Dump PSL_FIR register on PSL9 error irq
Date: Mon,  9 Oct 2017 23:28:11 +0530
Message-Id: <20171009175811.5266-1-vaibhav@linux.vnet.ibm.com>
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

This patch fixes issue by updating the cxl_native_err_irq_dump_regs()
to dump the PSL_FIR registers on a PSL error interrupt thereby
bringing the behavior in line with PSL on POWER-8.

Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
 drivers/misc/cxl/native.c | 17 ++++++++++++++---
 drivers/misc/cxl/pci.c    |  1 +
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index 6cd57c756927..fa143bad9b55 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -1267,10 +1267,21 @@ void cxl_native_err_irq_dump_regs(struct cxl *adapter)
 {
 	u64 fir1, fir2;
 
-	fir1 = cxl_p1_read(adapter, CXL_PSL_FIR1);
-	fir2 = cxl_p1_read(adapter, CXL_PSL_FIR2);
+	if (cxl_is_power8()) {
+		fir1 = cxl_p1_read(adapter, CXL_PSL_FIR1);
+		fir2 = cxl_p1_read(adapter, CXL_PSL_FIR2);
+		dev_crit(&adapter->dev,
+			 "PSL_FIR1: 0x%016llx\nPSL_FIR2: 0x%016llx\n",
+			 fir1, fir2);
+
+	} else if (cxl_is_power9()) {
+		fir1 = cxl_p1_read(adapter, CXL_PSL9_FIR1);
+		dev_crit(&adapter->dev, "PSL_FIR: 0x%016llx\n", fir1);
+
+	} else {
+		WARN_ON(1);
+	}
 
-	dev_crit(&adapter->dev, "PSL_FIR1: 0x%016llx\nPSL_FIR2: 0x%016llx\n", fir1, fir2);
 }
 
 static irqreturn_t native_irq_err(int irq, void *data)
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index b4ce9ea113a9..d9d6777fa853 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -1763,6 +1763,7 @@ static const struct cxl_service_layer_ops psl9_ops = {
 	.debugfs_add_adapter_regs = cxl_debugfs_add_adapter_regs_psl9,
 	.debugfs_add_afu_regs = cxl_debugfs_add_afu_regs_psl9,
 	.psl_irq_dump_registers = cxl_native_irq_dump_regs_psl9,
+	.err_irq_dump_registers = cxl_native_err_irq_dump_regs,
 	.debugfs_stop_trace = cxl_stop_trace_psl9,
 	.write_timebase_ctrl = write_timebase_ctrl_psl9,
 	.timebase_read = timebase_read_psl9,
-- 
2.13.6
