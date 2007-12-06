Return-Path: <SRS0=GNhQ=Q5=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 7A1C5DDF46
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2007 20:27:02 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 11/25] powerpc: 4xx PLB to PCI Express support
Date: Thu, 6 Dec 2007 10:26:56 +0100
References: <20071206080120.B47DBDDF15@ozlabs.org>
In-Reply-To: <20071206080120.B47DBDDF15@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712061026.57215.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 06 December 2007, Benjamin Herrenschmidt wrote:
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
> Many thanks to Stefan Roese for testing & fixing up the 405EX bits !

You're welcome. Thank you for doing the "dirty work".

Please find some comments below.

<snip>

> +/* Check that the core has been initied and if not, do it */
> +static int __init ppc4xx_pciex_check_core_init(struct device_node *np)
> +{
> +	static int core_init;
> +	int count = -ENODEV;
> +
> +	if (core_init++)
> +		return 0;
> +
> +#ifdef CONFIG_44x
> +	if (of_device_is_compatible(np, "ibm,plb-pciex-440speA"))
> +		ppc4xx_pciex_hwops = &ppc440speA_pcie_hwops;
> +	else if (of_device_is_compatible(np, "ibm,plb-pciex-440speB"))
> +		ppc4xx_pciex_hwops = &ppc440speB_pcie_hwops;

We need some runtime detection of the 440SPe revision here. There are boards 
out there (e.g. AMCC Yucca) which can be equipped with both PPC 
revisions. :-(

> +#endif /* CONFIG_44x    */
> +#ifdef CONFIG_40x
> +	if (of_device_is_compatible(np, "ibm,plb-pciex-405ex"))
> +		ppc4xx_pciex_hwops = &ppc405ex_pcie_hwops;
> +#endif

Why those #ifdef's? Just code-size reasons, since 40x and 44x will most likely 
never be built into one image? 

Thanks.

Best regards,
Stefan
