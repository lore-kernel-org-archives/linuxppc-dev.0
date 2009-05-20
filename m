Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3B8C1DE151
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 17:08:00 +1000 (EST)
Subject: Re: Musings on PCI busses
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20090519.225118.58497608.davem@davemloft.net>
References: <fa686aa40905190828x251765dek586f5bf8e73e4cf7@mail.gmail.com>
	<1242788490.16901.133.camel@pasglop>
	<20090519.225118.58497608.davem@davemloft.net>
Content-Type: text/plain
Date: Wed, 20 May 2009 16:51:07 +1000
Message-Id: <1242802267.16901.187.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, thunderbird2k@gmail.com, John.Linn@xilinx.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2009-05-19 at 22:51 -0700, David Miller wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Wed, 20 May 2009 13:01:30 +1000
> 
> > For example, some of the OF parsing bits may fail to convert memory
> > addresses to IO addresses if the PCI host bridges have not been
> > discovered yet, potentially causing issues with matching of resources
> > between the early serial stuff and the generic serial driver (if you
> > use an IO driven UART, the PCI 8250 driver may not properly figure out
> > that what it's finding in its IO BARs is actually the same port as
> > what it gets from the platform code as the later will end up with
> > memory addresses rather than IO ones). That's one example.
> 
> FWIW, I never run into this issue on sparc64 exactly because I
> fully resolve all resources when I populate the OF device tree
> in the kernel.

What do you mean by fully resolve ? IE. The issue above is specific to
IO space, which you can resolve both as MMIO, or as "IO" which in linux
means going through the special mapping for IO which allows the use of
the inX/outX instructions...

The later can only be done after we have established the special mapping
in question for a given PCI bus IO space, at which point, we know what
IO "base" corresponds to the IO space of that bridge. So in the
meantime, all we have is an MMIO resource, which is "resolved" in the
sense that it does contain all the right bits to get the serial ports
(address translation etc...) but isn't an IORESOURCE_IO type resource
and thus doesn't contain a magic token we can pass to inX/outX.

One of the issues we may have here on powerpc is that our very early
probe of serial ports (so we get some debug output early) may get to
those resources while the serial driver later sees the actual
IORESOURCE_IO resources coming from the PCI probe, and is unable to
figure that they are the same things.

Currently, we do a pass of "conversion" over those early resolved
resources just after the PCI bridges have been discovered to check if
they happen to land into the IO space of a bridge and then turn them
into IORESOURCE_IO tokens.

If we delay the probing of PCI bridges, things can get fishy there.

Cheers,
Ben.
