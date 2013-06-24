Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9FBBE2C029B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jun 2013 11:50:14 +1000 (EST)
Message-ID: <1372038589.3944.118.camel@pasglop>
Subject: Re: [PATCH v2] powerpc/pci: Improve device hotplug initialization
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 24 Jun 2013 11:49:49 +1000
In-Reply-To: <20130621165453.GA5506@roeck-us.net>
References: <1370884688-7753-1-git-send-email-linux@roeck-us.net>
 <20130621165453.GA5506@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Yuanquan Chen <Yuanquan.Chen@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-06-21 at 09:54 -0700, Guenter Roeck wrote:

> > v2: Ensure that PCI bus fixup code has been executed before calling
> >     device setup code.
> > 
> Hi Ben,
> 
> any comments/feedback on this approach ?
> 
> It is much less invasive than before and should address your concerns.

And also less nice cleanup :-) I'll have a look.

Cheers,
Ben.

> Thanks,
> Guenter
> 
> >  arch/powerpc/kernel/pci-common.c |   17 ++++++++++++-----
> >  1 file changed, 12 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> > index 7f2273c..6909b13 100644
> > --- a/arch/powerpc/kernel/pci-common.c
> > +++ b/arch/powerpc/kernel/pci-common.c
> > @@ -992,7 +992,7 @@ void pcibios_setup_bus_self(struct pci_bus *bus)
> >  		ppc_md.pci_dma_bus_setup(bus);
> >  }
> >  
> > -void pcibios_setup_device(struct pci_dev *dev)
> > +static void pcibios_setup_device(struct pci_dev *dev)
> >  {
> >  	/* Fixup NUMA node as it may not be setup yet by the generic
> >  	 * code and is needed by the DMA init
> > @@ -1013,6 +1013,17 @@ void pcibios_setup_device(struct pci_dev *dev)
> >  		ppc_md.pci_irq_fixup(dev);
> >  }
> >  
> > +int pcibios_add_device(struct pci_dev *dev)
> > +{
> > +	/*
> > +	 * We can only call pcibios_setup_device() after bus setup is complete,
> > +	 * since some of the platform specific DMA setup code depends on it.
> > +	 */
> > +	if (dev->bus->is_added)
> > +		pcibios_setup_device(dev);
> > +	return 0;
> > +}
> > +
> >  void pcibios_setup_bus_devices(struct pci_bus *bus)
> >  {
> >  	struct pci_dev *dev;
> > @@ -1467,10 +1478,6 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
> >  		if (ppc_md.pcibios_enable_device_hook(dev))
> >  			return -EINVAL;
> >  
> > -	/* avoid pcie irq fix up impact on cardbus */
> > -	if (dev->hdr_type != PCI_HEADER_TYPE_CARDBUS)
> > -		pcibios_setup_device(dev);
> > -
> >  	return pci_enable_resources(dev, mask);
> >  }
> >  
> > -- 
> > 1.7.9.7
> > 
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
