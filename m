Message-ID: <3CF4E842.3070207@embeddededge.com>
Date: Wed, 29 May 2002 10:40:02 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: LMBench and CONFIG_PIN_TLB
References: <20020529030838.GZ16537@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:

> I did some LMBench runs to observe the effect of CONFIG_PIN_TLB.

I implemented the tlb pinning for two reasons.  One, politics, since
everyone "just knows it is signficanlty better", and two, to alleviate
the exception path return problem of taking a TLB miss after loading SRR0/1.

> .... the difference varies between
> nothing (lost in the noise) to around 15% (fork proc).  The only
> measurement where no pinned entries might be argued to win is
> LMbench's main memory latency measurement.  The difference is < 0.1%
> and may just be chance fluctation.

It has been my experience over the last 20 years that in general
applications that show high TLB miss activity are making inefficient
use of all system resources and aren't likely to be doing any useful
work.  Why aren't we measuring cache efficiency?  Why aren't we profiling
the kernel to see where code changes will really make a difference?
Why aren't we measuring TLB performace on all processors?  If you want
to improve TLB performance, get a processor with larger TLBs or better
hardware support.

Pinning TLB entries simply reduces the resource availability.  When I'm
running a real application, doing real work in a real product, I don't
want these resources allocated for something else that is seldom used.
There are lots of other TLB management implementations that can really
improve performance, they just don't fit well into the current Linux/PowerPC
design.

I have seen exactly one application where TLB pinning actually
improved the performace of the system.  It was a real-time system,
based on Linux using an MPC8xx, where the maximum event response latency
had to be guaranteed.  With the proper locking of pages and TLB pins
this could be done.  It didn't improve the performance of the application,
but did ensure the system operated properly.


> 	The difference between 1 and 2 pinned entries is very small.
> There are a few cases where 1 might be better (but it might just be
> random noise) and a very few where 2 might be better than one.  On the
> basis of that there seems little point in pinning 2 entries.

What kind of scientific analysis is this?  Run controlled tests, post
the results, explain the variances, and allow it to be repeatable by
others.  Is there any consistency to the results?

> ..... Unless someone can come up with a
> real life workload which works poorly with pinned TLBs, I see little
> point in keeping the option - pinned TLBs should always be on (pinning
> 1 entry).


Where is your data that supports this?  Where is your "real life workload"
that actually supports what you want to do?

 From my perspective, your data shows we shouldn't do it.  A "real life
workload" is not a fork proc test, but rather main memory latency test,
where your tests showed it was better to not pin entries but you can't
explain the "fluctuation."  I contend the difference is due to the fact
you have reduced the TLB resources, increasing the number of TLB misses
to an application that is trying to do real work.

I suggest you heed the quote you always attach to your messages.  This
isn't a simple solution that is suitable for all applications.  It's one
option among many that needs to be tuned to meet the requirements of
an application.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
