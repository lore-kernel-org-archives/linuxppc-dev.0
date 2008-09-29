Return-Path: <dgibson@ozlabs.org>
Date: Mon, 29 Sep 2008 12:58:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Ilya Yanok <yanok@emcraft.com>
Subject: Re: [PATCH] powerpc: add support for PAGE_SIZEs greater than 4KB for
Message-ID: <20080929025813.GA8694@yookeroo.seuss>
References: <1221083587-8091-1-git-send-email-yanok@emcraft.com>
	<1221083587-8091-2-git-send-email-yanok@emcraft.com>
	<20080912034814.GE22288@yookeroo.seuss>
	<48DD71BF.9050204@emcraft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48DD71BF.9050204@emcraft.com>
Cc: linuxppc-dev@ozlabs.org, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Sep 27, 2008 at 03:35:27AM +0400, Ilya Yanok wrote:
> Hello David,
>
> David Gibson wrote:
>> I don't see any reason to have a separate set of config options for 32
>> and 64-bit.  Just make the once choice, but only have the individual
>> pagesize options enabled on machines that support them.
>
> Well. I can see some. First, on PPC64 kernel emulates 64K pages on  
> hardware that can't do it and we are not going to do such an emulation  
> on PPC32 now.

So?

> Then CONFIG_PPC_64K_PAGES selects PPC_HAS_HASH_64K and our  
> code has nothing to do with it. 

Well, obviously the generic 64K option wouldn't select
PPC_HAS_HASH_64K.  That would be dependent on both 64K_PAGES and
PPC64.

> And last but not least, we don't use  
> PPC64 kernels for now so we just tried not to break something we can't  
> test. But if everybody thinks that having a single option is a good idea  
> I'll do it that way.

Hrm, well that has something to be said for it.  But it's not hard to
at least build a ppc64 kernel to test if you've broken that.

>> I don't think you should need a real_pte_t type for the 32-bit
>> implementation.  It's just there because of how we implement
>> 64k granularity page allocation on hardware that only does 4k
>> translations.
>
> You are right. Thanks.
>
>>> diff --git a/arch/powerpc/include/asm/page_32.h b/arch/powerpc/include/asm/page_32.h
>>> index ebfae53..d176270 100644
>>> --- a/arch/powerpc/include/asm/page_32.h
>>> +++ b/arch/powerpc/include/asm/page_32.h
>>> @@ -20,7 +20,11 @@
>>>   */
>>>  #ifdef CONFIG_PTE_64BIT
>>>  typedef unsigned long long pte_basic_t;
>>> +#ifdef CONFIG_PPC32_256K_PAGES
>>> +#define PTE_SHIFT	(PAGE_SHIFT - 7)
>>>     
>>
>> This doesn't look right.  You should be eliding one of the levels of
>> page table if you don't need it, rather than leaving the bottom level
>> PTE page largely empty.
>
> Hm... We have only two levels really so if we elide one there will be  
> only one left. Don't sure if kernel can work with this...

Ah.. that's a point.  But again this is a 256K specific hack, so we
can worry about it later.

>>> +#if (PAGE_SHIFT == 12)
>>> +/*
>>> + * PAGE_SIZE  4K
>>> + * PAGE_SHIFT 12
>>> + * PTE_SHIFT   9
>>> + * PMD_SHIFT  21
>>> + */
>>> +#define PPC44x_TLBE_SIZE	PPC44x_TLB_4K
>>> +#define PPC44x_PGD_OFF_SH	13 /*(32 - PMD_SHIFT + 2)*/
>>> +#define PPC44x_PGD_OFF_M1	19 /*(PMD_SHIFT - 2)*/
>>> +#define PPC44x_PTE_ADD_SH	23 /*32 - PMD_SHIFT + PTE_SHIFT + 3*/
>>> +#define PPC44x_PTE_ADD_M1	20 /*32 - 3 - PTE_SHIFT*/
>>> +#define PPC44x_RPN_M2		19 /*31 - PAGE_SHIFT*/
>>>     
>>
>> Uh.. you have the formulae for these things right there in the
>> comments, so why aren't you using those and avoiding this nasty
>> multiway ifdef...
>
> We need to get PMD_SHIFT and friends out of #ifndef __ASSEMBLY__ for  
> that. And some of them are under include/asm-generic so patch becomes  
> not powerpc-specific...

So use arch/powerpc/kernel/asm-offsets.c, that's what it's for.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
