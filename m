Return-Path: <david-b@pacbell.net>
Received: from smtp116.sbc.mail.sp1.yahoo.com (smtp116.sbc.mail.sp1.yahoo.com
	[69.147.64.89]) by ozlabs.org (Postfix) with SMTP id 1E5E8DE007
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 08:29:51 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/2] usb: Remove broken optimisation in OHCI IRQ handler
Date: Thu, 6 Dec 2007 13:28:25 -0800
References: <20071125225542.880F2DDF13@ozlabs.org>
In-Reply-To: <20071125225542.880F2DDF13@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200712061328.26235.david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/2] usb: Remove broken optimisation in OHCI IRQ handler

The OHCI IRQ handler has an optimisation that avoids reading some
chip registers when the controller reports that the interrupt was
triggered *only* because completed requests were written into the
controller's "done list" and handed to the host.

This mechanism can't be used on some controllers.  Among others, it
fails for the SA1111 and the AMCC 440EP PowerPC processor.

This patch removes the optimisation and makes the code clearer.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
Suitable IMO for 2.6.24 final.

 drivers/usb/host/ohci-hcd.c |   23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

--- g26.orig/drivers/usb/host/ohci-hcd.c	2007-10-28 17:46:53.000000000 -0700
+++ g26/drivers/usb/host/ohci-hcd.c	2007-12-06 09:29:57.000000000 -0800
@@ -732,24 +732,27 @@ static irqreturn_t ohci_irq (struct usb_
 	struct ohci_regs __iomem *regs = ohci->regs;
 	int			ints;
 
-	/* we can eliminate a (slow) ohci_readl()
-	 * if _only_ WDH caused this irq
+	/* Read interrupt status (and flush pending writes).  We ignore the
+	 * optimization of checking the LSB of hcca->done_head; it doesn't
+	 * work on all systems (edge triggering for OHCI can be a factor).
 	 */
-	if ((ohci->hcca->done_head != 0)
-			&& ! (hc32_to_cpup (ohci, &ohci->hcca->done_head)
-				& 0x01)) {
-		ints =  OHCI_INTR_WDH;
+	ints = ohci_readl(ohci, &regs->intrstatus);
 
-	/* cardbus/... hardware gone before remove() */
-	} else if ((ints = ohci_readl (ohci, &regs->intrstatus)) == ~(u32)0) {
+	/* Check for an all 1's result which is a typical consequence
+	 * of dead, unclocked, or unplugged (CardBus...) devices
+	 */
+	if (ints == ~(u32)0) {
 		disable (ohci);
 		ohci_dbg (ohci, "device removed!\n");
 		return IRQ_HANDLED;
+	}
+
+	/* We only care about interrupts that are enabled */
+	ints &= ohci_readl(ohci, &regs->intrenable);
 
 	/* interrupt for some other device? */
-	} else if ((ints &= ohci_readl (ohci, &regs->intrenable)) == 0) {
+	if (ints == 0)
 		return IRQ_NOTMINE;
-	}
 
 	if (ints & OHCI_INTR_UE) {
 		// e.g. due to PCI Master/Target Abort
