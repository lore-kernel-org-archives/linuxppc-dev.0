Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F2F72DDDF9
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 15:31:30 +1000 (EST)
In-Reply-To: <20070718013541.GD15238@ld0162-tx32.am.freescale.net>
References: <20070718013541.GD15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5ED3F9B1-87FF-4046-ADFD-E7805925489A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 32/61] mpc82xx: Move PQ2 restart and halt functions out of
	mpc8272-specific code.
Date: Wed, 18 Jul 2007 00:31:55 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 17, 2007, at 8:35 PM, Scott Wood wrote:

> I renamed it from m82xx to pq2 because it won't work on the Integrated
> Host Processor line of 82xx chips (i.e. 8240, 8245, and such).
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/platforms/82xx/Makefile     |    1 +
>  arch/powerpc/platforms/82xx/mpc8272ads.c |   27 ++----------------
>  arch/powerpc/platforms/82xx/pq2.c        |   44 +++++++++++++++++++ 
> +++++++++++
>  arch/powerpc/platforms/82xx/pq2.h        |    7 +++++
>  include/asm-ppc/immap_cpm2.h             |    2 +
>  5 files changed, 57 insertions(+), 24 deletions(-)
>  create mode 100644 arch/powerpc/platforms/82xx/pq2.c
>  create mode 100644 arch/powerpc/platforms/82xx/pq2.h
>
> diff --git a/arch/powerpc/platforms/82xx/Makefile b/arch/powerpc/ 
> platforms/82xx/Makefile
> index 881a3f6..6049640 100644
> --- a/arch/powerpc/platforms/82xx/Makefile
> +++ b/arch/powerpc/platforms/82xx/Makefile
> @@ -3,3 +3,4 @@
>  #
>  obj-$(CONFIG_PPC_82xx) += mpc82xx.o
>  obj-$(CONFIG_MPC8272ADS) += mpc8272ads.o
> +obj-$(CONFIG_CPM2) += pq2.o
> diff --git a/arch/powerpc/platforms/82xx/mpc8272ads.c b/arch/ 
> powerpc/platforms/82xx/mpc8272ads.c
> index fbf9c67..cd14a48 100644
> --- a/arch/powerpc/platforms/82xx/mpc8272ads.c
> +++ b/arch/powerpc/platforms/82xx/mpc8272ads.c
> @@ -2,7 +2,6 @@
>   * MPC8272ADS setup and early boot code plus other random bits.
>   *
>   * Author: Vitaly Bordug <vbordug@ru.mvista.com>
> - * m82xx_restart fix by Wade Farnsworth <wfarnsworth@mvista.com>
>   *
>   * Copyright (c) 2006 MontaVista Software, Inc.
>   *
> @@ -42,6 +41,7 @@
>  #include <asm/mpc8260.h>
>  #include <asm/irq.h>
>  #include <mm/mmu_decl.h>
> +#include <platforms/82xx/pq2.h>
>  #include <asm/prom.h>
>  #include <asm/cpm2.h>
>  #include <asm/udbg.h>
> @@ -603,27 +603,6 @@ static int __init mpc8272ads_probe(void)
>  	return of_flat_dt_is_compatible(root, "fsl,mpc8272ads");
>  }
>
> -#define RMR_CSRE 0x00000001
> -static void m82xx_restart(char *cmd)
> -{
> -	__volatile__ unsigned char dummy;
> -
> -	local_irq_disable();
> -	((cpm2_map_t *) cpm2_immr)->im_clkrst.car_rmr |= RMR_CSRE;
> -
> -	/* Clear the ME,EE,IR & DR bits in MSR to cause checkstop */
> -	mtmsr(mfmsr() & ~(MSR_ME | MSR_EE | MSR_IR | MSR_DR));
> -	dummy = ((cpm2_map_t *) cpm2_immr)->im_clkrst.res[0];
> -	printk("Restart failed\n");
> -	while (1) ;
> -}
> -
> -static void m82xx_halt(void)
> -{
> -	local_irq_disable();
> -	while (1) ;
> -}
> -
>  define_machine(mpc8272ads)
>  {
>  	.name = "Freescale MPC8272ADS",
> @@ -633,6 +612,6 @@ define_machine(mpc8272ads)
>  	.show_cpuinfo = m82xx_show_cpuinfo,
>  	.get_irq = cpm2_get_irq,
>  	.calibrate_decr = m82xx_calibrate_decr,
> -	.restart = m82xx_restart,
> -	.halt = m82xx_halt,
> +	.restart = pq2_restart,
> +	.halt = pq2_halt,
>  };
> diff --git a/arch/powerpc/platforms/82xx/pq2.c b/arch/powerpc/ 
> platforms/82xx/pq2.c
> new file mode 100644
> index 0000000..e58980d
> --- /dev/null
> +++ b/arch/powerpc/platforms/82xx/pq2.c
> @@ -0,0 +1,44 @@
> +/*
> + * Common PowerQUICC II code.
> + *
> + * Author: Scott Wood <scottwood@freescale.com>
> + * Copyright (c) 2007 Freescale Semiconductor
> + *
> + * Based on code by Vitaly Bordug <vbordug@ru.mvista.com>
> + * pq2_restart fix by Wade Farnsworth <wfarnsworth@mvista.com>
> + * Copyright (c) 2006 MontaVista Software, Inc.
> + *
> + * This program is free software; you can redistribute  it and/or  
> modify it
> + * under  the terms of  the GNU General  Public License as  
> published by the
> + * Free Software Foundation;  either version 2 of the  License, or  
> (at your
> + * option) any later version.
> + */
> +
> +#include <asm/cpm2.h>
> +#include <asm/io.h>
> +#include <asm/system.h>
> +
> +#include <platforms/82xx/pq2.h>
> +
> +#define RMR_CSRE 0x00000001
> +
> +void pq2_restart(char *cmd)
> +{
> +	local_irq_disable();
> +	cpm2_immr->im_clkrst.car_rmr |= RMR_CSRE;
> +
> +	/* Clear the ME,EE,IR & DR bits in MSR to cause checkstop */
> +	mtmsr(mfmsr() & ~(MSR_ME | MSR_EE | MSR_IR | MSR_DR));
> +	in_8(&cpm2_immr->im_clkrst.res[0]);
> +
> +	printk("Restart failed\n");
> +	while (1)
> +		;
> +}
> +
> +void pq2_halt(void)
> +{
> +	local_irq_disable();
> +	while (1)
> +		;
> +}

Kill pq2_halt, if this is all it does just dont set ppc_md.halt() and  
get the generic behavior which is the same.

> diff --git a/arch/powerpc/platforms/82xx/pq2.h b/arch/powerpc/ 
> platforms/82xx/pq2.h
> new file mode 100644
> index 0000000..3c9620f
> --- /dev/null
> +++ b/arch/powerpc/platforms/82xx/pq2.h
> @@ -0,0 +1,7 @@
> +#ifndef _PQ2_H
> +#define _PQ2_H
> +
> +void pq2_restart(char *cmd);
> +void pq2_halt(void);
> +
> +#endif
> diff --git a/include/asm-ppc/immap_cpm2.h b/include/asm-ppc/ 
> immap_cpm2.h
> index 3c23d9c..8795bcc 100644
> --- a/include/asm-ppc/immap_cpm2.h
> +++ b/include/asm-ppc/immap_cpm2.h
> @@ -10,6 +10,8 @@
>  #ifndef __IMMAP_CPM2__
>  #define __IMMAP_CPM2__
>
> +#include <linux/types.h>
> +

Why was this needed all of a sudden?

>  /* System configuration registers.
>  */
>  typedef	struct sys_82xx_conf {

- k
