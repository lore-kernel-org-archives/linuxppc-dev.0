Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D8874B6F98
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Mar 2012 11:04:20 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Wed, 29 Feb 2012 19:04:14 -0500
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 9F7BE6E8057
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Feb 2012 19:03:51 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q2103pud195368
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Feb 2012 19:03:51 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q2103oDf021661
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Feb 2012 21:03:51 -0300
Date: Wed, 29 Feb 2012 16:03:46 -0800
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] bootmem/sparsemem: remove limit constraint in
 alloc_bootmem_section
Message-ID: <20120301000346.GA8375@linux.vnet.ibm.com>
References: <1330112038-18951-1-git-send-email-nacc@us.ibm.com>
 <20120228154732.GE1199@suse.de>
 <20120229181233.GF5136@linux.vnet.ibm.com>
 <20120229152830.22fc72a2.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120229152830.22fc72a2.akpm@linux-foundation.org>
Cc: Anton Blanchard <anton@au1.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
 stable@vger.kernel.org, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
 Mel Gorman <mgorman@suse.de>, Johannes Weiner <hannes@cmpxchg.org>,
 Robert Jennings <rcj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 29.02.2012 [15:28:30 -0800], Andrew Morton wrote:
> On Wed, 29 Feb 2012 10:12:33 -0800
> Nishanth Aravamudan <nacc@linux.vnet.ibm.com> wrote:
> 
> > While testing AMS (Active Memory Sharing) / CMO (Cooperative Memory
> > Overcommit) on powerpc, we tripped the following:
> > 
> > kernel BUG at mm/bootmem.c:483!
> >
> > ...
> > 
> > This is
> > 
> >         BUG_ON(limit && goal + size > limit);
> > 
> > and after some debugging, it seems that
> > 
> > 	goal = 0x7ffff000000
> > 	limit = 0x80000000000
> > 
> > and sparse_early_usemaps_alloc_node ->
> > sparse_early_usemaps_alloc_pgdat_section calls
> > 
> > 	return alloc_bootmem_section(usemap_size() * count, section_nr);
> > 
> > This is on a system with 8TB available via the AMS pool, and as a quirk
> > of AMS in firmware, all of that memory shows up in node 0. So, we end up
> > with an allocation that will fail the goal/limit constraints. In theory,
> > we could "fall-back" to alloc_bootmem_node() in
> > sparse_early_usemaps_alloc_node(), but since we actually have HOTREMOVE
> > defined, we'll BUG_ON() instead. A simple solution appears to be to
> > unconditionally remove the limit condition in alloc_bootmem_section,
> > meaning allocations are allowed to cross section boundaries (necessary
> > for systems of this size).
> > 
> > Johannes Weiner pointed out that if alloc_bootmem_section() no longer
> > guarantees section-locality, we need check_usemap_section_nr() to print
> > possible cross-dependencies between node descriptors and the usemaps
> > allocated through it. That makes the two loops in
> > sparse_early_usemaps_alloc_node() identical, so re-factor the code a
> > bit.
> 
> The patch is a bit scary now, so I think we should merge it into
> 3.4-rc1 and then backport it into 3.3.1 if nothing blows up.

I think that's fair.

> Do you think it should be backported into 3.3.x?  Earlier kernels?

3.3.x seems reasonable. If I had to guess, I think this could be hit on
any kernels with this functionality -- that is, sparsemem in general?
Not sure how far back it's worth backporting.

> Also, this?

Urgh, yeah, that's way better.

Acked-by: Nishanth Aravamudan <nacc@us.ibm.com>

> --- a/mm/bootmem.c~bootmem-sparsemem-remove-limit-constraint-in-alloc_bootmem_section-fix
> +++ a/mm/bootmem.c
> @@ -766,14 +766,13 @@ void * __init alloc_bootmem_section(unsi
>  				    unsigned long section_nr)
>  {
>  	bootmem_data_t *bdata;
> -	unsigned long pfn, goal, limit;
> +	unsigned long pfn, goal;
> 
>  	pfn = section_nr_to_pfn(section_nr);
>  	goal = pfn << PAGE_SHIFT;
> -	limit = 0;
>  	bdata = &bootmem_node_data[early_pfn_to_nid(pfn)];
> 
> -	return alloc_bootmem_core(bdata, size, SMP_CACHE_BYTES, goal, limit);
> +	return alloc_bootmem_core(bdata, size, SMP_CACHE_BYTES, goal, 0);
>  }
>  #endif

Thanks for all the feedback!

-Nish

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
