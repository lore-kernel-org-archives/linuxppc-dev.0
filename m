Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0CFDB67A66
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jun 2006 10:11:53 +1000 (EST)
Subject: Re: [PATCH] Use IRQ and senses from OF-tree on 8641hpcn.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1150999473.9022.79.camel@cashmere.sps.mot.com>
References: <1150999473.9022.79.camel@cashmere.sps.mot.com>
Content-Type: text/plain
Date: Fri, 23 Jun 2006 10:11:37 +1000
Message-Id: <1151021497.4046.79.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> -static void __devinit quirk_ali1575(struct pci_dev *dev)
> +static int __init get_pci_irq_from_of(struct pci_controller *hose,
> +				   int slot, int pin)
> +{
> +	struct device_node *node;
> +	unsigned long *interrupt, *interrupt_mask;
> +	int len, mask_len;
> +	int shift, i;
> +	int irq = 0;
> +
> +	if (!hose) {
> +		printk(KERN_ERR "No PCI hose found!\n");
> +		return -EFAULT;
> +	}
> +
> +	node = (struct device_node *)hose->arch_data;
> +	interrupt = (unsigned long *)get_property(node,
> +			"interrupt-map", &len);
> +	interrupt_mask = (unsigned long *)get_property(node,
> +			"interrupt-map-mask", &mask_len);
> +	if (!interrupt || !interrupt_mask) {
> +		printk(KERN_ERR "No PCI interrupt-map or interrupt-map-mask"
> +				"property in OpenFirmware device tree!\n");
> +		return -EFAULT;
> +	}
> +	shift = __ilog2((~interrupt_mask[0] + 1) & 0xffff);

Nice hack :)

But not something mergeable as it strictly relies on the specific format
of the interrupt map on that platform :) I have a generic parser on the
way, it's hot and will be released for public consumption later today or
this week-end along with the rest of the irq patches.

I'll need you guys to help porting the few embedded boards already in
arch/powerpc.

Ben.

> +	/*
> +	 * Find matched irq in interrupt-map node of OF-tree.
> +	 *
> +	 * interrupt-map entries format:
> +	 * <slot>     <pin> <interrupt-parent> <irq#>
> +	 *  8800  0 0   1         40000           3   0
> +	 */
> +	pr_debug("PCI slot %x, pin %d ", slot, pin);
> +	for (i = 0; i < (len / 7); i++)
> +		if (((interrupt[i * 7] & interrupt_mask[0]) == (slot << shift))
> +				&& (interrupt[i * 7 + 3] == pin))
> +			irq = interrupt[i * 7 + 5] & interrupt_mask[3];
> +	pr_debug("irq %d\n", irq);
> +
> +	if (!irq)
> +		printk(KERN_WARNING "PCI Slot %d, Pin %d device "
> +				"has no matched irq!\n", slot, pin);
> +
> +	return irq;
> +}
> +
> +static int __init mpc86xx_irq_fixup(struct pci_dev *dev)
> +{
> +	struct pci_controller *hose = NULL;
> +	int pin, slot;
> +
> +	hose = pci_bus_to_hose(dev->bus->number);
> +	if (!hose) {
> +		printk(KERN_ERR "No PCI hose found!\n");
> +		return -EFAULT;
> +	}
> +
> +	pin = dev->pin;
> +	if (dev->bus->number != hose->first_busno) {
> +		do {
> +			pin = ((pin-1) + PCI_SLOT(dev->devfn)) %4 + 1;
> +			/* Move up the chain of bridges. */
> +			dev = dev->bus->self;
> +		} while (dev->bus->self);
> +		/* The slot is the idsel of the last bridge. */
> +	}
> +	slot = PCI_SLOT(dev->devfn);
> +
> +	return get_pci_irq_from_of(hose, slot, pin);
> +}
> +
> +void __init mpc86xx_pcibios_fixup(void)
> +{
> +	struct pci_dev *dev = NULL;
> +
> +	for_each_pci_dev(dev) {
> +		dev->irq = mpc86xx_irq_fixup(dev);
> +		if (dev->irq < 0)
> +			return;
> +		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
> +	}
> +}
> +
> +enum pirq{PIRQA = 8, PIRQB, PIRQC, PIRQD, PIRQE, PIRQF, PIRQG, PIRQH};
> +const unsigned char uli1575_irq_route_table[16] = {
> +	0, 	/* 0: Reserved */
> +	0x8, 	/* 1: 0b1000 */
> +	0, 	/* 2: Reserved */
> +	0x2,	/* 3: 0b0010 */
> +	0x4,	/* 4: 0b0100 */
> +	0x5, 	/* 5: 0b0101 */
> +	0x7,	/* 6: 0b0111 */
> +	0x6,	/* 7: 0b0110 */
> +	0, 	/* 8: Reserved */
> +	0x1,	/* 9: 0b0001 */
> +	0x3,	/* 10: 0b0011 */
> +	0x9,	/* 11: 0b1001 */
> +	0xb,	/* 12: 0b1011 */
> +	0, 	/* 13: Reserved */
> +	0xd,	/* 14, 0b1101 */
> +	0xf,	/* 15, 0b1111 */
> +};
> +
> +
> +static void __devinit quirk_uli1575(struct pci_dev *dev)
>  {
>  	unsigned short temp;
> +	struct pci_controller *hose = pci_bus_to_hose(dev->bus->number);
> +	int i, irq;
> +	unsigned char irq2pin[16];
> +	unsigned long pirq_map_word = 0;
> +
> +	if (!hose) {
> +		printk(KERN_ERR "No PCI hose!\n");
> +		return;
> +	}
>  
>  	/*
> -	 * ALI1575 interrupts route table setup:
> +	 * ULI1575 interrupts route setup
> +	 */
> +	memset(irq2pin, 0, 16); /* Initialize default value 0 */
> +
> +	/*
> +	 * PIRQA -> PIRQD mapping read from OF-tree
> +	 *
> +	 * interrupts for PCI slot0 -- PIRQA / PIRQB / PIRQC / PIRQD
> +	 *                PCI slot1 -- PIRQB / PIRQC / PIRQD / PIRQA
> +	 */
> +	for (i = 0; i < 4; i++){
> +		irq = get_pci_irq_from_of(hose, 17, i + 1);
> +		if (irq >= 0 && irq <= 15)
> +			irq2pin[irq] = PIRQA + i;
> +	}
> +
> +	/*
> +	 * PIRQE -> PIRQF mapping set manually
>  	 *
>  	 * IRQ pin   IRQ#
> -	 * PIRQA ---- 3
> -	 * PIRQB ---- 4
> -	 * PIRQC ---- 5
> -	 * PIRQD ---- 6
>  	 * PIRQE ---- 9
>  	 * PIRQF ---- 10
>  	 * PIRQG ---- 11
>  	 * PIRQH ---- 12
> -	 *
> -	 * interrupts for PCI slot0 -- PIRQA / PIRQB / PIRQC / PIRQD
> -	 *                PCI slot1 -- PIRQB / PIRQC / PIRQD / PIRQA
>  	 */
> -	pci_write_config_dword(dev, 0x48, 0xb9317542);
> +	for (i = 0; i < 4; i++) irq2pin[i + 9] = PIRQE + i;
>  
> -	/* USB 1.1 OHCI controller 1, interrupt: PIRQE */
> -	pci_write_config_byte(dev, 0x86, 0x0c);
> +	/* Set IRQ-PIRQ Mapping to ULI1575 */
> +	for (i = 0; i < 16; i++)
> +		if (irq2pin[i])
> +			pirq_map_word |= (uli1575_irq_route_table[i] & 0xf)
> +				<< ((irq2pin[i] - PIRQA) * 4);
>  
> -	/* USB 1.1 OHCI controller 2, interrupt: PIRQF */
> -	pci_write_config_byte(dev, 0x87, 0x0d);
> +	DBG("Setup ULI1575 IRQ mapping configuration register value = 0x%x\n",
> +			pirq_map_word);
> +	pci_write_config_dword(dev, 0x48, pirq_map_word);
>  
> -	/* USB 1.1 OHCI controller 3, interrupt: PIRQH */
> -	pci_write_config_byte(dev, 0x88, 0x0f);
> +#define ULI1575_SET_DEV_IRQ(slot, pin, reg) 				\
> +	do { 								\
> +		int irq; 						\
> +		irq = get_pci_irq_from_of(hose, slot, pin); 		\
> +		if (irq >= 0 && irq <=15) 				\
> +			pci_write_config_byte(dev, reg, irq2pin[irq]); 	\
> +	} while(0)
>  
> -	/* USB 2.0 controller, interrupt: PIRQ7 */
> -	pci_write_config_byte(dev, 0x74, 0x06);
> +	/* USB 1.1 OHCI controller 1, slot 28, pin 1 */
> +	ULI1575_SET_DEV_IRQ(28, 1, 0x86);
>  
> -	/* Audio controller, interrupt: PIRQE */
> -	pci_write_config_byte(dev, 0x8a, 0x0c);
> +	/* USB 1.1 OHCI controller 2, slot 28, pin 2 */
> +	ULI1575_SET_DEV_IRQ(28, 2, 0x87);
>  
> -	/* Modem controller, interrupt: PIRQF */
> -	pci_write_config_byte(dev, 0x8b, 0x0d);
> +	/* USB 1.1 OHCI controller 3, slot 28, pin 3 */
> +	ULI1575_SET_DEV_IRQ(28, 3, 0x88);
>  
> -	/* HD audio controller, interrupt: PIRQG */
> -	pci_write_config_byte(dev, 0x8c, 0x0e);
> +	/* USB 2.0 controller, slot 28, pin 4 */
> +	irq = get_pci_irq_from_of(hose, 28, 4);
> +	if (irq >= 0 && irq <=15)
> +		pci_write_config_dword(dev, 0x74, uli1575_irq_route_table[irq]);
>  
> -	/* Serial ATA interrupt: PIRQD */
> -	pci_write_config_byte(dev, 0x8d, 0x0b);
> +	/* Audio controller, slot 29, pin 1 */
> +	ULI1575_SET_DEV_IRQ(29, 1, 0x8a);
>  
> -	/* SMB interrupt: PIRQH */
> -	pci_write_config_byte(dev, 0x8e, 0x0f);
> +	/* Modem controller, slot 29, pin 2 */
> +	ULI1575_SET_DEV_IRQ(29, 2, 0x8b);
>  
> -	/* PMU ACPI SCI interrupt: PIRQH */
> -	pci_write_config_byte(dev, 0x8f, 0x0f);
> +	/* HD audio controller, slot 29, pin 3 */
> +	ULI1575_SET_DEV_IRQ(29, 3, 0x8c);
> +
> +	/* SMB interrupt: slot 30, pin 1 */
> +	ULI1575_SET_DEV_IRQ(30, 1, 0x8e);
> +
> +	/* PMU ACPI SCI interrupt: slot 30, pin 2 */
> +	ULI1575_SET_DEV_IRQ(30, 2, 0x8f);
> +
> +	/* Serial ATA interrupt: slot 31, pin 1 */
> +	ULI1575_SET_DEV_IRQ(31, 1, 0x8d);
>  
>  	/* Primary PATA IDE IRQ: 14
>  	 * Secondary PATA IDE IRQ: 15
>  	 */
> -	pci_write_config_byte(dev, 0x44, 0x3d);
> -	pci_write_config_byte(dev, 0x75, 0x0f);
> +	pci_write_config_byte(dev, 0x44, 0x30 | uli1575_irq_route_table[14]);
> +	pci_write_config_byte(dev, 0x75, uli1575_irq_route_table[15]);
>  
>  	/* Set IRQ14 and IRQ15 to legacy IRQs */
>  	pci_read_config_word(dev, 0x46, &temp);
> @@ -277,6 +421,8 @@ static void __devinit quirk_ali1575(stru
>  	 */
>  	outb(0xfa, 0x4d0);
>  	outb(0x1e, 0x4d1);
> +
> +#undef ULI1575_SET_DEV_IRQ
>  }
>  
>  static void __devinit quirk_uli5288(struct pci_dev *dev)
> @@ -319,7 +465,7 @@ static void __devinit early_uli5249(stru
>  	dev->class |= 0x1;
>  }
>  
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x1575, quirk_ali1575);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x1575, quirk_uli1575);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5288, quirk_uli5288);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5229, quirk_uli5229);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AL, 0x5249, early_uli5249);
