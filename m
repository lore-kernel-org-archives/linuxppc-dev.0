Return-Path: <holt@sgi.com>
Received: from relay.sgi.com (relay2.sgi.com [192.48.179.30])
	by ozlabs.org (Postfix) with ESMTP id 17FD3DDDFB
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Jun 2009 22:31:02 +1000 (EST)
Date: Thu, 4 Jun 2009 07:24:09 -0500
From: Robin Holt <holt@sgi.com>
To: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Subject: Re: [PATCH v4] zone_reclaim is always 0 by default
Message-ID: <20090604122409.GK29447@sgi.com>
References: <20090604192236.9761.A69D9226@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090604192236.9761.A69D9226@jp.fujitsu.com>
Cc: Rik van Riel <riel@redhat.com>, linux-ia64@vger.kernel.org,
	linux-mm <linux-mm@kvack.org>, "Zhang, Yanmin" <yanmin.zhang@intel.com>,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Robin Holt <holt@sgi.com>, Christoph Lameter <cl@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Wu Fengguang <fengguang.wu@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Acked-by: Robin Holt <holt@sgi.com>


On Thu, Jun 04, 2009 at 07:23:15PM +0900, KOSAKI Motohiro wrote:
...
> Actually, zone_reclaim_mode=1 mean "I dislike remote node allocation rather than
> disk access", it makes performance improvement to HPC workload.
> but it makes performance degression to desktop, file server and web server.

I still disagree with this statement, but I don't care that much.
Why not something more to the effect of:

Setting zone_reclaim_mode=1 causes memory allocations on a nearly
exhausted node to do direct reclaim within that node before attempting
off-node allocations.  For work loads where most pages are clean in
page cache and easily reclaimed, this can result excessive disk activity
versus a more fair node memory balance.

If you disagree, don't respond, just ignore.

...
> --- a/include/linux/topology.h
> +++ b/include/linux/topology.h
> @@ -54,12 +54,7 @@ int arch_update_cpu_topology(void);
>  #define node_distance(from,to)	((from) == (to) ? LOCAL_DISTANCE : REMOTE_DISTANCE)
>  #endif
>  #ifndef RECLAIM_DISTANCE
> -/*
> - * If the distance between nodes in a system is larger than RECLAIM_DISTANCE
> - * (in whatever arch specific measurement units returned by node_distance())
> - * then switch on zone reclaim on boot.
> - */
> -#define RECLAIM_DISTANCE 20
> +#define RECLAIM_DISTANCE INT_MAX

Why remove this comment?  It seems more-or-less a reasonable statement.

Thanks,
Robin
