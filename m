Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id 7719267C77
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Oct 2006 03:05:10 +1000 (EST)
Date: Thu, 5 Oct 2006 12:04:58 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: make U4 PCIe work
Message-ID: <20061005170458.GL24705@localdomain>
References: <1160024098.22232.13.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1160024098.22232.13.camel@localhost.localdomain>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi-

Benjamin Herrenschmidt wrote:
> The Maple support code was missing code for U4/CPC945 PCIe. This adds
> it, enabling it to work on tigerwood boards, and possibly also js21
> using SLOF.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> Patch just missed the merge window but should go in anyway. It's been
> hanging around for a while, I just forgot about it, and it's fairly
> harmless.
> 
> Index: linux-work/arch/powerpc/platforms/maple/pci.c
> ===================================================================
> --- linux-work.orig/arch/powerpc/platforms/maple/pci.c	2006-10-05 14:14:28.000000000 +1000
> +++ linux-work/arch/powerpc/platforms/maple/pci.c	2006-10-05 14:29:30.000000000 +1000
> @@ -8,7 +8,7 @@
>   * 2 of the License, or (at your option) any later version.
>   */
>  
> -#define DEBUG
> +#undef DEBUG
>  
>  #include <linux/kernel.h>
>  #include <linux/pci.h>
> @@ -16,6 +16,7 @@
>  #include <linux/string.h>
>  #include <linux/init.h>
>  #include <linux/bootmem.h>
> +#include <linux/irq.h>
>  
>  #include <asm/sections.h>
>  #include <asm/io.h>
> @@ -33,7 +34,7 @@
>  #define DBG(x...)
>  #endif
>  
> -static struct pci_controller *u3_agp, *u3_ht;
> +static struct pci_controller *u3_agp, *u3_ht, *u4_pcie;
>  
>  static int __init fixup_one_level_bus_range(struct device_node *node, int higher)
>  {
> @@ -287,6 +288,110 @@ static struct pci_ops u3_ht_pci_ops =
>  	u3_ht_write_config
>  };
>  
> +#define U4_PCIE_CFA0(devfn, off)        \
> +        ((1 << ((unsigned int)PCI_SLOT(dev_fn)))        \
> +         | (((unsigned int)PCI_FUNC(dev_fn)) << 8)      \
> +         | ((((unsigned int)(off)) >> 8) << 28) \
> +         | (((unsigned int)(off)) & 0xfcU))


This macro has the same kind of bug I just fixed for the U3 code in
this file.  The macro parameter is named devfn but the body of the
macro refers to dev_fn.  I see no reason that these shouldn't be
functions.


> +
> +#define U4_PCIE_CFA1(bus, devfn, off)   \
> +        ((((unsigned int)(bus)) << 16) \
> +         |(((unsigned int)(devfn)) << 8)        \
> +         | ((((unsigned int)(off)) >> 8) << 28) \
> +         |(((unsigned int)(off)) & 0xfcU)       \
> +         |1UL)
> +
> +static volatile void __iomem *u4_pcie_cfg_access(struct pci_controller* hose,
> +                                        u8 bus, u8 dev_fn, int offset)
> +{
> +        unsigned int caddr;
> +
> +        if (bus == hose->first_busno) {
> +                caddr = U4_PCIE_CFA0(dev_fn, offset);
> +        } else
> +                caddr = U4_PCIE_CFA1(bus, dev_fn, offset);
> +
> +        /* Uninorth will return garbage if we don't read back the value ! */
> +        do {
> +                out_le32(hose->cfg_addr, caddr);
> +        } while (in_le32(hose->cfg_addr) != caddr);
> +
> +        offset &= 0x03;
> +        return hose->cfg_data + offset;
> +}
> +
> +static int u4_pcie_read_config(struct pci_bus *bus, unsigned int devfn,
> +                               int offset, int len, u32 *val)
> +{
> +        struct pci_controller *hose;
> +        volatile void __iomem *addr;
> +
> +        hose = pci_bus_to_host(bus);
> +        if (hose == NULL)
> +                return PCIBIOS_DEVICE_NOT_FOUND;
> +        if (offset >= 0x1000)
> +                return  PCIBIOS_BAD_REGISTER_NUMBER;
> +        addr = u4_pcie_cfg_access(hose, bus->number, devfn, offset);
> +        if (!addr)
> +                return PCIBIOS_DEVICE_NOT_FOUND;
> +        /*
> +         * Note: the caller has already checked that offset is
> +         * suitably aligned and that len is 1, 2 or 4.
> +         */
> +        switch (len) {
> +        case 1:
> +                *val = in_8(addr);
> +                break;
> +        case 2:
> +                *val = in_le16(addr);
> +                break;
> +        default:
> +                *val = in_le32(addr);
> +                break;
> +        }
> +        return PCIBIOS_SUCCESSFUL;
> +}
> +static int u4_pcie_write_config(struct pci_bus *bus, unsigned int devfn,
> +                                int offset, int len, u32 val)
> +{
> +        struct pci_controller *hose;
> +        volatile void __iomem *addr;
> +
> +        hose = pci_bus_to_host(bus);
> +        if (hose == NULL)
> +                return PCIBIOS_DEVICE_NOT_FOUND;
> +        if (offset >= 0x1000)
> +                return  PCIBIOS_BAD_REGISTER_NUMBER;
> +        addr = u4_pcie_cfg_access(hose, bus->number, devfn, offset);
> +        if (!addr)
> +                return PCIBIOS_DEVICE_NOT_FOUND;
> +        /*
> +         * Note: the caller has already checked that offset is
> +         * suitably aligned and that len is 1, 2 or 4.
> +         */
> +        switch (len) {
> +        case 1:
> +                out_8(addr, val);
> +                (void) in_8(addr);
> +                break;
> +        case 2:
> +                out_le16(addr, val);
> +                (void) in_le16(addr);
> +                break;
> +        default:
> +                out_le32(addr, val);
> +                (void) in_le32(addr);
> +                break;
> +        }
> +        return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static struct pci_ops u4_pcie_pci_ops =
> +{
> +        u4_pcie_read_config,
> +        u4_pcie_write_config
> +};
> +
>  static void __init setup_u3_agp(struct pci_controller* hose)
>  {
>  	/* On G5, we move AGP up to high bus number so we don't need
> @@ -307,6 +412,26 @@ static void __init setup_u3_agp(struct p
>  	u3_agp = hose;
>  }
>  
> +static void __init setup_u4_pcie(struct pci_controller* hose)
> +{
> +        /* We currently only implement the "non-atomic" config space, to
> +         * be optimised later.
> +         */
> +        hose->ops = &u4_pcie_pci_ops;
> +        hose->cfg_addr = ioremap(0xf0000000 + 0x800000, 0x1000);
> +        hose->cfg_data = ioremap(0xf0000000 + 0xc00000, 0x1000);
> +
> +        /* The bus contains a bridge from root -> device, we need to
> +         * make it visible on bus 0 so that we pick the right type
> +         * of config cycles. If we didn't, we would have to force all
> +         * config cycles to be type 1. So we override the "bus-range"
> +         * property here
> +         */
> +        hose->first_busno = 0x00;
> +        hose->last_busno = 0xff;
> +        u4_pcie = hose;
> +}
> +
>  static void __init setup_u3_ht(struct pci_controller* hose)
>  {
>  	hose->ops = &u3_ht_pci_ops;
> @@ -354,6 +479,10 @@ static int __init add_bridge(struct devi
>  		setup_u3_ht(hose);
>  		disp_name = "U3-HT";
>  		primary = 1;
> +        } else if (device_is_compatible(dev, "u4-pcie")) {
> +                setup_u4_pcie(hose);
> +                disp_name = "U4-PCIE";
> +                primary = 0;
>  	}
>  	printk(KERN_INFO "Found %s PCI host bridge. Firmware bus number: %d->%d\n",
>  		disp_name, hose->first_busno, hose->last_busno);
> @@ -361,7 +490,6 @@ static int __init add_bridge(struct devi
>  	/* Interpret the "ranges" property */
>  	/* This also maps the I/O region and sets isa_io/mem_base */
>  	pci_process_bridge_OF_ranges(hose, dev, primary);
> -	pci_setup_phb_io(hose, primary);
>  
>  	/* Fixup "bus-range" OF property */
>  	fixup_bus_range(dev);
> @@ -376,8 +504,17 @@ void __init maple_pcibios_fixup(void)
>  
>  	DBG(" -> maple_pcibios_fixup\n");
>  
> -	for_each_pci_dev(dev)
> -		pci_read_irq_line(dev);
> +	for_each_pci_dev(dev) {
> +		/* Fixup IRQ for PCIe host */
> +		if (u4_pcie != NULL && dev->bus->number == 0 &&
> +		    pci_bus_to_host(dev->bus) == u4_pcie) {
> +			printk(KERN_DEBUG "Fixup U4 PCIe IRQ\n");
> +			dev->irq = irq_create_mapping(NULL, 1);
> +			if (dev->irq != NO_IRQ)
> +				set_irq_type(dev->irq, IRQ_TYPE_LEVEL_LOW);
> +		} else
> +			pci_read_irq_line(dev);
> +	}
>  
>  	DBG(" <- maple_pcibios_fixup\n");
>  }
> @@ -388,8 +525,10 @@ static void __init maple_fixup_phb_resou
>  	
>  	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
>  		unsigned long offset = (unsigned long)hose->io_base_virt - pci_io_base;
> +
>  		hose->io_resource.start += offset;
>  		hose->io_resource.end += offset;
> +
>  		printk(KERN_INFO "PCI Host %d, io start: %llx; io end: %llx\n",
>  		       hose->global_number,
>  		       (unsigned long long)hose->io_resource.start,
> @@ -431,6 +570,19 @@ void __init maple_pci_init(void)
>  	if (ht && add_bridge(ht) != 0)
>  		of_node_put(ht);
>  
> +        /*
> +         * We need to call pci_setup_phb_io for the HT bridge first
> +         * so it gets the I/O port numbers starting at 0, and we
> +         * need to call it for the AGP bridge after that so it gets
> +         * small positive I/O port numbers.
> +         */
> +        if (u3_ht)
> +                pci_setup_phb_io(u3_ht, 1);
> +        if (u3_agp)
> +                pci_setup_phb_io(u3_agp, 0);
> +        if (u4_pcie)
> +                pci_setup_phb_io(u4_pcie, 0);
> +
>  	/* Fixup the IO resources on our host bridges as the common code
>  	 * does it only for childs of the host bridges
>  	 */
> @@ -479,6 +631,9 @@ int maple_pci_get_legacy_ide_irq(struct 
>  /* XXX: To remove once all firmwares are ok */
>  static void fixup_maple_ide(struct pci_dev* dev)
>  {
> +	if (!machine_is(maple))
> +		return;
> +
>  #if 0 /* Enable this to enable IDE port 0 */
>  	{
>  		u8 v;
> @@ -495,7 +650,7 @@ static void fixup_maple_ide(struct pci_d
>  	dev->resource[4].start = 0xcc00;
>  	dev->resource[4].end = 0xcc10;
>  #endif
> -#if 1 /* Enable this to fixup IDE sense/polarity of irqs in IO-APICs */
> +#if 0 /* Enable this to fixup IDE sense/polarity of irqs in IO-APICs */
>  	{
>  		struct pci_dev *apicdev;
>  		u32 v;

Do the changes to fixup_maple_ide have anything to do with the rest of
the patch?  It's not clear from your description.  And with that last
hunk the function now appears to do nothing.

Could we consider merging the powermac and maple pci code into a
common location that would be used by both platforms?  There's quite a
bit of code duplication going on here...
