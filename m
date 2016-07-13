Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqWs33lkZzDqH1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 07:18:15 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6DL91WP064350
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 17:18:14 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2455jtq63t-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 17:18:13 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 14 Jul 2016 07:18:11 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 703A73578053
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 07:18:08 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6DLI8TJ16515232
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 07:18:08 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6DLI732025183
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 07:18:08 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Huy Nguyen <huyn@mellanox.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Subject: [PATCH 12/15] cxl: Workaround PE=0 hardware limitation in Mellanox CX4
Date: Thu, 14 Jul 2016 07:17:11 +1000
In-Reply-To: <1468444634-1866-1-git-send-email-imunsie@au.ibm.com>
References: <1468444634-1866-1-git-send-email-imunsie@au.ibm.com>
Message-Id: <1468444634-1866-13-git-send-email-imunsie@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

The CX4 card cannot cope with a context with PE=0 due to a hardware
limitation, resulting in:

[   34.166577] command failed, status limits exceeded(0x8), syndrome 0x5a7939
[   34.166580] mlx5_core 0000:01:00.1: Failed allocating uar, aborting

Since the kernel API allocates a default context very early during
device init that will almost certainly get Process Element ID 0 there is
no easy way for us to extend the API to allow the Mellanox to inform us
of this limitation ahead of time.

Instead, work around the issue by extending the XSL structure to include
a minimum PE to allocate. Although the bug is not in the XSL, it is the
easiest place to work around this limitation given that the CX4 is
currently the only card that uses an XSL.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
---
 drivers/misc/cxl/context.c | 3 ++-
 drivers/misc/cxl/cxl.h     | 1 +
 drivers/misc/cxl/pci.c     | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
index 2616cddb..bdee9a0 100644
--- a/drivers/misc/cxl/context.c
+++ b/drivers/misc/cxl/context.c
@@ -90,7 +90,8 @@ int cxl_context_init(struct cxl_context *ctx, struct cxl_afu *afu, bool master,
 	 */
 	mutex_lock(&afu->contexts_lock);
 	idr_preload(GFP_KERNEL);
-	i = idr_alloc(&ctx->afu->contexts_idr, ctx, 0,
+	i = idr_alloc(&ctx->afu->contexts_idr, ctx,
+		      ctx->afu->adapter->native->sl_ops->min_pe,
 		      ctx->afu->num_procs, GFP_NOWAIT);
 	idr_preload_end();
 	mutex_unlock(&afu->contexts_lock);
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index d50cdb1..de09053 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -561,6 +561,7 @@ struct cxl_service_layer_ops {
 	u64 (*timebase_read)(struct cxl *adapter);
 	int capi_mode;
 	bool needs_reset_before_disable;
+	int min_pe;
 };
 
 struct cxl_native {
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index cb5d172..efe202f 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -1321,6 +1321,7 @@ static const struct cxl_service_layer_ops xsl_ops = {
 	.write_timebase_ctrl = write_timebase_ctrl_xsl,
 	.timebase_read = timebase_read_xsl,
 	.capi_mode = OPAL_PHB_CAPI_MODE_DMA,
+	.min_pe = 1, /* Workaround for Mellanox CX4 HW bug */
 };
 
 static void set_sl_ops(struct cxl *adapter, struct pci_dev *dev)
-- 
2.8.1
