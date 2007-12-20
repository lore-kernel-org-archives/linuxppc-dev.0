Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 20 Dec 2007 14:55:04 +1100
Subject: [PATCH 18/19] [POWERPC] Fixup skipping of PowerMac PCI<->PCI bridge
	"closed" resources
In-Reply-To: <1198122881.874131.56762399546.qpush@grosgo>
Message-Id: <20071220035506.827F4DDEA2@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Apple firmware has a strange way to "close" bridge resources by setting
them to some bogus values that overlap RAM (strangely, I haven't seen it
conflicting with DMA so far...). This explicitely closes them to avoid
problems. Previously, they would be closed as a consequence of failing
to be allocated, but this makes it more explicit, and thus the log
message is more explicit too.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/pci-common.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

--- linux-merge.orig/arch/powerpc/kernel/pci-common.c	2007-12-19 15:47:23.000000000 +1100
+++ linux-merge/arch/powerpc/kernel/pci-common.c	2007-12-19 15:58:59.000000000 +1100
@@ -776,6 +776,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI
 
 static void __devinit __pcibios_fixup_bus(struct pci_bus *bus)
 {
+	struct pci_controller *hose = pci_bus_to_host(bus);
 	struct pci_dev *dev = bus->self;
 
 	pr_debug("PCI: Fixup bus %d (%s)\n", bus->number, dev ? pci_name(dev) : "PHB");
@@ -793,6 +794,27 @@ static void __devinit __pcibios_fixup_bu
 			if (!res->flags || bus->self->transparent)
 				continue;
 
+			/* On PowerMac, Apple leaves bridge windows open over
+			 * an inaccessible region of memory space (0...fffff)
+			 * which is somewhat bogus, but that's what they think
+			 * means disabled...
+			 *
+			 * We clear those to force them to be reallocated later
+			 *
+			 * We detect such regions by the fact that the base is
+			 * equal to the pci_mem_offset of the host bridge and
+			 * their size is smaller than 1M.
+			 */
+			if (res->start == hose->pci_mem_offset &&
+			    res->end < 0x100000) {
+				printk(KERN_INFO
+				       "PCI: Closing bogus Apple Firmware"
+				       " region %d on bus 0x%02x\n",
+				       i, bus->number);
+				res->flags = 0;
+				continue;
+			}
+
 			pr_debug("PCI:%s Bus rsrc %d %016llx-%016llx [%x] fixup...\n",
 				 pci_name(dev), i,
 				 (unsigned long long)res->start,\
