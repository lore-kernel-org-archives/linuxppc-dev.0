Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Becky Bruce <beckyb@kernel.crashing.org>
Subject: Re: [PATCH] fsl_booke: Correct test for MMU_FTR_BIG_PHYS
In-reply-to: <1270844541-11125-1-git-send-email-beckyb@kernel.crashing.org>
References: <1270844541-11125-1-git-send-email-beckyb@kernel.crashing.org>
Date: Sun, 11 Apr 2010 13:47:36 +1000
Message-ID: <27522.1270957656@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In message <1270844541-11125-1-git-send-email-beckyb@kernel.crashing.org> you w
rote:
> The code was looking for this in cpu_features, not mmu_features.  Fix this.
> 
> Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
> ---
>  arch/powerpc/mm/fsl_booke_mmu.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.
c
> index c539472..533cae5 100644
> --- a/arch/powerpc/mm/fsl_booke_mmu.c
> +++ b/arch/powerpc/mm/fsl_booke_mmu.c
> @@ -116,7 +116,7 @@ void loadcam_entry(int idx)
>  	mtspr(SPRN_MAS2, TLBCAM[idx].MAS2);
>  	mtspr(SPRN_MAS3, TLBCAM[idx].MAS3);
>  
> -	if (cur_cpu_spec->cpu_features & MMU_FTR_BIG_PHYS)
> +	if (cur_cpu_spec->mmu_features & MMU_FTR_BIG_PHYS)

How about using mmu_has_feature()?

>  		mtspr(SPRN_MAS7, TLBCAM[idx].MAS7);
>  
>  	asm volatile("isync;tlbwe;isync" : : : "memory");
> @@ -152,7 +152,7 @@ static void settlbcam(int index, unsigned long virt, phys
_addr_t phys,
>  
>  	TLBCAM[index].MAS3 = (phys & MAS3_RPN) | MAS3_SX | MAS3_SR;
>  	TLBCAM[index].MAS3 |= ((flags & _PAGE_RW) ? MAS3_SW : 0);
> -	if (cur_cpu_spec->cpu_features & MMU_FTR_BIG_PHYS)
> +	if (cur_cpu_spec->mmu_features & MMU_FTR_BIG_PHYS)

Ditto.

Mikey

>  		TLBCAM[index].MAS7 = (u64)phys >> 32;
>  
>  #ifndef CONFIG_KGDB /* want user access for breakpoints */
> -- 
> 1.6.0.6
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
