Message-ID: <3E0BA5BB.7B959E63@koffie.nl>
Date: Fri, 27 Dec 2002 01:58:36 +0100
From: Segher Boessenkool <segher@koffie.nl>
MIME-Version: 1.0
To: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Cc: "'Paul Mackerras'" <paulus@samba.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: SV: New invalidate/clean/flush_dcache functions
References: <000001c2aa85$ff48d250$83b9143e@hempc>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund wrote:

> Only the invalidate function is missing the sync instruction.
> It's not needed. Invalidating the cache does not touch the memory
> so there is no need to sync the memory. I have been running my system

sync is not a "sync the memory" instruction, whatever that should mean.
>From chapter 8 of the 32-bit PEM:

	The sync instruction provides an ordering function for the effects of
	all instructions executed by a given processor. Executing a sync
	instruction ensures that all instructions preceding the sync instruction
	appear to have completed before the sync instruction completes, and that
	no subsequent instructions are initiated by the processor until after the
	sync instruction completes. When the sync instruction completes, all
	external accesses caused by instructions preceding the sync instruction
	will have been performed with respect to all other mechanisms that access
	memory.

dcbi can cause external accesses (it invalidates cache on _all_ cpu's in a
system, not just the local cpu).

> without it for a long time and I asked my HW contact at Motorola about
> it and he agreed. Others has used the dcbi without a sync without
> problems.
>
> Can you give me a pointer to where the spec claims that a sync is
> needed after a dcbi?

It doesn't.  Whether the sync is needed or not depends on your usage of the
dcbi, i.e. 1) is it necessary that the cache line gets invalidated on all
other cpu's, too?  and 2) do you already have another sync instruction on this
cpu, some time after the dcbi, but before the point where you have the requirement
of invalidation?

It might very well be true that a sync here isn't necessary, and sync's can be very
costly (on smp systems), but better be safe than sorry.


Cheers,

Segher


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
