Return-Path: <benh@ozlabs.org>
To: David Brownell <david-b@pacbell.net>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 26 Nov 2007 09:54:46 +1100
Subject: [PATCH 2/2] usb: Remove OHCI useless masking/unmasking of WDH
	interrupt
Message-Id: <20071125225543.374E0DDF17@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The OHCI driver's IRQ handler, while processing a WDH interrupt, masks
and unmasks it. I believe this is both broken (no dealign with write
posting) and totally useless as the IRQ cannot re-occur while we are in
the handler anyway. 
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

It might be a leftover related to the bogus optmisation that I've removed
in a separate patch. Anyway, I don't think it's any use so let's remove
to useless MMIO writes.

 drivers/usb/host/ohci-hcd.c |    4 ----
 1 file changed, 4 deletions(-)

Index: linux-work/drivers/usb/host/ohci-hcd.c
===================================================================
--- linux-work.orig/drivers/usb/host/ohci-hcd.c	2007-11-26 09:17:52.000000000 +1100
+++ linux-work/drivers/usb/host/ohci-hcd.c	2007-11-26 09:17:58.000000000 +1100
@@ -807,13 +807,9 @@ static irqreturn_t ohci_irq (struct usb_
 	}
 
 	if (ints & OHCI_INTR_WDH) {
-		if (HC_IS_RUNNING(hcd->state))
-			ohci_writel (ohci, OHCI_INTR_WDH, &regs->intrdisable);
 		spin_lock (&ohci->lock);
 		dl_done_list (ohci);
 		spin_unlock (&ohci->lock);
-		if (HC_IS_RUNNING(hcd->state))
-			ohci_writel (ohci, OHCI_INTR_WDH, &regs->intrenable);
 	}
 
 	if (quirk_zfmicro(ohci) && (ints & OHCI_INTR_SF)) {
