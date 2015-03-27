Return-Path: <ddstreet@gmail.com>
Received: from mail-ie0-x235.google.com (mail-ie0-x235.google.com
 [IPv6:2607:f8b0:4001:c03::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 771BD1A0BEC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 06:58:39 +1100 (AEDT)
Received: by iedm5 with SMTP id m5so79082163ied.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2015 12:58:36 -0700 (PDT)
MIME-Version: 1.0
Sender: ddstreet@gmail.com
In-Reply-To: <20150327192850.GA18701@linux.vnet.ibm.com>
References: <20150327192850.GA18701@linux.vnet.ibm.com>
From: Dan Streetman <ddstreet@ieee.org>
Date: Fri, 27 Mar 2015 15:58:16 -0400
Message-ID: <CALZtONAhqYXemQfUO48JMLvj-Cy1bb3qjqtO=2Xo6kNsafx7Sg@mail.gmail.com>
Subject: Re: [PATCH] mm: vmscan: do not throttle based on pfmemalloc reserves
 if node has no reclaimable zones
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Rik van Riel <riel@redhat.com>, anton@sambar.org,
 linux-kernel <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.cz>,
 Linux-MM <linux-mm@kvack.org>, Mel Gorman <mgorman@suse.de>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 27, 2015 at 3:28 PM, Nishanth Aravamudan
<nacc@linux.vnet.ibm.com> wrote:
> Based upon 675becce15 ("mm: vmscan: do not throttle based on pfmemalloc
> reserves if node has no ZONE_NORMAL") from Mel.
>
> We have a system with the following topology:
>
> (0) root @ br30p03: /root
> # numactl -H
> available: 3 nodes (0,2-3)
> node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22
> 23 24 25 26 27 28 29 30 31
> node 0 size: 28273 MB
> node 0 free: 27323 MB
> node 2 cpus:
> node 2 size: 16384 MB
> node 2 free: 0 MB
> node 3 cpus: 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47
> node 3 size: 30533 MB
> node 3 free: 13273 MB
> node distances:
> node   0   2   3
>   0:  10  20  20
>   2:  20  10  20
>   3:  20  20  10
>
> Node 2 has no free memory, because:
>
> # cat /sys/devices/system/node/node2/hugepages/hugepages-16777216kB/nr_hugepages
> 1
>
> This leads to the following zoneinfo:
>
> Node 2, zone      DMA
>   pages free     0
>         min      1840
>         low      2300
>         high     2760
>         scanned  0
>         spanned  262144
>         present  262144
>         managed  262144
> ...
>   all_unreclaimable: 1
>
> If one then attempts to allocate some normal 16M hugepages:
>
> echo 37 > /proc/sys/vm/nr_hugepages
>
> The echo enver returns and kswapd2 consumes CPU cycles.
>
> This is because throttle_direct_reclaim ends up calling
> wait_event(pfmemalloc_wait, pfmemalloc_watermark_ok...).
> pfmemalloc_watermark_ok() in turn checks all zones on the node and see
> if the there are any reserves, and if so, then indicates the watermarks
> are ok, by seeing if there are sufficient free pages.
>
> 675becce15 added a condition already for memoryless nodes. In this case,
> though, the node has memory, it is just all consumed (and not
> recliamable). Effectively, though, the result is the same on this
> call to pfmemalloc_watermark_ok() and thus seems like a reasonable
> additional condition.
>
> With this change, the afore-mentioned 16M hugepage allocation succeeds
> and correctly round-robins between Nodes 1 and 3.
>
> Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>

Reviewed-by: Dan Streetman <ddstreet@ieee.org>

>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index dcd90c8..033c2b7 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2585,7 +2585,7 @@ static bool pfmemalloc_watermark_ok(pg_data_t *pgdat)
>
>         for (i = 0; i <= ZONE_NORMAL; i++) {
>                 zone = &pgdat->node_zones[i];
> -               if (!populated_zone(zone))
> +               if (!populated_zone(zone) || !zone_reclaimable(zone))
>                         continue;
>
>                 pfmemalloc_reserve += min_wmark_pages(zone);
>
