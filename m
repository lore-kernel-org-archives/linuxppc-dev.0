Return-Path: <SRS0=jJTS=3Y=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA20C2D0B1
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Feb 2020 09:17:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75B212087E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Feb 2020 09:17:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B212087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48BfGd3PKyzDqFF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Feb 2020 20:17:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=osalvador@suse.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.de
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48BfB931mfzDqLH
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Feb 2020 20:13:21 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A8FB2B020;
 Tue,  4 Feb 2020 09:13:15 +0000 (UTC)
Date: Tue, 4 Feb 2020 10:13:12 +0100
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v6 08/10] mm/memory_hotplug: Don't check for "all holes"
 in shrink_zone_span()
Message-ID: <20200204091312.GC6494@linux>
References: <20191006085646.5768-1-david@redhat.com>
 <20191006085646.5768-9-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191006085646.5768-9-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-s390@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
 linux-ia64@vger.kernel.org, Pavel Tatashin <pasha.tatashin@soleen.com>,
 linux-sh@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Wei Yang <richardw.yang@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Oct 06, 2019 at 10:56:44AM +0200, David Hildenbrand wrote:
> If we have holes, the holes will automatically get detected and removed
> once we remove the next bigger/smaller section. The extra checks can
> go.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Wei Yang <richardw.yang@linux.intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Heh, I have been here before.
I have to confess that when I wrote my version of this I was not really 100%
about removing it, because hotplug was a sort of a "catchall" for all sort of weird
and corner-cases configurations, but thinking more about it, I cannot think of
any situation that would make this blow up.

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/memory_hotplug.c | 34 +++++++---------------------------
>  1 file changed, 7 insertions(+), 27 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index f294918f7211..8dafa1ba8d9f 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -393,6 +393,9 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
>  		if (pfn) {
>  			zone->zone_start_pfn = pfn;
>  			zone->spanned_pages = zone_end_pfn - pfn;
> +		} else {
> +			zone->zone_start_pfn = 0;
> +			zone->spanned_pages = 0;
>  		}
>  	} else if (zone_end_pfn == end_pfn) {
>  		/*
> @@ -405,34 +408,11 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
>  					       start_pfn);
>  		if (pfn)
>  			zone->spanned_pages = pfn - zone_start_pfn + 1;
> +		else {
> +			zone->zone_start_pfn = 0;
> +			zone->spanned_pages = 0;
> +		}
>  	}
> -
> -	/*
> -	 * The section is not biggest or smallest mem_section in the zone, it
> -	 * only creates a hole in the zone. So in this case, we need not
> -	 * change the zone. But perhaps, the zone has only hole data. Thus
> -	 * it check the zone has only hole or not.
> -	 */
> -	pfn = zone_start_pfn;
> -	for (; pfn < zone_end_pfn; pfn += PAGES_PER_SUBSECTION) {
> -		if (unlikely(!pfn_to_online_page(pfn)))
> -			continue;
> -
> -		if (page_zone(pfn_to_page(pfn)) != zone)
> -			continue;
> -
> -		/* Skip range to be removed */
> -		if (pfn >= start_pfn && pfn < end_pfn)
> -			continue;
> -
> -		/* If we find valid section, we have nothing to do */
> -		zone_span_writeunlock(zone);
> -		return;
> -	}
> -
> -	/* The zone has no valid section */
> -	zone->zone_start_pfn = 0;
> -	zone->spanned_pages = 0;
>  	zone_span_writeunlock(zone);
>  }
>  
> -- 
> 2.21.0
> 

-- 
Oscar Salvador
SUSE L3
