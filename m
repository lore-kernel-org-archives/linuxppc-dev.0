Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40cFlS3R9rzF2Vy
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2018 23:06:28 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Darren Stevens <darren@stevens-zone.net>, linuxppc-dev@lists.ozlabs.org
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: [PATCH NEXT 2/4] powerpc/pasemi: Add Nemo board IRQ init routine
In-Reply-To: <4b3d1fd01f9.613e9d05@auth.smtp.1and1.co.uk>
References: <4b3d1fd01f9.613e9d05@auth.smtp.1and1.co.uk>
Date: Thu, 03 May 2018 23:06:27 +1000
Message-ID: <87h8noanxo.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Darren Stevens <darren@stevens-zone.net> writes:

> diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
> index c4a3e93..c583c17 100644
> --- a/arch/powerpc/platforms/pasemi/setup.c
> +++ b/arch/powerpc/platforms/pasemi/setup.c
> @@ -183,6 +184,99 @@ static int __init pas_setup_mce_regs(void)
>  }
>  machine_device_initcall(pasemi, pas_setup_mce_regs);
>  
> +#ifdef CONFIG_PPC_PASEMI_NEMO
> +static void sb600_8259_cascade(struct irq_desc *desc)
> +{
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	unsigned int cascade_irq = i8259_irq();
> +
> +	if (cascade_irq)
> +               generic_handle_irq(cascade_irq);
> +
> +	chip->irq_eoi(&desc->irq_data);
> +}
> +
> +static __init void nemo_init_IRQ(void)
> +{
> +	struct device_node *np;
> +	struct device_node *root, *mpic_node, *i8259_node;
> +	unsigned long openpic_addr;
> +	const unsigned int *opprop;
> +	int naddr, opplen;
> +	int mpic_flags;
> +	const unsigned int *nmiprop;
> +	struct mpic *mpic;
> +	int gpio_virq;
> +
> +	mpic_node = NULL;

This is basically a copy of the existing routine.

> +	for_each_node_by_type(np, "interrupt-controller")
> +		if (of_device_is_compatible(np, "open-pic")) {
> +			mpic_node = np;
> +			break;
> +		}
> +	if (!mpic_node)
> +		for_each_node_by_type(np, "open-pic") {
> +			mpic_node = np;
> +			break;
> +		}
> +	if (!mpic_node) {
> +		printk(KERN_ERR
> +			"Failed to locate the MPIC interrupt controller\n");
> +		return;
> +	}
> +
> +	/* Find address list in /platform-open-pic */
> +	root = of_find_node_by_path("/");
> +	naddr = of_n_addr_cells(root);
> +	opprop = of_get_property(root, "platform-open-pic", &opplen);
> +	if (!opprop) {
> +		printk(KERN_ERR "No platform-open-pic property.\n");
> +		of_node_put(root);
> +		return;
> +	}
> +	openpic_addr = of_read_number(opprop, naddr);
> +	printk(KERN_DEBUG "OpenPIC addr: %lx\n", openpic_addr);
> +
> +	mpic_flags = MPIC_LARGE_VECTORS | MPIC_NO_BIAS | MPIC_NO_RESET;
> +
> +	nmiprop = of_get_property(mpic_node, "nmi-source", NULL);
> +	if (nmiprop)
> +		mpic_flags |= MPIC_ENABLE_MCK;
> +
> +	mpic = mpic_alloc(mpic_node, openpic_addr,
> +			  mpic_flags, 0, 0, "PASEMI-OPIC");
> +	BUG_ON(!mpic);
> +
> +	mpic_assign_isu(mpic, 0, mpic->paddr + 0x10000);
> +	mpic_init(mpic);
> +	/* The NMI/MCK source needs to be prio 15 */
> +	if (nmiprop) {
> +		nmi_virq = irq_create_mapping(NULL, *nmiprop);
> +		mpic_irq_set_priority(nmi_virq, 15);
> +		irq_set_irq_type(nmi_virq, IRQ_TYPE_EDGE_RISING);
> +		mpic_unmask_irq(irq_get_irq_data(nmi_virq));
> +	}

Except for this bit:

> +	/* Connect the SB600's legacy i8259 controller */
> +	i8259_node = of_find_node_by_path("/pxp@0,e0000000");
> +	i8259_init(i8259_node, 0);
> +	of_node_put(i8259_node);
> +
> +	gpio_virq = irq_create_mapping(NULL, 3);
> +	irq_set_irq_type(gpio_virq, IRQ_TYPE_LEVEL_HIGH);
> +	irq_set_chained_handler(gpio_virq, sb600_8259_cascade);
> +	mpic_unmask_irq(irq_get_irq_data(gpio_virq));
> +
> +	irq_set_default_host(mpic->irqhost);

So that should just go in a separate routine that is empty when NEMO=n.

cheers
