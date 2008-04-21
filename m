Return-Path: <Jason.Jin@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A3185DE0D0
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 20:01:59 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m3LA1nwx029546
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 03:01:50 -0700 (MST)
Received: from zch01exm27.fsl.freescale.net (zch01exm27.ap.freescale.net
	[10.192.129.223])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m3LA1lQ6017291
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 05:01:48 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 1/3] MSI driver for Freescale 83xx/85xx/86xx cpu
Date: Mon, 21 Apr 2008 18:01:45 +0800
Message-ID: <CC27DED0F8F39E48A7E75FD768688B7A874E57@zch01exm27.fsl.freescale.net>
In-Reply-To: <1208758907.9955.4.camel@concordia>
References: <1208597267-30960-1-git-send-email-Jason.jin@freescale.com>
	<1208758907.9955.4.camel@concordia>
From: "Jin Zhengxiong" <Jason.Jin@freescale.com>
To: <michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Gala Kumar <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Michael,

Thank you very much for you input, please see my inline answer.

B.R
Jason=20

> -----Original Message-----
> From: Michael Ellerman [mailto:michael@ellerman.id.au]=20
> Sent: Monday, April 21, 2008 2:22 PM
> To: Jin Zhengxiong
> Cc: linuxppc-dev@ozlabs.org; Gala Kumar
> Subject: Re: [PATCH 1/3] MSI driver for Freescale 83xx/85xx/86xx cpu
>=20
> > This MSI driver can be used on 83xx/85xx/86xx board.
> > In this driver, virtual interrupt host and chip were
> > setup. There are 256 MSI interrupts in this host, Every 32
> > MSI interrupts cascaded to one IPIC/MPIC interrupt.
> > The chip was treated as edge sensitive and some necessary
> > functions were setup for this chip.
> >=20
> > Before using the MSI interrupt, PCI/PCIE device need to
> > ask for a MSI interrupt in the 256 MSI interrupts. A 256bit
> > bitmap show which MSI interrupt was used, reserve bit in
> > the bitmap can be used to force the device use some designate
> > MSI interrupt in the 256 MSI interrupts. Sometimes this is useful
> > for testing the all the MSI interrupts. The msi-available-ranges
> > property in the dts file was used for this purpose.
> =20
>=20
> Hi Jason, some comments inline ...
>=20
> =20
> > diff --git a/arch/powerpc/sysdev/Makefile=20
> b/arch/powerpc/sysdev/Makefile
> > index 6d386d0..bfd3fe4 100644
> > --- a/arch/powerpc/sysdev/Makefile
> > +++ b/arch/powerpc/sysdev/Makefile
> > @@ -4,6 +4,7 @@ endif
> > =20
> >  mpic-msi-obj-$(CONFIG_PCI_MSI)	+=3D mpic_msi.o=20
> mpic_u3msi.o mpic_pasemi_msi.o
> >  obj-$(CONFIG_MPIC)		+=3D mpic.o $(mpic-msi-obj-y)
> > +obj-$(CONFIG_PCI_MSI)		+=3D fsl_msi.o
>=20
> Do we really always want to build this if we have MSI? Might it depend
> on something else as well? CONFIG_FSL_PCI maybe?
>=20
I'll try to change the depend.

> > diff --git a/arch/powerpc/sysdev/fsl_msi.c=20
> b/arch/powerpc/sysdev/fsl_msi.c
> > new file mode 100644
> > index 0000000..e8132cf
> > --- /dev/null
> > +++ b/arch/powerpc/sysdev/fsl_msi.c
> > @@ -0,0 +1,457 @@
> > +/*
> > + * Copyright (C) 2007-2008 Freescale Semiconductor, Inc.=20
> All rights reserved.
> > + *
> > + * Author: Tony Li <tony.li@freescale.com>
> > + *	   Jason Jin <Jason.jin@freescale.com>
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * as published by the Free Software Foundation; version 2 of the
> > + * License.
> > + *
> > + */
> > +
> > +#include <linux/irq.h>
> > +#include <linux/bootmem.h>
> > +#include <linux/bitmap.h>
> > +#include <linux/msi.h>
> > +#include <asm/prom.h>
> > +#include <asm/hw_irq.h>
> > +#include <linux/pci.h>
> > +#include <asm/ppc-pci.h>
> > +#include <linux/of_platform.h>
> > +
> > +#include <sysdev/fsl_soc.h>
> > +#include "fsl_msi.h"
>=20
> People consider it good style to have the linux includes before the
> asm includes.
>=20
OK

> > +#ifdef DEBUG
> > +#define pr_debug(fmt...) printk(fmt)
> > +#else
> > +#define pr_debug(fmt...)
> > +#endif
>=20
> Please don't do this, just use pr_debug(). In fact I don't=20
> see where you
> do use it :)
>=20
OK.

> > +/* A bit ugly, can we get this from the pci_dev somehow? */
> > +static struct fsl_msi *fsl_msi;
>=20
> I recognise that comment :)  The answer is "no" we can't (easily) get
> this from the pci_dev.
>=20
> > +static inline u32 fsl_msi_read(u32 __iomem *base,
> > +				unsigned int reg)
>=20
> This would fit in 80 chars wouldn't it?
>=20
OK

> > +{
> > +	return in_be32(base + (reg >> 2));
> > +}
> > +
> > +static inline void fsl_msi_write(u32 __iomem *base,
> > +				unsigned int reg, u32 value)
> > +{
> > +	out_be32(base + (reg >> 2), value);
> > +}
> > +
> > +#define	fsl_msi_irq_to_hw(virq)	 ((unsigned=20
> int)irq_map[virq].hwirq)
>=20
> I can't see where this is used, you probably don't need it.
>
I'll remove this.
=20
> > +/*
> > + * We do not need this actually. The MSIR register has=20
> been read once
> > + * in the cascade interrupt. So, this MSI interrupt has been acked
> > +*/
> > +static void fsl_msi_end_irq(unsigned int virq)
> > +{
> > +}
>=20
> I guess the generic code assumes you have an ack, bummer.
>=20
Yes, the generic code did not check it.

> > +static struct irq_chip fsl_msi_chip =3D {
> > +	.mask		=3D mask_msi_irq,
> > +	.unmask		=3D unmask_msi_irq,
> > +	.ack		=3D fsl_msi_end_irq,
> > +	.typename	=3D " FSL-MSI  ",
>=20
> I'd rather you didn't try and pad the name by hand, if we=20
> want /proc/interrupts
> to look pretty we should do that in show_interrupts().
>=20
Thanks, but I feel it's easier and cleaner to add the typename here to
make=20
the /proc/interrupts clear.=20

> > +static int fsl_msi_host_match(struct irq_host *h, struct=20
> device_node *node)
> > +{
> > +	struct fsl_msi *msi =3D h->host_data;
> > +
> > +	/* Exact match, unless node is NULL */
> > +	return msi->of_node =3D=3D NULL || msi->of_node =3D=3D node;
> > +}
>=20
> Do you really want the MSI to be the default irq host?
>=20
Thanks. I'll change the host match function.

> > +static int fsl_msi_host_map(struct irq_host *h, unsigned int virq,
> > +				irq_hw_number_t hw)
> > +{
> > +	struct fsl_msi *msi =3D h->host_data;
> > +	struct irq_chip *chip =3D msi->hc_irq;
> > +
> > +	set_irq_chip_data(virq, msi);
>=20
> You don't seem to use chip_data anywhere?
>=20
I'll check this.

> > +	get_irq_desc(virq)->status |=3D IRQ_TYPE_EDGE_FALLING;
> > +
> > +	set_irq_chip_and_handler(virq, chip,  handle_edge_irq);
> > +
> > +	return 0;
> > +}
> > +
> > +static struct irq_host_ops fsl_msi_host_ops =3D {
> > +	.match =3D fsl_msi_host_match,
> > +	.map =3D fsl_msi_host_map,
> > +};
> > +
> > +irq_hw_number_t fsl_msi_alloc_hwirqs(struct fsl_msi *msi, int num)
> > +{
> > +	unsigned long flags;
> > +	int offset, order =3D get_count_order(num);
> > +
> > +	spin_lock_irqsave(&msi->bitmap_lock, flags);
> > +
> > +	offset =3D bitmap_find_free_region(msi->fsl_msi_bitmap,
> > +					NR_MSI_IRQS, order);
> > +
> > +	spin_unlock_irqrestore(&msi->bitmap_lock, flags);
> > +
> > +	pr_debug("%s: allocated 0x%x (2^%d) at offset 0x%x\n",
> > +		__func__, num, order, offset);
> > +
> > +	return offset;
> > +}
> > +
> > +void fsl_msi_free_hwirqs(struct fsl_msi *msi, int offset, int num)
> > +{
> > +	unsigned long flags;
> > +	int order =3D get_count_order(num);
> > +
> > +	pr_debug("%s: freeing 0x%x (2^%d) at offset 0x%x\n",
> > +		__func__, num, order, offset);
> > +
> > +	spin_lock_irqsave(&msi->bitmap_lock, flags);
> > +	bitmap_release_region(msi->fsl_msi_bitmap, offset, order);
> > +	spin_unlock_irqrestore(&msi->bitmap_lock, flags);
> > +}
> > +
> > +static int fsl_msi_reserve_dt_hwirqs(struct fsl_msi *msi)
> > +{
> > +	int i, len;
> > +	const u32 *p;
> > +
> > +	p =3D of_get_property(msi->of_node, "msi-available-ranges", &len);
> > +	if (!p) {
> > +		pr_debug("fsl_msi: no msi-available-ranges=20
> property found \
> > +				on %s\n", msi->of_node->full_name);
> > +		return -ENODEV;
> > +	}
> > +
> > +	if (len & 0x8 !=3D 0) {
> > +		printk(KERN_WARNING "fsl_msi: Malformed=20
> msi-available-ranges "
> > +		       "property on %s\n", msi->of_node->full_name);
> > +		return -EINVAL;
> > +	}
>=20
> Do you really want a bitwise and with 0x8?
>=20
The range for the msi interrupt can be seperated to several part.=20
This can used to check the if the ranges is correct.=20

> > +
> > +	bitmap_allocate_region(msi->fsl_msi_bitmap, 0,
> > +			       get_count_order(msi->irq_count));
> > +
> > +	/* Format is: (<u32 start> <u32 count>)+ */
> > +	len /=3D sizeof(u32);
> > +	len /=3D 2;
> > +	for (i =3D 0; i < len; i++, p +=3D 2)
> > +		fsl_msi_free_hwirqs(msi, *p, *(p + 1));
> > +
> > +	return 0;
> > +}
>=20
> We could share a bunch of that code with mpic_msi.c, but=20
> that's not your
> job - I'll look at doing a patch once this goes in.
>=20
Thanks for the code you write for the MPIC msi.
 I'll use this until you share the code.

> > +static int fsl_msi_init_allocator(struct fsl_msi *msi)
> > +{
> > +	int rc, size;
> > +
> > +	size =3D BITS_TO_LONGS(NR_MSI_IRQS) * sizeof(long);
> > +
> > +	msi->fsl_msi_bitmap =3D kmalloc(size, GFP_KERNEL);
> > +
> > +	if (msi->fsl_msi_bitmap =3D=3D NULL) {
> > +		pr_debug("%s: ENOMEM allocating allocator bitmap!\n",
> > +				__func__);
> > +		return -ENOMEM;
> > +	}
> > +	memset(msi->fsl_msi_bitmap, 0, size);
>=20
> Use kzalloc() and you can lose the memset.
>=20
OK.

> > +	rc =3D fsl_msi_reserve_dt_hwirqs(msi);
>=20
> This routine is badly named (my fault), it really frees the available
> MSI ranges.
>=20
> > +	if (rc)
> > +		goto out_free;
> > +
> > +	return 0;
> > +out_free:
> > +	if (mem_init_done)
> > +		kfree(msi->fsl_msi_bitmap);
>=20
> You don't need to test mem_init_done, this is running at initcall time
> which is way later than mem_init.
>=20
Yes, I'll remove this. This code once used at just after the mpic was
intialized,and this
was left here.

> > +	msi->fsl_msi_bitmap =3D NULL;
> > +	return rc;
> > +
> > +}
> > +
> > +static int fsl_msi_check_device(struct pci_dev *pdev, int=20
> nvec, int type)
> > +{
> > +	if (type =3D=3D PCI_CAP_ID_MSIX)
> > +		pr_debug("fslmsi: MSI-X untested, trying anyway.\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static void fsl_teardown_msi_irqs(struct pci_dev *pdev)
> > +{
> > +	struct msi_desc *entry;
> > +	struct fsl_msi *msi =3D fsl_msi;
> > +
> > +	list_for_each_entry(entry, &pdev->msi_list, list) {
> > +		if (entry->irq =3D=3D NO_IRQ)
> > +			continue;
> > +		set_irq_msi(entry->irq, NULL);
> > +		fsl_msi_free_hwirqs(msi, virq_to_hw(entry->irq), 1);
> > +		irq_dispose_mapping(entry->irq);
> > +	}
> > +
> > +	return;
> > +}
> > +
> > +static void fsl_compose_msi_msg(struct pci_dev *pdev, int hwirq,
> > +				  struct msi_msg *msg)
> > +{
> > +	unsigned int srs;
> > +	unsigned int ibs;
> > +	struct fsl_msi *msi =3D fsl_msi;
> > +
> > +	srs =3D hwirq / INT_PER_MSIR;
> > +	ibs =3D hwirq % INT_PER_MSIR;
> > +
> > +	msg->address_lo =3D msi->msi_addr_lo;
> > +	msg->address_hi =3D msi->msi_addr_hi;
> > +	msg->data =3D (srs << 5) | (ibs & 0x1F);
>=20
> Is the 5 and 0x1F independent of the INT_PER_MSIR value? Given the
> current values isn't this a no-op, or am I missing something?
>=20
Do you mean there're another way to get the msg->data from the hwirq? =20

> > +	pr_debug("%s: allocated srs: %d, ibs: %d\n",
> > +		__func__, srs, ibs);
> > +}
> > +
> > +static int fsl_setup_msi_irqs(struct pci_dev *pdev, int=20
> nvec, int type)
> > +{
> > +	irq_hw_number_t hwirq;
> > +	int rc;
> > +	unsigned int virq;
> > +	struct msi_desc *entry;
> > +	struct msi_msg msg;
> > +	struct fsl_msi *msi =3D fsl_msi;
>=20
> A couple of places you put this into a local called "msi"=20
> which is not the
> greatest name in the world IMHO :)
>=20
Thank you, I'll try to use another name, Do you have any suggestion?

> > +	list_for_each_entry(entry, &pdev->msi_list, list) {
> > +		hwirq =3D fsl_msi_alloc_hwirqs(msi, 1);
> > +		if (hwirq < 0) {
> > +			rc =3D hwirq;
> > +			pr_debug("%s: fail allocating msi interrupt\n",
> > +					__func__);
> > +			goto out_free;
> > +		}
> > +
> > +		virq =3D irq_create_mapping(msi->irqhost, hwirq);
> > +
> > +		if (virq =3D=3D NO_IRQ) {
> > +			pr_debug("%s: fail mapping hwirq 0x%lx\n",
> > +					__func__, hwirq);
> > +			fsl_msi_free_hwirqs(msi, hwirq, 1);
> > +			rc =3D -ENOSPC;
> > +			goto out_free;
> > +		}
> > +		set_irq_msi(virq, entry);
> > +
> > +		fsl_compose_msi_msg(pdev, hwirq, &msg);
> > +		write_msi_msg(virq, &msg);
> > +	}
> > +	return 0;
> > +
> > +out_free:
> > +	fsl_teardown_msi_irqs(pdev);
>=20
> You don't need to call teardown, the generic code does that for you.
>=20
OK.

> > +	return rc;
> > +}
> > +
> > +void fsl_msi_cascade(unsigned int irq, struct irq_desc *desc)
> > +{
> > +	unsigned int cascade_irq;
> > +	struct fsl_msi *msi =3D fsl_msi;
> > +	int msir_index =3D -1;
> > +	int i;
> > +	u32 msir_value =3D 0;
> > +	u32 intr_index;
> > +	u32 have_shift =3D 0;
> > +
> > +	spin_lock(&desc->lock);
> > +	if ((msi->feature &  FSL_PIC_IP_MASK) =3D=3D FSL_PIC_IP_IPIC) {
> > +		if (desc->chip->mask_ack)
> > +			desc->chip->mask_ack(irq);
> > +		else {
> > +			desc->chip->mask(irq);
> > +			desc->chip->ack(irq);
> > +		}
> > +	}
> > +
> > +	if (unlikely(desc->status & IRQ_INPROGRESS))
> > +		goto unlock;
> > +
> > +	for (i =3D 0; i < NR_MSIR; i++)
> > +		if (irq =3D=3D msi->msir[i]) {
> > +			msir_index =3D i;
> > +			break;
> > +		}
>=20
> This is a bit ugly :)  Because you get the *msi from fsl_msi=20
> (above), you could
> store the msir_index in the handler_data (with set_irq_data),=20
> and save doing
> this loop.
>=20
I'll find if the handler data *msi was used somewhere. if not I change
to
save the msir_index to the handler data.=20

> > +	if (i >=3D NR_MSIR)
> > +		cascade_irq =3D NO_IRQ;
> > +
> > +	desc->status |=3D IRQ_INPROGRESS;
> > +	switch (fsl_msi->feature & FSL_PIC_IP_MASK) {
> > +	case FSL_PIC_IP_MPIC:
> > +		msir_value =3D fsl_msi_read(msi->msi_regs,=20
> msir_index * 0x10);
> > +		break;
> > +	case FSL_PIC_IP_IPIC:
> > +		msir_value =3D fsl_msi_read(msi->msi_regs,=20
> msir_index * 0x4);
> > +		break;
> > +	}
> > +
> > +	while (msir_value) {
> > +		intr_index =3D ffs(msir_value) - 1;
> > +
> > +		cascade_irq =3D irq_linear_revmap(msi->irqhost,
> > +			(msir_index * INT_PER_MSIR + intr_index=20
> + have_shift));
> > +
> > +		if (cascade_irq !=3D NO_IRQ)
> > +			generic_handle_irq(cascade_irq);
> > +		have_shift +=3D (intr_index + 1);
> > +		msir_value =3D (msir_value >> (intr_index + 1));
> > +	}
>=20
> It took me a while to grok all the shifting and so on here, I=20
> don't know if
> there's a cleaner way to do it.
>=20
To improve the efficency here, I tried to use the bit operation which
can=20
carry out by the cpu with one instruction. Maybe I also need to improve=20
readability :).

> > +	desc->status &=3D ~IRQ_INPROGRESS;
> > +
> > +	switch (fsl_msi->feature & FSL_PIC_IP_MASK) {
> > +	case FSL_PIC_IP_MPIC:
> > +		desc->chip->eoi(irq);
> > +		break;
> > +	case FSL_PIC_IP_IPIC:
> > +		if (!(desc->status & IRQ_DISABLED) &&=20
> desc->chip->unmask)
> > +		desc->chip->unmask(irq);
>=20
> Missing indent.
>=20
OK.

> > +		break;
> > +	}
> > +unlock:
> > +	spin_unlock(&desc->lock);
> > +}
> > +
> > +static int __devinit fsl_of_msi_probe(struct of_device *dev,
> > +				const struct of_device_id *match)
> > +{
> > +	struct fsl_msi *msi;
> > +	struct resource res;
> > +	int err, i, count;
> > +	int rc;
> > +	int virt_msir;
> > +	const u32 *p;
> > +	struct fsl_msi_data *tmp_data;
> > +
> > +	printk(KERN_INFO "Setting up fsl msi support\n");
>=20
> KERN_DEBUG would do here IMHO, users don't usually need to see it.
>=20
> > +	msi =3D kzalloc(sizeof(struct fsl_msi), GFP_KERNEL);
> > +	if (!msi) {
> > +		dev_err(&dev->dev, "No memory for MSI structure\n");
> > +		err =3D -ENOMEM;
> > +		goto error_out;
> > +	}
> > +
> > +	msi->of_node =3D dev->node;
> > +
> > +	msi->irqhost =3D irq_alloc_host(of_node_get(dev->node),
> > +				IRQ_HOST_MAP_LINEAR,
> > +				NR_MSI_IRQS, &fsl_msi_host_ops, 0);
> > +	if (msi->irqhost =3D=3D NULL) {
> > +		dev_err(&dev->dev, "No memory for MSI irqhost\n");
> > +		err =3D -ENOMEM;
>=20
> You need an of_node_put(dev->node) in the error case here.
>=20
Thanks, I'll add it.

> > +		goto error_out;
> > +	}
> > +
> > +	/*Get the MSI reg base */
>=20
> Missing space after /*
>=20
> > +	err =3D of_address_to_resource(dev->node, 0, &res);
> > +	if (err) {
> > +		dev_err(&dev->dev, "Can't get %s property 'reg'\n",
> > +				dev->node->full_name);
>=20
> That's a little misleading, aren't there's lots of reasons
> of_address_to_resource() might fail?
>=20
> > +		goto error_out;
> > +	}
> > +
> > +	msi->msi_regs =3D ioremap(res.start, res.end - res.start + 1);
>=20
> ioremap() can fail.
>=20
OK,  I'll add the error process code here.

> > +	tmp_data =3D (struct fsl_msi_data *)match->data;
> > +
> > +	msi->feature =3D tmp_data->fsl_pic_ip;
> > +
> > +	msi->irqhost->host_data =3D msi;
> > +	msi->hc_irq =3D &fsl_msi_chip;
>=20
> Any reason this needs to be a variable, isn't it always &fsl_msi_chip?
>=20
> > +	msi->msi_addr_hi =3D 0x0;
> > +	msi->msi_addr_lo =3D res.start + tmp_data->msiir_offset;
> > +
> > +	msi->irq_count =3D NR_MSI_IRQS;
>=20
> Ditto.
>=20
> > +	p =3D of_get_property(dev->node, "interrupts", &count);
> > +	if (!p) {
> > +		dev_err(&dev->dev, "no msi-interrupts property=20
> found on %s\n",
> > +				dev->node->full_name);
> > +		err =3D -ENODEV;
> > +		goto error_out;
> > +	}
> > +	if (count % 8 !=3D 0) {
> > +		dev_err(&dev->dev, "Malformed msi-interrupts=20
> property on %s\n",
> > +				dev->node->full_name);
>=20
> Messages don't match the code, "interrupts" vs "msi-interrupts".
>=20
Thanks, I'll change the description.

> > +		err =3D -EINVAL;
> > +		goto error_out;
> > +	}
> > +
> > +	count /=3D sizeof(u32);
> > +	for (i =3D 0; i < count / 2; i++) {
> > +		if (i > NR_MSIR)
> > +			break;
> > +		virt_msir =3D irq_of_parse_and_map(dev->node, i);
> > +		if (virt_msir !=3D NO_IRQ) {
> > +			set_irq_data(virt_msir, msi);
> > +			set_irq_chained_handler(virt_msir,=20
> fsl_msi_cascade);
> > +			msi->msir[i] =3D virt_msir;
> > +		} else
> > +			msi->msir[i] =3D NO_IRQ;
> > +	}
> > +
> > +	rc =3D fsl_msi_init_allocator(msi);
> > +	if (rc) {
> > +		dev_err(&dev->dev, "Error allocating MSI bitmap\n");
>=20
> If you hit this then the error case needs to get rid of all=20
> the irq mappings
> you created just above (which it doesn't). It would be=20
> simpler if you just move
> this call above the for loop, then you don't need to worry about it.
>
Thanks, good idea.
=20
> > +		goto error_out;
> > +	}
> > +
> > +	fsl_msi =3D msi;
> > +
> > +	WARN_ON(ppc_md.setup_msi_irqs);
> > +	ppc_md.setup_msi_irqs =3D fsl_setup_msi_irqs;
> > +	ppc_md.teardown_msi_irqs =3D fsl_teardown_msi_irqs;
> > +	ppc_md.msi_check_device =3D fsl_msi_check_device;
> > +	return 0;
> > +error_out:
> > +	if (msi)
> > +		kfree(msi);
>=20
> kfree(NULL) is fine.
>=20
> > +	return err;
> > +}
> > +
> > +static const struct fsl_msi_data mpic_msi_feature =3D=20
> {FSL_PIC_IP_MPIC, 0x140};
> > +static const struct fsl_msi_data ipic_msi_feature =3D=20
> {FSL_PIC_IP_IPIC, 0x38};
> > +
> > +static const struct of_device_id fsl_of_msi_ids[] =3D {
> > +	{
> > +		.compatible =3D "fsl,MPIC-MSI",
> > +		.data =3D (void *)&mpic_msi_feature,
> > +	},
> > +	{
> > +		.compatible =3D "fsl,IPIC-MSI",
> > +		.data =3D (void *)&ipic_msi_feature,
> > +	},
> > +	{}
> > +};
> > +
> > +static struct of_platform_driver fsl_of_msi_driver =3D {
> > +	.name =3D "fsl-of-msi",
> > +	.match_table =3D fsl_of_msi_ids,
> > +	.probe =3D fsl_of_msi_probe,
> > +};
> > +
> > +static __init int fsl_of_msi_init(void)
> > +{
> > +	return of_register_platform_driver(&fsl_of_msi_driver);
> > +}
> > +
> > +subsys_initcall(fsl_of_msi_init);
> > diff --git a/arch/powerpc/sysdev/fsl_msi.h=20
> b/arch/powerpc/sysdev/fsl_msi.h
> > new file mode 100644
> > index 0000000..7eef9ec
> > --- /dev/null
> > +++ b/arch/powerpc/sysdev/fsl_msi.h
> > @@ -0,0 +1,40 @@
> > +#ifndef _ASM_POWERPC_MSI_H
> > +#define _ASM_POWERPC_MSI_H
>=20
> Include guards don't match the filename, should be=20
> _POWERPC_SYSDEV_FSL_MSI_H
>=20
OK.

> > +#define NR_MSIR	8
> > +#define INT_PER_MSIR	32
> > +#define NR_MSI_IRQS	(NR_MSIR * INT_PER_MSIR)
> > +
> > +#define FSL_PIC_IP_MASK	0x0000000F
> > +#define FSL_PIC_IP_MPIC	0x00000001
> > +#define FSL_PIC_IP_IPIC	0x00000002
> > +
> > +struct fsl_msi {
> > +	/* Device node of the MSI interrupt*/
> > +	struct device_node *of_node;
> > +
> > +	struct irq_host *irqhost;
> > +	struct irq_chip *hc_irq;
> > +
> > +	unsigned long cascade_irq;
> > +	unsigned int msir[NR_MSIR];
> > +
> > +	u32 msi_addr_lo;
> > +	u32 msi_addr_hi;
> > +	void __iomem *msi_regs;
> > +	u32 irq_count;
> > +	u32 feature;
> > +
> > +	spinlock_t fsl_msi_lock;
>=20
> Unused?
>=20
> > +	unsigned long *fsl_msi_bitmap;
>=20
> Do we need fsl_msi in the name?
>=20
> > +	spinlock_t bitmap_lock;
> > +	const char *name;
>=20
> Unused?
>=20
> > +};
> > +
> > +struct fsl_msi_data {
> > +	u32 fsl_pic_ip;
> > +	u32 msiir_offset;
> > +};
> > +
> > +#endif /* _ASM_POWERPC_MSI_H */
> > +
> > diff --git a/arch/powerpc/sysdev/fsl_pci.c=20
> b/arch/powerpc/sysdev/fsl_pci.c
> > index bf13c21..fede767 100644
> > --- a/arch/powerpc/sysdev/fsl_pci.c
> > +++ b/arch/powerpc/sysdev/fsl_pci.c
> > @@ -106,6 +106,16 @@ void __init setup_pci_cmd(struct=20
> pci_controller *hose)
> >  	}
> >  }
> > =20
> > +#ifdef CONFIG_PCI_MSI
> > +void __init setup_pci_pcsrbar(struct pci_controller *hose)
> > +{
> > +	phys_addr_t immr_base;
> > +
> > +	immr_base =3D get_immrbase();
> > +	early_write_config_dword(hose, 0, 0,=20
> PCI_BASE_ADDRESS_0, immr_base);
> > +}
> > +#endif
>=20
> Up to you, but I prefer an empty static inline here which=20
> saves an #ifdef
> at the call site.
>=20
> >  static int fsl_pcie_bus_fixup;
> > =20
> >  static void __init quirk_fsl_pcie_header(struct pci_dev *dev)
> > @@ -211,6 +221,10 @@ int __init fsl_add_bridge(struct=20
> device_node *dev, int is_primary)
> >  	/* Setup PEX window registers */
> >  	setup_pci_atmu(hose, &rsrc);
> > =20
> > +	/*Setup PEXCSRBAR */
> > +#ifdef CONFIG_PCI_MSI
> > +	setup_pci_pcsrbar(hose);
> > +#endif
> >  	return 0;
> >  }
>=20
>=20
> cheers
>=20
