Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DF12ADE1EE
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Dec 2007 03:49:15 +1100 (EST)
Message-Id: <7AF0D992-6B4E-475C-949B-FAE4DDE03D3A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Dale Farnsworth <dale@farnsworth.org>
In-Reply-To: <20071122154619.GA26471@xyzzy.farnsworth.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 05/10] powerpc: Add crash kernel support for 85xx
Date: Fri, 14 Dec 2007 10:48:58 -0600
References: <20071122154619.GA26471@xyzzy.farnsworth.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 22, 2007, at 9:46 AM, Dale Farnsworth wrote:

> Add the ability to build a ppc_85xx kernel to run at a physical
> address of 32MB.
>
> Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
> ---
> arch/powerpc/Kconfig                 |    2 +-
> arch/powerpc/kernel/head_fsl_booke.S |   23 ++++++++++++++++++-----
> arch/powerpc/mm/fsl_booke_mmu.c      |    6 +++---
> 3 files changed, 22 insertions(+), 9 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 805b4d1..d405298 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -253,7 +253,7 @@ config KEXEC
>
> config CRASH_DUMP
> 	bool "Build a kdump crash kernel (EXPERIMENTAL)"
> -	depends on PPC_MULTIPLATFORM && EXPERIMENTAL
> +	depends on (PPC_MULTIPLATFORM || PPC_85xx) && EXPERIMENTAL
> 	help
> 	  Build a kernel suitable for use as a kdump capture kernel.
> 	  The kernel will be linked at a different address than normal, and
> diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/ 
> kernel/head_fsl_booke.S
> index 4b98227..1c9685f 100644
> --- a/arch/powerpc/kernel/head_fsl_booke.S
> +++ b/arch/powerpc/kernel/head_fsl_booke.S
> @@ -41,6 +41,12 @@
> #include <asm/asm-offsets.h>
> #include "head_booke.h"
>
> +#ifdef CONFIG_CRASH_DUMP
> +#define INITIAL_BOOKE_PAGESZ (BOOKE_PAGESZ_64M)
> +#else
> +#define INITIAL_BOOKE_PAGESZ (BOOKE_PAGESZ_16M)
> +#endif

I'm ok with bumping the first page to 64M in all cases.

>
> +
> /* As with the other PowerPC ports, it is expected that when code
>  * execution begins here, the following registers contain valid, yet
>  * optional, information:
> @@ -75,6 +81,7 @@ _ENTRY(_start);
>  * boot loader and load a single entry in TLB1[0] to map the
>  * first 16M of kernel memory.  Any boot info passed from the
>  * bootloader needs to live in this first 16M.
> + * Note that for crash (kdump) kernels, the first 64M is mapped.
>  *
>  * Requirement on bootloader:
>  *  - The page we're executing in needs to reside in TLB1 and
> @@ -167,7 +174,7 @@ skpinv:	addi	r6,r6,1				/* Increment */
> 	mtspr	SPRN_MAS0,r7
> 	tlbre
>
> -	/* Just modify the entry ID and EPN for the temp mapping */
> +	/* Just modify the entry ID, EPN and RPN for the temp mapping */
> 	lis	r7,0x1000	/* Set MAS0(TLBSEL) = 1 */
> 	rlwimi	r7,r5,16,4,15	/* Setup MAS0 = TLBSEL | ESEL(r5) */
> 	mtspr	SPRN_MAS0,r7
> @@ -177,9 +184,12 @@ skpinv:	addi	r6,r6,1				/* Increment */
> 	ori	r6,r6,(MAS1_TSIZE(BOOKE_PAGESZ_4K))@l
> 	mtspr	SPRN_MAS1,r6
> 	mfspr	r6,SPRN_MAS2
> -	li	r7,0		/* temp EPN = 0 */
> +	lis	r7,PHYSICAL_START@h
> 	rlwimi	r7,r6,0,20,31
> 	mtspr	SPRN_MAS2,r7
> +	mfspr	r6,SPRN_MAS3
> +	rlwimi	r7,r6,0,20,31
> +	mtspr	SPRN_MAS3,r7
> 	tlbwe
>
> 	xori	r6,r4,1
> @@ -222,11 +232,11 @@ skpinv:	addi	r6,r6,1				/* Increment */
> 	lis	r6,0x1000		/* Set MAS0(TLBSEL) = TLB1(1), ESEL = 0 */
> 	mtspr	SPRN_MAS0,r6
> 	lis	r6,(MAS1_VALID|MAS1_IPROT)@h
> -	ori	r6,r6,(MAS1_TSIZE(BOOKE_PAGESZ_16M))@l
> +	ori	r6,r6,(MAS1_TSIZE(INITIAL_BOOKE_PAGESZ))@l
> 	mtspr	SPRN_MAS1,r6
> 	li	r7,0
> -	lis	r6,KERNELBASE@h
> -	ori	r6,r6,KERNELBASE@l
> +	lis	r6,PAGE_OFFSET@h
> +	ori	r6,r6,PAGE_OFFSET@l
> 	rlwimi	r6,r7,0,20,31
> 	mtspr	SPRN_MAS2,r6
> 	li	r7,(MAS3_SX|MAS3_SW|MAS3_SR)
> @@ -234,6 +244,9 @@ skpinv:	addi	r6,r6,1				/* Increment */
> 	tlbwe
>
> /* 7. Jump to KERNELBASE mapping */
> +	lis	r6,KERNELBASE@h
> +	ori	r6,r6,KERNELBASE@l
> +	rlwimi	r6,r7,0,20,31
> 	lis	r7,MSR_KERNEL@h
> 	ori	r7,r7,MSR_KERNEL@l
> 	bl	1f			/* Find our address */
> diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/ 
> fsl_booke_mmu.c
> index 17139da..c93a966 100644
> --- a/arch/powerpc/mm/fsl_booke_mmu.c
> +++ b/arch/powerpc/mm/fsl_booke_mmu.c
> @@ -165,15 +165,15 @@ void invalidate_tlbcam_entry(int index)
> void __init cam_mapin_ram(unsigned long cam0, unsigned long cam1,
> 		unsigned long cam2)
> {
> -	settlbcam(0, KERNELBASE, PPC_MEMSTART, cam0, _PAGE_KERNEL, 0);
> +	settlbcam(0, PAGE_OFFSET, PPC_MEMSTART, cam0, _PAGE_KERNEL, 0);
> 	tlbcam_index++;
> 	if (cam1) {
> 		tlbcam_index++;
> -		settlbcam(1, KERNELBASE+cam0, PPC_MEMSTART+cam0, cam1,  
> _PAGE_KERNEL, 0);
> +		settlbcam(1, PAGE_OFFSET+cam0, PPC_MEMSTART+cam0, cam1,  
> _PAGE_KERNEL, 0);
> 	}
> 	if (cam2) {
> 		tlbcam_index++;
> -		settlbcam(2, KERNELBASE+cam0+cam1, PPC_MEMSTART+cam0+cam1, cam2,  
> _PAGE_KERNEL, 0);
> +		settlbcam(2, PAGE_OFFSET+cam0+cam1, PPC_MEMSTART+cam0+cam1, cam2,  
> _PAGE_KERNEL, 0);
> 	}
> }

The rest looks good.  Does this mean we can boot a e500 kernel at a  
non-zero physical address?  (can we run or is the non-zero phy just  
for a short period of init time).

- k
