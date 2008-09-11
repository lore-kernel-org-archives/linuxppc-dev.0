Return-Path: <yanok@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3DB0DDDF68
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Sep 2008 04:29:01 +1000 (EST)
Message-ID: <48C96349.1040903@emcraft.com>
Date: Thu, 11 Sep 2008 22:28:25 +0400
From: Ilya Yanok <yanok@emcraft.com>
MIME-Version: 1.0
To: prodyut hazarika <prodyuth@gmail.com>
Subject: Re: [PATCH] powerpc: add support for PAGE_SIZEs greater than 4KB for
References: <1221083587-8091-1-git-send-email-yanok@emcraft.com>	
	<1221083587-8091-2-git-send-email-yanok@emcraft.com>
	<49c0ff980809110957h4b7b85d4ie39dbb27d1edbe39@mail.gmail.com>
In-Reply-To: <49c0ff980809110957h4b7b85d4ie39dbb27d1edbe39@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

prodyut hazarika wrote:
>> +choice
>> +       prompt "Page size"
>> +       depends on 44x && PPC32
>> +       default PPC32_4K_PAGES
>> +       help
>> +         The PAGE_SIZE definition. Increasing the page size may
>> +         improve the system performance in some dedicated cases.
>> +         If unsure, set it to 4 KB.
>> +
>>     
> You should mention an example of dedicated cases (eg. RAID).
> I think this help should mention that for page size 256KB, you will
> need to have a special version of binutils, since the ELF standard
> mentions page sizes only upto 64KB.
>   

Agreed.

>> -#ifdef CONFIG_PPC_64K_PAGES
>> +#if defined(CONFIG_PPC32_256K_PAGES)
>> +#define PAGE_SHIFT             18
>> +#elif defined(CONFIG_PPC32_64K_PAGES) || defined(CONFIG_PPC_64K_PAGES)
>>  #define PAGE_SHIFT             16
>> +#elif defined(CONFIG_PPC32_16K_PAGES)
>> +#define PAGE_SHIFT             14
>>  #else
>>  #define PAGE_SHIFT             12
>>  #endif
>>     
>
> Why should the new defines be inside CONFIG_PPC_64K_PAGES? The
>   

I think you missed first '-' on the first line.

> definition CONFIG_PPC_64K_PAGES is repeated.
> Shouldn't these defines be like this:
> #if defined(CONFIG_PPC32_256K_PAGES)
> #define PAGE_SHIFT             18
> #elif defined(CONFIG_PPC32_64K_PAGES) || defined(CONFIG_PPC_64K_PAGES)
> #define PAGE_SHIFT             16
> #elif defined(CONFIG_PPC32_16K_PAGES)
> #define PAGE_SHIFT             14
> #else
> #define PAGE_SHIFT             12
> #endif
>   

And they do actually :)

> Please change PPC44x_PGD_OFF_SH to PPC44x_PGD_OFF_SHIFT. SH sounds
> very confusing. I don't like the MI and M2 names too. Change
> PPC44x_RPN_M2 to PPC44x_RPN_MASK. Change M1 to MASK in
> PPC44x_PGD_OFF_M1 and PPC44x_PTE_ADD_M1 .
>   

Agreed.

> Is there no way a define like
> #define PPC44x_PGD_OFF_SH      (32 - PMD_SHIFT + 2)
> be used in assembly file. If yes, we can avoid repeating the defines.
>   

We can use defined like this, problem is that PMD_SHIFT and PTE_SHIFT
declared inside #ifndef __ASSEMBLY__

> I think these 44x specific defines should go to asm/mmu-44x.h since I
>   

Agreed.

> For 256KB page size, I cannot understand why PTE_SHIFT is 11. Since
> each PTE entry is 8 byte, PTE_SHIFT should have been 15. But then
> there would be no bits in the Effective address for the 1st level
> PGDIR offset. On what basis PTE_SHIFT of 11 is chosen? This overflow
> problem happens only for 256KB page size.
>   

I think Yuri has commented on this already.

Any comments on the issues mentioned in introductory message?

Regards, Ilya.
