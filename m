Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E31C51A01A2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jul 2014 14:42:37 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 21 Jul 2014 14:42:37 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 676473578052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jul 2014 14:42:34 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6L4gIR110617238
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jul 2014 14:42:18 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6L4gXEo020677
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jul 2014 14:42:34 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 4/6] powerpc/powernv: Handle compound PE
Date: Mon, 21 Jul 2014 14:42:33 +1000
Message-Id: <1405917755-28830-5-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1405917755-28830-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1405917755-28830-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: yan@linux.vnet.ibm.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch introduces 3 PHB callbacks: compound PE state retrieval,
force freezing and unfreezing compound PE. The PCI config accessors
and PowerNV EEH backend can use them in subsequent patches.

We don't export the capability of compound PE to EEH core, which
helps avoiding more complexity to EEH core.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 143 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/pci.h      |   3 +
 2 files changed, 146 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 2b659d9..0381a78 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -347,6 +347,146 @@ static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
 	phb->pick_m64_pe = pnv_ioda2_pick_m64_pe;
 }
 
+static void pnv_ioda_freeze_pe(struct pnv_phb *phb, int pe_no)
+{
+	struct pnv_ioda_pe *pe = &phb->ioda.pe_array[pe_no];
+	struct pnv_ioda_pe *slave;
+	s64 rc;
+
+	/* Fetch master PE */
+	if (pe->flags & PNV_IODA_PE_SLAVE) {
+		pe = pe->master;
+		WARN_ON(!pe || !(pe->flags & PNV_IODA_PE_MASTER));
+		pe_no = pe->pe_number;
+	}
+
+	/* Freeze master PE */
+	rc = opal_pci_eeh_freeze_set(phb->opal_id,
+				     pe_no,
+				     OPAL_EEH_ACTION_SET_FREEZE_ALL);
+	if (rc != OPAL_SUCCESS) {
+		pr_warn("%s: Failure %lld freezing PHB#%x-PE#%x\n",
+			__func__, rc, phb->hose->global_number, pe_no);
+		return;
+	}
+
+	/* Freeze slave PEs */
+	if (!(pe->flags & PNV_IODA_PE_MASTER))
+		return;
+
+	list_for_each_entry(slave, &pe->slaves, list) {
+		rc = opal_pci_eeh_freeze_set(phb->opal_id,
+					     slave->pe_number,
+					     OPAL_EEH_ACTION_SET_FREEZE_ALL);
+		if (rc != OPAL_SUCCESS)
+			pr_warn("%s: Failure %lld freezing PHB#%x-PE#%x\n",
+				__func__, rc, phb->hose->global_number,
+				slave->pe_number);
+	}
+}
+
+int pnv_ioda_unfreeze_pe(struct pnv_phb *phb, int pe_no, int opt)
+{
+	struct pnv_ioda_pe *pe, *slave;
+	s64 rc;
+
+	/* Find master PE */
+	pe = &phb->ioda.pe_array[pe_no];
+	if (pe->flags & PNV_IODA_PE_SLAVE) {
+		pe = pe->master;
+		WARN_ON(!pe || !(pe->flags & PNV_IODA_PE_MASTER));
+		pe_no = pe->pe_number;
+	}
+
+	/* Clear frozen state for master PE */
+	rc = opal_pci_eeh_freeze_clear(phb->opal_id, pe_no, opt);
+	if (rc != OPAL_SUCCESS) {
+		pr_warn("%s: Failure %lld clear %d on PHB#%x-PE#%x\n",
+			__func__, rc, opt, phb->hose->global_number, pe_no);
+		return -EIO;
+	}
+
+	if (!(pe->flags & PNV_IODA_PE_MASTER))
+		return 0;
+
+	/* Clear frozen state for slave PEs */
+	list_for_each_entry(slave, &pe->slaves, list) {
+		rc = opal_pci_eeh_freeze_clear(phb->opal_id,
+					     slave->pe_number,
+					     opt);
+		if (rc != OPAL_SUCCESS) {
+			pr_warn("%s: Failure %lld clear %d on PHB#%x-PE#%x\n",
+				__func__, rc, opt, phb->hose->global_number,
+				slave->pe_number);
+			return -EIO;
+		}
+	}
+
+	return 0;
+}
+
+static int pnv_ioda_get_pe_state(struct pnv_phb *phb, int pe_no)
+{
+	struct pnv_ioda_pe *slave, *pe;
+	u8 fstate, state;
+	__be16 pcierr;
+	s64 rc;
+
+	/* Sanity check on PE number */
+	if (pe_no < 0 || pe_no >= phb->ioda.total_pe)
+		return OPAL_EEH_STOPPED_PERM_UNAVAIL;
+
+	/*
+	 * Fetch the master PE and the PE instance might be
+	 * not initialized yet.
+	 */
+	pe = &phb->ioda.pe_array[pe_no];
+	if (pe->flags & PNV_IODA_PE_SLAVE) {
+		pe = pe->master;
+		WARN_ON(!pe || !(pe->flags & PNV_IODA_PE_MASTER));
+		pe_no = pe->pe_number;
+	}
+
+	/* Check the master PE */
+	rc = opal_pci_eeh_freeze_status(phb->opal_id, pe_no,
+					&state, &pcierr, NULL);
+	if (rc != OPAL_SUCCESS) {
+		pr_warn("%s: Failure %lld getting "
+			"PHB#%x-PE#%x state\n",
+			__func__, rc,
+			phb->hose->global_number, pe_no);
+		return OPAL_EEH_STOPPED_TEMP_UNAVAIL;
+	}
+
+	/* Check the slave PE */
+	if (!(pe->flags & PNV_IODA_PE_MASTER))
+		return state;
+
+	list_for_each_entry(slave, &pe->slaves, list) {
+		rc = opal_pci_eeh_freeze_status(phb->opal_id,
+						slave->pe_number,
+						&fstate,
+						&pcierr,
+						NULL);
+		if (rc != OPAL_SUCCESS) {
+			pr_warn("%s: Failure %lld getting "
+				"PHB#%x-PE#%x state\n",
+				__func__, rc,
+				phb->hose->global_number, slave->pe_number);
+			return OPAL_EEH_STOPPED_TEMP_UNAVAIL;
+		}
+
+		/*
+		 * Override the result based on the ascending
+		 * priority.
+		 */
+		if (fstate > state)
+			state = fstate;
+	}
+
+	return state;
+}
+
 /* Currently those 2 are only used when MSIs are enabled, this will change
  * but in the meantime, we need to protect them to avoid warnings
  */
@@ -1626,6 +1766,9 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
 
 
 	phb->hose->ops = &pnv_pci_ops;
+	phb->get_pe_state = pnv_ioda_get_pe_state;
+	phb->freeze_pe = pnv_ioda_freeze_pe;
+	phb->unfreeze_pe = pnv_ioda_unfreeze_pe;
 #ifdef CONFIG_EEH
 	phb->eeh_ops = &ioda_eeh_ops;
 #endif
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index def7171..b160e6b 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -128,6 +128,9 @@ struct pnv_phb {
 	int (*init_m64)(struct pnv_phb *phb);
 	void (*alloc_m64_pe)(struct pnv_phb *phb);
 	int (*pick_m64_pe)(struct pnv_phb *phb, struct pci_bus *bus, int all);
+	int (*get_pe_state)(struct pnv_phb *phb, int pe_no);
+	void (*freeze_pe)(struct pnv_phb *phb, int pe_no);
+	int (*unfreeze_pe)(struct pnv_phb *phb, int pe_no, int opt);
 
 	union {
 		struct {
-- 
1.8.3.2
