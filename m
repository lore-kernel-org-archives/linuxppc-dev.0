Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e36.co.us.ibm.com", Issuer "Equifax" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CB49DB6FA3
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jun 2012 18:15:52 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Mon, 4 Jun 2012 02:15:47 -0600
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 73BB7C9005A
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jun 2012 04:15:28 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q548FSQV154742
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jun 2012 04:15:28 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q548FS1Q013100
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jun 2012 05:15:28 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/pci: save P2P bridge resource if possible
Date: Mon,  4 Jun 2012 16:15:25 +0800
Message-Id: <1338797725-2231-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: michael@ellerman.id.au, paulus@samba.org,
 Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When PCI probe flag PCI_REASSIGN_ALL_RSRC has been passed into PCI
core, it's hoped that all resources to be reassigned by PCI core.
As to particular P2P (PCI-to-PCI) bridge, the size of the corresponding
BAR (I/O, MMIO, prefetchable MMIO) is calculated by the resources
required by the PCI devices behind the P2P bridge. That means that
the information like start/end address retrieved from the hardware
registers of the P2P bridge is meainingless in the case. However,
we still count that in and the BARs might have been configured by
firmware with non-zero size. That leads to space waste.

The patch explicitly sets the size of P2P bridge BARs to zero in
case that resource reassignment is expected with PCI probe flag
PCI_REASSIGN_ALL_RSRC. In the result, it will save overall resource
required by the system without waste.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/pci-common.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 8e78e93..0fe214d 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -966,13 +966,14 @@ static void __devinit pcibios_fixup_bridge(struct pci_bus *bus)
 		if (i >= 3 && bus->self->transparent)
 			continue;
 
-		/* If we are going to re-assign everything, mark the resource
-		 * as unset and move it down to 0
+		/* If we're going to reassign everything, we can
+		 * shrink the P2P resource to have size as being
+		 * of 0 in order to save space.
 		 */
 		if (pci_has_flag(PCI_REASSIGN_ALL_RSRC)) {
 			res->flags |= IORESOURCE_UNSET;
-			res->end -= res->start;
 			res->start = 0;
+			res->end = -1;
 			continue;
 		}
 
@@ -1234,7 +1235,14 @@ void pcibios_allocate_bus_resources(struct pci_bus *bus)
 		pr_warning("PCI: Cannot allocate resource region "
 			   "%d of PCI bridge %d, will remap\n", i, bus->number);
 	clear_resource:
-		res->start = res->end = 0;
+		/* The resource might be figured out when doing
+		 * reassignment based on the resources required
+		 * by the downstream PCI devices. Here we set
+		 * the size of the resource to be 0 in order to
+		 * save more space.
+		 */
+		res->start = 0;
+		res->end = -1;
 		res->flags = 0;
 	}
 
-- 
1.7.9.5
