Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfsGZ0XVwzDqxS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 04:51:49 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5TIhuWJ033195
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 14:51:46 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23uw5qeg0q-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 14:51:46 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 30 Jun 2016 04:51:42 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 56C942CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 04:51:40 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5TIpeBa10289434
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 04:51:40 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5TIpdEV029020
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 04:51:40 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, mikey <mikey@neuling.org>,
 linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Huy Nguyen <huyn@mellanox.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Subject: [PATCH 1/2] cxl: Fix bug where AFU disable operation had no effect
Date: Thu, 30 Jun 2016 04:51:25 +1000
Message-Id: <1467226286-28547-1-git-send-email-imunsie@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

The AFU disable operation has a bug where it will not clear the enable
bit and therefore will have no effect. To date this has likely been
masked by fact that we perform an AFU reset before the disable, which
also has the effect of clearing the enable bit, making the following
disable operation effectively a noop on most hardware. This patch
modifies the afu_control function to take a parameter to clear from the
AFU control register so that the disable operation can clear the
appropriate bit.

This bug was uncovered on the Mellanox CX4, which uses an XSL rather
than a PSL. On the XSL the reset operation will not complete while the
AFU is enabled, meaning the enable bit was still set at the start of the
disable and as a result this bug was hit and the disable also timed out.

Because of this difference in behaviour between the PSL and XSL, this
patch now makes the reset dependent on the card using a PSL to avoid
waiting for a timeout on the XSL. It is entirely possible that we may be
able to drop the reset altogether if it turns out we only ever needed it
due to this bug - however I am not willing to drop it without further
regression testing.

This also fixes a small issue where the AFU_Cntl register was read
outside of the lock that protects it.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/cxl.h    |  1 +
 drivers/misc/cxl/native.c | 36 ++++++++++++++++++++++++++++--------
 drivers/misc/cxl/pci.c    |  1 +
 3 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index ce2b9d5..bab8dfd 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -544,6 +544,7 @@ struct cxl_service_layer_ops {
 	void (*write_timebase_ctrl)(struct cxl *adapter);
 	u64 (*timebase_read)(struct cxl *adapter);
 	int capi_mode;
+	bool needs_reset_before_disable;
 };
 
 struct cxl_native {
diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index 120c468..9479bfc 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -21,10 +21,10 @@
 #include "cxl.h"
 #include "trace.h"
 
-static int afu_control(struct cxl_afu *afu, u64 command,
+static int afu_control(struct cxl_afu *afu, u64 command, u64 clear,
 		       u64 result, u64 mask, bool enabled)
 {
-	u64 AFU_Cntl = cxl_p2n_read(afu, CXL_AFU_Cntl_An);
+	u64 AFU_Cntl;
 	unsigned long timeout = jiffies + (HZ * CXL_TIMEOUT);
 	int rc = 0;
 
@@ -33,7 +33,8 @@ static int afu_control(struct cxl_afu *afu, u64 command,
 
 	trace_cxl_afu_ctrl(afu, command);
 
-	cxl_p2n_write(afu, CXL_AFU_Cntl_An, AFU_Cntl | command);
+	AFU_Cntl = cxl_p2n_read(afu, CXL_AFU_Cntl_An);
+	cxl_p2n_write(afu, CXL_AFU_Cntl_An, (AFU_Cntl & ~clear) | command);
 
 	AFU_Cntl = cxl_p2n_read(afu, CXL_AFU_Cntl_An);
 	while ((AFU_Cntl & mask) != result) {
@@ -67,7 +68,7 @@ static int afu_enable(struct cxl_afu *afu)
 {
 	pr_devel("AFU enable request\n");
 
-	return afu_control(afu, CXL_AFU_Cntl_An_E,
+	return afu_control(afu, CXL_AFU_Cntl_An_E, 0,
 			   CXL_AFU_Cntl_An_ES_Enabled,
 			   CXL_AFU_Cntl_An_ES_MASK, true);
 }
@@ -76,7 +77,8 @@ int cxl_afu_disable(struct cxl_afu *afu)
 {
 	pr_devel("AFU disable request\n");
 
-	return afu_control(afu, 0, CXL_AFU_Cntl_An_ES_Disabled,
+	return afu_control(afu, 0, CXL_AFU_Cntl_An_E,
+			   CXL_AFU_Cntl_An_ES_Disabled,
 			   CXL_AFU_Cntl_An_ES_MASK, false);
 }
 
@@ -85,7 +87,7 @@ static int native_afu_reset(struct cxl_afu *afu)
 {
 	pr_devel("AFU reset request\n");
 
-	return afu_control(afu, CXL_AFU_Cntl_An_RA,
+	return afu_control(afu, CXL_AFU_Cntl_An_RA, 0,
 			   CXL_AFU_Cntl_An_RS_Complete | CXL_AFU_Cntl_An_ES_Disabled,
 			   CXL_AFU_Cntl_An_RS_MASK | CXL_AFU_Cntl_An_ES_MASK,
 			   false);
@@ -595,7 +597,16 @@ static int deactivate_afu_directed(struct cxl_afu *afu)
 	cxl_sysfs_afu_m_remove(afu);
 	cxl_chardev_afu_remove(afu);
 
-	cxl_ops->afu_reset(afu);
+	if (afu->adapter->native->sl_ops->needs_reset_before_disable) {
+		/*
+		 * XXX: We may be able to do away with this entirely - it is
+		 * possible that this was only ever needed due to a bug where
+		 * the disable operation did not clear the enable bit, however
+		 * I will only consider dropping this after more regression
+		 * testing on earlier PSL images.
+		 */
+		cxl_ops->afu_reset(afu);
+	}
 	cxl_afu_disable(afu);
 	cxl_psl_purge(afu);
 
@@ -735,7 +746,16 @@ static int native_attach_process(struct cxl_context *ctx, bool kernel,
 
 static inline int detach_process_native_dedicated(struct cxl_context *ctx)
 {
-	cxl_ops->afu_reset(ctx->afu);
+	if (ctx->afu->adapter->native->sl_ops->needs_reset_before_disable) {
+		/*
+		 * XXX: We may be able to do away with this entirely - it is
+		 * possible that this was only ever needed due to a bug where
+		 * the disable operation did not clear the enable bit, however
+		 * I will only consider dropping this after more regression
+		 * testing on earlier PSL images.
+		 */
+		cxl_ops->afu_reset(ctx->afu);
+	}
 	cxl_afu_disable(ctx->afu);
 	cxl_psl_purge(ctx->afu);
 	return 0;
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 58d7d821..b7f2e96 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -1309,6 +1309,7 @@ static const struct cxl_service_layer_ops psl_ops = {
 	.write_timebase_ctrl = write_timebase_ctrl_psl,
 	.timebase_read = timebase_read_psl,
 	.capi_mode = OPAL_PHB_CAPI_MODE_CAPI,
+	.needs_reset_before_disable = true,
 };
 
 static const struct cxl_service_layer_ops xsl_ops = {
-- 
2.8.1
