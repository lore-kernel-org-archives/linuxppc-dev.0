Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao02.cox.net (fed1rmmtao02.cox.net [68.230.241.37])
	by ozlabs.org (Postfix) with ESMTP id 54C7A68A10
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Feb 2006 05:16:07 +1100 (EST)
Date: Thu, 2 Feb 2006 11:16:03 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: "Jenkins, Clive" <Clive.Jenkins@xerox.com>,
	Peter Korsgaard <jacmet@sunsite.dk>,
	Kumar Gala <galak@kernel.crashing.org>, linuxppc-embedded@ozlabs.org
Subject: Re: Yosemite/440EP why are readl()/ioread32() setup to
	readlittle-endian?
Message-ID: <20060202111603.B28536@cox.net>
References: <35786B99AB3FDC45A8215724617919736D921C@gbrwgceumf01.eu.xerox.net>
	<20060202094641.GB12810@gate.ebshome.net>
	<20060202073700.B27740@cox.net>
	<20060202174504.GE12810@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060202174504.GE12810@gate.ebshome.net>;
	from ebs@ebshome.net on Thu, Feb 02, 2006 at 09:45:04AM -0800
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Feb 02, 2006 at 09:45:04AM -0800, Eugene Surovegin wrote:
> On Thu, Feb 02, 2006 at 07:37:01AM -0700, Matt Porter wrote:
> > I mentioned the BE iomap variants that are being used on some non-pci
> > parisc devices already. I'll give a partial example of something that
> > is non-pci yet "arch-independent".
> > 
> > Take a non-pci EHCI core (yes, I know it's little endian by definition
> > but suspend reality for a second).  You can create an arch-independent
> > EHCI driver that uses the platform bus by using the iomap accessors.
> > Since these cores are licensed every day by XYZ startups for their
> > latest "gee-whiz" SoC, it reasons that you'll see the same core on
> > multiple licensable SoC architectures. I've seen one such thing
> > on MIPS.
> > 
> > We also know that major semiconductor companies do the same thing
> > for their peripherals in some cases. They're just as willing to
> > buy somebody else's USB core, for example.  So, having a BE
> > non-pci device cross platform isn't a stretch.
> > 
> > Take a look at drivers/scsi/53c700.{c,h}. That generic driver
> > is why BE iomap accessors were added. It's in the process of
> > being shared between parisc and m68k.
> > 
> 
> Matt, my problem with this approach is that it repeats the same 
> old mistakes but in "BE-mode", e.g. _assuming_ some access mode and 
> hard-coding it into the driver. I fail to see how assuming big-endian 
> is any better than assuming little-endian in this case. And this is 
> not _portable_ in my book, no matter what some people want me to 
> believe.
> 
> This fails miserably when for example you have a bus which does byte 
> swaps in every half-word. And yes, I have such device on my table and 
> I have to port PCMCIA/PCI drivers to this SoC :).

Yuck. But a good example that there are always ill-behaved exceptions.

> Here is how inb looks like:
> 
> static inline u8 fpi_inb(unsigned long port)
> {
>     port ^= 1;
>     return inb(port);
> }
> 
> IMO, truly portable and driver independent I/O accessors should be 
> implemented as a function pointers on per-bus (at least) basis which 
> can be overridden by arch or board code. In this case we can get rid 
> of "ugly" ifdefs in driver code :).

There are a ton of reasons for this too, but there's been resistance
in the past to anything adding an additional dereference to the ia32
case.  I think there's been some proposals to get around this and
maybe even some small level of acceptance. However, since the server
folks don't need it, it's slow going to get such a major change pushed
through.

FWIW, some Xscale IXPs could use the per-bus pointer accessors to
manage the some floating I/O windows more cleanly as well. RapidIO
has some use for it too. It's not just byte swapping at least.

You could drive this change, you know. :)

-Matt
