Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zj11X44JNzF1Kw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Feb 2018 02:49:52 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1FFmuHX098095
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 10:49:49 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g5atnfbck-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 10:49:48 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Thu, 15 Feb 2018 15:49:46 -0000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 "Alastair D'Silva" <alastair@linux.ibm.com>
Subject: [PATCH v2] cxl: Check if PSL data-cache is available before issue
 flush request
Date: Thu, 15 Feb 2018 21:19:24 +0530
Message-Id: <20180215154924.22005-1-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PSL9D doesn't have a data-cache that needs to be flushed before
resetting the card. However when cxl tries to flush data-cache on such
a card, it times-out as PSL_Control register never indicates flush
operation complete due to missing data-cache. This is usually
indicated in the kernel logs with this message:

"WARNING: cache flush timed out"

To fix this the patch checks PSL_Debug register CDC-Field(BIT:27)
which indicates the absence of a data-cache and sets a flag
'no_data_cache' in 'struct cxl_native' to indicate this. When
cxl_data_cache_flush() is called it checks the flag and if set bails
out early without requesting a data-cache flush operation to the PSL.

Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
Change-log:
v2	-> Changed the dev_info to dev_dbg (Fred)
	   Removed the check for DD1.0 chips (Fred)
---
 drivers/misc/cxl/cxl.h    |  4 ++++
 drivers/misc/cxl/native.c | 11 ++++++++++-
 drivers/misc/cxl/pci.c    | 18 ++++++++++++------
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 4f015da78f28..4949b8d5a748 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -369,6 +369,9 @@ static const cxl_p2n_reg_t CXL_PSL_WED_An     = {0x0A0};
 #define CXL_PSL_TFC_An_AE (1ull << (63-30)) /* Restart PSL with address error */
 #define CXL_PSL_TFC_An_R  (1ull << (63-31)) /* Restart PSL transaction */
 
+/****** CXL_PSL_DEBUG *****************************************************/
+#define CXL_PSL_DEBUG_CDC  (1ull << (63-27)) /* Coherent Data cache support */
+
 /****** CXL_XSL9_IERAT_ERAT - CAIA 2 **********************************/
 #define CXL_XSL9_IERAT_MLPID    (1ull << (63-0))  /* Match LPID */
 #define CXL_XSL9_IERAT_MPID     (1ull << (63-1))  /* Match PID */
@@ -669,6 +672,7 @@ struct cxl_native {
 	irq_hw_number_t err_hwirq;
 	unsigned int err_virq;
 	u64 ps_off;
+	bool no_data_cache; /* set if no data cache on the card */
 	const struct cxl_service_layer_ops *sl_ops;
 };
 
diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index 1b3d7c65ea3f..98f867fcef24 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -353,8 +353,17 @@ int cxl_data_cache_flush(struct cxl *adapter)
 	u64 reg;
 	unsigned long timeout = jiffies + (HZ * CXL_TIMEOUT);
 
-	pr_devel("Flushing data cache\n");
+	/*
+	 * Do a datacache flush only if datacache is available.
+	 * In case of PSL9D datacache absent hence flush operation.
+	 * would timeout.
+	 */
+	if (adapter->native->no_data_cache) {
+		pr_devel("No PSL data cache. Ignoring cache flush req.\n");
+		return 0;
+	}
 
+	pr_devel("Flushing data cache\n");
 	reg = cxl_p1_read(adapter, CXL_PSL_Control);
 	reg |= CXL_PSL_Control_Fr;
 	cxl_p1_write(adapter, CXL_PSL_Control, reg);
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 758842f65a1b..3255f89c85d0 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -456,6 +456,7 @@ static int init_implementation_adapter_regs_psl9(struct cxl *adapter,
 	u64 chipid;
 	u32 phb_index;
 	u64 capp_unit_id;
+	u64 psl_debug;
 	int rc;
 
 	rc = cxl_calc_capp_routing(dev, &chipid, &phb_index, &capp_unit_id);
@@ -506,6 +507,15 @@ static int init_implementation_adapter_regs_psl9(struct cxl *adapter,
 	} else
 		cxl_p1_write(adapter, CXL_PSL9_DEBUG, 0x4000000000000000ULL);
 
+	/* Check if PSL has data-cache. We need to flush adapter datacache
+	 * when as its about to be removed.
+	 */
+	psl_debug = cxl_p1_read(adapter, CXL_PSL9_DEBUG);
+	if (psl_debug & CXL_PSL_DEBUG_CDC) {
+		dev_dbg(&dev->dev, "No data-cache present\n");
+		adapter->native->no_data_cache = true;
+	}
+
 	return 0;
 }
 
@@ -1449,10 +1459,8 @@ int cxl_pci_reset(struct cxl *adapter)
 
 	/*
 	 * The adapter is about to be reset, so ignore errors.
-	 * Not supported on P9 DD1
 	 */
-	if ((cxl_is_power8()) || (!(cxl_is_power9_dd1())))
-		cxl_data_cache_flush(adapter);
+	cxl_data_cache_flush(adapter);
 
 	/* pcie_warm_reset requests a fundamental pci reset which includes a
 	 * PERST assert/deassert.  PERST triggers a loading of the image
@@ -1936,10 +1944,8 @@ static void cxl_pci_remove_adapter(struct cxl *adapter)
 
 	/*
 	 * Flush adapter datacache as its about to be removed.
-	 * Not supported on P9 DD1.
 	 */
-	if ((cxl_is_power8()) || (!(cxl_is_power9_dd1())))
-		cxl_data_cache_flush(adapter);
+	cxl_data_cache_flush(adapter);
 
 	cxl_deconfigure_adapter(adapter);
 
-- 
2.14.3
