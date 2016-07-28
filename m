Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s0LNf5cWVzDrQ2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 15:42:42 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6S5dBPd043054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 01:42:40 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24eatkbeq7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 01:42:39 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 28 Jul 2016 15:42:36 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 33EB12BB005D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 15:42:33 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6S5gXvt29753384
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 15:42:33 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6S5gW0x004376
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 15:42:33 +1000
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Cc: imunsie@au1.ibm.com, fbarrat@linux.vnet.ibm.com, huyn@mellanox.com
Subject: [PATCH] cxl: fix NULL dereference in cxl_context_init() on PowerVM
 guests
Date: Thu, 28 Jul 2016 15:39:41 +1000
Message-Id: <1469684381-22354-1-git-send-email-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit f67a6722d650 ("cxl: Workaround PE=0 hardware limitation in Mellanox
CX4") added a "min_pe" field to struct cxl_service_layer_ops, to allow us
to work around a Mellanox CX-4 hardware limitation.

When allocating the PE number in cxl_context_init(), we read from
ctx->afu->adapter->native->sl_ops->min_pe to get the minimum PE number.
Unsurprisingly, in a PowerVM guest ctx->afu->adapter->native is NULL, and
guests don't have a cxl_service_layer_ops struct anywhere.

Move min_pe from struct cxl_service_layer_ops to struct cxl so it's
accessible in both native and PowerVM environments. For the Mellanox CX-4,
set the min_pe value in set_sl_ops().

Fixes: f67a6722d650 ("cxl: Workaround PE=0 hardware limitation in Mellanox CX4")
Reported-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
---
 drivers/misc/cxl/context.c | 3 +--
 drivers/misc/cxl/cxl.h     | 2 +-
 drivers/misc/cxl/pci.c     | 3 ++-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
index bdee9a0..c466ee2 100644
--- a/drivers/misc/cxl/context.c
+++ b/drivers/misc/cxl/context.c
@@ -90,8 +90,7 @@ int cxl_context_init(struct cxl_context *ctx, struct cxl_afu *afu, bool master,
 	 */
 	mutex_lock(&afu->contexts_lock);
 	idr_preload(GFP_KERNEL);
-	i = idr_alloc(&ctx->afu->contexts_idr, ctx,
-		      ctx->afu->adapter->native->sl_ops->min_pe,
+	i = idr_alloc(&ctx->afu->contexts_idr, ctx, ctx->afu->adapter->min_pe,
 		      ctx->afu->num_procs, GFP_NOWAIT);
 	idr_preload_end();
 	mutex_unlock(&afu->contexts_lock);
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 19b132f..76f8b94 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -549,7 +549,6 @@ struct cxl_service_layer_ops {
 	u64 (*timebase_read)(struct cxl *adapter);
 	int capi_mode;
 	bool needs_reset_before_disable;
-	int min_pe;
 };
 
 struct cxl_native {
@@ -591,6 +590,7 @@ struct cxl {
 	struct bin_attribute cxl_attr;
 	int adapter_num;
 	int user_irqs;
+	int min_pe;
 	u64 ps_size;
 	u16 psl_rev;
 	u16 base_image;
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 3c8d0d2..bbf5fc9 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -1552,14 +1552,15 @@ static const struct cxl_service_layer_ops xsl_ops = {
 	.write_timebase_ctrl = write_timebase_ctrl_xsl,
 	.timebase_read = timebase_read_xsl,
 	.capi_mode = OPAL_PHB_CAPI_MODE_DMA,
-	.min_pe = 1, /* Workaround for Mellanox CX4 HW bug */
 };
 
 static void set_sl_ops(struct cxl *adapter, struct pci_dev *dev)
 {
 	if (dev->vendor == PCI_VENDOR_ID_MELLANOX && dev->device == 0x1013) {
+		/* Mellanox CX-4 */
 		dev_info(&adapter->dev, "Device uses an XSL\n");
 		adapter->native->sl_ops = &xsl_ops;
+		adapter->min_pe = 1; /* Workaround for CX-4 hardware bug */
 	} else {
 		dev_info(&adapter->dev, "Device uses a PSL\n");
 		adapter->native->sl_ops = &psl_ops;
-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
