Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 617BADDF4F
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 22:21:51 +1100 (EST)
Date: Wed, 10 Dec 2008 14:21:42 +0300
From: Yuri Tikhonov <yur@emcraft.com>
Message-ID: <1251410626.20081210142142@emcraft.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re[2]: [PATCH] powerpc: add 16K/64K pages support for the 44x PPC32
	architectures.
In-Reply-To: <1228858740.22413.28.camel@pasglop>
References: <1227829488-8260-1-git-send-email-yanok@emcraft.com>
	<1228858740.22413.28.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: linuxppc-dev@ozlabs.org, Vladimir Panfilov <pvr@emcraft.com>, dzu@denx.de,
	Ilya Yanok <yanok@emcraft.com>, wd@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 Hello Ben,

On Wednesday, December 10, 2008 you wrote:

> Hi Ilya !

> Looks good overall. A few minor comments.

>> +config PPC_4K_PAGES
>> +     bool "4k page size"
>> +
>> +config PPC_16K_PAGES
>> +     bool "16k page size" if 44x
>> +
>> +config PPC_64K_PAGES
>> +     bool "64k page size" if 44x || PPC64
>> +     select PPC_HAS_HASH_64K if PPC64

> I'd rather if the PPC64 references were instead PPC_STD_MMU_64 (which
> may or may not be defined in Kconfig depending on what you are based on,
> but is trivial to add.

> I want to clearly differenciate what is MMU from what CPU architecture
> and there may (will ... ahem) at some point be 64-bit BookE.

 Understood. We'll fix this, and re-post the patch then.

 [snip]

>> diff --git a/arch/powerpc/include/asm/highmem.h b/arch/powerpc/include/a=
sm/highmem.h
>> index 91c5895..9875540 100644
>> --- a/arch/powerpc/include/asm/highmem.h
>> +++ b/arch/powerpc/include/asm/highmem.h
>> @@ -38,9 +38,20 @@ extern pte_t *pkmap_page_table;
>>   * easily, subsequent pte tables have to be allocated in one physical
>>   * chunk of RAM.
>>   */
>> -#define LAST_PKMAP   (1 << PTE_SHIFT)
>> -#define LAST_PKMAP_MASK (LAST_PKMAP-1)
>> +/*
>> + * We use one full pte table with 4K pages. And with 16K/64K pages pte
>> + * table covers enough memory (32MB and 512MB resp.) that both FIXMAP
>> + * and PKMAP can be placed in single pte table. We use 1024 pages for
>> + * PKMAP in case of 16K/64K pages.
>> + */
>> +#define PKMAP_ORDER  min(PTE_SHIFT, 10)
>> +#define LAST_PKMAP   (1 << PKMAP_ORDER)
>> +#if !defined(CONFIG_PPC_4K_PAGES)
>> +#define PKMAP_BASE   (FIXADDR_START - PAGE_SIZE*(LAST_PKMAP + 1))
>> +#else
>>  #define PKMAP_BASE   ((FIXADDR_START - PAGE_SIZE*(LAST_PKMAP + 1)) & PM=
D_MASK)
>> +#endif

> I'm not sure about the above & PMD_MASK. Shouldn't we instead make it
> not build if (PKMAP_BASE & PMD_MASK) !=3D 0 ?=20

 We separated the !4K_PAGES case here exactly because  (PKMAP_BASE &=20
PMD_MASK) !=3D 0 [see the comment to this chunk - why]. So, this'll turn=20
out to be broken if we follow your suggestion. Are there any reasons=20
why we should have PKMAP_BASE aligned on the PMD_SIZE boundary ?

> IE, somebody set
> FIXADDR_START to something wrong... and avoid the ifdef alltogether ? Or
> am I missing something ? (it's early morning and I may not have all my
> wits with me right now !)

[snip]

>> diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/a=
sm/pgtable.h
>> index dbb8ca1..a202043 100644
>> --- a/arch/powerpc/include/asm/pgtable.h
>> +++ b/arch/powerpc/include/asm/pgtable.h
>> @@ -39,6 +39,8 @@ extern void paging_init(void);
>> =20
>>  #include <asm-generic/pgtable.h>
>> =20
>> +#define PGD_T_LOG2   (__builtin_ffs(sizeof(pgd_t)) - 1)
>> +#define PTE_T_LOG2   (__builtin_ffs(sizeof(pte_t)) - 1)

> I'm surprised the above actually work :-) Why not having these next to the
> definition of pte_t in page_32.h ?

 These definitions seem to be related to the page table, so, as for me,=20
then pgtable.h is the better place for them. Though, as you want;=20
we'll move this to page_32.h.

> Also, you end up having to do an asm-offset trick to get those to asm, I
> wonder if it's worth it or if we aren't better off just #defining the siz=
es
> with actual numbers next to the type definitions. No big deal either way.
>>  /*
>>   * To support >32-bit physical addresses, we use an 8KB pgdir.
>> diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32=
.S
>> index bdc8b0e..42f99d2 100644
>> --- a/arch/powerpc/kernel/misc_32.S
>> +++ b/arch/powerpc/kernel/misc_32.S
>> @@ -647,8 +647,8 @@ _GLOBAL(__flush_dcache_icache)
>>  BEGIN_FTR_SECTION
>>       blr
>>  END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
>> -     rlwinm  r3,r3,0,0,19                    /* Get page base address */
>> -     li      r4,4096/L1_CACHE_BYTES  /* Number of lines in a page */
>> +     rlwinm  r3,r3,0,0,PPC44x_RPN_MASK       /* Get page base address */
>> +     li      r4,PAGE_SIZE/L1_CACHE_BYTES     /* Number of lines in a pa=
ge */

> Now, the problem here is the name of the constant. IE. This is more or
> less generic ppc code and you are using something called
> "PPC4xx_RPN_MASK", doesn't look right.

> I'r rather you do the right arithmetic using PAGE_SHIFT straight in
> here. In general, those _MASK constants you use aren't really masks,
> they are bit numbers in PPC notation which is very confusing. Maybe you
> should call those constants something like

> PPC_xxxx_MASK_BIT

 OK.

> Dunno ... it's a bit verbose. But I'm not too happy with that naming at
> this stage. In any case, the above is definitely wrong in misc_32.S=20

>>       mtctr   r4
>>       mr      r6,r3
>>  0:   dcbst   0,r3                            /* Write line to ram */
>> @@ -688,8 +688,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
>>       rlwinm  r0,r10,0,28,26                  /* clear DR */
>>       mtmsr   r0
>>       isync
>> -     rlwinm  r3,r3,0,0,19                    /* Get page base address */
>> -     li      r4,4096/L1_CACHE_BYTES  /* Number of lines in a page */
>> +     rlwinm  r3,r3,0,0,PPC44x_RPN_MASK       /* Get page base address */
>> +     li      r4,PAGE_SIZE/L1_CACHE_BYTES     /* Number of lines in a pa=
ge */

> Same comment.

>>  pgd_t *pgd_alloc(struct mm_struct *mm)
>>  {
>>       pgd_t *ret;
>> =20
>> -     ret =3D (pgd_t *)__get_free_pages(GFP_KERNEL|__GFP_ZERO, PGDIR_ORD=
ER);
>> +     ret =3D (pgd_t *)kzalloc(1 << PGDIR_ORDER, GFP_KERNEL);
>>       return ret;
>>  }

> We may want to consider using a slab cache. Maybe an area where we want
> to merge 32 and 64 bit code, though it doesn't have to be right now.

> Do we know the impact of using kzalloc instead of gfp for when it's
> really just a single page though ? Does it have overhead or will kzalloc
> just fallback to gfp ? If it has overhead, then we probably want to
> ifdef and keep using gfp for the 1-page case.

 This depends on allocator: SLUB looks calling __get_free_pages() if=20
size > PAGE_SIZE [note, not >=3D !], but SLAB doesn't. So, we'll add=20
ifdef here.


>>  __init_refok pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned=
 long address)
>> @@ -400,7 +395,7 @@ void kernel_map_pages(struct page *page, int numpage=
s, int enable)
>>  #endif /* CONFIG_DEBUG_PAGEALLOC */
>> =20
>>  static int fixmaps;
>> -unsigned long FIXADDR_TOP =3D 0xfffff000;
>> +unsigned long FIXADDR_TOP =3D (-PAGE_SIZE);
>>  EXPORT_SYMBOL(FIXADDR_TOP);
>> =20
>>  void __set_fixmap (enum fixed_addresses idx, phys_addr_t phys, pgprot_t=
 flags)
>> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platf=
orms/Kconfig.cputype
>> index 548efa5..73a5aa9 100644
>> --- a/arch/powerpc/platforms/Kconfig.cputype
>> +++ b/arch/powerpc/platforms/Kconfig.cputype
>> @@ -204,7 +204,7 @@ config PPC_STD_MMU_32
>> =20
>>  config PPC_MM_SLICES
>>       bool
>> -     default y if HUGETLB_PAGE || PPC_64K_PAGES
>> +     default y if HUGETLB_PAGE || (PPC64 && PPC_64K_PAGES)
>>       default n

> I would make it PPC_64 && (HUGETLB_PAGE || PPC_64K_PAGES) for now,
> I don't think we want to use the existing slice code on anything else.

> Make it even PPC_STD_MMU_64

> Cheers,
> Ben.

 Regards, Yuri

 --
 Yuri Tikhonov, Senior Software Engineer
 Emcraft Systems, www.emcraft.com
