Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 306641A0610
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2016 15:51:39 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 19 Feb 2016 14:51:37 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id A636B2BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2016 15:51:31 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1J4pNuj721296
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2016 15:51:31 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1J4ow6m019894
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2016 15:50:59 +1100
Message-ID: <56C69F21.4070101@linux.vnet.ibm.com>
Date: Fri, 19 Feb 2016 10:20:41 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
CC: aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [RFC 1/4] powerpc/mm: Rename variable to reflect start address
 of a section
References: <1455711179-20357-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1455806072.5284.17.camel@ellerman.id.au>
In-Reply-To: <1455806072.5284.17.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/18/2016 08:04 PM, Michael Ellerman wrote:
> On Wed, 2016-02-17 at 17:42 +0530, Anshuman Khandual wrote:
> 
>> The commit (16a05bff1: powerpc: start loop at section start of
>> start in vmemmap_populated()) reused 'start' variable to compute
>> the starting address of the memory section where the given address
>> belongs. Then the same variable is used for iterating over starting
>> address of all memory sections before reaching the 'end' address.
>> Renaming it as 'section_start' makes the logic more clear.
>>
>> Fixes: 16a05bff1 ("powerpc: start loop at section start of start in vmemmap_populated()")
> 
> It's not a fix, just a cleanup. Fixes lines should be reserved for actual bug
> fixes.

Sure, got it.

> 
>> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/mm/init_64.c | 12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
>> index 379a6a9..d6b9b4d 100644
>> --- a/arch/powerpc/mm/init_64.c
>> +++ b/arch/powerpc/mm/init_64.c
>> @@ -170,11 +170,15 @@ static unsigned long __meminit vmemmap_section_start(unsigned long page)
>>   */
>>  static int __meminit vmemmap_populated(unsigned long start, int page_size)
>>  {
>> -	unsigned long end = start + page_size;
>> -	start = (unsigned long)(pfn_to_page(vmemmap_section_start(start)));
>> +	unsigned long end, section_start;
>>  
>> -	for (; start < end; start += (PAGES_PER_SECTION * sizeof(struct page)))
>> -		if (pfn_valid(page_to_pfn((struct page *)start)))
>> +	end = start + page_size;
>> +	section_start = (unsigned long)(pfn_to_page
>> +					(vmemmap_section_start(start)));
>> +
>> +	for (; section_start < end; section_start
>> +				+= (PAGES_PER_SECTION * sizeof(struct page)))
>> +		if (pfn_valid(page_to_pfn((struct page *)section_start)))
>>  			return 1;
>>  
>>  	return 0;
> 
> That's not a big improvement.
> 
> But I think this code could be improved. There's a lot of casts, it seems to be
> confused about whether it's iterating over addresses or struct pages.

Right, this patch just tries to clear on such confusion. Thats all.
