Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzq7q3Y4xzDqHK
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 16:15:35 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3769jBq027624
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Apr 2017 02:15:32 -0400
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29p3dc5kca-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Apr 2017 02:15:32 -0400
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 7 Apr 2017 11:45:28 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v376FQeK18874536
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Apr 2017 11:45:26 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v376FOeH011910
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Apr 2017 11:45:25 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>,
 Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
 davem@davemloft.net, willy@infradead.org
Subject: Re: [v2 5/5] mm: teach platforms not to zero struct pages memory
In-Reply-To: <20170327060032.GB5092@osiris>
References: <1490383192-981017-1-git-send-email-pasha.tatashin@oracle.com>
 <1490383192-981017-6-git-send-email-pasha.tatashin@oracle.com>
 <20170327060032.GB5092@osiris>
Date: Fri, 07 Apr 2017 11:45:23 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87bms8rbes.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Heiko Carstens <heiko.carstens@de.ibm.com> writes:

> On Fri, Mar 24, 2017 at 03:19:52PM -0400, Pavel Tatashin wrote:
>> If we are using deferred struct page initialization feature, most of
>> "struct page"es are getting initialized after other CPUs are started, and
>> hence we are benefiting from doing this job in parallel. However, we are
>> still zeroing all the memory that is allocated for "struct pages" using the
>> boot CPU.  This patch solves this problem, by deferring zeroing "struct
>> pages" to only when they are initialized.
>> 
>> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
>> Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
>> ---
>>  arch/powerpc/mm/init_64.c |    2 +-
>>  arch/s390/mm/vmem.c       |    2 +-
>>  arch/sparc/mm/init_64.c   |    2 +-
>>  arch/x86/mm/init_64.c     |    2 +-
>>  4 files changed, 4 insertions(+), 4 deletions(-)
>> 
>> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
>> index eb4c270..24faf2d 100644
>> --- a/arch/powerpc/mm/init_64.c
>> +++ b/arch/powerpc/mm/init_64.c
>> @@ -181,7 +181,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
>>  		if (vmemmap_populated(start, page_size))
>>  			continue;
>> 
>> -		p = vmemmap_alloc_block(page_size, node, true);
>> +		p = vmemmap_alloc_block(page_size, node, VMEMMAP_ZERO);
>>  		if (!p)
>>  			return -ENOMEM;
>> 
>> diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
>> index 9c75214..ffe9ba1 100644
>> --- a/arch/s390/mm/vmem.c
>> +++ b/arch/s390/mm/vmem.c
>> @@ -252,7 +252,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
>>  				void *new_page;
>> 
>>  				new_page = vmemmap_alloc_block(PMD_SIZE, node,
>> -							       true);
>> +							       VMEMMAP_ZERO);
>>  				if (!new_page)
>>  					goto out;
>>  				pmd_val(*pm_dir) = __pa(new_page) | sgt_prot;
>
> s390 has two call sites that need to be converted, like you did in one of
> your previous patches. The same seems to be true for powerpc, unless there
> is a reason to not convert them?
>

vmemmap_list_alloc is not really struct page allocation right ? We are
just allocating memory to be used as vmemmmap_backing. But considering
we are updating all the three elements of the sturct, we can avoid that
memset . But instead of VMEMMAP_ZERO we can just pass false in that case
?

-aneesh
