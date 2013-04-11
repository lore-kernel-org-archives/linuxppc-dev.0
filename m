Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 53CC12C0090
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 16:36:19 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 11 Apr 2013 12:01:46 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 8B610394002D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 12:06:12 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3B6a8ch7995770
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 12:06:08 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3B6aA06019069
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 16:36:11 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
Subject: Re: [PATCH -V5 13/25] powerpc: Update tlbie/tlbiel as per ISA doc
In-Reply-To: <20130411061630.GG8165@truffula.fritz.box>
References: <1365055083-31956-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1365055083-31956-14-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130411033010.GV8165@truffula.fritz.box>
 <871uahod83.fsf@linux.vnet.ibm.com>
 <20130411061630.GG8165@truffula.fritz.box>
Date: Thu, 11 Apr 2013 12:06:05 +0530
Message-ID: <87vc7tmv56.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David Gibson <dwg@au1.ibm.com> writes:

> On Thu, Apr 11, 2013 at 10:50:12AM +0530, Aneesh Kumar K.V wrote:
>> David Gibson <dwg@au1.ibm.com> writes:
>> 
>> > On Thu, Apr 04, 2013 at 11:27:51AM +0530, Aneesh Kumar K.V wrote:
>> >> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> >> 
>> >> This make sure we handle multiple page size segment correctly.
>> >
>> > This needs a much more detailed message.  In what way was the existing
>> > code not matching the ISA documentation?  What consequences did that
>> > have?
>> 
>> Mostly to make sure we use the right penc values in tlbie. I did test
>> these changes on PowerNV. 
>
> A vague description like this is not adequate.  Your commit message
> needs to explain what was wrong with the existing behaviour.
>
>> >> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> >> ---
>> >>  arch/powerpc/mm/hash_native_64.c |   30 ++++++++++++++++++++++++++++--
>> >>  1 file changed, 28 insertions(+), 2 deletions(-)
>> >> 
>> >> diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
>> >> index b461b2d..ac84fa6 100644
>> >> --- a/arch/powerpc/mm/hash_native_64.c
>> >> +++ b/arch/powerpc/mm/hash_native_64.c
>> >> @@ -61,7 +61,10 @@ static inline void __tlbie(unsigned long vpn, int psize, int apsize, int ssize)
>> >>  
>> >>  	switch (psize) {
>> >>  	case MMU_PAGE_4K:
>> >> +		/* clear out bits after (52) [0....52.....63] */
>> >> +		va &= ~((1ul << (64 - 52)) - 1);
>> >>  		va |= ssize << 8;
>> >> +		va |= mmu_psize_defs[apsize].sllp << 6;
>> >
>> > sllp is the per-segment encoding, so it sure must be looked up via
>> > psize, not apsize.
>> 
>> as per ISA doc, for base page size 4K, RB[56:58] must be set to
>> SLB[L|LP] encoded for the page size corresponding to the actual page
>> size specified by the PTE that was used to create the the TLB entry to
>> be invalidated.
>
> Ok, I see.  Wow, our architecture is even more convoluted than I
> thought.  This could really do with a comment, because this is a very
> surprising aspect of the architecture.
>
>> >
>> >>  		asm volatile(ASM_FTR_IFCLR("tlbie %0,0", PPC_TLBIE(%1,%0), %2)
>> >>  			     : : "r" (va), "r"(0), "i" (CPU_FTR_ARCH_206)
>> >>  			     : "memory");
>> >> @@ -69,9 +72,19 @@ static inline void __tlbie(unsigned long vpn, int psize, int apsize, int ssize)
>> >>  	default:
>> >>  		/* We need 14 to 14 + i bits of va */
>> >>  		penc = mmu_psize_defs[psize].penc[apsize];
>> >> -		va &= ~((1ul << mmu_psize_defs[psize].shift) - 1);
>> >> +		va &= ~((1ul << mmu_psize_defs[apsize].shift) - 1);
>> >>  		va |= penc << 12;
>> >>  		va |= ssize << 8;
>> >> +		/* Add AVAL part */
>> >> +		if (psize != apsize) {
>> >> +			/*
>> >> +			 * MPSS, 64K base page size and 16MB parge page size
>> >> +			 * We don't need all the bits, but this seems to work.
>> >> +			 * vpn cover upto 65 bits of va. (0...65) and we need
>> >> +			 * 58..64 bits of va.
>> >
>> > "seems to work" is not a comment I like to see in core MMU code...
>> >
>> 
>> As per ISA spec, the "other bits" in RB[56:62] must be ignored by the
>> processor. Hence I didn't bother to do zero it out. Since we only
>> support one MPSS combination, we could easily zero out using 0xf0. 
>
> Then update the comment to clearly explain why what you're doing is
> correct, not just say it "seems to work".

Will do.

-aneesh
