Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E540EB7B69
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 24 Sep 2009 07:34:42 +1000 (EST)
Subject: Re: [PATCH 2/2] powerpc/44x: Fix xmon single step on PowerPC 44x
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20090923135156.GH14261@zod.rchland.ibm.com>
References: <20090923134844.GF14261@zod.rchland.ibm.com>
	<20090923135156.GH14261@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Thu, 24 Sep 2009 07:34:34 +1000
Message-Id: <1253741674.7103.327.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-09-23 at 09:51 -0400, Josh Boyer wrote:
> Prior to the arch/ppc -> arch/powerpc transition, xmon had support for single
> stepping on 4xx boards.  The functionality was lost when arch/ppc was removed.
> This patch restores single step support for 44x boards.
> 
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> ---
>  arch/powerpc/xmon/xmon.c |   20 +++++++++++++++++++-
>  1 files changed, 19 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index c6f0a71..fe2ad71 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -517,6 +517,15 @@ static int xmon_core(struct pt_regs *regs, int fromipi)
>  	in_xmon = 0;
>  #endif
>  
> +#ifdef CONFIG_4xx
> +	if ((regs->msr & (MSR_DE)) == (MSR_DE)) {

Why not just if (regs->msr & MSR_DE) ?

> +		bp = at_breakpoint(regs->nip);
> +		if (bp != NULL) {
> +			regs->nip = (unsigned long) &bp->instr[0];
> +			atomic_inc(&bp->ref_count);
> +		}
> +	}
> +#else

Any reason why that couldn't be in CONFIG_BOOKE ?

>  	if ((regs->msr & (MSR_IR|MSR_PR|MSR_SF)) == (MSR_IR|MSR_SF)) {
>  		bp = at_breakpoint(regs->nip);
>  		if (bp != NULL) {
> @@ -530,7 +539,7 @@ static int xmon_core(struct pt_regs *regs, int fromipi)
>  			}
>  		}
>  	}
> -
> +#endif
>  	insert_cpu_bpts();
>  
>  	local_irq_restore(flags);
> @@ -894,6 +903,14 @@ cmds(struct pt_regs *excp)
>  	}
>  }
>  
> +#ifdef CONFIG_44x

Same comment about BOOKE intead of 44x

> +static int do_step(struct pt_regs *regs)
> +{
> +	regs->msr |= MSR_DE;
> +	mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) | DBCR0_IC | DBCR0_IDM);

I'm not sure about setting IDM... Won't that be a problem if you have
an external debugger connected ?

> +	return 1;
> +}
> +#else
>  /*
>   * Step a single instruction.
>   * Some instructions we emulate, others we execute with MSR_SE set.
> @@ -924,6 +941,7 @@ static int do_step(struct pt_regs *regs)
>  	regs->msr |= MSR_SE;
>  	return 1;
>  }
> +#endif

Cheers,
Ben.

 
>  static void bootcmds(void)
>  {
