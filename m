Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 14AFD2C00BC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Oct 2013 09:37:19 +1100 (EST)
Message-ID: <1382135824.7979.906.camel@snotra.buserror.net>
Subject: Re: [v5][PATCH 1/6] powerpc/book3e: load critical/machine/debug
 exception stack
From: Scott Wood <scottwood@freescale.com>
To: Tiejun Chen <tiejun.chen@windriver.com>
Date: Fri, 18 Oct 2013 17:37:04 -0500
In-Reply-To: <1371724110-8250-2-git-send-email-tiejun.chen@windriver.com>
References: <1371724110-8250-1-git-send-email-tiejun.chen@windriver.com>
 <1371724110-8250-2-git-send-email-tiejun.chen@windriver.com>
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

On Thu, 2013-06-20 at 18:28 +0800, Tiejun Chen wrote:
> We always alloc critical/machine/debug check exceptions. This is
> different from the normal exception. So we should load these exception
> stack properly like we did for booke.

This is "booke".  Do you mean like "like we did for 32-bit"?

And the code is already trying to load the special stack; it just
happens that it's loading from a different location than the C code
placed the stack addresses.  The changelog should point out the specific
thing that is being fixed.

> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
> ---
>  arch/powerpc/kernel/exceptions-64e.S |   49 +++++++++++++++++++++++++++++++---
>  1 file changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
> index 4b23119..4d8e57f 100644
> --- a/arch/powerpc/kernel/exceptions-64e.S
> +++ b/arch/powerpc/kernel/exceptions-64e.S
> @@ -36,6 +36,37 @@
>   */
>  #define	SPECIAL_EXC_FRAME_SIZE	INT_FRAME_SIZE
>  
> +/* only on book3e */
> +#define DBG_STACK_BASE		dbgirq_ctx
> +#define MC_STACK_BASE		mcheckirq_ctx
> +#define CRIT_STACK_BASE		critirq_ctx
> +
> +#ifdef CONFIG_RELOCATABLE
> +#define LOAD_STACK_BASE(reg, level)			\
> +	tovirt(r2,r2);					\
> +	LOAD_REG_ADDR(reg, level##_STACK_BASE);
> +#else
> +#define LOAD_STACK_BASE(reg, level)			\
> +	LOAD_REG_IMMEDIATE(reg, level##_STACK_BASE);
> +#endif
> +
> +#ifdef CONFIG_SMP
> +#define BOOK3E_LOAD_EXC_LEVEL_STACK(level)		\
> +	mfspr	r14,SPRN_PIR;				\
> +	slwi	r14,r14,3;				\
> +	LOAD_STACK_BASE(r10, level);			\
> +	add	r10,r10,r14;				\
> +	ld	r10,0(r10);				\
> +	addi	r10,r10,THREAD_SIZE;			\
> +	std	r10,PACA_##level##_STACK(r13);
> +#else
> +#define BOOK3E_LOAD_EXC_LEVEL_STACK(level)		\
> +	LOAD_STACK_BASE(r10, level);			\
> +	ld	r10,0(r10);				\
> +	addi	r10,r10,THREAD_SIZE;			\
> +	std	r10,PACA_##level##_STACK(r13);
> +#endif

It looks like you're loading the stack from *irq_ctx, storing it in
PACA_*_stack, and then (immediately after this in the caller) loading it
back from PACA_*_STACK.  Why not just load it from *irq_ctx and get rid
of PACA_*_STACK altogether -- or change the C code to initialize the
addresses in the PACA instead, and get ird of *irq_ctx on 64-bit?

>  /* Exception prolog code for all exceptions */
>  #define EXCEPTION_PROLOG(n, intnum, type, addition)	    		    \
>  	mtspr	SPRN_SPRG_##type##_SCRATCH,r13;	/* get spare registers */   \
> @@ -68,20 +99,32 @@
>  #define SPRN_GDBELL_SRR1	SPRN_GSRR1
>  
>  #define CRIT_SET_KSTACK						            \
> +	andi.	r10,r11,MSR_PR;							\
> +	bne	1f;								\
> +	BOOK3E_LOAD_EXC_LEVEL_STACK(CRIT);					\
>  	ld	r1,PACA_CRIT_STACK(r13);				    \
> -	subi	r1,r1,SPECIAL_EXC_FRAME_SIZE;
> +	subi	r1,r1,SPECIAL_EXC_FRAME_SIZE;					\

The caller will already check MSR_PR and override this if coming from
userspace; why do you need to check again here?

-Scott
