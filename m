Return-Path: <B16395@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0253.outbound.messaging.microsoft.com [213.199.154.253])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8C4B32C032D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Oct 2013 01:35:54 +1100 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: RE: [PATCH 1/3] iommu/fsl: Factor out PCI specific code.
Date: Tue, 15 Oct 2013 14:35:41 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D0A53D863@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1381609954-15283-1-git-send-email-Varun.Sethi@freescale.com>
 <1381609954-15283-2-git-send-email-Varun.Sethi@freescale.com>
 <20131015001611.GA9203@google.com>
In-Reply-To: <20131015001611.GA9203@google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Yoder Stuart-B08248 <B08248@freescale.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Bhushan Bharat-R65777 <R65777@freescale.com>,
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
> bounces@lists.linux-foundation.org] On Behalf Of Bjorn Helgaas
> Sent: Tuesday, October 15, 2013 5:46 AM
> To: Sethi Varun-B16395
> Cc: Yoder Stuart-B08248; linux-kernel@vger.kernel.org; iommu@lists.linux-
> foundation.org; Bhushan Bharat-R65777; Wood Scott-B07421; linuxppc-
> dev@lists.ozlabs.org
> Subject: Re: [PATCH 1/3] iommu/fsl: Factor out PCI specific code.
>=20
> On Sun, Oct 13, 2013 at 02:02:32AM +0530, Varun Sethi wrote:
> > Factor out PCI specific code in the PAMU driver.
> >
> > Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> > ---
> >  drivers/iommu/fsl_pamu_domain.c |   81 +++++++++++++++++++------------
> --------
> >  1 file changed, 40 insertions(+), 41 deletions(-)
> >
> > diff --git a/drivers/iommu/fsl_pamu_domain.c
> > b/drivers/iommu/fsl_pamu_domain.c index c857c30..e02e1de 100644
> > --- a/drivers/iommu/fsl_pamu_domain.c
> > +++ b/drivers/iommu/fsl_pamu_domain.c
> > @@ -677,13 +677,9 @@ static int handle_attach_device(struct
> fsl_dma_domain *dma_domain,
> >  	return ret;
> >  }
> >
> > -static int fsl_pamu_attach_device(struct iommu_domain *domain,
> > -				  struct device *dev)
> > +static void check_for_pci_dma_device(struct device **dev)
>=20
> "check_for_pci_dma_device()" doesn't give a good clue about what the
> function returns.  And why return something via a reference parameter
> when you could return it directly?
[Sethi Varun-B16395] I will rename the function to get_dma_device and make =
it return a pointer.
>=20
> >  {
> > -	struct fsl_dma_domain *dma_domain =3D domain->priv;
> > -	const u32 *liodn;
> > -	u32 liodn_cnt;
> > -	int len, ret =3D 0;
> > +#ifdef CONFIG_PCI
> >  	struct pci_dev *pdev =3D NULL;
> >  	struct pci_controller *pci_ctl;
>=20
> This is sort of a goofy looking function.  It would read much better as
> something like this:
>=20
[Sethi Varun-B16395] Will make the change.

>       struct device *dma_dev =3D dev;
>=20
>   #ifdef CONFIG_PCI
>       if (...) {
>           dma_dev =3D ...;
>       }
>   #endif
>=20
>       return dma_dev;
>=20
> Does this need to care about reference counting when you return a pointer
> to a different device?
>=20
[Sethi Varun-B16395] Reference counting isn't required, as we are just obta=
ining the LIODN value from the PCI controller.

-Varun
