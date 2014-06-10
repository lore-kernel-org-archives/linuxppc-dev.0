Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 29A9D1A00D9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 11:57:08 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Tue, 10 Jun 2014 11:57:06 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id A65003578047
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 11:57:02 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5A1uk8Z7274900
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 11:56:47 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5A1v1DX023939
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 11:57:02 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: benh@au1.ibm.com
Subject: [RFC PATCH V3 07/17] ppc/pnv: Add function to deconfig a PE
Date: Tue, 10 Jun 2014 09:56:29 +0800
Message-Id: <1402365399-5121-8-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
 gwshan@linux.vnet.ibm.com, qiudayu@linux.vnet.ibm.com, bhelgaas@google.com,
 yan@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On PowerNV platform, it will support dynamic PE allocation and deallocation.

This patch adds a function to release those resources related to a PE.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |   77 +++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 8ca3926..87cb3089 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -330,6 +330,83 @@ static struct pnv_ioda_pe *pnv_ioda_get_pe(struct pci_dev *dev)
 }
 #endif /* CONFIG_PCI_MSI */
 
+static int pnv_ioda_deconfigure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
+{
+	struct pci_dev *parent;
+	uint8_t bcomp, dcomp, fcomp;
+	int64_t rc;
+	long rid_end, rid;
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
+			       pci_name(pe->pbus->self), count);
+			/* Do an exact match only */
+			bcomp = OpalPciBusAll;
+		}
+		rid_end = pe->rid + (count << 8);
+	}else {
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
+	/* Dissociate PE in PELT */
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
-- 
1.7.9.5
