Date: Wed, 9 Oct 2002 11:58:28 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew May <acmay@acmay.homeip.net>
Cc: Matt Porter <porter@cox.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: very minor 405GP and 405GPr PCI difference
Message-ID: <20021009015828.GO32555@zax>
References: <20020930040143.GF10265@zax> <20021001052121.GV10265@zax> <3D995EC0.2000500@elsoft.ch> <20021002014219.GF1848@zax> <3D9AA452.5070004@elsoft.ch> <20021003011233.GC1102@zax> <20021006052314.GG27824@acmay.homeip.net> <20021006183120.A17129@home.com> <20021008041419.GF32555@zax> <20021008052136.GA26470@acmay.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021008052136.GA26470@acmay.homeip.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Oct 07, 2002 at 10:21:36PM -0700, Andrew May wrote:
>
> On Tue, Oct 08, 2002 at 02:14:19PM +1000, David Gibson wrote:
> >
> > On Sun, Oct 06, 2002 at 06:31:20PM -0700, Matt Porter wrote:
> > >
> > > On Sat, Oct 05, 2002 at 10:23:14PM -0700, Andrew May wrote:
> > > >
> > > > It would be nice to have the option to let the boot loader set the
> > > > mapping. I have been happy with getting things done in PPCBoot and
> > > > ripping out the PCI scanning in the kernel.
> > >
> > > Yes, that's the ideal situation and going to what David and I would
> > > like to see makes that yet another simple fallout feature.
> > >
> > > Your custom port using a good implementation of PPCBoot simply
> > > would not call the pci macro init library nor would it use pci_auto.
> >
> > As Matt says, this would fall out naturally from a better control
> > structure.  Howeever, I tend to think that leaving things like this to
> > the bootloader/firmware is a bad idea:
>
> A full featured bootloader like PPCboot will need to setup the PCI bus
> to work with PCI devices, so it is not like it is always an extra burden
> on the bootloader or useless work.

That's all very well if you've got PPCboot, but lots of boards have
firmware which is, lets face it, shite.  The kernel has to be able to
deal with this case.  And since it has to deal with it for the case of
crappy firmware, is there any point turning it off for the case of
decent firmware?

> > The kernel has to know how PCI addresses are mapped anyway, so this
> > becomes yet another point at which the kernel and firmware are bound
> > together.  Why should the kernel have code to deal with umpteen
> > different cases of how PCI might have been set up, or not set up by
> > the firmware/bootloader, when it can just take control of the host
> > bridge and reprogram it how it wants?  Once the debugging cruft comes
> > out, it should only be a couple of hundred bytes of code.
>
> I wouldn't want to see the kernel deal with all the possible mapping
> configurations. Right now with everything getting remapped a couple
> of times it makes it hard to follow what the final mapping will be.
> Then we also have the core Linux PCI code that will try to fixup things
> again, if it thinks it is needed. PPCBoot knows how the kernel wants
> things setup so there should be no need to fix it up.

Agreed, with decent firmware there's no need.  But is there any point
turning the code off, since we have to have it anyway to support less
decent firmware.  This also means that the PCI setup for the kernel is
in one place - if for some reason we want to change the default
mapping, only the kernel need by altered, not PPCboot as well.

> So I just want you to keep in mind the PCI bus fixup can be a config
> option that can be built out if desired. It really shouldn't be tied
> to the board itself, since it is also common to load in PPCboot into
> Walnut boards.

That's easy - in fact the patch I posted before allows this (it won't
do anything if CONFIG_BIOS_FIXUP is not defined).

> Then there is always the case of hot-plugs, and the kernel will always
> have to do that mapping there.

Another reason that there is little to be gained by dropping fixup
support on platforms that don't need it.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
