Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao03.cox.net (fed1rmmtao03.cox.net [68.230.241.36])
	by ozlabs.org (Postfix) with ESMTP id B61972BDB2
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Sep 2004 16:14:45 +1000 (EST)
Date: Mon, 27 Sep 2004 23:14:38 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Message-ID: <20040927231438.D30772@home.com>
References: <4153A362.8010604@sonartech.com.au>
	<AE8972FB-0E3A-11D9-BC8B-000A95A4DC02@kernel.crashing.org>
	<4158DD68.2060707@sonartech.com.au>
	<20040927221323.A30581@home.com>
	<C617C694-1110-11D9-8370-000A95A4DC02@kernel.crashing.org>
	<20040927224825.B30772@home.com>
	<7C908338-1113-11D9-8370-000A95A4DC02@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7C908338-1113-11D9-8370-000A95A4DC02@kernel.crashing.org>;
	from segher@kernel.crashing.org on Tue, Sep 28, 2004 at
	12:58:57AM -0500
Cc: David Gardiner <daveg@sonartech.com.au>, linuxppc-embedded@ozlabs.org
Subject: Re: powerpc with gigabit card hanging
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Sep 28, 2004 at 12:58:57AM -0500, Segher Boessenkool wrote:
> >> PCI device IRQs are normally retrieved straight from the PCI device
> >> itself.  Sounds like a firmware problem (or the bootloader, if that
> >> sets up the PCI devices for you).
> >
> > This assumes a world where everything is managed by magic BIOS/OF
> > initialization. That's not the case for this user's board port.
> 
> The OS (Linux, specifically) won't do it for you.  It has to be set up
> beforehand.  Unless "embedded Linux" gets this the wrong way around
> as well.

This isn't an "embedded Linux" (whatever that is) thing. It is a
non-full-featured firmware thing.  If you take a look at MIPS, ARM,
SH, PPC embedded platforms you'll see a similar thing. But wait,
you'll even see interrupt routing tables in the decidedly not embedded
Alpha architecture. :) Linux does do it, and there is a very clear
infrastructure for managing routing tables and standard/non-standard
PCI swizzle mechanisms.
 
> >> I believe Linux for PowerMac actually gets the IRQ number straight
> >> from the device.  Some other routing might be gotten out of the OF
> >> device-tree, yes.
> >
> > The interrupt line register is always programmed by firmware, bios,
> > or an OS. It is a logical value that is dependent on the platform.
> 
> a) Don't pretend I don't know this; and b) it is wrong.  On the
> majority of platforms, you can route any PCI IRQ to any number you want.
> The firmware will tell you where it ends up (over PCI config space).

On commodity platforms that's true. But on just about every single
dedicated purpose platform (embedded systems), interrupt routing is
a static board layout/design decision.

> > The only thing statically available on a PCI device is the interrupt
> > pin register value.
> 
> That only tells you whether the device has any IRQ at all.

No, it also tells you which pin it is routed to (A-D). That's
an important piece of information when routing interrupts.

> > That combined with the platform-specific routing
> > table is used to generate an arbitrary interrupt line value that
> > is programmed into the PCI interrupt line register.
> 
> interrupt line == IRQ#?  That is set up _before_ Linux runs.

Again, on some platforms, not this one. Let's just agree that
not everything is a x86/BIOS or ppc64/pmac/OF machine that
has this done in some blackbox firmware.

-Matt
