Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rG2CF3QLQzDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 07:21:44 +1000 (AEST)
Date: Thu, 26 May 2016 14:21:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Oliver O'Halloran" <oohall@gmail.com>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, Mel Gorman
 <mgorman@techsingularity.net>
Subject: Re: [RFC PATCH] mm/init: fix zone boundary creation
Message-Id: <20160526142142.b16f7f3f18204faf0823ac65@linux-foundation.org>
In-Reply-To: <1462435033-15601-1-git-send-email-oohall@gmail.com>
References: <1462435033-15601-1-git-send-email-oohall@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu,  5 May 2016 17:57:13 +1000 "Oliver O'Halloran" <oohall@gmail.com> wrote:

> As a part of memory initialisation the architecture passes an array to
> free_area_init_nodes() which specifies the max PFN of each memory zone.
> This array is not necessarily monotonic (due to unused zones) so this
> array is parsed to build monotonic lists of the min and max PFN for
> each zone. ZONE_MOVABLE is special cased here as its limits are managed by
> the mm subsystem rather than the architecture. Unfortunately, this special
> casing is broken when ZONE_MOVABLE is the not the last zone in the zone
> list. The core of the issue is:
> 
> 	if (i == ZONE_MOVABLE)
> 		continue;
> 	arch_zone_lowest_possible_pfn[i] =
> 		arch_zone_highest_possible_pfn[i-1];
> 
> As ZONE_MOVABLE is skipped the lowest_possible_pfn of the next zone
> will be set to zero. This patch fixes this bug by adding explicitly
> tracking where the next zone should start rather than relying on the
> contents arch_zone_highest_possible_pfn[].

hm, this is all ten year old Mel code.

What's the priority on this?  What are the user-visible runtime
effects, how many people are affected, etc?


> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5980,15 +5980,18 @@ void __init free_area_init_nodes(unsigned long *max_zone_pfn)
>  				sizeof(arch_zone_lowest_possible_pfn));
>  	memset(arch_zone_highest_possible_pfn, 0,
>  				sizeof(arch_zone_highest_possible_pfn));
> -	arch_zone_lowest_possible_pfn[0] = find_min_pfn_with_active_regions();
> -	arch_zone_highest_possible_pfn[0] = max_zone_pfn[0];
> -	for (i = 1; i < MAX_NR_ZONES; i++) {
> +
> +	start_pfn = find_min_pfn_with_active_regions();
> +
> +	for (i = 0; i < MAX_NR_ZONES; i++) {
>  		if (i == ZONE_MOVABLE)
>  			continue;
> -		arch_zone_lowest_possible_pfn[i] =
> -			arch_zone_highest_possible_pfn[i-1];
> -		arch_zone_highest_possible_pfn[i] =
> -			max(max_zone_pfn[i], arch_zone_lowest_possible_pfn[i]);
> +
> +		end_pfn = max(max_zone_pfn[i], start_pfn);
> +		arch_zone_lowest_possible_pfn[i] = start_pfn;
> +		arch_zone_highest_possible_pfn[i] = end_pfn;
> +
> +		start_pfn = end_pfn;
>  	}
>  	arch_zone_lowest_possible_pfn[ZONE_MOVABLE] = 0;
>  	arch_zone_highest_possible_pfn[ZONE_MOVABLE] = 0;
