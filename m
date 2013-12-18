Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0188.outbound.protection.outlook.com [207.46.163.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 194022C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Dec 2013 14:30:07 +1100 (EST)
Message-ID: <1387337393.3140.27.camel@snotra.buserror.net>
Subject: Re: [v3][PATCH 2/8] powerpc/book3e: support CONFIG_RELOCATABLE
From: Scott Wood <scottwood@freescale.com>
To: Tiejun Chen <tiejun.chen@windriver.com>
Date: Tue, 17 Dec 2013 21:29:53 -0600
In-Reply-To: <1373357007-30785-3-git-send-email-tiejun.chen@windriver.com>
References: <1373357007-30785-1-git-send-email-tiejun.chen@windriver.com>
 <1373357007-30785-3-git-send-email-tiejun.chen@windriver.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-07-09 at 16:03 +0800, Tiejun Chen wrote:
> book3e is different with book3s since 3s includes the exception
> vectors code in head_64.S as it relies on absolute addressing
> which is only possible within this compilation unit. So we have
> to get that label address with got.
> 
> And when boot a relocated kernel, we should reset ipvr properly again
> after .relocate.

ivpr?

> 
> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
> ---
>  arch/powerpc/include/asm/exception-64e.h |   11 +++++++++++
>  arch/powerpc/kernel/exceptions-64e.S     |   18 +++++++++++++++++-
>  arch/powerpc/kernel/head_64.S            |   25 +++++++++++++++++++++++++
>  3 files changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/exception-64e.h b/arch/powerpc/include/asm/exception-64e.h
> index 51fa43e..371a77f 100644
> --- a/arch/powerpc/include/asm/exception-64e.h
> +++ b/arch/powerpc/include/asm/exception-64e.h
> @@ -214,10 +214,21 @@ exc_##label##_book3e:
>  #define TLB_MISS_STATS_SAVE_INFO_BOLTED
>  #endif
>  
> +#ifndef CONFIG_RELOCATABLE

Please use positive logic (ifdef/else, rather than ifndef/else).

>  #define SET_IVOR(vector_number, vector_offset)	\
>  	li	r3,vector_offset@l; 		\
>  	ori	r3,r3,interrupt_base_book3e@l;	\
>  	mtspr	SPRN_IVOR##vector_number,r3;
> +#else /* !CONFIG_RELOCATABLE */
> +/* In relocatable case the value of the constant expression 'expr' is only
> + * offset. So instead, we should loads the address of label 'name'.
> + */
> +#define SET_IVOR(vector_number, vector_offset)	\
> +	LOAD_REG_ADDR(r3,interrupt_base_book3e);\
> +	rlwinm	r3,r3,0,15,0;			\
> +	ori	r3,r3,vector_offset@l;		\
> +	mtspr	SPRN_IVOR##vector_number,r3;
> +#endif /* CONFIG_RELOCATABLE */

Please use the more readable 4-operand version of "rlwinm".

Is there a reason why this new code is only used with
CONFIG_RELOCATABLE?  If @got doesn't work without CONFIG_RELOCATABLE,
then the ifdef should be pushed into LOAD_REG_ADDR.

Likewise with other ifdefs on CONFIG_RELOCATABLE.

> -_STATIC(init_core_book3e)
> +_GLOBAL(init_core_book3e)
>  	/* Establish the interrupt vector base */
> +#ifdef CONFIG_RELOCATABLE
> +/* In relocatable case the value of the constant expression 'expr' is only
> + * offset. So instead, we should loads the address of label 'name'.
> + */
> +	tovirt(r2,r2)
> +	LOAD_REG_ADDR(r3, interrupt_base_book3e)
> +#else
>  	LOAD_REG_IMMEDIATE(r3, interrupt_base_book3e)
> +#endif

I'm having a hard time parsing the comment.  Plus, it feels wrong to
decouple tovirt(r2,r2) from the call to relative_toc.

>  	mtspr	SPRN_IVPR,r3
>  	sync
>  	blr
> diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
> index b61363d..550f8fb 100644
> --- a/arch/powerpc/kernel/head_64.S
> +++ b/arch/powerpc/kernel/head_64.S
> @@ -414,12 +414,25 @@ _STATIC(__after_prom_start)
>  	/* process relocations for the final address of the kernel */
>  	lis	r25,PAGE_OFFSET@highest	/* compute virtual base of kernel */
>  	sldi	r25,r25,32
> +#if defined(CONFIG_PPC_BOOK3E)
> +	tovirt(r26,r26)			/* on booke, we already run at PAGE_OFFSET */
> +#endif
>  	lwz	r7,__run_at_load-_stext(r26)
> +#if defined(CONFIG_PPC_BOOK3E)
> +	tophys(r26,r26)			/* Restore for the remains. */
> +#endif
>  	cmplwi	cr0,r7,1	/* flagged to stay where we are ? */
>  	bne	1f
>  	add	r25,r25,r26
>  1:	mr	r3,r25
>  	bl	.relocate
> +#if defined(CONFIG_PPC_BOOK3E)
> +	/* In relocatable case we always have to load the address of label 'name'
> +	 * to set IVPR. So after .relocate we have to update IVPR with current
> +	 * address of label.
> +	 */
> +	bl	.init_core_book3e
> +#endif

Maybe this function should be renamed to something ivpr-specific, so
nothing else gets added there.

>  #endif
>  
>  /*
> @@ -447,12 +460,24 @@ _STATIC(__after_prom_start)
>   * variable __run_at_load, if it is set the kernel is treated as relocatable
>   * kernel, otherwise it will be moved to PHYSICAL_START
>   */
> +#if defined(CONFIG_PPC_BOOK3E)
> +	tovirt(r26,r26)			/* on booke, we already run at PAGE_OFFSET */
> +#endif
>  	lwz	r7,__run_at_load-_stext(r26)
> +#if defined(CONFIG_PPC_BOOK3E)
> +	tophys(r26,r26)			/* Restore for the remains. */
> +#endif
>  	cmplwi	cr0,r7,1
>  	bne	3f
>  
> +#ifdef CONFIG_PPC_BOOK3E
> +	LOAD_REG_ADDR(r5, __end_interrupts)
> +	LOAD_REG_ADDR(r11, _stext)
> +	sub	r5,r5,r11
> +#else
>  	/* just copy interrupts */
>  	LOAD_REG_IMMEDIATE(r5, __end_interrupts - _stext)
> +#endif

Can't we skip the interrupt copying on book3e?  And if not for some
reason, why start at _stext?

-Scott
