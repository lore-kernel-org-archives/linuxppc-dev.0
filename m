Date: Tue, 8 Oct 2002 07:56:09 -0700
From: Matt Porter <porter@cox.net>
To: Andrew May <acmay@acmay.homeip.net>
Cc: Matt Porter <porter@cox.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: very minor 405GP and 405GPr PCI difference
Message-ID: <20021008075609.A21266@home.com>
References: <20020930040143.GF10265@zax> <20021001052121.GV10265@zax> <3D995EC0.2000500@elsoft.ch> <20021002014219.GF1848@zax> <3D9AA452.5070004@elsoft.ch> <20021003011233.GC1102@zax> <20021006052314.GG27824@acmay.homeip.net> <20021006183120.A17129@home.com> <20021008041419.GF32555@zax> <20021008052136.GA26470@acmay.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021008052136.GA26470@acmay.homeip.net>; from acmay@acmay.homeip.net on Mon, Oct 07, 2002 at 10:21:36PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Oct 07, 2002 at 10:21:36PM -0700, Andrew May wrote:
> I wouldn't want to see the kernel deal with all the possible mapping
> configurations. Right now with everything getting remapped a couple
> of times it makes it hard to follow what the final mapping will be.
> Then we also have the core Linux PCI code that will try to fixup things
> again, if it thinks it is needed. PPCBoot knows how the kernel wants
> things setup so there should be no need to fix it up.
>
> So I just want you to keep in mind the PCI bus fixup can be a config
> option that can be built out if desired. It really shouldn't be tied
> to the board itself, since it is also common to load in PPCboot into
> Walnut boards.

Yes, that's one area we need to keep in mind that isn't well-handled
yet.

> Then there is always the case of hot-plugs, and the kernel will always
> have to do that mapping there.

I think we are all more or less in agreement.  Let me review a couple
scenarios so we all recall why we have a few different methodologies.
Here are the basic systems:

1) Systems that have _perfect_ implementations of firmware that have
   everything set up correct and enumerate the PCI bus properly.
   In embedded, this may mean that things are setup up for your
   specific application though it might not

2) Systems that attempt to have _good_ implementation of firmware.
   General purpose systems that have OF trying to provide infos
   to OS fall in this category.  Unfortunately, they often have
   braindead mistakes necessitating fixups (since most of the infos
   are correct).

3) Systems that have _total crap_ implementations of firmware
   that have things incomplete, set up incorrectly, and can't
   enumerate themselves out of a paper bag.

The kernel should support all of these methodologies...here's why:

In case #1, we may have XYZ COTS PPC vendor who wants to support
Linux and actually implements firmware (PPCboot, whatever) that
works properly.  By doing things correctly, they earn themselves
the privilege of having a Linux port that can work across a family
of boards by simply varying their firmware port to provide the
correct per-board infos to a common port (e.g. pplus_setup.c,
but infos provided in registers)...a modern approach might use
PPCboot and a common family port would just parse birecs specifying
board specific things to do the right thing.  A board port in
this case shouldn't have to do a thing to chip mappings...it's
all correct...thus minimizing the work to maintain the port over
time.  A birec can even contain the PCI host address space range
in order to seamlessly provide the info across the family of
COTS board.

In case #2, we have something similar to #1 but the bitter reality
is that firmware is always doing something wrong in an attempt to
punish kernel people. :)  We have plenty of examples with Mac
and even the embedded-like Briq that provide OF with a vast amount
of infos...some of which are wrong.  So, we look at that the
incorrect cases and fix them up since they are the exception rather
than the rule.

In case #3, we have the all-to-familiar case for me.  Vendor XYZ
produces a worthless hunk of bits that they call firmware.  The
worst ones may be known under such friendly names as PowerBoot,
PMON/2000, and even OpenBIOS.  The problem here is that they do
so many things wrong that fixup like in case #2 becomes a pointless
pile of board-specific code.  We wish we have a case like #1 but
the reality is that it is extremely time-consuming to do a good
firmware port for a general purpose COTS board.  We also don't
control the firmware and may even have a vendor that doesn't
realize that not having good Linux support is going to kill
them eventually.  So, we follow the approach set by people
that have run into this all too often on COTS 7xx/74xx boards,
optional libraries of code.

We can (and already do) support all three methodologies.  The
important thing is to keep supporting them and make it easy
to handle case #3 on 4xx stuff.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
