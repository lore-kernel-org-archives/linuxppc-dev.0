Return-Path: <B16395@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A91082C02AF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2013 17:16:24 +1100 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Stuart Yoder <b08248@gmail.com>
Subject: RE: [PATCH 2/6] powerpc/fsl_pci: Store the platform device
 information corresponding to the pci controller.
Date: Tue, 26 Feb 2013 06:16:10 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D3BD338@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1361191939-21260-1-git-send-email-Varun.Sethi@freescale.com>
 <1361191939-21260-3-git-send-email-Varun.Sethi@freescale.com>
 <CALRxmdDc9TuxH7HgAF3_iLgatoaOUML6fUt8SU+sxHyz6ZVjfw@mail.gmail.com>
In-Reply-To: <CALRxmdDc9TuxH7HgAF3_iLgatoaOUML6fUt8SU+sxHyz6ZVjfw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>, Joerg Roedel <joro@8bytes.org>,
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

This patch is not present in Joerg's tree and the add_device API in the PAM=
U driver requires this patch.

-Varun

> -----Original Message-----
> From: Stuart Yoder [mailto:b08248@gmail.com]
> Sent: Tuesday, February 26, 2013 5:39 AM
> To: Sethi Varun-B16395
> Cc: iommu@lists.linux-foundation.org; linuxppc-dev@lists.ozlabs.org;
> linux-kernel@vger.kernel.org; Wood Scott-B07421; Joerg Roedel; Yoder
> Stuart-B08248
> Subject: Re: [PATCH 2/6] powerpc/fsl_pci: Store the platform device
> information corresponding to the pci controller.
>=20
> This patch was submitted separately to linuxppc-dev (and was already
> applied).  You don't need it in this patch set, right?
>=20
> Stuart
>=20
> On Mon, Feb 18, 2013 at 6:52 AM, Varun Sethi <Varun.Sethi@freescale.com>
> wrote:
> > The pci controller structure has a provision to store the device
> > strcuture pointer of the corresponding platform device. Currently this
> > information is not stored during fsl pci controller initialization.
> > This information is required while dealing with iommu groups for pci
> > devices connected to the fsl pci controller. For the case where the
> > pci devices can't be paritioned, they would fall under the same device
> group as the pci controller.
> >
> > This patch stores the platform device information in the pci
> > controller structure during initialization.
> >
> > Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> > ---
> >  arch/powerpc/sysdev/fsl_pci.c |    9 +++++++--
> >  arch/powerpc/sysdev/fsl_pci.h |    2 +-
> >  2 files changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/powerpc/sysdev/fsl_pci.c
> > b/arch/powerpc/sysdev/fsl_pci.c index 92a5915..b393ae7 100644
> > --- a/arch/powerpc/sysdev/fsl_pci.c
> > +++ b/arch/powerpc/sysdev/fsl_pci.c
> > @@ -421,13 +421,16 @@ void fsl_pcibios_fixup_bus(struct pci_bus *bus)
> >         }
> >  }
> >
> > -int __init fsl_add_bridge(struct device_node *dev, int is_primary)
> > +int __init fsl_add_bridge(struct platform_device *pdev, int
> > +is_primary)
> >  {
> >         int len;
> >         struct pci_controller *hose;
> >         struct resource rsrc;
> >         const int *bus_range;
> >         u8 hdr_type, progif;
> > +       struct device_node *dev;
> > +
> > +       dev =3D pdev->dev.of_node;
> >
> >         if (!of_device_is_available(dev)) {
> >                 pr_warning("%s: disabled\n", dev->full_name); @@
> > -453,6 +456,8 @@ int __init fsl_add_bridge(struct device_node *dev, int
> is_primary)
> >         if (!hose)
> >                 return -ENOMEM;
> >
> > +       /* set platform device as the parent */
> > +       hose->parent =3D &pdev->dev;
> >         hose->first_busno =3D bus_range ? bus_range[0] : 0x0;
> >         hose->last_busno =3D bus_range ? bus_range[1] : 0xff;
> >
> > @@ -880,7 +885,7 @@ static int fsl_pci_probe(struct platform_device
> > *pdev)  #endif
> >
> >         node =3D pdev->dev.of_node;
> > -       ret =3D fsl_add_bridge(node, fsl_pci_primary =3D=3D node);
> > +       ret =3D fsl_add_bridge(pdev, fsl_pci_primary =3D=3D node);
> >
> >  #ifdef CONFIG_SWIOTLB
> >         if (ret =3D=3D 0) {
> > diff --git a/arch/powerpc/sysdev/fsl_pci.h
> > b/arch/powerpc/sysdev/fsl_pci.h index d078537..c495c00 100644
> > --- a/arch/powerpc/sysdev/fsl_pci.h
> > +++ b/arch/powerpc/sysdev/fsl_pci.h
> > @@ -91,7 +91,7 @@ struct ccsr_pci {
> >         __be32  pex_err_cap_r3;         /* 0x.e34 - PCIE error capture
> register 0 */
> >  };
> >
> > -extern int fsl_add_bridge(struct device_node *dev, int is_primary);
> > +extern int fsl_add_bridge(struct platform_device *pdev, int
> > +is_primary);
> >  extern void fsl_pcibios_fixup_bus(struct pci_bus *bus);  extern int
> > mpc83xx_add_bridge(struct device_node *dev);
> >  u64 fsl_pci_immrbar_base(struct pci_controller *hose);
> > --
> > 1.7.4.1
> >
> >
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
