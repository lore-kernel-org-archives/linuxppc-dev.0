Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <62a10dda33b8e6b790f13057daea1430ed81ef1c.1205907051.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] Hide resources on Axon PCIE root complex nodes
Date: Wed, 19 Mar 2008 17:10:55 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The PCI bridge representing the PCIE root complex on Axon, contains device
BARs for a memory range and ROM that define inbound accesses. This confuses
the kernel resource management code, the resources need to be hidden when
Axon is a host bridge.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/setup.c |   36 +++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/cell/setup.c b/arch/powerpc/platforms/cell/setup.c
index dda3465..5c531e8 100644
--- a/arch/powerpc/platforms/cell/setup.c
+++ b/arch/powerpc/platforms/cell/setup.c
@@ -81,6 +81,42 @@ static void cell_progress(char *s, unsigned short hex)
 	printk("*** %04x : %s\n", hex, s ? s : "");
 }
 
+static void cell_fixup_pcie_rootcomplex(struct pci_dev *dev)
+{
+	struct pci_controller *hose;
+	const char *s;
+	int i;
+
+	if (!machine_is(cell))
+		return;
+
+	/* We're searching for a direct child of the PHB */
+	if (dev->bus->self != NULL || dev->devfn != 0)
+		return;
+
+	hose = pci_bus_to_host(dev->bus);
+	if (hose == NULL)
+		return;
+
+	/* Only on PCIE */
+	if (!of_device_is_compatible(hose->dn, "pciex"))
+		return;
+
+	/* And only on axon */
+	s = of_get_property(hose->dn, "model", NULL);
+	if (!s || strcmp(s, "Axon") != 0)
+		return;
+
+	for (i = 0; i < PCI_BRIDGE_RESOURCES; i++) {
+		dev->resource[i].start = dev->resource[i].end = 0;
+		dev->resource[i].flags = 0;
+	}
+
+	printk(KERN_DEBUG "PCI: Hiding resources on Axon PCIE RC %s\n",
+	       pci_name(dev));
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, cell_fixup_pcie_rootcomplex);
+
 static int __init cell_publish_devices(void)
 {
 	int node;
-- 
1.5.2.rc1.1884.g59b20
