Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9FA5B1A1E7A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 13:36:33 +1100 (AEDT)
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DB36214019D
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2014 13:36:32 +1100 (AEDT)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 12 Nov 2014 08:06:31 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id C452A1258053
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2014 08:06:30 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAC2aip148693498
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2014 08:06:44 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAC2aRLV009532
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2014 08:06:27 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/8] powerpc/powernv: Set PELTV for compound PEs
Date: Wed, 12 Nov 2014 13:36:08 +1100
Message-Id: <1415759771-11359-6-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1415759771-11359-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1415759771-11359-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 262af55 ("powerpc/powernv: Enable M64 aperatus for PHB3")
introduced compound PEs in order to support M64 aperatus on PHB3.
However, we never configured PELTV for compound PEs. The patch
fixes that by: parent PE can freeze all child compound PEs. Any
compound PE affects the group.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 118 ++++++++++++++++++++++++++----
 1 file changed, 102 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 7a7a688..b96ba48 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -522,6 +522,106 @@ static struct pnv_ioda_pe *pnv_ioda_get_pe(struct pci_dev *dev)
 }
 #endif /* CONFIG_PCI_MSI */
 
+static int pnv_ioda_set_one_peltv(struct pnv_phb *phb,
+				  struct pnv_ioda_pe *parent,
+				  struct pnv_ioda_pe *child,
+				  bool is_add)
+{
+	const char *desc = is_add ? "adding" : "removing";
+	uint8_t op = is_add ? OPAL_ADD_PE_TO_DOMAIN :
+			      OPAL_REMOVE_PE_FROM_DOMAIN;
+	struct pnv_ioda_pe *slave;
+	long rc;
+
+	/* Parent PE affects child PE */
+	rc = opal_pci_set_peltv(phb->opal_id, parent->pe_number,
+				child->pe_number, op);
+	if (rc != OPAL_SUCCESS) {
+		pe_warn(child, "OPAL error %ld %s to parent PELTV\n",
+			rc, desc);
+		return -ENXIO;
+	}
+
+	if (!(child->flags & PNV_IODA_PE_MASTER))
+		return 0;
+
+	/* Compound case: parent PE affects slave PEs */
+	list_for_each_entry(slave, &child->slaves, list) {
+		rc = opal_pci_set_peltv(phb->opal_id, parent->pe_number,
+					slave->pe_number, op);
+		if (rc != OPAL_SUCCESS) {
+			pe_warn(slave, "OPAL error %ld %s to parent PELTV\n",
+				rc, desc);
+			return -ENXIO;
+		}
+	}
+
+	return 0;
+}
+
+static int pnv_ioda_set_peltv(struct pnv_phb *phb,
+			      struct pnv_ioda_pe *pe,
+			      bool is_add)
+{
+	struct pnv_ioda_pe *slave;
+	struct pci_dev *pdev;
+	int ret;
+
+	/*
+	 * Clear PE frozen state. If it's master PE, we need
+	 * clear slave PE frozen state as well.
+	 */
+	if (is_add) {
+		opal_pci_eeh_freeze_clear(phb->opal_id, pe->pe_number,
+					  OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
+		if (pe->flags & PNV_IODA_PE_MASTER) {
+			list_for_each_entry(slave, &pe->slaves, list)
+				opal_pci_eeh_freeze_clear(phb->opal_id,
+							  slave->pe_number,
+							  OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
+		}
+	}
+
+	/*
+	 * Associate PE in PELT. We need add the PE into the
+	 * corresponding PELT-V as well. Otherwise, the error
+	 * originated from the PE might contribute to other
+	 * PEs.
+	 */
+	ret = pnv_ioda_set_one_peltv(phb, pe, pe, is_add);
+	if (ret)
+		return ret;
+
+	/* For compound PEs, any one affects all of them */
+	if (pe->flags & PNV_IODA_PE_MASTER) {
+		list_for_each_entry(slave, &pe->slaves, list) {
+			ret = pnv_ioda_set_one_peltv(phb, slave, pe, is_add);
+			if (ret)
+				return ret;
+		}
+	}
+
+	if (pe->flags & (PNV_IODA_PE_BUS_ALL | PNV_IODA_PE_BUS))
+		pdev = pe->pbus->self;
+	else
+		pdev = pe->pdev->bus->self;
+	while (pdev) {
+		struct pci_dn *pdn = pci_get_pdn(pdev);
+		struct pnv_ioda_pe *parent;
+
+		if (pdn && pdn->pe_number != IODA_INVALID_PE) {
+			parent = &phb->ioda.pe_array[pdn->pe_number];
+			ret = pnv_ioda_set_one_peltv(phb, parent, pe, is_add);
+			if (ret)
+				return ret;
+		}
+
+		pdev = pdev->bus->self;
+	}
+
+	return 0;
+}
+
 static int pnv_ioda_configure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
 {
 	struct pci_dev *parent;
@@ -576,23 +676,9 @@ static int pnv_ioda_configure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
 		return -ENXIO;
 	}
 
-	rc = opal_pci_set_peltv(phb->opal_id, pe->pe_number,
-				pe->pe_number, OPAL_ADD_PE_TO_DOMAIN);
-	if (rc)
-		pe_warn(pe, "OPAL error %d adding self to PELTV\n", rc);
-	opal_pci_eeh_freeze_clear(phb->opal_id, pe->pe_number,
-				  OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
+	/* Configure PELTV */
+	pnv_ioda_set_peltv(phb, pe, true);
 
-	/* Add to all parents PELT-V */
-	while (parent) {
-		struct pci_dn *pdn = pci_get_pdn(parent);
-		if (pdn && pdn->pe_number != IODA_INVALID_PE) {
-			rc = opal_pci_set_peltv(phb->opal_id, pdn->pe_number,
-						pe->pe_number, OPAL_ADD_PE_TO_DOMAIN);
-			/* XXX What to do in case of error ? */
-		}
-		parent = parent->bus->self;
-	}
 	/* Setup reverse map */
 	for (rid = pe->rid; rid < rid_end; rid++)
 		phb->ioda.pe_rmap[rid] = pe->pe_number;
-- 
1.8.3.2
