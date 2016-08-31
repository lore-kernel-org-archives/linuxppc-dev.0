Return-Path: <mstsxfx@gmail.com>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sPN296StKzDrhc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 21:09:37 +1000 (AEST)
Received: by mail-wm0-f65.google.com with SMTP id i5so7087053wmg.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 04:09:37 -0700 (PDT)
Date: Wed, 31 Aug 2016 13:09:33 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linux-MM <linux-mm@kvack.org>, Rik van Riel <riel@surriel.com>,
 Vlastimil Babka <vbabka@suse.cz>, Johannes Weiner <hannes@cmpxchg.org>,
 Minchan Kim <minchan@kernel.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 LKML <linux-kernel@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>
Subject: Re: [PATCH 07/34] mm, vmscan: make kswapd reclaim in terms of nodes
Message-ID: <20160831110932.GB21661@dhcp22.suse.cz>
References: <1467970510-21195-1-git-send-email-mgorman@techsingularity.net>
 <1467970510-21195-8-git-send-email-mgorman@techsingularity.net>
 <20160829093844.GA2592@linux.vnet.ibm.com>
 <20160830120728.GV8119@techsingularity.net>
 <20160830142508.GA10514@linux.vnet.ibm.com>
 <20160830150051.GW8119@techsingularity.net>
 <20160831060959.GA6787@linux.vnet.ibm.com>
 <20160831084942.GX8119@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160831084942.GX8119@techsingularity.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed 31-08-16 09:49:42, Mel Gorman wrote:
> On Wed, Aug 31, 2016 at 11:39:59AM +0530, Srikar Dronamraju wrote:
> > This indeed fixes the problem.
> > Please add my 
> > Tested-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> > 
> 
> Ok, thanks. Unfortunately we cannot do a wide conversion like this
> because some users of populated_zone() really meant to check for
> present_pages. In all cases, the expectation was that reserved pages
> would be tiny but fadump messes that up. Can you verify this also works
> please?
> 
> ---8<---
> mm, vmscan: Only allocate and reclaim from zones with pages managed by the buddy allocator
> 
> Firmware Assisted Dump (FA_DUMP) on ppc64 reserves substantial amounts
> of memory when booting a secondary kernel. Srikar Dronamraju reported that
> multiple nodes may have no memory managed by the buddy allocator but still
> return true for populated_zone().
> 
> Commit 1d82de618ddd ("mm, vmscan: make kswapd reclaim in terms of nodes")
> was reported to cause kswapd to spin at 100% CPU usage when fadump was
> enabled. The old code happened to deal with the situation of a populated
> node with zero free pages by co-incidence but the current code tries to
> reclaim populated zones without realising that is impossible.
> 
> We cannot just convert populated_zone() as many existing users really
> need to check for present_pages. This patch introduces a managed_zone()
> helper and uses it in the few cases where it is critical that the check
> is made for managed pages -- zonelist constuction and page reclaim.

OK, the patch makes sense to me. I am not happy about two very similar
functions, to be honest though. managed vs. present checks will be quite
subtle and it is not entirely clear when to use which one. I agree that
the reclaim path is the most critical one so the patch seems OK to me.
At least from a quick glance it should help with the reported issue so
feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>

I expect we might want to turn other places as well but they are far
from critical. I would appreciate some lead there and stick a clarifying
comment

[...]
> -static inline int populated_zone(struct zone *zone)
> +/* Returns true if a zone has pages managed by the buddy allocator */

/*
 * Returns true if a zone has pages managed by the buddy allocator.
 * All the reclaim decisions have to use this function rather than
 * populated_zone(). If the whole zone is reserved then we can easily
 * end up with populated_zone() && !managed_zone().
 */

What do you think?

> +static inline bool managed_zone(struct zone *zone)
>  {
> -	return (!!zone->present_pages);
> +	return zone->managed_pages;
> +}
> +
> +/* Returns true if a zone has memory */
> +static inline bool populated_zone(struct zone *zone)
> +{
> +	return zone->present_pages;
>  }
-- 
Michal Hocko
SUSE Labs
