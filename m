Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B790F67DB9
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 05:43:33 +1100 (EST)
Date: Wed, 15 Nov 2006 19:43:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Subject: Re: [PATCH 9/16] Supporting of PCI bus for Celleb
Message-ID: <20061115184328.GD21633@lst.de>
References: <200611150945.kAF9jXRV007053@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200611150945.kAF9jXRV007053@toshiba.co.jp>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +static inline void ioif_setup(struct ioif *ioif, struct device_node *dn)
> +{
> +	ioif->iommu_table = NULL;
> +}
> +
> +struct ioif *ioif_alloc(struct device_node *dn)
> +{
> +	struct ioif *ioif;
> +
> +	if (mem_init_done)
> +		ioif = kmalloc(sizeof(struct ioif), GFP_KERNEL);
> +	else
> +		ioif = alloc_bootmem(sizeof(struct ioif));
> +
> +	if (ioif)
> +		ioif_setup(ioif, dn);
> +
> +	return ioif;

Please switch the above from kmalloc to kzalloc.  As alloc_bootmem also
zeroes it's return value you now have ioif pre-cleared and don't need
ioif_setup.  Also when can this be called from non-initialization code?

> +struct ioif {

Struct ioif is a bit too generic, can you give it a better name?


> +extern int 
> +__init celleb_setup_pci_bridge(struct device_node *, struct pci_controller *);

Please move this extern declaration to a header.

> +
> +static int 
> +celleb_dummy_pci_read_config(struct pci_bus *bus,
> +                             unsigned int devfn,
> +                             int where, int size, u32 *val)
> +{
> +
> +
> +	return PCIBIOS_DEVICE_NOT_FOUND;
> +}
> +
> +
> +static int 
> +celleb_dummy_pci_write_config(struct pci_bus *bus,
> +                              unsigned int devfn,
> +                              int where, int size, u32 val)
> +{
> +
> +	return PCIBIOS_DEVICE_NOT_FOUND;
> +}
> +
> +struct pci_ops celleb_dummy_pci_ops = {
> +/* for generic PCI buses/devices */
> +	celleb_dummy_pci_read_config,
> +	celleb_dummy_pci_write_config
> +};

This look broken to me.  Busses that do not support config space
cycles shouldn't be reported to the PCI layer at all.

> +struct pci_ops celleb_fake_pci_ops = {
> +	celleb_fake_pci_read_config,
> +	celleb_fake_pci_write_config
> +};

What are these fake ops for?  If you don't have a real PCI
bus you shouldn't emulate it but use a vio-style bus insted.
