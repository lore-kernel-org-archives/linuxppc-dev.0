Date: Tue, 8 Oct 2002 08:18:00 -0700
From: Matt Porter <porter@cox.net>
To: Allen Curtis <acurtis@onz.com>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	Matt Porter <porter@cox.net>, Andrew May <acmay@acmay.homeip.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: very minor 405GP and 405GPr PCI difference
Message-ID: <20021008081800.C21266@home.com>
References: <20021008041419.GF32555@zax> <NCBBIINEHIPFGJPLBEIFOEPEDMAA.acurtis@onz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <NCBBIINEHIPFGJPLBEIFOEPEDMAA.acurtis@onz.com>; from acurtis@onz.com on Mon, Oct 07, 2002 at 11:19:31PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Oct 07, 2002 at 11:19:31PM -0700, Allen Curtis wrote:
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
>
> Only a suggestion...

This is a good time to reiterate that *if* your processor family
code is designed with the proper flow, you can decide how to approach
this on a case-by-case basis.

I don't want to comment to heavily on 826x stuffs but I think the
approach may well be the by-product of Dan's methodology of a
minimal bootrom, thus necessitating chip-level setup.  The
code clearly follows the "flow through a common file" approach
which tends to make per-board/system changes a bit hacky if you
start having 8260-based systems that have attributes that are
less alike.  The approach is fine if every system using a particular
SoC is very similar (i.e. not much external I/O or custom strappings).

I laid out the three cases of firmware/kernel coupling that I
know of in a separate post.  I think you'll find that there
are many cases where it is not feasible or possible to control
the firmware.  Obviously, we would all like to have the firmware
be 100% correct but that is not reality.  In some ways, you folks
doing custom board bringup for you application have the ideal
situation compared to dealing with reference/COTS boards with
blackbox firmware.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
