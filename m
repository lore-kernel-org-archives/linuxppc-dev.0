Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0EB151A03CA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 22:57:58 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 27 Nov 2015 21:57:57 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id DB5E1357804F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 22:57:52 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tARBvkAi37552316
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 22:57:54 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tARBvJXd031801
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 22:57:20 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2 07/10] powerpc/mm: update PTE frag size
In-Reply-To: <87egfbgav7.fsf@linux.vnet.ibm.com>
References: <1448274825-30289-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1448274825-30289-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <87egfbgav7.fsf@linux.vnet.ibm.com>
Date: Fri, 27 Nov 2015 17:26:59 +0530
Message-ID: <87a8pzfyes.fsf@linux.vnet.ibm.com>
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

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
>
>> Now that we don't track 4k subpage information we can use 2K PTE
>> fragments.
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/book3s/64/hash-64k.h | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
>> index 5062c6d423fd..a28dbfe2baed 100644
>> --- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
>> +++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
>> @@ -39,14 +39,14 @@
>>   */
>>  #define PTE_RPN_SHIFT	(30)
>>  /*
>> - * we support 8 fragments per PTE page of 64K size.
>> + * we support 32 fragments per PTE page of 64K size.
>>   */
>> -#define PTE_FRAG_NR	8
>> +#define PTE_FRAG_NR	32
>>  /*
>>   * We use a 2K PTE page fragment and another 4K for storing
>>   * real_pte_t hash index. Rounding the entire thing to 8K
>>   */
>> -#define PTE_FRAG_SIZE_SHIFT  13
>> +#define PTE_FRAG_SIZE_SHIFT  11
>>  #define PTE_FRAG_SIZE (1UL << PTE_FRAG_SIZE_SHIFT)
>>
>
>
> This break THP with 4k hpte support because we need to track 4096
> subpage information,  and we have only 2048 bytes after this change.
>
> Another thing I noticed is the impact of not tracking subpage
> information. We do see some significant impact as shown by the mmtest
> results below. The plan now is to go back to 4K pte framgments but
> instead of using 16 bits to track 4k subpage valid bit in pte, we use only 4
> bits as the last patch in this series does ("[PATCH V2 10/10]
> powerpc/mm: Optmize the hashed subpage iteration"). We will track the
> secondary and slot information on the second half. This will result in us using
> hidx value 0x0, wrongly. This actually indicate primary hash with slot
> number zero. But since we are not going to track individual 4k
> subpage information we may using slot 0 wrongly. I checked the existing
> code and we should be able to handle that case gracefuly.

I pushed the changes to 

https://github.com/kvaneesh/linux/commits/book3s-pte-format-v2

This needs full round of testing. I only did a sanity test with
4k hash pte config. Will send an updated series once I finish testing.
Meanwhile if you are interested please take a look

-aneesh
