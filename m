Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2F92B2C0080
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2013 15:02:54 +1100 (EST)
Message-ID: <1359000165.29726.10.camel@pasglop>
Subject: Re: [v0][PATCH 1/1] powerpc/book3e: disable interrupt after
 preempt_schedule_irq
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tiejun Chen <tiejun.chen@windriver.com>
Date: Thu, 24 Jan 2013 15:02:45 +1100
In-Reply-To: <1357469374-25719-1-git-send-email-tiejun.chen@windriver.com>
References: <1357469374-25719-1-git-send-email-tiejun.chen@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2013-01-06 at 18:49 +0800, Tiejun Chen wrote:
> In preempt case current arch_local_irq_restore() from
> preempt_schedule_irq() may enable hard interrupt but we really
> should disable interrupts when we return from the interrupt,
> and so that we don't get interrupted after loading SRR0/1.

This is an excellent catch, thanks !

Cheers,
Ben.

> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
> ---
>  arch/powerpc/kernel/entry_64.S |   13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index e9a906c..4e1de34 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -662,6 +662,19 @@ resume_kernel:
>  	ld	r4,TI_FLAGS(r9)
>  	andi.	r0,r4,_TIF_NEED_RESCHED
>  	bne	1b
> +
> +	/*
> +	 * arch_local_irq_restore() from preempt_schedule_irq above may
> +	 * enable hard interrupt but we really should disable interrupts
> +	 * when we return from the interrupt, and so that we don't get
> +	 * interrupted after loading SRR0/1.
> +	 */
> +#ifdef CONFIG_PPC_BOOK3E
> +	wrteei	0
> +#else
> +	ld	r10,PACAKMSR(r13) /* Get kernel MSR without EE */
> +	mtmsrd	r10,1		  /* Update machine state */
> +#endif /* CONFIG_PPC_BOOK3E */
>  #endif /* CONFIG_PREEMPT */
>  
>  	.globl	fast_exc_return_irq
