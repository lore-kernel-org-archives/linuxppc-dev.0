Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B014D1400D3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Apr 2014 18:02:39 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 21 Apr 2014 13:32:35 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id A96793940058
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Apr 2014 13:32:31 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3L82cgJ7995768
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Apr 2014 13:32:38 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3L82VBq022649
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Apr 2014 13:32:31 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/mm: Fix tlbie to add AVAL fields for 64K pages
In-Reply-To: <1398057937.19682.39.camel@pasglop>
References: <1398056856-17891-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1398057937.19682.39.camel@pasglop>
Date: Mon, 21 Apr 2014 13:32:30 +0530
Message-ID: <87wqejkt49.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Mon, 2014-04-21 at 10:37 +0530, Aneesh Kumar K.V wrote:
>> The if condition check was based on a draft ISA doc. Remove the same.
>
> Is this a real bug ? Do we need to send that back to stable ?

We haven't found any issues without the patch. I found that by code
reading when implementing THP support for powerkvm guest.  Also that if condition
issue is only applicable for 64K base page size. ie, when base page size and
actual page size both are 64K. Now for 64K bits we have bits 58..61
already in AVA field of tlbie instruction. But ISA requires that we have
them also in AVAL field. Since they are duplicate bits may be we are
ok ?

-aneesh

>
> Ben.
>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/mm/hash_native_64.c | 38 ++++++++++++++++----------------------
>>  1 file changed, 16 insertions(+), 22 deletions(-)
>> 
>> diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
>> index 3ea26c25590b..cf1d325eae8b 100644
>> --- a/arch/powerpc/mm/hash_native_64.c
>> +++ b/arch/powerpc/mm/hash_native_64.c
>> @@ -82,17 +82,14 @@ static inline void __tlbie(unsigned long vpn, int psize, int apsize, int ssize)
>>  		va &= ~((1ul << mmu_psize_defs[apsize].shift) - 1);
>>  		va |= penc << 12;
>>  		va |= ssize << 8;
>> -		/* Add AVAL part */
>> -		if (psize != apsize) {
>> -			/*
>> -			 * MPSS, 64K base page size and 16MB parge page size
>> -			 * We don't need all the bits, but rest of the bits
>> -			 * must be ignored by the processor.
>> -			 * vpn cover upto 65 bits of va. (0...65) and we need
>> -			 * 58..64 bits of va.
>> -			 */
>> -			va |= (vpn & 0xfe);
>> -		}
>> +		/*
>> +		 * AVAL bits:
>> +		 * We don't need all the bits, but rest of the bits
>> +		 * must be ignored by the processor.
>> +		 * vpn cover upto 65 bits of va. (0...65) and we need
>> +		 * 58..64 bits of va.
>> +		 */
>> +		va |= (vpn & 0xfe); /* AVAL */
>>  		va |= 1; /* L */
>>  		asm volatile(ASM_FTR_IFCLR("tlbie %0,1", PPC_TLBIE(%1,%0), %2)
>>  			     : : "r" (va), "r"(0), "i" (CPU_FTR_ARCH_206)
>> @@ -133,17 +130,14 @@ static inline void __tlbiel(unsigned long vpn, int psize, int apsize, int ssize)
>>  		va &= ~((1ul << mmu_psize_defs[apsize].shift) - 1);
>>  		va |= penc << 12;
>>  		va |= ssize << 8;
>> -		/* Add AVAL part */
>> -		if (psize != apsize) {
>> -			/*
>> -			 * MPSS, 64K base page size and 16MB parge page size
>> -			 * We don't need all the bits, but rest of the bits
>> -			 * must be ignored by the processor.
>> -			 * vpn cover upto 65 bits of va. (0...65) and we need
>> -			 * 58..64 bits of va.
>> -			 */
>> -			va |= (vpn & 0xfe);
>> -		}
>> +		/*
>> +		 * AVAL bits:
>> +		 * We don't need all the bits, but rest of the bits
>> +		 * must be ignored by the processor.
>> +		 * vpn cover upto 65 bits of va. (0...65) and we need
>> +		 * 58..64 bits of va.
>> +		 */
>> +		va |= (vpn & 0xfe);
>>  		va |= 1; /* L */
>>  		asm volatile(".long 0x7c000224 | (%0 << 11) | (1 << 21)"
>>  			     : : "r"(va) : "memory");
