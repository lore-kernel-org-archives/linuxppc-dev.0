From: Alan Mimms <alan@packetengines.com>
To: Dan Malek <dan@netx4.com>, Christer Weinigel <wingel@cendio.se>
Subject: Re: WARNING OFF TOPIC SLIGHTLY: 8xx MMU w/8MB pages
Date: Tue, 18 Jan 2000 11:11:40 -0800
Content-Type: text/plain
Cc: alan@packetengines.com, linuxppc-embedded@lists.linuxppc.org
References: <200001181828.TAA23940@dumburk.cendio.se> <3884B779.25C15918@netx4.com>
In-Reply-To: <3884B779.25C15918@netx4.com>
MIME-Version: 1.0
Message-Id: <0001181114300A.00752@alan.corp.packetengines.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks, Dan, for the additional suggestion.

I would like to suggest that using one or two 512MB pages locked into the
TLB's top two slots using the "RSVDn" flag in the Mx_CTL register might be the
right way to go.  Unless you can physically see the RAM present in the 8MB
single TLB entry's mapping in two separate physical addresses (more than 8MB
apart), you'll basically have to waste the memory beyond the top of the
kernel's requirements with this scheme.  Granularity of 512MB would be a good
deal closer and then you can effectively reserve 1MB for the kernel (close to
its actual size) pretty easily.

Or am I misunderstanding the issue somehow?

a

 On Tue, 18 Jan 2000, Dan Malek wrote:
> Christer Weinigel wrote:
>
> > ........  Set the 4/16k bit in
> > MD_RPN to 1 and it'll work.  Apparently, the two page size bits in
> > MD_TWC and the bit från MD_RPN together form the real page size.  The
> > documentation is a bit misleading here.
>
> That is the proper thing to do, but not exactly the reason.  You
> should also set MD_CTR.TWAM = 1, since the problem you are solving
> is telling the MMU not to use 4K/1K subpages.
>
>
> > Now I'd just like to know why I can't get 8 MB pages working with the
> > Linux page tables.
>
>
> How much software are you trying to modify in the generic Linux MM
> functions?  If none, it isn't likely to work except in one condition.
> You will have to wire the pages into permanent TLB entries, and
> move the kernel VM map around to ensure dynamically allocated
> pages don't overlap the 8M "pages".  This is the first and easiest
> to do, but......
>
>
> > ....  The performance boost from putting the Linux
> > kernel in an 8 MB page on a MPC850 is rather impressive, most lmbench
> > system call benchmarks went twice as fast.
>
>
> ....lmbench is not necessary representative of embedded applications.
> PPerforming the above modification to some of the embedded applications
> I have developed would reduce the performance because the number of
> TLB entries in the 850 or 823 is rather small.
>
> As I have said in previous messages, you can find quick little
> hacks like this that may help a specific application, but they
> are not generically beneficial.  The real solution is to significantly
> modify the Linux VM macros and functions to allow a better formatted
> page table and reduce the amount of instructions in the TLB handler.
> Further, we could leverage a variety of page sizes simultaneously.
> This has been on my list for a long time, but isn't a trivial
> weekend project (especially with the VM changes in 2.3.xx).
>
>
> 	-- Dan
--
Alan Mimms     Packet Engines, Inc.     Spokane, Washington [99214-0497]
  USA, Earth, Sol, Milky Way, The Local Group, Virgo Supercluster, U0
Despite the cost of living, have you noticed how popular it remains?
  -- Steven Wright?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
