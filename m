Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D4A3DDE050
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 17:18:27 +1000 (EST)
Subject: Re: [PATCH 2/11] cell: generalize io-workarounds code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <20080314.212034.-1625856941.kouish@swc.toshiba.co.jp>
References: <20080314.212034.-1625856941.kouish@swc.toshiba.co.jp>
Content-Type: text/plain
Date: Wed, 16 Apr 2008 17:18:01 +1000
Message-Id: <1208330282.6958.264.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-03-14 at 21:20 +0900, Ishizaki Kou wrote:
> This patch splits cell io-workaround code into spider-pci dependent
> code and a generic part, and also adds interfaces to the generic
> io-workaround mechanism.
> 
> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
> ---
> 
> Please test on CellBlade because I don't have any access to CellBlade.

Unfortunately, that crashes on spider based cell blade, see below:

> +
> +	/* setup dummy read */
> +	/*
> +	 * On CellBlade, we can't know that which XDR memory is used by
> +	 * kmalloc() to allocate dummy_page_va.
> +	 * In order to imporve the performance, the XDR which is used to
> +	 * allocate dummy_page_va is the nearest the spider-pci.
> +	 * We have to select the CBE which is the nearest the spider-pci
> +	 * to allocate memory from the best XDR, but I don't know that
> +	 * how to do.
> +	 *
> +	 * Celleb does not have this problem, because it has only one XDR.
> +	 */
> +	dummy_page_va = kmalloc(PAGE_SIZE, GFP_KERNEL);
> +	if (!dummy_page_va) {
> +		pr_err("SPIDERPCI-IOWA:Alloc dummy_page_va failed.\n");
> +		return -1;
> +	}
> +
> +	dummy_page_da = dma_map_single(phb->parent, dummy_page_va,
> +				       PAGE_SIZE, DMA_FROM_DEVICE);
> +	if (dma_mapping_error(dummy_page_da)) {
> +		pr_err("SPIDER-IOWA:Map dummy page filed.\n");
> +		kfree(dummy_page_va);
> +		return -1;
> +	}

The above dma_map_single() will crash on QS20 because there is no
phb->parent on these. The QS20 uses the "old style" PCI probing
mechanism where PCI busses are setup off the root node at setup_arch
time and have no struct device attached, which means yo ucan't call
dma_map_single on them unfortunately.
 
Now I wonder...

> +int __init spiderpci_iowa_init(struct iowa_bus *bus, void *data)
> +{
> +	void __iomem *regs = NULL;
> +	struct spiderpci_iowa_private *priv;
> +	struct device_node *np = bus->phb->dn;
> +	struct resource r;
> +	unsigned long offset = (unsigned long)data;
> +
> +	pr_debug("SPIDERPCI-IOWA:Bus initialize for spider(%s)\n",
> +		 np->full_name);
> +

   .../...

Is the above spiderpci_iowa_init() function ever used on Celleb ? It
looks to me like Celleb relies on the new of_platform stuff to create
the PCI host bridges off OF devices, after boot, in which case that
would work for you. That would mean that the above function is really
only useful for busses created in setup_arch() which is really only the
QS20 cell blade, right ?

In that case, I think that function should be moved to the cell blade
setup.c file instead of here. Now, regarding the above problem, I'm not
sure what is the best fix at this stage. We can't create sane struct
device objects at setup_arch() time.

We could create a hand-made platform or of_platform device from the
above function for every bridge that doesn't have one and hook up it's
DMA ops... I suppose that would fix it.

I've started hacking something but didn't yet get it working, I'll
continue tomorrow unless you come up with some other solution.

Cheers,
Ben.
