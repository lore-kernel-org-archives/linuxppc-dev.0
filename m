Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8ACA72C0142
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Feb 2014 18:25:43 +1100 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 12 Feb 2014 00:25:41 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 5821D19D8041
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Feb 2014 00:25:37 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08025.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1C7PWlH4129098
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Feb 2014 08:25:37 +0100
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1C7PH29010037
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Feb 2014 00:25:17 -0700
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] powerpc/powernv: Rework EEH reset
Date: Wed, 12 Feb 2014 15:24:54 +0800
Message-Id: <1392189896-18882-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>, stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When doing reset in order to recover the affected PE, we issue
hot reset on PE primary bus if it's not root bus. Otherwise, we
issue hot or fundamental reset on root port or PHB accordingly.
For the later case, we didn't cover the situation where PE only
includes root port and it potentially causes kernel crash upon
EEH error to the PE.

The patch reworks the logic of EEH reset to improve the code
readability and also avoid the kernel crash.

Cc: stable@vger.kernel.org
Reported-by: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c |   29 ++++-------------------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index e1e7161..fcb79cf 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -489,8 +489,7 @@ static int ioda_eeh_bridge_reset(struct pci_controller *hose,
 static int ioda_eeh_reset(struct eeh_pe *pe, int option)
 {
 	struct pci_controller *hose = pe->phb;
-	struct eeh_dev *edev;
-	struct pci_dev *dev;
+	struct pci_bus *bus;
 	int ret;
 
 	/*
@@ -519,31 +518,11 @@ static int ioda_eeh_reset(struct eeh_pe *pe, int option)
 	if (pe->type & EEH_PE_PHB) {
 		ret = ioda_eeh_phb_reset(hose, option);
 	} else {
-		if (pe->type & EEH_PE_DEVICE) {
-			/*
-			 * If it's device PE, we didn't refer to the parent
-			 * PCI bus yet. So we have to figure it out indirectly.
-			 */
-			edev = list_first_entry(&pe->edevs,
-					struct eeh_dev, list);
-			dev = eeh_dev_to_pci_dev(edev);
-			dev = dev->bus->self;
-		} else {
-			/*
-			 * If it's bus PE, the parent PCI bus is already there
-			 * and just pick it up.
-			 */
-			dev = pe->bus->self;
-		}
-
-		/*
-		 * Do reset based on the fact that the direct upstream bridge
-		 * is root bridge (port) or not.
-		 */
-		if (dev->bus->number == 0)
+		bus = eeh_pe_bus_get(pe);
+		if (pci_is_root_bus(bus))
 			ret = ioda_eeh_root_reset(hose, option);
 		else
-			ret = ioda_eeh_bridge_reset(hose, dev, option);
+			ret = ioda_eeh_bridge_reset(hose, bus->self, option);
 	}
 
 	return ret;
-- 
1.7.10.4
