Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1F3FA1A0E27
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jan 2016 20:16:21 +1100 (AEDT)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E1741140C49
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Jan 2016 20:16:20 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 29 Jan 2016 19:16:19 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E68AD3578054
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Jan 2016 20:16:17 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0T9G9s666978006
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Jan 2016 20:16:17 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0T9Fj0N003644
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Jan 2016 20:15:45 +1100
Message-ID: <56AB2DB0.7060908@linux.vnet.ibm.com>
Date: Fri, 29 Jan 2016 14:45:28 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/2] powerpc/mm: Enable HugeTLB page migration
References: <1453972285-8822-1-git-send-email-khandual@linux.vnet.ibm.com>
 <87io2dyda8.fsf@linux.vnet.ibm.com>
In-Reply-To: <87io2dyda8.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/28/2016 08:14 PM, Aneesh Kumar K.V wrote:
> Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:
> 
>> This enables HugeTLB page migration for PPC64_BOOK3S systems which implement
>> HugeTLB page at the PMD level. It enables the kernel configuration option
>> CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION by default which turns on the function
>> hugepage_migration_supported() during migration. After the recent changes
>> to the PTE format, HugeTLB page migration happens successfully.
>>
>> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/Kconfig | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index e4824fd..65d52a0 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -82,6 +82,10 @@ config GENERIC_HWEIGHT
>>  config ARCH_HAS_DMA_SET_COHERENT_MASK
>>          bool
>>
>> +config ARCH_ENABLE_HUGEPAGE_MIGRATION
>> +	def_bool y
>> +	depends on PPC_BOOK3S_64 && HUGETLB_PAGE && MIGRATION
>> +
>>  config PPC
>>  	bool
>>  	default y
> 
> 
> Are you sure this is all that is needed ? We will get a FOLL_GET with hugetlb
> migration and our follow_huge_addr will BUG_ON on that. Look at
> e66f17ff71772b209eed39de35aaa99ba819c93d (" mm/hugetlb: take page table
> lock in follow_huge_pmd()").

HugeTLB page migration was successful without any error and data integrity
check passed on them as well. But yes there might be some corner cases which
trigger the race condition we have not faced yet. Will try to understand the
situation there and get back.

> 
> Again this doesn't work with 4K page size. So if you are taking this
> route, we will need that restriction here.
> 

Agreed, I had already put a comment on the thread pointing out the same.
But yes, the restriction needs to be there in the enabling config option
here as well.

> I would suggest we switch 64K page size hugetlb to generic
> hugetlb and then do hugetlb migration on top of that.

Will explore it and get back.

> 
> Till you help me understnd why that FOLL_GET issue is not valid for
> powerpc,

Sure will get back.
