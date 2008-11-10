Return-Path: <yanok@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 90AD2DDE01
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2008 03:24:59 +1100 (EST)
Message-ID: <49186028.8010505@emcraft.com>
Date: Mon, 10 Nov 2008 19:24:08 +0300
From: Ilya Yanok <yanok@emcraft.com>
MIME-Version: 1.0
To: Milton Miller <miltonm@bga.com>
Subject: Re: [2/2] powerpc: support for 256K pages on PPC 44x
References: <d02415a31b89736f070f290be89013d4@bga.com>
In-Reply-To: <d02415a31b89736f070f290be89013d4@bga.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-ppc <linuxppc-dev@ozlabs.org>, Vladimir Panfilov <pvr@emcraft.com>,
	Wolfgang Denk <wd@denx.de>, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Milton,

Milton Miller wrote:
>> This patch adds support for 256K pages on PPC 44x along with
>> some hacks needed for this.
>
> This description is insufficient, it describes neither the hacks nor
> why they are required.

Ok. Actually there is only one hack -- increasing kernel stack size. We
do this because with 256K pages we get division by zero in kernel/fork.c:

        /*
         * The default maximum number of threads is set to a safe
         * value: the thread structures can take up at most half
         * of memory.
         */
        max_threads = mempages / (8 * THREAD_SIZE / PAGE_SIZE);

so setting THREAD_SIZE to bigger value we can avoid this. I don't think
it's very clean solution but at least we stay powerpc-specific.

>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 9627cfd..7df5528 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -425,6 +425,14 @@  config PPC_64K_PAGES
>>         bool "64k page size" if 44x || PPC64
>>         select PPC_HAS_HASH_64K if PPC64
>>
>> +config PPC_256K_PAGES
>> +       bool "256k page size" if 44x
>> +       depends on BROKEN
>
> I know it was not your original choice, but I feel BROKEN is too
> strong.  It should be under embedded, and maybe a second choice "I am
> using standard binutils" that defaults to yes and is set to no (so
> that all yes config does not enable it by accident), but I feel
> labeling this BROKEN for an external dependency is wrong.

Hm... maybe you are right. I'm looking forward for additional comments
on this.

>> +       help
>> +         ELF standard supports only page sizes up to 64K so you need
>> a patched
>> +         binutils in order to use 256K pages. Chose it only if you
>> know what
>> +         you are doing.
>> +
>>  endchoice
>>
>>  config FORCE_MAX_ZONEORDER
>> diff --git a/arch/powerpc/include/asm/highmem.h
>> b/arch/powerpc/include/asm/highmem.h
>> index dc1132c..0b4ac6a 100644
>> --- a/arch/powerpc/include/asm/highmem.h
>> +++ b/arch/powerpc/include/asm/highmem.h
>> @@ -38,7 +38,8 @@  extern pte_t *pkmap_page_table;
>>   * easily, subsequent pte tables have to be allocated in one physical
>>   * chunk of RAM.
>>   */
>> -#if defined(CONFIG_PPC_64K_PAGES) && !defined(CONFIG_PPC64)
>> +#if defined(CONFIG_PPC_256K_PAGES) || \
>> +       (defined(CONFIG_PPC_64K_PAGES) && !defined(CONFIG_PPC64))
>
> Just because 256K pages is not selectable on PPC64 doesn't mean that
> this is the right grouping.   However, as I said on the previous
> patch, this file is never included on PPC64 so the clause should be
> removed.

Ok.

>> diff --git a/arch/powerpc/include/asm/page_32.h
>> b/arch/powerpc/include/asm/page_32.h
>> index ebfae53..273369a 100644
>> --- a/arch/powerpc/include/asm/page_32.h
>> +++ b/arch/powerpc/include/asm/page_32.h
>> @@ -20,7 +20,11 @@
>>   */
>>  #ifdef CONFIG_PTE_64BIT
>>  typedef unsigned long long pte_basic_t;
>> +#ifdef CONFIG_PPC_256K_PAGES
>> +#define PTE_SHIFT       (PAGE_SHIFT - 7)
>
> This seems to be missing the comment on how many ptes are actually in
> the page that are in the other if and else cases.

Ok. I'll fix this. Actually it's another hack: we don't use full page
for PTE table because we need to reserve something for PGD

>> +#else
>>  #define PTE_SHIFT      (PAGE_SHIFT - 3)        /* 512 ptes per page */
>> +#endif
>>  #else
>>  typedef unsigned long pte_basic_t;
>>  #define PTE_SHIFT      (PAGE_SHIFT - 2)        /* 1024 ptes per page */
>> diff --git a/arch/powerpc/include/asm/thread_info.h
>> b/arch/powerpc/include/asm/thread_info.h
>> index 9665a26..3c8bbab 100644
>> --- a/arch/powerpc/include/asm/thread_info.h
>> +++ b/arch/powerpc/include/asm/thread_info.h
>> @@ -15,8 +15,12 @@
>>  #ifdef CONFIG_PPC64
>>  #define THREAD_SHIFT           14
>>  #else
>> +#ifdef CONFIG_PPC_256K_PAGES
>> +#define THREAD_SHIFT           15
>> +#else
>>  #define THREAD_SHIFT           13
>>  #endif
>> +#endif
>>
>>  #define THREAD_SIZE            (1 << THREAD_SHIFT)
>
>
> So this appears to be the one hack.  For some unknown reason, you are
> increasing the kernel stack from 8k to 32k when selecting 256k
> pages.   What data structure is ballooning in size so much that you
> need the additional kernel stack space on 256k pages but not on 64k
> pages?  Is this really tied to 256k base page size?

We don't really need additional stack space. Just trying to avoid
division by zero.

Regards, Ilya.
