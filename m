Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 935332C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2012 17:58:58 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 1 Aug 2012 13:28:55 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q717wrpv24510656
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Aug 2012 13:28:53 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q717wqir029191
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Aug 2012 17:58:52 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH -V5 11/13] arch/powerpc: properly isolate kernel and user
 proto-VSID
In-Reply-To: <20120801043147.GA24014@drongo>
References: <1343647339-25576-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1343647339-25576-12-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20120801043147.GA24014@drongo>
Date: Wed, 01 Aug 2012 13:28:47 +0530
Message-ID: <87r4rrhwlk.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> writes:

> On Mon, Jul 30, 2012 at 04:52:17PM +0530, Aneesh Kumar K.V wrote:
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> 
>> The proto-VSID space is divided into two class
>> User:   0 to 2^(CONTEXT_BITS + USER_ESID_BITS) -1
>> kernel: 2^(CONTEXT_BITS + USER_ESID_BITS) to 2^(VSID_BITS) - 1
>> 
>> With KERNEL_START at 0xc000000000000000, the proto vsid for
>> the kernel ends up with 0xc00000000 (36 bits). With 64TB
>> patchset we need to have kernel proto-VSID in the
>> [2^37 to 2^38 - 1] range due to the increased USER_ESID_BITS.
>
> This needs to be rolled in with the previous patch, otherwise you'll
> break bisection.
>
>> diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
>> index db2cb3f..405d380 100644
>> --- a/arch/powerpc/mm/slb_low.S
>> +++ b/arch/powerpc/mm/slb_low.S
>> @@ -57,8 +57,16 @@ _GLOBAL(slb_allocate_realmode)
>>  _GLOBAL(slb_miss_kernel_load_linear)
>>  	li	r11,0
>>  BEGIN_FTR_SECTION
>> +	li	r9,0x1
>> +	rldimi  r10,r9,(CONTEXT_BITS + USER_ESID_BITS),0
>>  	b	slb_finish_load
>>  END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
>> +	li	r9,0x1
>> +	/*
>> +	 * shift 12 bits less here, slb_finish_load_1T will do
>> +	 * the necessary shits
>> +	 */
>> +	rldimi  r10,r9,(CONTEXT_BITS + USER_ESID_BITS),0
>>  	b	slb_finish_load_1T
>
> Since you're actually doing exactly the same instructions in the 256M
> and 1T segment cases, why not do the li; rldimi before the
> BEGIN_FTR_SECTION?
>
>> @@ -86,8 +94,16 @@ _GLOBAL(slb_miss_kernel_load_vmemmap)
>>  	li	r11,0
>>  6:
>>  BEGIN_FTR_SECTION
>> +	li	r9,0x1
>> +	rldimi  r10,r9,(CONTEXT_BITS + USER_ESID_BITS),0
>>  	b	slb_finish_load
>>  END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
>> +	li	r9,0x1
>> +	/*
>> +	 * shift 12 bits less here, slb_finish_load_1T will do
>> +	 * the necessary shits
>> +	 */
>> +	rldimi  r10,r9,(CONTEXT_BITS + USER_ESID_BITS),0
>>  	b	slb_finish_load_1T
>
> And similarly here.
>

Folded to the previous patch and updated

-aneesh
