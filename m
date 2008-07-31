Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 31 Jul 2008 15:24:13 +1000
Subject: [PATCH] powerpc/pci: Don't keep ISA memory hole resources in the tree
Message-Id: <20080731052417.5A94FDDF27@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When we have an ISA memory hole (ie, a PCI window that allows to
generate PCI memory cycles at low PCI address) mixes with other
resources using a different CPU <=> PCI mapping, we must not keep
the ISA hole in the bridge resource list.

If we do, things might start trying to allocate device resources
in there and will get the PCI addresses wrong.

This patch fixes it, which fixes various cases of PCMCIA breakage
on PowerBooks using the MPC106 "grackle" bridge that supports
ISA holes.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/pci-common.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

--- linux-work.orig/arch/powerpc/kernel/pci-common.c	2008-07-31 14:45:20.000000000 +1000
+++ linux-work/arch/powerpc/kernel/pci-common.c	2008-07-31 14:57:31.000000000 +1000
@@ -650,11 +650,18 @@ void __devinit pci_process_bridge_OF_ran
 		}
 	}
 
-	/* Out of paranoia, let's put the ISA hole last if any */
-	if (isa_hole >= 0 && memno > 0 && isa_hole != (memno-1)) {
-		struct resource tmp = hose->mem_resources[isa_hole];
-		hose->mem_resources[isa_hole] = hose->mem_resources[memno-1];
-		hose->mem_resources[memno-1] = tmp;
+	/* If there's an ISA hole and the pci_mem_offset is -not- matching
+	 * the ISA hole offset, then we need to remove the ISA hole from
+	 * the resource list for that brige
+	 */
+	if (isa_hole >= 0 && hose->pci_mem_offset != isa_mb) {
+		unsigned int next = isa_hole + 1;
+		printk(KERN_INFO " Removing ISA hole at 0x%016llx\n", isa_mb);
+		if (next < memno)
+			memmove(&hose->mem_resources[isa_hole],
+				&hose->mem_resources[next],
+				sizeof(struct resource) * (memno - next));
+		hose->mem_resources[--memno].flags = 0;
 	}
 }
 
