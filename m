Return-Path: <B38951@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 91ECB2C007F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2012 20:34:56 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Michael Neuling <mikey@neuling.org>
Subject: RE: [PATCH V10] powerpc/fsl-pci: Unify pci/pcie initialization code
Date: Tue, 18 Sep 2012 10:34:48 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01AA9F50@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1346139848-28021-1-git-send-email-B38951@freescale.com>
 <14502.1347962174@neuling.org>
In-Reply-To: <14502.1347962174@neuling.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
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
> From: Michael Neuling [mailto:mikey@neuling.org]
> Sent: Tuesday, September 18, 2012 5:56 PM
> To: Jia Hongtao-B38951
> Cc: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org; Wood Scott-
> B07421; benh@kernel.crashing.org; linux-next@vger.kernel.org
> Subject: Re: [PATCH V10] powerpc/fsl-pci: Unify pci/pcie initialization
> code
>=20
> > +static int __devinit fsl_pci_probe(struct platform_device *pdev) {
> > +	int ret;
> > +	struct device_node *node;
> > +	struct pci_controller *hose;
> > +
> > +	node =3D pdev->dev.of_node;
> > +	ret =3D fsl_add_bridge(node, fsl_pci_primary =3D=3D node);
> >
> >  #ifdef CONFIG_SWIOTLB
> > -	/*
> > -	 * if we couldn't map all of DRAM via the dma windows
> > -	 * we need SWIOTLB to handle buffers located outside of
> > -	 * dma capable memory region
> > -	 */
> > -	if (memblock_end_of_DRAM() - 1 > max)
> > -		ppc_swiotlb_enable =3D 1;
> > +	if (ret =3D=3D 0) {
> > +		hose =3D pci_find_hose_for_OF_device(pdev->dev.of_node);
> > +
> > +		/*
> > +		 * if we couldn't map all of DRAM via the dma windows
> > +		 * we need SWIOTLB to handle buffers located outside of
> > +		 * dma capable memory region
> > +		 */
> > +		if (memblock_end_of_DRAM() - 1 > hose->dma_window_base_cur +
> > +				hose->dma_window_size)
> > +			ppc_swiotlb_enable =3D 1;
> > +	}
> >  #endif
> > +
> > +	mpc85xx_pci_err_probe(pdev);
> > +
> > +	return 0;
> > +}
>=20
> This breaks when CONFIG_SWIOTLB is disabled (chroma_defconfig hit this
> next-20120918), but think this could also hit in Linus tree:
>=20
>   arch/powerpc/sysdev/fsl_pci.c: In function 'fsl_pci_probe':
>   arch/powerpc/sysdev/fsl_pci.c:867:25: error: unused variable 'hose' [-
> Werror=3Dunused-variable]
>   cc1: all warnings being treated as errors
>=20
> Mikey

You are right, it's a problem.
I already send a patch to fix this.
Pls refer to http://patchwork.ozlabs.org/patch/184673/

Thanks for your response.

- Hongtao.
