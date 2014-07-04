Return-Path: <Varun.Sethi@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0182.outbound.protection.outlook.com [207.46.163.182])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 426401A000B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jul 2014 22:50:35 +1000 (EST)
From: Varun Sethi <Varun.Sethi@freescale.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH 2/3] iommu/fsl: Fix the device domain attach condition.
Date: Fri, 4 Jul 2014 12:50:28 +0000
Message-ID: <23ace98ce7e145b0909a1f5f5d1fd2dd@BL2PR03MB468.namprd03.prod.outlook.com>
References: <1403618237-26248-1-git-send-email-Varun.Sethi@freescale.com>
 <1403618237-26248-3-git-send-email-Varun.Sethi@freescale.com>
 <20140704105430.GE13434@8bytes.org>
In-Reply-To: <20140704105430.GE13434@8bytes.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Joerg Roedel [mailto:joro@8bytes.org]
> Sent: Friday, July 04, 2014 4:25 PM
> To: Sethi Varun-B16395
> Cc: iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> linuxppc-dev@lists.ozlabs.org; alex.williamson@redhat.com
> Subject: Re: [PATCH 2/3] iommu/fsl: Fix the device domain attach
> condition.
>=20
> Hmm,
>=20
> On Tue, Jun 24, 2014 at 07:27:16PM +0530, Varun Sethi wrote:
> > -	old_domain_info =3D find_domain(dev);
> > +	old_domain_info =3D dev->archdata.iommu_domain;
> >  	if (old_domain_info && old_domain_info->domain !=3D dma_domain) {
> >  		spin_unlock_irqrestore(&device_domain_lock, flags);
> >  		detach_device(dev, old_domain_info->domain);
>=20
> Wouldn't this set dev->archdata.iommu_domain to NULL anyway, so that ...
>=20
Not for the case where device has multiple LIODNs.

> > @@ -399,7 +394,7 @@ static void attach_device(struct fsl_dma_domain
> *dma_domain, int liodn, struct d
> >  	 * the info for the first LIODN as all
> >  	 * LIODNs share the same domain
> >  	 */
> > -	if (!old_domain_info)
> > +	if (!dev->archdata.iommu_domain)
> >  		dev->archdata.iommu_domain =3D info;
>=20
> We already know that it _must_ be NULL here?
>=20

That won't be true for devices having multiple LIODNs

> >  	spin_unlock_irqrestore(&device_domain_lock, flags);
>=20
> This would shrink down the patch to:
>=20
> diff --git a/drivers/iommu/fsl_pamu_domain.c
> b/drivers/iommu/fsl_pamu_domain.c index 93072ba..d21b554 100644
> --- a/drivers/iommu/fsl_pamu_domain.c
> +++ b/drivers/iommu/fsl_pamu_domain.c
> @@ -399,8 +399,7 @@ static void attach_device(struct fsl_dma_domain
> *dma_domain, int liodn, struct d
>  	 * the info for the first LIODN as all
>  	 * LIODNs share the same domain
>  	 */
> -	if (!old_domain_info)
> -		dev->archdata.iommu_domain =3D info;
> +	dev->archdata.iommu_domain =3D info;

For devices having multiple LIODNs, we don't want to overwrite the info.

-Varun
