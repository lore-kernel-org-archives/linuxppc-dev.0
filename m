Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH/RFC] powerpc: Add MPC5200 Interrupt Controller support.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicolas DET <nd@bplan-gmbh.de>
In-Reply-To: <454A5952.6090801@bplan-gmbh.de>
References: <454902F9.20206@bplan-gmbh.de>
	<1162419138.25682.453.camel@localhost.localdomain>
	<454A1C37.5050208@bplan-gmbh.de>  <454A5952.6090801@bplan-gmbh.de>
Content-Type: text/plain
Date: Sun, 05 Nov 2006 10:35:40 +1100
Message-Id: <1162683341.28571.82.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Sylvain Munaut <tnt@246tNt.com>, sl@bplan-gmbh.de,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-11-02 at 21:47 +0100, Nicolas DET wrote:

> + *
> + * Programmable Interrupt Controller functions for the Freescale MPC52xx.
> + *
> + * Based on (well, mostly copied from) the code from the 2.4 kernel by
> + * Dale Farnsworth <dfarnsworth@mvista.com> and Kent Borg.
> + * 
> + * Copyright (C) 2004 Sylvain Munaut <tnt@246tNt.com>
> + * Copyright (C) 2003 Montavista Software, Inc

You did significant changes, you should add your (c) before the "Based
on..." line.

> +	switch (l1irq) {
> +	case MPC52xx_IRQ_L1_CRIT:
> +		pr_debug("%s: Critical. l2=%x\n", __func__, l2irq);
> +
> +		BUG_ON(l2irq != 0);
> +
> +		type = mpc52xx_irqx_gettype(l2irq);
> +		good_irqchip = &mpc52xx_extirq_irqchip;
> +		break;
> +
> +	case MPC52xx_IRQ_L1_MAIN:
> +		pr_debug("%s: Main IRQ[1-3] l2=%x\n", __func__, l2irq);
> +
> +		if ((l2irq >= 1) && (l2irq <= 3)) {
> +			type = mpc52xx_irqx_gettype(l2irq);
> +			good_irqchip = &mpc52xx_extirq_irqchip;
> +		} else {
> +			good_irqchip = &mpc52xx_main_irqchip;
> +		}
> +		break;

You have changed the mapping of L1/L2 but not the device-tree
representation to match them. Which means that you need the ugly hack
above. That is not goot. Fix your device-tree instead and do the same
split in the tree for L1/L2 than you do in the code.

In fact, I'm wondering if it might not be worth going back to 2 cells
and have cell 0 just contain the HW number now that we have sanitized
those... In any way, the above special casing should go.

> +	picnode = find_mpc52xx_picnode();
> +	sdmanode = find_mpc52xx_sdmanode();

Any reason why you have those inline 1-line functions and just not put
the actual of_find_* call in here ?

You probably also need some of_node_put() in the error case. You are
doing a whole bunch of "return" that bypass them.

The rest looks ok.

Please submit the io.h patch separately. Also, you may need to fix the
default case (which is the one we are using) in there to work with
CONFIG_PCI not set (by defining PCI_DRAM_BASE to 0 among others).

> --- a/include/asm-ppc/io.h	2006-11-01 09:19:02.000000000 +0100
> +++ b/include/asm-ppc/io.h	2006-11-02 18:01:17.000000000 +0100
> @@ -26,7 +26,7 @@
>  
>  #if defined(CONFIG_4xx)
>  #include <asm/ibm4xx.h>
> -#elif defined(CONFIG_PPC_MPC52xx)
> +#elif defined(CONFIG_PPC_MPC52xx) && !defined(CONFIG_PPC_MERGE)
>  #include <asm/mpc52xx.h>
>  #elif defined(CONFIG_8xx)
>  #include <asm/mpc8xx.h>

Ben.
