Return-Path: <B16395@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DDC5F2C0077
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2013 23:04:33 +1100 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: RE: [PATCH 1/6 v8] iommu/fsl: Store iommu domain information
 pointer in archdata.
Date: Wed, 27 Feb 2013 12:04:20 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D3C26F6@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1361191939-21260-1-git-send-email-Varun.Sethi@freescale.com>
 <1361191939-21260-2-git-send-email-Varun.Sethi@freescale.com>
 <20130227113045.GH26252@8bytes.org>
In-Reply-To: <20130227113045.GH26252@8bytes.org>
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

Hi Kumar,Ben,
I am implementing the Freescale PAMU (IOMMU) driver using the Linux IOMMU A=
PI. In this particular patch, I have added a new field to dev_archdata stru=
cture to store the dma domain information.
This field is updated whenever we attach a device to an iommu domain.

Regards
Varun

> -----Original Message-----
> From: Joerg Roedel [mailto:joro@8bytes.org]
> Sent: Wednesday, February 27, 2013 5:01 PM
> To: Sethi Varun-B16395
> Cc: iommu@lists.linux-foundation.org; linuxppc-dev@lists.ozlabs.org;
> linux-kernel@vger.kernel.org; Wood Scott-B07421; Yoder Stuart-B08248
> Subject: Re: [PATCH 1/6 v8] iommu/fsl: Store iommu domain information
> pointer in archdata.
>=20
> On Mon, Feb 18, 2013 at 06:22:14PM +0530, Varun Sethi wrote:
> > Add a new field in the device (powerpc) archdata structure for storing
> > iommu domain information pointer. This pointer is stored when the
> > device is attached to a particular domain.
> >
> >
> > Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> > ---
> > - no change.
> >  arch/powerpc/include/asm/device.h |    4 ++++
> >  1 files changed, 4 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/device.h
> > b/arch/powerpc/include/asm/device.h
> > index 77e97dd..6dc79fe 100644
> > --- a/arch/powerpc/include/asm/device.h
> > +++ b/arch/powerpc/include/asm/device.h
> > @@ -28,6 +28,10 @@ struct dev_archdata {
> >  		void		*iommu_table_base;
> >  	} dma_data;
> >
> > +	/* IOMMU domain information pointer. This would be set
> > +	 * when this device is attached to an iommu_domain.
> > +	 */
> > +	void			*iommu_domain;
>=20
> Please Cc the PowerPC Maintainers on this, so that they can have a look
> at it. This also must be put this into an #ifdef CONFIG_IOMMU_API.
>=20
>=20
> 	Joerg
>=20
>=20
