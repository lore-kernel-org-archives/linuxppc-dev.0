Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (unknown [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D4E9A2C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 02:53:34 +1100 (EST)
Date: Mon, 28 Oct 2013 16:53:16 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/3] sched: Aggressive balance in domains whose groups
 share package resources
Message-ID: <20131028155316.GQ19466@laptop.lan>
References: <20131021114002.13291.31478.stgit@drishya>
 <20131021114502.13291.60794.stgit@drishya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131021114502.13291.60794.stgit@drishya>
Cc: Michael Neuling <mikey@neuling.org>, Mike Galbraith <bitbucket@online.de>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Anton Blanchard <anton@samba.org>, Preeti U Murthy <preeti@linux.vnet.ibm.com>,
 Paul Turner <pjt@google.com>, Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 21, 2013 at 05:15:02PM +0530, Vaidyanathan Srinivasan wrote:
> From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> 
> The current logic in load balance is such that after picking the
> busiest group, the load is attempted to be moved from the busiest cpu
> in that group to the dst_cpu. If the load cannot be moved from the
> busiest cpu to dst_cpu due to either tsk_cpus_allowed mask or cache
> hot tasks, then the dst_cpu is changed to be another idle cpu within
> the dst->grpmask. If even then, the load cannot be moved from the
> busiest cpu, then the source group is changed. The next busiest group
> is found and the above steps are repeated.
> 
> However if the cpus in the group share package resources, then when
> a load movement from the busiest cpu in this group fails as above,
> instead of finding the next busiest group to move load from, find the
> next busiest cpu *within the same group* from which to move load away.
> By doing so, a conscious effort is made during load balancing to keep
> just one cpu busy as much as possible within domains that have
> SHARED_PKG_RESOURCES flag set unless under scenarios of high load.
> Having multiple cpus busy within a domain which share package resource
> could lead to a performance hit.
> 
> A similar scenario arises in active load balancing as well. When the
> current task on the busiest cpu cannot be moved away due to task
> pinning, currently no more attempts at load balancing is made.

> This
> patch checks if the balancing is being done on a group whose cpus
> share package resources. If so, then check if the load balancing can
> be done for other cpus in the same group.

So I absolutely hate this patch... Also I'm not convinced I actually
understand the explanation above.

Furthermore; there is nothing special about spreading tasks for
SHARED_PKG_RESOURCES and special casing that one case is just wrong.

If anything it should be keyed off of SD_PREFER_SIBLING and or
cpu_power.
