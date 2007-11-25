Return-Path: <benh@ozlabs.org>
To: David Brownell <david-b@pacbell.net>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 26 Nov 2007 09:54:46 +1100
Subject: [PATCH 1/2] usb: Remove broken optimisation in OHCI IRQ handler
Message-Id: <20071125225542.880F2DDF13@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The OHCI IRQ handler has an optimisation that tries to avoid reading
the status register when it sees something has been put in the
controller "done list".

This optimisation is broken on controllers that use edge interrupt
signaling as it relies on "missed" interrupt to be re-emitted which
is not the case with egde interrupts. Among others, it breaks the
OHCI SoC controller in the AMCC 440EP PowerPC processor (and according
to David, it also breaks the SA1111).

This patch removes the optimisation along with making the code a little
bit less convoluted.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

While there, any reason why we do the read of the interenable register
and mask ? Is that actually useful in practice ? I haven't removed it
but it might be a good candidate if we want to save on MMIO reads.

 drivers/usb/host/ohci-hcd.c |   23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

Index: linux-work/drivers/usb/host/ohci-hcd.c
===================================================================
--- linux-work.orig/drivers/usb/host/ohci-hcd.c	2007-11-26 09:14:12.000000000 +1100
+++ linux-work/drivers/usb/host/ohci-hcd.c	2007-11-26 09:16:40.000000000 +1100
@@ -732,24 +732,25 @@ static irqreturn_t ohci_irq (struct usb_
 	struct ohci_regs __iomem *regs = ohci->regs;
 	int			ints;
 
-	/* we can eliminate a (slow) ohci_readl()
-	 * if _only_ WDH caused this irq
-	 */
-	if ((ohci->hcca->done_head != 0)
-			&& ! (hc32_to_cpup (ohci, &ohci->hcca->done_head)
-				& 0x01)) {
-		ints =  OHCI_INTR_WDH;
+	/* Read interrupt status & flush pending DMAs */
+	ints = ohci_readl (ohci, &regs->intrstatus);
 
-	/* cardbus/... hardware gone before remove() */
-	} else if ((ints = ohci_readl (ohci, &regs->intrstatus)) == ~(u32)0) {
+	/* Check for an all 1's result which is the consequence of a
+	 * dead or unplugged device
+	 */
+	if (ints == ~(u32)0) {
 		disable (ohci);
 		ohci_dbg (ohci, "device removed!\n");
 		return IRQ_HANDLED;
 
+	}
+
+	/* We only care about interrupts that are enabled */
+	ints &= ohci_readl (ohci, &regs->intrenable);
+
 	/* interrupt for some other device? */
-	} else if ((ints &= ohci_readl (ohci, &regs->intrenable)) == 0) {
+	if (ints == 0)
 		return IRQ_NOTMINE;
-	}
 
 	if (ints & OHCI_INTR_UE) {
 		// e.g. due to PCI Master/Target Abort
