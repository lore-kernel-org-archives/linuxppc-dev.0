Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3436E1A084B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2015 03:14:18 +1000 (AEST)
Received: from /spool/local
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Tue, 7 Apr 2015 13:14:15 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 8A37DC9003E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Apr 2015 13:05:22 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t37HEDU523199776
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Apr 2015 17:14:13 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t37HECcj003617
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Apr 2015 13:14:12 -0400
Date: Tue, 7 Apr 2015 10:14:10 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Topology updates and NUMA-level sched domains
Message-ID: <20150407171410.GA62529@linux.vnet.ibm.com>
References: <20150406214558.GA38501@linux.vnet.ibm.com>
 <20150407102147.GJ23123@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150407102147.GJ23123@twins.programming.kicks-ass.net>
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

On 07.04.2015 [12:21:47 +0200], Peter Zijlstra wrote:
> On Mon, Apr 06, 2015 at 02:45:58PM -0700, Nishanth Aravamudan wrote:
> > Hi Peter,
> > 
> > As you are very aware, I think, power has some odd NUMA topologies (and
> > changes to the those topologies) at run-time. In particular, we can see
> > a topology at boot:
> > 
> > Node 0: all Cpus
> > Node 7: no cpus
> > 
> > Then we get a notification from the hypervisor that a core (or two) have
> > moved from node 0 to node 7. This results in the:
> 
> > or a re-init API (which won't try to reallocate various bits), because
> > the topology could be completely different now (e.g.,
> > sched_domains_numa_distance will also be inaccurate now).  Really, a
> > topology update on power (not sure on s390x, but those are the only two
> > archs that return a positive value from arch_update_cpu_topology() right
> > now, afaics) is a lot like a hotplug event and we need to re-initialize
> > any dependent structures.
> > 
> > I'm just sending out feelers, as we can limp by with the above warning,
> > it seems, but is less than ideal. Any help or insight you could provide
> > would be greatly appreciated!
> 
> So I think (and ISTR having stated this before) that dynamic cpu<->node
> maps are absolutely insane.

Sorry if I wasn't involved at the time. I agree that it's a bit of a
mess!

> There is a ton of stuff that assumes the cpu<->node relation is a boot
> time fixed one. Userspace being one of them. Per-cpu memory another.

Well, userspace already deals with CPU hotplug, right? And the topology
updates are, in a lot of ways, just like you've hotplugged a CPU from
one node and re-hotplugged it into another node.

I'll look into the per-cpu memory case.

For what it's worth, our test teams are stressing the kernel with these
topology updates and hopefully we'll be able to resolve any issues that
result.

> You simply cannot do this without causing massive borkage.
> 
> So please come up with a coherent plan to deal with the entire problem
> of dynamic cpu to memory relation and I might consider the scheduler
> impact. But we're not going to hack around and maybe make it not crash
> in a few corner cases while the entire thing is shite.

Well, it doesn't crash now. In fact, it stays up reasonable well and
seems to dtrt (from the kernel perspective) other than the sched domain
messages.

I will look into per-cpu memory, and also another case I have been
thinking about where if a process is bound to a CPU/node combination via
numactl and then the topology changes, what exactly will happen. In
theory, via these topology updates, a node could go from memoryless ->
not and v.v., which seems like it might not be well supported (but
again, should not be much different from hotplugging all the memory out
from a node).

And, in fact, I think topologically speaking, I think I should be able
to repeat the same sched domain warnings if I start off with a 2-node
system with all CPUs on one node, and then hotplug a CPU onto the second
node, right? That has nothing to do with power, that I can tell. I'll
see if I can demonstrate it via a KVM guest.

Thanks for your quick response!

-Nish
