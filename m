Return-Path: <yanok@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 04CF9DDE0F
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2008 03:51:34 +1100 (EST)
Message-ID: <4918665C.2060100@emcraft.com>
Date: Mon, 10 Nov 2008 19:50:36 +0300
From: Ilya Yanok <yanok@emcraft.com>
MIME-Version: 1.0
To: Milton Miller <miltonm@bga.com>
Subject: Re: [1/2] powerpc: add 16K/64K pages support for the 44x PPC32
	architectures
References: <4516e17f1d199c21b1398be053e2dada@bga.com>
In-Reply-To: <4516e17f1d199c21b1398be053e2dada@bga.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Wolfgang Denk <wd@denx.de>, dzu@denx.de,
	linux-ppc <linuxppc-dev@ozlabs.org>, Vladimir Panfilov <pvr@emcraft.com>,
	Paul Mackerras <paulus@samba.org>
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
> I started out looking at the too minimal decription of patch 2/2, and
> that morphed into talking about both patches.
>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 587da5e..9627cfd 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -402,16 +402,30 @@  config PPC_HAS_HASH_64K
>>         depends on PPC64
>>         default n
>>
>> -config PPC_64K_PAGES
>> -       bool "64k page size"
>> -       depends on PPC64
>> -       select PPC_HAS_HASH_64K
>> +choice
>> +       prompt "Page size"
>> +       default PPC_4K_PAGES
>>         help
>> -         This option changes the kernel logical page size to 64k. On
>> machines
>> +         The PAGE_SIZE definition. Increasing the page size may
>> +         improve the system performance in some dedicated cases like
>> software
>> +         RAID with accelerated calculations. In PPC64 case on machines
>>           without processor support for 64k pages, the kernel will
>> simulate
>>           them by loading each individual 4k page on demand
>> transparently,
>>           while on hardware with such support, it will be used to map
>>           normal application pages.
>> +         If unsure, set it to 4 KB.
>> +
>
> This is less understandable (more hacker jargon) and too application
> specific.  (Josh, since this is cross-sub-platform we need to make
> sure this fragment gets proper review).
>
> Also, we need to check the help placement, as I seem to remember the
> config programs looking at the first choice instead of the choice
> tag.  Or should the help be split by option?

Help at the choice tag works properly.

> Lets try this
>
> Select the kernel logical page size.   Increasing the page size will
> reduce software overhead at each page boundary, allow hardware
> prefetch mechanisms to be more effective, and allow larger dma
> transfers increasing IO efficiency and reducing overhead.  However the
> utilization of memory will increase.  For example, each cached file
> will using a multiple of the page size to hold its contents and the
> difference between the end of file and the end of page is wasted.
>
> Some dedicated systems, such as software raid serving with accelerated
> calculations, have shown significant increases.
>
> If you configure a 64 bit kernel for 64k pages but the processor does
> not support them, then the kernel will simulate them with 4k pages,
> loading them on demand, but with the reduced software overhead and
> larger internal fragmentation.  For the 32 bit kernel, a large page
> option will not be offered unless it is supported by the configured
> processor.
>
> If unsure, choose 4K_PAGES.

This looks much better for me. I'll include this help message in updated
patch.

>> +config PPC_4K_PAGES
>> +       bool "4k page size"
>> +
>> +config PPC_16K_PAGES
>> +       bool "16k page size" if 44x
>> +
>> +config PPC_64K_PAGES
>> +       bool "64k page size" if 44x || PPC64
>> +       select PPC_HAS_HASH_64K if PPC64
>> +
>> +endchoice
>>
>
>
>> diff --git a/arch/powerpc/include/asm/highmem.h
>> b/arch/powerpc/include/asm/highmem.h
>> index 5d99b64..dc1132c 100644
>> --- a/arch/powerpc/include/asm/highmem.h
>> +++ b/arch/powerpc/include/asm/highmem.h
>> @@ -38,9 +38,15 @@  extern pte_t *pkmap_page_table;
>>   * easily, subsequent pte tables have to be allocated in one physical
>>   * chunk of RAM.
>>   */
>> +#if defined(CONFIG_PPC_64K_PAGES) && !defined(CONFIG_PPC64)
>
> In patch 2/2 I was going to comment about the precedence of PPC64 vs
> 64K_PAGES, but then I realized this file is only included when
> CONFIG_HIGHMEM is set and that depends on PPC32 , so it will never be
> set.   Please remove the additional noise && !defined(CONFIG_PPC64).

Ok.

>> +#define PKMAP_ORDER    (27 - PAGE_SHIFT)
> where did the value 27 come from?

Hm... It's pretty much experimental. There is the range of values which
gives us a proper virtual memory map (VMALLOC_BEGIN < VMALLOC_END) and I
have no clean idea which one we should use.

>> +#define LAST_PKMAP     (1 << PKMAP_ORDER)
>> +#define PKMAP_BASE     (FIXADDR_START - PAGE_SIZE*(LAST_PKMAP + 1))
>> +#else
>>  #define LAST_PKMAP     (1 << PTE_SHIFT)
>> -#define LAST_PKMAP_MASK (LAST_PKMAP-1)
>>  #define PKMAP_BASE     ((FIXADDR_START - PAGE_SIZE*(LAST_PKMAP + 1))
>> & PMD_MASK)
>> +#endif
>> +#define LAST_PKMAP_MASK        (LAST_PKMAP-1)
>
> and why not set PKMAP_ORDER on both sides of the else, keepign
> LAST_PKMAP common?

We can do this but I can't see much sense here... We still need to
define PKMAP_BASE differently.

>>  #define PKMAP_NR(virt)  ((virt-PKMAP_BASE) >> PAGE_SHIFT)
>>  #define PKMAP_ADDR(nr)  (PKMAP_BASE + ((nr) << PAGE_SHIFT))
>>
>>
>
>
>> diff --git a/arch/powerpc/include/asm/pgtable.h
>> b/arch/powerpc/include/asm/pgtable.h
>> index dbb8ca1..0d447fb 100644
>> --- a/arch/powerpc/include/asm/pgtable.h
>> +++ b/arch/powerpc/include/asm/pgtable.h
>> @@ -39,6 +39,9 @@  extern void paging_init(void);
>>
>>  #include <asm-generic/pgtable.h>
>>
>> +#define PGD_T_LOG2     (__builtin_ffs(sizeof(pgd_t)) - 1)
>> +#define PMD_T_LOG2     (__builtin_ffs(sizeof(pmd_t)) - 1)
>> +#define PTE_T_LOG2     (__builtin_ffs(sizeof(pte_t)) - 1)
>>
>
>> diff --git a/arch/powerpc/include/asm/mmu-44x.h
>> b/arch/powerpc/include/asm/mmu-44x.h
>> index a825524..2ca18e8 100644
>> --- a/arch/powerpc/include/asm/mmu-44x.h
>> +++ b/arch/powerpc/include/asm/mmu-44x.h
>
>> +#define PPC44x_PGD_OFF_SHIFT   (32 - PMD_SHIFT + 2)
>> +#define PPC44x_PGD_OFF_MASK    (PMD_SHIFT - 2)
>> +#define PPC44x_PTE_ADD_SHIFT   (32 - PMD_SHIFT + PTE_SHIFT + 3)
>> +#define PPC44x_PTE_ADD_MASK    (32 - 3 - PTE_SHIFT)
>> +#define PPC44x_RPN_MASK                (31 - PAGE_SHIFT)
>> +
>
> Are the values 2 and 3 related to the new defines PG*_T_LOG2 ?

Looks like you are right.

Thanks for your comments.

Regards, Ilya.
