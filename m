Return-Path: <yinghai@kernel.org>
Received: from acsinet14.oracle.com (acsinet14.oracle.com [141.146.126.236])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "acsinet14.oracle.com",
 Issuer "VeriSign Class 3 International Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EAC2AB6FA4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2012 06:30:44 +1000 (EST)
Received: from acsinet15.oracle.com (acsinet15.oracle.com [141.146.126.227])
 by acsinet14.oracle.com (Sentrion-MTA-4.2.2/Sentrion-MTA-4.2.2) with ESMTP id
 q47KUgQo004460
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 May 2012 20:30:42 GMT
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Tony Luck <tony.luck@intel.com>, David Miller <davem@davemloft.net>,
 x86 <x86@kernel.org>
Subject: [PATCH 17/21] powerpc/PCI: register busn_res for root buses
Date: Mon,  7 May 2012 13:30:02 -0700
Message-Id: <1336422606-4244-18-git-send-email-yinghai@kernel.org>
In-Reply-To: <1336422606-4244-1-git-send-email-yinghai@kernel.org>
References: <1336422606-4244-1-git-send-email-yinghai@kernel.org>
Cc: linux-arch@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add the host bridge bus number aperture to the resource list.
Like the MMIO and I/O port apertures, this is used when assigning
resources to hot-added devices or in the case of conflicts.

[bhelgaas: write changelog]
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/include/asm/pci-bridge.h |    1 +
 arch/powerpc/kernel/pci-common.c      |   17 +++++++++++------
 arch/powerpc/kernel/pci_of_scan.c     |    2 +-
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index ac39e6a..8cccbee 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -30,6 +30,7 @@ struct pci_controller {
 	int first_busno;
 	int last_busno;
 	int self_busno;
+	struct resource busn;
 
 	void __iomem *io_base_virt;
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 3532b53..7320f36 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1637,6 +1637,11 @@ void __devinit pcibios_scan_phb(struct pci_controller *hose)
 	/* Wire up PHB bus resources */
 	pcibios_setup_phb_resources(hose, &resources);
 
+	hose->busn.start = hose->first_busno;
+	hose->busn.end	 = hose->last_busno;
+	hose->busn.flags = IORESOURCE_BUS;
+	pci_add_resource(&resources, &hose->busn);
+
 	/* Create an empty bus for the toplevel */
 	bus = pci_create_root_bus(hose->parent, hose->first_busno,
 				  hose->ops, hose, &resources);
@@ -1646,7 +1651,6 @@ void __devinit pcibios_scan_phb(struct pci_controller *hose)
 		pci_free_resource_list(&resources);
 		return;
 	}
-	bus->busn_res.start = hose->first_busno;
 	hose->bus = bus;
 
 	/* Get probe mode and perform scan */
@@ -1654,13 +1658,14 @@ void __devinit pcibios_scan_phb(struct pci_controller *hose)
 	if (node && ppc_md.pci_probe_mode)
 		mode = ppc_md.pci_probe_mode(bus);
 	pr_debug("    probe mode: %d\n", mode);
-	if (mode == PCI_PROBE_DEVTREE) {
-		bus->busn_res.end = hose->last_busno;
+	if (mode == PCI_PROBE_DEVTREE)
 		of_scan_bus(node, bus);
-	}
 
-	if (mode == PCI_PROBE_NORMAL)
-		hose->last_busno = bus->busn_res.end = pci_scan_child_bus(bus);
+	if (mode == PCI_PROBE_NORMAL) {
+		pci_bus_update_busn_res_end(bus, 255);
+		hose->last_busno = pci_scan_child_bus(bus);
+		pci_bus_update_busn_res_end(bus, hose->last_busno);
+	}
 
 	/* Platform gets a chance to do some global fixups before
 	 * we proceed to resource allocation
diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index a36281a..ae5ea5e 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -240,7 +240,7 @@ void __devinit of_scan_pci_bridge(struct pci_dev *dev)
 	}
 
 	bus->primary = dev->bus->number;
-	bus->busn_res.end = busrange[1];
+	pci_bus_insert_busn_res(bus, busrange[0], busrange[1]);
 	bus->bridge_ctl = 0;
 
 	/* parse ranges property */
-- 
1.7.7
