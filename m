From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15605.24191.948013.249297@argo.ozlabs.ibm.com>
Date: Thu, 30 May 2002 09:04:31 +1000 (EST)
To: Dan Malek <dan@embeddededge.com>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: LMBench and CONFIG_PIN_TLB
In-Reply-To: <3CF4E842.3070207@embeddededge.com>
References: <20020529030838.GZ16537@zax>
	<3CF4E842.3070207@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek writes:

> I implemented the tlb pinning for two reasons.  One, politics, since
> everyone "just knows it is signficanlty better", and two, to alleviate
> the exception path return problem of taking a TLB miss after loading SRR0/1.

The second thing there is important, but there may be other ways
around that problem.

> Pinning TLB entries simply reduces the resource availability.  When I'm
> running a real application, doing real work in a real product, I don't
> want these resources allocated for something else that is seldom used.
> There are lots of other TLB management implementations that can really
> improve performance, they just don't fit well into the current Linux/PowerPC
> design.

I suspect we are all confusing two things here: (1) having pinned TLB
entries and (2) using large-page TLB entries for the kernel.  At the
moment the first is a prerequisite for the second.  The second gives
us a significant performance improvement, and David's measurements
show that.

We could have (2) without pinning any TLB entries but it would take
more code in the TLB miss handler to do that.  It is an interesting
question whether the benefit of having the 64th TLB slot available for
applications would outweigh the cost of the slightly slower TLB
misses.  My feeling is that it would be a close-run thing either way.

> I have seen exactly one application where TLB pinning actually
> improved the performace of the system.  It was a real-time system,
> based on Linux using an MPC8xx, where the maximum event response latency
> had to be guaranteed.  With the proper locking of pages and TLB pins
> this could be done.  It didn't improve the performance of the application,
> but did ensure the system operated properly.

Were you using any large-page TLB entries at all?

The other point that comes to mind is that the downside of pinning a
TLB entry is going to be much larger when you have fewer TLB entries
available.  Tom Rini mentioned the other day that some 8xx processors
only have 8 (I assume he meant 8 data + 8 instruction).  Having one
pinned entry out of 8 is going to be a lot more significant that one
out of 64.  David's suggestion was purely in the context of the 405
processor, which has 64.  I don't think he was advocating removing the
config option on the 8xx processors (actually, why is there the "860
only" comment in there?)

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
