Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 02 Feb 2009 09:53:39 +1100
Subject: [PATCH] powerpc: Fix oops on some machines due to incorrect pr_debug()
Message-Id: <20090201225351.8ED34DDF27@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Recently, a patch left DEBUG enabled in the powerpc common PCI code,
resulting in an old bug in a pr_debug() statement to show up and cause
a NULL dereference on some machines.

This fixes the pr_debug() statement and reverts to DEBUG not being
force-enabled in that file.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/pci-common.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-work.orig/arch/powerpc/kernel/pci-common.c	2009-01-30 14:32:34.000000000 +1100
+++ linux-work/arch/powerpc/kernel/pci-common.c	2009-02-02 09:51:48.000000000 +1100
@@ -16,7 +16,7 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#define DEBUG
+#undef DEBUG
 
 #include <linux/kernel.h>
 #include <linux/pci.h>
@@ -258,7 +258,8 @@ int pci_read_irq_line(struct pci_dev *pc
 	} else {
 		pr_debug(" Got one, spec %d cells (0x%08x 0x%08x...) on %s\n",
 			 oirq.size, oirq.specifier[0], oirq.specifier[1],
-		    oirq.controller->full_name);
+			 oirq.controller ? oirq.controller->full_name :
+			 "<default>");
 
 		virq = irq_create_of_mapping(oirq.controller, oirq.specifier,
 					     oirq.size);
