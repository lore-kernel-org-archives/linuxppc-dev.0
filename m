Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzZ5459M6zDqC8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 18:26:16 +1000 (AEST)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 3 May 2016 18:26:15 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 185742CE8059
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 18:26:13 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u438Q5c164684170
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 18:26:13 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u438Pexi030587
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 18:25:40 +1000
Message-ID: <57286072.90209@linux.vnet.ibm.com>
Date: Tue, 03 May 2016 13:55:22 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org
CC: mikey@neuling.org, oohall@gmail.com, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [RFC 1/7] powerpc/mm: Make vmemmap_populate accommodate
 ZONE_DEVICE memory
References: <1462256966-19321-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1462256966-19321-2-git-send-email-khandual@linux.vnet.ibm.com>
 <57285B70.3040905@gmail.com>
In-Reply-To: <57285B70.3040905@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/03/2016 01:34 PM, Balbir Singh wrote:
> 
> 
> On 03/05/16 16:29, Anshuman Khandual wrote:
>> Change the vmemmap_populate function to detect device memory through
>> to_vmemmap_altmap and then call generic the __vmmemap_alloc_block_buf
>> function instead of vmemmap_alloc_block as the earlier can allocate
>> physical memory from the device range instead of the system RAM.
>>
>> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/mm/init_64.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
>> index ba65566..db73708 100644
>> --- a/arch/powerpc/mm/init_64.c
>> +++ b/arch/powerpc/mm/init_64.c
>> @@ -42,6 +42,7 @@
>>  #include <linux/memblock.h>
>>  #include <linux/hugetlb.h>
>>  #include <linux/slab.h>
>> +#include <linux/memremap.h>
>>  
>>  #include <asm/pgalloc.h>
>>  #include <asm/page.h>
>> @@ -312,6 +313,7 @@ static __meminit void vmemmap_list_populate(unsigned long phys,
>>  int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
>>  {
>>  	unsigned long page_size = 1 << mmu_psize_defs[mmu_vmemmap_psize].shift;
>> +	unsigned long orig = start;
> 
> I would much rather do struct vmem_altmap *altmap = to_vmem_altmap(start);

Sure, makes sense.
