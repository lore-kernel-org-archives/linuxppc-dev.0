Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 64C9A2C008E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Oct 2013 09:57:23 +1100 (EST)
Message-ID: <1382137030.7979.914.camel@snotra.buserror.net>
Subject: Re: [v5][PATCH 3/6] book3e/kgdb: update thread's dbcr0
From: Scott Wood <scottwood@freescale.com>
To: Tiejun Chen <tiejun.chen@windriver.com>
Date: Fri, 18 Oct 2013 17:57:10 -0500
In-Reply-To: <1371724110-8250-4-git-send-email-tiejun.chen@windriver.com>
References: <1371724110-8250-1-git-send-email-tiejun.chen@windriver.com>
 <1371724110-8250-4-git-send-email-tiejun.chen@windriver.com>
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
> gdb always need to generate a single step properly to invoke
> a kgdb state. But with lazy interrupt, book3e can't always
> trigger a debug exception with a single step since the current
> is blocked for handling those pending exception, then we miss
> that expected dbcr configuration at last to generate a debug
> exception.

What do you mean by "the current is blocked"?  Could you explain more
clearly what lazy EE has to do with MSR_DE and DBCR0?

> So here we also update thread's dbcr0 to make sure the current
> can go back with that missed dbcr0 configuration.
> 
> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
> ---
>  arch/powerpc/kernel/kgdb.c |   13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
> index c1eef24..55409ac 100644
> --- a/arch/powerpc/kernel/kgdb.c
> +++ b/arch/powerpc/kernel/kgdb.c
> @@ -410,7 +410,7 @@ int kgdb_arch_handle_exception(int vector, int signo, int err_code,
>  			       struct pt_regs *linux_regs)
>  {
>  	char *ptr = &remcom_in_buffer[1];
> -	unsigned long addr;
> +	unsigned long addr, dbcr0;
>  
>  	switch (remcom_in_buffer[0]) {
>  		/*
> @@ -427,8 +427,15 @@ int kgdb_arch_handle_exception(int vector, int signo, int err_code,
>  		/* set the trace bit if we're stepping */
>  		if (remcom_in_buffer[0] == 's') {
>  #ifdef CONFIG_PPC_ADV_DEBUG_REGS
> -			mtspr(SPRN_DBCR0,
> -			      mfspr(SPRN_DBCR0) | DBCR0_IC | DBCR0_IDM);
> +			dbcr0 = mfspr(SPRN_DBCR0) | DBCR0_IC | DBCR0_IDM;
> +			mtspr(SPRN_DBCR0, dbcr0);
> +#ifdef CONFIG_PPC_BOOK3E_64

This could as well be "CONFIG_PPC64" -- CONFIG_PPC_ADV_DEBUG_REGS
implies booke or 40x.  Lazy EE is a CONFIG_PPC64 thing, not specifically
CONFIG_PPC_BOOK3E_64.

> +			/* With lazy interrut we have to update thread dbcr0 here

s/interrut/interrupts/

> +			 * to make sure we can set debug properly at last to invoke
> +			 * kgdb again to work well.
> +			 */
> +			current->thread.dbcr0 = dbcr0;
> +#endif
>  			linux_regs->msr |= MSR_DE;
>  #else
>  			linux_regs->msr |= MSR_SE;

Hmm, what happens here if we enable KGDB on booke without
CONFIG_PPC_ADV_DEBUG_REGS?  Kconfig doesn't appear to prevent it.

-Scott
