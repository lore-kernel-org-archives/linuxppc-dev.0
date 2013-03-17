Return-Path: <B16395@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5C9B62C00B7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2013 02:49:26 +1100 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH 5/5 v9] iommu/fsl: Freescale PAMU driver and iommu
 implementation.
Date: Sun, 17 Mar 2013 15:48:12 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D40ABB4@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1363200580-11623-1-git-send-email-Varun.Sethi@freescale.com>
 <0080B56D-8417-41B9-8341-665457D04DE6@kernel.crashing.org>
In-Reply-To: <0080B56D-8417-41B9-8341-665457D04DE6@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Yoder Stuart-B08248 <B08248@freescale.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: iommu-bounces@lists.linux-foundation.org [mailto:iommu-
> bounces@lists.linux-foundation.org] On Behalf Of Kumar Gala
> Sent: Friday, March 15, 2013 1:50 AM
> To: Sethi Varun-B16395
> Cc: benh@kernel.crashing.org; linux-kernel@vger.kernel.org; Yoder Stuart-
> B08248; iommu@lists.linux-foundation.org; Wood Scott-B07421; linuxppc-
> dev@lists.ozlabs.org
> Subject: Re: [PATCH 5/5 v9] iommu/fsl: Freescale PAMU driver and iommu
> implementation.
>=20
>=20
> On Mar 13, 2013, at 1:49 PM, Varun Sethi wrote:
>=20
> > +/*
> > + * Table of SVRs and the corresponding PORT_ID values.
> > + *
> > + * All future CoreNet-enabled SOCs will have this erratum fixed, so
> > +this table
> > + * should never need to be updated.  SVRs are guaranteed to be
> > +unique, so
> > + * there is no worry that a future SOC will inadvertently have one of
> > +these
> > + * values.
> > + */
>=20
> Maybe add to the comment about what port_id represents
>=20
[Sethi Varun-B16395] ok.
> > +static const struct {
> > +	u32 svr;
> > +	u32 port_id;
> > +} port_id_map[] =3D {
> > +	{0x82100010, 0xFF000000},	/* P2040 1.0 */
> > +	{0x82100011, 0xFF000000},	/* P2040 1.1 */
> > +	{0x82100110, 0xFF000000},	/* P2041 1.0 */
> > +	{0x82100111, 0xFF000000},	/* P2041 1.1 */
> > +	{0x82110310, 0xFF000000},	/* P3041 1.0 */
> > +	{0x82110311, 0xFF000000},	/* P3041 1.1 */
> > +	{0x82010020, 0xFFF80000},	/* P4040 2.0 */
> > +	{0x82000020, 0xFFF80000},	/* P4080 2.0 */
> > +	{0x82210010, 0xFC000000},       /* P5010 1.0 */
> > +	{0x82210020, 0xFC000000},       /* P5010 2.0 */
> > +	{0x82200010, 0xFC000000},	/* P5020 1.0 */
> > +	{0x82050010, 0xFF800000},	/* P5021 1.0 */
> > +	{0x82040010, 0xFF800000},	/* P5040 1.0 */
> > +};
> > +
> > +#define SVR_SECURITY	0x80000	/* The Security (E) bit */
> > +
> > +static int __init fsl_pamu_probe(struct platform_device *pdev) {
> > +	void __iomem *pamu_regs =3D NULL;
> > +	struct ccsr_guts __iomem *guts_regs =3D NULL;
> > +	u32 pamubypenr, pamu_counter;
> > +	unsigned long pamu_reg_off;
> > +	unsigned long pamu_reg_base;
> > +	struct pamu_isr_data *data;
> > +	struct device_node *guts_node;
> > +	u64 size;
> > +	struct page *p;
> > +	int ret =3D 0;
> > +	int irq;
> > +	phys_addr_t ppaact_phys;
> > +	phys_addr_t spaact_phys;
> > +	phys_addr_t omt_phys;
> > +	size_t mem_size =3D 0;
> > +	unsigned int order =3D 0;
> > +	u32 csd_port_id =3D 0;
> > +	unsigned i;
> > +	/*
> > +	 * enumerate all PAMUs and allocate and setup PAMU tables
> > +	 * for each of them,
> > +	 * NOTE : All PAMUs share the same LIODN tables.
> > +	 */
> > +
> > +	pamu_regs =3D of_iomap(pdev->dev.of_node, 0);
> > +	if (!pamu_regs) {
> > +		dev_err(&pdev->dev, "ioremap of PAMU node failed\n");
> > +		return -ENOMEM;
> > +	}
> > +	of_get_address(pdev->dev.of_node, 0, &size, NULL);
> > +
> > +	irq =3D irq_of_parse_and_map(pdev->dev.of_node, 0);
> > +	if (irq =3D=3D NO_IRQ) {
> > +		dev_warn(&pdev->dev, "no interrupts listed in PAMU node\n");
> > +		goto error;
> > +	}
> > +
> > +	data =3D kzalloc(sizeof(struct pamu_isr_data), GFP_KERNEL);
> > +	if (!data) {
> > +		iounmap(pamu_regs);
> > +		return -ENOMEM;
> > +	}
> > +	data->pamu_reg_base =3D pamu_regs;
> > +	data->count =3D size / PAMU_OFFSET;
> > +
> > +	/* The ISR needs access to the regs, so we won't iounmap them */
> > +	ret =3D request_irq(irq, pamu_av_isr, 0, "pamu", data);
> > +	if (ret < 0) {
> > +		dev_err(&pdev->dev, "error %i installing ISR for irq %i\n",
> > +			ret, irq);
> > +		goto error;
> > +	}
> > +
> > +	guts_node =3D of_find_compatible_node(NULL, NULL,
> > +			"fsl,qoriq-device-config-1.0");
>=20
> This doesn't work for T4 or B4 device trees.
>=20
[Sethi Varun-B16395]hmm.... I need to use the dcfg space for this.

> > +	if (!guts_node) {
> > +		dev_err(&pdev->dev, "could not find GUTS node %s\n",
> > +			pdev->dev.of_node->full_name);
> > +		ret =3D -ENODEV;
> > +		goto error;
> > +	}
> > +
> > +	guts_regs =3D of_iomap(guts_node, 0);
> > +	of_node_put(guts_node);
> > +	if (!guts_regs) {
> > +		dev_err(&pdev->dev, "ioremap of GUTS node failed\n");
> > +		ret =3D -ENODEV;
> > +		goto error;
> > +	}
> > +
> > +	/* read in the PAMU capability registers */
> > +	get_pamu_cap_values((unsigned long)pamu_regs);
> > +	/*
> > +	 * To simplify the allocation of a coherency domain, we allocate
> the
> > +	 * PAACT and the OMT in the same memory buffer.  Unfortunately,
> this
> > +	 * wastes more memory compared to allocating the buffers
> separately.
> > +	 */
> > +	/* Determine how much memory we need */
> > +	mem_size =3D (PAGE_SIZE << get_order(PAACT_SIZE)) +
> > +		(PAGE_SIZE << get_order(SPAACT_SIZE)) +
> > +		(PAGE_SIZE << get_order(OMT_SIZE));
> > +	order =3D get_order(mem_size);
> > +
> > +	p =3D alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
> > +	if (!p) {
> > +		dev_err(&pdev->dev, "unable to allocate PAACT/SPAACT/OMT
> block\n");
> > +		ret =3D -ENOMEM;
> > +		goto error;
> > +	}
> > +
> > +	ppaact =3D page_address(p);
> > +	ppaact_phys =3D page_to_phys(p);
> > +
> > +	/* Make sure the memory is naturally aligned */
> > +	if (ppaact_phys & ((PAGE_SIZE << order) - 1)) {
> > +		dev_err(&pdev->dev, "PAACT/OMT block is unaligned\n");
> > +		ret =3D -ENOMEM;
> > +		goto error;
> > +	}
> > +
> > +	spaact =3D (void *)ppaact + (PAGE_SIZE << get_order(PAACT_SIZE));
> > +	omt =3D (void *)spaact + (PAGE_SIZE << get_order(SPAACT_SIZE));
> > +
> > +	dev_dbg(&pdev->dev, "ppaact virt=3D%p phys=3D0x%llx\n", ppaact,
> > +		(unsigned long long) ppaact_phys);
> > +
> > +	/* Check to see if we need to implement the work-around on this SOC
> > +*/
> > +
> > +	/* Determine the Port ID for our coherence subdomain */
> > +	for (i =3D 0; i < ARRAY_SIZE(port_id_map); i++) {
> > +		if (port_id_map[i].svr =3D=3D (mfspr(SPRN_SVR) & ~SVR_SECURITY))
> {
> > +			csd_port_id =3D port_id_map[i].port_id;
> > +			dev_dbg(&pdev->dev, "found matching SVR %08x\n",
> > +				port_id_map[i].svr);
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (csd_port_id) {
> > +		dev_dbg(&pdev->dev, "creating coherency subdomain at address
> "
> > +			"0x%llx, size %zu, port id 0x%08x", ppaact_phys,
> > +			mem_size, csd_port_id);
> > +
> > +		ret =3D create_csd(ppaact_phys, mem_size, csd_port_id);
> > +		if (ret) {
> > +			dev_err(&pdev->dev, "could not create coherence "
> > +				"subdomain\n");
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	spaact_phys =3D virt_to_phys(spaact);
> > +	omt_phys =3D virt_to_phys(omt);
> > +
> > +	spaace_pool =3D gen_pool_create(ilog2(sizeof(struct paace)), -1);
> > +	if (!spaace_pool) {
> > +		ret =3D -ENOMEM;
> > +		dev_err(&pdev->dev, "PAMU : failed to allocate spaace gen
> pool\n");
> > +		goto error;
> > +	}
> > +
> > +	ret =3D gen_pool_add(spaace_pool, (unsigned long)spaact, SPAACT_SIZE,
> -1);
> > +	if (ret)
> > +		goto error_genpool;
> > +
> > +	pamubypenr =3D in_be32(&guts_regs->pamubypenr);
> > +
> > +	for (pamu_reg_off =3D 0, pamu_counter =3D 0x80000000; pamu_reg_off <
> size;
> > +	     pamu_reg_off +=3D PAMU_OFFSET, pamu_counter >>=3D 1) {
> > +
> > +		pamu_reg_base =3D (unsigned long) pamu_regs + pamu_reg_off;
> > +		setup_one_pamu(pamu_reg_base, pamu_reg_off, ppaact_phys,
> > +				 spaact_phys, omt_phys);
> > +		/* Disable PAMU bypass for this PAMU */
> > +		pamubypenr &=3D ~pamu_counter;
> > +	}
> > +
> > +	setup_omt(omt);
> > +
> > +	/* Enable all relevant PAMU(s) */
> > +	out_be32(&guts_regs->pamubypenr, pamubypenr);
> > +
> > +	iounmap(guts_regs);
> > +
> > +	/* Enable DMA for the LIODNs in the device tree*/
> > +
> > +	setup_liodns();
> > +
> > +	return 0;
> > +
> > +error_genpool:
> > +	gen_pool_destroy(spaace_pool);
> > +
> > +error:
> > +	if (irq !=3D NO_IRQ)
> > +		free_irq(irq, 0);
>=20
> Should be:
>=20
> free_irq(irq, data);
>=20
[Sethi Varun-B16395] Yes.
> > +
> > +	if (pamu_regs)
> > +		iounmap(pamu_regs);
> > +
> > +	if (guts_regs)
> > +		iounmap(guts_regs);
> > +
> > +	if (ppaact)
> > +		free_pages((unsigned long)ppaact, order);
> > +
> > +	ppaact =3D NULL;
> > +
>=20
> you alloc data, shouldn't you free it ?
>=20
[Sethi Varun-B16395] Yes.

-Varun
