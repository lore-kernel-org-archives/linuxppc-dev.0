Return-Path: <linux-kernel@hansmi.ch>
Received: from hansmi.home.forkbomb.ch (hansmi.home.forkbomb.ch
	[213.144.146.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "hansmi.home.forkbomb.ch",
	Issuer "hansmi.home.forkbomb.ch" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D9B3667A3A
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Aug 2006 09:24:57 +1000 (EST)
Date: Mon, 28 Aug 2006 01:24:52 +0200
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Keyboard backlight driver for Oct 2005 PowerBooks
Message-ID: <20060827232452.GB12569@hansmi.ch>
References: <20060827123015.GA4697@hansmi.ch>
	<1156718063.8433.358.camel@localhost.localdomain>
	<20060827230714.GA12569@hansmi.ch>
	<1156720264.8433.362.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1156720264.8433.362.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, johannes@sipsolutions.net, rpurdie@rpsys.net,
	linux-kernel@killerfox.forkbomb.ch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 28, 2006 at 09:11:03AM +1000, Benjamin Herrenschmidt wrote:
> > Drivers are there to abstract hardware. Userland shouldn't know about
> > hardware specific commands (PMU commands in this case).

> This is a bit of a broad statement :) If I were to follow you, thinks
> like USB scanner or printer drivers should all be in the kernel :)
> Well... they happen not to be.

True. But then again, a printer driver does little more than configuring
a single PWM value.

If there wasn't an I²C variant, we could even export these things as PMU
sub-devices. But there is one and a driver could easily hide these
differences from userland, because they simply don't matter there.

> Then the best is to do a library.

There was some effort ongoing on that a few months ago (at least on
IRC). Was there anything coming out of it?

> Yeah, separate program or library would do the trick just fine. Also,
> your driver doesn't handle reading the light sensors, does it ?

No, it doesn't. The light sensor is a different device and doesn't
belong into a LED driver. I plan to do a driver for it separately.

So the target is to have one driver for backlight and one for sensors,
each handling the I²C and PMU variants. MacBooks have some other
variant, which could be included, theoretically. Lacking the hardware, I
can't do that, tough.

The main reason I did not do all at once is that I feared a discussion
like we have it now. I'm not going to invest much time for unused code
anymore like I did with the ctrl+click patch.

Greets,
Michael
