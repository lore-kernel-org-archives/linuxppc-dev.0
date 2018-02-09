Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zd28L0D2xzF1Cl
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Feb 2018 15:26:57 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w194QhYn030139
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Feb 2018 23:26:56 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g0y15mkf9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Feb 2018 23:26:54 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Fri, 9 Feb 2018 04:26:52 -0000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 "Alastair D'Silva" <alastair@linux.ibm.com>
Subject: [PATCH 3/3] cxl: Provide implementation for sl_ops.start_psltrace on
 PSL9
Date: Fri,  9 Feb 2018 09:55:35 +0530
In-Reply-To: <20180209042535.16845-1-vaibhav@linux.vnet.ibm.com>
References: <20180209042535.16845-1-vaibhav@linux.vnet.ibm.com>
Message-Id: <20180209042535.16845-4-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We introduce a new function named cxl_start_trace_psl9() that starts
the various trace-arrays available on PSL9. The implementation
configures trace-array-units(TAU) via multiple writes to the
PSL_TRACECFG register and uses the defaults (data-bus, trigger-bus &
trigger-masks) provided by the h/w team for each trace-array. These
defaults are defined in array cxl_psl_trace_mask.

The implementation takes care of not re-initializing a trace-array in
case its already in 'FIN' or 'WFT' or 'INIT' state so as to not reset
the existing trace data. After moving the individual trace-arrays to
'INIT' state we poll the PSL_CTCCFG register to ensure the all
configured TAUs to move to WFT/FIN state so that no traces/triggers
are missed.

Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
 drivers/misc/cxl/pci.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 9e8b8525534c..44b1843c5b7a 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -1767,6 +1767,78 @@ static void cxl_stop_trace_psl9(struct cxl *adapter)
 	}
 }
 
+/* Default enable mask for various trace arrays */
+static const uint64_t cxl_psl_trace_mask[] = {
+	[CXL_PSL9_TRACEID_RX0]  = 0x8200000000000000ULL,
+	[CXL_PSL9_TRACEID_RX1]  = 0xAA00000000000001UL,
+	[CXL_PSL9_TRACEID_XSL]  = 0x0,
+	[CXL_PSL9_TRACEID_CT0]  = 0xA2B8000000000003UL,
+	[CXL_PSL9_TRACEID_CT1]  = 0x0,
+	[CXL_PSL9_TRACEID_LA0]  = 0x83FFC00000000005ULL,
+	[CXL_PSL9_TRACEID_LA1]  = 0x83FFC00000000006ULL,
+	[CXL_PSL9_TRACEID_JM0]  = 0x8200000000000007ULL,
+	[CXL_PSL9_TRACEID_DMA0] = 0x8200000000000008UL,
+	[CXL_PSL9_TRACEID_DMA1] = 0x8200000000000009UL,
+	[CXL_PSL9_TRACEID_REOA] = 0x0,
+};
+
+static void cxl_start_trace_psl9(struct cxl *adapter)
+{
+	int traceid;
+	unsigned long timeout;
+	struct pci_dev *dev = to_pci_dev(adapter->dev.parent);
+	uint64_t trace_mask, trace_cfg = cxl_p1_read(adapter, CXL_PSL9_CTCCFG);
+
+	dev_dbg(&dev->dev, "Enabling traces. PSL_CTCCFG=0x%016llx\n",
+		trace_cfg);
+
+	for (trace_mask = traceid = 0;
+	     traceid < CXL_PSL9_TRACEID_MAX; ++traceid) {
+
+		if (cxl_psl_trace_mask[traceid] == 0)
+			continue;
+
+		if (CXL_PSL9_TRACE_STATE(trace_cfg, traceid) ==
+		    CXL_PSL9_TRACESTATE_IDLE) {
+			dev_dbg(&dev->dev, "Traceid-%d Initializing\n",
+				traceid);
+			cxl_p1_write(adapter, CXL_PSL9_TRACECFG,
+				     cxl_psl_trace_mask[traceid]);
+
+			/* filter out tlbie-response */
+			if (traceid == CXL_PSL9_TRACEID_LA0) {
+				cxl_p1_write(adapter, CXL_PSL9_TRACECFG,
+					     0x81FF400000000005ULL);
+			}
+
+			/* Mask so that we can poll for exit from INIT state */
+			trace_mask |= CXL_PSL9_TRACESTATE_WFT <<
+				(62 - traceid * 2);
+		} else {
+			dev_dbg(&dev->dev, "Traceid-%d already init.\n",
+				traceid);
+		}
+	}
+
+	/* poll until all the enabled arrays are out of INIT state */
+	timeout = jiffies + (HZ * CXL_TIMEOUT);
+	while (time_before(jiffies, timeout)) {
+		trace_cfg = cxl_p1_read(adapter, CXL_PSL9_CTCCFG);
+		if ((trace_cfg & trace_mask) == trace_mask)
+			break;
+		schedule();
+	}
+
+	if ((trace_cfg & trace_mask) != trace_mask) {
+		dev_warn(&dev->dev, "Trace init timeout."
+			 "Some trace events may be missed.\n");
+		dev_dbg(&dev->dev, "cxl:CTCCFG=0x%016llx\n", trace_cfg);
+
+	} else {
+		dev_info(&dev->dev, "Traces enabled\n");
+	}
+}
+
 static void cxl_stop_trace_psl8(struct cxl *adapter)
 {
 	int slice;
@@ -1802,6 +1874,7 @@ static const struct cxl_service_layer_ops psl9_ops = {
 	.psl_irq_dump_registers = cxl_native_irq_dump_regs_psl9,
 	.err_irq_dump_registers = cxl_native_err_irq_dump_regs_psl9,
 	.stop_psltrace = cxl_stop_trace_psl9,
+	.start_psltrace = cxl_start_trace_psl9,
 	.timebase_read = timebase_read_psl9,
 	.capi_mode = OPAL_PHB_CAPI_MODE_CAPI,
 	.needs_reset_before_disable = true,
-- 
2.14.3
