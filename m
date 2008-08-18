Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id AC8F4DE3FD
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 01:33:01 +1000 (EST)
Date: Mon, 18 Aug 2008 19:33:00 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH 1/3] gpiolib: make gpio_to_chip() public
Message-ID: <20080818153300.GA10163@oksana.dev.rtsoft.ru>
References: <20080808161717.GA19095@polina.dev.rtsoft.ru>
	<200808181558.50182.laurentp@cse-semaphore.com>
	<20080818143343.GA30812@oksana.dev.rtsoft.ru>
	<200808181644.45480.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <200808181644.45480.laurentp@cse-semaphore.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Greg Kroah-Hartman <greg@kroah.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Li Yang <leoli@freescale.com>, Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 18, 2008 at 04:44:36PM +0200, Laurent Pinchart wrote:
> On Monday 18 August 2008, Anton Vorontsov wrote:
> > On Mon, Aug 18, 2008 at 03:58:46PM +0200, Laurent Pinchart wrote:
> > [...]
> > > > Not exactly. But you can do this way, if you need to preserve
> > > > a direction. What I did is a bit different though.
> > > > 
> > > > qe_gpio_set_dedicated() actually just restores a mode that
> > > > firmware had set up, including direction (since direction could
> > > > be a part of dedicated configuration).
> > > > 
> > > > That is, upon GPIO controller registration, we save all registers,
> > > > then driver can set up a pin to a GPIO mode via standard API, and
> > > > then it can _revert_ a pin to a dedicated function via
> > > > qe_gpio_set_dedicated() call. Dedicated function is specified by
> > > > the firmware (or board file), we're just restoring it.
> > > 
> > > The semantic of the set_dedicated() operation needs to be clearly
> > > defined then.
> > 
> > It is. We set up a dedicated function that firmware (or board file)
> > has configured.
> 
> A comment in the source would help.
> 
> > > I can live with this behaviour, but it might not be
> > > acceptable for everybody.
> > 
> > For example?
> > 
> > > Your patch requires the firmware to set a pin in dedicated mode at
> > > bootup in order to be used later in dedicated mode.
> > 
> > Yes. On a PowerPC this is always true: firmware should set up PIO
> > config. Linux' board file could fixup the firmware though.
> 
> That's not what I meant. What if the hardware requires to pin to be
> configured in GPIO mode with a fixed value until the SOC-specific
> driver that will drive the GPIO is loaded ? That's not possible
> with your API.

Yes, this isn't possible with this API. Because you can do this
with standard GPIO API! ;-)

Just call gpio_direction_*() in the board file, before probing the
hardware.

> Until a SOC peripheral is initialized by its associated Linux driver,
> the behaviour of a GPIO pin in dedicated mode will be undefined.

Huh?! Then all current software is simply broken: we're setting pinmux
config _prior_ to controller initialization.

> The firmware/board code will probably want to set the pin as a GPIO
> output with a fixed value until the driver initializes the hardware.

Probably? Do you have any such hardware?

> > Another option would be to add some argument to the set_dedicated
> > call, thus the software could specify arbitrary dedicated
> > function (thus no need to save/restore anything). But this would
> > be SOC-model specific, thus no driver can use this argument anyway.
> 
> Drivers that require dedicated mode are SOC-specific anyway.

I didn't say "SOC-specific". I said "SOC-model specific", which
means that the driver would be not portable even across QE chips
(i.e. MPC8323 vs. MPC8360, you can assume that the "CLK12" function
is having same PAR/ODR/DAT/DIR bits).

> > > If, for some
> > > reason (driver not loaded, ...), no GPIO user shows up for that
> > > pin, it will stay configured in dedicated mode.
> > 
> > Yes.
> > 
> > > It might be better to set the PAR bit unconditionally in
> > 
> > Why it might be better?
> 
> Because, as explained a few lines down, the board initialization code
> will be able to configure a pin in a known state (PAR not set) at boot
> time until a driver requests the pin to be switched to dedicated mode.

You can do this as I described above. But prior to this, yes, you have
to configure the pins and let Linux save these values. There is no other
way to pass this information, unfortunately.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
