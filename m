Date: Tue, 18 Jan 2000 20:55:08 +0100
Message-Id: <200001181955.UAA24116@dumburk.cendio.se>
From: Christer Weinigel <wingel@cendio.se>
To: dan@netx4.com
CC: alan@packetengines.com, linuxppc-embedded@lists.linuxppc.org
In-reply-to: <3884B779.25C15918@netx4.com> (message from Dan Malek on Tue, 18
	Jan 2000 13:56:57 -0500)
Subject: Re: WARNING OFF TOPIC SLIGHTLY: 8xx MMU w/8MB pages
References: <200001181828.TAA23940@dumburk.cendio.se> <3884B779.25C15918@netx4.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:

> How much software are you trying to modify in the generic Linux MM
> functions?  If none, it isn't likely to work except in one condition.
> You will have to wire the pages into permanent TLB entries, and
> move the kernel VM map around to ensure dynamically allocated
> pages don't overlap the 8M "pages".  This is the first and easiest
> to do, but......

Nope, that's not at all what I'm doing.  What I did was to modify the
data (and instruction) TLB miss handlers, first to add some TLB
statistics, and later to do the 8 MB pages hack, like this:

    dtlb_misses++;		/* update statistics */

#ifdef UGLY_HACK
    addr = MD_EPN & 0xfffff000;
    if (addr >= 0xc0000000 && addr < 0xc0000000 + memory_size)
    {
        MD_TWC = MD_PS8MEG | MD_SVALID;
        MD_RPN = addr | 0xf0 | MD_PS4K_16K | MD_SVALID;
        return;
    }
#endif

    /* normal TLB handler */
    return;

Which means that a normal user application will be able to use all 8
TLB entries, but upon entering the kernel there will usually be two
page faults, one to load one ITLB entry and later one DTLB entry.
Yes, I do know that this slows down each and every TLB miss, but it
was just a quick hack to see if it was worth doing at all.  The
results were rather promising, lmbench went much faster, and just
counting the number of TLB misses from boot until the kernel has been
able to mount an NFS server and show a bash prompt gave this result:

		   misses
		ITLB	DTLB
Unmodified	120k	260k
8 MB hack	15k	35k

What I've been trying to do next is to put the 8 MB page information
in the pgd/pte entries, because I don't want the speed loss coming
from the compare in a time critical code path.  I have read the
comments in the source about pgd entries being used as pointers, so to
begin with, I just tried to change the mapin_ram function to:

    map_page(&init_task, v, p, f | 8);

so that the kernel view of the RAM would use 16 kB pages instead of 4
kB pages.  This fails for some reason and that's what I've been trying
to fix now.  That it what I'd like to get working first of all.

  /Christer

--
Christer Weinigel		Cendio Systems AB
Email:	wingel@cendio.se	Teknikringen 8
Phone:	+46-13-21 46 00		583 30  Linköping
Fax:	+46-13-21 47 00		Sweden
[please note that Signum Support has changed its name to Cendio Systems]

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
