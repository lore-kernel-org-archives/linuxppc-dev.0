Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0185.outbound.protection.outlook.com [207.46.163.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 955B72C0092
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jan 2014 10:30:36 +1100 (EST)
Message-ID: <1389742224.24905.140.camel@snotra.buserror.net>
Subject: Re: [PATCH 3/3] powerpc/fsl: Use the new interface to save or
 restore registers
From: Scott Wood <scottwood@freescale.com>
To: Dongsheng Wang <dongsheng.wang@freescale.com>
Date: Tue, 14 Jan 2014 17:30:24 -0600
In-Reply-To: <1389686397-46555-3-git-send-email-dongsheng.wang@freescale.com>
References: <1389686397-46555-1-git-send-email-dongsheng.wang@freescale.com>
 <1389686397-46555-3-git-send-email-dongsheng.wang@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: anton@enomsg.org, linuxppc-dev@lists.ozlabs.org, chenhui.zhao@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-01-14 at 15:59 +0800, Dongsheng Wang wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> Use fsl_cpu_state_save/fsl_cpu_state_restore to save/restore registers.
> Use the functions to save/restore registers, so we don't need to
> maintain the code.
> 
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>

Is there any functional change with this patchset (e.g. suspend
supported on chips where it wasn't before), or is it just cleanup?  A
cover letter would be useful to describe the purpose of the overall
patchset when it isn't obvious.

> 
> diff --git a/arch/powerpc/kernel/swsusp_booke.S b/arch/powerpc/kernel/swsusp_booke.S
> index 553c140..b5992db 100644
> --- a/arch/powerpc/kernel/swsusp_booke.S
> +++ b/arch/powerpc/kernel/swsusp_booke.S
> @@ -4,92 +4,28 @@
>   * Copyright (c) 2009-2010 MontaVista Software, LLC.
>   */
>  
> -#include <linux/threads.h>
> -#include <asm/processor.h>
>  #include <asm/page.h>
> -#include <asm/cputable.h>
> -#include <asm/thread_info.h>
>  #include <asm/ppc_asm.h>
>  #include <asm/asm-offsets.h>
>  #include <asm/mmu.h>
> -
> -/*
> - * Structure for storing CPU registers on the save area.
> - */
> -#define SL_SP		0
> -#define SL_PC		4
> -#define SL_MSR		8
> -#define SL_TCR		0xc
> -#define SL_SPRG0	0x10
> -#define SL_SPRG1	0x14
> -#define SL_SPRG2	0x18
> -#define SL_SPRG3	0x1c
> -#define SL_SPRG4	0x20
> -#define SL_SPRG5	0x24
> -#define SL_SPRG6	0x28
> -#define SL_SPRG7	0x2c
> -#define SL_TBU		0x30
> -#define SL_TBL		0x34
> -#define SL_R2		0x38
> -#define SL_CR		0x3c
> -#define SL_LR		0x40
> -#define SL_R12		0x44	/* r12 to r31 */
> -#define SL_SIZE		(SL_R12 + 80)
> -
> -	.section .data
> -	.align	5
> -
> -_GLOBAL(swsusp_save_area)
> -	.space	SL_SIZE
> -
> +#include <asm/fsl_sleep.h>
>  
>  	.section .text
>  	.align	5
>  
>  _GLOBAL(swsusp_arch_suspend)
> -	lis	r11,swsusp_save_area@h
> -	ori	r11,r11,swsusp_save_area@l
> -
> -	mflr	r0
> -	stw	r0,SL_LR(r11)
> -	mfcr	r0
> -	stw	r0,SL_CR(r11)
> -	stw	r1,SL_SP(r11)
> -	stw	r2,SL_R2(r11)
> -	stmw	r12,SL_R12(r11)
> -
> -	/* Save MSR & TCR */
> -	mfmsr	r4
> -	stw	r4,SL_MSR(r11)
> -	mfspr	r4,SPRN_TCR
> -	stw	r4,SL_TCR(r11)
> -
> -	/* Get a stable timebase and save it */
> -1:	mfspr	r4,SPRN_TBRU
> -	stw	r4,SL_TBU(r11)
> -	mfspr	r5,SPRN_TBRL
> -	stw	r5,SL_TBL(r11)
> -	mfspr	r3,SPRN_TBRU
> -	cmpw	r3,r4
> -	bne	1b
> +	mflr	r15
> +	lis	r3, core_registers_save_area@h
> +	ori	r3, r3, core_registers_save_area@l
> +
> +	/* Save base register */
> +	li	r4, 0
> +	bl	fsl_cpu_state_save
>  
> -	/* Save SPRGs */
> -	mfspr	r4,SPRN_SPRG0
> -	stw	r4,SL_SPRG0(r11)
> -	mfspr	r4,SPRN_SPRG1
> -	stw	r4,SL_SPRG1(r11)
> -	mfspr	r4,SPRN_SPRG2
> -	stw	r4,SL_SPRG2(r11)
> -	mfspr	r4,SPRN_SPRG3
> -	stw	r4,SL_SPRG3(r11)
> -	mfspr	r4,SPRN_SPRG4
> -	stw	r4,SL_SPRG4(r11)
> -	mfspr	r4,SPRN_SPRG5
> -	stw	r4,SL_SPRG5(r11)
> -	mfspr	r4,SPRN_SPRG6
> -	stw	r4,SL_SPRG6(r11)
> -	mfspr	r4,SPRN_SPRG7
> -	stw	r4,SL_SPRG7(r11)
> +	/* Save LR */
> +	lis	r3, core_registers_save_area@h
> +	ori	r3, r3, core_registers_save_area@l
> +	stw	r15, SR_LR(r3)
>  
>  	/* Call the low level suspend stuff (we should probably have made
>  	 * a stackframe...
> @@ -97,11 +33,12 @@ _GLOBAL(swsusp_arch_suspend)
>  	bl	swsusp_save
>  
>  	/* Restore LR from the save area */
> -	lis	r11,swsusp_save_area@h
> -	ori	r11,r11,swsusp_save_area@l
> -	lwz	r0,SL_LR(r11)
> -	mtlr	r0
> +	lis	r3, core_registers_save_area@h
> +	ori	r3, r3, core_registers_save_area@l
> +	lwz	r15, SR_LR(r3)
> +	mtlr	r15
>  
> +	li	r3, 0
>  	blr
>  
>  _GLOBAL(swsusp_arch_resume)
> @@ -138,9 +75,6 @@ _GLOBAL(swsusp_arch_resume)
>  	bl flush_dcache_L1
>  	bl flush_instruction_cache
>  
> -	lis	r11,swsusp_save_area@h
> -	ori	r11,r11,swsusp_save_area@l
> -
>  	/*
>  	 * Mappings from virtual addresses to physical addresses may be
>  	 * different than they were prior to restoring hibernation state. 
> @@ -149,53 +83,12 @@ _GLOBAL(swsusp_arch_resume)
>  	 */
>  	bl	_tlbil_all
>  
> -	lwz	r4,SL_SPRG0(r11)
> -	mtspr	SPRN_SPRG0,r4
> -	lwz	r4,SL_SPRG1(r11)
> -	mtspr	SPRN_SPRG1,r4
> -	lwz	r4,SL_SPRG2(r11)
> -	mtspr	SPRN_SPRG2,r4
> -	lwz	r4,SL_SPRG3(r11)
> -	mtspr	SPRN_SPRG3,r4
> -	lwz	r4,SL_SPRG4(r11)
> -	mtspr	SPRN_SPRG4,r4
> -	lwz	r4,SL_SPRG5(r11)
> -	mtspr	SPRN_SPRG5,r4
> -	lwz	r4,SL_SPRG6(r11)
> -	mtspr	SPRN_SPRG6,r4
> -	lwz	r4,SL_SPRG7(r11)
> -	mtspr	SPRN_SPRG7,r4
> -
> -	/* restore the MSR */
> -	lwz	r3,SL_MSR(r11)
> -	mtmsr	r3
> -
> -	/* Restore TB */
> -	li	r3,0
> -	mtspr	SPRN_TBWL,r3
> -	lwz	r3,SL_TBU(r11)
> -	lwz	r4,SL_TBL(r11)
> -	mtspr	SPRN_TBWU,r3
> -	mtspr	SPRN_TBWL,r4
> -
> -	/* Restore TCR and clear any pending bits in TSR. */
> -	lwz	r4,SL_TCR(r11)
> -	mtspr	SPRN_TCR,r4
> -	lis	r4, (TSR_ENW | TSR_WIS | TSR_DIS | TSR_FIS)@h
> -	mtspr	SPRN_TSR,r4
> -
> -	/* Kick decrementer */
> -	li	r0,1
> -	mtdec	r0
> -
> -	/* Restore the callee-saved registers and return */
> -	lwz	r0,SL_CR(r11)
> -	mtcr	r0
> -	lwz	r2,SL_R2(r11)
> -	lmw	r12,SL_R12(r11)
> -	lwz	r1,SL_SP(r11)
> -	lwz	r0,SL_LR(r11)
> -	mtlr	r0
> +	lis	r3, core_registers_save_area@h
> +	ori	r3, r3, core_registers_save_area@l
> +
> +	/* Restore base register */
> +	li	r4, 0
> +	bl	fsl_cpu_state_restore

Why are you calling anything with "fsl" in the name from code that is
supposed to be for all booke?

-Scott
