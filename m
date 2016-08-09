Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7rNG5xyvzDqQ5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 20:38:22 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: gwshan@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
 Michael Neuling <mikey@neuling.org>
Subject: [PATCH stable 4.6 1/4] powerpc/eeh: Fix invalid cached PE primary bus
Date: Tue,  9 Aug 2016 20:38:05 +1000
Message-Id: <1470739088-17850-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1470739088-17850-1-git-send-email-mpe@ellerman.id.au>
References: <1470739088-17850-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Gavin Shan <gwshan@linux.vnet.ibm.com>

commit a3aa256b7258b3d19f8b44557cc64525a993b941 upstream.

Backport required due to rename of pcibios_add_pci_devices() to
pci_hp_add_devices() upstream - mpe.

The PE primary bus cannot be got from its child devices when having
full hotplug in error recovery. The PE primary bus is cached, which
is done in commit <05ba75f84864> ("powerpc/eeh: Fix stale cached primary
bus"). In eeh_reset_device(), the flag (EEH_PE_PRI_BUS) is cleared
before the PCI hot remove. eeh_pe_bus_get() then returns NULL as the
PE primary bus in pnv_eeh_reset() and it crashes the kernel eventually.

This fixes the issue by clearing the flag (EEH_PE_PRI_BUS) before the
PCI hot add. With it, the PowerNV EEH reset backend (pnv_eeh_reset())
can get valid PE primary bus through eeh_pe_bus_get().

Fixes: 67086e32b564 ("powerpc/eeh: powerpc/eeh: Support error recovery for VF PE")
Reported-by: Pridhiviraj Paidipeddi <ppaiddipe@in.ibm.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/eeh_driver.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 31e4c7e1a4b4..c42627645b54 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -648,7 +648,6 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
 		if (pe->type & EEH_PE_VF) {
 			eeh_pe_dev_traverse(pe, eeh_rmv_device, NULL);
 		} else {
-			eeh_pe_state_clear(pe, EEH_PE_PRI_BUS);
 			pci_lock_rescan_remove();
 			pcibios_remove_pci_devices(bus);
 			pci_unlock_rescan_remove();
@@ -698,10 +697,12 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
 		 */
 		edev = list_first_entry(&pe->edevs, struct eeh_dev, list);
 		eeh_pe_traverse(pe, eeh_pe_detach_dev, NULL);
-		if (pe->type & EEH_PE_VF)
+		if (pe->type & EEH_PE_VF) {
 			eeh_add_virt_device(edev, NULL);
-		else
+		} else {
+			eeh_pe_state_clear(pe, EEH_PE_PRI_BUS);
 			pcibios_add_pci_devices(bus);
+		}
 	} else if (frozen_bus && rmv_data->removed) {
 		pr_info("EEH: Sleep 5s ahead of partial hotplug\n");
 		ssleep(5);
-- 
2.7.4
