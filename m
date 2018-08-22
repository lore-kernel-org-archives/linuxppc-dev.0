Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41wMj34FfMzDqC8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2018 19:30:30 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7M9Te7F074536
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2018 05:30:28 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2m14ypgm9v-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2018 05:30:27 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 22 Aug 2018 10:30:25 +0100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Michal Hocko <mhocko@kernel.org>, Haren Myneni <haren@linux.vnet.ibm.com>
Cc: n-horiguchi@ah.jp.nec.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kamezawa.hiroyu@jp.fujitsu.com,
 mgorman@suse.de
Subject: Re: Infinite looping observed in __offline_pages
In-Reply-To: <20180725200336.GP28386@dhcp22.suse.cz>
References: <20180725181115.hmlyd3tmnu3mn3sf@p50.austin.ibm.com>
 <20180725200336.GP28386@dhcp22.suse.cz>
Date: Wed, 22 Aug 2018 15:00:18 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87bm9ug34l.fsf@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Michal,

Michal Hocko <mhocko@kernel.org> writes:

> On Wed 25-07-18 13:11:15, John Allen wrote:
> [...]
>> Does a failure in do_migrate_range indicate that the range is unmigratable
>> and the loop in __offline_pages should terminate and goto failed_removal? Or
>> should we allow a certain number of retrys before we
>> give up on migrating the range?
>
> Unfortunatelly not. Migration code doesn't tell a difference between
> ephemeral and permanent failures. We are relying on
> start_isolate_page_range to tell us this. So the question is, what kind
> of page is not migratable and for what reason.
>
> Are you able to add some debugging to give us more information. The
> current debugging code in the hotplug/migration sucks...

Haren did most of the debugging, so at minimum we need a patch like this
I guess. 

modified   mm/page_alloc.c
@@ -7649,6 +7649,10 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
 		 * handle each tail page individually in migration.
 		 */
 		if (PageHuge(page)) {
+
+			if (!IS_ENABLED(CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION))
+				goto unmovable;
+
 			iter = round_up(iter + 1, 1<<compound_order(page)) - 1;
 			continue;
 		}


The problem is start_isolate_range, doesn't look at hugetlbpage and
return error if the architecture didn't support HUGEPAGE migration. 

Now discussing with Naoya, I was suggsting whether we should add a
similar check in 

modified   mm/memory_hotplug.c
@@ -1338,7 +1338,8 @@ static unsigned long scan_movable_pages(unsigned long start, unsigned long end)
 				return pfn;
 			if (__PageMovable(page))
 				return pfn;
-			if (PageHuge(page)) {
+			if (IS_ENABLED(CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION) &&
+			    PageHuge(page)) {
 				if (page_huge_active(page))
 					return pfn;

One of the thinking there is it possible to get new hugetlb pages
allocated in that range after start_isolate_range ran. But i guess since
we marked all the free pages as  MIGRATE_ISOLATE that is not possible?

But then it is good to have scan_movable_pages also check for
HUGEPAGE_MIGRATION?

Complete patch below.

commit 2e9d754ac211f2af3731f15df3cd8cd070b4cc54
Author: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Date:   Tue Aug 21 14:17:55 2018 +0530

    mm/hugetlb: filter out hugetlb pages if HUGEPAGE migration is not supported.
    
    When scanning for movable pages, filter out Hugetlb pages if hugepage migration
    is not supported. Without this we hit infinte loop in __offline pages where we
    do
            pfn = scan_movable_pages(start_pfn, end_pfn);
            if (pfn) { /* We have movable pages */
                    ret = do_migrate_range(pfn, end_pfn);
                    goto repeat;
            }
    
    We do support hugetlb migration ony if the hugetlb pages are at pmd level. Here
    we just check for Kernel config. The gigantic page size check is done in
    page_huge_active.
    
    Reported-by: Haren Myneni <haren@linux.vnet.ibm.com>
    CC: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
    Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 4eb6e824a80c..f9bdea685cf4 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1338,7 +1338,8 @@ static unsigned long scan_movable_pages(unsigned long start, unsigned long end)
 				return pfn;
 			if (__PageMovable(page))
 				return pfn;
-			if (PageHuge(page)) {
+			if (IS_ENABLED(CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION) &&
+			    PageHuge(page)) {
 				if (page_huge_active(page))
 					return pfn;
 				else
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 15ea511fb41c..a3f81e18c882 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7649,6 +7649,10 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
 		 * handle each tail page individually in migration.
 		 */
 		if (PageHuge(page)) {
+
+			if (!IS_ENABLED(CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION))
+				goto unmovable;
+
 			iter = round_up(iter + 1, 1<<compound_order(page)) - 1;
 			continue;
 		}
