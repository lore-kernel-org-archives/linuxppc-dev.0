Return-Path: <rashmicy@gmail.com>
Received: from mail-pa0-x235.google.com (mail-pa0-x235.google.com
 [IPv6:2607:f8b0:400e:c03::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BE03C1A060D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2016 15:31:27 +1100 (AEDT)
Received: by mail-pa0-x235.google.com with SMTP id fl4so43357541pad.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 20:31:27 -0800 (PST)
Subject: Re: [PATCH] powerpc/Kconfig: Update config option based on page size.
To: Balbir Singh <bsingharora@gmail.com>
References: <1455846943-32147-1-git-send-email-rashmicy@gmail.com>
 <56C69535.90907@gmail.com>
From: Rashmica <rashmicy@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Message-ID: <56C69A98.3020800@gmail.com>
Date: Fri, 19 Feb 2016 15:31:20 +1100
MIME-Version: 1.0
In-Reply-To: <56C69535.90907@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 19/02/16 15:08, Balbir Singh wrote:
>
> On 19/02/16 12:55, Rashmica Gupta wrote:
>> Currently on PPC64 changing kernel pagesize from 4K to 64K leaves
>> FORCE_MAX_ZONEORDER set to 13 - which produces a compile error.
>>
>> The error occurs because of the following constraint (from
>> include/linux/mmzone.h) being violated:
>>
>> 	MAX_ORDER -1 + PAGESHIFT <= SECTION_SIZE_BITS.
> IA64 has this cool hack
>
>        12 #ifdef CONFIG_FORCE_MAX_ZONEORDER
>        13 #if ((CONFIG_FORCE_MAX_ZONEORDER - 1 + PAGE_SHIFT) > SECTION_SIZE_BITS)
>        14 #undef SECTION_SIZE_BITS
>        15 #define SECTION_SIZE_BITS (CONFIG_FORCE_MAX_ZONEORDER - 1 + PAGE_SHIFT)
>        16 #endif
>
> But coming back (we can revisit the SECTION_SIZE_BITS definition later)
I feel like someone more senior than me should weigh in on if this is 
worth doing...

> MAX_ORDER -1 + 16 <= 24 for 64 K
>
> and
>
> MAX_ORDER -1 + 12 < = 24 for 4K
>
> Your calculations are correct
>> Expanding this out, we get:
>>
>> 	FORCE_MAX_ZONEBITS <= 25 - PAGESHIFT,
>>
>> which requires, for a 64K page, FORCE_MAX_ZONEBITS <= 9. Thus
>> set max value of FORCE_MAX_ZONEORDER for 64K pages to 9.
>>
>> Also, check the minimum value:
>> In include/linux/huge_mm.h, we have the constraint HPAGE_PMD_ORDER <
>> MAX_ORDER which expands out to:
>>
>> 	PTE_INDEX_SIZE < FORCE_MAX_ZONEORDER.
>> PTE_INDEX_SIZE is:
>> 	9 (4k hash or no hash 4K pgtable) or
>> 	8 (64K hash or no hash 64K pgtable).
>> Thus a min value of 9 for 64K pages is reasonable.
> For 4K pages we end up with
>
> 9 < FORCE_MAX_ZONE_ORDER
> FORCE_MAX_ZONE_ORDER -1 + 12 < = 24
>
> The range is 9 to 13
>
> For 64K we end up with
> 8 < FORCE_MAX_ZONE_ORDER
> FORCE_MAX_ZONE_ORDER -1 + 16 <= 24 or FORCE_MAX_ZONE_ORDER <= 9
>
> The range is really between 8 and 9 unless we tweak the SECTION_SIZE_BITS
Yup, you are right! Might have had a brain spaz...
>> So, update the range of FORCE_MAX_ZONEORDER from 9-64 to 9-9.
>>
>> Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
>> ---
>>   arch/powerpc/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index e4824fd04bb7..3bd3465b93ba 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -585,7 +585,7 @@ endchoice
>>   
>>   config FORCE_MAX_ZONEORDER
>>   	int "Maximum zone order"
>> -	range 9 64 if PPC64 && PPC_64K_PAGES
>> +	range 9 9 if PPC64 && PPC_64K_PAGES
> range 8 9?
Agreed.
>>   	default "9" if PPC64 && PPC_64K_PAGES
>>   	range 13 64 if PPC64 && !PPC_64K_PAGES
> Should this be fixed as well?
> range 9 13?
Agreed.
>>   	default "13" if PPC64 && !PPC_64K_PAGES
Should the default values remain as is, or follow the trend and be equal 
to the minimum value?
> Please check my calculations
>
> Reviewed-by: Balbir Singh <bsingharora@gmail.com>
>
> Balbir Singh
