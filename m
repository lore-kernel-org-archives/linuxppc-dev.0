Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B844B1A0094
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Apr 2015 06:31:07 +1000 (AEST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 10 Apr 2015 14:31:05 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id CC3AE1FF0021
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 14:22:13 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3AKUlXZ40763614
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 13:30:48 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3AKV13c031297
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 14:31:02 -0600
Date: Fri, 10 Apr 2015 13:30:59 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Topology updates and NUMA-level sched domains
Message-ID: <20150410203059.GC31621@linux.vnet.ibm.com>
References: <20150406214558.GA38501@linux.vnet.ibm.com>
 <20150407102147.GJ23123@twins.programming.kicks-ass.net>
 <20150407171410.GA62529@linux.vnet.ibm.com>
 <20150407194129.GT23123@twins.programming.kicks-ass.net>
 <20150409222956.GE53918@linux.vnet.ibm.com>
 <20150410083153.GQ27490@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150410083153.GQ27490@worktop.programming.kicks-ass.net>
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

On 10.04.2015 [10:31:53 +0200], Peter Zijlstra wrote:
> On Thu, Apr 09, 2015 at 03:29:56PM -0700, Nishanth Aravamudan wrote:
> > > No, that's very much not the same. Even if it were dealing with hotplug
> > > it would still assume the cpu to return to the same node.
> > 
> > The analogy may have been poor; a better one is: it's the same as
> > hotunplugging a CPU from one node and hotplugging a physically identical
> > CPU on a different node.
> 
> Then it'll not be the same cpu from the OS's pov. The outgoing cpus and
> the incoming cpus will have different cpu numbers.

Right, it's an analogy. I understand it's not the exact same. I was
trying to have a civil discussion about how to solve this problem
without you calling me a wanker.

> Furthermore at boot we will have observed the empty socket and reserved
> cpu number and arranged per-cpu resources for them.

Ok, I see what you're referring to now:

static void * __init pcpu_fc_alloc(unsigned int cpu, size_t size, size_t
align)
{
	return __alloc_bootmem_node(NODE_DATA(cpu_to_node(cpu)), size,
align,
				    __pa(MAX_DMA_ADDRESS));
}

So we'll be referring to bootmem in the pcpu path for the node we were
on at boot-time.

Actually, this is already horribly broken on power.

[    0.000000] pcpu-alloc: [0] 000 001 002 003 [0] 004 005 006 007 
[    0.000000] pcpu-alloc: [0] 008 009 010 011 [0] 012 013 014 015 
[    0.000000] pcpu-alloc: [0] 016 017 018 019 [0] 020 021 022 023 
[    0.000000] pcpu-alloc: [0] 024 025 026 027 [0] 028 029 030 031 
[    0.000000] pcpu-alloc: [0] 032 033 034 035 [0] 036 037 038 039 
[    0.000000] pcpu-alloc: [0] 040 041 042 043 [0] 044 045 046 047 
[    0.000000] pcpu-alloc: [0] 048 049 050 051 [0] 052 053 054 055 
[    0.000000] pcpu-alloc: [0] 056 057 058 059 [0] 060 061 062 063 
[    0.000000] pcpu-alloc: [0] 064 065 066 067 [0] 068 069 070 071 
[    0.000000] pcpu-alloc: [0] 072 073 074 075 [0] 076 077 078 079 
[    0.000000] pcpu-alloc: [0] 080 081 082 083 [0] 084 085 086 087 
[    0.000000] pcpu-alloc: [0] 088 089 090 091 [0] 092 093 094 095 
[    0.000000] pcpu-alloc: [0] 096 097 098 099 [0] 100 101 102 103 
[    0.000000] pcpu-alloc: [0] 104 105 106 107 [0] 108 109 110 111 
[    0.000000] pcpu-alloc: [0] 112 113 114 115 [0] 116 117 118 119 
[    0.000000] pcpu-alloc: [0] 120 121 122 123 [0] 124 125 126 127 
[    0.000000] pcpu-alloc: [0] 128 129 130 131 [0] 132 133 134 135 
[    0.000000] pcpu-alloc: [0] 136 137 138 139 [0] 140 141 142 143 
[    0.000000] pcpu-alloc: [0] 144 145 146 147 [0] 148 149 150 151 
[    0.000000] pcpu-alloc: [0] 152 153 154 155 [0] 156 157 158 159 

even though the topology is:
available: 4 nodes (0-1,16-17)
node 0 cpus: 0 8 16 24 32
node 1 cpus: 40 48 56 64 72
node 16 cpus: 80 88 96 104 112
node 17 cpus: 120 128 136 144 152

The comment in for pcpu_build_alloc_info() seems wrong:

"The returned configuration is guaranteed
 * to have CPUs on different nodes on different groups and >=75% usage
 * of allocated virtual address space."

Or, we're returning node 0 for everything at this point. I'll debug it
further, but one more question:

If we have CONIFG_USE_PERCPU_NUMA_NODE_ID and are using cpu_to_node()
for setting up the per-cpu areas itself; isn't that a problem?

> > > People very much assume that when they set up their node affinities they
> > > will remain the same for the life time of their program. People set
> > > separate cpu affinity with sched_setaffinity() and memory affinity with
> > > mbind() and assume the cpu<->node maps are invariant.
> > 
> > That's a bad assumption to make if you're virtualized, I would think
> > (including on KVM). Unless you're also binding your vcpu threads to
> > physical cpus.
> > 
> > But the point is valid, that userspace does tend to think rather
> > statically about the world.
> 
> I've no idea how KVM numa is working, if at all. I would not be
> surprised if it indeed hard binds vcpus to nodes. Not doing that allows
> the vcpus to randomly migrate between nodes which will completely
> destroy the whole point of exposing numa details to the guest.

Well, you *can* bind vcpus to nuodes. But you don't have to.

> I suppose some of the auto-numa work helps here. not sure at all.

Yes, it does, I think.

> > > > I'll look into the per-cpu memory case.
> > > 
> > > Look into everything that does cpu_to_node() based allocations, because
> > > they all assume that that is stable.
> > >
> > > They allocate memory at init time to be node local, but they you go an
> > > mess that up.
> > 
> > So, the case that you're considering is:
> > 
> > CPU X on Node Y at boot-time, gets memory from Node Y.
> > 
> > CPU X moves to Node Z at run-time, is still using memory from Node Y.
> 
> Right, at which point numa doesn't make sense anymore. If you randomly
> scramble your cpu<->node map what's the point of exposing numa to the
> guest?
> 
> The whole point of NUMA is that userspace can be aware of the layout and
> use local memory where possible.
> 
> Nobody will want to consider dynamic NUMA information; its utterly
> insane; do you see your HPC compute job going: "oi hold on, I've got to
> reallocate my data, just hold on while I go do this" ? I think not.

Fair point.

> > The memory is still there (or it's also been 'moved' via the hypervisor
> > interface), it's just not optimally placed. Autonuma support should help
> > us move that memory over at run-time, in my understanding.
> 
> No auto-numa cannot fix this. And the HV cannot migrate the memory for
> the same reason.
> 
> Suppose you have two cpus: X0 X1 on node X, you then move X0 into node
> Y. You cannot move memory along with it, X1 might still expect it to be
> on node X.

Well, if they are both using the memory, I believe autonuma will achieve
some sort of homeostasis. Not sure.

> You can only migrate your entire node, at which point nothing has really
> changed (assuming a fully connected system).
> 
> > I won't deny it's imperfect, but honestly, it does actually work (in
> > that the kernel doesn't crash). And the updated mappings will ensure
> > future page allocations are accurate.
> 
> Well it works for you; because all you care about is the kernel not
> crashing.

That's not all I care about, actually. But I think to make userspace
handle this case, the kernel has to not crash first. There really isn't
userspace otherwise, to consider. And we are now at the point where
userspace doesn't crash. But the scheduler, for instance, and probably
other places, are no longer able to load balance a system because it no
longer has an accurate view of the sched domains hierarchy.

> But does it actually provide usable semantics for userspace? Is there
> anyone who _wants_ to use this?

In at least one case where this happens on power, the "user" isn't
selecting anything. The hypervisor is sending events to the partition.
The partition can choose to ignore them, at which point performance will
probably degrade (topologically speaking guest and host now have
different views of the gust). The guest would see the updated partition
topology, in that case, on a reboot, I think.

> What's the point of thinking all your memory is local only to have it
> shredded across whatever nodes you stuffed your vcpu in? Utter crap I'd
> say.

I think the hope is by "fixing" the topology at run-time (these events
are when the topology is already bad and made "good" by putting cpus and
memory closer together), the performance will actually go up, in
practice, without having to reboot systems.

> > But the point is still valid, and I will do my best and work with others
> > to audit the users of cpu_to_node(). When I worked earlier on supporting
> > memoryless nodes, I didn't see too too many init time callers using
> > those APIs, many just rely on getting local allocations implicitly
> > (which I do understand also would break here, but should also get
> > migrated to follow the cpus eventually, if possible).
> 
> init time or not doesn't matter; runtime cpu_to_node() users equally
> expect the allocation to remain local for the duration as well.

And those are already broken for memoryless nodes, afaict (and should be
using cpu_to_mem).

> You've really got to step back and look at what you think you're
> providing.
> 
> Sure you can make all this 'work' but what is the end result? Is it
> useful? I say not. I'm saying that what you end up with is a useless
> pile of crap.

I understand that is your opinion. You've made it rather clear
throughout this thread.

I will try and come up with a clearer documentation of what happens and
what we'd like to provide, maybe that will lead to a more fruitful
discussion.

> > > > For what it's worth, our test teams are stressing the kernel with these
> > > > topology updates and hopefully we'll be able to resolve any issues that
> > > > result.
> > > 
> > > Still absolutely insane.
> > 
> > I won't deny that, necessarily, but I'm in a position to at least try
> > and make them work with Linux.
> 
> Make what work? A useless pile of crap that nobody can or wants to use?

We get the topology events already. Linux can (does) choose to handle
those events or not. If we do handle those events, I would like to
handle them correctly in the kernel. Your opinion seems to be that it
cannot be done. I respect your opinion as a kernel expert.

> > > > I will look into per-cpu memory, and also another case I have been
> > > > thinking about where if a process is bound to a CPU/node combination via
> > > > numactl and then the topology changes, what exactly will happen. In
> > > > theory, via these topology updates, a node could go from memoryless ->
> > > > not and v.v., which seems like it might not be well supported (but
> > > > again, should not be much different from hotplugging all the memory out
> > > > from a node).
> > > 
> > > memory hotplug is even less well handled than cpu hotplug.
> > 
> > That feels awfully hand-wavy to me. Again, we stress test both memory
> > and cpu hotplug pretty heavily.
> 
> That's not the point; sure you stress the kernel implementation; but
> does anybody actually care?
> 
> Is there a single userspace program out there that goes: oh hey, my
> memory layout just changed, lemme go fix that?

This is a good point -- I'm not sure how we'd communicate that to
userspace either. I am guessing that currently we do not.

> > > And yes, the fact that you need to go look into WTF happens when people
> > > use numactl should be a big arse red flag. _That_ is breaking userspace.
> > 
> > It will be the exact same condition as running bound to a CPU and
> > hotplugging that CPU out, as I understand it.
> 
> Yes and that is _BROKEN_.. I'm >< that close to merging a patch that
> will fail hotplug when there is a user task affine to that cpu. This
> madness need to stop _NOW_.

That feels like policy, but that is your choice. What about when it's
affined to the cpus on a node? And we hotplug one of those cpus out?

It feels like what you really don't like is CPU and memory hotplug
generally. I suppose you could push (or merge) a patch that just
disables it. I think you will get push back on such a patch, but that's
the point of the process.

> Also, listen to yourself. The user _wanted_ that task there and you
> say its OK to wreck that.

Not exactly. But I think you're saying that a user's tasks gets to
override system administration tasks. Maybe that's the right choice. I
don't really know. What I am saying is that userspace cannot always be
satisfied in its request. For instance, memoryless nodes that have CPUs
cannot have node-local memory. Does that mean such tasks should be
killed instaed of run with slightly less performant results? Again, I
think that's a policy question.

> Please, step back, look at what you're doing and ask yourself, will any
> sane person want to use this? Can they use this?
> 
> If so, start by describing the desired user semantics of this work.
> Don't start by cobbling kernel bits togerther until it stops crashing.

I will try to do just that. Thank you for input.

-Nish
