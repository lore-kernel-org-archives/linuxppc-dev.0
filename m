Date: Sat, 6 Apr 02 12:23:17 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0204062023.AA17004@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: CONFIG_GENERIC_PPC32
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


: ChangeSet
:   1.925 02/04/05 23:09:25 msokolov@helium.harhan.org +60 -0
:   Add generic PPC32 config, implemented for Adirondack, EV-64260A, and K2
:   New GT-64260 support implementation under CONFIG_GENERIC_PPC32
:   bi_recs enhancements (persistent, nested, searchable, GT-64260 support)
:   PPCStar zImage support under CONFIG_GENERIC_PPC32
:   Many small enhancements along the way

Some commentary is in order on this cset. I strongly recommend that Paulus,
people interested in bi_recs enhancements, and people interested in GT-64260
support check it out and give it a good look.

For Paulus: Remember the discussions a while ago about CONFIG_ALL_PPC not
really being all PPC and the need to either change it or remove it or somehow
get it straight? Well, this cset does it. I've created CONFIG_GENERIC_PPC32 as
an alternative to the current very misnamed CONFIG_ALL_PPC. Unlike the latter,
it actually can support all standard non-embedded PPC ports in the current
tree. It is a single configuration vmlinux that relies on a list of bi_recs to
be passed to it to tell it what it's running on: the _machine value passed via
BI_MACHTYPE and other info if necessary. The minimal platform_init parses the
bi_recs (pointed to by R3) and dispatches to the init routine for the platform
selected by BI_MACHTYPE. Any number of platforms can be included in the
configuration. Each is selected with a bool in config.in so the user can
include only the platform(s) that s/he needs, while distribution makers can
ship one kernel for the world.

The platforms I've initially included in this new model are Adirondack,
EV-64260A, and K2. Other non-CONFIG_ALL_PPC 6xx/7xx/74xx boards in the current
2_4_devel can be easily added given someone knowledgeable about that board.
(Some may require an #ifdef-ectomy.) And finally, the CHRP, PMac, and PReP
ports can also be converted to CONFIG_GENERIC_PPC32 by someone who knows more
about them than I do and has hardware to test on. (And perhaps the PReP port
could then be just like, say, the K2 port and the CHRP and PMac ones combined
into a single OF port as I've heard suggestions.) That would allow the current
CONFIG_ALL_PPC morass to be laid to rest and replaced with a true all PPC
configuration.

There is no extra overhead in the kernel for CONFIG_GENERIC_PPC32. A
CONFIG_GENERIC_PPC32 configuration with only one port selected is no different
from any of current castle-walled board ports in 2_4_devel. The only price to
pay for CONFIG_GENERIC_PPC32 is in the boot mechanism. One has to either boot
vmlinux directly with a bootloader that can generate all the needed bi_recs
including BI_MACHTYPE, have a zImage wrapper that can sense the machine type,
or have make zImage create a bunch of zImages for different ports and/or
bootloaders as done currently for CONFIG_ALL_PPC where make zImage gives you 3
zImages for chrp, pmac, and prep. However, the arch/ppc/boot/simple way of
doing things that the MVistities seem to love so much is fundamentally
incompatible with this.

In what I have right now make zImage for CONFIG_GENERIC_PPC32 makes a ppcstar
zImage wrapper for PPCStar systems, which can identify which PPCStar system
it's running on (per the PPCStar spec) and select the right port in vmlinux
with BI_MACHTYPE. (Adirondack, EV-64260A, and K2 are PPCStar systems when
fitted with StarMON ROMs that are available for them.) If the CHRP, PMac, and
PReP are integrated into CONFIG_GENERIC_PPC32 the chrp, pmac, and prep
subdirectories of arch/ppc/boot can be easily added to the CONFIG_GENERIC_PPC32
line in arch/ppc/boot, giving you 4 zImages made on one make zImage: chrp,
pmac, ppstar, and prep.

The problem is what to do about all the other board ports I envision people
adding, each having its own unique boot mechanism requiring its own zImage. In
that case I don't see much choice other than extending the chrp/pmac/prep 3
zImages model to N zImages for all those platform-unique booters. This will be
an encouragement to board makers to use standardized firmware like OF, StarMON,
or PPCBoot rather than roll a board-unique one: use something standard and you
can use one of existing zImages, or roll your own and be prepared to convince
people to accept adding yet another zImage. OTOH, it seems like a lot of boards
ship without any usable firmware at all and anyone wanting to run Linux has to
reach for the PROM burner anyway. For those we can simply tell people to use
StarMON or PPCBoot to run the new generic PPC Linux.

On to bi_recs. I have implemented the persistent, nested, and searchable
bi_recs which were the consensus of a recent hot discussion on this list
coached by Mark Greer. It works and is fully backward-compatible with the
bi_recs in the current 2_4_devel, check it out. While I was at it, I converted
the handling of BI_MEMSIZE to the new way. Right now in 2_4_devel it is
detected in the initial parsing and the value is saved in a global var that the
generic kernel code doesn't use. Instead, the latter calls
ppc_md.find_end_of_memory() to get the memory size, and ports wishing to use
BI_MEMSIZE provide a boilerplate routine consisting of return(boot_mem_size).
With the new persistent and searchable bi_recs the better way is obvious:
remove the boot_mem_size global var, have a routine that searches the
BI_MEMSIZE, and returns it. Ports wishing to use BI_MEMSIZE simply point
ppc_md.find_end_of_memory at this routine instead of each including the same
old boilerplate. It's implemented in my patch. I've also added all the bi_recs
in Mark's patch plus BI_CPU_BUS_SPEED and BI_CPU_CORE_SPEED.

On to GT-64260. I've rewritten the GT-64260 support code from scratch only
selectively taking bits from the old one, as opposed to taking the old one and
selectively modifying it. The old gt64260_common.c etc. files are bk rm'ed in
my tree. My new implementation is fully integrated into CONFIG_GENERIC_PPC32. A
single configuration can support a single GT-based port, multiple different
ones, or a mixture of GT-based and other ports. IOW, it's done right. The GT-
specific bi_recs are exactly as hashed out by Mark, just implemented right. The
only port is my tree for GT-64260 right now is my reference EV-64260A port.
Again it's written from scratch selectively taking a few old bits. It's not the
same as my old EV-64260-SBS and EV-64260-MS ports which were intended for my
own use only, this one is for public consumption. I only have a zImage wrapper
for PPCStar, but the actual port in vmlinux is designed to work with any sane
boot ROM, although I have nothing to test it on except StarMON. I encourage
PPCBoot folks to try it, since you say you boot vmlinux directly, it should
work for you, just give it the bi_recs it needs.

Have fun!

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
