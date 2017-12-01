Return-Path: <felix@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ypDTZ1khbzDrKJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Dec 2017 23:43:29 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vB1Cfako086276
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Dec 2017 07:43:27 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ek51wpntx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Dec 2017 07:43:27 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Fri, 1 Dec 2017 12:43:25 -0000
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: fbarrat@linux.vnet.ibm.com, clombard@linux.vnet.ibm.com, benh@au1.ibm.com,
 Philippe Bergheaud <felix@linux.vnet.ibm.com>
Subject: [PATCH v2 2/2] cxl: read PHB indications from the device tree
Date: Fri,  1 Dec 2017 13:43:18 +0100
In-Reply-To: <20171201124318.4159-1-felix@linux.vnet.ibm.com>
References: <20171201124318.4159-1-felix@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20171201124318.4159-2-felix@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Configure the P9 XSL_DSNCTL register with PHB indications found
in the device tree, or else use legacy hard-coded values.

Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
---
Changelog:

v2: New patch. Use the new device tree property "ibm,phb-indications".

This patch depends on the following skiboot prerequisite:

    https://patchwork.ozlabs.org/patch/843474/
---
 drivers/misc/cxl/cxl.h    |  2 +-
 drivers/misc/cxl/cxllib.c |  2 +-
 drivers/misc/cxl/pci.c    | 44 +++++++++++++++++++++++++++++++++++++-------
 3 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index e46a4062904a..5a6e9a921c2b 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -1062,7 +1062,7 @@ int cxl_psl_purge(struct cxl_afu *afu);
 int cxl_calc_capp_routing(struct pci_dev *dev, u64 *chipid,
 			  u32 *phb_index, u64 *capp_unit_id);
 int cxl_slot_is_switched(struct pci_dev *dev);
-int cxl_get_xsl9_dsnctl(u64 capp_unit_id, u64 *reg);
+int cxl_get_xsl9_dsnctl(struct pci_dev *dev, u64 capp_unit_id, u64 *reg);
 u64 cxl_calculate_sr(bool master, bool kernel, bool real_mode, bool p9);
 
 void cxl_native_irq_dump_regs_psl9(struct cxl_context *ctx);
diff --git a/drivers/misc/cxl/cxllib.c b/drivers/misc/cxl/cxllib.c
index dc9bc1807fdf..61f80d586279 100644
--- a/drivers/misc/cxl/cxllib.c
+++ b/drivers/misc/cxl/cxllib.c
@@ -99,7 +99,7 @@ int cxllib_get_xsl_config(struct pci_dev *dev, struct cxllib_xsl_config *cfg)
 	if (rc)
 		return rc;
 
-	rc = cxl_get_xsl9_dsnctl(capp_unit_id, &cfg->dsnctl);
+	rc = cxl_get_xsl9_dsnctl(dev, capp_unit_id, &cfg->dsnctl);
 	if (rc)
 		return rc;
 	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index bb7fd3f4edab..e21c45758558 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -409,7 +409,36 @@ int cxl_calc_capp_routing(struct pci_dev *dev, u64 *chipid,
 	return 0;
 }
 
-int cxl_get_xsl9_dsnctl(u64 capp_unit_id, u64 *reg)
+static u64 nbwind = 0;
+static u64 asnind = 0;
+static u64 capiind = 0;
+
+static int get_phb_indications(struct pci_dev *dev)
+{
+	struct device_node *np;
+	const __be32 *prop;
+
+	if (capiind)
+		return 0;
+
+	if (!(np = pnv_pci_get_phb_node(dev)))
+		return -1;
+
+	prop = of_get_property(np, "ibm,phb-indications", NULL);
+	if (!prop) {
+		nbwind = 0x0300UL; /* legacy values */
+		asnind = 0x0400UL;
+		capiind = 0x0200UL;
+	} else {
+		nbwind = (u64)be32_to_cpu(prop[2]);
+		asnind = (u64)be32_to_cpu(prop[1]);
+		capiind = (u64)be32_to_cpu(prop[0]);
+	}
+	of_node_put(np);
+	return 0;
+}
+
+int cxl_get_xsl9_dsnctl(struct pci_dev *dev, u64 capp_unit_id, u64 *reg)
 {
 	u64 xsl_dsnctl;
 
@@ -423,10 +452,11 @@ int cxl_get_xsl9_dsnctl(u64 capp_unit_id, u64 *reg)
 	 * Tell XSL where to route data to.
 	 * The field chipid should match the PHB CAPI_CMPM register
 	 */
-	xsl_dsnctl = ((u64)0x2 << (63-7)); /* Bit 57 */
+	get_phb_indications(dev);
+	xsl_dsnctl = (capiind << (63-15)); /* Bit 57 */
 	xsl_dsnctl |= (capp_unit_id << (63-15));
 
-	/* nMMU_ID Defaults to: b’000001001’*/
+	/* nMMU_ID Defaults to: b'000001001'*/
 	xsl_dsnctl |= ((u64)0x09 << (63-28));
 
 	if (!(cxl_is_power9_dd1())) {
@@ -437,14 +467,14 @@ int cxl_get_xsl9_dsnctl(u64 capp_unit_id, u64 *reg)
 		 * nbwind=0x03, bits [57:58], must include capi indicator.
 		 * Not supported on P9 DD1.
 		 */
-		xsl_dsnctl |= ((u64)0x03 << (63-47));
+		xsl_dsnctl |= (nbwind << (63-55));
 
 		/*
 		 * Upper 16b address bits of ASB_Notify messages sent to the
-		 * system. Need to match the PHB’s ASN Compare/Mask Register.
+		 * system. Need to match the PHB's ASN Compare/Mask Register.
 		 * Not supported on P9 DD1.
 		 */
-		xsl_dsnctl |= ((u64)0x04 << (63-55));
+		xsl_dsnctl |= asnind;
 	}
 
 	*reg = xsl_dsnctl;
@@ -464,7 +494,7 @@ static int init_implementation_adapter_regs_psl9(struct cxl *adapter,
 	if (rc)
 		return rc;
 
-	rc = cxl_get_xsl9_dsnctl(capp_unit_id, &xsl_dsnctl);
+	rc = cxl_get_xsl9_dsnctl(dev, capp_unit_id, &xsl_dsnctl);
 	if (rc)
 		return rc;
 
-- 
2.15.0
