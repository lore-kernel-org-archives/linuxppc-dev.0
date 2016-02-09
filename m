Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 952521A0220
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 15:51:35 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 9 Feb 2016 14:51:35 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 07B172BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 15:51:32 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u194pNqd59703328
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Feb 2016 15:51:32 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u194oxYA025510
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Feb 2016 15:50:59 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v2 1/4] powerpc/eeh: Fix stale cached primary bus
Date: Tue,  9 Feb 2016 15:50:21 +1100
Message-Id: <1454993431-17068-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When PE is created, its primary bus is cached to pe->bus. At later
point, the cached primary bus is returned from eeh_pe_bus_get().
However, we could get stale cached primary bus and run into kernel
crash in one case: full hotplug as part of fenced PHB error recovery
releases all PCI busses under the PHB at unplugging time and recreate
them at plugging time. pe->bus is still dereferencing the PCI bus
that was released.

This adds another PE flag (EEH_PE_PRI_BUS) to represent the validity
of pe->bus. pe->bus is updated when its first child EEH device is
online and the flag is set. Before unplugging in full hotplug for
error recovery, the flag is cleared.

Fixes: 8cdb2833 ("powerpc/eeh: Trace PCI bus from PE")
Cc: stable@vger.kernel.org #v3.11+
Reported-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Reported-by: Pradipta Ghosh <pradghos@in.ibm.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Tested-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               | 1 +
 arch/powerpc/kernel/eeh_driver.c             | 3 +++
 arch/powerpc/kernel/eeh_pe.c                 | 2 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c | 5 ++++-
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index c5eb86f..867c39b 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -81,6 +81,7 @@ struct pci_dn;
 #define EEH_PE_KEEP		(1 << 8)	/* Keep PE on hotplug	*/
 #define EEH_PE_CFG_RESTRICTED	(1 << 9)	/* Block config on error */
 #define EEH_PE_REMOVED		(1 << 10)	/* Removed permanently	*/
+#define EEH_PE_PRI_BUS		(1 << 11)	/* Cached primary bus   */
 
 struct eeh_pe {
 	int type;			/* PE type: PHB/Bus/Device	*/
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 9387421..301be31 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -564,6 +564,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
 	 */
 	eeh_pe_state_mark(pe, EEH_PE_KEEP);
 	if (bus) {
+		eeh_pe_state_clear(pe, EEH_PE_PRI_BUS);
 		pci_lock_rescan_remove();
 		pcibios_remove_pci_devices(bus);
 		pci_unlock_rescan_remove();
@@ -803,6 +804,7 @@ perm_error:
 	 * the their PCI config any more.
 	 */
 	if (frozen_bus) {
+		eeh_pe_state_clear(pe, EEH_PE_PRI_BUS);
 		eeh_pe_dev_mode_mark(pe, EEH_DEV_REMOVED);
 
 		pci_lock_rescan_remove();
@@ -886,6 +888,7 @@ static void eeh_handle_special_event(void)
 					continue;
 
 				/* Notify all devices to be down */
+				eeh_pe_state_clear(pe, EEH_PE_PRI_BUS);
 				bus = eeh_pe_bus_get(phb_pe);
 				eeh_pe_dev_traverse(pe,
 					eeh_report_failure, NULL);
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 8654cb1..127d124 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -931,7 +931,7 @@ struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe)
 		bus = pe->phb->bus;
 	} else if (pe->type & EEH_PE_BUS ||
 		   pe->type & EEH_PE_DEVICE) {
-		if (pe->bus) {
+		if (pe->state & EEH_PE_PRI_BUS) {
 			bus = pe->bus;
 			goto out;
 		}
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 5f152b9..87f47e5 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -444,9 +444,12 @@ static void *pnv_eeh_probe(struct pci_dn *pdn, void *data)
 	 * PCI devices of the PE are expected to be removed prior
 	 * to PE reset.
 	 */
-	if (!edev->pe->bus)
+	if (!(edev->pe->state & EEH_PE_PRI_BUS)) {
 		edev->pe->bus = pci_find_bus(hose->global_number,
 					     pdn->busno);
+		if (edev->pe->bus)
+			edev->pe->state |= EEH_PE_PRI_BUS;
+	}
 
 	/*
 	 * Enable EEH explicitly so that we will do EEH check
-- 
2.1.0
