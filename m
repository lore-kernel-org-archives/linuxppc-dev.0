Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B82B667BE3
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 21:40:43 +1100 (EST)
Date: Fri, 17 Nov 2006 19:40:34 +0900 (JST)
Message-Id: <200611171040.kAHAeYGG017561@toshiba.co.jp>
To: hch@lst.de
Subject: Re: [PATCH 9/16] Supporting of PCI bus for Celleb
In-Reply-To: <20061115184328.GD21633@lst.de>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Christoph-san,


 Thanks for your comments.

 Frist of all, we must say sorry and mention that PCI and IOIF 
support for Celleb is still under development. Some codes 
are based on temporary design, like fake-PCI methods.
 We basically agree that IOIF buses should not pretend PCI.

 There were some reasons why we made such  temporary design:
- To design a new bus seemed to be large scale development and would 
affect large parts of original powerpc codes.
- Some existing drivers for celleb device(i.e. spider_net) depends on 
PCI methods.

 We think that a new bus type should be defined for IOIFs, as they are 
not PCI, not virtual buses. We did't have enough time to examine what 
kind of method is the best, implement to kernel and then modify device 
drivers..

> 
> > +static inline void ioif_setup(struct ioif *ioif, struct device_node *dn)
> > +{
> > + ioif->iommu_table = NULL;
> > +}
> > +
> > +struct ioif *ioif_alloc(struct device_node *dn)
> > +{
> > + struct ioif *ioif;
> > +
> > + if (mem_init_done)
> > +     ioif = kmalloc(sizeof(struct ioif), GFP_KERNEL);
> > + else
> > +     ioif = alloc_bootmem(sizeof(struct ioif));
> > +
> > + if (ioif)
> > +     ioif_setup(ioif, dn);
> > +
> > + return ioif;
> 
> Please switch the above from kmalloc to kzalloc.  As alloc_bootmem also
> zeroes it's return value you now have ioif pre-cleared and don't need
> ioif_setup.  Also when can this be called from non-initialization code?
> 
> > +struct ioif {
> 
> Struct ioif is a bit too generic, can you give it a better name?

 Thank you. kzalloc is safer and simpler.
 This function is now called from setup_arch only. The codes assumes 
some future cases. As struct ioif includes pointer to iommu_table, this 
will be used like pci_dn. (with more member variables.. we think.)
 The name will be struct ioif_dn? (and will include pointer to struct 
device_node)

> 
> > +extern int 
> > +__init celleb_setup_pci_bridge(struct device_node *, struct pci_controller *);
> 
> Please move this extern declaration to a header.

　Sorry, this declaration is a trash. We'll remove it.

> > +
> > +static int 
> > +celleb_dummy_pci_read_config(struct pci_bus *bus,
> > +                             unsigned int devfn,
> > +                             int where, int size, u32 *val)
> > +{
> > +
> > +
> > + return PCIBIOS_DEVICE_NOT_FOUND;
> > +}
> > +
> > +
> > +static int 
> > +celleb_dummy_pci_write_config(struct pci_bus *bus,
> > +                              unsigned int devfn,
> > +                              int where, int size, u32 val)
> > +{
> > +
> > + return PCIBIOS_DEVICE_NOT_FOUND;
> > +}
> > +
> > +struct pci_ops celleb_dummy_pci_ops = {
> > +/* for generic PCI buses/devices */
> > + celleb_dummy_pci_read_config,
> > + celleb_dummy_pci_write_config
> > +};
> 
> This look broken to me.  Busses that do not support config space
> cycles shouldn't be reported to the PCI layer at all.
> 
> > +struct pci_ops celleb_fake_pci_ops = {
> > + celleb_fake_pci_read_config,
> > + celleb_fake_pci_write_config
> > +};
> 
> What are these fake ops for?  If you don't have a real PCI
> bus you shouldn't emulate it but use a vio-style bus insted.

Thank you,
Kou Ishizaki
Toshiba
