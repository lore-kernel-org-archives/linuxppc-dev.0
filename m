Return-Path: <mstsxfx@gmail.com>
Received: from mail-wg0-x22b.google.com (mail-wg0-x22b.google.com
 [IPv6:2a00:1450:400c:c00::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 866301A0ABD
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Apr 2015 05:24:51 +1100 (AEDT)
Received: by wgbdm7 with SMTP id dm7so116999966wgb.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2015 11:24:47 -0700 (PDT)
Sender: Michal Hocko <mstsxfx@gmail.com>
Date: Fri, 3 Apr 2015 20:24:45 +0200
From: Michal Hocko <mhocko@suse.cz>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] mm: vmscan: do not throttle based on pfmemalloc
 reserves if node has no reclaimable pages
Message-ID: <20150403182445.GA31900@dhcp22.suse.cz>
References: <20150327192850.GA18701@linux.vnet.ibm.com>
 <5515BAF7.6070604@intel.com>
 <20150327222350.GA22887@linux.vnet.ibm.com>
 <20150331094829.GE9589@dhcp22.suse.cz>
 <20150403174357.GE32318@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150403174357.GE32318@linux.vnet.ibm.com>
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

On Fri 03-04-15 10:43:57, Nishanth Aravamudan wrote:
> On 31.03.2015 [11:48:29 +0200], Michal Hocko wrote:
[...]
> > I would expect kswapd would be looping endlessly because the zone
> > wouldn't be balanced obviously. But I would be wrong... because
> > pgdat_balanced is doing this:
> > 		/*
> > 		 * A special case here:
> > 		 *
> > 		 * balance_pgdat() skips over all_unreclaimable after
> > 		 * DEF_PRIORITY. Effectively, it considers them balanced so
> > 		 * they must be considered balanced here as well!
> > 		 */
> > 		if (!zone_reclaimable(zone)) {
> > 			balanced_pages += zone->managed_pages;
> > 			continue;
> > 		}
> > 
> > and zone_reclaimable is false for you as you didn't have any
> > zone_reclaimable_pages(). But wakeup_kswapd doesn't do this check so it
> > would see !zone_balanced() AFAICS (build_zonelists doesn't ignore those
> > zones right?) and so the kswapd would be woken up easily. So it looks
> > like a mess.
> 
> My understanding, and I could easily be wrong, is that kswapd2 (node 2
> is the exhausted one) spins endlessly, because the reclaim logic sees
> that we are reclaiming from somewhere but the allocation request for
> node 2 (which is __GFP_THISNODE for hugepages, not GFP_THISNODE) will
> never complete, so we just continue to reclaim.

__GFP_THISNODE would be waking up kswapd2 again and again, that is true.
I am just wondering whether we will have any __GFP_THISNODE allocations
for a node without CPUs (numa_node_id() shouldn't return such a node
AFAICS). Maybe if somebody is bound to Node2 explicitly but I would
consider this as a misconfiguration.

-- 
Michal Hocko
SUSE Labs
