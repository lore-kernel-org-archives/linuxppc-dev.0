Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rwqtR5hq9zDrKh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 22:37:51 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id cf3so6924853pad.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 05:37:51 -0700 (PDT)
Date: Fri, 22 Jul 2016 22:37:38 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [for-4.8, 1/2] powerpc/mm: Switch user slb fault handling to
 translation enabled
Message-ID: <20160722223738.62a27fed@roar.ozlabs.ibm.com>
In-Reply-To: <1468402850-6052-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1468402850-6052-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 13 Jul 2016 15:10:49 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> We also handle fault with proper stack initialized. This enable us to
> callout to C in fault handling routines. We don't do this for kernel
> mapping, because of the possibility of taking recursive fault if
> kernel stack in not yet mapped by an slb entry.
> 
> This enable us to handle Power9 slb fault better. We will add bolted
> entries for the entire kernel mapping in segment table and user slb
> entries we take fault and insert on demand. With translation on, we
> should be able to access segment table from fault handler.

What does this cost on P8? Is that a problem? Might need to do
feature bits.

> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/exceptions-64s.S | 55
> ++++++++++++++++++++++++++++++++----
> arch/powerpc/mm/slb.c                | 11 ++++++++ 2 files changed,
> 61 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/exceptions-64s.S
> b/arch/powerpc/kernel/exceptions-64s.S index
> 2747e901fb99..2132bf55573c 100644 ---
> a/arch/powerpc/kernel/exceptions-64s.S +++
> b/arch/powerpc/kernel/exceptions-64s.S @@ -794,7 +794,7 @@
> data_access_slb_relon_pSeries: mfspr	r3,SPRN_DAR
>  	mfspr	r12,SPRN_SRR1
>  #ifndef CONFIG_RELOCATABLE
> -	b	slb_miss_realmode
> +	b	handle_slb_miss_relon
>  #else
>  	/*
>  	 * We can't just use a direct branch to slb_miss_realmode
> @@ -803,7 +803,7 @@ data_access_slb_relon_pSeries:
>  	 */
>  	mfctr	r11
>  	ld	r10,PACAKBASE(r13)
> -	LOAD_HANDLER(r10, slb_miss_realmode)
> +	LOAD_HANDLER(r10, handle_slb_miss_relon)
>  	mtctr	r10
>  	bctr
>  #endif
> @@ -819,11 +819,11 @@ instruction_access_slb_relon_pSeries:
>  	mfspr	r3,SPRN_SRR0		/* SRR0 is faulting
> address */ mfspr	r12,SPRN_SRR1
>  #ifndef CONFIG_RELOCATABLE
> -	b	slb_miss_realmode
> +	b	handle_slb_miss_relon
>  #else
>  	mfctr	r11
>  	ld	r10,PACAKBASE(r13)
> -	LOAD_HANDLER(r10, slb_miss_realmode)
> +	LOAD_HANDLER(r10, handle_slb_miss_relon)
>  	mtctr	r10
>  	bctr
>  #endif
> @@ -961,7 +961,23 @@ h_data_storage_common:
>  	bl      unknown_exception
>  	b       ret_from_except
>  
> +/* r3 point to DAR */
>  	.align	7
> +	.globl slb_miss_user
> +slb_miss_user:
> +	std	r3,PACA_EXSLB+EX_DAR(r13)
> +	/* Restore r3 as expected by PROLOG_COMMON below */
> +	ld	r3,PACA_EXSLB+EX_R3(r13)
> +	EXCEPTION_PROLOG_COMMON(0x380, PACA_EXSLB)
> +	RECONCILE_IRQ_STATE(r10, r11)
> +	ld	r4,PACA_EXSLB+EX_DAR(r13)
> +	li	r5,0x380
> +	std	r4,_DAR(r1)
> +	addi	r3,r1,STACK_FRAME_OVERHEAD
> +	bl	handle_slb_miss
> +	b       ret_from_except_lite
> +
> +        .align	7
>  	.globl instruction_access_common
>  instruction_access_common:
>  	EXCEPTION_PROLOG_COMMON(0x400, PACA_EXGEN)
> @@ -1379,11 +1395,17 @@ unrecover_mce:
>   * We assume we aren't going to take any exceptions during this
> procedure. */
>  slb_miss_realmode:
> -	mflr	r10
>  #ifdef CONFIG_RELOCATABLE
>  	mtctr	r11
>  #endif
> +	/*
> +	 * Handle user slb miss with translation enabled
> +	 */
> +	cmpdi	r3,0
> +	bge	3f
>  
> +slb_miss_kernel:
> +	mflr	r10
>  	stw	r9,PACA_EXSLB+EX_CCR(r13)	/* save CR in
> exc. frame */ std	r10,PACA_EXSLB+EX_LR(r13)	/* save LR
> */ 
> @@ -1429,6 +1451,29 @@
> ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX) mtspr
> SPRN_SRR1,r10 rfid
>  	b	.
> +3:
> +	/*
> +	 * Enable IR/DR and handle the fault
> +	 */
> +	EXCEPTION_PROLOG_PSERIES_1(slb_miss_user, EXC_STD)
> +	/*
> +	 * handler with relocation on
> +	 */
> +handle_slb_miss_relon:
> +#ifdef CONFIG_RELOCATABLE
> +	mtctr	r11
> +#endif

This is turning into a bit of spaghetti. I think it can be
improved though.

I have a patch that I think can save a few instructions in the
relocatable case for SLB miss. I think that may give enough space
inline to branch to the correct handler. I should submit it soon.


> +	/*
> +	 * Handle user slb miss with stack initialized.
> +	 */
> +	cmpdi	r3,0
> +	bge	4f
> +	/*
> +	 * go back to slb_miss_realmode
> +	 */

Are these comments adding much? I think if the names of some of the
labels was improved, you might find they're not necessary. Some
existing labels like slb_miss_realmode don't help too much either. That
handler runs in real and virtual mode, and now the realmode exception
can go elsewhere too.


> +	b	slb_miss_kernel

blt    slb_miss_kernel?


> +4:
> +	EXCEPTION_RELON_PROLOG_PSERIES_1(slb_miss_user, EXC_STD)
