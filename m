Return-Path: <Jason.Jin@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F2150DDEEB
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 13:39:46 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m3T3deKJ023731
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 20:39:40 -0700 (MST)
Received: from zch01exm27.fsl.freescale.net (zch01exm27.ap.freescale.net
	[10.192.129.223])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m3T3dcm8006023
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 22:39:39 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v2] MSI driver for Freescale 83xx/85xx/86xx cpu
Date: Tue, 29 Apr 2008 11:39:39 +0800
Message-ID: <CC27DED0F8F39E48A7E75FD768688B7A8754CB@zch01exm27.fsl.freescale.net>
In-Reply-To: <65D1ED37-6B8D-436C-A994-E8764922FE6D@freescale.com>
References: <1208857064-26863-1-git-send-email-Jason.jin@freescale.com>
	<65D1ED37-6B8D-436C-A994-E8764922FE6D@freescale.com>
From: "Jin Zhengxiong" <Jason.Jin@freescale.com>
To: "Gala Kumar" <kumar.gala@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Gala Kumar=20
> Sent: Tuesday, April 22, 2008 9:38 PM
> To: Jin Zhengxiong
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH v2] MSI driver for Freescale 83xx/85xx/86xx cpu
>=20
> > diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/=20
> > Makefile index 6d386d0..e60a238 100644
> > --- a/arch/powerpc/sysdev/Makefile
> > +++ b/arch/powerpc/sysdev/Makefile
> > @@ -4,6 +4,7 @@ endif
> >
> > mpic-msi-obj-$(CONFIG_PCI_MSI)	+=3D mpic_msi.o mpic_u3msi.o =20
> > mpic_pasemi_msi.o
> > obj-$(CONFIG_MPIC)		+=3D mpic.o $(mpic-msi-obj-y)
> > +obj-$(CONFIG_FSL_PCI)		+=3D fsl_msi.o
>=20
> can we do something like:
> fsl_pci-$(CONFIG_MSI)           +=3D fsl_msi.o
> obj-$(CONFIG_FSL_PCI)           +=3D fsl_pci.o $(fsl_pci-y)
>=20
> > obj-$(CONFIG_PPC_MPC106)	+=3D grackle.o
> > obj-$(CONFIG_PPC_DCR_NATIVE)	+=3D dcr-low.o

OK, Thanks

>=20
> > +static int fsl_msi_init_allocator(struct fsl_msi *msi_data) {
> > +	int rc, size;
> > +
> > +	size =3D BITS_TO_LONGS(NR_MSI_IRQS) * sizeof(long);
>=20
> should this be long or u32?
>=20
> > +
> > +	msi_data->fsl_msi_bitmap =3D kzalloc(size, GFP_KERNEL);
> > +
> > +	if (msi_data->fsl_msi_bitmap =3D=3D NULL) {
> > +		pr_debug("%s: ENOMEM allocating allocator bitmap!\n",
> > +				__func__);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	rc =3D fsl_msi_free_dt_hwirqs(msi_data);
> > +	if (rc)
> > +		goto out_free;
> > +
> > +	return 0;
> > +out_free:
> > +	kfree(msi_data->fsl_msi_bitmap);
> > +
> > +	msi_data->fsl_msi_bitmap =3D NULL;
> > +	return rc;
> > +
> > +}
> > +
> > +static int fsl_msi_check_device(struct pci_dev *pdev, int nvec, int
> > type)
> > +{
> > +	if (type =3D=3D PCI_CAP_ID_MSIX)
> > +		pr_debug("fslmsi: MSI-X untested, trying anyway.\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static void fsl_teardown_msi_irqs(struct pci_dev *pdev) {
> > +	struct msi_desc *entry;
> > +	struct fsl_msi *msi_data =3D fsl_msi;
> > +
> > +	list_for_each_entry(entry, &pdev->msi_list, list) {
> > +		if (entry->irq =3D=3D NO_IRQ)
> > +			continue;
> > +		set_irq_msi(entry->irq, NULL);
> > +		fsl_msi_free_hwirqs(msi_data,=20
> virq_to_hw(entry->irq), 1);
> > +		irq_dispose_mapping(entry->irq);
> > +	}
> > +
> > +	return;
> > +}
> > +
> > +static void fsl_compose_msi_msg(struct pci_dev *pdev, int hwirq,
> > +				  struct msi_msg *msg)
> > +{
> > +	struct fsl_msi *msi_data =3D fsl_msi;
> > +
> > +	msg->address_lo =3D msi_data->msi_addr_lo;
> > +	msg->address_hi =3D msi_data->msi_addr_hi;
> > +	msg->data =3D hwirq;
> > +
> > +	pr_debug("%s: allocated srs: %d, ibs: %d\n",
> > +		__func__, hwirq / INT_PER_MSIR, hwirq % INT_PER_MSIR); }
> > +
> > +static int fsl_setup_msi_irqs(struct pci_dev *pdev, int nvec, int
> > type)
> > +{
> > +	irq_hw_number_t hwirq;
> > +	int rc;
> > +	unsigned int virq;
> > +	struct msi_desc *entry;
> > +	struct msi_msg msg;
> > +	struct fsl_msi *msi_data =3D fsl_msi;
> > +
> > +	list_for_each_entry(entry, &pdev->msi_list, list) {
> > +		hwirq =3D fsl_msi_alloc_hwirqs(msi_data, 1);
> > +		if (hwirq < 0) {
> > +			rc =3D hwirq;
> > +			pr_debug("%s: fail allocating msi interrupt\n",
> > +					__func__);
> > +			goto out_free;
> > +		}
> > +
> > +		virq =3D irq_create_mapping(msi_data->irqhost, hwirq);
> > +
> > +		if (virq =3D=3D NO_IRQ) {
> > +			pr_debug("%s: fail mapping hwirq 0x%lx\n",
> > +					__func__, hwirq);
> > +			fsl_msi_free_hwirqs(msi_data, hwirq, 1);
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
> > +	return rc;
> > +}
> > +
> > +void fsl_msi_cascade(unsigned int irq, struct irq_desc *desc) {
> > +	unsigned int cascade_irq;
> > +	struct fsl_msi *msi_data =3D fsl_msi;
> > +	int msir_index =3D -1;
> > +	u32 msir_value =3D 0;
> > +	u32 intr_index;
> > +	u32 have_shift =3D 0;
> > +
> > +	spin_lock(&desc->lock);
> > +	if ((msi_data->feature &  FSL_PIC_IP_MASK) =3D=3D FSL_PIC_IP_IPIC) =
{
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
> > +	msir_index =3D (int)(desc->handler_data);
> > +
> > +	if (msir_index >=3D NR_MSIR)
> > +		cascade_irq =3D NO_IRQ;
> > +
> > +	desc->status |=3D IRQ_INPROGRESS;
> > +	switch (fsl_msi->feature & FSL_PIC_IP_MASK) {
> > +	case FSL_PIC_IP_MPIC:
> > +		msir_value =3D fsl_msi_read(msi_data->msi_regs,
> > +			msir_index * 0x10);
> > +		break;
> > +	case FSL_PIC_IP_IPIC:
> > +		msir_value =3D fsl_msi_read(msi_data->msi_regs,=20
> msir_index * 0x4);
> > +		break;
> > +	}
> > +
> > +	while (msir_value) {
> > +		intr_index =3D ffs(msir_value) - 1;
> > +
> > +		cascade_irq =3D irq_linear_revmap(msi_data->irqhost,
> > +			(msir_index * INT_PER_MSIR + intr_index=20
> + have_shift));
> > +
> > +		if (cascade_irq !=3D NO_IRQ)
> > +			generic_handle_irq(cascade_irq);
> > +		have_shift +=3D (intr_index + 1);
> > +		msir_value =3D (msir_value >> (intr_index + 1));
> > +	}
> > +	desc->status &=3D ~IRQ_INPROGRESS;
> > +
> > +	switch (msi_data->feature & FSL_PIC_IP_MASK) {
> > +	case FSL_PIC_IP_MPIC:
> > +		desc->chip->eoi(irq);
> > +		break;
> > +	case FSL_PIC_IP_IPIC:
> > +		if (!(desc->status & IRQ_DISABLED) &&=20
> desc->chip->unmask)
> > +			desc->chip->unmask(irq);
> > +		break;
> > +	}
> > +unlock:
> > +	spin_unlock(&desc->lock);
> > +}
> > +
> > +static int __devinit fsl_of_msi_probe(struct of_device *dev,
> > +				const struct of_device_id *match) {
> > +	struct fsl_msi *msi;
> > +	struct resource res;
> > +	int err, i, count;
> > +	int rc;
> > +	int virt_msir;
> > +	const u32 *p;
> > +	struct fsl_msi_feature *tmp_data;
> > +
> > +	printk(KERN_DEBUG "Setting up fsl msi support\n");
> > +
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
> > +		of_node_put(dev->node);
> > +		err =3D -ENOMEM;
> > +		goto error_out;
> > +	}
> > +
> > +	/* Get the MSI reg base */
> > +	err =3D of_address_to_resource(dev->node, 0, &res);
> > +	if (err) {
> > +		dev_err(&dev->dev, "%s resource error!\n",
> > +				dev->node->full_name);
> > +		goto error_out;
> > +	}
> > +
> > +	msi->msi_regs =3D ioremap(res.start, res.end - res.start + 1);
> > +	if (!msi->msi_regs) {
> > +		dev_err(&dev->dev, "ioremap problem failed\n");
> > +		goto error_out;
> > +	}
> > +
> > +	tmp_data =3D (struct fsl_msi_feature *)match->data;
> > +
> > +	msi->feature =3D tmp_data->fsl_pic_ip;
> > +
> > +	msi->irqhost->host_data =3D msi;
> > +
> > +	msi->msi_addr_hi =3D 0x0;
> > +	msi->msi_addr_lo =3D res.start + tmp_data->msiir_offset;
> > +
> > +	rc =3D fsl_msi_init_allocator(msi);
> > +	if (rc) {
> > +		dev_err(&dev->dev, "Error allocating MSI bitmap\n");
> > +		goto error_out;
> > +	}
> > +
> > +	p =3D of_get_property(dev->node, "interrupts", &count);
> > +	if (!p) {
> > +		dev_err(&dev->dev, "no interrupts property=20
> found on %s\n",
> > +				dev->node->full_name);
> > +		err =3D -ENODEV;
> > +		goto error_out;
> > +	}
> > +	if (count % 8 !=3D 0) {
> > +		dev_err(&dev->dev, "Malformed interrupts=20
> property on %s\n",
> > +				dev->node->full_name);
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
> > +			set_irq_data(virt_msir, (void *)i);
> > +			set_irq_chained_handler(virt_msir,=20
> fsl_msi_cascade);
> > +		}
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
> > +	kfree(msi);
> > +	return err;
> > +}
> > +
> > +static const struct fsl_msi_feature mpic_msi_feature =3D
> > {FSL_PIC_IP_MPIC, 0x140};
> > +static const struct fsl_msi_feature ipic_msi_feature =3D
> > {FSL_PIC_IP_IPIC, 0x38};
>=20
> make this
> {
> 	.fsl_pic_ip =3D FSL_PIC_IP_MPIC
> 	.offset =3D 0x140
> };
>=20
> for readability.
>=20
OK!

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
> > +static __init int fsl_of_msi_init(void) {
> > +	return of_register_platform_driver(&fsl_of_msi_driver);
> > +}
> > +
> > +subsys_initcall(fsl_of_msi_init);
> > diff --git a/arch/powerpc/sysdev/fsl_msi.h b/arch/powerpc/sysdev/=20
> > fsl_msi.h new file mode 100644 index 0000000..628b6c0
> > --- /dev/null
> > +++ b/arch/powerpc/sysdev/fsl_msi.h
> > @@ -0,0 +1,36 @@
> > +#ifndef _POWERPC_SYSDEV_FSL_MSI_H
> > +#define _POWERPC_SYSDEV_FSL_MSI_H
> > +
> > +#define NR_MSIR	8
>=20
> NR_MSR_REG
>=20
> > +#define INT_PER_MSIR	32
>=20
> IRQS_PER_MSI_REG
>=20
> >
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
> > +
> > +	unsigned long cascade_irq;
> > +
> > +	u32 msi_addr_lo;
> > +	u32 msi_addr_hi;
> > +	void __iomem *msi_regs;
> > +	u32 feature;
> > +
> > +	unsigned long *fsl_msi_bitmap;
> > +	spinlock_t bitmap_lock;
> > +	const char *name;
> > +};
> > +
> > +struct fsl_msi_feature {
> > +	u32 fsl_pic_ip;
> > +	u32 msiir_offset;
> > +};
>=20
> move this struct into .c
OK

> >
> > +
> > +#endif /* _POWERPC_SYSDEV_FSL_MSI_H */
> > +
> > diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/=20
> > fsl_pci.c index bf13c21..fede767 100644
> > --- a/arch/powerpc/sysdev/fsl_pci.c
> > +++ b/arch/powerpc/sysdev/fsl_pci.c
> > @@ -106,6 +106,16 @@ void __init setup_pci_cmd(struct pci_controller
> > *hose)
> > 	}
> > }
> >
> > +#ifdef CONFIG_PCI_MSI
> > +void __init setup_pci_pcsrbar(struct pci_controller *hose) {
> > +	phys_addr_t immr_base;
> > +
> > +	immr_base =3D get_immrbase();
> > +	early_write_config_dword(hose, 0, 0,=20
> PCI_BASE_ADDRESS_0, immr_base);=20
> > +} #endif
> > +
> > static int fsl_pcie_bus_fixup;
> >
> > static void __init quirk_fsl_pcie_header(struct pci_dev *dev) @@=20
> > -211,6 +221,10 @@ int __init fsl_add_bridge(struct=20
> device_node *dev,=20
> > int is_primary)
> > 	/* Setup PEX window registers */
> > 	setup_pci_atmu(hose, &rsrc);
> >
> > +	/*Setup PEXCSRBAR */
> > +#ifdef CONFIG_PCI_MSI
> > +	setup_pci_pcsrbar(hose);
> > +#endif
>=20
> I'm not convinced this is safe.  we need to be careful to=20
> make sure the pcsrbar doesn't overlap with any other device.
>=20
The PCI MEM inbound/outband map seems 'one-one map' in our system and=20
the dts may guard the outband space not overlap(No one wish to set the
space
the same as immrbase :) ). =20
But the 2G inbound MEM was set in our system directly, So far the
pcsrbar is=20
not overlap with other device.

Thanks
Jason

=20
