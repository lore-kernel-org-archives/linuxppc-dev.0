Return-Path: <felix@linux.vnet.ibm.com>
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qPcPZ2xHszDqk3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Mar 2016 01:26:42 +1100 (AEDT)
Received: from localhost
 by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Tue, 15 Mar 2016 14:26:37 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id CF914219004D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 14:26:15 +0000 (GMT)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
 [9.149.37.217])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2FEQXBU56885320
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 14:26:33 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2FEQXWb022138
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 10:26:33 -0400
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: imunsie@au1.ibm.com, mikey@neuling.org,
 Philippe Bergheaud <felix@linux.vnet.ibm.com>
Subject: [PATCH] cxl: Configure the PSL for dual port CAPI on Naples
Date: Tue, 15 Mar 2016 15:26:48 +0100
Message-Id: <1458052008-29254-1-git-send-email-felix@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Naples CPUs have two CAPI ports.  Configure the PSL to route data to
the port corresponding to the PHB index.

Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
---
 drivers/misc/cxl/pci.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 0c6c17a1..3db0a0b 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -340,12 +340,15 @@ static void dump_afu_descriptor(struct cxl_afu *afu)
 #undef show_reg
 }
 
+#define CPU_IS_NAPLES() (cur_cpu_spec->pvr_value == 0x004c0000)
+
 static int init_implementation_adapter_regs(struct cxl *adapter, struct pci_dev *dev)
 {
 	struct device_node *np;
 	const __be32 *prop;
 	u64 psl_dsnctl;
 	u64 chipid;
+	u64 phb_index;
 
 	if (!(np = pnv_pci_get_phb_node(dev)))
 		return -ENODEV;
@@ -355,10 +358,20 @@ static int init_implementation_adapter_regs(struct cxl *adapter, struct pci_dev
 	if (!np)
 		return -ENODEV;
 	chipid = be32_to_cpup(prop);
-	of_node_put(np);
 
 	/* Tell PSL where to route data to */
 	psl_dsnctl = 0x02E8900002000000ULL | (chipid << (63-5));
+	if (CPU_IS_NAPLES()) {
+		prop = of_get_property(np, "ibm,phb-index", NULL);
+		if (!prop) {
+			of_node_put(np);
+			return -ENODEV;
+		}
+		phb_index = be32_to_cpup(prop);
+		psl_dsnctl |= (phb_index << (63-11));
+	}
+	of_node_put(np);
+
 	cxl_p1_write(adapter, CXL_PSL_DSNDCTL, psl_dsnctl);
 	cxl_p1_write(adapter, CXL_PSL_RESLCKTO, 0x20000000200ULL);
 	/* snoop write mask */
-- 
2.1.0
