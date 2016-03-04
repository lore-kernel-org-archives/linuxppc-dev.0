Return-Path: <vbabka@suse.cz>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C927D1A045D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 19:48:51 +1100 (AEDT)
Subject: Re: [PATCH RFC 1/2] mm: meminit: initialise more memory for
 inode/dentry hash tables in early boot
To: Li Zhang <zhlcindy@gmail.com>, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 mgorman@techsingularity.net
References: <1456988501-29046-1-git-send-email-zhlcindy@gmail.com>
 <1456988501-29046-2-git-send-email-zhlcindy@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Li Zhang <zhlcindy@linux.vnet.ibm.com>
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <56D94BEE.1080506@suse.cz>
Date: Fri, 4 Mar 2016 09:48:46 +0100
MIME-Version: 1.0
In-Reply-To: <1456988501-29046-2-git-send-email-zhlcindy@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/03/2016 08:01 AM, Li Zhang wrote:
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -293,13 +293,20 @@ static inline bool update_defer_init(pg_data_t *pgdat,
>  				unsigned long pfn, unsigned long zone_end,
>  				unsigned long *nr_initialised)
>  {
> +	unsigned long max_initialise;
> +
>  	/* Always populate low zones for address-contrained allocations */
>  	if (zone_end < pgdat_end_pfn(pgdat))
>  		return true;
> +	/*
> +	* Initialise at least 2G of a node but also take into account that
> +	* two large system hashes that can take up 1GB for 0.25TB/node.
> +	*/

The indentation is wrong here.

> +	max_initialise = max(2UL << (30 - PAGE_SHIFT),
> +		(pgdat->node_spanned_pages >> 8));
>  
> -	/* Initialise at least 2G of the highest zone */
>  	(*nr_initialised)++;
> -	if (*nr_initialised > (2UL << (30 - PAGE_SHIFT)) &&
> +	if ((*nr_initialised > max_initialise) &&
>  	    (pfn & (PAGES_PER_SECTION - 1)) == 0) {
>  		pgdat->first_deferred_pfn = pfn;
>  		return false;
> 
