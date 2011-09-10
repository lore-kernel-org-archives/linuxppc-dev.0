Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3F42DB71C6
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Sep 2011 00:20:18 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 03/21] powerpc/pci: Call pcie_bus_configure_settings()
Date: Sat, 10 Sep 2011 11:19:50 -0300
Message-Id: <1315664408-16797-3-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1315664408-16797-1-git-send-email-benh@kernel.crashing.org>
References: <1315664408-16797-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This new function is used to properly setup the PCI Express Max Payload Size
(and in some circumstances Max Read Request Size).

Some systems will not operate properly if these aren't set correctly and
the firmware doesn't always do it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/pci-common.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 32656f1..1bd47f3 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1730,6 +1730,17 @@ void __devinit pcibios_scan_phb(struct pci_controller *hose)
 
 	if (mode == PCI_PROBE_NORMAL)
 		hose->last_busno = bus->subordinate = pci_scan_child_bus(bus);
+
+	/* Configure PCI Express settings */
+	if (bus) {
+		struct pci_bus *child;
+		list_for_each_entry(child, &bus->children, node) {
+			struct pci_dev *self = child->self;
+			if (!self)
+				continue;
+			pcie_bus_configure_settings(child, self->pcie_mpss);
+		}
+	}
 }
 
 static void fixup_hide_host_resource_fsl(struct pci_dev *dev)
-- 
1.7.4.1
