Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 87327B7B7E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Sep 2009 00:57:15 +1000 (EST)
Date: Wed, 16 Sep 2009 10:57:08 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: RFC: delete UART current-speed from 4xx DTS?
Message-ID: <20090916145708.GA5135@windriver.com>
References: <20090915143135.GA7015@windriver.com>
	<20090915153220.GG12372@zod.rchland.ibm.com>
	<1253051047.8375.232.camel@pasglop>
	<20090916131943.GA14261@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090916131943.GA14261@zod.rchland.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[Re: RFC: delete UART current-speed from 4xx DTS?] On 16/09/2009 (Wed 09:19) Josh Boyer wrote:

> On Wed, Sep 16, 2009 at 07:44:07AM +1000, Benjamin Herrenschmidt wrote:
> >On Tue, 2009-09-15 at 11:32 -0400, Josh Boyer wrote:
> >> 
> >> When I did the bamboo port a while ago, I recall having issues with either
> >> a missing clock-frequency or current-speed (or both perhaps) and the bootloader
> >> on the board was the original PIBS.  It might have been an issue with PIBS
> >> but I'm guessing the rest of the 4xx boards copied from either Ebony or
> >> Bamboo in their ports and hence contain that property.
> >
> >I think I recently added code to legacy_serial probe the speed from the
> >HW if the property is absent, which should help.
> 
> Ok, so I think that is related to what I originally hit.
> 
> I played around with removing the current-speed property on canyonlands today,
> and noticed that I would get no console output at all unless I specified a
> baudrate with console=ttyS0,115200.  That was sort of contrary to what I found
> with bamboo, so I diffed the configs to see why.  Bamboo has udbg enabled and
> hence has legacy_serial builtin, whereas canyonlands just has of_serial.

Makes sense - udbg kind of bridges the information gap in getting the
baudrate that the bootloader was using carried forward.  I'd have never
noticed that because I've always been in the habit of recommending that
people always use an explicit console=ttySn,rate for all non PC like
hardware.

I just saw Documentation/serial-console.txt (also somewhat PC-centric)
claims that "If no console device is specified, the first device found
capable of acting as a system console will be used." But I've never
relied on that, or even tested if it is really a valid claim once you
stray outside the realm of common PC hardware, and end user chosen
baudrates.  I'm pretty sure that on sbc8349, if I omit the console=
and I don't have udbg enabled, I won't see anything either (and I've
always implicitly filed that under "user configuration error").

> 
> So on boards where of_serial is the only serial driver, we need either an
> accurate current-speed property, or a specific baudrate on the command line.

I just took a rummage around in u-boot, and at the moment there isn't
really many boards poking around with current-speed.  Just for
board/muas3001, and any older mpc85xx CPUs with CPM UARTs.  There
doesn't appear to be any real global trend there at all.  (That is not
to say that it couldn't be added though...)  But in any case, I still
don't think having something as end-user configurable as a baud rate
should be hard coded in a dtb (esp. if the firmware isn't updating it
on the fly...)

> That makes a bit more tenuous to remove the properties entirely, because if
> people disable udbg and are relying on that behavior they get no more console
> output.  Need to think on that a bit I guess.

Would be interesting to get other input from people on how big they
think that user group who would be relying on this are.  I'm thinking
a lot of other boards have already tossed out any such guarantee.  I'll
have to do some experiments to confirm that though.

> Alternatively, we could try patching of_serial.c to do the baudrate probe
> as well.

Improving it to "do the right thing" independent of the current
behaviour of other boards is probably worthwhile in terms of user
friendly improvements.  It always sucks to launch into a kernel
and see nothing but another case of "silent boot death".

Paul.

> 
> josh
