Return-Path: <yinghai@kernel.org>
Received: from rcsinet15.oracle.com (rcsinet15.oracle.com [148.87.113.117])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "rcsinet15.oracle.com",
 Issuer "VeriSign Class 3 International Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D696CB6FA3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Mar 2012 10:08:44 +1100 (EST)
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Tony Luck <tony.luck@intel.com>, David Miller <davem@davemloft.net>,
 x86 <x86@kernel.org>
Subject: [PATCH 28/39] PCI, powerpc: Register busn_res for root buses
Date: Wed, 29 Feb 2012 15:07:27 -0800
Message-Id: <1330556858-11768-29-git-send-email-yinghai@kernel.org>
In-Reply-To: <1330556858-11768-1-git-send-email-yinghai@kernel.org>
References: <1330556858-11768-1-git-send-email-yinghai@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Paul Mackerras <paulus@samba.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Yinghai Lu <yinghai@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/include/asm/pci-bridge.h |    1 +
 arch/powerpc/kernel/pci-common.c      |   10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 5d48765..11cebf0 100644
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
index 910b9de..ee8c0c9 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1648,6 +1648,11 @@ void __devinit pcibios_scan_phb(struct pci_controller *hose)
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
@@ -1670,8 +1675,11 @@ void __devinit pcibios_scan_phb(struct pci_controller *hose)
 		of_scan_bus(node, bus);
 	}
 
-	if (mode == PCI_PROBE_NORMAL)
+	if (mode == PCI_PROBE_NORMAL) {
+		pci_bus_update_busn_res_end(bus, 255);
 		hose->last_busno = bus->subordinate = pci_scan_child_bus(bus);
+		pci_bus_update_busn_res_end(bus, bus->subordinate);
+	}
 
 	/* Platform gets a chance to do some global fixups before
 	 * we proceed to resource allocation
-- 
1.7.7
