Return-Path: <mhocko@kernel.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41wPYS69DwzDqC8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2018 20:54:03 +1000 (AEST)
Date: Wed, 22 Aug 2018 12:53:55 +0200
From: Michal Hocko <mhocko@kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Haren Myneni <haren@linux.vnet.ibm.com>, n-horiguchi@ah.jp.nec.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kamezawa.hiroyu@jp.fujitsu.com, mgorman@suse.de
Subject: Re: Infinite looping observed in __offline_pages
Message-ID: <20180822105355.GI29735@dhcp22.suse.cz>
References: <20180725181115.hmlyd3tmnu3mn3sf@p50.austin.ibm.com>
 <20180725200336.GP28386@dhcp22.suse.cz>
 <87bm9ug34l.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87bm9ug34l.fsf@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed 22-08-18 15:00:18, Aneesh Kumar K.V wrote:
> 
> Hi Michal,
> 
> Michal Hocko <mhocko@kernel.org> writes:
> 
> > On Wed 25-07-18 13:11:15, John Allen wrote:
> > [...]
> >> Does a failure in do_migrate_range indicate that the range is unmigratable
> >> and the loop in __offline_pages should terminate and goto failed_removal? Or
> >> should we allow a certain number of retrys before we
> >> give up on migrating the range?
> >
> > Unfortunatelly not. Migration code doesn't tell a difference between
> > ephemeral and permanent failures. We are relying on
> > start_isolate_page_range to tell us this. So the question is, what kind
> > of page is not migratable and for what reason.
> >
> > Are you able to add some debugging to give us more information. The
> > current debugging code in the hotplug/migration sucks...
> 
> Haren did most of the debugging, so at minimum we need a patch like this
> I guess. 
> 
> modified   mm/page_alloc.c
> @@ -7649,6 +7649,10 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
>  		 * handle each tail page individually in migration.
>  		 */
>  		if (PageHuge(page)) {
> +
> +			if (!IS_ENABLED(CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION))
> +				goto unmovable;
> +
>  			iter = round_up(iter + 1, 1<<compound_order(page)) - 1;
>  			continue;
>  		}
> 
> 
> The problem is start_isolate_range, doesn't look at hugetlbpage and
> return error if the architecture didn't support HUGEPAGE migration. 

Yes this makes sense. I didn't really have arches without huge page
migration in mind.
 
> Now discussing with Naoya, I was suggsting whether we should add a
> similar check in 
> 
> modified   mm/memory_hotplug.c
> @@ -1338,7 +1338,8 @@ static unsigned long scan_movable_pages(unsigned long start, unsigned long end)
>  				return pfn;
>  			if (__PageMovable(page))
>  				return pfn;
> -			if (PageHuge(page)) {
> +			if (IS_ENABLED(CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION) &&
> +			    PageHuge(page)) {
>  				if (page_huge_active(page))
>  					return pfn;
> 
> One of the thinking there is it possible to get new hugetlb pages
> allocated in that range after start_isolate_range ran. But i guess since
> we marked all the free pages as  MIGRATE_ISOLATE that is not possible?

I do not follow. You are usually allocating new pages outside of the
offlined range. But the above change makes sense because it doesn't
really make sense to migrate pfn if it is backed by a non-migrateable
huge page. dissolve_free_huge_pages should then try to remove it
completely and the offlining fails if that is not possible.

> But then it is good to have scan_movable_pages also check for
> HUGEPAGE_MIGRATION?

Good question. It is not necessary right now because has_unmovable_pages
called earlier should take care of it. But I guess it will not hurt to
have it there as well for the clarity.

> 
> Complete patch below.
> 
> commit 2e9d754ac211f2af3731f15df3cd8cd070b4cc54
> Author: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Date:   Tue Aug 21 14:17:55 2018 +0530
> 
>     mm/hugetlb: filter out hugetlb pages if HUGEPAGE migration is not supported.
>     
>     When scanning for movable pages, filter out Hugetlb pages if hugepage migration
>     is not supported. Without this we hit infinte loop in __offline pages where we
>     do
>             pfn = scan_movable_pages(start_pfn, end_pfn);
>             if (pfn) { /* We have movable pages */
>                     ret = do_migrate_range(pfn, end_pfn);
>                     goto repeat;
>             }
>     
>     We do support hugetlb migration ony if the hugetlb pages are at pmd level. Here
>     we just check for Kernel config. The gigantic page size check is done in
>     page_huge_active.

That being said. The patch makes sense to me.

>     
>     Reported-by: Haren Myneni <haren@linux.vnet.ibm.com>
>     CC: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
>     Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

I guess we should mark it for stable even though I am not sure how often
do we see CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=n

Acked-by: Michal Hocko <mhocko@suse.com>

> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 4eb6e824a80c..f9bdea685cf4 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1338,7 +1338,8 @@ static unsigned long scan_movable_pages(unsigned long start, unsigned long end)
>  				return pfn;
>  			if (__PageMovable(page))
>  				return pfn;
> -			if (PageHuge(page)) {
> +			if (IS_ENABLED(CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION) &&
> +			    PageHuge(page)) {
>  				if (page_huge_active(page))
>  					return pfn;
>  				else
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 15ea511fb41c..a3f81e18c882 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7649,6 +7649,10 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
>  		 * handle each tail page individually in migration.
>  		 */
>  		if (PageHuge(page)) {
> +
> +			if (!IS_ENABLED(CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION))
> +				goto unmovable;
> +
>  			iter = round_up(iter + 1, 1<<compound_order(page)) - 1;
>  			continue;
>  		}

-- 
Michal Hocko
SUSE Labs
