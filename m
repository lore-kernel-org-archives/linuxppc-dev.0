Return-Path: <SRS0=99Ew=Q6=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id C2599DDDE7
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 18:02:14 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 11/25] powerpc: 4xx PLB to PCI Express support
Date: Fri, 7 Dec 2007 08:02:00 +0100
References: <20071206080120.B47DBDDF15@ozlabs.org>
	<200712061026.57215.sr@denx.de> <1196979686.6599.1.camel@pasglop>
In-Reply-To: <1196979686.6599.1.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200712070802.01126.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 06 December 2007, Benjamin Herrenschmidt wrote:
> > > +/* Check that the core has been initied and if not, do it */
> > > +static int __init ppc4xx_pciex_check_core_init(struct device_node *np)
> > > +{
> > > +	static int core_init;
> > > +	int count = -ENODEV;
> > > +
> > > +	if (core_init++)
> > > +		return 0;
> > > +
> > > +#ifdef CONFIG_44x
> > > +	if (of_device_is_compatible(np, "ibm,plb-pciex-440speA"))
> > > +		ppc4xx_pciex_hwops = &ppc440speA_pcie_hwops;
> > > +	else if (of_device_is_compatible(np, "ibm,plb-pciex-440speB"))
> > > +		ppc4xx_pciex_hwops = &ppc440speB_pcie_hwops;
> >
> > We need some runtime detection of the 440SPe revision here. There are
> > boards out there (e.g. AMCC Yucca) which can be equipped with both PPC
> > revisions. :-(
>
> Ah... crap ! Do you think we should put that in the boot wrapper and
> fixup the device-tree or should we put it in the PCIe code proper ?

How about this: We change the compatible node to "plb-pciex-440spe" 
(without "A" and "B) and make a PVR runtime detection in the 4xx-pci driver.

What do you think? Should I prepare a patch for this?

> > > +#endif /* CONFIG_44x    */
> > > +#ifdef CONFIG_40x
> > > +	if (of_device_is_compatible(np, "ibm,plb-pciex-405ex"))
> > > +		ppc4xx_pciex_hwops = &ppc405ex_pcie_hwops;
> > > +#endif
> >
> > Why those #ifdef's? Just code-size reasons, since 40x and 44x will most
> > likely never be built into one image?
>
> Code size... I know how keen embedded people are to keep their kernel
> small and as of today, you can't build 40x and 44x support in the same
> image, so I didn't want to be blamed for adding bloat in that case :-)

Ok. Thanks.

Best regards,
Stefan
