Return-Path: <dave.hansen@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by lists.ozlabs.org (Postfix) with ESMTP id 6FC821A054F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 07:18:01 +1100 (AEDT)
Message-ID: <5515BAF7.6070604@intel.com>
Date: Fri, 27 Mar 2015 13:17:59 -0700
From: Dave Hansen <dave.hansen@intel.com>
MIME-Version: 1.0
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH] mm: vmscan: do not throttle based on pfmemalloc reserves
 if node has no reclaimable zones
References: <20150327192850.GA18701@linux.vnet.ibm.com>
In-Reply-To: <20150327192850.GA18701@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Cc: Rik van Riel <riel@redhat.com>, anton@sambar.org,
 linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.cz>,
 linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
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

On 03/27/2015 12:28 PM, Nishanth Aravamudan wrote:
> @@ -2585,7 +2585,7 @@ static bool pfmemalloc_watermark_ok(pg_data_t *pgdat)
>  
>         for (i = 0; i <= ZONE_NORMAL; i++) {
>                 zone = &pgdat->node_zones[i];
> -               if (!populated_zone(zone))
> +               if (!populated_zone(zone) || !zone_reclaimable(zone))
>                         continue;
>  
>                 pfmemalloc_reserve += min_wmark_pages(zone);

Do you really want zone_reclaimable()?  Or do you want something more
direct like "zone_reclaimable_pages(zone) == 0"?
