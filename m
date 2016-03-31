Return-Path: <felix@linux.vnet.ibm.com>
Received: from e06smtp09.uk.ibm.com (e06smtp09.uk.ibm.com [195.75.94.105])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qbJrS2wwCzDqFZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 20:20:08 +1100 (AEDT)
Received: from localhost
 by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Thu, 31 Mar 2016 10:20:04 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7504A1B08061
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 10:20:25 +0100 (BST)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2V9JnIw6357300
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 09:19:50 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2V9Jn0Q027102
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 03:19:49 -0600
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, imunsie@au1.ibm.com, mikey@neuling.org,
 Philippe Bergheaud <felix@linux.vnet.ibm.com>
Subject: [PATCH v3 2/2] cxl: Configure the PSL for two CAPI ports on POWER8NVL
Date: Thu, 31 Mar 2016 11:19:28 +0200
Message-Id: <1459415968-4890-2-git-send-email-felix@linux.vnet.ibm.com>
In-Reply-To: <1459415968-4890-1-git-send-email-felix@linux.vnet.ibm.com>
References: <1459415968-4890-1-git-send-email-felix@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The POWER8NVL chip has two CAPI ports.  Configure the PSL to route
data to the port corresponding to the CAPP unit.

Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
---
V2:
  - Complete rewrite after Mikey's review
V3:
  Fixes suggested by Michael:
  - s/capp_unit_id(/get_capp_unit_id(/
  - Fix block commenting style
  - Remove extra space
  - Use of_property_read_u32
  - Add blank line after return
  - Fix logic for phb_index > 1 on POWERNVL
  - s/cappunitid/capp_unit_id/
  - Add error message for -ENODEV

 drivers/misc/cxl/pci.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 2844e97..94fd3f7 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -21,6 +21,7 @@
 #include <asm/msi_bitmap.h>
 #include <asm/pnv-pci.h>
 #include <asm/io.h>
+#include <asm/reg.h>
 
 #include "cxl.h"
 #include <misc/cxl.h>
@@ -321,12 +322,43 @@ static void dump_afu_descriptor(struct cxl_afu *afu)
 #undef show_reg
 }
 
+#define CAPP_UNIT0_ID 0xBA
+#define CAPP_UNIT1_ID 0XBE
+
+static u64 get_capp_unit_id(struct device_node *np)
+{
+	u32 phb_index;
+
+	/*
+	 * For chips other than POWER8NVL, we only have CAPP 0,
+	 * irrespective of which PHB is used.
+	 */
+	if (!pvr_version_is(PVR_POWER8NVL))
+		return CAPP_UNIT0_ID;
+
+	/*
+	 * For POWER8NVL, assume CAPP 0 is attached to PHB0 and
+	 * CAPP 1 is attached to PHB1.
+	 */
+	if (of_property_read_u32(np, "ibm,phb-index", &phb_index))
+		return 0;
+
+	if (phb_index == 0)
+		return CAPP_UNIT0_ID;
+
+	if (phb_index == 1)
+		return CAPP_UNIT1_ID;
+
+	return 0;
+}
+
 static int init_implementation_adapter_regs(struct cxl *adapter, struct pci_dev *dev)
 {
 	struct device_node *np;
 	const __be32 *prop;
 	u64 psl_dsnctl;
 	u64 chipid;
+	u64 capp_unit_id;
 
 	if (!(np = pnv_pci_get_phb_node(dev)))
 		return -ENODEV;
@@ -336,10 +368,17 @@ static int init_implementation_adapter_regs(struct cxl *adapter, struct pci_dev
 	if (!np)
 		return -ENODEV;
 	chipid = be32_to_cpup(prop);
+	capp_unit_id = get_capp_unit_id(np);
 	of_node_put(np);
+	if (!capp_unit_id) {
+		pr_err("cxl: invalid capp unit id\n");
+		return -ENODEV;
+	}
 
 	/* Tell PSL where to route data to */
-	psl_dsnctl = 0x02E8900002000000ULL | (chipid << (63-5));
+	psl_dsnctl = 0x0000900002000000ULL | (chipid << (63-5));
+	psl_dsnctl |= (capp_unit_id << (63-13));
+
 	cxl_p1_write(adapter, CXL_PSL_DSNDCTL, psl_dsnctl);
 	cxl_p1_write(adapter, CXL_PSL_RESLCKTO, 0x20000000200ULL);
 	/* snoop write mask */
-- 
2.1.0
