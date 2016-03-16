Return-Path: <felix@linux.vnet.ibm.com>
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQH3t6GVwzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 03:28:42 +1100 (AEDT)
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Wed, 16 Mar 2016 16:28:39 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 063D317D805A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Mar 2016 16:29:08 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2GGSaxR35848392
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Mar 2016 16:28:36 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2GGSZvu031017
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Mar 2016 10:28:36 -0600
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: imunsie@au1.ibm.com, mikey@neuling.org,
 Philippe Bergheaud <felix@linux.vnet.ibm.com>
Subject: [PATCH v2 2/2] cxl: Configure the PSL for two CAPI ports on POWER8NVL
Date: Wed, 16 Mar 2016 17:28:56 +0100
Message-Id: <1458145736-20326-2-git-send-email-felix@linux.vnet.ibm.com>
In-Reply-To: <1458145736-20326-1-git-send-email-felix@linux.vnet.ibm.com>
References: <1458145736-20326-1-git-send-email-felix@linux.vnet.ibm.com>
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

 drivers/misc/cxl/pci.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 0c6c17a1..924ba63 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -22,6 +22,7 @@
 #include <asm/pci-bridge.h> /* for struct pci_controller */
 #include <asm/pnv-pci.h>
 #include <asm/io.h>
+#include <asm/reg.h>
 
 #include "cxl.h"
 #include <misc/cxl.h>
@@ -340,12 +341,35 @@ static void dump_afu_descriptor(struct cxl_afu *afu)
 #undef show_reg
 }
 
+#define CAPP_UNIT0_ID 0xBA
+#define CAPP_UNIT1_ID 0XBE
+
+static u64 capp_unit_id(struct device_node *np)
+{
+	const __be32 *prop;
+	u64 phb_index;
+
+	/* For chips other than POWER8NVL, we only have CAPP 0,
+	 * irrespective of which PHB is used */
+	if (!pvr_version_is(PVR_POWER8NVL))
+		return CAPP_UNIT0_ID ;
+
+	/* For POWER8NVL, assume CAPP 0 is attached to PHB0 and
+	 * CAPP 1 is attached to PHB1 */
+	prop = of_get_property(np, "ibm,phb-index", NULL);
+	if (!prop)
+		return 0;
+	phb_index = be32_to_cpup(prop);
+	return phb_index ? CAPP_UNIT1_ID : CAPP_UNIT0_ID;
+}
+
 static int init_implementation_adapter_regs(struct cxl *adapter, struct pci_dev *dev)
 {
 	struct device_node *np;
 	const __be32 *prop;
 	u64 psl_dsnctl;
 	u64 chipid;
+	u64 cappunitid;
 
 	if (!(np = pnv_pci_get_phb_node(dev)))
 		return -ENODEV;
@@ -355,10 +379,15 @@ static int init_implementation_adapter_regs(struct cxl *adapter, struct pci_dev
 	if (!np)
 		return -ENODEV;
 	chipid = be32_to_cpup(prop);
+	cappunitid = capp_unit_id(np);
 	of_node_put(np);
+	if (!cappunitid)
+		return -ENODEV;
 
 	/* Tell PSL where to route data to */
-	psl_dsnctl = 0x02E8900002000000ULL | (chipid << (63-5));
+	psl_dsnctl = 0x0000900002000000ULL | (chipid << (63-5));
+	psl_dsnctl |= (cappunitid << (63-13));
+
 	cxl_p1_write(adapter, CXL_PSL_DSNDCTL, psl_dsnctl);
 	cxl_p1_write(adapter, CXL_PSL_RESLCKTO, 0x20000000200ULL);
 	/* snoop write mask */
-- 
2.1.0
