Date: Mon, 15 Oct 01 14:32:22 PDT
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0110152132.AA08287@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: boot methods
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras <paulus@samba.org> wrote:

> There is improvement because you can have a separate wrapper for each
> firmware, if necessary.  At present if we want to change the way
> information is passed into the kernel, we have to synchronously change
> several different firmware/booter implementations, which are
> maintained in separate places by separate people.  The list includes
> (at least) BootX, miboot, yaboot, PPCBoot, and Michael Sokolov's VAX
> console.  This is a logistical nightmare.  Just getting the updates
> into the firmware/booters is bad enough, but then you create problems
> for users who then can't boot old kernels with the new firmware or new
> kernels with the old firmware.

Just for the record, in my case there is no problem with either getting the
changes into the Linux booter or new and old kernels coexisting. My firmware,
which is indeed a VAX console clone for PPC, knows absolutely nothing about how
to boot Linux or any other OS, just like the real VAX console. Just like the
real VAX console, it hands the problem of booting the user's OS of choice to
the OS vendor. To boot Linux I have an entity called ppc-linux-boot, which is
completely free, maintained in public CVS, and not tied to or controlled by SBS
or any other hardware/firmware vendor.

As ppc-linux-boot is free, public, and independent of the SBS firmware, there
can no problem with people changing it any way they want. It is not part of the
system ROM, it is a user-installed utility stored in the user console store, so
any user can easily and legitimately change it whenever s/he likes without
needing any blessing from the hardware manufacturer, and can use experimental
versions hacked by anyone in the world if s/he likes.

When the vmlinux boot interface changes for a platform supported by ppc-linux-
boot, I'll change runlnx (the part of ppc-linux-boot that actually transfers
control to vmlinux) accordingly. I can make the new version support both old
and new kernels by having a boot flag (the user always has to set the correct
boot flags anyway) select the kernel boot interface.

> The reason that nothing has been done is precisely because it is so
> hard at present to change the way that information is passed into the
> kernel, because we still boot the vmlinux directly in some situations.

But currently the vmlinux boot interface is defined per platform: the generic
code passes the initial R3-R7 to platform_init(). It should be possible for a
board port maintainer to change this interface in his/her port without
affecting anyone else.

> If we absolutely *have* to boot a vmlinux directly without a wrapper,
> then probably the best thing is to use bi_recs and pass in a pointer
> to them, since that is reasonably flexible and can be made to be
> forwards and backwards compatible without too much pain.

Yes, and I'm looking forward to usable bi_recs.

> Changing to
> this scheme is going to cause considerable pain in the short term,
> though.

Not at all. Here's how you can make it painless. In arch/ppc/kernel/setup.c
change the division of labor between machine_init and parse_bootinfo. Move the
current logic for locating bi_recs in memory from parse_bootinfo to
machine_init, passing the pointer to bi_recs to parse_bootinfo() as an
argument. Then new board ports can be designed with a bi_recs interface instead
of the current traditional one by doing something like parse_bootinfo(r3) in
platform_init. Existing ports can be converted gradually as their users work
out the transition. I would gladly change the SBS board ports. In fact, one
should first check if the current memory-based bi_recs are being used by anyone
at all. If they aren't, change parse_bootinfo() to take a pointer, remove its
invokation from machine_init altogether, and leave it up to subarch maintainers
to call it from their platform_init's when they are ready to change. Or if the
current memory-based bi_recs are only used on CONFIG_ALL_PPC, do the same but
put the code for locating them and calling parse_bootinfo() in pmac_init,
prep_init, and chrp_init for now. This would have zero impact on CONFIG_ALL_PPC
users while clearing the way for board port maintainers to convert to bi_recs
individually when they are ready.

--
Michael Sokolov				5791 VAN ALLEN WAY
Software Engineer			CARLSBAD CA 92008-7321 USA
SBS Technologies, Inc.			Phone: +1-760-438-6900 x2347
Communications Products			    or  1-888-SBS-COMM x2347
					Fax:   +1-760-438-6985
					E-mail: msokolov@sbs.com
					     or msokolov@ivan.Harhan.ORG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
