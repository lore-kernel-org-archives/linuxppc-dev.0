Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A7FF91A025F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 09:23:56 +1100 (AEDT)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 27 Mar 2015 16:23:54 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id E037E19D803F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2015 16:14:58 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2RMM7ob35586108
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2015 15:22:07 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2RMNpTm017211
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2015 16:23:52 -0600
Date: Fri, 27 Mar 2015 15:23:50 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH v2] mm: vmscan: do not throttle based on pfmemalloc reserves
 if node has no reclaimable pages
Message-ID: <20150327222350.GA22887@linux.vnet.ibm.com>
References: <20150327192850.GA18701@linux.vnet.ibm.com>
 <5515BAF7.6070604@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5515BAF7.6070604@intel.com>
Cc: Rik van Riel <riel@redhat.com>, anton@sambar.org,
 linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.cz>,
 linux-mm@kvack.org, Mel Gorman <mgorman@suse.de>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Dan Streetman <ddstreet@ieee.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 27.03.2015 [13:17:59 -0700], Dave Hansen wrote:
> On 03/27/2015 12:28 PM, Nishanth Aravamudan wrote:
> > @@ -2585,7 +2585,7 @@ static bool pfmemalloc_watermark_ok(pg_data_t *pgdat)
> >  
> >         for (i = 0; i <= ZONE_NORMAL; i++) {
> >                 zone = &pgdat->node_zones[i];
> > -               if (!populated_zone(zone))
> > +               if (!populated_zone(zone) || !zone_reclaimable(zone))
> >                         continue;
> >  
> >                 pfmemalloc_reserve += min_wmark_pages(zone);
> 
> Do you really want zone_reclaimable()?  Or do you want something more
> direct like "zone_reclaimable_pages(zone) == 0"?

Yeah, I guess in my testing this worked out to be the same, since
zone_reclaimable_pages(zone) is 0 and so zone_reclaimable(zone) will
always be false. Thanks!

Based upon 675becce15 ("mm: vmscan: do not throttle based on pfmemalloc
reserves if node has no ZONE_NORMAL") from Mel.

We have a system with the following topology:

# numactl -H
available: 3 nodes (0,2-3)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22
23 24 25 26 27 28 29 30 31
node 0 size: 28273 MB
node 0 free: 27323 MB
node 2 cpus:
node 2 size: 16384 MB
node 2 free: 0 MB
node 3 cpus: 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47
node 3 size: 30533 MB
node 3 free: 13273 MB
node distances:
node   0   2   3
  0:  10  20  20
  2:  20  10  20
  3:  20  20  10

Node 2 has no free memory, because:
# cat /sys/devices/system/node/node2/hugepages/hugepages-16777216kB/nr_hugepages
1

This leads to the following zoneinfo:

Node 2, zone      DMA
  pages free     0
        min      1840
        low      2300
        high     2760
        scanned  0
        spanned  262144
        present  262144
        managed  262144
...
  all_unreclaimable: 1

If one then attempts to allocate some normal 16M hugepages via

echo 37 > /proc/sys/vm/nr_hugepages

The echo never returns and kswapd2 consumes CPU cycles.

This is because throttle_direct_reclaim ends up calling
wait_event(pfmemalloc_wait, pfmemalloc_watermark_ok...).
pfmemalloc_watermark_ok() in turn checks all zones on the node if there
are any reserves, and if so, then indicates the watermarks are ok, by
seeing if there are sufficient free pages.

675becce15 added a condition already for memoryless nodes. In this case,
though, the node has memory, it is just all consumed (and not
reclaimable). Effectively, though, the result is the same on this call
to pfmemalloc_watermark_ok() and thus seems like a reasonable additional
condition.

With this change, the afore-mentioned 16M hugepage allocation attempt
succeeds and correctly round-robins between Nodes 1 and 3.

Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>

---
v1 -> v2:
  Check against zone_reclaimable_pages, rather zone_reclaimable, based
  upon feedback from Dave Hansen.

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5e8eadd71bac..c627fa4c991f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2646,7 +2646,8 @@ static bool pfmemalloc_watermark_ok(pg_data_t *pgdat)
 
 	for (i = 0; i <= ZONE_NORMAL; i++) {
 		zone = &pgdat->node_zones[i];
-		if (!populated_zone(zone))
+		if (!populated_zone(zone) ||
+		    zone_reclaimable_pages(zone) == 0)
 			continue;
 
 		pfmemalloc_reserve += min_wmark_pages(zone);
