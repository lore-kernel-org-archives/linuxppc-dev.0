Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41wq263189zDrWY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 13:01:49 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7N2x2Pv135188
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2018 23:01:46 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2m1eeeuvnk-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2018 23:01:46 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 22 Aug 2018 21:01:45 -0600
Subject: Re: Infinite looping observed in __offline_pages
To: Mike Kravetz <mike.kravetz@oracle.com>, Michal Hocko <mhocko@kernel.org>,
 Haren Myneni <haren@linux.vnet.ibm.com>
Cc: n-horiguchi@ah.jp.nec.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kamezawa.hiroyu@jp.fujitsu.com,
 mgorman@suse.de
References: <20180725181115.hmlyd3tmnu3mn3sf@p50.austin.ibm.com>
 <20180725200336.GP28386@dhcp22.suse.cz> <87bm9ug34l.fsf@linux.ibm.com>
 <54c72a22-a921-fc64-460d-f66985d0df4e@oracle.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Thu, 23 Aug 2018 08:31:34 +0530
MIME-Version: 1.0
In-Reply-To: <54c72a22-a921-fc64-460d-f66985d0df4e@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <ba980214-5189-cd9e-6775-6f619656a041@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/23/2018 12:28 AM, Mike Kravetz wrote:
> On 08/22/2018 02:30 AM, Aneesh Kumar K.V wrote:
>> commit 2e9d754ac211f2af3731f15df3cd8cd070b4cc54
>> Author: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> Date:   Tue Aug 21 14:17:55 2018 +0530
>>
>>      mm/hugetlb: filter out hugetlb pages if HUGEPAGE migration is not supported.
>>      
>>      When scanning for movable pages, filter out Hugetlb pages if hugepage migration
>>      is not supported. Without this we hit infinte loop in __offline pages where we
>>      do
>>              pfn = scan_movable_pages(start_pfn, end_pfn);
>>              if (pfn) { /* We have movable pages */
>>                      ret = do_migrate_range(pfn, end_pfn);
>>                      goto repeat;
>>              }
>>      
>>      We do support hugetlb migration ony if the hugetlb pages are at pmd level. Here
> 
> I thought migration at pgd level was added for POWER?  commit 94310cbcaa3c
> (mm/madvise: enable (soft|hard) offline of HugeTLB pages at PGD level).
> Only remember, because I did not fully understand the use case. :)
> 

yes. We hit the issue on older distro kernels.

>>      we just check for Kernel config. The gigantic page size check is done in
>>      page_huge_active.
>>      
>>      Reported-by: Haren Myneni <haren@linux.vnet.ibm.com>
>>      CC: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
>>      Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index 4eb6e824a80c..f9bdea685cf4 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -1338,7 +1338,8 @@ static unsigned long scan_movable_pages(unsigned long start, unsigned long end)
>>   				return pfn;
>>   			if (__PageMovable(page))
>>   				return pfn;
>> -			if (PageHuge(page)) {
>> +			if (IS_ENABLED(CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION) &&
>> +			    PageHuge(page)) {
> 
> How about using hugepage_migration_supported instead?  It would automatically
> catch those non-migratable huge page sizes.  Something like:
> 


Will do that.

> 			if (PageHuge(page) &&
> 			    hugepage_migration_supported(page_hstate(page))) {
> 

-aneesh
