Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y9nxk2tRTzDr3M
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 04:56:57 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v99HskRH145081
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Oct 2017 13:56:55 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dg9k4fx3y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Oct 2017 13:56:55 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Mon, 9 Oct 2017 18:56:54 +0100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v99HuoNd17956926
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Oct 2017 17:56:51 GMT
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v99HueGu004596
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 04:56:41 +1100
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 "Alastair D'Silva" <alastair@au1.ibm.com>
Subject: [PATCH] cxl: Rename register PSL9_FIR2 to PSL9_FIR_MASK
Date: Mon,  9 Oct 2017 23:26:27 +0530
Message-Id: <20171009175627.4829-1-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PSL9 doesn't have a FIR2 register as was the case with PSL8. However
currently the register definitions in 'cxl.h' have a definition for
PSL9_FIR2 that actually points to PSL9_FIR_MASK register in the P1
area at offset 0x308.

So this patch renames the def PSL9_FIR2 to PSL9_FIR_MASK and updates
the references in the code to point to the new identifier. It also
removes the code to dump contents of FIR2 (FIR_MASK actually) in
cxl_native_irq_dump_regs_psl9().

Fixes: f24be42aab37("cxl: Add psl9 specific code")
Reported-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
 drivers/misc/cxl/cxl.h     | 2 +-
 drivers/misc/cxl/debugfs.c | 3 ++-
 drivers/misc/cxl/native.c  | 4 +---
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 0167df81df62..252373c2b861 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -104,7 +104,7 @@ static const cxl_p1_reg_t CXL_XSL9_INV      = {0x0110};
 static const cxl_p1_reg_t CXL_XSL9_DEF      = {0x0140};
 static const cxl_p1_reg_t CXL_XSL9_DSNCTL   = {0x0168};
 static const cxl_p1_reg_t CXL_PSL9_FIR1     = {0x0300};
-static const cxl_p1_reg_t CXL_PSL9_FIR2     = {0x0308};
+static const cxl_p1_reg_t CXL_PSL9_FIR_MASK = {0x0308};
 static const cxl_p1_reg_t CXL_PSL9_Timebase = {0x0310};
 static const cxl_p1_reg_t CXL_PSL9_DEBUG    = {0x0320};
 static const cxl_p1_reg_t CXL_PSL9_FIR_CNTL = {0x0348};
diff --git a/drivers/misc/cxl/debugfs.c b/drivers/misc/cxl/debugfs.c
index eae9d749f967..52e3d97db114 100644
--- a/drivers/misc/cxl/debugfs.c
+++ b/drivers/misc/cxl/debugfs.c
@@ -62,7 +62,8 @@ static struct dentry *debugfs_create_io_x64(const char *name, umode_t mode,
 void cxl_debugfs_add_adapter_regs_psl9(struct cxl *adapter, struct dentry *dir)
 {
 	debugfs_create_io_x64("fir1", S_IRUSR, dir, _cxl_p1_addr(adapter, CXL_PSL9_FIR1));
-	debugfs_create_io_x64("fir2", S_IRUSR, dir, _cxl_p1_addr(adapter, CXL_PSL9_FIR2));
+	debugfs_create_io_x64("fir_mask", 0400, dir,
+			      _cxl_p1_addr(adapter, CXL_PSL9_FIR_MASK));
 	debugfs_create_io_x64("fir_cntl", S_IRUSR, dir, _cxl_p1_addr(adapter, CXL_PSL9_FIR_CNTL));
 	debugfs_create_io_x64("trace", S_IRUSR | S_IWUSR, dir, _cxl_p1_addr(adapter, CXL_PSL9_TRACECFG));
 }
diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index 75df74d59527..6cd57c756927 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -1085,13 +1085,11 @@ static int native_get_irq_info(struct cxl_afu *afu, struct cxl_irq_info *info)
 
 void cxl_native_irq_dump_regs_psl9(struct cxl_context *ctx)
 {
-	u64 fir1, fir2, serr;
+	u64 fir1, serr;
 
 	fir1 = cxl_p1_read(ctx->afu->adapter, CXL_PSL9_FIR1);
-	fir2 = cxl_p1_read(ctx->afu->adapter, CXL_PSL9_FIR2);
 
 	dev_crit(&ctx->afu->dev, "PSL_FIR1: 0x%016llx\n", fir1);
-	dev_crit(&ctx->afu->dev, "PSL_FIR2: 0x%016llx\n", fir2);
 	if (ctx->afu->adapter->native->sl_ops->register_serr_irq) {
 		serr = cxl_p1n_read(ctx->afu, CXL_PSL_SERR_An);
 		cxl_afu_decode_psl_serr(ctx->afu, serr);
-- 
2.13.6
