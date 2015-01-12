Return-Path: <yinghai@kernel.org>
Received: from userp1050.oracle.com (userp1050.oracle.com [156.151.31.82])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4A3DA1A064E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jan 2015 06:25:23 +1100 (AEDT)
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by userp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 t0CJPKYA029986
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jan 2015 19:25:21 GMT
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 09/10] PCI,
 powerpc: clip firmware assigned resource under parent bridge's
Date: Mon, 12 Jan 2015 11:23:19 -0800
Message-Id: <1421090600-9750-10-git-send-email-yinghai@kernel.org>
In-Reply-To: <1421090600-9750-1-git-send-email-yinghai@kernel.org>
References: <1421090600-9750-1-git-send-email-yinghai@kernel.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Andrew Murray <amurray@embedded-bits.co.uk>,
 Sebastian Ott <sebott@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, linux-pci@vger.kernel.org,
 Yinghai Lu <yinghai@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some bios put range that is not fully coverred by root bus resources.
Try to clip them and update them in pci bridge bars.

We'd like to fix other arches instead of just x86.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=85491
Reported-by: Marek Kordik <kordikmarek@gmail.com>
Fixes: 5b28541552ef ("PCI: Restrict 64-bit prefetchable bridge windows to 64-bit resources")
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: Anton Blanchard <anton@samba.org>
Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: Andrew Murray <amurray@embedded-bits.co.uk>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kernel/pci-common.c | 43 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 37d512d..6909546 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1148,6 +1148,7 @@ static void pcibios_allocate_bus_resources(struct pci_bus *bus)
 	struct pci_bus *b;
 	int i;
 	struct resource *res, *pr;
+	bool changed = false;
 
 	pr_debug("PCI: Allocating bus resources for %04x:%02x...\n",
 		 pci_domain_nr(bus), bus->number);
@@ -1184,6 +1185,8 @@ static void pcibios_allocate_bus_resources(struct pci_bus *bus)
 			 pr, (pr && pr->name) ? pr->name : "nil");
 
 		if (pr && !(pr->flags & IORESOURCE_UNSET)) {
+			struct pci_dev *dev = bus->self;
+
 			if (request_resource(pr, res) == 0)
 				continue;
 			/*
@@ -1193,6 +1196,16 @@ static void pcibios_allocate_bus_resources(struct pci_bus *bus)
 			 */
 			if (reparent_resources(pr, res) == 0)
 				continue;
+
+			if (dev && i >= PCI_BRIDGE_RESOURCES &&
+			    i < PCI_NUM_RESOURCES &&
+			    (dev->class >> 8) == PCI_CLASS_BRIDGE_PCI &&
+			    pci_bus_clip_resource(dev, res)) {
+				changed = true;
+				if (pci_claim_resource(dev, i) >= 0)
+					continue;
+			}
+
 		}
 		pr_warning("PCI: Cannot allocate resource region "
 			   "%d of PCI bridge %d, will remap\n", i, bus->number);
@@ -1208,6 +1221,9 @@ static void pcibios_allocate_bus_resources(struct pci_bus *bus)
 		res->flags = 0;
 	}
 
+	if (changed)
+		pci_setup_bridge(bus);
+
 	list_for_each_entry(b, &bus->children, node)
 		pcibios_allocate_bus_resources(b);
 }
@@ -1225,6 +1241,13 @@ static inline void alloc_resource(struct pci_dev *dev, int idx)
 	pr = pci_find_parent_resource(dev, r);
 	if (!pr || (pr->flags & IORESOURCE_UNSET) ||
 	    request_resource(pr, r) < 0) {
+		/* try again with clip */
+		if (idx != PCI_ROM_RESOURCE && pci_bus_clip_resource(dev, r)) {
+			pci_update_resource(dev, idx);
+			if (pci_claim_resource(dev, idx) >= 0)
+				return;
+		}
+
 		printk(KERN_WARNING "PCI: Cannot allocate resource region %d"
 		       " of device %s, will remap\n", idx, pci_name(dev));
 		if (pr)
@@ -1386,6 +1409,7 @@ void pcibios_claim_one_bus(struct pci_bus *bus)
 	struct pci_bus *child_bus;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
+		bool changed = false;
 		int i;
 
 		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
@@ -1401,8 +1425,25 @@ void pcibios_claim_one_bus(struct pci_bus *bus)
 				 (unsigned long long)r->end,
 				 (unsigned int)r->flags);
 
-			pci_claim_resource(dev, i);
+			if (pci_claim_resource(dev, i) >= 0)
+				continue;
+
+			if (dev->subordinate &&
+			    i >= PCI_BRIDGE_RESOURCES &&
+			    i < PCI_NUM_RESOURCES &&
+			    (dev->class >> 8) == PCI_CLASS_BRIDGE_PCI &&
+			    pci_bus_clip_resource(dev, r)) {
+				changed = true;
+				pci_claim_resource(dev, i);
+			} else if (i < PCI_BRIDGE_RESOURCES &&
+				   i != PCI_ROM_RESOURCE &&
+				   pci_bus_clip_resource(dev, r)) {
+					pci_update_resource(dev, i);
+					pci_claim_resource(dev, i);
+			}
 		}
+		if (changed)
+			pci_setup_bridge(dev->subordinate);
 	}
 
 	list_for_each_entry(child_bus, &bus->children, node)
-- 
1.8.4.5
