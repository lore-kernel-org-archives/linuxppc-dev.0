Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by ozlabs.org (Postfix) with ESMTP id 2E927DDEBB
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Nov 2007 04:15:43 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so19834anc
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Nov 2007 09:15:43 -0800 (PST)
Message-ID: <fa686aa40711240915k197a2af9p57ecd9605608dd4e@mail.gmail.com>
Date: Sat, 24 Nov 2007 10:15:17 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: [linux-usb-devel] [PATCH 1/5] USB: Make usb_hcd_irq work for
	multi-role USB controllers w/ shared irq
In-Reply-To: <20071124170307.773d7317@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071124001203.25361.99294.stgit@trillian.cg.shawcable.net>
	<20071124002431.25361.23974.stgit@trillian.cg.shawcable.net>
	<20071124051039.GA11029@suse.de>
	<20071124170307.773d7317@the-village.bc.nu>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, Greg KH <gregkh@suse.de>,
	linux-usb-devel@lists.sourceforge.net, dbrownell@users.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/24/07, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Fri, 23 Nov 2007 21:10:39 -0800
> Greg KH <gregkh@suse.de> wrote:
>
> > On Fri, Nov 23, 2007 at 05:24:31PM -0700, Grant Likely wrote:
> > > From: Peter Korsgaard <peter.korsgaard@barco.com>
> > >
> > > Some multi-role (host/peripheral) USB controllers use a shared interrupt
> > > line for all parts of the chip. Export usb_hcd_irq so drivers can call it
> > > from their interrupt handler instead of duplicating code.
> > > Drivers pass an irqnum of 0 to usb_add_hcd to signal that the interrupt handler
> > > shouldn't be registerred by the core.
> >
> > What about for platforms where irq 0 is a valid irq?
>
> There are no such platforms. Linus made that absolutely clear every time
> this came up before
>
>         0       -       No IRQ
>
> A platform with a physical or bus IRQ of 0 needs to remap it to a
> different constant.

Regardless, I should probably use the NO_IRQ macro instead.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
