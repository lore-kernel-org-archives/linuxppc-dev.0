Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xsZj651tgzDrK6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 18:34:50 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8D8YFb9060947
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 04:34:47 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cxvpqk2rj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 04:34:47 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 13 Sep 2017 09:34:45 +0100
Subject: Re: [PATCH v3 1/2] powerpc/mm: Export flush_all_mm()
To: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, andrew.donnellan@au1.ibm.com,
 clombard@linux.vnet.ibm.com, vaibhav@linux.vnet.ibm.com
References: <20170903181513.29635-1-fbarrat@linux.vnet.ibm.com>
 <2900303.PDvBtpZXzq@new-mexico>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Wed, 13 Sep 2017 10:34:40 +0200
MIME-Version: 1.0
In-Reply-To: <2900303.PDvBtpZXzq@new-mexico>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <648a876c-e187-423a-c3b9-f3a995afdb7d@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 13/09/2017 à 06:04, Alistair Popple a écrit :
>> +static inline void hash__local_flush_all_mm(struct mm_struct *mm)
>> +{
>> +	/*
>> +	 * There's no Page Walk Cache for hash, so what is needed is
>> +	 * the same as flush_tlb_mm(), which doesn't really make sense
>> +	 * with hash. So the only thing we could do is flush the
>> +	 * entire LPID! Punt for now, as it's not being used.
>> +	 */
> 
> Do you think it is worth putting a WARN_ON_ONCE here if we're asserting this
> isn't used on hash?

I toyed with the idea. The reason I didn't add it was because 
hash__local_flush_tlb_mm() and hash__flush_tlb_mm() don't have one, yet 
it's also not supported. And I had faith in a developer thinking about 
using it would see the comment.
I was actually pretty close to have hash__local_flush_all_mm() call 
directly hash__local_flush_tlb_mm(), since the "all" stands for "pwc and 
tlb" and pwc doesn't exist for hash. But that doesn't do us any good for 
the time being.

Michael: any preference?

Side note: I'm under the impression that flush_tlb_mm() may be called on 
hash, even though it does nothing. kernel/fork.c, dup_mmap() and 
potentially another (through cscope).

   Fred


> Otherwise looks good and is also needed for NPU.
> 
> Reviewed-By: Alistair Popple <alistair@popple.id.au>
> 
>> +}
>> +
>> +static inline void hash__flush_all_mm(struct mm_struct *mm)
>> +{
>> +	/*
>> +	 * There's no Page Walk Cache for hash, so what is needed is
>> +	 * the same as flush_tlb_mm(), which doesn't really make sense
>> +	 * with hash. So the only thing we could do is flush the
>> +	 * entire LPID! Punt for now, as it's not being used.
>> +	 */
>> +}
>> +
>>   static inline void hash__local_flush_tlb_page(struct vm_area_struct *vma,
>>   					  unsigned long vmaddr)
>>   {
>> diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
>> index 9b433a624bf3..af06c6fe8a9f 100644
>> --- a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
>> +++ b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
>> @@ -21,17 +21,20 @@ extern void radix__flush_tlb_range(struct vm_area_struct *vma, unsigned long sta
>>   extern void radix__flush_tlb_kernel_range(unsigned long start, unsigned long end);
>>   
>>   extern void radix__local_flush_tlb_mm(struct mm_struct *mm);
>> +extern void radix__local_flush_all_mm(struct mm_struct *mm);
>>   extern void radix__local_flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
>>   extern void radix__local_flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmaddr,
>>   					      int psize);
>>   extern void radix__tlb_flush(struct mmu_gather *tlb);
>>   #ifdef CONFIG_SMP
>>   extern void radix__flush_tlb_mm(struct mm_struct *mm);
>> +extern void radix__flush_all_mm(struct mm_struct *mm);
>>   extern void radix__flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
>>   extern void radix__flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmaddr,
>>   					int psize);
>>   #else
>>   #define radix__flush_tlb_mm(mm)		radix__local_flush_tlb_mm(mm)
>> +#define radix__flush_all_mm(mm)		radix__local_flush_all_mm(mm)
>>   #define radix__flush_tlb_page(vma,addr)	radix__local_flush_tlb_page(vma,addr)
>>   #define radix__flush_tlb_page_psize(mm,addr,p) radix__local_flush_tlb_page_psize(mm,addr,p)
>>   #endif
>> diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush.h b/arch/powerpc/include/asm/book3s/64/tlbflush.h
>> index 72b925f97bab..70760d018bcd 100644
>> --- a/arch/powerpc/include/asm/book3s/64/tlbflush.h
>> +++ b/arch/powerpc/include/asm/book3s/64/tlbflush.h
>> @@ -57,6 +57,13 @@ static inline void local_flush_tlb_page(struct vm_area_struct *vma,
>>   	return hash__local_flush_tlb_page(vma, vmaddr);
>>   }
>>   
>> +static inline void local_flush_all_mm(struct mm_struct *mm)
>> +{
>> +	if (radix_enabled())
>> +		return radix__local_flush_all_mm(mm);
>> +	return hash__local_flush_all_mm(mm);
>> +}
>> +
>>   static inline void tlb_flush(struct mmu_gather *tlb)
>>   {
>>   	if (radix_enabled())
>> @@ -79,9 +86,17 @@ static inline void flush_tlb_page(struct vm_area_struct *vma,
>>   		return radix__flush_tlb_page(vma, vmaddr);
>>   	return hash__flush_tlb_page(vma, vmaddr);
>>   }
>> +
>> +static inline void flush_all_mm(struct mm_struct *mm)
>> +{
>> +	if (radix_enabled())
>> +		return radix__flush_all_mm(mm);
>> +	return hash__flush_all_mm(mm);
>> +}
>>   #else
>>   #define flush_tlb_mm(mm)		local_flush_tlb_mm(mm)
>>   #define flush_tlb_page(vma, addr)	local_flush_tlb_page(vma, addr)
>> +#define flush_all_mm(mm)		local_flush_all_mm(mm)
>>   #endif /* CONFIG_SMP */
>>   /*
>>    * flush the page walk cache for the address
>> diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
>> index b3e849c4886e..5a1f46eff3a2 100644
>> --- a/arch/powerpc/mm/tlb-radix.c
>> +++ b/arch/powerpc/mm/tlb-radix.c
>> @@ -144,7 +144,7 @@ void radix__local_flush_tlb_mm(struct mm_struct *mm)
>>   EXPORT_SYMBOL(radix__local_flush_tlb_mm);
>>   
>>   #ifndef CONFIG_SMP
>> -static void radix__local_flush_all_mm(struct mm_struct *mm)
>> +void radix__local_flush_all_mm(struct mm_struct *mm)
>>   {
>>   	unsigned long pid;
>>   
>> @@ -154,6 +154,7 @@ static void radix__local_flush_all_mm(struct mm_struct *mm)
>>   		_tlbiel_pid(pid, RIC_FLUSH_ALL);
>>   	preempt_enable();
>>   }
>> +EXPORT_SYMBOL(radix__local_flush_all_mm);
>>   #endif /* CONFIG_SMP */
>>   
>>   void radix__local_flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmaddr,
>> @@ -200,7 +201,7 @@ void radix__flush_tlb_mm(struct mm_struct *mm)
>>   }
>>   EXPORT_SYMBOL(radix__flush_tlb_mm);
>>   
>> -static void radix__flush_all_mm(struct mm_struct *mm)
>> +void radix__flush_all_mm(struct mm_struct *mm)
>>   {
>>   	unsigned long pid;
>>   
>> @@ -216,6 +217,7 @@ static void radix__flush_all_mm(struct mm_struct *mm)
>>   no_context:
>>   	preempt_enable();
>>   }
>> +EXPORT_SYMBOL(radix__flush_all_mm);
>>   
>>   void radix__flush_tlb_pwc(struct mmu_gather *tlb, unsigned long addr)
>>   {
>>
> 
