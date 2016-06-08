Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPc3L3P4QzDqHh
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 15:11:10 +1000 (AEST)
Received: from pps.filterd (m0048817.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u58597a3006676
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Jun 2016 01:11:07 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23e9mf206m-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jun 2016 01:11:07 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Wed, 8 Jun 2016 15:11:04 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id E0FBA2BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 15:10:44 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u585AY2h8782302
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Jun 2016 15:10:39 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u585AS6f013014
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Jun 2016 15:10:29 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, mikey <mikey@neuling.org>,
 linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Huy Nguyen <huyn@mellanox.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Subject: [PATCH, RFC] cxl: Add support for CAPP DMA mode
Date: Wed,  8 Jun 2016 15:09:54 +1000
In-Reply-To: <1464025158-23849-1-git-send-email-imunsie@au.ibm.com>
References: <1464025158-23849-1-git-send-email-imunsie@au.ibm.com>
Message-Id: <1465362594-10437-1-git-send-email-imunsie@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

This adds support for using CAPP DMA mode, which is required for XSL
based cards such as the Mellanox CX4 to function.

This is currently an RFC as it depends on the corresponding support to
be merged into skiboot first, which was submitted here:
http://patchwork.ozlabs.org/patch/625582/

In the event that the skiboot on the system does not have the above
support, it will indicate as such in the kernel log and abort the init
process.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 arch/powerpc/include/asm/opal-api.h       | 1 +
 arch/powerpc/platforms/powernv/pci-ioda.c | 4 +++-
 drivers/misc/cxl/cxl.h                    | 1 +
 drivers/misc/cxl/pci.c                    | 4 +++-
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 9bb8ddf..d29c584 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -825,6 +825,7 @@ enum {
 	OPAL_PHB_CAPI_MODE_CAPI		= 1,
 	OPAL_PHB_CAPI_MODE_SNOOP_OFF    = 2,
 	OPAL_PHB_CAPI_MODE_SNOOP_ON	= 3,
+	OPAL_PHB_CAPI_MODE_DMA		= 4,
 };
 
 /* OPAL I2C request */
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 3a5ea82..5a42e98 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2793,7 +2793,9 @@ int pnv_phb_to_cxl_mode(struct pci_dev *dev, uint64_t mode)
 	pe_info(pe, "Switching PHB to CXL\n");
 
 	rc = opal_pci_set_phb_cxl_mode(phb->opal_id, mode, pe->pe_number);
-	if (rc)
+	if (rc == OPAL_UNSUPPORTED)
+		dev_err(&dev->dev, "Required cxl mode not supported by firmware - update skiboot\n");
+	else if (rc)
 		dev_err(&dev->dev, "opal_pci_set_phb_cxl_mode failed: %i\n", rc);
 
 	return rc;
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 92e7f19..aa69a84 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -542,6 +542,7 @@ struct cxl_service_layer_ops {
 	void (*debugfs_stop_trace)(struct cxl *adapter);
 	void (*write_timebase_ctrl)(struct cxl *adapter);
 	u64 (*timebase_read)(struct cxl *adapter);
+	int capi_mode;
 };
 
 struct cxl_native {
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 556718d..648817a 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -1249,7 +1249,7 @@ static int cxl_configure_adapter(struct cxl *adapter, struct pci_dev *dev)
 	if ((rc = adapter->native->sl_ops->adapter_regs_init(adapter, dev)))
 		goto err;
 
-	if ((rc = pnv_phb_to_cxl_mode(dev, OPAL_PHB_CAPI_MODE_CAPI)))
+	if ((rc = pnv_phb_to_cxl_mode(dev, adapter->native->sl_ops->capi_mode)))
 		goto err;
 
 	/* If recovery happened, the last step is to turn on snooping.
@@ -1293,6 +1293,7 @@ static const struct cxl_service_layer_ops psl_ops = {
 	.debugfs_stop_trace = cxl_stop_trace,
 	.write_timebase_ctrl = write_timebase_ctrl_psl,
 	.timebase_read = timebase_read_psl,
+	.capi_mode = OPAL_PHB_CAPI_MODE_CAPI,
 };
 
 static const struct cxl_service_layer_ops xsl_ops = {
@@ -1300,6 +1301,7 @@ static const struct cxl_service_layer_ops xsl_ops = {
 	.debugfs_add_adapter_sl_regs = cxl_debugfs_add_adapter_xsl_regs,
 	.write_timebase_ctrl = write_timebase_ctrl_xsl,
 	.timebase_read = timebase_read_xsl,
+	.capi_mode = OPAL_PHB_CAPI_MODE_DMA,
 };
 
 static void set_sl_ops(struct cxl *adapter, struct pci_dev *dev)
-- 
2.8.1
