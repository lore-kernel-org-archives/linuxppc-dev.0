From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "'Segher Boessenkool'" <segher@koffie.nl>
Cc: "'Paul Mackerras'" <paulus@samba.org>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: SV: SV: New invalidate/clean/flush_dcache functions
Date: Fri, 27 Dec 2002 21:20:04 +0100
Message-ID: <000001c2ade5$5baaa020$94b9143e@hempc>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3E0BA5BB.7B959E63@koffie.nl>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Joakim Tjernlund wrote:
>
> > Only the invalidate function is missing the sync instruction.
> > It's not needed. Invalidating the cache does not touch the memory
> > so there is no need to sync the memory. I have been running my
system
>
> sync is not a "sync the memory" instruction, whatever that should
mean.
> >From chapter 8 of the 32-bit PEM:
>
> 	The sync instruction provides an ordering function for the
> effects of
> 	all instructions executed by a given processor. Executing a
> sync
> 	instruction ensures that all instructions preceding the sync
> instruction
> 	appear to have completed before the sync instruction completes,
> and that
> 	no subsequent instructions are initiated by the processor until
> after the
> 	sync instruction completes. When the sync instruction
> completes, all
> 	external accesses caused by instructions preceding the sync
> instruction
> 	will have been performed with respect to all other mechanisms
> that access
> 	memory.
>
> dcbi can cause external accesses (it invalidates cache on _all_ cpu's
in a
> system, not just the local cpu).


OK thanks.

>
> > without it for a long time and I asked my HW contact at Motorola
about
> > it and he agreed. Others has used the dcbi without a sync without
> > problems.
> >
> > Can you give me a pointer to where the spec claims that a sync is
> > needed after a dcbi?
>
> It doesn't.  Whether the sync is needed or not depends on your usage
of
> the
> dcbi, i.e. 1) is it necessary that the cache line gets invalidated on
all
> other cpu's, too?  and 2) do you already have another sync instruction
on
> this
> cpu, some time after the dcbi, but before the point where you have the
> requirement
> of invalidation?

In my typical example I need to invalidate a buffer before I give it to
the
CPM to be used as a receive buffer. Once given to the CPM there must be
no more writes to that buffer memory. When the CPM has received data
and written the data into the buffer and hands it over to the CPU
(usally via an interrupt) the next read from the CPU must access it from
the memory.  Does the above require a sync?

Does it take some time before a invalidate is completed?

   Jocke
>
> It might very well be true that a sync here isn't necessary, and
sync's
> can be very
> costly (on smp systems), but better be safe than sorry.
>
>
> Cheers,
>
> Segher


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
