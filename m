Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6dHT5RNGzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 18:15:49 +1000 (AEST)
Subject: Re: [PATCH] powerpc/32: Fix protection of kernel RAM after freeing
 unused memory
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
References: <20170414131126.AA07A67422@localhost.localdomain>
 <87mvbe6wxa.fsf@concordia.ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <4a39282c-2c69-1a09-ef50-b5c8c25d0a02@c-s.fr>
Date: Tue, 18 Apr 2017 10:15:16 +0200
MIME-Version: 1.0
In-Reply-To: <87mvbe6wxa.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 18/04/2017 à 08:40, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>
>
>> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
>> index a65c0b4c0669..d506bd61b629 100644
>> --- a/arch/powerpc/mm/pgtable_32.c
>> +++ b/arch/powerpc/mm/pgtable_32.c
>> @@ -323,6 +323,26 @@ get_pteptr(struct mm_struct *mm, unsigned long addr, pte_t **ptep, pmd_t **pmdp)
>>          return(retval);
>>  }
>>
>> +void remap_init_ram(void)
>> +{
>> +	unsigned long start = (unsigned long)_sinittext & PAGE_MASK;
>> +	unsigned long end = (unsigned long)_einittext;
>> +	unsigned long va;
>> +
>> +	for (va = start; va < end; va += PAGE_SIZE) {
>> +		pte_t *kpte;
>> +		pmd_t *kpmd;
>> +		pte_t pte = pfn_pte(__pa(va) >> PAGE_SHIFT, PAGE_KERNEL);
>> +
>> +		if (!get_pteptr(&init_mm, va, &kpte, &kpmd))
>> +			continue;
>> +		__set_pte_at(&init_mm, va, kpte, pte, 0);
>> +		wmb();
>> +		pte_unmap(kpte);
>> +	}
>> +	flush_tlb_kernel_range(start, end);
>> +}
>
> Can we just use unmap_kernel_range() ?

We only want to remove the X bit.
I think unmap_kernel_range() will unmap the area, wheareas we want to 
keep it as part of the linear data area.

Christophe

>
> Is this sufficient on all 32-bit PPC? (I have no idea)
>
> cheers
>
