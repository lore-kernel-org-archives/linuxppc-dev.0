Return-Path: <linux-kernel@hansmi.ch>
Received: from hansmi.home.forkbomb.ch (hansmi.home.forkbomb.ch
	[213.144.146.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "hansmi.home.forkbomb.ch",
	Issuer "hansmi.home.forkbomb.ch" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 32D4067C61
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Aug 2006 09:07:19 +1000 (EST)
Date: Mon, 28 Aug 2006 01:07:14 +0200
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Keyboard backlight driver for Oct 2005 PowerBooks
Message-ID: <20060827230714.GA12569@hansmi.ch>
References: <20060827123015.GA4697@hansmi.ch>
	<1156718063.8433.358.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1156718063.8433.358.camel@localhost.localdomain>
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

On Mon, Aug 28, 2006 at 08:34:23AM +1000, Benjamin Herrenschmidt wrote:
> Why would we need a driver ? Userland can emit PMU commands directly...

Drivers are there to abstract hardware. Userland shouldn't know about
hardware specific commands (PMU commands in this case).

It would make it much simpler for programs to use these devices, because
not each of them has to implement everything needed to locate the device
and control it.

pbbuttonsd supports both the I²C and PMU variant. The code is a mess
there and a generic driver would help to clean it up. And yes, I'm
partly responsible for it, since I supplied the original patch for the
PMU keyboard backlight support in pbbuttonsd.

Maybe controlling the keyboard backlight could be moved to its own
program anyway, because the algorithm used by pbbuttonsd isn't appealing
to all people. But those are just ideas.

Oh, and using the LED class allows users to attach it to some trigger.
Maybe someone wants to use it as the IDE LED. :-)

> At least, if we do a driver, it should provide a common interface to
> both PMU and i2c based LMUs

Yeah, I figured after sending it. You'll hear again from me once I got
my hands on an I²C backlight. Something like the AMS driver would be
nice.
