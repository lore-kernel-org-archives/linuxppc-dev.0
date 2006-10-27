Return-Path: <tnt@246tNt.com>
Message-ID: <45428295.7090608@246tNt.com>
Date: Sat, 28 Oct 2006 00:05:09 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Nicolas DET <nd@bplan-gmbh.de>
Subject: Re: [PATCH] General CHRP/MPC5K2 platform support patch
References: <453FB582.20802@bplan-gmbh.de>	
	<1161816783.22582.132.camel@localhost.localdomain>	
	<45409760.7030902@bplan-gmbh.de>	
	<1161866964.27827.2.camel@localhost.localdomain>	
	<4540B0A9.6070404@bplan-gmbh.de>	
	<528646bc0610260902o4d4996a4i3dcf2a9b874037c7@mail.gmail.com>	
	<4541118F.60002@bplan-gmbh.de>	
	<528646bc0610261300s3e93e53fk5732990089b68d35@mail.gmail.com>
	<1161919709.25682.61.camel@localhost.localdomain>
	<45421C97.80501@bplan-gmbh.de>
In-Reply-To: <45421C97.80501@bplan-gmbh.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: akpm@osdl.org, sl@bplan-gmbh.de, linuxppc-dev@ozlabs.org,
	linuxppc-embedded@ozlabs.org, sha@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Nicolas,

Here is a few comments. I'm not very familiar with the new irq stuff so
others
might have more insights.


Sylvain

> --- a/arch/powerpc/sysdev/mpc52xx_pic.c	1970-01-01 01:00:00.000000000 +0100
> +++ b/arch/powerpc/sysdev/mpc52xx_pic.c	2006-10-27 15:58:29.000000000 +0200
> @@ -0,0 +1,414 @@
> +/*
> + * arch/powerpc/sysdev/mpc52xx_pic.c
>   
Looks like jdl is right, we apparently don't do that any more ... So
let's not ;)
> + * Based on (well, mostly copied from) the code from the 2.4 kernel by
> + * Dale Farnsworth <dfarnsworth@mvista.com> and Kent Borg.
>   
That can be removed ... We can't blame Dale anymore if it doesn't work ;)

> +
> +static void mpc52xx_ic_mask_and_ack(unsigned int irq)
> +{
> +	mpc52xx_ic_mask(irq);
> +	mpc52xx_ic_ack(irq);
> +}
>   
>From kernel/irq/chip.c that's done automatically if mask_and_ack is NULL.

> +
> +static struct irq_chip mpc52xx_irqchip = {
> +	.typename = " MPC52xx  ",
> +	.mask = mpc52xx_ic_mask,
> +	.unmask = mpc52xx_ic_unmask,
> +	.mask_ack = mpc52xx_ic_mask_and_ack,
> +};
Is it useful to implement set_type for IRQ[0-3] ? (Just asking ...)

> +	for (i = 0; i < NR_IRQS; i++) {
> +		irq_desc[i].chip = &mpc52xx_irqchip;
> +		irq_desc[i].status = IRQ_LEVEL;
> +
> +	}
>   
All LEVEL ?

> +
> +	/*
> +	 * As last step, add an irq host to translate the real
> +	 * hw irq information provided by the ofw to linux virq
> +	 */
> +
> +	mpc52xx_irqhost =
> +	    irq_alloc_host(IRQ_HOST_MAP_LINEAR, NR_IRQS, &mpc52xx_irqhost_ops,
> +			   -1);
> +}
>   
NR_IRQS ? Might be time to do something better.



> diff -uprN a/include/asm-powerpc/mpc52xx.h b/include/asm-powerpc/mpc52xx.h
> --- a/include/asm-powerpc/mpc52xx.h	1970-01-01 01:00:00.000000000 +0100
> +++ b/include/asm-powerpc/mpc52xx.h	2006-10-27 15:51:55.000000000 +0200
> @@ -0,0 +1,414 @@
> +/*
> + * include/asm-ppc/mpc52xx.h
> + * 
> + * Prototypes, etc. for the Freescale MPC52xx embedded cpu chips
> + * May need to be cleaned as the port goes on ...
> + *
> + *
> + * Maintainer : Sylvain Munaut <tnt@246tNt.com>
> + *
> + * Originally written by Dale Farnsworth <dfarnsworth@mvista.com> 
> + * for the 2.4 kernel.
>   
Again, remove all that (just leave the first line of the description)

> +
> +/* ======================================================================== */
> +/* IRQ mapping                                                              */
> +/* ======================================================================== */
> +
> +#define MPC52xx_IRQ_L1_CRIT	0
> +#define MPC52xx_IRQ_L1_MAIN	1
> +#define MPC52xx_IRQ_L1_PERP	2
> +#define MPC52xx_IRQ_L1_SDMA	3
> +
> +#define MPC52xx_IRQ_L1_OFFSET  (6)
> +#define MPC52xx_IRQ_L1_MASK    (0xc0)
> +
> +#define MPC52xx_IRQ_L2_OFFSET  (0)
> +#define MPC52xx_IRQ_L2_MASK    (0x3f)
>   
As benh suggested on IRC, a L1 offset of 8 might be better for
readability of the
hw irq numbers.
