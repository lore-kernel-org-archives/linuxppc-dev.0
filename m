Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B8D53B7D06
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Jan 2010 14:10:17 +1100 (EST)
Subject: [PATCH 2/3] powerpc/pci: Add missing hookup to pci_slot
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 27 Jan 2010 14:10:05 +1100
Message-ID: <1264561805.3601.164.camel@pasglop>
Mime-Version: 1.0
Cc: Linux PCI <linux-pci@vger.kernel.org>,
	Breno Leitao <leitao@linux.vnet.ibm.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add missing hookup to existing pci_slot when building the pci_dev from
scratch off the Open Firmware device-tree

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/pci_of_scan.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index 693eb9a..b6b2e86 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -123,6 +123,7 @@ struct pci_dev *of_create_pci_dev(struct device_node *node,
 {
 	struct pci_dev *dev;
 	const char *type;
+	struct pci_slot *slot;
 
 	dev = alloc_pci_dev();
 	if (!dev)
@@ -142,6 +143,10 @@ struct pci_dev *of_create_pci_dev(struct device_node *node,
 	dev->needs_freset = 0;		/* pcie fundamental reset required */
 	set_pcie_port_type(dev);
 
+	list_for_each_entry(slot, &dev->bus->slots, list)
+		if (PCI_SLOT(dev->devfn) == slot->number)
+			dev->slot = slot;
+
 	dev->vendor = get_int_prop(node, "vendor-id", 0xffff);
 	dev->device = get_int_prop(node, "device-id", 0xffff);
 	dev->subsystem_vendor = get_int_prop(node, "subsystem-vendor-id", 0);
