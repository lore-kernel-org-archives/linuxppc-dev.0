Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E6EF368009
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 13:44:16 +1100 (EST)
Subject: Re: [PATCH 4/5] [POWERPC] 8xx: powerpc port of core CPM, CPM PIC, etc.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Vitaly Bordug <vbordug@ru.mvista.com>
In-Reply-To: <20061114012825.17455.1242.stgit@localhost.localdomain>
References: <20061114012504.17455.13833.stgit@localhost.localdomain>
	<20061114012825.17455.1242.stgit@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 14 Nov 2006 13:44:07 +1100
Message-Id: <1163472248.5940.71.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Great !

Some comments ...

> +static void cpm_mask_irq(unsigned int irq)
> +{
> +        unsigned int cpm_vec = (unsigned int)irq_map[irq].hwirq;
> +
> +	clrbits32(&cpic_reg->cpic_cimr, (1 << cpm_vec));
> +}
> +
> +static void cpm_unmask_irq(unsigned int irq)
> +{
> +        unsigned int cpm_vec = (unsigned int)irq_map[irq].hwirq;
> +
> +	setbits32(&cpic_reg->cpic_cimr, (1 << cpm_vec));
> +}

Some space/tab mangling up there :-)

> +static void cpm_mask_and_ack(unsigned int irq)
> +{
> +	/* We do not need to do anything here. */
> +}

Then you probably don't need the callback. What flow handler are you
using ?

> +static void cpm_end_irq(unsigned int irq)
> +{
> +        unsigned int cpm_vec = (unsigned int)irq_map[irq].hwirq;
> +
> +	out_be32(&cpic_reg->cpic_cisr, (1 << cpm_vec));
> +}

That looks like a fasteoi type handler to me...

> +static struct irq_chip cpm_pic = {
> +	.typename = " CPM PIC ",
> +	.enable = cpm_unmask_irq,
> +	.disable = cpm_mask_irq,
> +	.unmask = cpm_unmask_irq,
> +	.mask_ack = cpm_mask_and_ack,
> +	.end = cpm_end_irq,
> +};

Remove enable/disable, the common code will use mask/unmask to implement
them. Also, remove mask_ack and use .eoi for your eoi handler and you
should be able to use the handle_fasteoi_irq() flow handler for your
PIC.

> +static int cpm_pic_host_match(struct irq_host *h, struct device_node *node)
> +{
> +	return cpm_pic_node == NULL || cpm_pic_node == node;
> +}

Are you sure you want to match on a NULL node ?

> +static int cpm_pic_host_map(struct irq_host *h, unsigned int virq,
> +			  irq_hw_number_t hw)
> +{
> +	pr_debug("cpm_pic_host_map(%d, 0x%lx)\n", virq, hw);
> +
> +	get_irq_desc(virq)->status |= IRQ_LEVEL;
> +	set_irq_chip_and_handler(virq, &cpm_pic, handle_level_irq);
> +	return 0;
> +}

As I said above, use fasteoi, not level. Like mpic or xics

> +static void cpm_host_unmap(struct irq_host *h, unsigned int virq)
> +{
> +	/* Make sure irq is masked in hardware */
> +	cpm_mask_irq(virq);
> +
> +	/* remove chip and handler */
> +	set_irq_chip_and_handler(virq, NULL, NULL);
> +}

The above is a duplicate of the common code, you can probably just not
implement an unmap callback at all.

> +static int cpm_pic_host_xlate(struct irq_host *h, struct device_node *ct,
> +			    u32 *intspec, unsigned int intsize,
> +			    irq_hw_number_t *out_hwirq, unsigned int *out_flags)
> +{
> +	static unsigned char map_cpm_senses[4] = {
> +		IRQ_TYPE_LEVEL_LOW,
> +		IRQ_TYPE_LEVEL_HIGH,
> +		IRQ_TYPE_EDGE_FALLING,
> +		IRQ_TYPE_EDGE_RISING,
> +	};
> +
> +	*out_hwirq = intspec[0];
> +	if (intsize > 1 && intspec[1] < 4)
> +		*out_flags = map_cpm_senses[intspec[1]];
> +	else
> +		*out_flags = IRQ_TYPE_NONE;
> +
> +	return 0;
> +}

Can the interrupts have a different sense/polarity ? Because you never
configure that anywhere in the code, so that means you either expect
them to be configured by the firmware, or they have a fixed
sense/polarity in which case, since you can use a fasteoi handler, you
don't even care wether they are level or edge. Thus, if all that is
true, just use a #interrupt-cells of 1 and don't bother with putting
sense/polarity info in the tree at all :-)

> +/* The CPM can generate the error interrupt when there is a race condition
> + * between generating and masking interrupts.  All we have to do is ACK it
> + * and return.  This is a no-op function so we don't need any special
> + * tests in the interrupt handler.
> + */
> +static	irqreturn_t cpm_error_interrupt(int irq, void *dev)
> +{
> +	return IRQ_HANDLED;
> +}

Can you tell me more about this error interrupt ?

> +	ret = of_address_to_resource(np, 0, &res);
> +	if (ret)
> +		return sirq;
> +
> +	cpic_reg = (void *)ioremap(res.start, res.end - res.start + 1);
> +	if (cpic_reg == NULL)
> +		return sirq;

Your error path probably need an of_node_put(np);

> +	sirq = irq_of_parse_and_map(np, 0);

Check for NO_IRQ here in case the device-tree is broken.

> +	/* Initialize the CPM interrupt controller. */
> +	hwirq = (unsigned int)irq_map[sirq].hwirq;
> +	out_be32(&cpic_reg->cpic_cicr,
> +	    (CICR_SCD_SCC4 | CICR_SCC_SCC3 | CICR_SCB_SCC2 | CICR_SCA_SCC1) |
> +		((hwirq/2) << 13) | CICR_HP_MASK);

Here you are configuring the HW irq going to the parent controller ?

> +	out_be32(&cpic_reg->cpic_cimr, 0);
> +
> +	/* create a legacy host */
> +	if (np)
> +		cpm_pic_node = of_node_get(np);

The comment probably needs to change or go :-)

> +	cpm_pic_host = irq_alloc_host(IRQ_HOST_MAP_LINEAR, 64, &cpm_pic_host_ops, 64);
> +	if (cpm_pic_host == NULL) {
> +		printk(KERN_ERR "CPM2 PIC: failed to allocate irq host!\n");
> +		sirq = NO_IRQ;
> +                return sirq;
> +	}

More missing of_node_put() in error path.

> +	/* Install our own error handler. */
> +	np = of_find_node_by_type(NULL, "cpm");
> +	eirq= irq_of_parse_and_map(np, 0);
> +	if (setup_irq(eirq, &cpm_error_irqaction))
> +		printk(KERN_ERR "Could not allocate CPM error IRQ!");

Some error checking above might be useful on the result on
of_find_node_by_type() and irq_of_parse_and_map().

 [ skip ucode patches ]

Wouldn't it be better to have that in the device-tree ? Not sure here,
just asking ...

> +
> +#ifdef CONFIG_USB_SOF_UCODE_PATCH
> +	commproc->cp_rccr = 0;
> +
> +	dp = (uint *)(commproc->cp_dpmem);
> +	for (i=0; i<(sizeof(patch_2000)/4); i++)
> +		*dp++ = patch_2000[i];
> +
> +	dp = (uint *)&(commproc->cp_dpmem[0x0f00]);
> +	for (i=0; i<(sizeof(patch_2f00)/4); i++)
> +		*dp++ = patch_2f00[i];
> +
> +	commproc->cp_rccr = 0x0009;
> +
> +	printk("USB SOF microcode patch installed\n");
> +#endif /* CONFIG_USB_SOF_UCODE_PATCH */
> +
> +#if defined(CONFIG_I2C_SPI_UCODE_PATCH) || \
> +    defined(CONFIG_I2C_SPI_SMC1_UCODE_PATCH)
> +
> +	commproc->cp_rccr = 0;
> +
> +	dp = (uint *)(commproc->cp_dpmem);
> +	for (i=0; i<(sizeof(patch_2000)/4); i++)
> +		*dp++ = patch_2000[i];
> +
> +	dp = (uint *)&(commproc->cp_dpmem[0x0f00]);
> +	for (i=0; i<(sizeof(patch_2f00)/4); i++)
> +		*dp++ = patch_2f00[i];
> +
> +	iip = (iic_t *)&commproc->cp_dparam[PROFF_IIC];
> +# define RPBASE 0x0500
> +	iip->iic_rpbase = RPBASE;
> +
> +	/* Put SPI above the IIC, also 32-byte aligned.
> +	*/
> +	i = (RPBASE + sizeof(iic_t) + 31) & ~31;
> +	spp = (spi_t *)&commproc->cp_dparam[PROFF_SPI];
> +	spp->spi_rpbase = i;
> +
> +# if defined(CONFIG_I2C_SPI_UCODE_PATCH)
> +	commproc->cp_cpmcr1 = 0x802a;
> +	commproc->cp_cpmcr2 = 0x8028;
> +	commproc->cp_cpmcr3 = 0x802e;
> +	commproc->cp_cpmcr4 = 0x802c;
> +	commproc->cp_rccr = 1;
> +
> +	printk("I2C/SPI microcode patch installed.\n");
> +# endif /* CONFIG_I2C_SPI_UCODE_PATCH */
> +
> +# if defined(CONFIG_I2C_SPI_SMC1_UCODE_PATCH)
> +
> +	dp = (uint *)&(commproc->cp_dpmem[0x0e00]);
> +	for (i=0; i<(sizeof(patch_2e00)/4); i++)
> +		*dp++ = patch_2e00[i];
> +
> +	commproc->cp_cpmcr1 = 0x8080;
> +	commproc->cp_cpmcr2 = 0x808a;
> +	commproc->cp_cpmcr3 = 0x8028;
> +	commproc->cp_cpmcr4 = 0x802a;
> +	commproc->cp_rccr = 3;
> +
> +	smp = (smc_uart_t *)&commproc->cp_dparam[PROFF_SMC1];
> +	smp->smc_rpbase = 0x1FC0;
> +
> +	printk("I2C/SPI/SMC1 microcode patch installed.\n");
> +# endif /* CONFIG_I2C_SPI_SMC1_UCODE_PATCH) */
> +
> +#endif /* some variation of the I2C/SPI patch was selected */
> +}

A lot of ifdefs in there ... I would prefer a few device-tree entries
indicating what has to be done so that a given kernel image can be made
to work on 2 or 3 revs of a board needing a different patch. That should
be all small enough. You can still have CONFIG options to define which
patches are supported (built in the kernel image) so that one can choose
to only have one in to get the smallest possible image, but it would be
nice to have the ability to select them as a set and have the platform
define, via the tree, which patches to apply.

> +/*
> + *  Take this entire routine out, since no one calls it and its
> + * logic is suspect.
> + */

Well... just do it then :-)

> +static void mpc8xx_end_irq(unsigned int virq)
> +{
> +	unsigned int irq_nr = (unsigned int)irq_map[virq].hwirq;
> +
> +	if (!(irq_desc[irq_nr].status & (IRQ_DISABLED|IRQ_INPROGRESS))
> +			&& irq_desc[irq_nr].action) {
> +		int bit, word;
> +
> +		bit = irq_nr & 0x1f;
> +		word = irq_nr >> 5;
> +
> +		ppc_cached_irq_mask[word] |= (1 << (31-bit));
> +		out_be32(&siu_reg->sc_simask, ppc_cached_irq_mask[word]);
> +	}
> +}

You should never need a end() handler. You might want an eoi() if you
have a smart controller and can use fasteoi(). For normal level or edge,
the flow handler will implement the logic of unmasking when needed.

> +static int mpc8xx_set_irq_type(unsigned int virq, unsigned int flow_type)
> +{
> +       struct irq_desc *desc = get_irq_desc(virq);
> +
> +
> +        desc->status &= ~(IRQ_TYPE_SENSE_MASK | IRQ_LEVEL);
> +        desc->status |= flow_type & IRQ_TYPE_SENSE_MASK;
> +        if (flow_type & (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW))
> +                desc->status |= IRQ_LEVEL;
> +
> +        if (flow_type & IRQ_TYPE_EDGE_FALLING) {
> +		irq_hw_number_t hw = (unsigned int)irq_map[virq].hwirq;
> +		unsigned int siel = in_be32(&siu_reg->sc_siel);
> +                if ((hw & 1) == 0)
> +                        siel |= (0x80000000 >> hw);
> +                else
> +                        siel &= ~(0x80000000 >> (hw & ~1));
> +		out_be32(&siu_reg->sc_siel, siel);
> +	}
> +        return 0;
> +}

Don't you need to change the flow handler too between edge/level ?

Also, waht is this sc_siel register for ? I'm surprised you have to
do something when swithing an irq to edge but not undo it when
switching it to level...

> +static struct irq_chip mpc8xx_pic = {
> +	.typename = " MPC8XX SIU ",
> +	.enable = mpc8xx_unmask_irq,
> +	.disable = mpc8xx_mask_irq,
> +	.unmask = mpc8xx_unmask_irq,
> +	.mask_ack = mpc8xx_mask_and_ack,
> +	.end = mpc8xx_end_irq,
> +	.set_type = mpc8xx_set_irq_type,
> +};

Remove enable/disable/end. Add ack() if you use the edge flow handler.

> +unsigned int mpc8xx_get_irq(void)
> +{
> +	int irq;
> +
> +	/* For MPC8xx, read the SIVEC register and shift the bits down
> +	 * to get the irq number.
> +	 */
> +	irq = in_be32(&siu_reg->sc_sivec) >> 26;
> +
> +	/*
> +	 * When we read the sivec without an interrupt to process, we will
> +	 * get back SIU_LEVEL7.  In this case, return -1
> +	 */
> +//        if (irq == CPM_INTERRUPT)
> +//        	irq = CPM_IRQ_OFFSET + cpm_get_irq(regs);
> +//	else
> +		if (irq == PIC_VEC_SPURRIOUS)
> +			irq = NO_IRQ;
> +        return irq_linear_revmap(mpc8xx_pic_host, irq);
> +
> +//	return irq;
> +}

Needs cleanups :-) Also is a bit buggy, you probably want

		if (irq == PIC_VEC_SPURRIOUS)
			return NO_IRQ;

> +static int mpc8xx_pic_host_match(struct irq_host *h, struct device_node *node)
> +{
> +	return mpc8xx_pic_node == NULL || mpc8xx_pic_node == node;
> +}

Why match when mpc8xx_pic_node is NULL ? This is something that 8259
does for weird reasons of being compatible with crappy device-trees on
some machines. Not something you should bring in for new ports.

> +static void mpc8xx_pic_host_unmap(struct irq_host *h, unsigned int virq)
> +{
> +	/* Make sure irq is masked in hardware */
> +	mpc8xx_mask_irq(virq);
> +
> +	/* remove chip and handler */
> +	set_irq_chip_and_handler(virq, NULL, NULL);
> +}

You probably don't need an unmap callback at all.

> +void mpc8xx_pic_init(struct device_node *np)
> +{
> +	struct resource res;
> +	int ret;
> +
> +	/* create a legacy host */
> +	if (np)
> +		mpc8xx_pic_node = of_node_get(np);
> +
> +	ret = of_address_to_resource(np, 0, &res);
> +	if (ret)
> +		return;
> +
> +	siu_reg = (void *)ioremap(res.start, res.end - res.start + 1);
> +	if (siu_reg == NULL)
> +		return;

of_node_put(np);

> +	mpc8xx_pic_host = irq_alloc_host(IRQ_HOST_MAP_LINEAR, 64, &mpc8xx_pic_host_ops, 64);
> +	if (mpc8xx_pic_host == NULL) {
> +		printk(KERN_ERR "MPC8xx PIC: failed to allocate irq host!\n");
> +	}
> +}

> +/* Currently, all 8xx boards that support a processor to PCI/ISA bridge
> + * use the same memory map.
> + */
> +#if !defined(_IO_BASE)  /* defined in board specific header */
> +#define _IO_BASE        0
> +#endif
> +#define _ISA_MEM_BASE   0
> +#define PCI_DRAM_OFFSET 0

The above should now be defined generically in asm-powerpc/io.h (at
least with my latest patches).

> +#ifndef __ASSEMBLY__
> +//struct pt_regs;
> +//#define PPC_PIN_SIZE	(24 * 1024 * 1024)	/* 24Mbytes of data pinned */
> +#endif /* !__ASSEMBLY__ */

Some cleanup is overdue here :-)\

Cheers,
Ben.
