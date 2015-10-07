Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7266D1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2015 19:46:45 +1100 (AEDT)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 7 Oct 2015 14:16:42 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 34824394006B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2015 14:16:40 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t978kdsW917834
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Oct 2015 14:16:39 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t978kcbT023551
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Oct 2015 14:16:39 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, benh@kernel.crashing.org,
 paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc: Fix _ALIGN_* errors due to type difference.
In-Reply-To: <20151006094843.C8ECF140D71@ozlabs.org>
References: <20151006094843.C8ECF140D71@ozlabs.org>
Date: Wed, 07 Oct 2015 14:16:38 +0530
Message-ID: <87si5n12xd.fsf@linux.vnet.ibm.com>
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

Michael Ellerman <mpe@ellerman.id.au> writes:

> On Fri, 2015-02-10 at 14:33:48 UTC, "Aneesh Kumar K.V" wrote:
>> This avoid errors like
>> 
>>         unsigned int usize = 1 << 30;
>>         int size = 1 << 30;
>>         unsigned long addr = 64UL << 30 ;
>> 
>>         value = _ALIGN_DOWN(addr, usize); -> 0
>>         value = _ALIGN_DOWN(addr, size);  -> 0x1000000000
>
> Are you actually seeing that anywhere? I assume not.

I hit that in new development. So not in the current kernel.


>
>> diff --git a/arch/powerpc/boot/page.h b/arch/powerpc/boot/page.h
>> index 14eca30fef64..87c42d7d283d 100644
>> --- a/arch/powerpc/boot/page.h
>> +++ b/arch/powerpc/boot/page.h
>> @@ -22,8 +22,8 @@
>>  #define PAGE_MASK	(~(PAGE_SIZE-1))
>>  
>>  /* align addr on a size boundary - adjust address up/down if needed */
>> -#define _ALIGN_UP(addr,size)	(((addr)+((size)-1))&(~((size)-1)))
>> -#define _ALIGN_DOWN(addr,size)	((addr)&(~((size)-1)))
>> +#define _ALIGN_UP(addr, size)	(((addr)+((size)-1))&(~((typeof(addr))(size)-1)))
>> +#define _ALIGN_DOWN(addr, size)	((addr)&(~((typeof(addr))(size)-1)))
>>  
>>  /* align addr on a size boundary - adjust address up if needed */
>>  #define _ALIGN(addr,size)     _ALIGN_UP(addr,size)
>> diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
>> index 71294a6e976e..1dd69774a31c 100644
>> --- a/arch/powerpc/include/asm/page.h
>> +++ b/arch/powerpc/include/asm/page.h
>> @@ -240,8 +240,8 @@ extern long long virt_phys_offset;
>>  #endif
>>  
>>  /* align addr on a size boundary - adjust address up/down if needed */
>> -#define _ALIGN_UP(addr,size)	(((addr)+((size)-1))&(~((size)-1)))
>> -#define _ALIGN_DOWN(addr,size)	((addr)&(~((size)-1)))
>> +#define _ALIGN_UP(addr, size)	(((addr)+((size)-1))&(~((typeof(addr))(size)-1)))
>> +#define _ALIGN_DOWN(addr, size)	((addr)&(~((typeof(addr))(size)-1)))
>
>
> It looks like ALIGN() in kernel.h already does this right, so can we just use
> that instead for _ALIGN_UP() at least.
>

But we still can't get rid of _ALIGN_UP, because that is used in other
parts of the kernel and if you are suggesting use

#define _ALIGN_UP __ALIGN_KERNEL, IMHO that is unnecessary indirection
for no real benefit.

-aneesh
