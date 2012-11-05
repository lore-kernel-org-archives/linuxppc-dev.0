Return-Path: <B38951@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BA7DF2C01C6
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Nov 2012 13:40:35 +1100 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: RE: [linuxppc-release] [PATCH] powerpc/fsl-pci: Add PCI controller
 ATMU PM support
Date: Mon, 5 Nov 2012 02:40:24 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01B2F820@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1351736348-26754-1-git-send-email-B38951@freescale.com>
 <50927862.9080909@freescale.com>
In-Reply-To: <50927862.9080909@freescale.com>
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



> -----Original Message-----
> From: Tabi Timur-B04825
> Sent: Thursday, November 01, 2012 9:26 PM
> To: Jia Hongtao-B38951
> Cc: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org; Wood Scott-
> B07421; Li Yang-R58472
> Subject: Re: [linuxppc-release] [PATCH] powerpc/fsl-pci: Add PCI
> controller ATMU PM support
>=20
> Jia Hongtao wrote:
>=20
> > +#ifdef CONFIG_SUSPEND
> > +static int fsl_pci_resume(struct platform_device *pdev)
> > +{
> > +	struct pci_controller *hose;
> > +	struct resource pci_rsrc;
> > +
> > +	hose =3D pci_find_hose_for_OF_device(pdev->dev.of_node);
> > +	of_address_to_resource(pdev->dev.of_node, 0, &pci_rsrc);
> > +	setup_pci_atmu(hose, &pci_rsrc);
> > +
> > +	return 0;
> > +}
>=20
> Some of these functions can fail, so they should return an error code if
> they do.

I checked the of_address_to_resource function now.
Is that necessary to check other two fuctions?

>=20
> > +#endif
> > +
> >  static struct platform_driver fsl_pci_driver =3D {
> >  	.driver =3D {
> >  		.name =3D "fsl-pci",
> >  		.of_match_table =3D pci_ids,
> >  	},
> >  	.probe =3D fsl_pci_probe,
> > +#ifdef CONFIG_SUSPEND
> > +	.resume	=3D fsl_pci_resume,
> > +#endif
>=20
> Do this instead:
>=20
> #ifdef CONFIG_SUSPEND
> static int fsl_pci_resume(struct platform_device *pdev)
> ...
> #else
> #define fsl_pci_resume NULL
> #endif

Ok, I will update this.

-Hongtao.
