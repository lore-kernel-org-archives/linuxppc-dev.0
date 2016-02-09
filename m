Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 23E931A0193
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 15:51:37 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 9 Feb 2016 14:51:36 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 4FCA53578052
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 15:51:32 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u194pO1s19202074
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Feb 2016 15:51:32 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u194oxui025519
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Feb 2016 15:51:00 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v2 3/4] powerpc/eeh: Reworked eeh_pe_bus_get()
Date: Tue,  9 Feb 2016 15:50:23 +1100
Message-Id: <1454993431-17068-3-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1454993431-17068-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1454993431-17068-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The original implementation is ugly: unnecessary if statements and
"out" tag. This reworks the function to avoid above weaknesses. No
functional changes introduced.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
---
 arch/powerpc/kernel/eeh_pe.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 127d124..faaf19e 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -923,25 +923,21 @@ out:
  */
 struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe)
 {
-	struct pci_bus *bus = NULL;
 	struct eeh_dev *edev;
 	struct pci_dev *pdev;
 
-	if (pe->type & EEH_PE_PHB) {
-		bus = pe->phb->bus;
-	} else if (pe->type & EEH_PE_BUS ||
-		   pe->type & EEH_PE_DEVICE) {
-		if (pe->state & EEH_PE_PRI_BUS) {
-			bus = pe->bus;
-			goto out;
-		}
+	if (pe->type & EEH_PE_PHB)
+		return pe->phb->bus;
 
-		edev = list_first_entry(&pe->edevs, struct eeh_dev, list);
-		pdev = eeh_dev_to_pci_dev(edev);
-		if (pdev)
-			bus = pdev->bus;
-	}
+	/* The primary bus might be cached during probe time */
+	if (pe->state & EEH_PE_PRI_BUS)
+		return pe->bus;
 
-out:
-	return bus;
+	/* Retrieve the parent PCI bus of first (top) PCI device */
+	edev = list_first_entry_or_null(&pe->edevs, struct eeh_dev, list);
+	pdev = eeh_dev_to_pci_dev(edev);
+	if (pdev)
+		return pdev->bus;
+
+	return NULL;
 }
-- 
2.1.0
