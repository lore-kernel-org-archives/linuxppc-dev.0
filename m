Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao11.cox.net (fed1rmmtao11.cox.net [68.230.241.28])
	by ozlabs.org (Postfix) with ESMTP id 94448689FD
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Feb 2006 04:44:08 +1100 (EST)
Date: Wed, 1 Feb 2006 10:44:05 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: David Hawkins <dwh@ovro.caltech.edu>
Subject: Re: Yosemite/440EP why are readl()/ioread32() setup to
	readlittle-endian?
Message-ID: <20060201104405.C16064@cox.net>
References: <35786B99AB3FDC45A8215724617919736D9217@gbrwgceumf01.eu.xerox.net>
	<43E0E9A7.4040508@ovro.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <43E0E9A7.4040508@ovro.caltech.edu>;
	from dwh@ovro.caltech.edu on Wed, Feb 01, 2006 at 09:02:31AM -0800
Cc: linuxppc-embedded@ozlabs.org, "Jenkins, Clive" <Clive.Jenkins@xerox.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Feb 01, 2006 at 09:02:31AM -0800, David Hawkins wrote:
> Jenkins, Clive wrote:
> >>>>readl() and ioread32() read the registers in little-endian format!
> >>>
> >>>Correct. That's how it is implemented on all platforms. Think for
> >>>example of an pci device driver. Using these IO functions, the
> >>>driver will become platform independent, running without
> >>>modifications on little- and big-endian machines.
> >>
> >>I just stumbled across the section in Rubini 3rd Ed that mislead
> >>me into believing that the readl()/writel() were machine endianness
> >>dependent, i.e., LE on x86, BE on PPC.
> > 
> > 
> >>p453 of his book has a PCI DMA example, where he uses the
> >>cpu_to_le32() macros inside calls writel().
> > 
> > 
> >>However, since these functions are internally implemented to
> >>perform LE operations, this example appears to be incorrect.
> > 
> > 
> >>Would you agree?
> > 
> > 
> > No, I think it is correct.
> > 
> > On most architectures readl() and writel() assume you are
> > accessing MMIO on the PCI bus, which is little-endian.
> > So these macros convert between the endian-ness of the CPU
> > and the endian-ness of the PCI bus.
> > 
> > Clive
> 
> Hey Clive,
> 
> Right, but in the 440EP source, and probably on other PowerPC
> ports, readl() and writel() perform the endian conversion for
> you, so if you wrote an operation as
> 
>    writel(register_address, cpu_to_le32(data));
> 
> you would get *two* little endian conversions, i.e., you
> would write the bytes in the wrong order.
> 
> I haven't looked in the source for other big-endian architecures
> yet. I wonder if the ARM stuff is big, or little endian?

Both

> The original question came about while I was trying to read
> back PLX-9054 registers (a PCI-to-local bus bridge on a PCI
> adapter board).

Those regs are little endian since it's a PCI device. You
use the old read*/write* or new ioread*/iowrite* since it's
a PCI device.

> I search through the other drivers for the 440EP peripherals
> that are not on the PCI bus showed that the authors used
> the in_be32() and out_be32() calls. The comment at the top
> of this email indicates that the readl() and writel() are
> effectively 'reserved' for PCI accesses. I didn't get this
> impression from reading Rubini.

The book implicitly focuses on x86 driver developers, that's
why you don't get an explicit statement about this...
"everything" is PCI in that world.

read*/write* and ioread*/iowrite* generate outbound little
endian cycles on ALL arches, period.  They are intended
only for PCI use and have generic names only because of
the assumption that "all the world is a PC".

Now, what it takes to to generate outbound little endian cycles
varies. On some arches, it's just a store (native LE) on
other arches, it's a reversed store (PPC), others still configure
their PCI bridge hardware to do byte swapping in hardware (typically
if their arch doesn't have a simple byte-swapping store like PPC).

The example you cite on pg. 453 of Rubini looks broken for BE
systems. It works on LE systems since cpu_to_le32() does nothing
and writel is a simply dereference. That's pure luck. On PPC,
for example, that would write a big endian bus_addr to the fictitious
PCI device which is not what they want.

-Matt
