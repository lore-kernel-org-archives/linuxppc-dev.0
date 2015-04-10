Return-Path: <peterz@infradead.org>
Received: from casper.infradead.org (unknown [IPv6:2001:770:15f::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 996071A2DAC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 18:32:06 +1000 (AEST)
Date: Fri, 10 Apr 2015 10:31:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: Topology updates and NUMA-level sched domains
Message-ID: <20150410083153.GQ27490@worktop.programming.kicks-ass.net>
References: <20150406214558.GA38501@linux.vnet.ibm.com>
 <20150407102147.GJ23123@twins.programming.kicks-ass.net>
 <20150407171410.GA62529@linux.vnet.ibm.com>
 <20150407194129.GT23123@twins.programming.kicks-ass.net>
 <20150409222956.GE53918@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150409222956.GE53918@linux.vnet.ibm.com>
Cc: Boqun Feng <boqun.feng@linux.vnet.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 09, 2015 at 03:29:56PM -0700, Nishanth Aravamudan wrote:
> > No, that's very much not the same. Even if it were dealing with hotplug
> > it would still assume the cpu to return to the same node.
> 
> The analogy may have been poor; a better one is: it's the same as
> hotunplugging a CPU from one node and hotplugging a physically identical
> CPU on a different node.

Then it'll not be the same cpu from the OS's pov. The outgoing cpus and
the incoming cpus will have different cpu numbers.

Furthermore at boot we will have observed the empty socket and reserved
cpu number and arranged per-cpu resources for them.

> > People very much assume that when they set up their node affinities they
> > will remain the same for the life time of their program. People set
> > separate cpu affinity with sched_setaffinity() and memory affinity with
> > mbind() and assume the cpu<->node maps are invariant.
> 
> That's a bad assumption to make if you're virtualized, I would think
> (including on KVM). Unless you're also binding your vcpu threads to
> physical cpus.
> 
> But the point is valid, that userspace does tend to think rather
> statically about the world.

I've no idea how KVM numa is working, if at all. I would not be
surprised if it indeed hard binds vcpus to nodes. Not doing that allows
the vcpus to randomly migrate between nodes which will completely
destroy the whole point of exposing numa details to the guest.

I suppose some of the auto-numa work helps here. not sure at all.

> > > I'll look into the per-cpu memory case.
> > 
> > Look into everything that does cpu_to_node() based allocations, because
> > they all assume that that is stable.
> >
> > They allocate memory at init time to be node local, but they you go an
> > mess that up.
> 
> So, the case that you're considering is:
> 
> CPU X on Node Y at boot-time, gets memory from Node Y.
> 
> CPU X moves to Node Z at run-time, is still using memory from Node Y.

Right, at which point numa doesn't make sense anymore. If you randomly
scramble your cpu<->node map what's the point of exposing numa to the
guest?

The whole point of NUMA is that userspace can be aware of the layout and
use local memory where possible.

Nobody will want to consider dynamic NUMA information; its utterly
insane; do you see your HPC compute job going: "oi hold on, I've got to
reallocate my data, just hold on while I go do this" ? I think not.

> The memory is still there (or it's also been 'moved' via the hypervisor
> interface), it's just not optimally placed. Autonuma support should help
> us move that memory over at run-time, in my understanding.

No auto-numa cannot fix this. And the HV cannot migrate the memory for
the same reason.

Suppose you have two cpus: X0 X1 on node X, you then move X0 into node
Y. You cannot move memory along with it, X1 might still expect it to be
on node X.

You can only migrate your entire node, at which point nothing has really
changed (assuming a fully connected system).

> I won't deny it's imperfect, but honestly, it does actually work (in
> that the kernel doesn't crash). And the updated mappings will ensure
> future page allocations are accurate.

Well it works for you; because all you care about is the kernel not
crashing.

But does it actually provide usable semantics for userspace? Is there
anyone who _wants_ to use this?

What's the point of thinking all your memory is local only to have it
shredded across whatever nodes you stuffed your vcpu in? Utter crap I'd
say.

> But the point is still valid, and I will do my best and work with others
> to audit the users of cpu_to_node(). When I worked earlier on supporting
> memoryless nodes, I didn't see too too many init time callers using
> those APIs, many just rely on getting local allocations implicitly
> (which I do understand also would break here, but should also get
> migrated to follow the cpus eventually, if possible).

init time or not doesn't matter; runtime cpu_to_node() users equally
expect the allocation to remain local for the duration as well.

You've really got to step back and look at what you think you're
providing.

Sure you can make all this 'work' but what is the end result? Is it
useful? I say not. I'm saying that what you end up with is a useless
pile of crap.

> > > For what it's worth, our test teams are stressing the kernel with these
> > > topology updates and hopefully we'll be able to resolve any issues that
> > > result.
> > 
> > Still absolutely insane.
> 
> I won't deny that, necessarily, but I'm in a position to at least try
> and make them work with Linux.

Make what work? A useless pile of crap that nobody can or wants to use?

> > > I will look into per-cpu memory, and also another case I have been
> > > thinking about where if a process is bound to a CPU/node combination via
> > > numactl and then the topology changes, what exactly will happen. In
> > > theory, via these topology updates, a node could go from memoryless ->
> > > not and v.v., which seems like it might not be well supported (but
> > > again, should not be much different from hotplugging all the memory out
> > > from a node).
> > 
> > memory hotplug is even less well handled than cpu hotplug.
> 
> That feels awfully hand-wavy to me. Again, we stress test both memory
> and cpu hotplug pretty heavily.

That's not the point; sure you stress the kernel implementation; but
does anybody actually care?

Is there a single userspace program out there that goes: oh hey, my
memory layout just changed, lemme go fix that?

> > And yes, the fact that you need to go look into WTF happens when people
> > use numactl should be a big arse red flag. _That_ is breaking userspace.
> 
> It will be the exact same condition as running bound to a CPU and
> hotplugging that CPU out, as I understand it.

Yes and that is _BROKEN_.. I'm >< that close to merging a patch that
will fail hotplug when there is a user task affine to that cpu. This
madness need to stop _NOW_.

Also, listen to yourself. The user _wanted_ that task there and you say
its OK to wreck that.


Please, step back, look at what you're doing and ask yourself, will any
sane person want to use this? Can they use this?

If so, start by describing the desired user semantics of this work.
Don't start by cobbling kernel bits togerther until it stops crashing.
