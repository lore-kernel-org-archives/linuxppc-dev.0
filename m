From: Gabriel Paubert <paubert@iram.es>
Date: Wed, 12 May 2004 10:00:24 +0200
To: Paul Mackerras <paulus@samba.org>
Cc: Dan Malek <dan@embeddededge.com>, Amit Shah <amitshah@gmx.net>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: IBM 750GX SMP on Marvell Discovery II or III?
Message-ID: <20040512080024.GA26628@iram.es>
References: <c7nb0l$5e3$1@sea.gmane.org> <16544.4592.978105.177882@cargo.ozlabs.ibm.com> <3B3163BD-A2F0-11D8-95B9-003065F9B7DC@embeddededge.com> <16544.16999.648530.393071@cargo.ozlabs.ibm.com> <517E783F-A362-11D8-942E-003065F9B7DC@embeddededge.com> <16545.27647.651552.393992@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <16545.27647.651552.393992@cargo.ozlabs.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, May 12, 2004 at 10:12:47AM +1000, Paul Mackerras wrote:
>
> Dan Malek writes:
>
> > But, read the following sentence.  "Any bus activity caused by other
> > cache instructions results directly from performing the operation on
> > the MPC750 cache."  A dcbz has to be broadcast, others do not because
> > their operations appear just as standard load/store ops.
> >
> > The only thing we should have to do in software is the icbi, which is
> > no big deal to broadcast.
>
> I don't think you are right, but it would be nice if you can prove me
> wrong. ;)
>
> Consider this scenario: an application is modifying some instructions
> (for example, ld.so modifying a PLT entry).  It modifies the
> instructions, and then just before it does its dcbst; sync; icbi;
> isync sequence, it gets scheduled on the other CPU.  It goes ahead and
> does the dcbst.  However, the relevant cache lines aren't in the the
> cache (they are in the E state in the other CPU's cache), so nothing
> gets written out to memory.  After doing the sync; icbi; isync it goes
> to execute the instructions and gets the old instructions, not the new
> ones.

Are you sure? Since the cache lines are in the other processor memory,
they will be flushed to RAM when they are fetched by the processor,
provided that you can force the coherence bit on instruction fetches
(this is possible IIRC).

The most nasty scenario is I believe:
- proceeding up to icbi or isync on processor 1,
- scheduling and switching the process to processor 2
- the instructions were already in the icache on processor 2
 for some reasons (PLT entries are half a cache line long IIRC)

The only solution to this is full icache invalidate when a process
changes processors. Threading might however make things worse
because threads are entitled to believe from the architecture
specification that icbi will affect other threads simultaneously
running on other processors. And that has no clean solution AFAICS.

BTW, did I dream or did I read somewhere that on a PPC750 icbi
flushes all the cache ways (using only 7 bits of the address).
This would mean that flushing an instruction cache page flushes
the whole cache, and settnig HID0[ICFI] might be faster.

> The dcbst won't cause any stores to memory in this scenario.  It will
> cause a dcbst address-only broadcast but that won't (according to my
> reading of the manual) cause the other CPU to write back its copy of
> the relevant cache line, since the dcbst isn't snooped.

Yeah, but the subsequent fetch will be snooped if it's marked
coherent. dcbst is really only necessary because instruction fetches
don't look into the L1 data cache of the same processor.

>
> The only workaround I can see for this is to completely flush the D
> and I caches of both CPUs whenever we schedule a process on a
> different CPU from that on which it last ran.  Triple yuck.

As I said, I believe the real problem is multithreaded applications.

>
> > My experience has been that MPC750s work in a SMP environment
> > on a 60x bus.  Maybe I was just lucky?  The way I read the manual,
> > they should work with a proper memory controller.
>
> I think that the sorts of problems I am talking about wouldn't show up
> very often.  Generally I think that these problems would just cause
> the system to be a bit flaky rather than stop it from working at all.

I agree.

> If you didn't have L2 caches that would make the problems show up less
> frequently, too.

I'm not so sure. Instruction fetches look into L2 caches. The main issue
are:
1) are the instruction fetches marked coherent?
2) do you run multithreaded applications?

If you answer yes and no, then I don't see any showstopper.

	Regards,
	Gabriel


>
> Regards,
> Paul.
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
