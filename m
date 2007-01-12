Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8B707DDE2E
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 18:28:00 +1100 (EST)
Subject: Re: [PATCH 2/7] Powerpc MSI implementation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20070111213603.GB23237@lst.de>
References: <1168514716.63474.857278133999.qpush@cradle>
	<20070111112503.0CC1BDDF13@ozlabs.org> <20070111213603.GB23237@lst.de>
Content-Type: text/plain
Date: Fri, 12 Jan 2007 18:27:49 +1100
Message-Id: <1168586869.5011.6.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Greg Kroah-Hartman <greg@kroah.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Olof Johannsson <olof@lixom.net>,
	linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Most of this shouldn't live in arch/powerpc as it's generic code except
> for tiny little bits.

Generally agreed.

> > +static struct ppc_msi_ops *get_msi_ops(struct pci_dev *pdev)
> > +{
> > +	if (ppc_md.get_msi_ops)
> > +		return ppc_md.get_msi_ops(pdev);
> > +
> > +	return NULL;
> > +}
>
> struct ppc_msi_ops should become msi_ops, and this function should
> be an arch hook in asm/msi.h

Yes. We need an asm hook as some archs will return one single global ops
instance for any PCI devices, while others (like powerpc) need to be
able to return different ops depending on what bus a device hangs off.

> > +static struct msi_info *get_msi_info(struct pci_dev *pdev)
> > +{
> > +	return pdev->msi_info;
> > +}
> 
> This wrapper looks rather useless :)

It dates from when we were unsure where to put the msi_info (initially
in some ppc-specific pci_dn data structure iirc, until we had Greg's ok
about having it in pci_dev... Easier to just update the wrapper than fix
everybody using it :-)

> > +#if defined(CONFIG_PCI_MSI) && defined(CONFIG_PPC_MERGE)
> > +struct msi_info;
> > +#endif
> 
> Unconditional, please.
>
> >  /*
> >   * The pci_dev structure is used to describe PCI devices.
> >   */
> > @@ -174,6 +178,9 @@ struct pci_dev {
> >  	struct bin_attribute *rom_attr; /* attribute descriptor for sysfs ROM entry */
> >  	int rom_attr_enabled;		/* has display of the rom attribute been enabled? */
> >  	struct bin_attribute *res_attr[DEVICE_COUNT_RESOURCE]; /* sysfs file for resources */
> > +#if defined(CONFIG_PCI_MSI) && defined(CONFIG_PPC_MERGE)
> > +	struct	msi_info *msi_info;
> > +#endif
> 
> and only #ifdef CONFIG_PCI_MSI here please.

Yeah well, CONFIG_PCI_MSI_NEW for now and CONFIG_PCI_MSI once
everything's been ported over the new infrastructure.

Ben.
