From: Gabriel Paubert <paubert@iram.es>
Date: Wed, 12 May 2004 15:45:51 +0200
To: Paul Mackerras <paulus@samba.org>
Cc: Dan Malek <dan@embeddededge.com>, Amit Shah <amitshah@gmx.net>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: IBM 750GX SMP on Marvell Discovery II or III?
Message-ID: <20040512134551.GB31780@iram.es>
References: <c7nb0l$5e3$1@sea.gmane.org> <16544.4592.978105.177882@cargo.ozlabs.ibm.com> <3B3163BD-A2F0-11D8-95B9-003065F9B7DC@embeddededge.com> <16544.16999.648530.393071@cargo.ozlabs.ibm.com> <517E783F-A362-11D8-942E-003065F9B7DC@embeddededge.com> <16545.27647.651552.393992@cargo.ozlabs.ibm.com> <20040512080024.GA26628@iram.es> <16546.3723.214235.623354@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <16546.3723.214235.623354@cargo.ozlabs.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, May 12, 2004 at 09:46:19PM +1000, Paul Mackerras wrote:
>
> Gabriel Paubert writes:
>
> > Are you sure? Since the cache lines are in the other processor memory,
> > they will be flushed to RAM when they are fetched by the processor,
> > provided that you can force the coherence bit on instruction fetches
> > (this is possible IIRC).
>
> The table on page 3-29 of the 750 user manual implies that GBL is
> asserted if M=1 on instruction fetches.  So you're right.
>
> > The most nasty scenario is I believe:
> > - proceeding up to icbi or isync on processor 1,
> > - scheduling and switching the process to processor 2
> > - the instructions were already in the icache on processor 2
> >  for some reasons (PLT entries are half a cache line long IIRC)
>
> Another bad scenario would be:
>
> - write the instructions on processor 1
> - switch the process to processor 2
> - it does the dcbst + sync, which do nothing
> - switch the process back to processor 1
> - icbi, isync, try to execute the instructions
>
> In this scenario the instructions don't get written back to memory.
> So it sounds like when we switch a processor from cpu A to cpu B, we
> would need to (at least) flush cpu A's data cache and cpu B's
> instruction cache.

Argh, I did not think of that case. Switching twice in two instructions
is too devious for me ;-) It is also probably much harder to hit than
the example I gave (which requires either two process switches or a
multithreaded application), but correctness indeed requires a data
cache flush.

Data cache flushes are evil! Strictly speaking I believe that only
the L1 cache needs to be flushed since instruction fetches will look
at L2, but I hoped that a simple flash invalidate of icache would be
sufficient and it's not.

> Basically you can't rely on any cache management instructions being
> effective, because they could be executed on a different processor
> from the one where you need to execute them.  This is true inside the
> kernel as well if you have preemption enabled (you can of course
> disable preemption where necessary, but you have to find and modify
> all those places).  This will also affect the lazy cache flush logic
> that we have that defers doing the dcache/icache flush on a page until
> the page gets mapped into a user process.

I've never looked at that logic so I can't comment.


> > The only solution to this is full icache invalidate when a process
> > changes processors. Threading might however make things worse
> > because threads are entitled to believe from the architecture
> > specification that icbi will affect other threads simultaneously
> > running on other processors. And that has no clean solution AFAICS.
>
> Indeed, I can't see one either.  Not being able to use threads takes
> some of the fun out of SMP, of course.

Bottom line, 750 can't be used for SMP.

>
> > BTW, did I dream or did I read somewhere that on a PPC750 icbi
> > flushes all the cache ways (using only 7 bits of the address).
>
> Page 2-64 says about icbi: "All ways of a selected set are
> invalidated".  It seems that saves them having to actually translate
> the effective address. :)  That means that the kernel doing the
> dcache/icache flush on a page is going to invalidate the whole
> icache.  Ew...

Be more optimistic, consider this as an optimization opportunity!
don't loop over the lines, simply flush the whole cache. Especially
if you want to flush several pages.

For example and if I understand what you mean by lazy cache flushing:
once you have done an icache flush when mapping a page to userspace,
you don't need to perform any other until a page has been unmapped.
(This can probably be improved upon but it's a start).

	Regards,
	Gabriel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
