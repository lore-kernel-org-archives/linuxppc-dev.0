Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id DD2AEDDF24
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 03:19:53 +1000 (EST)
Date: Mon, 19 May 2008 21:19:50 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: gary.jennejohn@freenet.de
Subject: Re: [PATCH 3/4] spi: Add OF binding support for SPI busses
Message-ID: <20080519171949.GA12616@polina.dev.rtsoft.ru>
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
	<20080516193613.28030.13950.stgit@trillian.secretlab.ca>
	<Pine.LNX.4.64.0805191446530.27140@axis700.grange>
	<fa686aa40805190857u317d3304ie75d11870e109fc5@mail.gmail.com>
	<20080519190900.01ec3b2a@peedub.jennejohn.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080519190900.01ec3b2a@peedub.jennejohn.org>
Cc: fabrizio.garetto@gmail.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, dbrownell@users.sourceforge.net,
	spi-devel-general@lists.sourceforge.net,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 19, 2008 at 07:09:00PM +0200, Gary Jennejohn wrote:
> On Mon, 19 May 2008 09:57:21 -0600
> "Grant Likely" <grant.likely@secretlab.ca> wrote:
> 
> > On Mon, May 19, 2008 at 7:17 AM, Guennadi Liakhovetski
> > <g.liakhovetski@gmx.de> wrote:
> > > On Fri, 16 May 2008, Grant Likely wrote:
> > >
> > >> +    However, the binding does not attempt to define the specific method for
> > >> +    assigning chip select numbers.  Since SPI chip select configuration is
> > >> +    flexible and non-standardized, it is left out of this binding with the
> > >> +    assumption that board specific platform code will be used to manage
> > >> +    chip selects.  Individual drivers can define additional properties to
> > >> +    support describing the chip select layout.
> > >
> > > Yes, this looks like a problem to me. This means, SPI devices will need
> > > two bindings - OF and platform?... Maybe define an spi_chipselect
> > > OF-binding?
> > 
> > Actually, spi devices have *neither*.  :-)  They bind to the SPI bus.
> > Not the platform bus or of_platform bus.  But that is Linux internal
> > details; this discussion is about device tree bindings.
> > 
> > Note that I did say that drivers can define additional properties for
> > supporting chip select changes as needed.  I'm just not attempting to
> > encode them into the formal binding.  There is simply just too many
> > different ways to manipulate chip select signals and so I don't feel
> > confident trying to define a *common* binding at this moment in time.
> > At some point in the future when we have a number of examples to
> > choose from then we can extend this binding with chip select related
> > properties.
> > 
> > As for the Linux internals, the 5200 SPI bus driver that I posted
> > exports a function that allows another driver to call in and
> > manipulated the CS lines before the transfer.  It isn't the prettiest
> > solution, but I'm not locked into the approach and that gives some
> > time to consider cleaner interfaces.
> > 
> 
> I sort of hesitate to hijack this thread, but since we're discussing SPI
> and chip selects...
> 
> I have a driver for the SPI controller in the 440EPx.  This controller
> is very simple and does not have any internal support for a chip select.
> The controller seems to also be in the 440GR and 440EP, and may be in
> other AMCC CPUs too.
> 
> All chip selects must be done using GPIO.  In fact, the board for which
> I developed this driver, a modified sequoia, actually uses 2 chip selects.
> 
> My problem was, and is, that there's no generic GPIO support for powerpc.
> At least, not that I'm aware of.  Please tell me if I'm wrong.

Documentation/powerpc/booting-without-of.txt
VIII - Specifying GPIO information for devices.

And include/linux/of_gpio.h + drivers/of/gpio.c.

Soon I'll post some patches for mpc83xx_spi showing how to use GPIOs
for the SPI chip selects.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
