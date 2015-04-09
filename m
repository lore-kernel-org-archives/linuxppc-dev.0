Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D9A941A0C44
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 08:30:02 +1000 (AEST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Thu, 9 Apr 2015 16:30:00 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id D19321FF0021
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Apr 2015 16:21:08 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t39MTfaH28704770
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Apr 2015 15:29:41 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t39MTvwJ029029
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Apr 2015 16:29:57 -0600
Date: Thu, 9 Apr 2015 15:29:56 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Topology updates and NUMA-level sched domains
Message-ID: <20150409222956.GE53918@linux.vnet.ibm.com>
References: <20150406214558.GA38501@linux.vnet.ibm.com>
 <20150407102147.GJ23123@twins.programming.kicks-ass.net>
 <20150407171410.GA62529@linux.vnet.ibm.com>
 <20150407194129.GT23123@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150407194129.GT23123@twins.programming.kicks-ass.net>
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

On 07.04.2015 [21:41:29 +0200], Peter Zijlstra wrote:
> On Tue, Apr 07, 2015 at 10:14:10AM -0700, Nishanth Aravamudan wrote:
> > > So I think (and ISTR having stated this before) that dynamic cpu<->node
> > > maps are absolutely insane.
> > 
> > Sorry if I wasn't involved at the time. I agree that it's a bit of a
> > mess!
> > 
> > > There is a ton of stuff that assumes the cpu<->node relation is a boot
> > > time fixed one. Userspace being one of them. Per-cpu memory another.
> > 
> > Well, userspace already deals with CPU hotplug, right? 
> 
> Barely, mostly not.

Well, as much as it needs to, I mean. CPU hotlug is done quite regularly
on power, at least.

> > And the topology updates are, in a lot of ways, just like you've
> > hotplugged a CPU from one node and re-hotplugged it into another
> > node.
> 
> No, that's very much not the same. Even if it were dealing with hotplug
> it would still assume the cpu to return to the same node.

The analogy may have been poor; a better one is: it's the same as
hotunplugging a CPU from one node and hotplugging a physically identical
CPU on a different node.

> But mostly people do not even bother to handle hotplug.

I'm not sure what you mean by "people" here, but I think it's what you
outline below.

> People very much assume that when they set up their node affinities they
> will remain the same for the life time of their program. People set
> separate cpu affinity with sched_setaffinity() and memory affinity with
> mbind() and assume the cpu<->node maps are invariant.

That's a bad assumption to make if you're virtualized, I would think
(including on KVM). Unless you're also binding your vcpu threads to
physical cpus.

But the point is valid, that userspace does tend to think rather
statically about the world.

> > I'll look into the per-cpu memory case.
> 
> Look into everything that does cpu_to_node() based allocations, because
> they all assume that that is stable.
>
> They allocate memory at init time to be node local, but they you go an
> mess that up.

So, the case that you're considering is:

CPU X on Node Y at boot-time, gets memory from Node Y.

CPU X moves to Node Z at run-time, is still using memory from Node Y.

The memory is still there (or it's also been 'moved' via the hypervisor
interface), it's just not optimally placed. Autonuma support should help
us move that memory over at run-time, in my understanding.

I won't deny it's imperfect, but honestly, it does actually work (in
that the kernel doesn't crash). And the updated mappings will ensure
future page allocations are accurate.

But the point is still valid, and I will do my best and work with others
to audit the users of cpu_to_node(). When I worked earlier on supporting
memoryless nodes, I didn't see too too many init time callers using
those APIs, many just rely on getting local allocations implicitly
(which I do understand also would break here, but should also get
migrated to follow the cpus eventually, if possible).

> > For what it's worth, our test teams are stressing the kernel with these
> > topology updates and hopefully we'll be able to resolve any issues that
> > result.
> 
> Still absolutely insane.

I won't deny that, necessarily, but I'm in a position to at least try
and make them work with Linux.

> > I will look into per-cpu memory, and also another case I have been
> > thinking about where if a process is bound to a CPU/node combination via
> > numactl and then the topology changes, what exactly will happen. In
> > theory, via these topology updates, a node could go from memoryless ->
> > not and v.v., which seems like it might not be well supported (but
> > again, should not be much different from hotplugging all the memory out
> > from a node).
> 
> memory hotplug is even less well handled than cpu hotplug.

That feels awfully hand-wavy to me. Again, we stress test both memory
and cpu hotplug pretty heavily.

> And yes, the fact that you need to go look into WTF happens when people
> use numactl should be a big arse red flag. _That_ is breaking userspace.

It will be the exact same condition as running bound to a CPU and
hotplugging that CPU out, as I understand it. In the kernel, actually,
we can (do) migrate CPUs via stop_machine and so it's slightly different
than a hotplug event (numbering is consistent, just the mapping has
changed).

So maybe the better example would be being bound to a given node and
having the CPUs in that node change. We would need to ensure the sched
domains are accurate after the update, so that the policies can be
accurately applied, afaict. That's why I'm asking you as the sched
domain expert what exactly needs to be done.

> > And, in fact, I think topologically speaking, I think I should be able
> > to repeat the same sched domain warnings if I start off with a 2-node
> > system with all CPUs on one node, and then hotplug a CPU onto the second
> > node, right? That has nothing to do with power, that I can tell. I'll
> > see if I can demonstrate it via a KVM guest.
> 
> Uhm, no. CPUs will not first appear on node 0 only to then appear on
> node 1 later.

Sorry I was unclear in my statement. The "hotplug a CPU" wasn't one that
was unplugged from node 0, it was only added to node 1. In other words,
I was trying to say:

Node 0 - all CPUs, some memory
Node 1 - no CPUs, some memory

<hotplug event>

Node 0 - same CPUs, some memory
Node 1 - some CPUs, some memory

> If you have a cpu-less node 1 and then hotplug cpus in they will start
> and end live on node 1, they'll never be part of node 0.

Yes, that's exactly right.

But node 1 won't have a sched domain at the NUMA level, because it had
no CPUs on it to start. And afaict, there's no support to build that
NUMA level domain at run-time if the CPU is hotplugged?

> Also, cpu/memory - less nodes + hotplug to later populate them are
> crazeh in they they never get the performance you get from regular
> setups. Its impossible to get node-local right.

Ok, so the performance may suck and we may eventually say -- reboot when
you can, to re-init everything properly. But I'd actually like to limp
along (which in fact we do already). I'd like the limp to be a little
less pronounced by building the proper sched domains in the example I
gave. I get the impression you disagree, so we'll continue to limp
as-is.

Thanks for your insight,
Nish
