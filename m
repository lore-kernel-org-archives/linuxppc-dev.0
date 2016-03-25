Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qWdQC23BMzDq71
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Mar 2016 20:33:07 +1100 (AEDT)
In-Reply-To: <1458337746-20337-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, gpiccoli@linux.vnet.ibm.com, linux-pci@vger.kernel.org,
 gwshan@linux.vnet.ibm.com, paulus@samba.org, imunsie@au1.ibm.com,
 andrew.donnellan@au1.ibm.com, bhelgaas@google.com
Subject: Re: [v4] powerpc/pci: Assign fixed PHB number based on device-tree
 properties
Message-Id: <3qWdQC0MVDz9s9Y@ozlabs.org>
Date: Fri, 25 Mar 2016 20:33:06 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Guilherme,

Some comments below ...

On Fri, 2016-18-03 at 21:49:06 UTC, "Guilherme G. Piccoli" wrote:
> The domain/PHB field of PCI addresses has its value obtained from a
> global variable, incremented each time a new domain (represented by
> struct pci_controller) is added on the system. The domain addition
> process happens during boot or due to PCI device hotplug.
> 
> As recent kernels are using predictable naming for network interfaces,
> the network stack is more tied to PCI naming. This can be a problem in
> hotplug scenarios, because PCI addresses will change if devices are
> removed and then re-added. This situation seems unusual, but it can
> happen if a user wants to replace a NIC without rebooting the machine,
> for example.
> 
> This patch changes the way PCI domain values are generated: now, we use
> device-tree properties to assign fixed PHB numbers to PCI addresses
> when available (meaning pSeries and PowerNV cases). We also use a bitmap
> to allow dynamic PHB numbering when device-tree properties are not
> used. This bitmap keeps track of used PHB numbers and if a PHB is
> released (by hotplug operations for example), it allows the reuse of
> this PHB number, avoiding PCI address to change in case of device remove
> and re-add soon after. No functional changes were introduced.
> 
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/pci-common.c | 40 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index 0f7a60f..bc31ac1 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -44,8 +44,11 @@
>  static DEFINE_SPINLOCK(hose_spinlock);
>  LIST_HEAD(hose_list);
>  
> -/* XXX kill that some day ... */
> -static int global_phb_number;		/* Global phb counter */
> +/* For dynamic PHB numbering on get_phb_number(): max number of PHBs. */
> +#define	MAX_PHBS	8192

Did we just make that up? It seems like a lot, but then we have some big
systems?

> +/* For dynamic PHB numbering: used/free PHBs tracking bitmap. */

Locking? It looks like it's protected by the hose_spinlock, but you should say
that here, and also in the comment for hose_spinlock.

> +static DECLARE_BITMAP(phb_bitmap, MAX_PHBS);
>  
>  /* ISA Memory physical address */
>  resource_size_t isa_mem_base;
> @@ -64,6 +67,32 @@ struct dma_map_ops *get_pci_dma_ops(void)
>  }
>  EXPORT_SYMBOL(get_pci_dma_ops);
>  

There should be a comment here saying what the locking requirements are for
this function.

> +static int get_phb_number(struct device_node *dn)
> +{
> +	const __be64 *prop64;
> +	const __be32 *regs;
> +	int phb_id = 0;
> +
> +	/* try fixed PHB numbering first, by checking archs and reading
> +	 * the respective device-tree property. */
> +	if (machine_is(pseries)) {

Firstly I don't see why this check needs to be conditional on pseries. Any
machine where the PHB has a 'reg' property should be able to use 'reg' for
numbering.

> +		regs = of_get_property(dn, "reg", NULL);
> +		if (regs)
> +			return (int)(be32_to_cpu(regs[1]) & 0xFFFF);

This should use of_property_read_u32().

> +	} else if (machine_is(powernv)) {

This shouldn't be a machine check, it should just look for 'ibm,opal-phbid'
first, before 'reg'.

> +		prop64 = of_get_property(dn, "ibm,opal-phbid", NULL);
> +		if (prop64)
> +			return (int)(be64_to_cpup(prop64) & 0xFFFF);

of_property_read_u64().

> +	}

And finally in either case above, where you get a number from the device tree,
you must check that it's not already allocated. Otherwise if you have a system
where some PHBs have a property but others don't, you may give out the same
number twice. Also you could have firmware give you the same number twice
(which would be a firmware bug, but those happen).

If the number is allocated you fall back to dynamic numbering.

If it's not allocated you must mark it as allocated in the bitmap.

> +
> +	/* if not pSeries nor PowerNV, fallback to dynamic PHB numbering */
> +	phb_id = find_first_zero_bit(phb_bitmap, MAX_PHBS);
> +	BUG_ON(phb_id >= MAX_PHBS); /* reached maximum number of PHBs */
> +	set_bit(phb_id, phb_bitmap);
> +
> +	return phb_id;
> +}
> +
>  struct pci_controller *pcibios_alloc_controller(struct device_node *dev)
>  {
>  	struct pci_controller *phb;

cheers
