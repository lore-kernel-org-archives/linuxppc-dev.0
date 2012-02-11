Return-Path: <yinghai@kernel.org>
Received: from rcsinet15.oracle.com (rcsinet15.oracle.com [148.87.113.117])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "rcsinet15.oracle.com",
 Issuer "VeriSign Class 3 International Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D5939B6F9F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Feb 2012 15:07:13 +1100 (EST)
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Tony Luck <tony.luck@intel.com>
Subject: [PATCH 07/22] PCI, powerpc: Register busn_res for root buses
Date: Fri, 10 Feb 2012 20:06:10 -0800
Message-Id: <1328933185-15154-8-git-send-email-yinghai@kernel.org>
In-Reply-To: <1328933185-15154-1-git-send-email-yinghai@kernel.org>
References: <1328933185-15154-1-git-send-email-yinghai@kernel.org>
Cc: linux-arch@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Paul Mackerras <paulus@samba.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
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
 arch/powerpc/kernel/pci-common.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index cce98d7..501f29b 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1732,6 +1732,8 @@ void __devinit pcibios_scan_phb(struct pci_controller *hose)
 	bus->secondary = hose->first_busno;
 	hose->bus = bus;
 
+	pci_bus_insert_busn_res(bus, hose->first_busno, hose->last_busno);
+
 	/* Get probe mode and perform scan */
 	mode = PCI_PROBE_NORMAL;
 	if (node && ppc_md.pci_probe_mode)
@@ -1742,8 +1744,11 @@ void __devinit pcibios_scan_phb(struct pci_controller *hose)
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
