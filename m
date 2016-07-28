Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s0PhB2WJyzDqh9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 18:11:22 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@ozlabs.org
Cc: haokexin@gmail.com, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH v3 04/21] powerpc/mm: Do radix device tree scanning earlier
In-Reply-To: <4dce619e-1901-4528-9522-02c0a466d130@gmail.com>
References: <1469629097-30859-1-git-send-email-mpe@ellerman.id.au>
 <1469629097-30859-4-git-send-email-mpe@ellerman.id.au>
 <4dce619e-1901-4528-9522-02c0a466d130@gmail.com>
Date: Thu, 28 Jul 2016 18:11:18 +1000
Message-ID: <87vazq18t5.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> writes:

> On 28/07/16 00:18, Michael Ellerman wrote:
>> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
>> index 003ff48a11b6..f34ccdbe0fbd 100644
>> --- a/arch/powerpc/mm/pgtable-radix.c
>> +++ b/arch/powerpc/mm/pgtable-radix.c
>> @@ -343,7 +343,6 @@ void __init radix__early_init_mmu(void)
>>  	__pte_frag_nr = H_PTE_FRAG_NR;
>>  	__pte_frag_size_shift = H_PTE_FRAG_SIZE_SHIFT;
>>  
>> -	radix_init_page_sizes();
>>  	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
>>  		radix_init_native();
>>  		lpcr = mfspr(SPRN_LPCR);
>>
>
> If I am reading this correctly, radix_init_page_sizes() has become
> radix__early_init_devtree() where as hash__early_init_devtree() initializes
> both segment and page sizes? I would still like to keep
>
> mmu_early_init_devtree()
> 	-> radix__early_init_devtree()
> 		-> radix__init_page_sizes()

But then radix__early_init_devtree() would just be:

void radix__early_init_devtree(void)
{
    radix__init_page_sizes();
}

Which seems silly.

I'm doing a new version which splits the htab scanning from the page
init more, as Ben suggested.

cheers
