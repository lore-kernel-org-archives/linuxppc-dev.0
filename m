Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJ17j51C9zDqGH
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 10:41:21 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v17Nerxb132310
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Feb 2017 18:41:19 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28fj84p0ep-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Feb 2017 18:41:19 -0500
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 8 Feb 2017 09:41:17 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 7BAF02BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 10:41:15 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v17Nf7O735192880
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2017 10:41:15 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v17NehqJ023013
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2017 10:40:43 +1100
Date: Wed, 8 Feb 2017 10:40:18 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org, mgorman@suse.de
Subject: Re: [PATCH] powerpc/mm: Fix RECLAIM_DISTANCE
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1485214348-19487-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <20170125035744.GB12855@localhost.localdomain>
 <20170125045822.GA10566@gwshan>
 <20170127124910.GA2668@localhost.localdomain>
 <20170130120240.5018f476@kryten> <20170130043823.GA30920@gwshan>
 <87zii8uub8.fsf@concordia.ellerman.id.au>
 <20170131050104.GB25724@gwshan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170131050104.GB25724@gwshan>
Message-Id: <20170207234018.GA14393@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 31, 2017 at 04:01:05PM +1100, Gavin Shan wrote:
>On Tue, Jan 31, 2017 at 08:11:39AM +1100, Michael Ellerman wrote:
>>Gavin Shan <gwshan@linux.vnet.ibm.com> writes:
>>
>>I'd like to see some test results from multi-node systems.
>>
>>I'd also like to understand what has changed since we changed
>>RECLAIM_DISTANCE in the first place, ie. why did it used to work and now
>>doesn't?
>>
>
>[Ccing Mel]
>
>Michael, thanks for review. I would like to explain a bit more. The issue
>addressed by the patch is irrelevant to the number of NUMA nodes. There
>is one procfs entry ("/proc/sys/vm/zone_reclaim_mode") which corresponds
>to variable @node_reclaim_mode (their names don't match!). it can have
>belowing bits or any combination of them. Its default value is RECLAIM_OFF (0).
>Note RECLAIM_ZONE was obsoleted and I will send one patch to remove it
>later.
>
>#define RECLAIM_OFF 0
>#define RECLAIM_ZONE (1<<0)     /* Run shrink_inactive_list on the zone */
>#define RECLAIM_WRITE (1<<1)    /* Writeout pages during reclaim */
>#define RECLAIM_UNMAP (1<<2)    /* Unmap pages during reclaim */
>
>When @node_reclaim_mode is set to (RECLAIM_WRITE | RECLAIM_UNMAP), node_reclaim()
>isn't called on the preferred node as the condition is false: zone_allows_reclaim(
>node-A, node-A). As I observed, the distance from node-A to node-A is 10, equal to
>RECLAIM_DISTANCE.
>
>static bool zone_allows_reclaim(struct zone *local_zone, struct zone *zone)
>{
>        return node_distance(zone_to_nid(local_zone), zone_to_nid(zone)) <
>                                RECLAIM_DISTANCE;
>}
>
>
>__alloc_pages_nodemask
>   get_page_from_freelist     <- WATERMARK_LOW
>      zone_watermark_fast     <- Assume the allocation is breaking WATERMARK_LOW
>         node_reclaim         <- @node_reclaim_node isn't 0 and
>                                 zone_allows_reclaim(preferred_zone, current_zone) returns true
>         __node_reclaim       <- SWAP, WRITEPAGE and UNMAP setting from @node_reclaim_node
>         shrink_node
>      buffered_rmqueue
>   __alloc_pages_slowpath
>      get_page_from_freelist        <- WATERMARK_MIN
>      __alloc_pages_direct_compact  <- If it's costly allocation (order > 3)
>      wake_all_kswapds
>      get_page_from_freelist        <- NO_WATERMARK, CPU local node is set to preferred one
>      __alloc_pages_direct_reclaim
>         __perform_reclaim
>         try_to_free_pages          <- WRITEPAGE + UNMAP + SWAP
>         do_try_to_free_pages
>         shrink_zones               <- Stop until priority (12) reaches to 0 or reclaimed enough
>         shrink_node
>      __alloc_pages_direct_compact
>
>
>Also, RECLAIM_DISTANCE is set to 30 in include/linux/topology.h. It's used when arch
>doesn't provide one. It's why I set this macro to 30 in this patch. This issue is 
>introduced by commit 5f7a75acdb2 ("mm: page_alloc: do not cache reclaim distances").
>In the patch, it had wrong replacement. So I would correct the wrong replacement
>alternatively. Or both of them. Which way do you think is the best? Maybe Mel also
>has thoughts.
>
>     39  static bool zone_allows_reclaim(struct zone *local_zone, struct zone *zone)
>     40  {
>     41 -       return node_isset(local_zone->node, zone->zone_pgdat->reclaim_nodes);
>     42 -}
>     43 -
>     44 -static void __paginginit init_zone_allows_reclaim(int nid)
>     45 -{
>     46 -       int i;
>     47 -
>     48 -       for_each_node_state(i, N_MEMORY)
>     49 -               if (node_distance(nid, i) <= RECLAIM_DISTANCE)
>     50 -                       node_set(i, NODE_DATA(nid)->reclaim_nodes);
>     51 +       return node_distance(zone_to_nid(local_zone), zone_to_nid(zone)) <
>     52 +                               RECLAIM_DISTANCE;
>     53  }
>

Michael, I guess Mel might have missed this thread. I will send one patch to linux-mm
to address "<" and "<=" issue. If the replacement was intentional in Mel's patch, the
patch will introduce more discussion there.

On the other hand, I will repost this patch with upated changelog, meaning to set
RECLAIM_DISTANCE to 30. Its value matches with that in include/linux/topology.h.
The value 10 for RECLAIM_DISTANCE should work if "<" is changed to "<=". However,
30 isn't harmful because there is subsequent check to limit reclaiming on CPU's
local node or those who aren't associated with any CPUs.

Thanks,
Gavin
