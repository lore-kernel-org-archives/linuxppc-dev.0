Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 21 Dec 2007 14:53:27 +1100
Subject: [PATCH] [POWERPC] Fix possible NULL deref in ppc32 PCI
Message-Id: <20071221035331.15AA3DDDF7@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The 32-bit PCI code tests if "bus" is non-NULL after calling
pci_scan_bus_parented() in one place but not another before
derefencing it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/pci_32.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-merge.orig/arch/powerpc/kernel/pci_32.c	2007-12-21 14:50:24.000000000 +1100
+++ linux-merge/arch/powerpc/kernel/pci_32.c	2007-12-21 14:51:20.000000000 +1100
@@ -442,9 +442,10 @@ static int __init pcibios_init(void)
 		hose->last_busno = 0xff;
 		bus = pci_scan_bus_parented(hose->parent, hose->first_busno,
 					    hose->ops, hose);
-		if (bus)
+		if (bus) {
 			pci_bus_add_devices(bus);
-		hose->last_busno = bus->subordinate;
+			hose->last_busno = bus->subordinate;
+		}
 		if (pci_assign_all_buses || next_busno <= hose->last_busno)
 			next_busno = hose->last_busno + pcibios_assign_bus_offset;
 	}
