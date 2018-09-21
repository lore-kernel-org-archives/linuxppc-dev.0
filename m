Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42GqWX3hb7zF3Q8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 20:26:16 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8LALTFT020242
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 06:26:13 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2mmx7w9mem-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 06:26:13 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Fri, 21 Sep 2018 06:26:12 -0400
Subject: Re: [PATCH V3 1/6] powerpc/mm/book3s: Update pmd_present to look at
 _PAGE_PRESENT bit
To: Christophe LEROY <christophe.leroy@c-s.fr>, npiggin@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
References: <20180920180947.17893-1-aneesh.kumar@linux.ibm.com>
 <71b953af-5063-2440-62aa-9c3a7a738dc6@c-s.fr>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Fri, 21 Sep 2018 15:56:05 +0530
MIME-Version: 1.0
In-Reply-To: <71b953af-5063-2440-62aa-9c3a7a738dc6@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <e64affb4-858b-1424-e850-07442fd45912@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 9/21/18 11:25 AM, Christophe LEROY wrote:
> 
> 
> Le 20/09/2018 à 20:09, Aneesh Kumar K.V a écrit :

>> diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
>> index d71c7777669c..aee04b209b51 100644
>> --- a/arch/powerpc/mm/pgtable.c
>> +++ b/arch/powerpc/mm/pgtable.c
>> @@ -188,11 +188,10 @@ void set_pte_at(struct mm_struct *mm, unsigned 
>> long addr, pte_t *ptep,
>>           pte_t pte)
>>   {
>>       /*
>> -     * When handling numa faults, we already have the pte marked
>> -     * _PAGE_PRESENT, but we can be sure that it is not in hpte.
>> -     * Hence we can use set_pte_at for them.
>> +     * Make sure hardware valid bit is not set. We don't do
>> +     * tlb flush for this update.
>>        */
>> -    VM_WARN_ON(pte_present(*ptep) && !pte_protnone(*ptep));
>> +    VM_WARN_ON(pte_val(*ptep) & _PAGE_PRESENT);
> 
> Why not using pte_present() anymore ?
> 
> Also, you are removing the pte_protnone() check, won't it change the 
> behaviour ?
> 
> If we can't use pte_present(), can we create a new helper for that 
> (allthough _PAGE_PRESENT exists on all platforms).
> 
> Christophe
> 

This patch update a page table clear to clear _PAGE_PRESENT and mark it 
invalid via _PAGE_INVALID. The pte_present now looks at both the flag. 
That is we want these transient clear of pte to be considered as present 
pte even if _PAGE_PRESENT is cleared. What we are catching by the debug 
BUG_ON in these function is we are not using them to set a pte where the 
old entry has a hadware valid bit set. This is because we don't do any 
tlb flush with set_pte_at.


So the reason for pte_present -> pte_val() & _PAGE_PRESENT is because we 
swtiched the clear to clear _PAGE_PRESENT and set _PAGE_INVALID and 
pte_present now check both.

The reason for the removal of pte_protnone is because we dropped that 
set_pte_at usage from core autonuma code long time back.

Now Considering we are calling this from mm/pgtable.c With your approach 
of not using pte flags directly in core code we could switch this to 
pte_hw_valid(). May be we can do that as an addon patch?

-aneesh
