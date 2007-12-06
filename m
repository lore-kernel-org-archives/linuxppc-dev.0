Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8BB79DDF04
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 09:21:43 +1100 (EST)
Subject: Re: [PATCH 11/25] powerpc: 4xx PLB to PCI Express support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200712061026.57215.sr@denx.de>
References: <20071206080120.B47DBDDF15@ozlabs.org>
	<200712061026.57215.sr@denx.de>
Content-Type: text/plain
Date: Fri, 07 Dec 2007 09:21:26 +1100
Message-Id: <1196979686.6599.1.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > +/* Check that the core has been initied and if not, do it */
> > +static int __init ppc4xx_pciex_check_core_init(struct device_node *np)
> > +{
> > +	static int core_init;
> > +	int count = -ENODEV;
> > +
> > +	if (core_init++)
> > +		return 0;
> > +
> > +#ifdef CONFIG_44x
> > +	if (of_device_is_compatible(np, "ibm,plb-pciex-440speA"))
> > +		ppc4xx_pciex_hwops = &ppc440speA_pcie_hwops;
> > +	else if (of_device_is_compatible(np, "ibm,plb-pciex-440speB"))
> > +		ppc4xx_pciex_hwops = &ppc440speB_pcie_hwops;
> 
> We need some runtime detection of the 440SPe revision here. There are boards 
> out there (e.g. AMCC Yucca) which can be equipped with both PPC 
> revisions. :-(

Ah... crap ! Do you think we should put that in the boot wrapper and
fixup the device-tree or should we put it in the PCIe code proper ?

> > +#endif /* CONFIG_44x    */
> > +#ifdef CONFIG_40x
> > +	if (of_device_is_compatible(np, "ibm,plb-pciex-405ex"))
> > +		ppc4xx_pciex_hwops = &ppc405ex_pcie_hwops;
> > +#endif
> 
> Why those #ifdef's? Just code-size reasons, since 40x and 44x will most likely 
> never be built into one image? 

Code size... I know how keen embedded people are to keep their kernel
small and as of today, you can't build 40x and 44x support in the same
image, so I didn't want to be blamed for adding bloat in that case :-)

Ben.
