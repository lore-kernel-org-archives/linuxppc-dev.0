Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41v3Pr599CzDqp5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 16:12:48 +1000 (AEST)
Subject: Re: [PATCH 3/3] powerpc/mm/ Add proper pte access check helper
From: Christophe LEROY <christophe.leroy@c-s.fr>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
References: <20171204021912.25974-1-aneesh.kumar@linux.vnet.ibm.com>
 <20171204021912.25974-3-aneesh.kumar@linux.vnet.ibm.com>
 <d4c28fbf-5663-b40a-c083-daf9f816fe91@c-s.fr>
Message-ID: <a0769cd0-4dfc-9f15-7dd2-12600989d3e2@c-s.fr>
Date: Mon, 20 Aug 2018 08:12:33 +0200
MIME-Version: 1.0
In-Reply-To: <d4c28fbf-5663-b40a-c083-daf9f816fe91@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 17/08/2018 à 17:12, Christophe LEROY a écrit :
> 
> 
> Le 04/12/2017 à 03:19, Aneesh Kumar K.V a écrit :
>> pte_access_premitted get called in get_user_pages_fast path. If we 
>> have marked
>> the pte PROT_NONE, we should not allow a read access on the address. With
>> the current implementation we are not checking the READ and only check 
>> for
>> WRITE. This is needed on archs like ppc64 that implement PROT_NONE using
>> _PAGE_USER access instead of _PAGE_PRESENT. Also add pte_user check 
>> just to make sure
>> we are not accessing kernel mapping.
>>
>> Even though there is code duplication, keeping the low level pte 
>> accessors
>> different for different platforms helps in code readability.
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/include/asm/book3s/32/pgtable.h | 23 
>> +++++++++++++++++++++++
>>   arch/powerpc/include/asm/nohash/pgtable.h    | 23 
>> +++++++++++++++++++++++
>>   2 files changed, 46 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h 
>> b/arch/powerpc/include/asm/book3s/32/pgtable.h
>> index 016579ef16d3..30a155c0a6b0 100644
>> --- a/arch/powerpc/include/asm/book3s/32/pgtable.h
>> +++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
>> @@ -311,6 +311,29 @@ static inline int pte_present(pte_t pte)
>>       return pte_val(pte) & _PAGE_PRESENT;
>>   }
>> +/*
>> + * We only find page table entry in the last level
>> + * Hence no need for other accessors
>> + */
>> +#define pte_access_permitted pte_access_permitted
>> +static inline bool pte_access_permitted(pte_t pte, bool write)
>> +{
>> +    unsigned long pteval = pte_val(pte);
>> +    /*
>> +     * A read-only access is controlled by _PAGE_USER bit.
>> +     * We have _PAGE_READ set for WRITE and EXECUTE
>> +     */
>> +    unsigned long need_pte_bits = _PAGE_PRESENT | _PAGE_USER;
>> +
>> +    if (write)
>> +        need_pte_bits |= _PAGE_WRITE;
>> +
>> +    if ((pteval & need_pte_bits) != need_pte_bits)
>> +        return false;
>> +
>> +    return true;
>> +}
>> +
>>   /* Conversion functions: convert a page and protection to a page entry,
>>    * and a page entry and page directory to the page they refer to.
>>    *
>> diff --git a/arch/powerpc/include/asm/nohash/pgtable.h 
>> b/arch/powerpc/include/asm/nohash/pgtable.h
>> index 5c68f4a59f75..fc4376c8d444 100644
>> --- a/arch/powerpc/include/asm/nohash/pgtable.h
>> +++ b/arch/powerpc/include/asm/nohash/pgtable.h
>> @@ -45,6 +45,29 @@ static inline int pte_present(pte_t pte)
>>       return pte_val(pte) & _PAGE_PRESENT;
>>   }
>> +/*
>> + * We only find page table entry in the last level
>> + * Hence no need for other accessors
>> + */
>> +#define pte_access_permitted pte_access_permitted
>> +static inline bool pte_access_permitted(pte_t pte, bool write)
>> +{
>> +    unsigned long pteval = pte_val(pte);
>> +    /*
>> +     * A read-only access is controlled by _PAGE_USER bit.
>> +     * We have _PAGE_READ set for WRITE and EXECUTE
>> +     */
> 
> Not fully right. asm/pte-common.h defines:
> 
> #define PAGE_NONE    __pgprot(_PAGE_BASE | _PAGE_NA)
> #define PAGE_SHARED    __pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW)
> #define PAGE_SHARED_X    __pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW | \
>                   _PAGE_EXEC)
> #define PAGE_COPY    __pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RO)
> #define PAGE_COPY_X    __pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RO | \
>                   _PAGE_EXEC)
> #define PAGE_READONLY    __pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RO)
> #define PAGE_READONLY_X    __pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RO | \
>                   _PAGE_EXEC)
> 
> On the 8xx, _PAGE_USER = 0
> 
>> +    unsigned long need_pte_bits = _PAGE_PRESENT | _PAGE_USER;

_PAGE_PRIVILEGED should be checked as well.

Indeed, it seems like our patches crossed each other. My patch for 
adding _PAGE_PRIVILEGED is date January 16th while your's was merged on 
the 17th.

I'm wondering if there are other places that are missing _PAGE_RO 
handling and _PAGE_PRIVILEGED handling. Do you remember if you added any 
recently ?

Christophe

>> +
>> +    if (write)
>> +        need_pte_bits |= _PAGE_WRITE;
>> +
>> +    if ((pteval & need_pte_bits) != need_pte_bits)
>> +        return false;
> 
> This test is not fully correct:
> - To check access(read) permission, you also have to check that _PAGE_NA 
> is not set.
> - To check write permission, you also have to check that neither 
> _PAGE_NA nor _PAGE_RO are set.
> 
> On the 8xx, you have:
> _PAGE_RW = _PAGE_WRITE = 0
> _PAGE_NA = 0x0200
> _PAGE_RO = 0x0600
> 
> Christophe
> 
>> +
>> +    return true;
>> +}
>> +
>>   /* Conversion functions: convert a page and protection to a page entry,
>>    * and a page entry and page directory to the page they refer to.
>>    *
>>
