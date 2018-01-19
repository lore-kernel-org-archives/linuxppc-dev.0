Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zNDSt6mL8zF10B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 19:26:54 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0J8OC1W145289
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 03:26:52 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fkcfxhraj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 03:26:51 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 19 Jan 2018 08:26:49 -0000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/5] powerpc/32: Fix hugepage allocation on 8xx at hint
 address
In-Reply-To: <ed0e31af563aa34045b43a20d0668650e8a7bb7a.1516179904.git.christophe.leroy@c-s.fr>
References: <49148d07955d3e5f963cedf9adcfcc37c3e03ef4.1516179904.git.christophe.leroy@c-s.fr>
 <ed0e31af563aa34045b43a20d0668650e8a7bb7a.1516179904.git.christophe.leroy@c-s.fr>
Date: Fri, 19 Jan 2018 13:56:42 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87shb2z22l.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> On the 8xx, the page size is set in the PMD entry and applies to
> all pages of the page table pointed by the said PMD entry.
>
> When an app has some regular pages allocated (e.g. see below) and tries
> to mmap() a huge page at a hint address covered by the same PMD entry,
> the kernel accepts the hint allthough the 8xx cannot handle different
> page sizes in the same PMD entry.
>
> 10000000-10001000 r-xp 00000000 00:0f 2597 /root/malloc
> 10010000-10011000 rwxp 00000000 00:0f 2597 /root/malloc
>
> mmap(0x10080000, 524288, PROT_READ|PROT_WRITE,
>      MAP_PRIVATE|MAP_ANONYMOUS|0x40000, -1, 0) = 0x10080000
>
> This results the app remaining forever in do_page_fault()/hugetlb_fault()
> and when interrupting that app, we get the following warning:
>
> [162980.035629] WARNING: CPU: 0 PID: 2777 at arch/powerpc/mm/hugetlbpage.c:354 hugetlb_free_pgd_range+0xc8/0x1e4
> [162980.035699] CPU: 0 PID: 2777 Comm: malloc Tainted: G W       4.14.6 #85
> [162980.035744] task: c67e2c00 task.stack: c668e000
> [162980.035783] NIP:  c000fe18 LR: c00e1eec CTR: c00f90c0
> [162980.035830] REGS: c668fc20 TRAP: 0700   Tainted: G W        (4.14.6)
> [162980.035854] MSR:  00029032 <EE,ME,IR,DR,RI>  CR: 24044224 XER: 20000000
> [162980.036003]
> [162980.036003] GPR00: c00e1eec c668fcd0 c67e2c00 00000010 c6869410 10080000 00000000 77fb4000
> [162980.036003] GPR08: ffff0001 0683c001 00000000 ffffff80 44028228 10018a34 00004008 418004fc
> [162980.036003] GPR16: c668e000 00040100 c668e000 c06c0000 c668fe78 c668e000 c6835ba0 c668fd48
> [162980.036003] GPR24: 00000000 73ffffff 74000000 00000001 77fb4000 100fffff 10100000 10100000
> [162980.036743] NIP [c000fe18] hugetlb_free_pgd_range+0xc8/0x1e4
> [162980.036839] LR [c00e1eec] free_pgtables+0x12c/0x150
> [162980.036861] Call Trace:
> [162980.036939] [c668fcd0] [c00f0774] unlink_anon_vmas+0x1c4/0x214 (unreliable)
> [162980.037040] [c668fd10] [c00e1eec] free_pgtables+0x12c/0x150
> [162980.037118] [c668fd40] [c00eabac] exit_mmap+0xe8/0x1b4
> [162980.037210] [c668fda0] [c0019710] mmput.part.9+0x20/0xd8
> [162980.037301] [c668fdb0] [c001ecb0] do_exit+0x1f0/0x93c
> [162980.037386] [c668fe00] [c001f478] do_group_exit+0x40/0xcc
> [162980.037479] [c668fe10] [c002a76c] get_signal+0x47c/0x614
> [162980.037570] [c668fe70] [c0007840] do_signal+0x54/0x244
> [162980.037654] [c668ff30] [c0007ae8] do_notify_resume+0x34/0x88
> [162980.037744] [c668ff40] [c000dae8] do_user_signal+0x74/0xc4
> [162980.037781] Instruction dump:
> [162980.037821] 7fdff378 81370000 54a3463a 80890020 7d24182e 7c841a14 712a0004 4082ff94
> [162980.038014] 2f890000 419e0010 712a0ff0 408200e0 <0fe00000> 54a9000a 7f984840 419d0094
> [162980.038216] ---[ end trace c0ceeca8e7a5800a ]---
> [162980.038754] BUG: non-zero nr_ptes on freeing mm: 1
> [162985.363322] BUG: non-zero nr_ptes on freeing mm: -1
>
> In order to fix this, this patch uses the address space "slices"
> implemented for BOOK3S/64 and enhanced to support PPC32 by the
> preceding patch.
>
> This patch modifies the context.id on the 8xx to be in the range
> [1:16] instead of [0:15] in order to identify context.id == 0 as
> not initialised contexts as done on BOOK3S
>
> This patch activates CONFIG_PPC_MM_SLICES when CONFIG_HUGETLB_PAGE is
> selected for the 8xx
>
> Alltough we could in theory have as many slices as PMD entries, the
> current slices implementation limits the number of low slices to 16.
> This limitation is not preventing us to fix the initial issue allthough
> it is suboptimal. It will be cured in a subsequent patch.
>
> Fixes: 4b91428699477 ("powerpc/8xx: Implement support of hugepages")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  v2: First patch of v1 serie split in two parts
>
>  arch/powerpc/include/asm/mmu-8xx.h     | 6 ++++++
>  arch/powerpc/kernel/setup-common.c     | 2 ++
>  arch/powerpc/mm/8xx_mmu.c              | 2 +-
>  arch/powerpc/mm/hugetlbpage.c          | 2 ++
>  arch/powerpc/mm/mmu_context_nohash.c   | 4 ++--
>  arch/powerpc/mm/slice.c                | 2 ++
>  arch/powerpc/platforms/Kconfig.cputype | 1 +
>  7 files changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/mmu-8xx.h b/arch/powerpc/include/asm/mmu-8xx.h
> index 5bb3dbede41a..5f89b6010453 100644
> --- a/arch/powerpc/include/asm/mmu-8xx.h
> +++ b/arch/powerpc/include/asm/mmu-8xx.h
> @@ -169,6 +169,12 @@ typedef struct {
>  	unsigned int id;
>  	unsigned int active;
>  	unsigned long vdso_base;
> +#ifdef CONFIG_PPC_MM_SLICES
> +	u16 user_psize;		/* page size index */
> +	u64 low_slices_psize;	/* page size encodings */
> +	unsigned char high_slices_psize[0];
> +	unsigned long slb_addr_limit;
> +#endif
>  } mm_context_t;
>  
>  #define PHYS_IMMR_BASE (mfspr(SPRN_IMMR) & 0xfff80000)
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index 9d213542a48b..67075a1cff36 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -927,6 +927,8 @@ void __init setup_arch(char **cmdline_p)
>  #ifdef CONFIG_PPC64
>  	if (!radix_enabled())
>  		init_mm.context.slb_addr_limit = DEFAULT_MAP_WINDOW_USER64;
> +#elif defined(CONFIG_PPC_8xx)
> +	init_mm.context.slb_addr_limit = DEFAULT_MAP_WINDOW;
>  #else
>  #error	"context.addr_limit not initialized."
>  #endif
> diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
> index f29212e40f40..0be77709446c 100644
> --- a/arch/powerpc/mm/8xx_mmu.c
> +++ b/arch/powerpc/mm/8xx_mmu.c
> @@ -192,7 +192,7 @@ void set_context(unsigned long id, pgd_t *pgd)
>  	mtspr(SPRN_M_TW, __pa(pgd) - offset);
>  
>  	/* Update context */
> -	mtspr(SPRN_M_CASID, id);
> +	mtspr(SPRN_M_CASID, id - 1);
>  	/* sync */
>  	mb();
>  }
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index a9b9083c5e49..79e1378ee303 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -553,9 +553,11 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>  	struct hstate *hstate = hstate_file(file);
>  	int mmu_psize = shift_to_mmu_psize(huge_page_shift(hstate));
>  
> +#ifdef CONFIG_PPC_RADIX_MMU
>  	if (radix_enabled())
>  		return radix__hugetlb_get_unmapped_area(file, addr, len,
>  						       pgoff, flags);
> +#endif

if (0) didn't remove the following radix__hugetlb_get_unmapped_area for
you? 


>  	return slice_get_unmapped_area(addr, len, flags, mmu_psize, 1);
>  }
>  #endif
> diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_context_nohash.c
> index 42e02f5b6660..c1e1bf186871 100644
> --- a/arch/powerpc/mm/mmu_context_nohash.c
> +++ b/arch/powerpc/mm/mmu_context_nohash.c
> @@ -435,8 +435,8 @@ void __init mmu_context_init(void)
>  	 *      -- BenH
>  	 */
>  	if (mmu_has_feature(MMU_FTR_TYPE_8xx)) {
> -		first_context = 0;
> -		last_context = 15;
> +		first_context = 1;
> +		last_context = 16;
>  		no_selective_tlbil = true;
>  	} else if (mmu_has_feature(MMU_FTR_TYPE_47x)) {
>  		first_context = 1;
> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
> index 3f35a93afe13..b617acf35836 100644
> --- a/arch/powerpc/mm/slice.c
> +++ b/arch/powerpc/mm/slice.c
> @@ -206,6 +206,7 @@ static int slice_check_fit(struct mm_struct *mm,
>  
>  static void slice_flush_segments(void *parm)
>  {
> +#ifdef CONFIG_PPC_BOOK3S_64
>  	struct mm_struct *mm = parm;
>  	unsigned long flags;
>  
> @@ -217,6 +218,7 @@ static void slice_flush_segments(void *parm)
>  	local_irq_save(flags);
>  	slb_flush_and_rebolt();
>  	local_irq_restore(flags);
> +#endif
>  }
>  
>  static void slice_convert(struct mm_struct *mm, struct slice_mask mask, int psize)
> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
> index ae07470fde3c..73a7ea333e9e 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -334,6 +334,7 @@ config PPC_BOOK3E_MMU
>  config PPC_MM_SLICES
>  	bool
>  	default y if PPC_BOOK3S_64
> +	default y if PPC_8xx && HUGETLB_PAGE
>  	default n
>  
>  config PPC_HAVE_PMU_SUPPORT
> -- 
> 2.13.3
