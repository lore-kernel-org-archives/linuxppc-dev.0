Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 121511400E2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 17:59:50 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 29 Apr 2014 17:59:49 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 7C8EC2BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 17:59:46 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3T7xVcZ7340528
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 17:59:31 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3T7xjYK020751
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 17:59:46 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc/eeh: Dump PE location code
Date: Tue, 29 Apr 2014 18:00:01 +1000
Message-Id: <1398758401-23022-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As Ben suggested, it's meaningful to dump PE's location code
for site engineers when hitting EEH errors. The patch introduces
function eeh_pe_loc_get() to retireve the location code from
dev-tree so that we can output it when hitting EEH errors.

If primary PE bus is root bus, the PHB's dev-node would be tried
prior to root port's dev-node. Otherwise, the upstream bridge's
dev-node of the primary PE bus will be check for the location code
directly.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h            |  1 +
 arch/powerpc/kernel/eeh.c                 |  9 ++---
 arch/powerpc/kernel/eeh_pe.c              | 60 +++++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/eeh-ioda.c | 27 ++++++++------
 4 files changed, 82 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index d12529f..7782056 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -255,6 +255,7 @@ void *eeh_pe_traverse(struct eeh_pe *root,
 void *eeh_pe_dev_traverse(struct eeh_pe *root,
 		eeh_traverse_func fn, void *flag);
 void eeh_pe_restore_bars(struct eeh_pe *pe);
+const char *eeh_pe_loc_get(struct eeh_pe *pe);
 struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe);
 
 void *eeh_dev_init(struct device_node *dn, void *data);
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 3764fb7..9f8de75 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -329,8 +329,8 @@ static int eeh_phb_check_failure(struct eeh_pe *pe)
 	eeh_pe_state_mark(phb_pe, EEH_PE_ISOLATED);
 	eeh_serialize_unlock(flags);
 
-	pr_err("EEH: PHB#%x failure detected\n",
-		phb_pe->phb->global_number);
+	pr_err("EEH: PHB#%x (%s) failure detected\n",
+		phb_pe->phb->global_number, eeh_pe_loc_get(phb_pe));
 	dump_stack();
 	eeh_send_failure_event(phb_pe);
 
@@ -459,8 +459,9 @@ int eeh_dev_check_failure(struct eeh_dev *edev)
 	 * a stack trace will help the device-driver authors figure
 	 * out what happened.  So print that out.
 	 */
-	pr_err("EEH: Frozen PE#%x detected on PHB#%x\n",
-		pe->addr, pe->phb->global_number);
+	pr_err("EEH: Frozen PHB#%x-PE#%x (%s) detected\n",
+		pe->phb->global_number, pe->addr,
+		eeh_pe_loc_get(pe));
 	dump_stack();
 
 	eeh_send_failure_event(pe);
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 995c2a2..fbd01eb 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -792,6 +792,66 @@ void eeh_pe_restore_bars(struct eeh_pe *pe)
 }
 
 /**
+ * eeh_pe_loc_get - Retrieve location code binding to the given PE
+ * @pe: EEH PE
+ *
+ * Retrieve the location code of the given PE. If the primary PE bus
+ * is root bus, we will grab location code from PHB device tree node
+ * or root port. Otherwise, the upstream bridge's device tree node
+ * of the primary PE bus will be checked for the location code.
+ */
+const char *eeh_pe_loc_get(struct eeh_pe *pe)
+{
+	struct pci_controller *hose;
+	struct pci_bus *bus = eeh_pe_bus_get(pe);
+	struct pci_dev *pdev;
+	struct device_node *dn;
+	const char *loc;
+
+	if (!bus)
+		return "N/A";
+
+	/* PHB PE or root PE ? */
+	if (pci_is_root_bus(bus)) {
+		hose = pci_bus_to_host(bus);
+		loc = of_get_property(hose->dn,
+				"ibm,loc-code", NULL);
+		if (loc)
+			return loc;
+		loc = of_get_property(hose->dn,
+				"ibm,io-base-loc-code", NULL);
+		if (loc)
+			return loc;
+
+		pdev = pci_get_slot(bus, 0x0);
+	} else {
+		pdev = bus->self;
+	}
+
+	if (!pdev) {
+		loc = "N/A";
+		goto out;
+	}
+
+	dn = pci_device_to_OF_node(pdev);
+	if (!dn) {
+		loc = "N/A";
+		goto out;
+	}
+
+	loc = of_get_property(dn, "ibm,loc-code", NULL);
+	if (!loc)
+		loc = of_get_property(dn, "ibm,slot-location-code", NULL);
+	if (!loc)
+		loc = "N/A";
+
+out:
+	if (pci_is_root_bus(bus) && pdev)
+		pci_dev_put(pdev);
+	return loc;
+}
+
+/**
  * eeh_pe_bus_get - Retrieve PCI bus according to the given PE
  * @pe: EEH PE
  *
diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 79d0cdf..e5b88c5 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -851,18 +851,21 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 		case OPAL_EEH_PHB_ERROR:
 			if (severity == OPAL_EEH_SEV_PHB_DEAD) {
 				*pe = phb_pe;
-				pr_err("EEH: dead PHB#%x detected\n",
-					hose->global_number);
+				pr_err("EEH: dead PHB#%x (%s) detected\n",
+					hose->global_number,
+					eeh_pe_loc_get(phb_pe));
 				ret = EEH_NEXT_ERR_DEAD_PHB;
 			} else if (severity == OPAL_EEH_SEV_PHB_FENCED) {
 				*pe = phb_pe;
-				pr_err("EEH: fenced PHB#%x detected\n",
-					hose->global_number);
+				pr_err("EEH: Fenced PHB#%x (%s) detected\n",
+					hose->global_number,
+					eeh_pe_loc_get(phb_pe));
 				ret = EEH_NEXT_ERR_FENCED_PHB;
 			} else if (severity == OPAL_EEH_SEV_INF) {
-				pr_info("EEH: PHB#%x informative error "
+				pr_info("EEH: PHB#%x (%s) informative error "
 					"detected\n",
-					hose->global_number);
+					hose->global_number,
+					eeh_pe_loc_get(phb_pe));
 				ioda_eeh_phb_diag(hose);
 				ret = EEH_NEXT_ERR_NONE;
 			}
@@ -881,16 +884,18 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 			 */
 			if (ioda_eeh_get_pe(hose, frozen_pe_no, pe)) {
 				*pe = phb_pe;
-				pr_err("EEH: Escalated fenced PHB#%x "
-				       "detected for PE#%llx\n",
+				pr_err("EEH: Escalated frozen PHB#%x-"
+				       "PE#%llx (%s) detected\n",
 					hose->global_number,
-					frozen_pe_no);
+					frozen_pe_no,
+					eeh_pe_loc_get(phb_pe));
 				ret = EEH_NEXT_ERR_FENCED_PHB;
 			} else if ((*pe)->state & EEH_PE_ISOLATED) {
 				ret = EEH_NEXT_ERR_NONE;
 			} else {
-				pr_err("EEH: Frozen PE#%x on PHB#%x detected\n",
-					(*pe)->addr, (*pe)->phb->global_number);
+				pr_err("EEH: Frozen PHB#%x-PE#%x (%s) detected\n",
+					(*pe)->phb->global_number, (*pe)->addr,
+					eeh_pe_loc_get(*pe));
 				ret = EEH_NEXT_ERR_FROZEN_PE;
 			}
 
-- 
1.8.3.2
