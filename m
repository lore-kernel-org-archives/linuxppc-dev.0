Return-Path: <david-b@pacbell.net>
Received: from smtp116.sbc.mail.sp1.yahoo.com (smtp116.sbc.mail.sp1.yahoo.com
	[69.147.64.89]) by ozlabs.org (Postfix) with SMTP id 5BED9DE015
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 08:29:51 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2/2] usb: Remove OHCI useless masking/unmasking of WDH
	interrupt
Date: Thu, 6 Dec 2007 13:29:46 -0800
References: <20071125225543.374E0DDF17@ozlabs.org>
In-Reply-To: <20071125225543.374E0DDF17@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200712061329.47591.david-b@pacbell.net>
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
Subject: [PATCH 2/2] usb: Remove OHCI useless masking/unmasking of WDH interrupt

The OHCI driver's IRQ handler, while processing a WDH interrupt, masks
and unmasks it.  I believe this is both broken (the write may still be
posted during the donelist processing it's trying to safeguard) and
useless as this IRQ may not be reissued until it's acked (unless this
legacy code is an uncommented workaround for some chip erratum).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
Worth IMO holding till 2.6.25-early.

--- g26.orig/drivers/usb/host/ohci-hcd.c	2007-12-06 08:42:24.000000000 -0800
+++ g26/drivers/usb/host/ohci-hcd.c	2007-12-06 08:42:29.000000000 -0800
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
