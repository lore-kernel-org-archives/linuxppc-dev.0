Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5F3E6B6F04
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  4 Jan 2010 17:25:47 +1100 (EST)
Subject: Re: [PATCH 2/2] Adding PCI-E MSI support for PowerPC 460SX SOC.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: tmarri@amcc.com
In-Reply-To: <1261639722-12614-1-git-send-email-tmarri@amcc.com>
References: <1261639722-12614-1-git-send-email-tmarri@amcc.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 04 Jan 2010 17:25:27 +1100
Message-ID: <1262586327.2173.365.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, writetomarri@yahoo.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-12-23 at 23:28 -0800, tmarri@amcc.com wrote:
> From: Tirumala Marri <tmarri@amcc.com>
> 
> 
> Signed-off-by: Tirumala Marri <tmarri@amcc.com>
> ---
> 	When 460SX configured as root as a end point E1000(Intell Ethernet card)
> 	was plugged into the one of the PCI-E ports. I was able to run the traffic
> 	with MSI interrupts.

So before I even ack or nack that patch, I need to better understand how
your HW works. I've read the doc of the 460EX twice and still don't
quite get it :-)

So my understanding so far is that when reception of MSIs is enabled,
writes to some magic address in the first 1K of BAR0 are interpreted ad
MSIs. The MSI interrupt value (low 16 bits of the 32-bit store in little
endian) is thus interpreted as an interrupt number and send to the UIC.

Is that correct ?

Now, which UIC ? There are at least 3 in the 460EX for example :-)

Also, UICs have a limited amount of inputs and I don't see many
interrupt sources "reserved" for use as MSIs, can you enlighten me a bit
more on how you get to choose an interrupt source to use as MSI ?

Or is there some translation done ? IE. In the 460EX manual, there seem
to be specific interrupt numbers dedicated to PCI0 MSI 0, 1 2 and 3
spread between UIC0 and UIC1, and a block of 8 interrupts in UIC3
reserved for PCI-E MSIs. Is there a renumbering done in HW here ?

IE. Your table shows for 460EX for example that PCI-E MSI 2 is UIC3
input 26. Do I need thus to program the device to write a "2" in the MSI
message or "26" to hit that interrupt ?

IE. Are you running the input message through a binary decoder that then
spreads into various UIC input lines ?

Now some comments:

> diff --git a/arch/powerpc/boot/dts/redwood.dts b/arch/powerpc/boot/dts/redwood.dts
> index 81636c0..6c20faf 100644
> --- a/arch/powerpc/boot/dts/redwood.dts
> +++ b/arch/powerpc/boot/dts/redwood.dts
> @@ -357,6 +357,21 @@
>  				0x0 0x0 0x0 0x3 &UIC3 0xa 0x4 /* swizzled int C */
>  				0x0 0x0 0x0 0x4 &UIC3 0xb 0x4 /* swizzled int D */>;
>  		};
> +  		MSI: ppc4xx-msi@400300000 {
> +  			compatible = "amcc,ppc4xx-460sx-msi", "ppc4xx-msi";
> +  			reg = < 0x4 0x00300000 0x100
> +  				0x4 0x00300000 0x100>;
> +  			sdr-base = <0x3B0>;
> +  			interrupts =<0 1 2 3>;
> +  			interrupt-parent = <&MSI>;
> +  			#interrupt-cells = <1>;
> +  			#address-cells = <0>;
> +  			#size-cells = <0>;
> +  			interrupt-map = <0 &UIC0 0xC 1
> +  				1 &UIC0 0x0D 1
> +  				2 &UIC0 0x0E 1
> +  				3 &UIC0 0x0F 1>;
> +  		};

Wow ! That's the mother of all device-tree hacks :-) So you are using
the "interrupts" property of the MSI node to represent the MSI
interrupts you hand out, and you make it its own interrupt-parent, using
an interrupt-map in itself to convert them into UIC interrupts :-)
Sneaky... Hell, it will work so why not ?

> +static struct ppc4xx_msi *ppc4xx_msi;
> +
> +struct ppc4xx_msi_feature {
> +	u32 ppc4xx_pic_ip;
> +	u32 msiir_offset;
> +};
> +
> +static int ppc4xx_msi_init_allocator(struct ppc4xx_msi *msi_data)
> +{
> +	int rc;
> +
> +	rc = msi_bitmap_alloc(&msi_data->bitmap, NR_MSI_IRQS,
> +				msi_data->irqhost->of_node);
> +	if (rc)
> +		return rc;
> +	rc = msi_bitmap_reserve_dt_hwirqs(&msi_data->bitmap);
> +	if (rc < 0) {
> +		msi_bitmap_free(&msi_data->bitmap);
> +		return rc;
> +	}
> +	return 0;
> +}

Ok so here I start having problems :-) First you allocate a bitmap for
the MSIs of a fixed number, despite the fact that there seem to be a
different number of MSIs supported depending on what part/bridge you are
using. Then, you try to call msi_bitmap_reserve_dt_hwirqs()... why
that ? This is meant to be used when you don't know what interrupt
numbers are reserved for use by MSIs in your system, it's a bit fishy to
be honest, we use it on powermac mostly :-)

> +static void ppc4xx_msi_cascade(unsigned int irq, struct irq_desc *desc)
> +{
> +	unsigned int cascade_irq;
> +	struct ppc4xx_msi *msi_data = ppc4xx_msi;
> +	int msir_index = -1;
> +
> +	raw_spin_lock(&desc->lock);
> +	if (desc->chip->mask_ack) {
> +		desc->chip->mask_ack(irq);
> +	} else {
> +		desc->chip->mask(irq);
> +		desc->chip->ack(irq);
> +	}
> +
> +	if (unlikely(desc->status & IRQ_INPROGRESS))
> +		goto unlock;
> +
> +	msir_index = (int)desc->handler_data;
> +
> +	if (msir_index >= NR_MSI_IRQS)
> +		cascade_irq = NO_IRQ;
> +
> +	desc->status |= IRQ_INPROGRESS;
> +
> +	cascade_irq = irq_linear_revmap(msi_data->irqhost, msir_index);
> +	if (cascade_irq != NO_IRQ)
> +		generic_handle_irq(cascade_irq);
> +	desc->status &= ~IRQ_INPROGRESS;
> +
> +	if (!(desc->status & IRQ_DISABLED) && desc->chip->unmask)
> +		desc->chip->unmask(irq);
> +unlock:
> +	raw_spin_unlock(&desc->lock);
> +}

Now, that's really a weird idea. Why are you making it a cascaded
interrupt controller ? That is just gratuitous overhead. You could have
the MSI handling directly hand out the appropriate UIC interrupts and
have them call directly into the driver. The above adds significant
overhead to MSI processing.

> +static void ppc4xx_compose_msi_msg(struct pci_dev *pdev, int hwirq,
> +					struct msi_msg *msg)
> +{
> +	struct ppc4xx_msi *msi_data = ppc4xx_msi;
> +
> +	msg->address_lo = msi_data->msi_addr_lo;
> +	msg->address_hi = msi_data->msi_addr_hi;
> +	msg->data = hwirq;
> +}
> +
> +int ppc4xx_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
> +{
> +	struct msi_desc *entry;
> +	int rc, hwirq;
> +	unsigned int virq;
> +	struct msi_msg msg;
> +	struct ppc4xx_msi *msi_data = ppc4xx_msi;
> +
> +
> +	list_for_each_entry(entry, &dev->msi_list, list) {
> +		hwirq = msi_bitmap_alloc_hwirqs(&msi_data->bitmap, 1);
> +		if (hwirq < 0) {
> +			rc = hwirq;
> +			dev_err(&dev->dev, "%s: fail allocating msi\
> +					interrupt\n",	__func__);
> +			goto out_free;
> +		}
> +
> +		pr_debug(KERN_INFO"mis is %p\n", msi_data->irqhost);
> +		virq = irq_create_mapping(msi_data->irqhost, hwirq);
> +		if (virq == NO_IRQ) {
> +			dev_err(&dev->dev, "%s: fail mapping irq\n", __func__);
> +			rc = -ENOSPC;
> +			goto out_free;
> +		}
> +
> +		set_irq_msi(virq, entry);
> +		ppc4xx_compose_msi_msg(dev, hwirq, &msg);
> +		write_msi_msg(virq, &msg);
> +	}
> +
> +	return 0;
> +out_free:
> +	return rc;
> +}

Similar here. You create this whole layer of secondary interrupt host
while you could just hand out existing UIC interrupts no ?
 
 .../...

> +
> +static int __devinit ppc4xx_msi_probe(struct of_device *dev,
> +					const struct of_device_id *match)
> +{
> +	struct ppc4xx_msi *msi;
> +	struct resource res, rmsi;
> +	int i, count;
> +	int rc;
> +	int virt_msir;
> +	const u32 *p;
> +	const u32 *sdr_base;
> +	u32 *msi_virt = NULL;
> +	dma_addr_t msi_phys;
> +
> +
> +	msi = kzalloc(sizeof(struct ppc4xx_msi), GFP_KERNEL);
> +	if (!msi) {
> +		dev_err(&dev->dev, "No memory for MSI structure\n");
> +		rc = -ENOMEM;
> +		goto error_out;
> +	}
> +
> +	msi->irqhost = irq_alloc_host(dev->node, IRQ_HOST_MAP_LINEAR,
> +				      NR_MSI_IRQS, &ppc4xx_msi_host_ops, 0);
> +	if (msi->irqhost == NULL) {
> +		dev_err(&dev->dev, "No memory for MSI irqhost\n");
> +		rc = -ENOMEM;
> +		goto error_out;
> +	}

Same comment, ie, why a separate irq host ?

> +
> +	/* Get MSI ranges */
> +	rc = of_address_to_resource(dev->node, 0, &rmsi);
> +	if (rc) {
> +		dev_err(&dev->dev, "%s resource error!\n",
> +				dev->node->full_name);
> +		goto error_out;
> +	}
> +
> +
> +	/* Get the MSI reg base */
> +	rc = of_address_to_resource(dev->node, 1, &res);
> +	if (rc) {
> +		dev_err(&dev->dev, "%s resource error!\n",
> +				dev->node->full_name);
> +		goto error_out;
> +	}
> +	/* Get the sdr-base */
> +	sdr_base = (u32 *)of_get_property(dev->node, "sdr-base", NULL);
> +	if (sdr_base == NULL) {
> +		dev_err(&dev->dev, "%s resource error!\n",
> +				dev->node->full_name);
> +		goto error_out;
> +	}
> +	msi->sdr_base = *sdr_base;
> +	mtdcri(SDR0, msi->sdr_base, res.start >> 32);
> +	mtdcri(SDR0, msi->sdr_base + 1, res.start & 0xFFFFFFFF);
> +	msi->msi_regs = ioremap(res.start, res.end - res.start + 1);
> +	if (!msi->msi_regs) {
> +		dev_err(&dev->dev, "ioremap problem failed\n");
> +		goto error_out;
> +	}
> +	/* MSI region always mapped in 4GB region*/
> +	msi->msi_addr_hi = 0x0;
> +	msi_virt = dma_alloc_coherent(&dev->dev, 64, &msi_phys,
> +			GFP_KERNEL);
> +	if (msi_virt == NULL) {
> +		dev_err(&dev->dev, "No memory for MSI mem space\n");
> +		rc = -ENOMEM;
> +		goto error_out;
> +	}
> +	msi->msi_addr_lo = (u32)msi_phys;

Now, what is the above for ? Are the MSI writes done by the device
actually hitting memory as well ? I would have expected them to be
filtered by the bridge on the way up, are they not ?

I suppose it gives you a cheap way to obtain a bit of unused address
space...

> +	/* Progam the Interrupt handler Termination addr registers */
> +	out_be32(msi->msi_regs + PEIH_TERMADH, msi->msi_addr_hi);
> +	out_be32(msi->msi_regs + PEIH_TERMADL, msi->msi_addr_lo);
> +
> +	/* Program MSI Expected data and Mask bits */
> +	out_be32(msi->msi_regs + PEIH_MSIED, MSI_DATA_PATTERN);
> +	out_be32(msi->msi_regs + PEIH_MSIMK, MSI_DATA_PATTERN);

Can you tell me a bit more about what the above is about ?

Also, it looks like your code would work for other SoCs like 460EX
etc... by just updating the .dts right ? Care to update a few more
boards so I can test on my canyonlands ? :-)

Cheers,
Ben.
