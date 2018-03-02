Return-Path: <felix@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zt4Sw3nTXzF1r9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Mar 2018 20:56:32 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w229sZfv017424
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Mar 2018 04:56:28 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gf1vh5jv0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Mar 2018 04:56:28 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Fri, 2 Mar 2018 09:56:25 -0000
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: fbarrat@linux.vnet.ibm.com, clombard@linux.vnet.ibm.com, benh@au1.ibm.com,
 Philippe Bergheaud <felix@linux.vnet.ibm.com>
Subject: [PATCH v10 2/2] cxl: read PHB indications from the device tree
Date: Fri,  2 Mar 2018 10:56:12 +0100
In-Reply-To: <20180302095612.19493-1-felix@linux.vnet.ibm.com>
References: <20180302095612.19493-1-felix@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20180302095612.19493-2-felix@linux.vnet.ibm.com>
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
Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
---
Changelog:

v2: New patch. Use the new device tree property "ibm,phb-indications".

v3: No change.

v4: No functional change.
    Drop cosmetic fix in comment.

v5: get_phb_indications():
      - make static variables local to function.
      - return static variable values by arguments.

v6: get_phb_indications():
      - acquire a mutex before setting the phb indications.

v7: get_phb_indications():
    cxl_get_xsl9_dsnctl():
      - return -ENODEV instead of -1.

v8: get_phb_indications():
      - stay on the safe side: acquire the mutex unconditionally

v9,v10: No change.
---
 drivers/misc/cxl/cxl.h    |  2 +-
 drivers/misc/cxl/cxllib.c |  2 +-
 drivers/misc/cxl/pci.c    | 48 ++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 4f015da78f28..a7689944b351 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -1065,7 +1065,7 @@ int cxl_psl_purge(struct cxl_afu *afu);
 int cxl_calc_capp_routing(struct pci_dev *dev, u64 *chipid,
 			  u32 *phb_index, u64 *capp_unit_id);
 int cxl_slot_is_switched(struct pci_dev *dev);
-int cxl_get_xsl9_dsnctl(u64 capp_unit_id, u64 *reg);
+int cxl_get_xsl9_dsnctl(struct pci_dev *dev, u64 capp_unit_id, u64 *reg);
 u64 cxl_calculate_sr(bool master, bool kernel, bool real_mode, bool p9);
 
 void cxl_native_irq_dump_regs_psl9(struct cxl_context *ctx);
diff --git a/drivers/misc/cxl/cxllib.c b/drivers/misc/cxl/cxllib.c
index 30ccba436b3b..bea1eb004b49 100644
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
index 758842f65a1b..8d179e64a296 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -407,21 +407,59 @@ int cxl_calc_capp_routing(struct pci_dev *dev, u64 *chipid,
 	return 0;
 }
 
-int cxl_get_xsl9_dsnctl(u64 capp_unit_id, u64 *reg)
+static DEFINE_MUTEX(indications_mutex);
+
+static int get_phb_indications(struct pci_dev *dev, u64 *capiind, u64 *asnind,
+			       u64 *nbwind)
+{
+	static u64 nbw, asn, capi = 0;
+	struct device_node *np;
+	const __be32 *prop;
+
+	mutex_lock(&indications_mutex);
+	if (!capi) {
+		if (!(np = pnv_pci_get_phb_node(dev))) {
+			mutex_unlock(&indications_mutex);
+			return -ENODEV;
+		}
+
+		prop = of_get_property(np, "ibm,phb-indications", NULL);
+		if (!prop) {
+			nbw = 0x0300UL; /* legacy values */
+			asn = 0x0400UL;
+			capi = 0x0200UL;
+		} else {
+			nbw = (u64)be32_to_cpu(prop[2]);
+			asn = (u64)be32_to_cpu(prop[1]);
+			capi = (u64)be32_to_cpu(prop[0]);
+		}
+		of_node_put(np);
+	}
+	*capiind = capi;
+	*asnind = asn;
+	*nbwind = nbw;
+	mutex_unlock(&indications_mutex);
+	return 0;
+}
+
+int cxl_get_xsl9_dsnctl(struct pci_dev *dev, u64 capp_unit_id, u64 *reg)
 {
 	u64 xsl_dsnctl;
+	u64 capiind, asnind, nbwind;
 
 	/*
 	 * CAPI Identifier bits [0:7]
 	 * bit 61:60 MSI bits --> 0
 	 * bit 59 TVT selector --> 0
 	 */
+	if (get_phb_indications(dev, &capiind, &asnind, &nbwind))
+		return -ENODEV;
 
 	/*
 	 * Tell XSL where to route data to.
 	 * The field chipid should match the PHB CAPI_CMPM register
 	 */
-	xsl_dsnctl = ((u64)0x2 << (63-7)); /* Bit 57 */
+	xsl_dsnctl = (capiind << (63-15)); /* Bit 57 */
 	xsl_dsnctl |= (capp_unit_id << (63-15));
 
 	/* nMMU_ID Defaults to: b’000001001’*/
@@ -435,14 +473,14 @@ int cxl_get_xsl9_dsnctl(u64 capp_unit_id, u64 *reg)
 		 * nbwind=0x03, bits [57:58], must include capi indicator.
 		 * Not supported on P9 DD1.
 		 */
-		xsl_dsnctl |= ((u64)0x03 << (63-47));
+		xsl_dsnctl |= (nbwind << (63-55));
 
 		/*
 		 * Upper 16b address bits of ASB_Notify messages sent to the
 		 * system. Need to match the PHB’s ASN Compare/Mask Register.
 		 * Not supported on P9 DD1.
 		 */
-		xsl_dsnctl |= ((u64)0x04 << (63-55));
+		xsl_dsnctl |= asnind;
 	}
 
 	*reg = xsl_dsnctl;
@@ -462,7 +500,7 @@ static int init_implementation_adapter_regs_psl9(struct cxl *adapter,
 	if (rc)
 		return rc;
 
-	rc = cxl_get_xsl9_dsnctl(capp_unit_id, &xsl_dsnctl);
+	rc = cxl_get_xsl9_dsnctl(dev, capp_unit_id, &xsl_dsnctl);
 	if (rc)
 		return rc;
 
-- 
2.16.1
