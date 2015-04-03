Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9493C1A0A3F
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Apr 2015 04:44:03 +1100 (AEDT)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 3 Apr 2015 11:44:01 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 255801FF0021
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Apr 2015 11:35:10 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t33Hi25D49020992
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Apr 2015 10:44:02 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t33Hhwvl029921
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Apr 2015 11:43:59 -0600
Date: Fri, 3 Apr 2015 10:43:57 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH v2] mm: vmscan: do not throttle based on pfmemalloc
 reserves if node has no reclaimable pages
Message-ID: <20150403174357.GE32318@linux.vnet.ibm.com>
References: <20150327192850.GA18701@linux.vnet.ibm.com>
 <5515BAF7.6070604@intel.com>
 <20150327222350.GA22887@linux.vnet.ibm.com>
 <20150331094829.GE9589@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150331094829.GE9589@dhcp22.suse.cz>
Cc: Rik van Riel <riel@redhat.com>, anton@sambar.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
 Mel Gorman <mgorman@suse.de>, Johannes Weiner <hannes@cmpxchg.org>,
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

On 31.03.2015 [11:48:29 +0200], Michal Hocko wrote:
> On Fri 27-03-15 15:23:50, Nishanth Aravamudan wrote:
> > On 27.03.2015 [13:17:59 -0700], Dave Hansen wrote:
> > > On 03/27/2015 12:28 PM, Nishanth Aravamudan wrote:
> > > > @@ -2585,7 +2585,7 @@ static bool pfmemalloc_watermark_ok(pg_data_t *pgdat)
> > > >  
> > > >         for (i = 0; i <= ZONE_NORMAL; i++) {
> > > >                 zone = &pgdat->node_zones[i];
> > > > -               if (!populated_zone(zone))
> > > > +               if (!populated_zone(zone) || !zone_reclaimable(zone))
> > > >                         continue;
> > > >  
> > > >                 pfmemalloc_reserve += min_wmark_pages(zone);
> > > 
> > > Do you really want zone_reclaimable()?  Or do you want something more
> > > direct like "zone_reclaimable_pages(zone) == 0"?
> > 
> > Yeah, I guess in my testing this worked out to be the same, since
> > zone_reclaimable_pages(zone) is 0 and so zone_reclaimable(zone) will
> > always be false. Thanks!
> > 
> > Based upon 675becce15 ("mm: vmscan: do not throttle based on pfmemalloc
> > reserves if node has no ZONE_NORMAL") from Mel.
> > 
> > We have a system with the following topology:
> > 
> > # numactl -H
> > available: 3 nodes (0,2-3)
> > node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22
> > 23 24 25 26 27 28 29 30 31
> > node 0 size: 28273 MB
> > node 0 free: 27323 MB
> > node 2 cpus:
> > node 2 size: 16384 MB
> > node 2 free: 0 MB
> > node 3 cpus: 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47
> > node 3 size: 30533 MB
> > node 3 free: 13273 MB
> > node distances:
> > node   0   2   3
> >   0:  10  20  20
> >   2:  20  10  20
> >   3:  20  20  10
> > 
> > Node 2 has no free memory, because:
> > # cat /sys/devices/system/node/node2/hugepages/hugepages-16777216kB/nr_hugepages
> > 1
> > 
> > This leads to the following zoneinfo:
> > 
> > Node 2, zone      DMA
> >   pages free     0
> >         min      1840
> >         low      2300
> >         high     2760
> >         scanned  0
> >         spanned  262144
> >         present  262144
> >         managed  262144
> > ...
> >   all_unreclaimable: 1
> 
> Blee, this is a weird configuration.

Yep, super gross. It's relatively rare in the field, thankfully. But 16G
pages definitely make it pretty likely to hit (as in, I've seen it once
before :)
 
> > If one then attempts to allocate some normal 16M hugepages via
> > 
> > echo 37 > /proc/sys/vm/nr_hugepages
> > 
> > The echo never returns and kswapd2 consumes CPU cycles.
> > 
> > This is because throttle_direct_reclaim ends up calling
> > wait_event(pfmemalloc_wait, pfmemalloc_watermark_ok...).
> > pfmemalloc_watermark_ok() in turn checks all zones on the node if there
> > are any reserves, and if so, then indicates the watermarks are ok, by
> > seeing if there are sufficient free pages.
> > 
> > 675becce15 added a condition already for memoryless nodes. In this case,
> > though, the node has memory, it is just all consumed (and not
> > reclaimable). Effectively, though, the result is the same on this call
> > to pfmemalloc_watermark_ok() and thus seems like a reasonable additional
> > condition.
> > 
> > With this change, the afore-mentioned 16M hugepage allocation attempt
> > succeeds and correctly round-robins between Nodes 1 and 3.
> 
> I am just wondering whether this is the right/complete fix. Don't we
> need a similar treatment at more places?

Almost certainly needs an audit. Exhausted nodes are tough to reproduce
easily (fully exhausted, that is), for me.

> I would expect kswapd would be looping endlessly because the zone
> wouldn't be balanced obviously. But I would be wrong... because
> pgdat_balanced is doing this:
> 		/*
> 		 * A special case here:
> 		 *
> 		 * balance_pgdat() skips over all_unreclaimable after
> 		 * DEF_PRIORITY. Effectively, it considers them balanced so
> 		 * they must be considered balanced here as well!
> 		 */
> 		if (!zone_reclaimable(zone)) {
> 			balanced_pages += zone->managed_pages;
> 			continue;
> 		}
> 
> and zone_reclaimable is false for you as you didn't have any
> zone_reclaimable_pages(). But wakeup_kswapd doesn't do this check so it
> would see !zone_balanced() AFAICS (build_zonelists doesn't ignore those
> zones right?) and so the kswapd would be woken up easily. So it looks
> like a mess.

My understanding, and I could easily be wrong, is that kswapd2 (node 2
is the exhausted one) spins endlessly, because the reclaim logic sees
that we are reclaiming from somewhere but the allocation request for
node 2 (which is __GFP_THISNODE for hugepages, not GFP_THISNODE) will
never complete, so we just continue to reclaim.

> There are possibly other places which rely on populated_zone or
> for_each_populated_zone without checking reclaimability. Are those
> working as expected?

Not yet verified, admittedly.

> That being said. I am not objecting to this patch. I am just trying to
> wrap my head around possible issues from such a weird configuration and
> all the consequences.

Yeah, there are almost certainly more. Luckily, our test organization is
hammering this configuration, so hopefully I'll get reports about
further issues soon, if there are any, with the patch applied.

Thanks,
Nish
