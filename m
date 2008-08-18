Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id DDB08DE03C
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 00:33:45 +1000 (EST)
Date: Mon, 18 Aug 2008 18:33:43 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH 1/3] gpiolib: make gpio_to_chip() public
Message-ID: <20080818143343.GA30812@oksana.dev.rtsoft.ru>
References: <20080808161717.GA19095@polina.dev.rtsoft.ru>
	<200808141645.56418.laurentp@cse-semaphore.com>
	<20080814151022.GA9885@oksana.dev.rtsoft.ru>
	<200808181558.50182.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <200808181558.50182.laurentp@cse-semaphore.com>
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

On Mon, Aug 18, 2008 at 03:58:46PM +0200, Laurent Pinchart wrote:
[...]
> > Not exactly. But you can do this way, if you need to preserve
> > a direction. What I did is a bit different though.
> > 
> > qe_gpio_set_dedicated() actually just restores a mode that
> > firmware had set up, including direction (since direction could
> > be a part of dedicated configuration).
> > 
> > That is, upon GPIO controller registration, we save all registers,
> > then driver can set up a pin to a GPIO mode via standard API, and
> > then it can _revert_ a pin to a dedicated function via
> > qe_gpio_set_dedicated() call. Dedicated function is specified by
> > the firmware (or board file), we're just restoring it.
> 
> The semantic of the set_dedicated() operation needs to be clearly
> defined then.

It is. We set up a dedicated function that firmware (or board file)
has configured.

> I can live with this behaviour, but it might not be
> acceptable for everybody.

For example?

> Your patch requires the firmware to set a pin in dedicated mode at
> bootup in order to be used later in dedicated mode.

Yes. On a PowerPC this is always true: firmware should set up PIO
config. Linux' board file could fixup the firmware though.

Another option would be to add some argument to the set_dedicated
call, thus the software could specify arbitrary dedicated
function (thus no need to save/restore anything). But this would
be SOC-model specific, thus no driver can use this argument anyway.

> If, for some
> reason (driver not loaded, ...), no GPIO user shows up for that
> pin, it will stay configured in dedicated mode.

Yes.

> It might be better to set the PAR bit unconditionally in

Why it might be better? That way you may set up wrong _GPIO_
mode, because you didn't set PAR bit (when PAR bit set
DIR/ODR/DAT bits are losing their meanings).

> qe_gpio_set_dedicated() instead of restoring its value. That way
> the board initialization code could just set the DIR, DAT and ODR
> bits for dedicated mode but still configure the pin in GPIO mode.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
