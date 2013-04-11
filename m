Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0AAE92C009C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 15:20:34 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 11 Apr 2013 15:15:41 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E64082CE8051
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 15:20:27 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3B5KM2I4129150
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 15:20:22 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3B5KQBA003573
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 15:20:26 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
Subject: Re: [PATCH -V5 13/25] powerpc: Update tlbie/tlbiel as per ISA doc
In-Reply-To: <20130411033010.GV8165@truffula.fritz.box>
References: <1365055083-31956-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1365055083-31956-14-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130411033010.GV8165@truffula.fritz.box>
Date: Thu, 11 Apr 2013 10:50:12 +0530
Message-ID: <871uahod83.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David Gibson <dwg@au1.ibm.com> writes:

> On Thu, Apr 04, 2013 at 11:27:51AM +0530, Aneesh Kumar K.V wrote:
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> 
>> This make sure we handle multiple page size segment correctly.
>
> This needs a much more detailed message.  In what way was the existing
> code not matching the ISA documentation?  What consequences did that
> have?

Mostly to make sure we use the right penc values in tlbie. I did test
these changes on PowerNV. 


>
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/mm/hash_native_64.c |   30 ++++++++++++++++++++++++++++--
>>  1 file changed, 28 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
>> index b461b2d..ac84fa6 100644
>> --- a/arch/powerpc/mm/hash_native_64.c
>> +++ b/arch/powerpc/mm/hash_native_64.c
>> @@ -61,7 +61,10 @@ static inline void __tlbie(unsigned long vpn, int psize, int apsize, int ssize)
>>  
>>  	switch (psize) {
>>  	case MMU_PAGE_4K:
>> +		/* clear out bits after (52) [0....52.....63] */
>> +		va &= ~((1ul << (64 - 52)) - 1);
>>  		va |= ssize << 8;
>> +		va |= mmu_psize_defs[apsize].sllp << 6;
>
> sllp is the per-segment encoding, so it sure must be looked up via
> psize, not apsize.


as per ISA doc, for base page size 4K, RB[56:58] must be set to
SLB[L|LP] encoded for the page size corresponding to the actual page
size specified by the PTE that was used to create the the TLB entry to
be invalidated.


>
>>  		asm volatile(ASM_FTR_IFCLR("tlbie %0,0", PPC_TLBIE(%1,%0), %2)
>>  			     : : "r" (va), "r"(0), "i" (CPU_FTR_ARCH_206)
>>  			     : "memory");
>> @@ -69,9 +72,19 @@ static inline void __tlbie(unsigned long vpn, int psize, int apsize, int ssize)
>>  	default:
>>  		/* We need 14 to 14 + i bits of va */
>>  		penc = mmu_psize_defs[psize].penc[apsize];
>> -		va &= ~((1ul << mmu_psize_defs[psize].shift) - 1);
>> +		va &= ~((1ul << mmu_psize_defs[apsize].shift) - 1);
>>  		va |= penc << 12;
>>  		va |= ssize << 8;
>> +		/* Add AVAL part */
>> +		if (psize != apsize) {
>> +			/*
>> +			 * MPSS, 64K base page size and 16MB parge page size
>> +			 * We don't need all the bits, but this seems to work.
>> +			 * vpn cover upto 65 bits of va. (0...65) and we need
>> +			 * 58..64 bits of va.
>
> "seems to work" is not a comment I like to see in core MMU code...
>

As per ISA spec, the "other bits" in RB[56:62] must be ignored by the
processor. Hence I didn't bother to do zero it out. Since we only
support one MPSS combination, we could easily zero out using 0xf0. 

-aneesh
