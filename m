Return-Path: <mhocko@kernel.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y5yxR50b6zDqmb
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 23:28:27 +1100 (AEDT)
Date: Tue, 3 Oct 2017 14:28:23 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 ard.biesheuvel@linaro.org, mark.rutland@arm.com,
 will.deacon@arm.com, catalin.marinas@arm.com, sam@ravnborg.org,
 mgorman@techsingularity.net, steven.sistare@oracle.com,
 daniel.m.jordan@oracle.com, bob.picco@oracle.com
Subject: Re: [PATCH v9 02/12] sparc64/mm: setting fields in deferred pages
Message-ID: <20171003122823.mdzkhxs4xza7sb2w@dhcp22.suse.cz>
References: <20170920201714.19817-1-pasha.tatashin@oracle.com>
 <20170920201714.19817-3-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170920201714.19817-3-pasha.tatashin@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed 20-09-17 16:17:04, Pavel Tatashin wrote:
> Without deferred struct page feature (CONFIG_DEFERRED_STRUCT_PAGE_INIT),
> flags and other fields in "struct page"es are never changed prior to first
> initializing struct pages by going through __init_single_page().
> 
> With deferred struct page feature enabled there is a case where we set some
> fields prior to initializing:
> 
> mem_init() {
>      register_page_bootmem_info();
>      free_all_bootmem();
>      ...
> }
> 
> When register_page_bootmem_info() is called only non-deferred struct pages
> are initialized. But, this function goes through some reserved pages which
> might be part of the deferred, and thus are not yet initialized.
> 
> mem_init
> register_page_bootmem_info
> register_page_bootmem_info_node
>  get_page_bootmem
>   .. setting fields here ..
>   such as: page->freelist = (void *)type;
> 
> free_all_bootmem()
> free_low_memory_core_early()
>  for_each_reserved_mem_region()
>   reserve_bootmem_region()
>    init_reserved_page() <- Only if this is deferred reserved page
>     __init_single_pfn()
>      __init_single_page()
>       memset(0) <-- Loose the set fields here
> 
> We end-up with similar issue as in the previous patch, where currently we
> do not observe problem as memory is zeroed. But, if flag asserts are
> changed we can start hitting issues.
> 
> Also, because in this patch series we will stop zeroing struct page memory
> during allocation, we must make sure that struct pages are properly
> initialized prior to using them.
> 
> The deferred-reserved pages are initialized in free_all_bootmem().
> Therefore, the fix is to switch the above calls.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
> Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> Reviewed-by: Bob Picco <bob.picco@oracle.com>
> Acked-by: David S. Miller <davem@davemloft.net>

As you separated x86 and sparc patches doing essentially the same I
assume David is going to take this patch?

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  arch/sparc/mm/init_64.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index 6034569e2c0d..310c6754bcaa 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -2548,9 +2548,15 @@ void __init mem_init(void)
>  {
>  	high_memory = __va(last_valid_pfn << PAGE_SHIFT);
>  
> -	register_page_bootmem_info();
>  	free_all_bootmem();
>  
> +	/* Must be done after boot memory is put on freelist, because here we
> +	 * might set fields in deferred struct pages that have not yet been
> +	 * initialized, and free_all_bootmem() initializes all the reserved
> +	 * deferred pages for us.
> +	 */
> +	register_page_bootmem_info();
> +
>  	/*
>  	 * Set up the zero page, mark it reserved, so that page count
>  	 * is not manipulated when freeing the page from user ptes.
> -- 
> 2.14.1

-- 
Michal Hocko
SUSE Labs
