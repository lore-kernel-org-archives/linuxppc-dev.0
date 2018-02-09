Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zd1nS6jfTzDqMJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Feb 2018 15:10:36 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1948i7Z079266
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Feb 2018 23:10:34 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g13j51svh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Feb 2018 23:10:34 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Fri, 9 Feb 2018 04:10:32 -0000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 "Alastair D'Silva" <alastair@linux.ibm.com>
Subject: [PATCH] cxl: Remove function write_timebase_ctrl_psl9() for PSL9
Date: Fri,  9 Feb 2018 09:40:09 +0530
Message-Id: <20180209041009.14456-1-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For PSL9 the time-base enable bit has moved from PSL_TB_CTLSTAT
register to PSL_CONTROL register. Hence we don't need an sl_ops
implementation for 'write_timebase_ctrl' for PSL9.

Hence this patch removes function write_timebase_ctrl_psl9() and its
references from the code.

Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
 drivers/misc/cxl/pci.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index c983f23cc2ed..9bc30c20b66b 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -572,12 +572,6 @@ static int init_implementation_adapter_regs_xsl(struct cxl *adapter, struct pci_
 /* For the PSL this is a multiple for 0 < n <= 7: */
 #define PSL_2048_250MHZ_CYCLES 1
 
-static void write_timebase_ctrl_psl9(struct cxl *adapter)
-{
-	cxl_p1_write(adapter, CXL_PSL9_TB_CTLSTAT,
-		     TBSYNC_CNT(2 * PSL_2048_250MHZ_CYCLES));
-}
-
 static void write_timebase_ctrl_psl8(struct cxl *adapter)
 {
 	cxl_p1_write(adapter, CXL_PSL_TB_CTLSTAT,
@@ -639,7 +633,8 @@ static void cxl_setup_psl_timebase(struct cxl *adapter, struct pci_dev *dev)
 	 * Setup PSL Timebase Control and Status register
 	 * with the recommended Timebase Sync Count value
 	 */
-	adapter->native->sl_ops->write_timebase_ctrl(adapter);
+	if (adapter->native->sl_ops->write_timebase_ctrl)
+		adapter->native->sl_ops->write_timebase_ctrl(adapter);
 
 	/* Enable PSL Timebase */
 	cxl_p1_write(adapter, CXL_PSL_Control, 0x0000000000000000);
@@ -1805,7 +1800,6 @@ static const struct cxl_service_layer_ops psl9_ops = {
 	.psl_irq_dump_registers = cxl_native_irq_dump_regs_psl9,
 	.err_irq_dump_registers = cxl_native_err_irq_dump_regs_psl9,
 	.debugfs_stop_trace = cxl_stop_trace_psl9,
-	.write_timebase_ctrl = write_timebase_ctrl_psl9,
 	.timebase_read = timebase_read_psl9,
 	.capi_mode = OPAL_PHB_CAPI_MODE_CAPI,
 	.needs_reset_before_disable = true,
-- 
2.14.3
