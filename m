Date: Wed, 9 Oct 2002 12:10:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Allen Curtis <acurtis@onz.com>
Cc: Matt Porter <porter@cox.net>,
	Andrew May <acmay@acmay.homeip.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: very minor 405GP and 405GPr PCI difference
Message-ID: <20021009021031.GP32555@zax>
References: <20021008041419.GF32555@zax> <NCBBIINEHIPFGJPLBEIFOEPEDMAA.acurtis@onz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <NCBBIINEHIPFGJPLBEIFOEPEDMAA.acurtis@onz.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Oct 07, 2002 at 11:19:31PM -0700, Allen Curtis wrote:
>
> > As Matt says, this would fall out naturally from a better control
> > structure.  Howeever, I tend to think that leaving things like this to
> > the bootloader/firmware is a bad idea:
> >
> > The kernel has to know how PCI addresses are mapped anyway, so this
> > becomes yet another point at which the kernel and firmware are bound
> > together.  Why should the kernel have code to deal with umpteen
> > different cases of how PCI might have been set up, or not set up by
> > the firmware/bootloader, when it can just take control of the host
> > bridge and reprogram it how it wants?  Once the debugging cruft comes
> > out, it should only be a couple of hundred bytes of code.
>
> I believe that there are many cases where the kernel code is much too
> aggressive with configuration. Personally I believe that all BIOS code
> should totally initialize the processor state so you always have a known
> starting point. (whether you boot Linux or not) Many times I have had to
> track down where the kernel thinks it "knows" the proper configuration and
> unravels the work done by the BIOS. I am not sure how to solve this problem
> but I believe the kernel should attempt to detect and use a configuration
> before reconfiguring any hardware. I have implemented this technique in our
> UART and Ethernet configuration stuff on the 8260 with good success.

This is a nice idea in principle, but IMO it is flawed in practice.
The unfortunate truth is that firmwares are all too frequently broken
in one or more ways (this is not only true for embedded - think APM or
ACPI, or the many buggy OF implementations).  So we need code to
handle (at least some) cases where the firmware setup is incomplete,
or the firmware provides incorrect information.  Worse, in many cases
a new revision of the firmware will remove some bugs but add some new
ones - which mean workarounds tailored to doing a minimum fixup for a
particular BIOS are very fragile.

Given that, how much is really to be gained by carefully tailoring a
kernel to the brokenness or lack thereof of a particular platform's
firmware - as opposed to just always handling the setup ourselves,
putting the device into a known state.

Incidentally the case of a UART is quite different from PCI: you can
use a UART without knowing how it is configured, that way you can
leave the selection of baud rate (for example) up to firmware
configuration and just use its setup - i.e. in this case there is a
tangible benefit from leaving the work up to the firmware.  In the
case of PCI we have to know what the windows are in order to use the
device, so we must know precisely how the firmware has set the bridge
up, in which case why don't we just set it up that way ourselves.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
