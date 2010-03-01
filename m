Return-Path: <mel@csn.ul.ie>
Received: from gir.skynet.ie (gir.skynet.ie [193.1.99.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5456DB7D86
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  1 Mar 2010 23:06:54 +1100 (EST)
Date: Mon, 1 Mar 2010 12:06:32 +0000
From: Mel Gorman <mel@csn.ul.ie>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc: Set a smaller value for RECLAIM_DISTANCE to
	enable zone reclaim
Message-ID: <20100301120632.GB3852@csn.ul.ie>
References: <20100218222923.GC31681@kryten> <20100219000730.GD31681@kryten>
	<20100219145523.GN30258@csn.ul.ie> <20100223015551.GG31681@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20100223015551.GG31681@kryten>
Cc: cl@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 23, 2010 at 12:55:51PM +1100, Anton Blanchard wrote:
>  
> Hi Mel,
> 

I'm back but a bit vague. Am on painkillers for the bashing I gave
myself down the hills.

> > You're pretty much on the button here. Only one thread at a time enters
> > zone_reclaim. The others back off and try the next zone in the zonelist
> > instead. I'm not sure what the original intention was but most likely it
> > was to prevent too many parallel reclaimers in the same zone potentially
> > dumping out way more data than necessary.
> > 
> > > I'm not sure if there is an easy way to fix this without penalising other
> > > workloads though.
> > > 
> > 
> > You could experiment with waiting on the bit if the GFP flags allowi it? The
> > expectation would be that the reclaim operation does not take long. Wait
> > on the bit, if you are making the forward progress, recheck the
> > watermarks before continueing.
> 
> Thanks to you and Christoph for some suggestions to try. Attached is a
> chart showing the results of the following tests:
> 
> 
> baseline.txt
> The current ppc64 default of zone_reclaim_mode = 0. As expected we see
> no change in remote node memory usage even after 10 iterations.
> 
> zone_reclaim_mode.txt
> Now we set zone_reclaim_mode = 1. On each iteration we continue to improve,
> but even after 10 runs of stream we have > 10% remote node memory usage.
> 

Ok, so how reasonable would it be to expect that the rate of "improvement"
to be related to the ratio between "available free node memory at start -
how many pages the benchmark requires" and the number of pages zone_reclaim
reclaims on the local node?

The exact rate of improvement is complicated by multiple threads so it
won't be exact.

> reclaim_4096_pages.txt
> Instead of reclaiming 32 pages at a time, we try for a much larger batch
> of 4096. The slope is much steeper but it still takes around 6 iterations
> to get almost all local node memory.
> 
> wait_on_busy_flag.txt
> Here we busy wait if the ZONE_RECLAIM_LOCKED flag is set. As you suggest
> we would need to check the GFP flags etc, but so far it looks the most
> promising. We only get a few percent of remote node memory on the first
> iteration and get all local node by the second.
> 

If the above expectation is reasonable, a better alternative may be to adapt
the number of pages reclaimed to the number of callers to
__zone_reclaim() and allow parallel reclaimers.

e.g. 
	1 thread	 128
	2 threads	  64
	3 threads	  32
	4 threads	  16
etc

The exact starting batch count needs more careful thinking than what I'm
giving it currently and maybe the decay ratio too to work out what the
worst-case scenario for dumping node-local memory is but you get the idea.

The downside is that this requires a per-zone counter to count the
number of parallel reclaimers.

> 
> Perhaps a combination of larger batch size and waiting on the busy
> flag is the way to go?
> 

I think a static increase on the batch size runs three risks. The first of
parallel reclaimers dumping too much of local memory although it could be
mitigated by checking the watermarks after waiting on the bit lock. The
second is that the thread doing the reclaiming is penalised with higher
reclaim costs while other CPUs remain idle. The third is that there
could be latency snags with a thread spinning that would previously have
gone off-node.

Not sure what the impact of the third risk but it might be noticeable on
latency-sensitive machines where the off-node cost is not significant
enough to justify a delay.

Christoph, how feasible would it be to allow parallel reclaimers in
__zone_reclaim() that back off at a rate depending on the number of
reclaimers?

> --- mm/vmscan.c~	2010-02-21 23:47:14.000000000 -0600
> +++ mm/vmscan.c	2010-02-22 03:22:01.000000000 -0600
> @@ -2534,7 +2534,7 @@
>  		.may_unmap = !!(zone_reclaim_mode & RECLAIM_SWAP),
>  		.may_swap = 1,
>  		.nr_to_reclaim = max_t(unsigned long, nr_pages,
> -				       SWAP_CLUSTER_MAX),
> +				       4096),
>  		.gfp_mask = gfp_mask,
>  		.swappiness = vm_swappiness,
>  		.order = order,

> --- mm/vmscan.c~	2010-02-21 23:47:14.000000000 -0600
> +++ mm/vmscan.c	2010-02-21 23:47:31.000000000 -0600
> @@ -2634,8 +2634,8 @@
>  	if (node_state(node_id, N_CPU) && node_id != numa_node_id())
>  		return ZONE_RECLAIM_NOSCAN;
>  
> -	if (zone_test_and_set_flag(zone, ZONE_RECLAIM_LOCKED))
> -		return ZONE_RECLAIM_NOSCAN;
> +	while (zone_test_and_set_flag(zone, ZONE_RECLAIM_LOCKED))
> +		cpu_relax();
>  
>  	ret = __zone_reclaim(zone, gfp_mask, order);
>  	zone_clear_flag(zone, ZONE_RECLAIM_LOCKED);


-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
