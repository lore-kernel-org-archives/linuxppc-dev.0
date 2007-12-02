Return-Path: <SRS0=Nfrs=QZ=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 93EC8DDE38
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Dec 2007 23:37:18 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 12/24] powerpc: 4xx PLB to PCI Express support
Date: Sun, 2 Dec 2007 13:32:28 +0100
References: <20071130061155.41D71DDF5F@ozlabs.org>
In-Reply-To: <20071130061155.41D71DDF5F@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712021332.29074.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben,

On Friday 30 November 2007, Benjamin Herrenschmidt wrote:
> This adds to the previous 2 patches the support for the 4xx PCI Express
> cells as found in the 440SPe revA, revB and 405EX.
>
> Unfortunately, due to significant differences between these, and other
> interesting "features" of those pieces of HW, the code isn't as simple
> as it is for PCI and PCI-X and some of the functions differ significantly
> between the 3 implementations. Thus, not only this code can only support
> those 3 implementations for now and will refuse to operate on any other,
> but there are added ifdef's to avoid the bloat of building a fairly large
> amount of code on platforms that don't need it.
>
> Also, this code currently only supports fully initializing root complex
> nodes, not endpoint. Some more code will have to be lifted from the
> arch/ppc implementation to add the endpoint support, though it's mostly
> differences in memory mapping, and the question on how to represent
> endpoint mode PCI in the device-tree is thus open.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>
> 440SPeA is untested, 440SPeB is slightly tested (with a sky2 network card
> on port 0 only for now) and 405EX is untested.

As already mentioned I'm experiencing some problems with this current version. 
At least what's available in Josh's 2.6.25-candidates branch. The kernel 
crashes in the first ppc4xx_pciex_read_config() call upon (after I fixed the 
small problem mentioned further down below):

	BUG_ON(hose != port->hose);

So before digging into this deeper, I wanted to check if you don't have a 
slightly "better" version which passed your tests with the sky2 PCIe card.

One further comment below.

>  arch/powerpc/Kconfig             |    1
>  arch/powerpc/sysdev/Kconfig      |    8
>  arch/powerpc/sysdev/ppc4xx_pci.c |  927
> ++++++++++++++++++++++++++++++++++++++- arch/powerpc/sysdev/ppc4xx_pci.h | 
> 237 +++++++++
>  4 files changed, 1172 insertions(+), 1 deletion(-)
>
> Index: linux-work/arch/powerpc/sysdev/ppc4xx_pci.c

<snip>

> +static void __init ppc4xx_pciex_port_setup_hose(struct ppc4xx_pciex_port
> *port) +{
> +	struct resource dma_window;
> +	struct pci_controller *hose = NULL;
> +	const int *bus_range;
> +	int primary, busses;
> +	void __iomem *mbase = NULL, *cfg_data = NULL;
> +
> +	/* XXX FIXME: Handle endpoint mode properly */
> +	if (port->endpoint)
> +		return;
> +
> +	/* Check if primary bridge */
> +	if (of_get_property(port->node, "primary", NULL))
> +		primary = 1;
> +
> +	/* Get bus range if any */
> +	bus_range = of_get_property(port->node, "bus-range", NULL);
> +
> +	/* Allocate the host controller data structure */
> +	hose = pcibios_alloc_controller(port->node);
> +	if (!hose)
> +		goto fail;
> +
> +	/* We stick the port number in "indirect_type" so the config space
> +	 * ops can retrieve the port data structure easily
> +	 */
> +	hose->indirect_type = port->index;
> +
> +	/* Get bus range */
> +	hose->first_busno = bus_range ? bus_range[0] : 0x0;
> +	hose->last_busno = bus_range ? bus_range[1] : 0xff;
> +
> +	/* Because of how big mapping the config space is (1M per bus), we
> +	 * limit how many busses we support. In the long run, we could replace
> +	 * that with something akin to kmap_atomic instead. We set aside 1 bus
> +	 * for the host itself too.
> +	 */
> +	busses = hose->last_busno - hose->first_busno; /* This is off by 1 */
> +	if (busses > MAX_PCIE_BUS_MAPPED) {
> +		busses = MAX_PCIE_BUS_MAPPED;
> +		hose->last_busno = hose->first_busno + busses;
> +	}
> +
> +	/* We map the external config space in cfg_data and the host config
> +	 * space in cfg_addr. External space is 1M per bus, internal space
> +	 * is 4K
> +	 */
> +	cfg_data = ioremap(port->cfg_space.start +
> +				 (hose->first_busno + 1) * 0x100000,
> +				 busses * 0x100000);
> +	mbase = ioremap(port->cfg_space.start + 0x10000000, 0x1000);
> +	if (cfg_data == NULL || mbase == NULL) {
> +		printk(KERN_ERR "%s: Can't map config space !",
> +		       port->node->full_name);
> +		goto fail;
> +	}
> +
> +	hose->cfg_data = cfg_data;
> +	hose->cfg_addr = mbase;
> +
> +#ifdef CONFIG_40x
> +	/*
> +	 * 405EX needs this offset in the PCIe config cycles
> +	 * need a little more debugging to see if this can be handled
> +	 * differently.				sr, 2007-10
> +	 */
> +	if (of_device_is_compatible(port->node, "ibm,plb-pciex-405ex"))
> +		hose->cfg_data -= 0x8000;
> +#endif /* CONFIG_40x */
> +
> +	pr_debug("PCIE %s, bus %d..%d\n", port->node->full_name,
> +		 hose->first_busno, hose->last_busno);
> +	pr_debug("     config space mapped at: root @0x%p, other @0x%p\n",
> +		 hose->cfg_addr, hose->cfg_data);
> +
> +	/* Setup config space */
> +	hose->ops = &ppc4xx_pciex_pci_ops;
> +	port->hose = hose;
> +	mbase = (void __iomem *)hose->cfg_addr;
> +
> +	/*
> +	 * Set bus numbers on our root port
> +	 */
> +	out_8(mbase + PCI_PRIMARY_BUS, hose->first_busno);
> +	out_8(mbase + PCI_SECONDARY_BUS, hose->first_busno + 1);
> +	out_8(mbase + PCI_SUBORDINATE_BUS, hose->last_busno);
> +
> +	/*
> +	 * OMRs are already reset, also disable PIMs
> +	 */
> +	out_le32(mbase + PECFG_PIMEN, 0);
> +
> +	/* Parse outbound mapping resources */
> +	pci_process_bridge_OF_ranges(hose, port->node, primary);
> +
> +	/* Parse inbound mapping resources */
> +	if (ppc4xx_parse_dma_ranges(hose, mbase, &dma_window) != 0)
> +		goto fail;
> +
> +	/* Configure outbound ranges POMs */
> +	ppc4xx_configure_pciex_POMs(port, hose, mbase);
> +
> +	/* Configure inbound ranges PIMs */
> +	ppc4xx_configure_pciex_PIMs(port, hose, mbase, &dma_window);
> +
> +	/* The root complex doesn't show up if we don't set some vendor
> +	 * and device IDs into it. Those are the same bogus one that the
> +	 * initial code in arch/ppc add. We might want to change that.
> +	 */
> +	out_le16(mbase + 0x200, 0xaaa0 + port->index);
> +	out_le16(mbase + 0x202, 0xbed0 + port->index);
> +
> +	/* Set Class Code to PCI-PCI bridge and Revision Id to 1 */
> +	out_le32(mbase + 0x208, 0x06040001);
> +
> +	printk(KERN_INFO "PCIE%d: successfully set as root-complex\n",
> +	       port->index);
> +	return;
> + fail:
> +	if (hose)
> +		pcibios_free_controller(hose);
> +	if (fg_data)

Should be "cfg_data". I suspect you you have a newer version that compiles 
clean.

Thanks.

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================
