Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vycRG3wptzDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 17:09:46 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH V2] powerpc/hugetlb: Add ABI defines for supported HugeTLB
 page sizes
In-Reply-To: <1491375562.28260.33.camel@gmail.com>
References: <f7208305-1aad-bc98-87e3-a8a46404c19e@linux.vnet.ibm.com>
 <20170405051907.18192-1-khandual@linux.vnet.ibm.com>
 <1491375562.28260.33.camel@gmail.com>
Date: Wed, 05 Apr 2017 17:09:43 +1000
Message-ID: <87pogrtjns.fsf@concordia.ellerman.id.au>
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
> On Wed, 2017-04-05 at 10:49 +0530, Anshuman Khandual wrote:
>> diff --git a/arch/powerpc/include/uapi/asm/mman.h b/arch/powerpc/include/uapi/asm/mman.h
>> index 03c06ba..3eb788c 100644
>> --- a/arch/powerpc/include/uapi/asm/mman.h
>> +++ b/arch/powerpc/include/uapi/asm/mman.h
>> @@ -29,4 +29,9 @@
>>  #define MAP_STACK	0x20000		/* give out an address that is best suited for process/thread stacks */
>>  #define MAP_HUGETLB	0x40000		/* create a huge page mapping */
>>  
>> +#define MAP_HUGE_2MB	(21 << MAP_HUGE_SHIFT)	/* 2MB HugeTLB Page */
>> +#define MAP_HUGE_16MB	(24 << MAP_HUGE_SHIFT)	/* 16MB HugeTLB Page */
>> +#define MAP_HUGE_1GB	(30 << MAP_HUGE_SHIFT)	/* 1GB HugeTLB Page */
>> +#define MAP_HUGE_16GB	(34 << MAP_HUGE_SHIFT)	/* 16GB HugeTLB Page */
>> +
>>  #endif /* _UAPI_ASM_POWERPC_MMAN_H */
>
> We may want to call out what MMU supports what size, so that an error can
> be interpreted from the header file comments.

No don't, it can depend on what's configured in Linux and/or hypervisor
config and/or firmware and so on, so any header file comments are most
likely just going to be misleading and/or out of date.

cheers
