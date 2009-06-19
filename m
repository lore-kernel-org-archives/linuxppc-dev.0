Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 073C5B7243
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 23:25:50 +1000 (EST)
Date: Fri, 19 Jun 2009 17:25:01 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Leon Woestenberg <leon.woestenberg@gmail.com>
Subject: Re: [PATCH -mm][POWERPC] mpc8xxx : allow SPI without cs.
Message-ID: <20090619132501.GA10886@oksana.dev.rtsoft.ru>
References: <4A39DC80.7030906@arvoo.nl>
	<20090618130955.GA1369@oksana.dev.rtsoft.ru>
	<EEB9B7B7-5456-4AE9-8BB9-96DA04320697@kernel.crashing.org>
	<c384c5ea0906190445u130a4fedv14c22c7f9abdb9d8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <c384c5ea0906190445u130a4fedv14c22c7f9abdb9d8@mail.gmail.com>
Cc: spi-devel-general@lists.sourceforge.net, Rini van Zetten <rini@arvoo.nl>,
	linuxppc-dev list <Linuxppc-dev@ozlabs.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 19, 2009 at 01:45:46PM +0200, Leon Woestenberg wrote:
> Hello,
> 
> On Thu, Jun 18, 2009 at 4:04 PM, Kumar Gala<galak@kernel.crashing.org> wrote:
> > On Jun 18, 2009, at 8:09 AM, Anton Vorontsov wrote:
> >> On Thu, Jun 18, 2009 at 08:19:44AM +0200, Rini van Zetten wrote:
> >>>
> >>> This patch adds the possibility to have a spi device without a cs.
> >>>
> > That is a good question.  What HW is this for (I don't think its for eSPI
> > but I could be wrong).
> >
> We need SPI without CS too on our MPC8313E design.

We do support SPI without CS, but only for one slave device. If
there is no CS, technically you can address only one device on a
SPI bus.

And apparently Rini's case is not for addressing multiple chips
w/o CS lines, it's just some chip-selects need quirks.

> In our case having a CS line to each slave (18 of them) is too
> expensive and we use a chip select which piggy backs on another
> signal.
> Once the slave is selected, SPI is used to send large amounts of data.

Can you describe it a little bit more? Have you patched the SPI
driver to work with your setup?

If you can address 18 slaves w/o chip-select line, I quess
you have a CS demuxing bridge somewhere, i.e.

spi-controller {
	/*
	 * no chip-selects from the controller, it can only talk to
	 * one device: the cs demuxing bridge, it is always selected.
	 */
	spi-cs-demuxing-bridge {
		/*
		 * knows how to manage chip-selects (or demux
		 * one chip select line for several slaves)
		 */
		spi-slave {
			reg = <0>;
		};
		...
		spi-slave {
			reg = <17>;
		};
	};
};

Surely we can hide the bridge into the SPI controller driver,
but I think it would be beneficial to "factor-out" it to a
stand-alone entity, so that other SPI controllers could work
with this setup without any modifications (oh and btw, we could
also create a bridge called "gpio-chipselects-bridge", and
factor out all GPIO stuff from the drivers).

There are two options of how we can factor out chip-select
machines... the bad and the ugly. :-) No, the first one is bad,
but the second should be OK.

1. We can create full-fledged SPI master bridge drivers, the
   drivers will just pass-through all SPI IO, but will manage
   chip-selects. The bad part is that these drivers could degrade
   performance since they'll have to manage SPI IO, which is
   unneeded for the pure CS machines.

2. Another option (which I like more), is to create "SPI chip-
   select machine driver framework", so we could (finally)
   separate two SPI entities: SPI IO and SPI chip-select machine.
   CS machines of different flavours: GPIO, built-in, and
   board-specific (!) with a lot of demuxing magic.

(1) can be implemented trivially, while (2) is a lot of work.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
