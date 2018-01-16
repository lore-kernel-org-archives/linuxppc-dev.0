Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLbML4Kj5zF0Wt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 03:31:26 +1100 (AEDT)
Subject: Re: [PATCH 1/3] powerpc/32: Fix hugepage allocation on 8xx at hint
 address
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <9a5dadc10f88e2fc0ac9fb5d18c5424df33f3f4c.1515169256.git.christophe.leroy@c-s.fr>
 <876081by7g.fsf@linux.vnet.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <b5e34a5b-94b8-9405-929d-d35dde3fcb3b@c-s.fr>
Date: Tue, 16 Jan 2018 17:31:22 +0100
MIME-Version: 1.0
In-Reply-To: <876081by7g.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 16/01/2018 à 16:49, Aneesh Kumar K.V a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> When an app has some regular pages allocated (e.g. see below) and tries
>> to mmap() a huge page at a hint address covered by the same PMD entry,
>> the kernel accepts the hint allthough the 8xx cannot handle different
>> page sizes in the same PMD entry.
> 
> 
> So that is a bug in get_unmapped_area function that you are using and
> you want to fix that by using the slice code. Can you describe here what
> the allocation restrictions are w.r.t 8xx? Do they have segments and
> base page size like hash64?

I don't think it is a bug in get_unmapped_area() that is used by 
default. It is that some HW do support mixing any page size in the same 
page table (eg BOOK3E ?), but the 8xx doesn't.
In the 8xx, the page size is defined in the PGD entry, then all pages 
defined in a given page table pointed by a PGD entry have the same size.

So it is similar to segments if you consider each PGD entry as a kind of 
segment

> 
>>
>> 10000000-10001000 r-xp 00000000 00:0f 2597 /root/malloc
>> 10010000-10011000 rwxp 00000000 00:0f 2597 /root/malloc
>>
>> mmap(0x10080000, 524288, PROT_READ|PROT_WRITE,
>>       MAP_PRIVATE|MAP_ANONYMOUS|0x40000, -1, 0) = 0x10080000
>>
>> This results in the following warning, and the app remains forever in
>> do_page_fault()/hugetlb_fault()
>>
>> [162980.035629] WARNING: CPU: 0 PID: 2777 at arch/powerpc/mm/hugetlbpage.c:354 hugetlb_free_pgd_range+0xc8/0x1e4
>> [162980.035699] CPU: 0 PID: 2777 Comm: malloc Tainted: G W       4.14.6 #85
>> [162980.035744] task: c67e2c00 task.stack: c668e000
>> [162980.035783] NIP:  c000fe18 LR: c00e1eec CTR: c00f90c0
>> [162980.035830] REGS: c668fc20 TRAP: 0700   Tainted: G W        (4.14.6)
>> [162980.035854] MSR:  00029032 <EE,ME,IR,DR,RI>  CR: 24044224 XER: 20000000
>> [162980.036003]
>> [162980.036003] GPR00: c00e1eec c668fcd0 c67e2c00 00000010 c6869410 10080000 00000000 77fb4000
>> [162980.036003] GPR08: ffff0001 0683c001 00000000 ffffff80 44028228 10018a34 00004008 418004fc
>> [162980.036003] GPR16: c668e000 00040100 c668e000 c06c0000 c668fe78 c668e000 c6835ba0 c668fd48
>> [162980.036003] GPR24: 00000000 73ffffff 74000000 00000001 77fb4000 100fffff 10100000 10100000
>> [162980.036743] NIP [c000fe18] hugetlb_free_pgd_range+0xc8/0x1e4
>> [162980.036839] LR [c00e1eec] free_pgtables+0x12c/0x150
>> [162980.036861] Call Trace:
>> [162980.036939] [c668fcd0] [c00f0774] unlink_anon_vmas+0x1c4/0x214 (unreliable)
>> [162980.037040] [c668fd10] [c00e1eec] free_pgtables+0x12c/0x150
>> [162980.037118] [c668fd40] [c00eabac] exit_mmap+0xe8/0x1b4
>> [162980.037210] [c668fda0] [c0019710] mmput.part.9+0x20/0xd8
>> [162980.037301] [c668fdb0] [c001ecb0] do_exit+0x1f0/0x93c
>> [162980.037386] [c668fe00] [c001f478] do_group_exit+0x40/0xcc
>> [162980.037479] [c668fe10] [c002a76c] get_signal+0x47c/0x614
>> [162980.037570] [c668fe70] [c0007840] do_signal+0x54/0x244
>> [162980.037654] [c668ff30] [c0007ae8] do_notify_resume+0x34/0x88
>> [162980.037744] [c668ff40] [c000dae8] do_user_signal+0x74/0xc4
>> [162980.037781] Instruction dump:
>> [162980.037821] 7fdff378 81370000 54a3463a 80890020 7d24182e 7c841a14 712a0004 4082ff94
>> [162980.038014] 2f890000 419e0010 712a0ff0 408200e0 <0fe00000> 54a9000a 7f984840 419d0094
>> [162980.038216] ---[ end trace c0ceeca8e7a5800a ]---
>> [162980.038754] BUG: non-zero nr_ptes on freeing mm: 1
>> [162985.363322] BUG: non-zero nr_ptes on freeing mm: -1
>>
>> In order to fix this, the address space "slices" implemented
>> for BOOK3S/64 is reused.
>>
>> This patch:
>> 1/ Modifies the "slices" implementation to support 32 bits CPUs,
>> based on using only the low slices.
>> 2/ Moves "slices" functions prototypes from page64.h to page.h
>> 3/ Modifies the context.id on the 8xx to be in the range [1:16]
>> instead of [0:15] in order to identify context.id == 0 as
>> not initialised contexts
>> 4/ Activates CONFIG_PPC_MM_SLICES when CONFIG_HUGETLB_PAGE is
>> selected for the 8xx
>>
>> Alltough we could in theory have as many slices as PMD entries, the current
>> slices implementation limits the number of low slices to 16.
> 
> Can you explain this more?

As you commented in your other mail, mm_context_t.low_slice_psize which 
is of type 64 and need 4 bits per each slice to store the segment base
page size details, so the maximum number of low slices is 64/4=16


> 
> 
>>
>> Fixes: 4b91428699477 ("powerpc/8xx: Implement support of hugepages")
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/include/asm/mmu-8xx.h     |  6 ++++
>>   arch/powerpc/include/asm/page.h        | 14 ++++++++
>>   arch/powerpc/include/asm/page_32.h     | 19 +++++++++++
>>   arch/powerpc/include/asm/page_64.h     | 21 ++----------
>>   arch/powerpc/kernel/setup-common.c     |  2 +-
>>   arch/powerpc/mm/8xx_mmu.c              |  2 +-
>>   arch/powerpc/mm/hash_utils_64.c        |  2 +-
>>   arch/powerpc/mm/hugetlbpage.c          |  2 ++
>>   arch/powerpc/mm/mmu_context_nohash.c   | 11 +++++--
>>   arch/powerpc/mm/slice.c                | 58 +++++++++++++++++++++++-----------
>>   arch/powerpc/platforms/Kconfig.cputype |  1 +
>>   11 files changed, 95 insertions(+), 43 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/mmu-8xx.h b/arch/powerpc/include/asm/mmu-8xx.h
>> index 5bb3dbede41a..5f89b6010453 100644
>> --- a/arch/powerpc/include/asm/mmu-8xx.h
>> +++ b/arch/powerpc/include/asm/mmu-8xx.h
>> @@ -169,6 +169,12 @@ typedef struct {
>>   	unsigned int id;
>>   	unsigned int active;
>>   	unsigned long vdso_base;
>> +#ifdef CONFIG_PPC_MM_SLICES
>> +	u16 user_psize;		/* page size index */
>> +	u64 low_slices_psize;	/* page size encodings */
>> +	unsigned char high_slices_psize[0];
>> +	unsigned long slb_addr_limit;
>> +#endif
>>   } mm_context_t;
>>   
>>   #define PHYS_IMMR_BASE (mfspr(SPRN_IMMR) & 0xfff80000)
>> diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
>> index 8da5d4c1cab2..d0384f9db9eb 100644
>> --- a/arch/powerpc/include/asm/page.h
>> +++ b/arch/powerpc/include/asm/page.h
>> @@ -342,6 +342,20 @@ typedef struct page *pgtable_t;
>>   #endif
>>   #endif
>>   
>> +#ifdef CONFIG_PPC_MM_SLICES
>> +struct mm_struct;
>> +
>> +unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>> +				      unsigned long flags, unsigned int psize,
>> +				      int topdown);
>> +
>> +unsigned int get_slice_psize(struct mm_struct *mm, unsigned long addr);
>> +
>> +void slice_set_user_psize(struct mm_struct *mm, unsigned int psize);
>> +void slice_set_range_psize(struct mm_struct *mm, unsigned long start,
>> +			   unsigned long len, unsigned int psize);
>> +#endif
>> +
>>   #include <asm-generic/memory_model.h>
>>   #endif /* __ASSEMBLY__ */
>>   
>> diff --git a/arch/powerpc/include/asm/page_32.h b/arch/powerpc/include/asm/page_32.h
>> index 5c378e9b78c8..f7d1bd1183c8 100644
>> --- a/arch/powerpc/include/asm/page_32.h
>> +++ b/arch/powerpc/include/asm/page_32.h
>> @@ -60,4 +60,23 @@ extern void copy_page(void *to, void *from);
>>   
>>   #endif /* __ASSEMBLY__ */
>>   
>> +#ifdef CONFIG_PPC_MM_SLICES
>> +
>> +#define SLICE_LOW_SHIFT		28
>> +#define SLICE_HIGH_SHIFT	0
>> +
>> +#define SLICE_LOW_TOP		(0xfffffffful)
>> +#define SLICE_NUM_LOW		((SLICE_LOW_TOP >> SLICE_LOW_SHIFT) + 1)
>> +#define SLICE_NUM_HIGH		0ul
>> +
>> +#define GET_LOW_SLICE_INDEX(addr)	((addr) >> SLICE_LOW_SHIFT)
>> +#define GET_HIGH_SLICE_INDEX(addr)	(addr & 0)
>> +
>> +#ifdef CONFIG_HUGETLB_PAGE
>> +#define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
>> +#endif
>> +#define HAVE_ARCH_UNMAPPED_AREA
>> +#define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
>> +
>> +#endif
>>   #endif /* _ASM_POWERPC_PAGE_32_H */
>> diff --git a/arch/powerpc/include/asm/page_64.h b/arch/powerpc/include/asm/page_64.h
>> index 56234c6fcd61..a7baef5bbe5f 100644
>> --- a/arch/powerpc/include/asm/page_64.h
>> +++ b/arch/powerpc/include/asm/page_64.h
>> @@ -91,30 +91,13 @@ extern u64 ppc64_pft_size;
>>   #define SLICE_LOW_SHIFT		28
>>   #define SLICE_HIGH_SHIFT	40
>>   
>> -#define SLICE_LOW_TOP		(0x100000000ul)
>> -#define SLICE_NUM_LOW		(SLICE_LOW_TOP >> SLICE_LOW_SHIFT)
>> +#define SLICE_LOW_TOP		(0xfffffffful)
>> +#define SLICE_NUM_LOW		((SLICE_LOW_TOP >> SLICE_LOW_SHIFT) + 1)
>>   #define SLICE_NUM_HIGH		(H_PGTABLE_RANGE >> SLICE_HIGH_SHIFT)
> 
> 
> Why are you changing this? is this a bug fix?

That's because 0x100000000ul is out of range of unsigned long on PPC32.

> 
>>   
>>   #define GET_LOW_SLICE_INDEX(addr)	((addr) >> SLICE_LOW_SHIFT)
>>   #define GET_HIGH_SLICE_INDEX(addr)	((addr) >> SLICE_HIGH_SHIFT)
>>   
>> -#ifndef __ASSEMBLY__
>> -struct mm_struct;
>> -
>> -extern unsigned long slice_get_unmapped_area(unsigned long addr,
>> -					     unsigned long len,
>> -					     unsigned long flags,
>> -					     unsigned int psize,
>> -					     int topdown);
>> -
>> -extern unsigned int get_slice_psize(struct mm_struct *mm,
>> -				    unsigned long addr);
>> -
>> -extern void slice_set_user_psize(struct mm_struct *mm, unsigned int psize);
>> -extern void slice_set_range_psize(struct mm_struct *mm, unsigned long start,
>> -				  unsigned long len, unsigned int psize);
>> -
>> -#endif /* __ASSEMBLY__ */
>>   #else
>>   #define slice_init()
>>   #ifdef CONFIG_PPC_BOOK3S_64
>> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
>> index 9d213542a48b..a285e1067713 100644
>> --- a/arch/powerpc/kernel/setup-common.c
>> +++ b/arch/powerpc/kernel/setup-common.c
>> @@ -928,7 +928,7 @@ void __init setup_arch(char **cmdline_p)
>>   	if (!radix_enabled())
>>   		init_mm.context.slb_addr_limit = DEFAULT_MAP_WINDOW_USER64;
>>   #else
>> -#error	"context.addr_limit not initialized."
>> +	init_mm.context.slb_addr_limit = DEFAULT_MAP_WINDOW;
>>   #endif
> 
> 
> May be put this within #ifdef 8XX and retain the error?

Is this error really worth it ?
I wanted to avoid spreading too many #ifdef PPC_8xx, but ok I can do that.

> 
>>   #endif
>>   
>> diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
>> index f29212e40f40..0be77709446c 100644
>> --- a/arch/powerpc/mm/8xx_mmu.c
>> +++ b/arch/powerpc/mm/8xx_mmu.c
>> @@ -192,7 +192,7 @@ void set_context(unsigned long id, pgd_t *pgd)
>>   	mtspr(SPRN_M_TW, __pa(pgd) - offset);
>>   
>>   	/* Update context */
>> -	mtspr(SPRN_M_CASID, id);
>> +	mtspr(SPRN_M_CASID, id - 1);
>>   	/* sync */
>>   	mb();
>>   }
>> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
>> index 655a5a9a183d..3266b3326088 100644
>> --- a/arch/powerpc/mm/hash_utils_64.c
>> +++ b/arch/powerpc/mm/hash_utils_64.c
>> @@ -1101,7 +1101,7 @@ static unsigned int get_paca_psize(unsigned long addr)
>>   	unsigned char *hpsizes;
>>   	unsigned long index, mask_index;
>>   
>> -	if (addr < SLICE_LOW_TOP) {
>> +	if (addr <= SLICE_LOW_TOP) {
> 
> If this is part of bug fix, please do it as part of seperate patch with details

As explained above, in order to allow comparison to work on PPC32, 
SLICE_LOW_TOP has to be 0xffffffff instead of 0x100000000

How should I split in separate patches ? Something like ?
1/ Slice support for PPC32
2/ Activate slice for 8xx

> 
> 
>>   		lpsizes = get_paca()->mm_ctx_low_slices_psize;
>>   		index = GET_LOW_SLICE_INDEX(addr);
>>   		return (lpsizes >> (index * 4)) & 0xF;
>> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
>> index a9b9083c5e49..79e1378ee303 100644
>> --- a/arch/powerpc/mm/hugetlbpage.c
>> +++ b/arch/powerpc/mm/hugetlbpage.c
>> @@ -553,9 +553,11 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>>   	struct hstate *hstate = hstate_file(file);
>>   	int mmu_psize = shift_to_mmu_psize(huge_page_shift(hstate));
>>   
>> +#ifdef CONFIG_PPC_RADIX_MMU
>>   	if (radix_enabled())
>>   		return radix__hugetlb_get_unmapped_area(file, addr, len,
>>   						       pgoff, flags);
>> +#endif
>>   	return slice_get_unmapped_area(addr, len, flags, mmu_psize, 1);
>>   }
>>   #endif
>> diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_context_nohash.c
>> index 4554d6527682..c1e1bf186871 100644
>> --- a/arch/powerpc/mm/mmu_context_nohash.c
>> +++ b/arch/powerpc/mm/mmu_context_nohash.c
>> @@ -331,6 +331,13 @@ int init_new_context(struct task_struct *t, struct mm_struct *mm)
>>   {
>>   	pr_hard("initing context for mm @%p\n", mm);
>>   
>> +#ifdef CONFIG_PPC_MM_SLICES
>> +	if (!mm->context.slb_addr_limit)
>> +		mm->context.slb_addr_limit = DEFAULT_MAP_WINDOW;
>> +	if (!mm->context.id)
>> +		slice_set_user_psize(mm, mmu_virtual_psize);
>> +#endif
>> +
>>   	mm->context.id = MMU_NO_CONTEXT;
>>   	mm->context.active = 0;
>>   	return 0;
>> @@ -428,8 +435,8 @@ void __init mmu_context_init(void)
>>   	 *      -- BenH
>>   	 */
>>   	if (mmu_has_feature(MMU_FTR_TYPE_8xx)) {
>> -		first_context = 0;
>> -		last_context = 15;
>> +		first_context = 1;
>> +		last_context = 16;
>>   		no_selective_tlbil = true;
>>   	} else if (mmu_has_feature(MMU_FTR_TYPE_47x)) {
>>   		first_context = 1;
>> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
>> index 23ec2c5e3b78..1a66fafc3e45 100644
>> --- a/arch/powerpc/mm/slice.c
>> +++ b/arch/powerpc/mm/slice.c
>> @@ -73,10 +73,11 @@ static void slice_range_to_mask(unsigned long start, unsigned long len,
>>   	unsigned long end = start + len - 1;
>>   
>>   	ret->low_slices = 0;
>> -	bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
>> +	if (SLICE_NUM_HIGH)
>> +		bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
> 
> So you don't want to use high slices but just low slice? If so can you
> add that as a different patch which implements just that.

high slices are over 0xffffffff, so pointless on PPC32.

> 
> 
>>   
>> -	if (start < SLICE_LOW_TOP) {
>> -		unsigned long mend = min(end, (SLICE_LOW_TOP - 1));
>> +	if (start <= SLICE_LOW_TOP) {
>> +		unsigned long mend = min(end, SLICE_LOW_TOP);
>>   
>>   		ret->low_slices = (1u << (GET_LOW_SLICE_INDEX(mend) + 1))
>>   			- (1u << GET_LOW_SLICE_INDEX(start));
>> @@ -117,7 +118,7 @@ static int slice_high_has_vma(struct mm_struct *mm, unsigned long slice)
>>   	 * of the high or low area bitmaps, the first high area starts
>>   	 * at 4GB, not 0 */
>>   	if (start == 0)
>> -		start = SLICE_LOW_TOP;
>> +		start = SLICE_LOW_TOP + 1;
>>   
>>   	return !slice_area_is_free(mm, start, end - start);
>>   }
>> @@ -128,7 +129,8 @@ static void slice_mask_for_free(struct mm_struct *mm, struct slice_mask *ret,
>>   	unsigned long i;
>>   
>>   	ret->low_slices = 0;
>> -	bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
>> +	if (SLICE_NUM_HIGH)
>> +		bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
>>   
>>   	for (i = 0; i < SLICE_NUM_LOW; i++)
>>   		if (!slice_low_has_vma(mm, i))
>> @@ -151,7 +153,8 @@ static void slice_mask_for_size(struct mm_struct *mm, int psize, struct slice_ma
>>   	u64 lpsizes;
>>   
>>   	ret->low_slices = 0;
>> -	bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
>> +	if (SLICE_NUM_HIGH)
>> +		bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
>>   
>>   	lpsizes = mm->context.low_slices_psize;
>>   	for (i = 0; i < SLICE_NUM_LOW; i++)
>> @@ -180,15 +183,18 @@ static int slice_check_fit(struct mm_struct *mm,
>>   	 */
>>   	unsigned long slice_count = GET_HIGH_SLICE_INDEX(mm->context.slb_addr_limit);
>>   
>> -	bitmap_and(result, mask.high_slices,
>> -		   available.high_slices, slice_count);
>> +	if (SLICE_NUM_HIGH)
>> +		bitmap_and(result, mask.high_slices,
>> +			   available.high_slices, slice_count);
>>   
>>   	return (mask.low_slices & available.low_slices) == mask.low_slices &&
>> -		bitmap_equal(result, mask.high_slices, slice_count);
>> +		(!slice_count ||
>> +		 bitmap_equal(result, mask.high_slices, slice_count));
>>   }
>>   
>>   static void slice_flush_segments(void *parm)
>>   {
>> +#ifdef CONFIG_PPC_BOOK3S_64
>>   	struct mm_struct *mm = parm;
>>   	unsigned long flags;
>>   
>> @@ -200,6 +206,7 @@ static void slice_flush_segments(void *parm)
>>   	local_irq_save(flags);
>>   	slb_flush_and_rebolt();
>>   	local_irq_restore(flags);
>> +#endif
>>   }
>>   
>>   static void slice_convert(struct mm_struct *mm, struct slice_mask mask, int psize)
>> @@ -259,7 +266,7 @@ static bool slice_scan_available(unsigned long addr,
>>   				 unsigned long *boundary_addr)
>>   {
>>   	unsigned long slice;
>> -	if (addr < SLICE_LOW_TOP) {
>> +	if (addr <= SLICE_LOW_TOP) {
>>   		slice = GET_LOW_SLICE_INDEX(addr);
>>   		*boundary_addr = (slice + end) << SLICE_LOW_SHIFT;
>>   		return !!(available.low_slices & (1u << slice));
>> @@ -391,8 +398,11 @@ static inline void slice_or_mask(struct slice_mask *dst, struct slice_mask *src)
>>   	DECLARE_BITMAP(result, SLICE_NUM_HIGH);
>>   
>>   	dst->low_slices |= src->low_slices;
>> -	bitmap_or(result, dst->high_slices, src->high_slices, SLICE_NUM_HIGH);
>> -	bitmap_copy(dst->high_slices, result, SLICE_NUM_HIGH);
>> +	if (SLICE_NUM_HIGH) {
>> +		bitmap_or(result, dst->high_slices, src->high_slices,
>> +			  SLICE_NUM_HIGH);
>> +		bitmap_copy(dst->high_slices, result, SLICE_NUM_HIGH);
>> +	}
>>   }
>>   
>>   static inline void slice_andnot_mask(struct slice_mask *dst, struct slice_mask *src)
>> @@ -401,12 +411,17 @@ static inline void slice_andnot_mask(struct slice_mask *dst, struct slice_mask *
>>   
>>   	dst->low_slices &= ~src->low_slices;
>>   
>> -	bitmap_andnot(result, dst->high_slices, src->high_slices, SLICE_NUM_HIGH);
>> -	bitmap_copy(dst->high_slices, result, SLICE_NUM_HIGH);
>> +	if (SLICE_NUM_HIGH) {
>> +		bitmap_andnot(result, dst->high_slices, src->high_slices,
>> +			      SLICE_NUM_HIGH);
>> +		bitmap_copy(dst->high_slices, result, SLICE_NUM_HIGH);
>> +	}
>>   }
>>   
>>   #ifdef CONFIG_PPC_64K_PAGES
>>   #define MMU_PAGE_BASE	MMU_PAGE_64K
>> +#elif defined(CONFIG_PPC_16K_PAGES)
>> +#define MMU_PAGE_BASE	MMU_PAGE_16K
>>   #else
>>   #define MMU_PAGE_BASE	MMU_PAGE_4K
>>   #endif
> 
> I am not sure we want them based on page size. The rule is we flush
> segments on book3s63 if the page size is different from MMU_PAGE_BASE

Do you mean this definition is just useless for the 8xx as it doesn't 
have real segments ?

> 
> 
>> @@ -450,14 +465,17 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>>   	 * init different masks
>>   	 */
>>   	mask.low_slices = 0;
>> -	bitmap_zero(mask.high_slices, SLICE_NUM_HIGH);
>> +	if (SLICE_NUM_HIGH)
>> +		bitmap_zero(mask.high_slices, SLICE_NUM_HIGH);
>>   
>>   	/* silence stupid warning */;
>>   	potential_mask.low_slices = 0;
>> -	bitmap_zero(potential_mask.high_slices, SLICE_NUM_HIGH);
>> +	if (SLICE_NUM_HIGH)
>> +		bitmap_zero(potential_mask.high_slices, SLICE_NUM_HIGH);
>>   
>>   	compat_mask.low_slices = 0;
>> -	bitmap_zero(compat_mask.high_slices, SLICE_NUM_HIGH);
>> +	if (SLICE_NUM_HIGH)
>> +		bitmap_zero(compat_mask.high_slices, SLICE_NUM_HIGH);
>>   
>>   	/* Sanity checks */
>>   	BUG_ON(mm->task_size == 0);
>> @@ -595,7 +613,9 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>>    convert:
>>   	slice_andnot_mask(&mask, &good_mask);
>>   	slice_andnot_mask(&mask, &compat_mask);
>> -	if (mask.low_slices || !bitmap_empty(mask.high_slices, SLICE_NUM_HIGH)) {
>> +	if (mask.low_slices ||
>> +	    (SLICE_NUM_HIGH &&
>> +	     !bitmap_empty(mask.high_slices, SLICE_NUM_HIGH))) {
>>   		slice_convert(mm, mask, psize);
>>   		if (psize > MMU_PAGE_BASE)
>>   			on_each_cpu(slice_flush_segments, mm, 1);
>> @@ -640,7 +660,7 @@ unsigned int get_slice_psize(struct mm_struct *mm, unsigned long addr)
>>   		return MMU_PAGE_4K;
>>   #endif
>>   	}
>> -	if (addr < SLICE_LOW_TOP) {
>> +	if (addr <= SLICE_LOW_TOP) {
>>   		u64 lpsizes;
>>   		lpsizes = mm->context.low_slices_psize;
>>   		index = GET_LOW_SLICE_INDEX(addr);
>> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
>> index ae07470fde3c..73a7ea333e9e 100644
>> --- a/arch/powerpc/platforms/Kconfig.cputype
>> +++ b/arch/powerpc/platforms/Kconfig.cputype
>> @@ -334,6 +334,7 @@ config PPC_BOOK3E_MMU
>>   config PPC_MM_SLICES
>>   	bool
>>   	default y if PPC_BOOK3S_64
>> +	default y if PPC_8xx && HUGETLB_PAGE
>>   	default n
>>   
>>   config PPC_HAVE_PMU_SUPPORT
>> -- 
>> 2.13.3
