Return-Path: <christophe.leroy@c-s.fr>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vYqch4ZKPzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 22:20:52 +1100 (AEDT)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vYqcg5wxCz9s7x
 for <linuxppc-dev@ozlabs.org>; Thu,  2 Mar 2017 22:20:51 +1100 (AEDT)
Subject: Re: [RFC PATCH 5/9] powerpc/4xx: Move machine_check_4xx() into
 platforms/4xx
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <1487313139-21959-1-git-send-email-mpe@ellerman.id.au>
 <1487313139-21959-5-git-send-email-mpe@ellerman.id.au>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <eb9a7757-41e9-917d-bb47-cf44f98cf6bc@c-s.fr>
Date: Thu, 2 Mar 2017 12:11:15 +0100
MIME-Version: 1.0
In-Reply-To: <1487313139-21959-5-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 17/02/2017 à 07:32, Michael Ellerman a écrit :
> Now that we have 4xx platform directory we can move the 4xx machine
> check handler in there. Again we drop get_mc_reason() and replace it
> with regs->dsisr directly (which is actually SPRN_ESR).

The same can also be done for the 8xx.
I can propose a patch once you've commited your patches, to avoid 
conflict on traps.c

Or I do it now and you apply your patches over it ?

Christophe

>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/kernel/traps.c                | 18 +-----------------
>  arch/powerpc/platforms/4xx/Makefile        |  2 +-
>  arch/powerpc/platforms/4xx/machine_check.c | 26 ++++++++++++++++++++++++++
>  3 files changed, 28 insertions(+), 18 deletions(-)
>  create mode 100644 arch/powerpc/platforms/4xx/machine_check.c
>
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 41aa472f8ab1..37cbfd7af41d 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -409,23 +409,7 @@ static inline int check_io_access(struct pt_regs *regs)
>  #define clear_single_step(regs)	((regs)->msr &= ~MSR_SE)
>  #endif
>
> -#if defined(CONFIG_4xx)
> -int machine_check_4xx(struct pt_regs *regs)
> -{
> -	unsigned long reason = get_mc_reason(regs);
> -
> -	if (reason & ESR_IMCP) {
> -		printk("Instruction");
> -		mtspr(SPRN_ESR, reason & ~ESR_IMCP);
> -	} else
> -		printk("Data");
> -	printk(" machine check in kernel mode.\n");
> -
> -	return 0;
> -}
> -
> -
> -#elif defined(CONFIG_E500)
> +#if defined(CONFIG_E500)
>  int machine_check_e500mc(struct pt_regs *regs)
>  {
>  	unsigned long mcsr = mfspr(SPRN_MCSR);
> diff --git a/arch/powerpc/platforms/4xx/Makefile b/arch/powerpc/platforms/4xx/Makefile
> index 0d4b65c88d66..9779c32db34e 100644
> --- a/arch/powerpc/platforms/4xx/Makefile
> +++ b/arch/powerpc/platforms/4xx/Makefile
> @@ -1,4 +1,4 @@
> -obj-y				+= uic.o
> +obj-y				+= uic.o machine_check.o
>  obj-$(CONFIG_PPC4xx_OCM)	+= ocm.o
>  obj-$(CONFIG_4xx_SOC)		+= soc.o
>  obj-$(CONFIG_PCI)		+= pci.o
> diff --git a/arch/powerpc/platforms/4xx/machine_check.c b/arch/powerpc/platforms/4xx/machine_check.c
> new file mode 100644
> index 000000000000..aa039dfaf82f
> --- /dev/null
> +++ b/arch/powerpc/platforms/4xx/machine_check.c
> @@ -0,0 +1,26 @@
> +/*
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/printk.h>
> +#include <linux/ptrace.h>
> +
> +#include <asm/reg.h>
> +
> +int machine_check_4xx(struct pt_regs *regs)
> +{
> +	unsigned long reason = regs->dsisr;
> +
> +	if (reason & ESR_IMCP) {
> +		printk("Instruction");
> +		mtspr(SPRN_ESR, reason & ~ESR_IMCP);
> +	} else
> +		printk("Data");
> +	printk(" machine check in kernel mode.\n");
> +
> +	return 0;
> +}
>
