Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qdwJN3vHzzDq6F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Apr 2016 01:04:52 +1000 (AEST)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 5 Apr 2016 01:04:50 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 6F9172CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Apr 2016 01:04:36 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u34F4SFI65798286
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Apr 2016 01:04:36 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u34F435g009481
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Apr 2016 01:04:04 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 01/65] powerpc/mm: Use big endian page table for book3s 64
In-Reply-To: <56FBB035.8090603@gmail.com>
References: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <56FBB035.8090603@gmail.com>
Date: Mon, 04 Apr 2016 20:33:44 +0530
Message-ID: <87h9fhxvov.fsf@linux.vnet.ibm.com>
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

> [ text/plain ]
>
> On 27/03/16 19:23, Aneesh Kumar K.V wrote:
>> This enables us to share the same page table code for
>> both radix and hash. Radix use a hardware defined big endian
>> page table
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

.....

>> diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
>> index d0ee6fcef823..2113de051824 100644
>> --- a/arch/powerpc/include/asm/book3s/64/hash.h
>> +++ b/arch/powerpc/include/asm/book3s/64/hash.h
>> @@ -250,22 +250,27 @@ static inline unsigned long pte_update(struct mm_struct *mm,
>>  				       int huge)
>>  {
>>  	unsigned long old, tmp;
>> +	unsigned long busy = cpu_to_be64(_PAGE_BUSY);
>> +
>> +	clr = cpu_to_be64(clr);
>> +	set = cpu_to_be64(set);
> so clr and set come in in native endian and the page flags (_PAGE_BUSY, etc) are also native endian?
> I think the changelog should mention this
>
> 1. The bits are stored big endian, but when dealing with them we convert them
> to native endian
> 2. Native endian is for portability across platforms
> 3. pte/pmd/pud/pgd_val() will continue toreturn the value in native endian
>
> You may also want to check/warn about user tools breakage and cc relevant lists. I think the kdump ML
> and any other relevant tools and also check for kvm migration. I think if everything ends up
> native endian (like pte/pmd/pgd/pud_val) we might be good.

Hari is already looking at this.

>
>>  
>>  	__asm__ __volatile__(
>>  	"1:	ldarx	%0,0,%3		# pte_update\n\
>> -	andi.	%1,%0,%6\n\
>> +	and.	%1,%0,%6\n\
>>  	bne-	1b \n\
>>  	andc	%1,%0,%4 \n\
>>  	or	%1,%1,%7\n\
>>  	stdcx.	%1,0,%3 \n\
>>  	bne-	1b"
>>  	: "=&r" (old), "=&r" (tmp), "=m" (*ptep)
>> -	: "r" (ptep), "r" (clr), "m" (*ptep), "i" (_PAGE_BUSY), "r" (set)
>> +	: "r" (ptep), "r" (clr), "m" (*ptep), "r" (busy), "r" (set)
>>  	: "cc" );
>>  	/* huge pages use the old page table lock */
>>  	if (!huge)
>>  		assert_pte_locked(mm, addr);
>>  
>> +	old = be64_to_cpu(old);
>>  	if (old & _PAGE_HASHPTE)
>>  		hpte_need_flush(mm, addr, ptep, old, huge);
>>  
.....

>> +/*
>> + * 64 bit hash always use 4 level table. Everybody else use 4 level
>> + * only for 4K page size.
>> + */
>> +#if defined(CONFIG_PPC_BOOK3S_64) || !defined(CONFIG_PPC_64K_PAGES)
> Doesn't this header get included only if
>
> CONFIG_PPC_BOOK3S_64 is defined, do we need the #if defined for it?

If other platforms want to implement big endian table they can just
include this header. But yes for now this will be included only by
book3s 64.



>
>> +typedef struct { __be64 pud; } pud_t;
>> +#define __pud(x)	((pud_t) { cpu_to_be64(x) })
>> +static inline unsigned long pud_val(pud_t x)
>> +{
>> +	return be64_to_cpu(x.pud);
>> +}
>> +#endif /* CONFIG_PPC_BOOK3S_64 || !CONFIG_PPC_64K_PAGES */
>> +#endif /* CONFIG_PPC64 */
>> +
>> +/* PGD level */
>> +typedef struct { __be64 pgd; } pgd_t;
>> +#define __pgd(x)	((pgd_t) { cpu_to_be64(x) })
>> +static inline unsigned long pgd_val(pgd_t x)
>> +{
>> +	return be64_to_cpu(x.pgd);
>> +}
>> +
>> +/* Page protection bits */
>> +typedef struct { unsigned long pgprot; } pgprot_t;
>> +#define pgprot_val(x)	((x).pgprot)
>> +#define __pgprot(x)	((pgprot_t) { (x) })
>> +

-aneesh
