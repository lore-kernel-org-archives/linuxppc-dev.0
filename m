Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0963EDDDB6
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Mar 2009 08:25:34 +1100 (EST)
Subject: Re: [RFC][PATCH v3] powerpc: e300c2/c3/c4 TLB errata workaround
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1236957383-20240-1-git-send-email-galak@kernel.crashing.org>
References: <1236957383-20240-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain
Date: Sat, 14 Mar 2009 08:25:19 +1100
Message-Id: <1236979519.25062.53.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, david.jander@protonic.nl, wd@denx.de,
	gunnar@genesi-usa.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2009-03-13 at 10:16 -0500, Kumar Gala wrote:
> From: David Jander <david.jander@protonic.nl>
> 
> Complete workaround for DTLB errata in e300c2/c3/c4 processors.
> 
> Due to the bug, the hardware-implemented LRU algorythm always goes to way
> 1 of the TLB. This fix implements the proposed software workaround in
> form of a LRW table for chosing the TLB-way.
> 
> Signed-off-by: David Jander <david@protonic.nl>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> 
> Added cpu feature support.. need to check with Ben if we should use a MMU feature instead

Yes, we should...

Cheers,
Ben.

> - k
> 
>  arch/powerpc/include/asm/cputable.h |    7 +++-
>  arch/powerpc/kernel/cputable.c      |    4 +-
>  arch/powerpc/kernel/head_32.S       |   61 +++++++++++++++++++++++++++++++++++
>  3 files changed, 69 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
> index fca1611..42e3145 100644
> --- a/arch/powerpc/include/asm/cputable.h
> +++ b/arch/powerpc/include/asm/cputable.h
> @@ -152,6 +152,7 @@ extern const char *powerpc_base_platform;
>  #define CPU_FTR_NAP_DISABLE_L2_PR	ASM_CONST(0x0000000000002000)
>  #define CPU_FTR_DUAL_PLL_750FX		ASM_CONST(0x0000000000004000)
>  #define CPU_FTR_NO_DPM			ASM_CONST(0x0000000000008000)
> +#define CPU_FTR_NEED_DTLB_SW_LRU	ASM_CONST(0x0000000000010000)
>  #define CPU_FTR_NEED_COHERENT		ASM_CONST(0x0000000000020000)
>  #define CPU_FTR_NO_BTIC			ASM_CONST(0x0000000000040000)
>  #define CPU_FTR_NODSISRALIGN		ASM_CONST(0x0000000000100000)
> @@ -356,7 +357,11 @@ extern const char *powerpc_base_platform;
>  	    CPU_FTR_COMMON)
>  #define CPU_FTRS_E300C2	(CPU_FTR_MAYBE_CAN_DOZE | \
>  	    CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP | \
> -	    CPU_FTR_COMMON | CPU_FTR_FPU_UNAVAILABLE)
> +	    CPU_FTR_COMMON | CPU_FTR_FPU_UNAVAILABLE | \
> +	    CPU_FTR_NEED_DTLB_SW_LRU)
> +#define CPU_FTRS_E300C3	(CPU_FTR_MAYBE_CAN_DOZE | \
> +	    CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP | \
> +	    CPU_FTR_COMMON | CPU_FTR_NEED_DTLB_SW_LRU)
>  #define CPU_FTRS_CLASSIC32	(CPU_FTR_COMMON | CPU_FTR_USE_TB)
>  #define CPU_FTRS_8XX	(CPU_FTR_USE_TB)
>  #define CPU_FTRS_40X	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE)
> diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
> index ccea243..039452c 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -1101,7 +1101,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
>  		.pvr_mask		= 0x7fff0000,
>  		.pvr_value		= 0x00850000,
>  		.cpu_name		= "e300c3",
> -		.cpu_features		= CPU_FTRS_E300,
> +		.cpu_features		= CPU_FTRS_E300C3,
>  		.cpu_user_features	= COMMON_USER,
>  		.mmu_features		= MMU_FTR_USE_HIGH_BATS,
>  		.icache_bsize		= 32,
> @@ -1116,7 +1116,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
>  		.pvr_mask		= 0x7fff0000,
>  		.pvr_value		= 0x00860000,
>  		.cpu_name		= "e300c4",
> -		.cpu_features		= CPU_FTRS_E300,
> +		.cpu_features		= CPU_FTRS_E300C3,
>  		.cpu_user_features	= COMMON_USER,
>  		.mmu_features		= MMU_FTR_USE_HIGH_BATS,
>  		.icache_bsize		= 32,
> diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
> index f8c2e6b..eecae0d 100644
> --- a/arch/powerpc/kernel/head_32.S
> +++ b/arch/powerpc/kernel/head_32.S
> @@ -554,6 +554,10 @@ DataLoadTLBMiss:
>   * r2:	ptr to linux-style pte
>   * r3:	scratch
>   */
> +BEGIN_FTR_SECTION
> +	b      TlbWo    /* Code for TLB-errata workaround doesn't fit here */
> +END_FTR_SECTION_IFSET(CPU_FTR_NEED_DTLB_SW_LRU)
> +RFTlbWo:
>  	mfctr	r0
>  	/* Get PTE (linux-style) and check access */
>  	mfspr	r3,SPRN_DMISS
> @@ -626,6 +630,31 @@ DataStoreTLBMiss:
>   * r2:	ptr to linux-style pte
>   * r3:	scratch
>   */
> +BEGIN_FTR_SECTION
> +/* MPC512x: workaround for errata in die M36P and earlier:
> + * Implement LRW for TLB way.
> + */
> +       mfspr   r3,SPRN_DMISS
> +       rlwinm  r3,r3,19,25,29 /* Get Address bits 19:15 */
> +       lis     r2,lrw@ha       /* Search index in lrw[] */
> +       addi    r2,r2,lrw@l
> +       tophys(r2,r2)
> +       lwzx    r1,r3,r2       /* Get item from lrw[] */
> +       cmpwi   0,r1,0         /* Was it way 0 last time? */
> +       beq-    0,113f         /* Then goto 113: */
> +
> +       mfspr   r1,SPRN_SRR1
> +       rlwinm  r1,r1,0,15,13  /* Mask out SRR1[WAY] */
> +       mtspr   SPRN_SRR1,r1
> +
> +       li      r0,0
> +       stwx    r0,r3,r2       /* Make lrw[] entry 0 */
> +       b       114f
> +113:
> +       li      r0,1
> +       stwx    r0,r3,r2       /* Make lrw[] entry 1 */
> +114:
> +END_FTR_SECTION_IFSET(CPU_FTR_NEED_DTLB_SW_LRU)
>  	mfctr	r0
>  	/* Get PTE (linux-style) and check access */
>  	mfspr	r3,SPRN_DMISS
> @@ -813,6 +842,32 @@ giveup_altivec:
>  	blr
>  #endif /* CONFIG_ALTIVEC */
>  
> +TlbWo:
> +/* MPC512x: workaround for errata in die M36P and earlier:
> + * Implement LRW for TLB way.
> + */
> +       mfspr   r3,SPRN_DMISS
> +       rlwinm  r3,r3,19,25,29 /* Get Address bits 19:15 */
> +       lis     r2,lrw@ha       /* Search index in lrw[] */
> +       addi    r2,r2,lrw@l
> +       tophys(r2,r2)
> +       lwzx    r1,r3,r2       /* Get item from lrw[] */
> +       cmpwi   0,r1,0         /* Was it way 0 last time? */
> +       beq-    0,113f         /* Then goto 113: */
> +
> +       mfspr   r1,SPRN_SRR1
> +       rlwinm  r1,r1,0,15,13  /* Mask out SRR1[WAY] */
> +       mtspr   SPRN_SRR1,r1
> +
> +       li      r0,0
> +       stwx    r0,r3,r2       /* Make lrw[] entry 0 */
> +       b       114f
> +113:
> +       li      r0,1
> +       stwx    r0,r3,r2       /* Make lrw[] entry 1 */
> +114:
> +       b       RFTlbWo
> +
>  /*
>   * This code is jumped to from the startup code to copy
>   * the kernel image to physical address PHYSICAL_START.
> @@ -1328,6 +1383,12 @@ intercept_table:
>  	.long 0, 0, 0, 0, 0, 0, 0, 0
>  	.long 0, 0, 0, 0, 0, 0, 0, 0
>  
> +lrw:
> +       .long 0, 0, 0, 0, 0, 0, 0, 0
> +       .long 0, 0, 0, 0, 0, 0, 0, 0
> +       .long 0, 0, 0, 0, 0, 0, 0, 0
> +       .long 0, 0, 0, 0, 0, 0, 0, 0
> +
>  /* Room for two PTE pointers, usually the kernel and current user pointers
>   * to their respective root page table.
>   */
