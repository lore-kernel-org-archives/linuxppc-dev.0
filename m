Return-Path: <mhocko@kernel.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTPxm1zw0zDr2T
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 22:50:52 +1000 (AEST)
Date: Fri, 11 Aug 2017 14:50:47 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 ard.biesheuvel@linaro.org, will.deacon@arm.com,
 catalin.marinas@arm.com, sam@ravnborg.org
Subject: Re: [v6 08/15] mm: zero struct pages during initialization
Message-ID: <20170811125047.GJ30811@dhcp22.suse.cz>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-9-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1502138329-123460-9-git-send-email-pasha.tatashin@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon 07-08-17 16:38:42, Pavel Tatashin wrote:
> Add struct page zeroing as a part of initialization of other fields in
> __init_single_page().

I believe this deserves much more detailed explanation why this is safe.
What actually prevents any pfn walker from seeing an uninitialized
struct page? Please make your assumptions explicit in the commit log so
that we can check them independently.

Also this is done with some purpose which is the perfmance, right? You
have mentioned that in the cover letter but if somebody is going to read
through git logs this wouldn't be obvious from the specific commit.
So add that information here as well. Especially numbers will be
interesting.

As a sidenote, this will need some more followups for memory hotplug
after my recent changes which are not merged yet but I will take care of
that.

> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
> Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> Reviewed-by: Bob Picco <bob.picco@oracle.com>

After the relevant information is added feel free add
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/mm.h | 9 +++++++++
>  mm/page_alloc.c    | 1 +
>  2 files changed, 10 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 46b9ac5e8569..183ac5e733db 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -93,6 +93,15 @@ extern int mmap_rnd_compat_bits __read_mostly;
>  #define mm_forbids_zeropage(X)	(0)
>  #endif
>  
> +/*
> + * On some architectures it is expensive to call memset() for small sizes.
> + * Those architectures should provide their own implementation of "struct page"
> + * zeroing by defining this macro in <asm/pgtable.h>.
> + */
> +#ifndef mm_zero_struct_page
> +#define mm_zero_struct_page(pp)  ((void)memset((pp), 0, sizeof(struct page)))
> +#endif
> +
>  /*
>   * Default maximum number of active map areas, this limits the number of vmas
>   * per mm struct. Users can overwrite this number by sysctl but there is a
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 983de0a8047b..4d32c1fa4c6c 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1168,6 +1168,7 @@ static void free_one_page(struct zone *zone,
>  static void __meminit __init_single_page(struct page *page, unsigned long pfn,
>  				unsigned long zone, int nid)
>  {
> +	mm_zero_struct_page(page);
>  	set_page_links(page, zone, nid, pfn);
>  	init_page_count(page);
>  	page_mapcount_reset(page);
> -- 
> 2.14.0

-- 
Michal Hocko
SUSE Labs
