Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga07.intel.com (unknown [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yYSLj0QRNzDrKr
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Nov 2017 04:53:16 +1100 (AEDT)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/2] powerpc/pci: convert to use for_each_pci_bridge()
 helper
Date: Fri, 10 Nov 2017 19:52:29 +0200
Message-Id: <20171110175230.82522-1-andriy.shevchenko@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

...which makes code slightly cleaner.

Requires: d43f59ce6c50 ("PCI: Add for_each_pci_bridge() helper")
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/powerpc/kernel/pci-hotplug.c | 7 ++-----
 arch/powerpc/kernel/pci_of_scan.c | 7 ++-----
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
index 2d71269e7dc1..741f47295188 100644
--- a/arch/powerpc/kernel/pci-hotplug.c
+++ b/arch/powerpc/kernel/pci-hotplug.c
@@ -134,11 +134,8 @@ void pci_hp_add_devices(struct pci_bus *bus)
 		pcibios_setup_bus_devices(bus);
 		max = bus->busn_res.start;
 		for (pass = 0; pass < 2; pass++) {
-			list_for_each_entry(dev, &bus->devices, bus_list) {
-				if (pci_is_bridge(dev))
-					max = pci_scan_bridge(bus, dev,
-							      max, pass);
-			}
+			for_each_pci_bridge(dev, bus)
+				max = pci_scan_bridge(bus, dev, max, pass);
 		}
 	}
 	pcibios_finish_adding_to_bus(bus);
diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index 0d790f8432d2..8bdaa2a6fa62 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -369,11 +369,8 @@ static void __of_scan_bus(struct device_node *node, struct pci_bus *bus,
 	pcibios_setup_bus_devices(bus);
 
 	/* Now scan child busses */
-	list_for_each_entry(dev, &bus->devices, bus_list) {
-		if (pci_is_bridge(dev)) {
-			of_scan_pci_bridge(dev);
-		}
-	}
+	for_each_pci_bridge(dev, bus)
+		of_scan_pci_bridge(dev);
 }
 
 /**
-- 
2.14.2
