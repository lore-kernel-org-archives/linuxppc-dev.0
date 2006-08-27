Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EB50E67C6D
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Aug 2006 09:11:18 +1000 (EST)
Subject: Re: [PATCH] Keyboard backlight driver for Oct 2005 PowerBooks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
In-Reply-To: <20060827230714.GA12569@hansmi.ch>
References: <20060827123015.GA4697@hansmi.ch>
	<1156718063.8433.358.camel@localhost.localdomain>
	<20060827230714.GA12569@hansmi.ch>
Content-Type: text/plain; charset=utf-8
Date: Mon, 28 Aug 2006 09:11:03 +1000
Message-Id: <1156720264.8433.362.camel@localhost.localdomain>
Mime-Version: 1.0
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

On Mon, 2006-08-28 at 01:07 +0200, Michael Hanselmann wrote:
> On Mon, Aug 28, 2006 at 08:34:23AM +1000, Benjamin Herrenschmidt wrote:
> > Why would we need a driver ? Userland can emit PMU commands directly...
> 
> Drivers are there to abstract hardware. Userland shouldn't know about
> hardware specific commands (PMU commands in this case).

This is a bit of a broad statement :) If I were to follow you, thinks
like USB scanner or printer drivers should all be in the kernel :)
Well... they happen not to be.

Only drivers providing services to the kernel itself (block,
network, ...) or doing things like direct DMA, interrupts, etc... that
aren't useable from an exposed userland interfaces need to be in the
kernel.

> It would make it much simpler for programs to use these devices, because
> not each of them has to implement everything needed to locate the device
> and control it.

Then the best is to do a library.

> pbbuttonsd supports both the I²C and PMU variant. The code is a mess
> there and a generic driver would help to clean it up. And yes, I'm
> partly responsible for it, since I supplied the original patch for the
> PMU keyboard backlight support in pbbuttonsd.
> 
> Maybe controlling the keyboard backlight could be moved to its own
> program anyway, because the algorithm used by pbbuttonsd isn't appealing
> to all people. But those are just ideas.

Yeah, separate program or library would do the trick just fine. Also,
your driver doesn't handle reading the light sensors, does it ?

> Oh, and using the LED class allows users to attach it to some trigger.
> Maybe someone wants to use it as the IDE LED. :-)

That would be just insane :)

> > At least, if we do a driver, it should provide a common interface to
> > both PMU and i2c based LMUs
> 
> Yeah, I figured after sending it. You'll hear again from me once I got
> my hands on an I²C backlight. Something like the AMS driver would be
> nice.

I still think this has little to do in the kernel ...

Ben.
