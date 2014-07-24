Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 20CDE1A0950
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 16:22:58 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Thu, 24 Jul 2014 11:52:57 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 0E980125805E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 11:52:47 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6O6Ogmw35848292
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 11:54:42 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6O6Mo6C011121
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 11:52:51 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com,
 yan@linux.vnet.ibm.com, qiudayu@linux.vnet.ibm.com
Subject: [PATCH V7 11/17] powerpc/powernv: Add function to deconfig a PE
Date: Thu, 24 Jul 2014 14:22:21 +0800
Message-Id: <1406182947-11302-12-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1406182947-11302-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1406182947-11302-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On PowerNV platform, it will support dynamic PE allocation and deallocation.

This patch adds a function to release those resources related to a PE. Also
fix a bug when it is the root bus, there is no bridge associated.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |   90 ++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index d66a76b..8318b07 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -505,6 +505,93 @@ static struct pnv_ioda_pe *pnv_ioda_get_pe(struct pci_dev *dev)
 }
 #endif /* CONFIG_PCI_MSI */
 
+static int pnv_ioda_deconfigure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
+{
+	struct pci_dev *parent;
+	uint8_t bcomp, dcomp, fcomp;
+	int64_t rc;
+	long rid_end, rid;
+
+	/* Currently, we just deconfigure VF PE. Bus PE will always there.*/
+	if (pe->pbus) {
+		int count;
+
+		dcomp = OPAL_IGNORE_RID_DEVICE_NUMBER;
+		fcomp = OPAL_IGNORE_RID_FUNCTION_NUMBER;
+		parent = pe->pbus->self;
+		if (pe->flags & PNV_IODA_PE_BUS_ALL)
+			count = pe->pbus->busn_res.end - pe->pbus->busn_res.start + 1;
+		else
+			count = 1;
+
+		switch(count) {
+		case  1: bcomp = OpalPciBusAll;         break;
+		case  2: bcomp = OpalPciBus7Bits;       break;
+		case  4: bcomp = OpalPciBus6Bits;       break;
+		case  8: bcomp = OpalPciBus5Bits;       break;
+		case 16: bcomp = OpalPciBus4Bits;       break;
+		case 32: bcomp = OpalPciBus3Bits;       break;
+		default:
+			pr_err("%s: Number of subordinate busses %d"
+			       " unsupported\n",
+			       pci_is_root_bus(pe->pbus)?"root bus":pci_name(pe->pbus->self),
+			       count);
+			/* Do an exact match only */
+			bcomp = OpalPciBusAll;
+		}
+		rid_end = pe->rid + (count << 8);
+	} else {
+		parent = pe->pdev->bus->self;
+		bcomp = OpalPciBusAll;
+		dcomp = OPAL_COMPARE_RID_DEVICE_NUMBER;
+		fcomp = OPAL_COMPARE_RID_FUNCTION_NUMBER;
+		rid_end = pe->rid + 1;
+	}
+
+	/* Disable MVT on IODA1 */
+	if (phb->type == PNV_PHB_IODA1) {
+		rc = opal_pci_set_mve_enable(phb->opal_id,
+					     pe->mve_number, OPAL_DISABLE_MVE);
+		if (rc) {
+			pe_err(pe, "OPAL error %ld enabling MVE %d\n",
+			       rc, pe->mve_number);
+			pe->mve_number = -1;
+		}
+	}
+	/* Clear the reverse map */
+	for (rid = pe->rid; rid < rid_end; rid++)
+		phb->ioda.pe_rmap[rid] = 0;
+
+	/* Release from all parents PELT-V */
+	while (parent) {
+		struct pci_dn *pdn = pci_get_pdn(parent);
+		if (pdn && pdn->pe_number != IODA_INVALID_PE) {
+			rc = opal_pci_set_peltv(phb->opal_id, pdn->pe_number,
+						pe->pe_number, OPAL_REMOVE_PE_FROM_DOMAIN);
+			/* XXX What to do in case of error ? */
+		}
+		parent = parent->bus->self;
+	}
+
+	opal_pci_eeh_freeze_set(phb->opal_id, pe->pe_number,
+				  OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
+
+	/* Dissociate PE in PELT */
+	rc = opal_pci_set_peltv(phb->opal_id, pe->pe_number,
+				pe->pe_number, OPAL_REMOVE_PE_FROM_DOMAIN);
+	if (rc)
+		pe_warn(pe, "OPAL error %ld remove self from PELTV\n", rc);
+	rc = opal_pci_set_pe(phb->opal_id, pe->pe_number, pe->rid,
+			     bcomp, dcomp, fcomp, OPAL_UNMAP_PE);
+	if (rc)
+		pe_err(pe, "OPAL error %ld trying to setup PELT table\n", rc);
+
+	pe->pbus = NULL;
+	pe->pdev = NULL;
+
+	return 0;
+}
+
 static int pnv_ioda_configure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
 {
 	struct pci_dev *parent;
@@ -533,7 +620,8 @@ static int pnv_ioda_configure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
 		default:
 			pr_err("%s: Number of subordinate busses %d"
 			       " unsupported\n",
-			       pci_name(pe->pbus->self), count);
+			       pci_is_root_bus(pe->pbus)?"root bus":pci_name(pe->pbus->self),
+			       count);
 			/* Do an exact match only */
 			bcomp = OpalPciBusAll;
 		}
-- 
1.7.9.5
