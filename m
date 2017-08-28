Return-Path: <bryantly@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xgxSC1F67zDq5m
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 02:05:14 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7SG4kQF144455
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 12:05:12 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cmjvy0cwq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 12:05:12 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bryantly@linux.vnet.ibm.com>;
 Mon, 28 Aug 2017 12:05:11 -0400
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: martin.petersen@oracle.com, linuxppc-dev@lists.ozlabs.org,
 "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
 "Bryant G. Ly" <bgly@us.ibm.com>
Subject: [PATCH] powerpc/kernel: Change retrieval of pci_dn
Date: Mon, 28 Aug 2017 11:05:03 -0500
Message-Id: <1503936303-18274-1-git-send-email-bryantly@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For a PCI device it's pci_dn can be retrieved from
pdev->dev.archdata.firmware_data, PCI_DN(devnode), or parent's list.
Thus, we should just use the generic function pci_get_pdn_by_devfn
to get the pci_dn.

Signed-off-by: Bryant G. Ly <bgly@us.ibm.com>
---
 arch/powerpc/kernel/rtas_pci.c | 30 ++----------------------------
 1 file changed, 2 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/kernel/rtas_pci.c b/arch/powerpc/kernel/rtas_pci.c
index 73f1934..c21e6c5 100644
--- a/arch/powerpc/kernel/rtas_pci.c
+++ b/arch/powerpc/kernel/rtas_pci.c
@@ -91,25 +91,13 @@ static int rtas_pci_read_config(struct pci_bus *bus,
 				unsigned int devfn,
 				int where, int size, u32 *val)
 {
-	struct device_node *busdn, *dn;
 	struct pci_dn *pdn;
-	bool found = false;
 	int ret;
 
 	/* Search only direct children of the bus */
 	*val = 0xFFFFFFFF;
-	busdn = pci_bus_to_OF_node(bus);
-	for (dn = busdn->child; dn; dn = dn->sibling) {
-		pdn = PCI_DN(dn);
-		if (pdn && pdn->devfn == devfn
-		    && of_device_is_available(dn)) {
-			found = true;
-			break;
-		}
-	}
 
-	if (!found)
-		return PCIBIOS_DEVICE_NOT_FOUND;
+	pdn = pci_get_pdn_by_devfn(bus, devfn);
 
 	ret = rtas_read_config(pdn, where, size, val);
 	if (*val == EEH_IO_ERROR_VALUE(size) &&
@@ -153,23 +141,9 @@ static int rtas_pci_write_config(struct pci_bus *bus,
 				 unsigned int devfn,
 				 int where, int size, u32 val)
 {
-	struct device_node *busdn, *dn;
 	struct pci_dn *pdn;
-	bool found = false;
-
-	/* Search only direct children of the bus */
-	busdn = pci_bus_to_OF_node(bus);
-	for (dn = busdn->child; dn; dn = dn->sibling) {
-		pdn = PCI_DN(dn);
-		if (pdn && pdn->devfn == devfn
-		    && of_device_is_available(dn)) {
-			found = true;
-			break;
-		}
-	}
 
-	if (!found)
-		return PCIBIOS_DEVICE_NOT_FOUND;
+	pdn = pci_get_pdn_by_devfn(bus, devfn);
 
 	return rtas_write_config(pdn, where, size, val);
 }
-- 
2.5.4 (Apple Git-61)
