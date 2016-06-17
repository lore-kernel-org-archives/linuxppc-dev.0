Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rW4rD5snlzDqsd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 13:05:32 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rW4rD1m2bz9sdn
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Jun 2016 13:05:31 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5H33w06072415
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2016 23:05:30 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23kbtwb8rb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2016 23:05:30 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 17 Jun 2016 13:05:27 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id BFE172BB0054
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Jun 2016 13:05:25 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5H35Pah9830830
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Jun 2016 13:05:25 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5H35Pk9014412
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Jun 2016 13:05:25 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/eeh: Fix invalid cached PE primary bus
Date: Fri, 17 Jun 2016 13:05:11 +1000
Message-Id: <1466132722-13512-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PE primary bus cannot be got from its child devices when having
full hotplug in error recovery. The PE primary bus is cached, which
is done in commit <05ba75f84864> ("powerpc/eeh: Fix stale cached primary
bus"). In eeh_reset_device(), the flag (EEH_PE_PRI_BUS) is cleared
before the PCI hot remove. eeh_pe_bus_get() then returns NULL as the
PE primary bus in pnv_eeh_reset() and it crashes the kernel eventually.

This fixes the issue by clearing the flag (EEH_PE_PRI_BUS) before the
PCI hot add. With it, the PowerNV EEH reset backend (pnv_eeh_reset())
can get valid PE primary bus through eeh_pe_bus_get().

Cc: stable@vger.kernel.org # v4.6+
Fixes: 67086e32b564 ("powerpc/eeh: powerpc/eeh: Support error recovery for VF PE")
Reported-by: Pridhiviraj Paidipeddi <ppaiddipe@in.ibm.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_driver.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 2714a3b..b5f73cb 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -642,7 +642,6 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
 		if (pe->type & EEH_PE_VF) {
 			eeh_pe_dev_traverse(pe, eeh_rmv_device, NULL);
 		} else {
-			eeh_pe_state_clear(pe, EEH_PE_PRI_BUS);
 			pci_lock_rescan_remove();
 			pci_hp_remove_devices(bus);
 			pci_unlock_rescan_remove();
@@ -692,10 +691,12 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
 		 */
 		edev = list_first_entry(&pe->edevs, struct eeh_dev, list);
 		eeh_pe_traverse(pe, eeh_pe_detach_dev, NULL);
-		if (pe->type & EEH_PE_VF)
+		if (pe->type & EEH_PE_VF) {
 			eeh_add_virt_device(edev, NULL);
-		else
+		} else {
+			eeh_pe_state_clear(pe, EEH_PE_PRI_BUS);
 			pci_hp_add_devices(bus);
+		}
 	} else if (frozen_bus && rmv_data->removed) {
 		pr_info("EEH: Sleep 5s ahead of partial hotplug\n");
 		ssleep(5);
-- 
2.1.0
