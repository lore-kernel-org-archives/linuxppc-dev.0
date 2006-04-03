Return-Path: <sonny@kevlar.burdell.org>
Received: from kevlar.burdell.org (kevlar.burdell.org [66.92.73.214])
	by ozlabs.org (Postfix) with ESMTP id 3E44E67A66
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Apr 2006 18:17:12 +1000 (EST)
Date: Mon, 3 Apr 2006 04:09:50 -0400
From: Sonny Rao <sonny@burdell.org>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: Fw: 2.6.16 crashes when running numastat on p575
Message-ID: <20060403080950.GA2993@kevlar.burdell.org>
References: <20060402213216.2e61b74e.akpm@osdl.org>
	<Pine.LNX.4.64.0604022149450.15895@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0604022149450.15895@schroedinger.engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, ak@suse.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Apr 02, 2006 at 10:12:29PM -0700, Christoph Lameter wrote:
> On Sun, 2 Apr 2006, Andrew Morton wrote:
> 
> > I have a vague feeling that you guys worked on numastat?
> 
> This is mostly Andi's code although I added the zone_pcp() stuff. This is 
> failing because zone_pcp() only returns valid information for online 
> processors.
> 
> Initially all zone_pcps() point to the boot_cpuset (see zone_pcp_init)
> and therefore zone_pcp) is always valid and we do not see this bug. But 
> if someone downs a processor or a processor dies then free_zone_pageset() 
> is called which will set zone_pcp() = NULL.
> 
> 
> Fix NULL pointer dereference in node_read_numastat()
> 
> zone_pcp() only returns valid values if the processor is online.
> 
> Change node_read_numastat() to only scan online processors.
> 
> Signed-off-by: Christoph Lameter <clameter@sgi.com>
> 
> Index: linux-2.6.16/drivers/base/node.c
> ===================================================================
> --- linux-2.6.16.orig/drivers/base/node.c	2006-03-19 21:53:29.000000000 -0800
> +++ linux-2.6.16/drivers/base/node.c	2006-04-02 21:59:49.000000000 -0700
> @@ -106,7 +106,7 @@ static ssize_t node_read_numastat(struct
>  	other_node = 0;
>  	for (i = 0; i < MAX_NR_ZONES; i++) {
>  		struct zone *z = &pg->node_zones[i];
> -		for (cpu = 0; cpu < NR_CPUS; cpu++) {
> +		for_each_online_cpu(cpu) {
>  			struct per_cpu_pageset *ps = zone_pcp(z,cpu);
>  			numa_hit += ps->numa_hit;
>  			numa_miss += ps->numa_miss;


Works, thanks.

Sonny
