Return-Path: <mike.kravetz@oracle.com>
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41wghX5d3ZzDqC8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 07:31:02 +1000 (AEST)
Subject: Re: Infinite looping observed in __offline_pages
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Michal Hocko <mhocko@kernel.org>, Haren Myneni <haren@linux.vnet.ibm.com>
Cc: n-horiguchi@ah.jp.nec.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kamezawa.hiroyu@jp.fujitsu.com,
 mgorman@suse.de
References: <20180725181115.hmlyd3tmnu3mn3sf@p50.austin.ibm.com>
 <20180725200336.GP28386@dhcp22.suse.cz> <87bm9ug34l.fsf@linux.ibm.com>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <54c72a22-a921-fc64-460d-f66985d0df4e@oracle.com>
Date: Wed, 22 Aug 2018 11:58:02 -0700
MIME-Version: 1.0
In-Reply-To: <87bm9ug34l.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/22/2018 02:30 AM, Aneesh Kumar K.V wrote:
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

I thought migration at pgd level was added for POWER?  commit 94310cbcaa3c
(mm/madvise: enable (soft|hard) offline of HugeTLB pages at PGD level).
Only remember, because I did not fully understand the use case. :)

>     we just check for Kernel config. The gigantic page size check is done in
>     page_huge_active.
>     
>     Reported-by: Haren Myneni <haren@linux.vnet.ibm.com>
>     CC: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
>     Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> 
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

How about using hugepage_migration_supported instead?  It would automatically
catch those non-migratable huge page sizes.  Something like:

			if (PageHuge(page) &&
			    hugepage_migration_supported(page_hstate(page))) {

-- 
Mike Kravetz

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
> 
