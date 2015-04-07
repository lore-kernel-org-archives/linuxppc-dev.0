Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ABF1A0757
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2015 05:41:44 +1000 (AEST)
Date: Tue, 7 Apr 2015 21:41:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: Topology updates and NUMA-level sched domains
Message-ID: <20150407194129.GT23123@twins.programming.kicks-ass.net>
References: <20150406214558.GA38501@linux.vnet.ibm.com>
 <20150407102147.GJ23123@twins.programming.kicks-ass.net>
 <20150407171410.GA62529@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150407171410.GA62529@linux.vnet.ibm.com>
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

On Tue, Apr 07, 2015 at 10:14:10AM -0700, Nishanth Aravamudan wrote:
> > So I think (and ISTR having stated this before) that dynamic cpu<->node
> > maps are absolutely insane.
> 
> Sorry if I wasn't involved at the time. I agree that it's a bit of a
> mess!
> 
> > There is a ton of stuff that assumes the cpu<->node relation is a boot
> > time fixed one. Userspace being one of them. Per-cpu memory another.
> 
> Well, userspace already deals with CPU hotplug, right? 

Barely, mostly not.

> And the topology
> updates are, in a lot of ways, just like you've hotplugged a CPU from
> one node and re-hotplugged it into another node.

No, that's very much not the same. Even if it were dealing with hotplug
it would still assume the cpu to return to the same node.

But mostly people do not even bother to handle hotplug.

People very much assume that when they set up their node affinities they
will remain the same for the life time of their program. People set
separate cpu affinity with sched_setaffinity() and memory affinity with
mbind() and assume the cpu<->node maps are invariant.

> I'll look into the per-cpu memory case.

Look into everything that does cpu_to_node() based allocations, because
they all assume that that is stable.

They allocate memory at init time to be node local, but they you go an
mess that up.

> For what it's worth, our test teams are stressing the kernel with these
> topology updates and hopefully we'll be able to resolve any issues that
> result.

Still absolutely insane.

> I will look into per-cpu memory, and also another case I have been
> thinking about where if a process is bound to a CPU/node combination via
> numactl and then the topology changes, what exactly will happen. In
> theory, via these topology updates, a node could go from memoryless ->
> not and v.v., which seems like it might not be well supported (but
> again, should not be much different from hotplugging all the memory out
> from a node).

memory hotplug is even less well handled than cpu hotplug.

And yes, the fact that you need to go look into WTF happens when people
use numactl should be a big arse red flag. _That_ is breaking userspace.

> And, in fact, I think topologically speaking, I think I should be able
> to repeat the same sched domain warnings if I start off with a 2-node
> system with all CPUs on one node, and then hotplug a CPU onto the second
> node, right? That has nothing to do with power, that I can tell. I'll
> see if I can demonstrate it via a KVM guest.

Uhm, no. CPUs will not first appear on node 0 only to then appear on
node 1 later.

If you have a cpu-less node 1 and then hotplug cpus in they will start
and end live on node 1, they'll never be part of node 0.

Also, cpu/memory - less nodes + hotplug to later populate them are
crazeh in they they never get the performance you get from regular
setups. Its impossible to get node-local right.
