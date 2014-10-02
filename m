Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3742A1A1625
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Oct 2014 16:09:57 +1000 (EST)
Message-ID: <1412230196.6143.16.camel@ale.ozlabs.ibm.com>
Subject: Re: [PATCH v2 08/17] powerpc/powerpc: Add new PCIe functions for
 allocating cxl interrupts
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 02 Oct 2014 16:09:56 +1000
In-Reply-To: <20141002031659.DB564140188@ozlabs.org>
References: <20141002031659.DB564140188@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, arnd@arndb.de, "Aneesh
 Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, greg@kroah.com,
 linux-kernel@vger.kernel.org, imunsie@au.ibm.com, linuxppc-dev@ozlabs.org,
 anton@samba.org, jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-10-02 at 13:16 +1000, Michael Ellerman wrote:
> On Tue, 2014-30-09 at 10:34:57 UTC, Michael Neuling wrote:
> > From: Ian Munsie <imunsie@au1.ibm.com>
> >=20
> > This adds a number of functions for allocating IRQs under powernv PCIe =
for cxl.
> >=20
> > diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/p=
latforms/powernv/pci-ioda.c
> > index 329164f..b0b96f0 100644
> > --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> > +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> > @@ -503,6 +505,138 @@ static struct pnv_ioda_pe *pnv_ioda_get_pe(struct=
 pci_dev *dev)
> >  		return NULL;
> >  	return &phb->ioda.pe_array[pdn->pe_number];
> >  }
> > +
> > +struct device_node *pnv_pci_to_phb_node(struct pci_dev *dev)
> > +{
> > +        struct pci_controller *hose =3D pci_bus_to_host(dev->bus);
> > +
> > +        return hose->dn;
> > +}
> > +EXPORT_SYMBOL(pnv_pci_to_phb_node);
> > +
> > +#ifdef CONFIG_CXL_BASE
> > +int pnv_phb_to_cxl(struct pci_dev *dev)
> > +{
> > +	struct pci_controller *hose =3D pci_bus_to_host(dev->bus);
> > +	struct pnv_phb *phb =3D hose->private_data;
> > +	struct pnv_ioda_pe *pe;
> > +	int rc;
> > +
> > +	if (!(pe =3D pnv_ioda_get_pe(dev))) {
> > +		rc =3D -ENODEV;
> > +		goto out;
> > +	}
>=20
> That'd be a lot simpler as:
>=20
> 	pe =3D pnv_ioda_get_pe(dev);
> 	if (!pe)
> 		return -ENODEV;

OK

> > +	pe_info(pe, "switch PHB to CXL\n");
> > +	pe_info(pe, "PHB-ID  : 0x%016llx\n", phb->opal_id);
> > +	pe_info(pe, "     pe : %i\n", pe->pe_number);
>=20
> Spacing is a bit weird but maybe it matches something else?

Actually, we switched this to pe_info() based on one of Gavin's reviews,
so the pe_number and opal_id being printed here are not needed anymore.
I'm simplifying this into one line.

	pe_info(pe, "Switching PHB to CXL\n");


>=20
> > +
> > +	if ((rc =3D opal_pci_set_phb_cxl_mode(phb->opal_id, 1, pe->pe_number)=
))
> > +		dev_err(&dev->dev, "opal_pci_set_phb_cxl_mode failed: %i\n", rc);
>=20
> Again why not:
>=20
> 	rc =3D opal_pci_set_phb_cxl_mode(phb->opal_id, 1, pe->pe_number);
> 	if (rc)
> 		dev_err(&dev->dev, "opal_pci_set_phb_cxl_mode failed: %i\n", rc);

Ok.

> > +out:
> > +	return rc;
> > +}
> > +EXPORT_SYMBOL(pnv_phb_to_cxl);
> > +
>=20
> > +int pnv_cxl_alloc_hwirq_ranges(struct cxl_irq_ranges *irqs,
> > +			       struct pci_dev *dev, int num)
>=20
> This could use some documentation.
>=20
> It seems to be that it allocates num irqs in some number of ranges, up to
> CXL_IRQ_RANGES?

OK

>=20
> > +{
> > +	struct pci_controller *hose =3D pci_bus_to_host(dev->bus);
> > +	struct pnv_phb *phb =3D hose->private_data;
> > +	int range =3D 0;
>=20
> You reinitialise to 1 below?

Oops

>=20
> > +	int hwirq;
> > +	int try;
>=20
> So these can be:
>=20
> 	int hwirq, try, range;
>=20
> > +	memset(irqs, 0, sizeof(struct cxl_irq_ranges));
> > +
> > +	for (range =3D 1; range < CXL_IRQ_RANGES && num; range++) {
>=20
> I think this would be clearer if range was just called "i" as usual.

OK

> Why does it start at 1 ?

0 is used by the data storage interrupt. I'll add a comment to clarify.

>=20
> > +		try =3D num;
> > +		while (try) {
> > +			hwirq =3D msi_bitmap_alloc_hwirqs(&phb->msi_bmp, try);
> > +			if (hwirq >=3D 0)
> > +				break;
> > +			try /=3D 2;
> > +		}
> > +		if (!try)
> > +			goto fail;
> > +
> > +		irqs->offset[range] =3D phb->msi_base + hwirq;
> > +		irqs->range[range] =3D try;
>=20
> irqs->range is irq_hw_number_t but looks like it should just be uint.
>=20
> > +		pr_devel("cxl alloc irq range 0x%x: offset: 0x%lx  limit: %li\n",
> > +			 range, irqs->offset[range], irqs->range[range]);
> > +		num -=3D try;
> > +	}
> > +	if (num)
> > +		goto fail;
> > +
> > +	return 0;
> > +fail:
> > +	for (range--; range >=3D 0; range--) {
> > +		hwirq =3D irqs->offset[range] - phb->msi_base;
> > +		msi_bitmap_free_hwirqs(&phb->msi_bmp, hwirq,
> > +				       irqs->range[range]);
> > +		irqs->range[range] =3D 0;
> > +	}
>=20
> Because you zero ranges at the top I think you can replace all of the fai=
l
> logic with a call to pnv_cxl_release_hwirq_ranges().

Nice.  Will change.

>=20
>=20
> > +	return -ENOSPC;
> > +}
> > +EXPORT_SYMBOL(pnv_cxl_alloc_hwirq_ranges);
> > +
> > +void pnv_cxl_release_hwirq_ranges(struct cxl_irq_ranges *irqs,
> > +				  struct pci_dev *dev)
> > +{
> > +	struct pci_controller *hose =3D pci_bus_to_host(dev->bus);
> > +	struct pnv_phb *phb =3D hose->private_data;
> > +	int range =3D 0;
>=20
> Unnecessary init again.

Yep. I'll change to 'i' too.

> > +	int hwirq;
> > +
> > +	for (range =3D 0; range < 4; range++) {
>=20
> Shouldn't 4 be CXL_IRQ_RANGES ?

Yep.

>=20
> > +		hwirq =3D irqs->offset[range] - phb->msi_base;
>=20
> That should be inside the if.

Yep.

>=20
> Or better do:
> 		if (!irqs->range[range])
> 			continue;
> 		...

Nice.

>=20
> > +		if (irqs->range[range]) {
> > +			pr_devel("cxl release irq range 0x%x: offset: 0x%lx  limit: %ld\n",
> > +				 range, irqs->offset[range],
> > +				 irqs->range[range]);
> > +			msi_bitmap_free_hwirqs(&phb->msi_bmp, hwirq,
> > +					       irqs->range[range]);
> > +		}
> > +	}
> > +}
> > +EXPORT_SYMBOL(pnv_cxl_release_hwirq_ranges);
> > +
> > +int pnv_cxl_get_irq_count(struct pci_dev *dev)
> > +{
> > +	struct pci_controller *hose =3D pci_bus_to_host(dev->bus);
> > +        struct pnv_phb *phb =3D hose->private_data;
>=20
> Indentation is fubar.

OK

>=20
> > +	return phb->msi_bmp.irq_count;
> > +}
> > +EXPORT_SYMBOL(pnv_cxl_get_irq_count);
> > +
> > +#endif /* CONFIG_CXL_BASE */
> >  #endif /* CONFIG_PCI_MSI */
> > =20
> >  static int pnv_ioda_configure_pe(struct pnv_phb *phb, struct pnv_ioda_=
pe *pe)
> > @@ -1330,6 +1464,33 @@ static void set_msi_irq_chip(struct pnv_phb *phb=
, unsigned int virq)
> >  	irq_set_chip(virq, &phb->ioda.irq_chip);
> >  }
> > =20
> > +#ifdef CONFIG_CXL_BASE
>=20
> Why is this here and not in the previous #ifdef CONFIG_CXL_BASE block ?

I can actually move the rest of the cxl code down here too.  So I'll do
that.

>=20
> > +int pnv_cxl_ioda_msi_setup(struct pci_dev *dev, unsigned int hwirq,
> > +			   unsigned int virq)
> > +{
> > +	struct pci_controller *hose =3D pci_bus_to_host(dev->bus);
> > +	struct pnv_phb *phb =3D hose->private_data;
> > +	unsigned int xive_num =3D hwirq - phb->msi_base;
> > +	struct pnv_ioda_pe *pe;
> > +	int rc;
> > +
> > +	if (!(pe =3D pnv_ioda_get_pe(dev)))
> > +		return -ENODEV;
> > +
> > +	/* Assign XIVE to PE */
> > +	rc =3D opal_pci_set_xive_pe(phb->opal_id, pe->pe_number, xive_num);
> > +	if (rc) {
> > +		pr_warn("%s: OPAL error %d setting msi_base 0x%x hwirq 0x%x XIVE 0x%=
x PE\n",
> > +			pci_name(dev), rc, phb->msi_base, hwirq, xive_num);
>=20
> dev_warn() ?

I'm going to move it to the pe_warn() we have here.

Cheers,
Mikey
