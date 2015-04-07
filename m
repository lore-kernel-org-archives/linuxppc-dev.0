Return-Path: <peterz@infradead.org>
Received: from casper.infradead.org (unknown [IPv6:2001:770:15f::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C85B51A056E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Apr 2015 20:22:08 +1000 (AEST)
Date: Tue, 7 Apr 2015 12:21:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: Topology updates and NUMA-level sched domains
Message-ID: <20150407102147.GJ23123@twins.programming.kicks-ass.net>
References: <20150406214558.GA38501@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150406214558.GA38501@linux.vnet.ibm.com>
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

On Mon, Apr 06, 2015 at 02:45:58PM -0700, Nishanth Aravamudan wrote:
> Hi Peter,
> 
> As you are very aware, I think, power has some odd NUMA topologies (and
> changes to the those topologies) at run-time. In particular, we can see
> a topology at boot:
> 
> Node 0: all Cpus
> Node 7: no cpus
> 
> Then we get a notification from the hypervisor that a core (or two) have
> moved from node 0 to node 7. This results in the:

> or a re-init API (which won't try to reallocate various bits), because
> the topology could be completely different now (e.g.,
> sched_domains_numa_distance will also be inaccurate now).  Really, a
> topology update on power (not sure on s390x, but those are the only two
> archs that return a positive value from arch_update_cpu_topology() right
> now, afaics) is a lot like a hotplug event and we need to re-initialize
> any dependent structures.
> 
> I'm just sending out feelers, as we can limp by with the above warning,
> it seems, but is less than ideal. Any help or insight you could provide
> would be greatly appreciated!

So I think (and ISTR having stated this before) that dynamic cpu<->node
maps are absolutely insane.

There is a ton of stuff that assumes the cpu<->node relation is a boot
time fixed one. Userspace being one of them. Per-cpu memory another.

You simply cannot do this without causing massive borkage.

So please come up with a coherent plan to deal with the entire problem
of dynamic cpu to memory relation and I might consider the scheduler
impact. But we're not going to hack around and maybe make it not crash
in a few corner cases while the entire thing is shite.
