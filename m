Date: Fri, 11 Oct 2002 12:37:20 -0700
From: Andrew May <acmay@acmay.homeip.net>
To: Matt Porter <porter@cox.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: very minor 405GP and 405GPr PCI difference
Message-ID: <20021011193720.GA9039@acmay.homeip.net>
References: <20021001052121.GV10265@zax> <3D995EC0.2000500@elsoft.ch> <20021002014219.GF1848@zax> <3D9AA452.5070004@elsoft.ch> <20021003011233.GC1102@zax> <20021006052314.GG27824@acmay.homeip.net> <20021006183120.A17129@home.com> <20021008041419.GF32555@zax> <20021008052136.GA26470@acmay.homeip.net> <20021009015828.GO32555@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021009015828.GO32555@zax>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sorry about the late reply but I wanted to check the 2.5 tree and I haven't
been looking at it before.

On Wed, Oct 09, 2002 at 11:58:28AM +1000, David Gibson wrote:
>
> On Mon, Oct 07, 2002 at 10:21:36PM -0700, Andrew May wrote:
> >
> > A full featured bootloader like PPCboot will need to setup the PCI bus
> > to work with PCI devices, so it is not like it is always an extra burden
> > on the bootloader or useless work.
>
> That's all very well if you've got PPCboot, but lots of boards have
> firmware which is, lets face it, shite.  The kernel has to be able to
> deal with this case.  And since it has to deal with it for the case of
> crappy firmware, is there any point turning it off for the case of
> decent firmware?

Yes there is a point. I am working on a new custum PCI device and the
hardware guy gives me silly requests to try differnt PCI bus settings.
And I would much rather make the changes in my small quick PPCBoot build
rather than a full kernel build.

> > So I just want you to keep in mind the PCI bus fixup can be a config
> > option that can be built out if desired. It really shouldn't be tied
> > to the board itself, since it is also common to load in PPCboot into
> > Walnut boards.
>
> That's easy - in fact the patch I posted before allows this (it won't
> do anything if CONFIG_BIOS_FIXUP is not defined).

Well you patch is only part of the issue, it is the rest of
arch/ppc/kernel/4xx/ppc405_pci.c that gets pulled in every build with PCI,
that remapps everything in _find_bridges.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
