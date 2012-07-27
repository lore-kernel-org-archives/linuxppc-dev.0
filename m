Return-Path: <B38951@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0476B2C008F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2012 20:10:18 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH V3 1/5] powerpc/fsl-pci: Unify pci/pcie initialization code
Date: Fri, 27 Jul 2012 10:10:10 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01A289D8@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1343305827-26734-1-git-send-email-B38951@freescale.com>
 <ACC8975F-CA31-4AA0-9824-4C3F6C70CD45@kernel.crashing.org>
In-Reply-To: <ACC8975F-CA31-4AA0-9824-4C3F6C70CD45@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi kumar,

I know "duplicate code from pci_process_bridge_OF_ranges()" is
hard to accept but "refactor the code to have a shared function"
is knotty. Actually this is the reason I didn't do the refactor.

Here is the situation:

First, pci_process_bridge_OF_ranges() is a common code using by
so many pci client.

Second, the contents of pci_process_bridge_OF_ranges() twisted
together. It's hard to decouple the function I need for determining
swiotlb with other contents. I tried and found a way to do this
but the shared function need so many parameters which is also
unacceptable.=20

Third, my function to determine swiotlb should know the start
and the end of pci mem space address for all the controllers.
Note that the end of address is for determining where to map
PEXCSRBAR.

If you have any idea for this please let me know.

Thanks.
-Hongtao.


> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Friday, July 27, 2012 1:53 AM
> To: Jia Hongtao-B38951
> Cc: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421; Li Yang-R58472
> Subject: Re: [PATCH V3 1/5] powerpc/fsl-pci: Unify pci/pcie
> initialization code
>=20
>=20
> On Jul 26, 2012, at 7:30 AM, Jia Hongtao wrote:
>=20
> > We unified the Freescale pci/pcie initialization by changing the
> fsl_pci
> > to a platform driver. In previous PCI code architecture the
> initialization
> > routine is called at board_setup_arch stage. Now the initialization is
> done
> > in probe function which is architectural better. Also It's convenient
> for
> > adding PM support for PCI controller in later patch.
> >
> > One issue introduced by this architecture is the timing of swiotlb_init=
.
> > During PCI initialization the need of swiotlb is determined and this
> should
> > be done before swiotlb_init. So a new function to determine swiotlb by
> > parsing pci ranges is made. This function is called at board_setup_arch
> > stage which is earlier than swiotlb_init.
> >
> > Signed-off-by: Jia Hongtao <B38951@freescale.com>
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > ---
> > Changed for V3:
> > - Rebase the patch set on the latest tree
> > - merge PCI unify and swiotlb patch into one
> >
> > arch/powerpc/sysdev/fsl_pci.c |  155 ++++++++++++++++++++++++++++++++--
> -------
> > arch/powerpc/sysdev/fsl_pci.h |    9 +--
> > 2 files changed, 125 insertions(+), 39 deletions(-)
> >
> > diff --git a/arch/powerpc/sysdev/fsl_pci.c
> b/arch/powerpc/sysdev/fsl_pci.c
> > index a7b2a60..5228b6b 100644
> > --- a/arch/powerpc/sysdev/fsl_pci.c
> > +++ b/arch/powerpc/sysdev/fsl_pci.c
> > @@ -823,56 +823,143 @@ static const struct of_device_id pci_ids[] =3D {
> > 	{},
> > };
> >
> > -struct device_node *fsl_pci_primary;
> > -
> > -void __devinit fsl_pci_init(void)
> > +#ifdef CONFIG_SWIOTLB
> > +void pci_determine_swiotlb(void)
> > {
> > +	const u32 *ranges;
> > +	int rlen;
> > +	int pna;
> > +	int np;
> > 	struct device_node *node;
> > -	struct pci_controller *hose;
> > -	dma_addr_t max =3D 0xffffffff;
> > -
> > -	/* Callers can specify the primary bus using other means. */
> > -	if (!fsl_pci_primary) {
> > -		/* If a PCI host bridge contains an ISA node, it's primary.
> */
> > -		node =3D of_find_node_by_type(NULL, "isa");
> > -		while ((fsl_pci_primary =3D of_get_parent(node))) {
> > -			of_node_put(node);
> > -			node =3D fsl_pci_primary;
> > -
> > -			if (of_match_node(pci_ids, node))
> > -				break;
> > -		}
> > -	}
> > +	int memno;
> > +	u32 pci_space;
> > +	unsigned long long pci_addr, cpu_addr, pci_next, cpu_next, size;
> > +	unsigned long long pci_addr_lo =3D ULLONG_MAX;
> > +	unsigned long long pci_addr_hi =3D 0x0;
> > +	dma_addr_t pci_dma_sz;
> >
> > -	node =3D NULL;
> > 	for_each_node_by_type(node, "pci") {
> > 		if (of_match_node(pci_ids, node)) {
> > -			/*
> > -			 * If there's no PCI host bridge with ISA, arbitrarily
> > -			 * designate one as primary.  This can go away once
> > -			 * various bugs with primary-less systems are fixed.
> > -			 */
> > -			if (!fsl_pci_primary)
> > -				fsl_pci_primary =3D node;
> > -
> > -			fsl_add_bridge(node, fsl_pci_primary =3D=3D node);
> > -			hose =3D pci_find_hose_for_OF_device(node);
> > -			max =3D min(max, hose->dma_window_base_cur +
> > -					hose->dma_window_size);
> > +			memno =3D 0;
> > +			pna =3D of_n_addr_cells(node);
> > +			np =3D pna + 5;
>=20
> Don't duplicate code from pci_process_bridge_OF_ranges(), refactor the
> code to have a shared function:
>=20
> > +			/* Get ranges property */
> > +			ranges =3D of_get_property(node, "ranges", &rlen);
> > +			if (ranges =3D=3D NULL)
> > +				return;
> > +
> > +			/* Parse outbound MEM window range */
> > +			while ((rlen -=3D np * 4) >=3D 0) {
> > +				/* Read next ranges element */
> > +				pci_space =3D ranges[0];
> > +				if (!((pci_space >> 24) & 0x2)) {
> > +					ranges +=3D np;
> > +					break;
> > +				}
> > +				pci_addr =3D of_read_number(ranges + 1, 2);
> > +				cpu_addr =3D of_translate_address(
> > +						node, ranges + 3);
> > +				size =3D of_read_number(ranges + pna + 3, 2);
> > +				ranges +=3D np;
> > +
> > +				/*
> > +				 * If we failed translation or got a zero-sized
> > +				 * region (some FW try to feed us with non
> > +				 * sensical zero sized regions such as power3
> > +				 * which look like some kind of attempt at
> > +				 * exposing the VGA memory hole)
> > +				 */
> > +				if (cpu_addr =3D=3D OF_BAD_ADDR || size =3D=3D 0)
> > +					continue;
> > +
> > +				/*
> > +				 * Now consume following elements while they
> > +				 * are contiguous
> > +				 */
> > +				for (; rlen >=3D np * sizeof(u32);
> > +						ranges +=3D np, rlen -=3D np * 4) {
> > +					if (ranges[0] !=3D pci_space)
> > +						break;
> > +					pci_next =3D of_read_number(ranges + 1,
> > +							2);
> > +					cpu_next =3D of_translate_address(node,
> > +							ranges + 3);
> > +					if (pci_next !=3D pci_addr + size ||
> > +						cpu_next !=3D cpu_addr + size)
> > +						break;
> > +					size +=3D of_read_number(
> > +							ranges + pna + 3, 2);
> > +				}
> > +
> > +				/* We support only 3 memory ranges */
> > +				if (memno >=3D 3) {
> > +					printk(KERN_INFO
> > +							" \\--> Skipped (too
> many) !\n");
> > +					continue;
> > +				}
> > +
> > +				pci_addr_lo =3D min(pci_addr, pci_addr_lo);
> > +				pci_addr_hi =3D max(pci_addr + size, pci_addr_hi);
> > +				memno++;
> > +			}
> > 		}
> > 	}
> >
> > -#ifdef CONFIG_SWIOTLB
> > +	/* Get PEXCSRBAR size (equal to CCSR size) */
> > +	node =3D of_find_node_by_type(NULL, "soc");
> > +	ranges =3D of_get_property(node, "ranges", &rlen);
> > +	if (ranges =3D=3D NULL)
> > +		return;
> > +
> > +	size =3D of_read_number(ranges + 3, 1);
> > +	of_node_put(node);
> > +
> > +	if (pci_addr_hi < (0x100000000ull - size))
> > +		pci_dma_sz =3D pci_addr_lo;
> > +	else
> > +		pci_dma_sz =3D pci_addr_lo - size;
> > +
> > 	/*
> > 	 * if we couldn't map all of DRAM via the dma windows
> > 	 * we need SWIOTLB to handle buffers located outside of
> > 	 * dma capable memory region
> > 	 */
> > -	if (memblock_end_of_DRAM() - 1 > max) {
> > +	if (memblock_end_of_DRAM() > pci_dma_sz) {
> > 		ppc_swiotlb_enable =3D 1;
> > 		set_pci_dma_ops(&swiotlb_dma_ops);
> > -		ppc_md.pci_dma_dev_setup =3D pci_dma_dev_setup_swiotlb;
> > +		ppc_md.pci_dma_dev_setup =3D
> > +			pci_dma_dev_setup_swiotlb;
>=20
> why the line wrap change?
>=20
> > 	}
> > +}
> > #endif
> > +
> > +int primary_phb_addr;
> > +static int __devinit fsl_pci_probe(struct platform_device *pdev)
> > +{
> > +	struct pci_controller *hose;
> > +	bool is_primary;
> > +
> > +	if (of_match_node(pci_ids, pdev->dev.of_node)) {
> > +		struct resource rsrc;
> > +		of_address_to_resource(pdev->dev.of_node, 0, &rsrc);
> > +		is_primary =3D ((rsrc.start & 0xfffff) =3D=3D primary_phb_addr);
> > +		fsl_add_bridge(pdev->dev.of_node, is_primary);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static struct platform_driver fsl_pci_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "fsl-pci",
> > +		.of_match_table =3D pci_ids,
> > +	},
> > +	.probe =3D fsl_pci_probe,
> > +};
> > +
> > +static int __init fsl_pci_init(void)
> > +{
> > +	return platform_driver_register(&fsl_pci_driver);
> > }
> > +arch_initcall(fsl_pci_init);
> > #endif
>=20
>=20
