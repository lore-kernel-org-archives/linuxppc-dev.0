Date: Thu, 30 May 2002 15:05:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: LMBench and CONFIG_PIN_TLB
Message-ID: <20020530050538.GU16537@zax>
References: <20020529030838.GZ16537@zax> <3CF4E842.3070207@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CF4E842.3070207@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, May 29, 2002 at 10:40:02AM -0400, Dan Malek wrote:
>
> David Gibson wrote:
>
> >I did some LMBench runs to observe the effect of CONFIG_PIN_TLB.
>
> I implemented the tlb pinning for two reasons.  One, politics, since
> everyone "just knows it is signficanlty better", and two, to alleviate
> the exception path return problem of taking a TLB miss after loading SRR0/1.

Ok.

> >.... the difference varies between
> >nothing (lost in the noise) to around 15% (fork proc).  The only
> >measurement where no pinned entries might be argued to win is
> >LMbench's main memory latency measurement.  The difference is < 0.1%
> >and may just be chance fluctation.
>
> It has been my experience over the last 20 years that in general
> applications that show high TLB miss activity are making inefficient
> use of all system resources and aren't likely to be doing any useful
> work.  Why aren't we measuring cache efficiency?  Why aren't we profiling
> the kernel to see where code changes will really make a difference?
> Why aren't we measuring TLB performace on all processors?  If you want
> to improve TLB performance, get a processor with larger TLBs or better
> hardware support.

Good question.  Because we all have finite time.  I figure an LMBench
run on CONFIG_PIN_TLB, while admittedly quite incomplete information
is better than no data at all.

> Pinning TLB entries simply reduces the resource availability.  When I'm
> running a real application, doing real work in a real product, I don't
> want these resources allocated for something else that is seldom used.
> There are lots of other TLB management implementations that can really
> improve performance, they just don't fit well into the current Linux/PowerPC
> design.

As paulus also points out there are two issues here.  Pinning the TLB
entries per se reduces resource availability.  However it provides an
easy way to use a large page TLB entry for the kernel, which for a
number of not infrequent kernel activities is a win according to
LMBench.

> I have seen exactly one application where TLB pinning actually
> improved the performace of the system.  It was a real-time system,
> based on Linux using an MPC8xx, where the maximum event response latency
> had to be guaranteed.  With the proper locking of pages and TLB pins
> this could be done.  It didn't improve the performance of the application,
> but did ensure the system operated properly.
>
> >	The difference between 1 and 2 pinned entries is very small.
> >There are a few cases where 1 might be better (but it might just be
> >random noise) and a very few where 2 might be better than one.  On the
> >basis of that there seems little point in pinning 2 entries.
>
> What kind of scientific analysis is this?  Run controlled tests, post
> the results, explain the variances, and allow it to be repeatable by
> others.  Is there any consistency to the results?

Ok, put it like this: a) this LMbench run shows very weak evidence
that 1 pinned entry is better than 2, but certainly no evidence that 2
beats 1. b) I see no theoretical reason that 2 pinned entries would do
significantly better than 1 (16MB being sufficient to cover all the
kernel text, static data and BSS), c) 1 pinned entry is slightly
simpler than 2 and therefore wins by default.

> >..... Unless someone can come up with a
> >real life workload which works poorly with pinned TLBs, I see little
> >point in keeping the option - pinned TLBs should always be on (pinning
> >1 entry).
>
> Where is your data that supports this?  Where is your "real life workload"
> that actually supports what you want to do?

Ok, put it this way:

Pro CONFIG_PIN_TLB (as currently implemented):
    	- LMbench results, admittedly inconclusive
	- Makes ensuring the exception exit is safe easier
Con CONFIG_PIN_TLB (as currently implemented):
	- You think it isn't a good idea
	- Possible miniscule improvement in main memory latency

Data from a real life workload would certainly trump all the "pro"
arguments I've listed there.  Give me some numbers supporting your
case and I'll probably agree with you, but given no other data this
suggests that CONFIG_PIN_TLB wins.  Oh, incidentally a kernel compile
also appears to be slightly faster with CONFIG_PIN_TLB.

> From my perspective, your data shows we shouldn't do it.  A "real life
> workload" is not a fork proc test, but rather main memory latency test,
> where your tests showed it was better to not pin entries but you can't
> explain the "fluctuation."  I contend the difference is due to the fact
> you have reduced the TLB resources, increasing the number of TLB misses
> to an application that is trying to do real work.

Dan, either you're not reading or you're not thinking.  The difference
between the memory latency numbers is tiny, less than 0.1%.  If you
actually look at the LMbench numbers (I have three runs in each
situation), the random variation between each run is around the same
size.  Therefore the data is inconclusive, put possibly suggests a
slowdown with CONFIG_PIN_TLB - particularly given that there are at
least two plausible explanations for the slowdown, (a) because we have
less free TLB entries we are taking more TLB misses and (b) with
CONFIG_PIN_TLB the TLB fault handler has a few extra instructions.
*But* any such slowdown is <0.1%.  It doesn't take that many page
faults (say) which appear to be around 15% faster with CONFIG_PIN_TLB,
for that to be a bigger win than the (possible) memory access
slowdown.

> I suggest you heed the quote you always attach to your messages.  This
> isn't a simple solution that is suitable for all applications.  It's one
> option among many that needs to be tuned to meet the requirements of
> an application.

Ok.  Show me an application where CONFIG_PIN_TLB loses.  I'm perfectly
willing to accept they exist.  At the moment I've presented little
data, but you've presented none.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
