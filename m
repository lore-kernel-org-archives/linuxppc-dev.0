Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id AC0A4DDF00
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Jun 2008 22:53:40 +1000 (EST)
Date: Mon, 2 Jun 2008 16:53:37 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Pierre Ossman <drzeus-mmc@drzeus.cx>
Subject: Re: [RFC PATCH 1/2] mmc_spi: export probe and remove functions
Message-ID: <20080602125337.GA2872@polina.dev.rtsoft.ru>
References: <20080523182754.GA26891@polina.dev.rtsoft.ru>
	<20080523182834.GA469@polina.dev.rtsoft.ru>
	<20080526141836.72db0623@mjolnir.drzeus.cx>
	<20080526122533.GA9595@polina.dev.rtsoft.ru>
	<20080526131009.GA19861@polina.dev.rtsoft.ru>
	<20080601121841.0392b01c@mjolnir.drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080601121841.0392b01c@mjolnir.drzeus.cx>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Gary Jennejohn <garyj@denx.de>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jun 01, 2008 at 12:18:41PM +0200, Pierre Ossman wrote:
> On Mon, 26 May 2008 17:10:09 +0400
> Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> 
> > 
> > Btw, this isn't actually drivers encapsulating. This is about making
> > mmc_spi export some "library" function which could be used by other
> > bindings.
> > 
> > Think of usb_add_hcd() used by various drivers' bindings for e.g.
> > drivers/usb/host/ehci-*.c. Though usb_add_hcd() is more generic
> > than just "EHCI" bindings, but only because there is nothing to
> > share between them. (for MMC over SPI bindings all we want to do is fill
> > the platform data).
> > 
> 
> There's a big difference.

This depends on the perception. :-)

> usb_add_hcd() is designed specifically to be called by other, real probe
> functions.

Yes, by convention (or better, by design).

> mmc_spi_probe() _is_ a probe function. 

Yes, so far.

> Also exporting it as a library function is very confusing.

No, if designed/documented properly.

Just imagine this (100% similarity to USB code):

mmc_spi_create_hcd(&mmc_spi_driver, dev, dev->bus_id);
mmc_spi_add_hcd(dev, irq, irqflags);

> > Maybe something like this? I don't like it so much, but given that
> > you don't like to export functions from mmc_spi, we'll have to place
> > some calls into the driver itself. :-/ And there is no easy way to do
> > generic callbacks, since that way we'll have implement "mmc_spi
> > callbacks subsystem". :-)
> 
> That's not a callback, but an explicit call to another module.
> 
> 
> All of this work looks a bit like trying to wedge a square piece into a
> round hole. It looks to me that the kernel needs a bit of restructuring
> to handle it. You can't really export every probe function of every
> platform device so that you can add OF hooks to it.
> 
> From what I can tell, the OF stuff behaves very much like the PNP
> system on PCs. The information relayed is a bit more versatile though.
> Perhaps what is needed is a more advanced "platform" bus that is
> modeled after the PNP bus, but with the extra ability of handling the
> stuff currently crammed into the platform structures. mmc_spi would
> then be extended to be driver for the "platform" bus and we could have
> generic calls like platform_get_pin(dev, "ro");.

platform_get_pin()? Um, maybe platform_get_gpio(), as _irq()? Yes,
this is doable (and someday this should be done). But this way we can
pass only GPIOs and then teach mmc_spi to work with them directly
(in addition to callbacks).

But this is not enough, there is still no way to pass real platform data,
such as: caps and ocr_mask. Any idea how to deliver these?


Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
