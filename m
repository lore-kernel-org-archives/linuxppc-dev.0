Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 20 Dec 2007 15:10:02 +1100
Subject: [PATCH] [POWERPC] Fix PCI IRQ fallback code to not map IRQ 0
Message-Id: <20071220041004.781E5DDEEB@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The PCI IRQ code has a fallback when the device-tree parsing fails, that
tries to map the interrupt indicated by PCI_INTERRUPT_LINE if the firmware
set something in there. This is a bit fragile but has proven useful in some
cases so far. However, it's causing us to incorrectly try to map interrupt 0
on various setups, so let's prevent that case, as none of the cases where
the fallback is legit should have an IRQ 0.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/pci-common.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-merge.orig/arch/powerpc/kernel/pci-common.c	2007-12-14 15:49:36.000000000 +1100
+++ linux-merge/arch/powerpc/kernel/pci-common.c	2007-12-14 15:49:36.000000000 +1100
@@ -225,10 +225,11 @@ int pci_read_irq_line(struct pci_dev *pc
 		if (pin == 0)
 			return -1;
 		if (pci_read_config_byte(pci_dev, PCI_INTERRUPT_LINE, &line) ||
-		    line == 0xff) {
+		    line == 0xff || line == 0) {
 			return -1;
 		}
-		DBG(" -> no map ! Using irq line %d from PCI config\n", line);
+		DBG(" -> no map ! Using line %d (pin %d) from PCI config\n",
+		    line, pin);
 
 		virq = irq_create_mapping(NULL, line);
 		if (virq != NO_IRQ)
