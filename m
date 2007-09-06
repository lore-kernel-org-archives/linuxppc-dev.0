Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A86E1DDF01
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 00:15:16 +1000 (EST)
Date: Thu, 6 Sep 2007 09:15:01 -0500
From: Scott Wood <scottwood@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: PCI I/O space -- reg or ranges?
Message-ID: <20070906141501.GA16353@ld0162-tx32.am.freescale.net>
References: <20070831175006.17240@gmx.net>
	<20070903013431.GG31499@localhost.localdomain>
	<20070903145814.101070@gmx.net>
	<f460b176a7c30dae101bfc00d1d4b8e9@kernel.crashing.org>
	<20070904114945.303440@gmx.net>
	<20070905024805.GE17189@localhost.localdomain>
	<22dc6fa3382b591fe721c1b9dee88097@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <22dc6fa3382b591fe721c1b9dee88097@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 06, 2007 at 03:56:38PM +0200, Segher Boessenkool wrote:
> > Err... huh?  The legacy IO space is assigned a block of addresses in
> > 3-word "OF-PCI-space by the PCI binding.  When that is translated into
> > an MMIO range by the bridge, there's no reason that can't be encoded
> > into the ranges property.
> 
> Sure, it can be encoded like that.  But does it make sense?
> You cannot use legacy I/O space as normal memory space.

Why does it not make sense?  I'm not sure what you mean by using it as
"normal memory space", but if the PCI bridge does a straightforward
linear mapping of I/O into memory space (like most non-x86 bridges do),
it seems to make sense to me to reuse the existing ranges mechanism
rather than require each driver to have extra glue code.

And given the substantial impact of such a change on many existing device
trees and the kernel, it should probably be brought up in a thread with a
subject that will clue people in to what is being discussed, rather than
buried in "AmigaOne device tree source v2".

BTW, memory space could be non-linear as well, so should we stop using
ranges for that?  For an example, see the old Alphas which lacked
byte/word I/O, and thus used a weird sparse mapping to control the size
of the access that went out over the bus.

> Also, from a driver standpoint, a PHB driver needs to find out
> two main things about the bridge: a) how and where to generate
> config cycles; b) how and where to generate legacy I/O cycles.
> It is told "how" by the "compatible" property, and "where" by
> the "reg" property, normally.

All it currently needs to do is a), provided it's a normal linear mapping
and the I/O space is in ranges.

-Scott
