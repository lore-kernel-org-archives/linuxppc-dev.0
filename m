Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.247])
	by ozlabs.org (Postfix) with ESMTP id 15548DDEFB
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Nov 2007 06:28:54 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so24588anc
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Nov 2007 11:28:53 -0800 (PST)
Message-ID: <fa686aa40711241128o199f2669n86fc3b0ec54a263c@mail.gmail.com>
Date: Sat, 24 Nov 2007 12:28:53 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "David Brownell" <david-b@pacbell.net>
Subject: Re: [PATCH 1/5] USB: Make usb_hcd_irq work for multi-role USB
	controllers w/ shared irq
In-Reply-To: <200711241106.46515.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071124001203.25361.99294.stgit@trillian.cg.shawcable.net>
	<20071124002431.25361.23974.stgit@trillian.cg.shawcable.net>
	<200711241106.46515.david-b@pacbell.net>
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

On 11/24/07, David Brownell <david-b@pacbell.net> wrote:
> On Friday 23 November 2007, Grant Likely wrote:
> > Some multi-role (host/peripheral) USB controllers use a shared interrupt
> > line for all parts of the chip.
>
> Like the musb_hdrc code ... soonish to go upstream (it needs some
> updates to catch up to usbcore urb->status changes), this is used
> by the Nokia 800 and 810.  In terms of chips with Linux support:
> DaVinci, TUSB60x0, OMAP 2430, OMAP 3430, Blackfin BF527; and ISTR
> a few less-publicised ones (including, yes, some PPC SOCs).
>
> That driver hasn't needed to change usbcore for IRQ handling though.
>
>
> > Export usb_hcd_irq so drivers can call it
> > from their interrupt handler instead of duplicating code.
>
> This seems to be the main point of this patch.  I'd rather just
> make that "static" though; it should already be marked that way.
>
> That routine doesn't do enough to make me like it any more; and
> with dual-role controllers, the driver lifecycle is more complex
> than usbcore can be expected to mediate.  Best to just call the
> host side IRQ logic directly from your toplevel IRQ handler.
>
>
> > Drivers pass an irqnum of 0 to usb_add_hcd to signal that the interrupt handler
> > shouldn't be registerred by the core.
>
> The current way to get that behavior is to leave hcd->driver->irq
> as zero; then "irqnum" is ignored, and your dual role driver can
> register its own handler.

Okay, I'll make that change.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
