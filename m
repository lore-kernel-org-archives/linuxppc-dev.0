Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao04.cox.net (fed1rmmtao04.cox.net [68.230.241.35])
	by ozlabs.org (Postfix) with ESMTP id 59A3E2BDB2
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Sep 2004 15:48:28 +1000 (EST)
Date: Mon, 27 Sep 2004 22:48:25 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Message-ID: <20040927224825.B30772@home.com>
References: <4153A362.8010604@sonartech.com.au>
	<AE8972FB-0E3A-11D9-BC8B-000A95A4DC02@kernel.crashing.org>
	<4158DD68.2060707@sonartech.com.au>
	<20040927221323.A30581@home.com>
	<C617C694-1110-11D9-8370-000A95A4DC02@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C617C694-1110-11D9-8370-000A95A4DC02@kernel.crashing.org>;
	from segher@kernel.crashing.org on Tue, Sep 28, 2004 at
	12:39:32AM -0500
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

On Tue, Sep 28, 2004 at 12:39:32AM -0500, Segher Boessenkool wrote:
> >> What kernel are you using?
> 
> 2.6.whatever, and I've used 2.4 in the past I believe.
> 
> >> it's just that the irq's I'm getting for the
> >> gigabit devices are zero (dual gigabit ethernet card) for the 
> >> 2.6.9-rc2
> >> plus patchs kernel but for the 2.4 series I was getting 12 and 9 as 
> >> can
> >> be seen below and configuring the devices worked fine.
> 
> PCI device IRQs are normally retrieved straight from the PCI device
> itself.  Sounds like a firmware problem (or the bootloader, if that
> sets up the PCI devices for you).

This assumes a world where everything is managed by magic BIOS/OF
initialization. That's not the case for this user's board port.
 
> > irqs for PCI devices do not come from the driver, they are platform
> > specific.  If you are having problems with the interrupt reported
> > by xyz PCI driver then that is something wrong with your platform.
> > On pmac, interrupt routing is retrieved from OF.
> 
> I believe Linux for PowerMac actually gets the IRQ number straight
> from the device.  Some other routing might be gotten out of the OF
> device-tree, yes.

The interrupt line register is always programmed by firmware, bios,
or an OS. It is a logical value that is dependent on the platform.

The only thing statically available on a PCI device is the interrupt
pin register value. That combined with the platform-specific routing
table is used to generate an arbitrary interrupt line value that
is programmed into the PCI interrupt line register.

-Matt
