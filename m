Date: Tue, 8 Oct 2002 14:14:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Matt Porter <porter@cox.net>
Cc: Andrew May <acmay@acmay.homeip.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: very minor 405GP and 405GPr PCI difference
Message-ID: <20021008041419.GF32555@zax>
References: <OF8DC4E66D.5C36B7D3-ON87256C41.00434ACB@boulder.ibm.com> <20020930040143.GF10265@zax> <20021001052121.GV10265@zax> <3D995EC0.2000500@elsoft.ch> <20021002014219.GF1848@zax> <3D9AA452.5070004@elsoft.ch> <20021003011233.GC1102@zax> <20021006052314.GG27824@acmay.homeip.net> <20021006183120.A17129@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021006183120.A17129@home.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sun, Oct 06, 2002 at 06:31:20PM -0700, Matt Porter wrote:
>
> On Sat, Oct 05, 2002 at 10:23:14PM -0700, Andrew May wrote:
> >
> > On Thu, Oct 03, 2002 at 11:12:33AM +1000, David Gibson wrote:
> > >
> > > Fair enough.  I'm just trying to come up with the simplest approach
> > > that still provides the flexibility we need.  Based on the evidence
> > > immediately available, what I posted seemed like it.  How about you
> > > tell me something about the non-standard PCI mappings, so I can come
> > > up with something better.
> >
> > It would be nice to have the option to let the boot loader set the
> > mapping. I have been happy with getting things done in PPCBoot and
> > ripping out the PCI scanning in the kernel.
>
> Yes, that's the ideal situation and going to what David and I would
> like to see makes that yet another simple fallout feature.
>
> Your custom port using a good implementation of PPCBoot simply
> would not call the pci macro init library nor would it use pci_auto.

As Matt says, this would fall out naturally from a better control
structure.  Howeever, I tend to think that leaving things like this to
the bootloader/firmware is a bad idea:

The kernel has to know how PCI addresses are mapped anyway, so this
becomes yet another point at which the kernel and firmware are bound
together.  Why should the kernel have code to deal with umpteen
different cases of how PCI might have been set up, or not set up by
the firmware/bootloader, when it can just take control of the host
bridge and reprogram it how it wants?  Once the debugging cruft comes
out, it should only be a couple of hundred bytes of code.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
