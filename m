Return-Path: <yanok@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 99264DDDF4
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Sep 2008 09:36:09 +1000 (EST)
Message-ID: <48DD71BF.9050204@emcraft.com>
Date: Sat, 27 Sep 2008 03:35:27 +0400
From: Ilya Yanok <yanok@emcraft.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: add support for PAGE_SIZEs greater than 4KB for
References: <1221083587-8091-1-git-send-email-yanok@emcraft.com>
	<1221083587-8091-2-git-send-email-yanok@emcraft.com>
	<20080912034814.GE22288@yookeroo.seuss>
In-Reply-To: <20080912034814.GE22288@yookeroo.seuss>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello David,

David Gibson wrote:
> I don't see any reason to have a separate set of config options for 32
> and 64-bit.  Just make the once choice, but only have the individual
> pagesize options enabled on machines that support them.
>   

Well. I can see some. First, on PPC64 kernel emulates 64K pages on 
hardware that can't do it and we are not going to do such an emulation 
on PPC32 now. Then CONFIG_PPC_64K_PAGES selects PPC_HAS_HASH_64K and our 
code has nothing to do with it. And last but not least, we don't use 
PPC64 kernels for now so we just tried not to break something we can't 
test. But if everybody thinks that having a single option is a good idea 
I'll do it that way.

> I don't think you should need a real_pte_t type for the 32-bit
> implementation.  It's just there because of how we implement
> 64k granularity page allocation on hardware that only does 4k
> translations.
>   

You are right. Thanks.

>> diff --git a/arch/powerpc/include/asm/page_32.h b/arch/powerpc/include/asm/page_32.h
>> index ebfae53..d176270 100644
>> --- a/arch/powerpc/include/asm/page_32.h
>> +++ b/arch/powerpc/include/asm/page_32.h
>> @@ -20,7 +20,11 @@
>>   */
>>  #ifdef CONFIG_PTE_64BIT
>>  typedef unsigned long long pte_basic_t;
>> +#ifdef CONFIG_PPC32_256K_PAGES
>> +#define PTE_SHIFT	(PAGE_SHIFT - 7)
>>     
>
> This doesn't look right.  You should be eliding one of the levels of
> page table if you don't need it, rather than leaving the bottom level
> PTE page largely empty.
>   

Hm... We have only two levels really so if we elide one there will be 
only one left. Don't sure if kernel can work with this...

>> +#if (PAGE_SHIFT == 12)
>> +/*
>> + * PAGE_SIZE  4K
>> + * PAGE_SHIFT 12
>> + * PTE_SHIFT   9
>> + * PMD_SHIFT  21
>> + */
>> +#define PPC44x_TLBE_SIZE	PPC44x_TLB_4K
>> +#define PPC44x_PGD_OFF_SH	13 /*(32 - PMD_SHIFT + 2)*/
>> +#define PPC44x_PGD_OFF_M1	19 /*(PMD_SHIFT - 2)*/
>> +#define PPC44x_PTE_ADD_SH	23 /*32 - PMD_SHIFT + PTE_SHIFT + 3*/
>> +#define PPC44x_PTE_ADD_M1	20 /*32 - 3 - PTE_SHIFT*/
>> +#define PPC44x_RPN_M2		19 /*31 - PAGE_SHIFT*/
>>     
>
> Uh.. you have the formulae for these things right there in the
> comments, so why aren't you using those and avoiding this nasty
> multiway ifdef...
>   

We need to get PMD_SHIFT and friends out of #ifndef __ASSEMBLY__ for 
that. And some of them are under include/asm-generic so patch becomes 
not powerpc-specific...

>> diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
>> index 9665a26..4e7cd1f 100644
>> --- a/arch/powerpc/include/asm/thread_info.h
>> +++ b/arch/powerpc/include/asm/thread_info.h
>> @@ -15,8 +15,12 @@
>>  #ifdef CONFIG_PPC64
>>  #define THREAD_SHIFT		14
>>  #else
>> +#if defined(CONFIG_PPC32_256K_PAGES)
>> +#define THREAD_SHIFT		15
>>     
>
> Hrm.. more peculiar special cases for 256K pages.  I think it might be
> clearer if you split the patch into one which supports page sizes up
> to 64k, then another that does the extra hacks for 256k pages.
>   

Agreed.

>> diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
>> index fce2df9..4f802df 100644
>> --- a/arch/powerpc/kernel/head_booke.h
>> +++ b/arch/powerpc/kernel/head_booke.h
>> @@ -20,7 +20,9 @@
>>  	beq	1f;							     \
>>  	mfspr	r1,SPRN_SPRG3;		/* if from user, start at top of   */\
>>  	lwz	r1,THREAD_INFO-THREAD(r1); /* this thread's kernel stack   */\
>> -	addi	r1,r1,THREAD_SIZE;					     \
>> +	lis	r11,THREAD_SIZE@h;					     \
>> +	ori	r11,r11,THREAD_SIZE@l;					     \
>> +	add	r1,r1,r11;
>> \
>>     
>
> It would be nice if we could avoid the extra instruction here when the
> page sizes isn't big enough to require it.
>   

Ok. This is going to go to 256K-dirty-hacks.patch anyway.

Regards, Ilya.
