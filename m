MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16546.3723.214235.623354@cargo.ozlabs.ibm.com>
Date: Wed, 12 May 2004 21:46:19 +1000
From: Paul Mackerras <paulus@samba.org>
To: Gabriel Paubert <paubert@iram.es>
Cc: Dan Malek <dan@embeddededge.com>, Amit Shah <amitshah@gmx.net>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: IBM 750GX SMP on Marvell Discovery II or III?
In-Reply-To: <20040512080024.GA26628@iram.es>
References: <c7nb0l$5e3$1@sea.gmane.org>
	<16544.4592.978105.177882@cargo.ozlabs.ibm.com>
	<3B3163BD-A2F0-11D8-95B9-003065F9B7DC@embeddededge.com>
	<16544.16999.648530.393071@cargo.ozlabs.ibm.com>
	<517E783F-A362-11D8-942E-003065F9B7DC@embeddededge.com>
	<16545.27647.651552.393992@cargo.ozlabs.ibm.com>
	<20040512080024.GA26628@iram.es>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert writes:

> Are you sure? Since the cache lines are in the other processor memory,
> they will be flushed to RAM when they are fetched by the processor,
> provided that you can force the coherence bit on instruction fetches
> (this is possible IIRC).

The table on page 3-29 of the 750 user manual implies that GBL is
asserted if M=1 on instruction fetches.  So you're right.

> The most nasty scenario is I believe:
> - proceeding up to icbi or isync on processor 1,
> - scheduling and switching the process to processor 2
> - the instructions were already in the icache on processor 2
>  for some reasons (PLT entries are half a cache line long IIRC)

Another bad scenario would be:

- write the instructions on processor 1
- switch the process to processor 2
- it does the dcbst + sync, which do nothing
- switch the process back to processor 1
- icbi, isync, try to execute the instructions

In this scenario the instructions don't get written back to memory.
So it sounds like when we switch a processor from cpu A to cpu B, we
would need to (at least) flush cpu A's data cache and cpu B's
instruction cache.

Basically you can't rely on any cache management instructions being
effective, because they could be executed on a different processor
from the one where you need to execute them.  This is true inside the
kernel as well if you have preemption enabled (you can of course
disable preemption where necessary, but you have to find and modify
all those places).  This will also affect the lazy cache flush logic
that we have that defers doing the dcache/icache flush on a page until
the page gets mapped into a user process.

> The only solution to this is full icache invalidate when a process
> changes processors. Threading might however make things worse
> because threads are entitled to believe from the architecture
> specification that icbi will affect other threads simultaneously
> running on other processors. And that has no clean solution AFAICS.

Indeed, I can't see one either.  Not being able to use threads takes
some of the fun out of SMP, of course.

> BTW, did I dream or did I read somewhere that on a PPC750 icbi
> flushes all the cache ways (using only 7 bits of the address).

Page 2-64 says about icbi: "All ways of a selected set are
invalidated".  It seems that saves them having to actually translate
the effective address. :)  That means that the kernel doing the
dcache/icache flush on a page is going to invalidate the whole
icache.  Ew...

Regards,
Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
