Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from the-village.bc.nu (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 81031DDEB7
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Nov 2007 04:15:17 +1100 (EST)
Date: Sat, 24 Nov 2007 17:03:07 +0000
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <gregkh@suse.de>
Subject: Re: [linux-usb-devel] [PATCH 1/5] USB: Make usb_hcd_irq work for
	multi-role USB	controllers w/ shared irq
Message-ID: <20071124170307.773d7317@the-village.bc.nu>
In-Reply-To: <20071124051039.GA11029@suse.de>
References: <20071124001203.25361.99294.stgit@trillian.cg.shawcable.net>
	<20071124002431.25361.23974.stgit@trillian.cg.shawcable.net>
	<20071124051039.GA11029@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: akpm@osdl.org, dbrownell@users.sourceforge.net,
	linux-usb-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 23 Nov 2007 21:10:39 -0800
Greg KH <gregkh@suse.de> wrote:

> On Fri, Nov 23, 2007 at 05:24:31PM -0700, Grant Likely wrote:
> > From: Peter Korsgaard <peter.korsgaard@barco.com>
> > 
> > Some multi-role (host/peripheral) USB controllers use a shared interrupt
> > line for all parts of the chip. Export usb_hcd_irq so drivers can call it
> > from their interrupt handler instead of duplicating code.
> > Drivers pass an irqnum of 0 to usb_add_hcd to signal that the interrupt handler
> > shouldn't be registerred by the core.
> 
> What about for platforms where irq 0 is a valid irq?

There are no such platforms. Linus made that absolutely clear every time
this came up before

	0	-	No IRQ

A platform with a physical or bus IRQ of 0 needs to remap it to a
different constant.

Alan
