Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao07.cox.net (fed1rmmtao07.cox.net [68.230.241.32])
	by ozlabs.org (Postfix) with ESMTP id 1428268A84
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Feb 2006 01:37:03 +1100 (EST)
Date: Thu, 2 Feb 2006 07:37:01 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: "Jenkins, Clive" <Clive.Jenkins@xerox.com>,
	Peter Korsgaard <jacmet@sunsite.dk>,
	Kumar Gala <galak@kernel.crashing.org>, linuxppc-embedded@ozlabs.org
Subject: Re: Yosemite/440EP why are readl()/ioread32() setup to
	readlittle-endian?
Message-ID: <20060202073700.B27740@cox.net>
References: <35786B99AB3FDC45A8215724617919736D921C@gbrwgceumf01.eu.xerox.net>
	<20060202094641.GB12810@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060202094641.GB12810@gate.ebshome.net>;
	from ebs@ebshome.net on Thu, Feb 02, 2006 at 01:46:41AM -0800
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Feb 02, 2006 at 01:46:41AM -0800, Eugene Surovegin wrote:
> On Thu, Feb 02, 2006 at 09:35:56AM -0000, Jenkins, Clive wrote:
> > A driver for some device that could be connected to (or plugged into)
> > a variety of different platforms of different architecture.
> > A driver for a core that could be implemented within an FPGA on
> > multiple platforms.
> 
> Well, this is all nice but I was wondering about _real_ examples.
> When you are talking about "connecting" or "plugging" you have to keep 
> in mind actual bus interconnect. So far AFAIK PCI (and derivatives) 
> are the only cross-arch bus.
> 
> So basically, you have no _real_ life examples, so I'm wondering why 
> people need this "arch-independent" non-PCI I/O accessors for 
> something which doesn't exist.
> 
> I think the reason why Linux doesn't have this stuff follows from the 
> previous paragraph.

I mentioned the BE iomap variants that are being used on some non-pci
parisc devices already. I'll give a partial example of something that
is non-pci yet "arch-independent".

Take a non-pci EHCI core (yes, I know it's little endian by definition
but suspend reality for a second).  You can create an arch-independent
EHCI driver that uses the platform bus by using the iomap accessors.
Since these cores are licensed every day by XYZ startups for their
latest "gee-whiz" SoC, it reasons that you'll see the same core on
multiple licensable SoC architectures. I've seen one such thing
on MIPS.

We also know that major semiconductor companies do the same thing
for their peripherals in some cases. They're just as willing to
buy somebody else's USB core, for example.  So, having a BE
non-pci device cross platform isn't a stretch.

Take a look at drivers/scsi/53c700.{c,h}. That generic driver
is why BE iomap accessors were added. It's in the process of
being shared between parisc and m68k.

-Matt
