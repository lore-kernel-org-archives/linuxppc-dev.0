Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] General CHRP/MPC5K2 platform support patch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicolas DET <nd@bplan-gmbh.de>
In-Reply-To: <45421FFD.8070407@bplan-gmbh.de>
References: <453FB582.20802@bplan-gmbh.de>
	<1161816783.22582.132.camel@localhost.localdomain>
	<45409760.7030902@bplan-gmbh.de>
	<1161866964.27827.2.camel@localhost.localdomain>
	<4540B0A9.6070404@bplan-gmbh.de>
	<528646bc0610260902o4d4996a4i3dcf2a9b874037c7@mail.gmail.com>
	<4541118F.60002@bplan-gmbh.de>
	<528646bc0610261300s3e93e53fk5732990089b68d35@mail.gmail.com>
	<1161919709.25682.61.camel@localhost.localdomain>
	<45421C97.80501@bplan-gmbh.de>  <45421FFD.8070407@bplan-gmbh.de>
Content-Type: text/plain
Date: Sat, 28 Oct 2006 08:34:23 +1000
Message-Id: <1161988463.25682.94.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, sl@bplan-gmbh.de,
	sha@pengutronix.de, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-10-27 at 17:04 +0200, Nicolas DET wrote:

> +static void mpc52xx_ic_mask(unsigned int virq)
> +{
> +	u32 val;
> +	int irq;
> +	int l1irq;
> +	int l2irq;
> +
> +	irq = irq_map[virq].hwirq;
> +	l1irq = (irq & MPC52xx_IRQ_L1_MASK) >> MPC52xx_IRQ_L1_OFFSET;
> +	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
> +
> +	pr_debug("%s: irq=%x. l1=%d, l2=%d\n", __func__, irq, l1irq, l2irq);
> +
> +	switch (l1irq) {
> +	case MPC52xx_IRQ_L1_CRIT:
> +		if (l2irq != 0)
> +			BUG();
> +
> +		val = in_be32(&intr->ctrl);
> +		val &= ~(1 << 11);
> +		out_be32(&intr->ctrl, val);
> +		break;
> +
> +	case MPC52xx_IRQ_L1_MAIN:
> +		if ( (l2irq >= 1) && (l2irq <= 3) ) {
> +			val = in_be32(&intr->ctrl);
> +			val &= ~(1 << (11 - l2irq));
> +			out_be32(&intr->ctrl, val);
> +		} else {
> +			val = in_be32(&intr->main_mask);
> +			val |= 1 << (16 - l2irq);
> +			out_be32(&intr->main_mask, val);
> +		}
> +		break;

Any reason why you do the above instead o defining two diferent levels
instead. Also, L1_CRIT would fit in the L1_MAIN case too...

I don't see the point of having also XXX-l2, just put a bit number in L2
and be done with it.

The idea is to streamling the code, such that you can index an array
with l1irq to get the register, and build a mask. No test, no switch
case, etc...

Actually... the most performant way of doing all this is to have a
different irq_chip (with a different set of ask,mask,unmask) for each
"L1" so that they get right to the point. But I would settle for an
array indexed by L1.

> +static void mpc52xx_ic_mask_and_ack(unsigned int irq)
> +{
> +	mpc52xx_ic_mask(irq);
> +	mpc52xx_ic_ack(irq);
> +}

The above is unnuecessary. The core will call mask and ack.

> +static struct irq_chip mpc52xx_irqchip = {
> +	.typename = " MPC52xx  ",
> +	.mask = mpc52xx_ic_mask,
> +	.unmask = mpc52xx_ic_unmask,
> +	.mask_ack = mpc52xx_ic_mask_and_ack,
> +};

In the above, you need to provide ack.

> +static int mpc52xx_irqhost_match(struct irq_host *h, struct device_node *node)
> +{
> +	pr_debug("%s: %p vs %p\n", __func__, find_mpc52xx_picnode(), node);
> +	return find_mpc52xx_picnode() == node;
> +}

Don't redo the whole find all the time. Put the node in your
irq_host->host_data at init time and compare it there. That way, also,
find_mpc53xx_picnode() thingy can just stay static to chrp/setup.c. The
way you did it would be a problem if we had more than one platform using
52xx built in the same kernel.

> +static int mpc52xx_islevel(int num)
> +{
> +	u32 ictl_req;
> +	int ictl_type;
> +
> +	ictl_req = in_be32(&intr->ctrl);
> +	ictl_type = (ictl_req >> 16) & 0x3;
> +
> +	switch (ictl_type) {
> +	case 0:
> +	case 3:
> +		return 1;
> +	}
> +
> +	return 0;
> +}

You only have level/edge settings, not polarity ? Also, you aren't
giving the user or device-tree the option to set the type manually....

Ideally, you should use the bits in IRQ_TYPE_SENSE_MASK to fully
define the irq type/polarity and provide a set_irq_type() callback.

Also, beware that you cannot call set_irq_chip_and_handler() from within
set_irq_type() due to a spinlock recursion issue. There is a patch
floating on the list for IPIC fixing an issue of that sort, you may want
to have a look.

In general, look at what others are doing, notably mpic and ipic.

You can also keep IRQ_LEVEL in "sync" with the other polarity bits, it's
really only useful to display the polarity in /proc/interrupts.

Note that your map code would always OR the bit, never clear it. It
should have probably cleared it before the switch/case.

> +void mpc52xx_irqhost_unmap(struct irq_host *h, unsigned int virq)
> +{
> +	pr_debug("%s: v=%x\n", __func__, virq);
> +
> +	mpc52xx_ic_mask(virq);
> +	set_irq_chip_and_handler(virq, NULL, NULL);
> +	synchronize_irq(virq);
> +}

The common code will do all of the above. Your unmap can be empty. (Or
just don't do an unmap).

> +static struct irq_host_ops mpc52xx_irqhost_ops = {
> +	.match = mpc52xx_irqhost_match,
> +	.xlate = mpc52xx_irqhost_xlate,
> +	.map = mpc52xx_irqhost_map,
> +	.unmap = mpc52xx_irqhost_unmap,
> +};
> +
> +void __init mpc52xx_init_irq(void)
> +{
> +	int i;
> +	u32 intr_ctrl;
> +
> +	/* Remap the necessary zones */
> +	intr = ioremap(MPC52xx_PA(MPC52xx_INTR_OFFSET), MPC52xx_INTR_SIZE);
> +	sdma = ioremap(MPC52xx_PA(MPC52xx_SDMA_OFFSET), MPC52xx_SDMA_SIZE);
> +
> +	if ((intr == NULL) || (sdma == NULL))
> +		panic("Can't ioremap PIC/SDMA register or init_irq !");
> +
> +	/* Disable all interrupt sources. */
> +	out_be32(&sdma->IntPend, 0xffffffff);	/* 1 means clear pending */
> +	out_be32(&sdma->IntMask, 0xffffffff);	/* 1 means disabled */
> +	out_be32(&intr->per_mask, 0x7ffffc00);	/* 1 means disabled */
> +	out_be32(&intr->main_mask, 0x00010fff);	/* 1 means disabled */
> +	intr_ctrl = in_be32(&intr->ctrl);
> +	intr_ctrl &= 0x00ff0000;	/* Keeps IRQ[0-3] config */
> +	intr_ctrl |= 0x0f000000 |	/* clear IRQ 0-3 */
> +	    0x00001000 |	/* MEE master external enable */
> +	    0x00000000 |	/* 0 means disable IRQ 0-3 */
> +	    0x00000001;		/* CEb route critical normally */
> +	out_be32(&intr->ctrl, intr_ctrl);
> +
> +	/* Zero a bunch of the priority settings.  */
> +	out_be32(&intr->per_pri1, 0);
> +	out_be32(&intr->per_pri2, 0);
> +	out_be32(&intr->per_pri3, 0);
> +	out_be32(&intr->main_pri1, 0);
> +	out_be32(&intr->main_pri2, 0);
> +	/* Initialize irq_desc[i].handler's with mpc52xx_ic. */
> +	for (i = 0; i < NR_IRQS; i++) {
> +		irq_desc[i].chip = &mpc52xx_irqchip;
> +		irq_desc[i].status = IRQ_LEVEL;
> +
> +	}

The above is completely bogus and should be just removed. You should not
touch the irq_desc array. You should only ever modify irq_desc's that
have been assigned to you by your host->map callback.

> +	/*
> +	 * As last step, add an irq host to translate the real
> +	 * hw irq information provided by the ofw to linux virq
> +	 */
> +
> +	mpc52xx_irqhost =
> +	    irq_alloc_host(IRQ_HOST_MAP_LINEAR, NR_IRQS, &mpc52xx_irqhost_ops,
> +			   -1);
> +}

As I said before, NR_IRQ is a poor choice for the size of the revmap.
You should have a constant somewhere defining what is your max HW irq
number. and use that +1, or a hw irq count.
> --- a/arch/powerpc/platforms/chrp/setup.c	2006-10-25 19:07:23.000000000 +0200
> +++ b/arch/powerpc/platforms/chrp/setup.c	2006-10-27 16:08:03.000000000 +0200
> @@ -51,6 +51,7 @@
>  #include <asm/mpic.h>
>  #include <asm/rtas.h>
>  #include <asm/xmon.h>
> +#include <asm/mpc52xx.h>
>  
>  #include "chrp.h"
>  
> @@ -435,6 +436,18 @@ static struct irqaction xmon_irqaction =
>  };
>  #endif
>  
> +static int __init chrp_find_mpc52xx_pic(void)
> +{
> +	if (find_mpc52xx_picnode()) {
> +		printk(KERN_INFO "Found MPC52xx Interrupt Controller\n");
> +		ppc_md.get_irq = mpc52xx_get_irq;
> +		mpc52xx_init_irq();
> +		return 0;
> +	}
> +
> +	return -ENODEV;
> +}

Just get rif of find_mpic53xx_picnode. Do it locally and pass the device
node to mpc52xx_init_irq().

>  static void __init chrp_find_8259(void)
>  {
>  	struct device_node *np, *pic = NULL;
> @@ -496,6 +509,7 @@ void __init chrp_init_IRQ(void)
>  #endif
>  	chrp_find_openpic();
>  	chrp_find_8259();
> +	chrp_find_mpc52xx_pic();
>  
>  #ifdef CONFIG_SMP
>  	/* Pegasos has no MPIC, those ops would make it crash. It might be an
> diff -uprN a/include/asm-powerpc/mpc52xx.h b/include/asm-powerpc/mpc52xx.h
> --- a/include/asm-powerpc/mpc52xx.h	1970-01-01 01:00:00.000000000 +0100
> +++ b/include/asm-powerpc/mpc52xx.h	2006-10-27 15:51:55.000000000 +0200
> @@ -0,0 +1,414 @@
> +/*
> + * include/asm-powerpc/mpc52xx.h
> + * 
> + * Prototypes, etc. for the Freescale MPC52xx embedded cpu chips
> + * May need to be cleaned as the port goes on ...
> + *
> + *
> + * Maintainer : Sylvain Munaut <tnt@246tNt.com>
> + *
> + * Originally written by Dale Farnsworth <dfarnsworth@mvista.com> 
> + * for the 2.4 kernel.
> + *
> + * Copyright (C) 2004-2005 Sylvain Munaut <tnt@246tNt.com>
> + * Copyright (C) 2003 MontaVista, Software, Inc.
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2. This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +#ifndef __ASM_POWERPC_MPC52xx_H__
> +#define __ASM_POWERPC_MPC52xx_H__
> +
> +#ifndef __ASSEMBLY__
> +#include <asm/types.h>
> +#include <asm/prom.h>
> +
> +#endif /* __ASSEMBLY__ */
> +
> +
> +#ifdef CONFIG_PCI
> +#define _IO_BASE	isa_io_base
> +#define _ISA_MEM_BASE	isa_mem_base
> +#define PCI_DRAM_OFFSET	pci_dram_offset
> +#else
> +#define _IO_BASE	0
> +#define _ISA_MEM_BASE	0
> +#define PCI_DRAM_OFFSET	0
> +#endif

Remove all of the above, it's bogus. You don't want to touch those
things when CONFIG_MULTIPLATFORM. (That is, they are variables set
programmatically, you can't just go #define them and common code already
takes care of defining them anyway).

Ben.
