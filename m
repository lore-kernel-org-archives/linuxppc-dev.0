Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vCDYL2Vt3zDq93
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 15:58:29 +1100 (AEDT)
Date: Tue, 31 Jan 2017 15:58:16 +1100
From: Anton Blanchard <anton@samba.org>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm: Fix RECLAIM_DISTANCE
Message-ID: <20170131155816.13cf819f@kryten>
In-Reply-To: <20170131043355.GA25724@gwshan>
References: <1485214348-19487-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <20170125035744.GB12855@localhost.localdomain>
 <20170125045822.GA10566@gwshan>
 <20170127124910.GA2668@localhost.localdomain>
 <20170130120240.5018f476@kryten> <20170131043355.GA25724@gwshan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,


> Anton, I think the behaviour looks good. Actually, it's not very
> relevant to the issue addressed by the patch. I will reply to
> Michael's reply about the reason. There are two nodes in your system
> and the memory is expected to be allocated from node-0. If node-0
> doesn't have enough free memory, the allocater switches to node-1. It
> means we need more stress.

Did you try setting zone_reclaim_mode? Surely we should reclaim local
clean pagecache if enabled?

Anton
--

zone_reclaim_mode:

Zone_reclaim_mode allows someone to set more or less aggressive approaches to
reclaim memory when a zone runs out of memory. If it is set to zero then no
zone reclaim occurs. Allocations will be satisfied from other zones / nodes
in the system.

This is value ORed together of

1       = Zone reclaim on
2       = Zone reclaim writes dirty pages out
4       = Zone reclaim swaps pages

zone_reclaim_mode is disabled by default.  For file servers or workloads
that benefit from having their data cached, zone_reclaim_mode should be
left disabled as the caching effect is likely to be more important than
data locality.

zone_reclaim may be enabled if it's known that the workload is partitioned
such that each partition fits within a NUMA node and that accessing remote
memory would cause a measurable performance reduction.  The page allocator
will then reclaim easily reusable pages (those page cache pages that are
currently not used) before allocating off node pages.

Allowing zone reclaim to write out pages stops processes that are
writing large amounts of data from dirtying pages on other nodes. Zone
reclaim will write out dirty pages if a zone fills up and so effectively
throttle the process. This may decrease the performance of a single process
since it cannot use all of system memory to buffer the outgoing writes
anymore but it preserve the memory on other nodes so that the performance
of other processes running on other nodes will not be affected.

Allowing regular swap effectively restricts allocations to the local
node unless explicitly overridden by memory policies or cpuset
configurations.


> 
> In the experiment, 38GB is allocated: 16GB for pagecache and 24GB for
> heap. It's not exceeding the memory capacity (64GB). So page reclaim
> in the fast and slow path weren't triggered. It's why the pagecache
> wasn't dropped. I think __GFP_THISNODE isn't specified when
> page-fault handler tries to allocate page to accomodate the VMA for
> the heap.
> 
> *Without* the patch applied, I got something as below in the system
> where two NUMA nodes and each of them has 64GB memory. Also, I don't
> think the patch is going to change the behaviour:
> 
> # cat /proc/sys/vm/zone_reclaim_mode 
> 0
> 
> Drop pagecache
> Read 8GB file, for pagecache to consume 8GB memory.
> Node 0 FilePages:       8496960 kB
> taskset -c 0 ./alloc 137438953472       <- 128GB sized heap
> Node 0 FilePages:        503424 kB
> 
> Eventually, some of swap clusters have been used as well:
> 
> # free -m
>               total        used        free      shared  buff/cache
> available Mem:         130583      129203         861
> 10         518         297 Swap:         10987        3145        7842
> 
> Thanks,
> Gavin
> 
