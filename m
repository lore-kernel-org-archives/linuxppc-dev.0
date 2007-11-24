Return-Path: <david-b@pacbell.net>
Received: from smtp116.sbc.mail.sp1.yahoo.com (smtp116.sbc.mail.sp1.yahoo.com
	[69.147.64.89]) by ozlabs.org (Postfix) with SMTP id 2DB7EDDED4
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Nov 2007 06:06:49 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/5] USB: Make usb_hcd_irq work for multi-role USB
	controllers w/ shared irq
Date: Sat, 24 Nov 2007 11:06:46 -0800
References: <20071124001203.25361.99294.stgit@trillian.cg.shawcable.net>
	<20071124002431.25361.23974.stgit@trillian.cg.shawcable.net>
In-Reply-To: <20071124002431.25361.23974.stgit@trillian.cg.shawcable.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200711241106.46515.david-b@pacbell.net>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, gregkh@suse.de,
	linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 23 November 2007, Grant Likely wrote:
> Some multi-role (host/peripheral) USB controllers use a shared interrupt
> line for all parts of the chip.

Like the musb_hdrc code ... soonish to go upstream (it needs some
updates to catch up to usbcore urb->status changes), this is used
by the Nokia 800 and 810.  In terms of chips with Linux support:
DaVinci, TUSB60x0, OMAP 2430, OMAP 3430, Blackfin BF527; and ISTR
a few less-publicised ones (including, yes, some PPC SOCs).

That driver hasn't needed to change usbcore for IRQ handling though.


> Export usb_hcd_irq so drivers can call it 
> from their interrupt handler instead of duplicating code.

This seems to be the main point of this patch.  I'd rather just
make that "static" though; it should already be marked that way.

That routine doesn't do enough to make me like it any more; and
with dual-role controllers, the driver lifecycle is more complex
than usbcore can be expected to mediate.  Best to just call the
host side IRQ logic directly from your toplevel IRQ handler.


> Drivers pass an irqnum of 0 to usb_add_hcd to signal that the interrupt handler
> shouldn't be registerred by the core.

The current way to get that behavior is to leave hcd->driver->irq
as zero; then "irqnum" is ignored, and your dual role driver can
register its own handler.

- Dave
