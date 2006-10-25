Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] General CHRP/MPC5K2 platform support patch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicolas DET <nd@bplan-gmbh.de>
In-Reply-To: <453FB582.20802@bplan-gmbh.de>
References: <453FB582.20802@bplan-gmbh.de>
Content-Type: text/plain
Date: Thu, 26 Oct 2006 08:53:03 +1000
Message-Id: <1161816783.22582.132.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: akpm@osdl.org, Sylvain Munaut <tnt@246tNt.com>, sl@bplan-gmbh.de,
	linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org, sha@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-10-25 at 21:05 +0200, Nicolas DET wrote:

In addition to various whitespace damage in the patch...

> +	if (_chrp_type ==  _CHRP_E5K2) {
> +		ppc_md.get_irq = mpc52xx_get_irq;
> +		mpc52xx_init_irq();
> +		return;
> +	}

As I wrote, the above should be unnecessary.

>  	chrp_find_openpic();
>  	chrp_find_8259();

Just add a

	chrp_find_mpc5200pic();

Which will set itself as the default controller and set ppc_md.get_irq
if none have done it before.
 
> @@ -530,6 +540,9 @@ chrp_init2(void)
>  	chrp_nvram_init();
>  #endif
>  
> +	if (_chrp_type == _CHRP_E5K2)
> +		return;

Why that ? Not that we really need those request_region() anyway, but
it's highly recommended that your firmware doesn't allocate anything in
that "legacy" portion of the IO space anyway, so requesting those
regions will do no harm.

>  	request_region(0x20,0x20,"pic1");
>  	request_region(0xa0,0x20,"pic2");
>  	request_region(0x00,0x20,"dma1");

> +static void
> +mpc52xx_ic_disable(unsigned int virq)
> +{
> +        u32 val;
> +	int irq;
> +
> +	irq = irq_map[virq].hwirq;

You should test if the result is valid just in case you were called with
a bogus irq number

> +	pr_debug("%s: irq=%d\n", __func__, irq);
> +
> +        if (irq == MPC52xx_IRQ0) {
> +                val = in_be32(&intr->ctrl);
> +                val &= ~(1 << 11);
> +                out_be32(&intr->ctrl, val);
> +        } else if (irq < MPC52xx_IRQ1) {
> +                BUG();
> +        } else if (irq <= MPC52xx_IRQ3) {
> +                val = in_be32(&intr->ctrl);
> +                val &= ~(1 << (10 - (irq - MPC52xx_IRQ1)));
> +                out_be32(&intr->ctrl, val);
> +        } else if (irq < MPC52xx_SDMA_IRQ_BASE) {
> +                val = in_be32(&intr->main_mask);
> +                val |= 1 << (16 - (irq - MPC52xx_MAIN_IRQ_BASE));
> +                out_be32(&intr->main_mask, val);
> +        } else if (irq < MPC52xx_PERP_IRQ_BASE) {
> +                val = in_be32(&sdma->IntMask);
> +                val |= 1 << (irq - MPC52xx_SDMA_IRQ_BASE);
> +                out_be32(&sdma->IntMask, val);
> +        } else {
> +                val = in_be32(&intr->per_mask);
> +                val |= 1 << (31 - (irq - MPC52xx_PERP_IRQ_BASE));
> +                out_be32(&intr->per_mask, val);
> +        }
> +}

You may want to chose a different encoding for your HW irqs to make the
above less horrible. For example, have an irq category in some top bits
and the actual bit mask pre-mashed in the bottom bits.

And same comments for enable().

> +static void
> +mpc52xx_ic_disable_and_ack(unsigned int irq)
> +{
> +        mpc52xx_ic_disable(irq);
> +        mpc52xx_ic_ack(irq);
> +}

You don't need the above. It will be done for you by the core code once
you properly adapt to genirq.

> +static void
> +mpc52xx_ic_end(unsigned int irq)
> +{
> +        if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
> +                mpc52xx_ic_enable(irq);
> +}

The above is not necessary anymore, you need to properly adapt to genirq
which you haven't done yet.

> +static struct irq_chip mpc52xx_irqchip = {
> +	.name	= " MPC52xx  ",
> +	.enable		= mpc52xx_ic_enable,
> +	.disable	= mpc52xx_ic_disable,
> +	.ack		= mpc52xx_ic_disable_and_ack,
> +	.end		= mpc52xx_ic_end,
> +};

As I said, you haven't properly adapted to genirq. That is

 enable -> unmask
 disable -> mask
 ack stays and doesn't do disable
 end is gone

You also need to call set_irq_chip_and_handler(), possibly in your host
map() function to set the right flow handler for your interrupts.

> +static int mpc52xx_irqhost_match(struct irq_host *h, struct device_node *node)
> +{
> +	pr_debug("%s: node=%p\n", __func__, node);
> +
> +	if ( device_is_compatible(node, "mpc52xx-pic") )
> +		return 1;
> +
> +	return device_is_compatible(node, "mpc5200-pic");
> +}

You probably need only one of the above statements. It depends on how
the device-tree binding is defined for the MPC52xx which, for the
10000th time, should be done PUBLICALLY

> +int mpc52xx_irqhost_map(struct irq_host *h, unsigned int virq, irq_hw_number_t hw)
> +{
> +	pr_debug("%s: v=%d, hw=%d\n", __func__, virq, (int) hw);
> +
> +	return 0;
> +}

As I said earlier, the above needs to at least set a flow handler. Also,
if you intend to have different flow handlers for edge and level irqs,
then you'll also probably need to implement set_irq_type(). You may want
to look at the IPI driver for that (and beware of the lock problem with
set_irq_type() vs. set_irq_handler(), see the IPIC patch that went on
the list recently)

> +        /* Zero a bunch of the priority settings.  */
> +        out_be32(&intr->per_pri1, 0);
> +        out_be32(&intr->per_pri2, 0);
> +        out_be32(&intr->per_pri3, 0);
> +        out_be32(&intr->main_pri1, 0);
> +        out_be32(&intr->main_pri2, 0);
> +        /* Initialize irq_desc[i].handler's with mpc52xx_ic. */
> +        for (i = 0; i < NR_IRQS; i++) {
> +                irq_desc[i].chip = &mpc52xx_irqchip;
> +                irq_desc[i].status = IRQ_LEVEL;
> +		
> +        }

The above should go. With the port to genirq, you get descriptors as
irqs get mapped, from your map callback, which is where you set the chip
and flow handler.

You should also never completley override status like that. Just or-in
the bits you need. Look at what other PICs in arch/powerpc do.

> +#define IRQn_MODE(intr_ctrl,irq) (((intr_ctrl) >> (22-(i<<1))) & 0x03)
> +        for (i=0 ; i<4 ; i++) {
> +                int mode;
> +                mode = IRQn_MODE(intr_ctrl,i);
> +                if ((mode == 0x1) || (mode == 0x2))
> +                        irq_desc[i?MPC52xx_IRQ1+i-1:MPC52xx_IRQ0].status = 0;
> +        }

What is the above about ?

> +	/*
> +	 * As last step, add an irq host to translate the real
> +	 * hw irq information provided by the ofw to linux virq
> +	*/
> +
> +	mpc52xx_irqhost = irq_alloc_host(IRQ_HOST_MAP_LINEAR, 0, &mpc52xx_irqhost_ops, -1);
> +	pr_debug("%s: mpc52xx_irqhost =%p\n", __func__, mpc52xx_irqhost );
> +}

Ususally we do that first but heh, it doesn't really matter. However:

passing a count of 0 when creating a linear revmap is totally bogus (in
fact, I'm surprised your code works).

Also, as far as the invalid irq is concerned, you should probably define
it using a symbolic constant (properly typed) so you can use it
elsewhere in the code to test the result of the revmap functions among
others.

> +unsigned int
> +mpc52xx_get_irq(void)
> +{
> +        u32 status;
> +	int virq;
> +        int irq = NO_IRQ_IGNORE;
> +
> +        status = in_be32(&intr->enc_status);
> +        if (status & 0x00000400)
> +        {		/* critical */
> +                irq = (status >> 8) & 0x3;
> +                if (irq == 2)			/* high priority peripheral */
> +                        goto peripheral;
> +                irq += MPC52xx_CRIT_IRQ_BASE;
> +        } else if (status & 0x00200000)
> +        {		/* main */
> +                irq = (status >> 16) & 0x1f;
> +                if (irq == 4)			/* low priority peripheral */
> +                        goto peripheral;
> +                irq += MPC52xx_MAIN_IRQ_BASE;
> +        } else if (status & 0x20000000)
> +        {		/* peripheral */
> +peripheral:
> +                irq = (status >> 24) & 0x1f;
> +                if (irq == 0) {			/* bestcomm */
> +                        status = in_be32(&sdma->IntPend);
> +                        irq = ffs(status) + MPC52xx_SDMA_IRQ_BASE-1;
> +                } else
> +                        irq += MPC52xx_PERP_IRQ_BASE;
> +
> +        }
> +
> +	virq = irq_linear_revmap(mpc52xx_irqhost, irq);
> +	pr_debug("%s: irq=%d -> %d\n", __func__, irq, virq);
> +
> +        return virq;
> +}

I'm surprised the revmap is working at all... considering the issues you
have above. You are lucky but things should be fixed anyway.

> --- a/arch/powerpc/sysdev/Makefile	2006-10-25 19:07:24.000000000 +0200
> +++ b/arch/powerpc/sysdev/Makefile	2006-10-25 20:33:32.000000000 +0200
> @@ -13,6 +13,7 @@ obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
>  obj-$(CONFIG_PPC_TODC)		+= todc.o
>  obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o
>  obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
> +obj-$(CONFIG_PPC_CHRP)		+= mpc52xx_pic.o

That's not the proper way to do it. Instead, define an invisible
CONFIG_MPC52xx_PIC and have the chrp platform select it.

>  ifeq ($(CONFIG_PPC_MERGE),y)
>  obj-$(CONFIG_PPC_I8259)		+= i8259.o

Ben.
