Return-Path: <B16395@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe003.messaging.microsoft.com [213.199.154.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 82DBE2C03AA
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2012 02:22:31 +1000 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH 2/3 v2] iommu/fsl: Add iommu domain attributes required
 by fsl PAMU driver.
Date: Thu, 4 Oct 2012 16:22:18 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D1EFC03@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1349351808-7156-1-git-send-email-b16395@freescale.com>
 <1349351808-7156-3-git-send-email-b16395@freescale.com>
 <43F13A8A-BF97-427C-8736-8F2E55B7A3D1@kernel.crashing.org>
In-Reply-To: <43F13A8A-BF97-427C-8736-8F2E55B7A3D1@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "joerg.roedel@amd.com" <joerg.roedel@amd.com>,
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
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Thursday, October 04, 2012 6:47 PM
> To: Sethi Varun-B16395
> Cc: joerg.roedel@amd.com; iommu@lists.linux-foundation.org; linuxppc-
> dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; Sethi Varun-B16395
> Subject: Re: [PATCH 2/3 v2] iommu/fsl: Add iommu domain attributes
> required by fsl PAMU driver.
>=20
>=20
> On Oct 4, 2012, at 6:56 AM, <b16395@freescale.com> <b16395@freescale.com>
> wrote:
>=20
> > From: Varun Sethi <Varun.Sethi@freescale.com>
> >
> > Added the following domain attributes required by FSL PAMU driver:
> > 1. Subwindows field added to the iommu domain geometry attribute.
> > 2. Added new iommu stash attribute, which allows setting of the
> >   LIODN specific stash id parameter through IOMMU API.
> > 3. Added an attribute for enabling/disabling DMA to a particular
> >   memory window.
> >
> > Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> > ---
> > include/linux/iommu.h |   35 +++++++++++++++++++++++++++++++++++
> > 1 files changed, 35 insertions(+), 0 deletions(-)
> >
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h index
> > f3b99e1..62e22f0 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -44,6 +44,33 @@ struct iommu_domain_geometry {
> > 	dma_addr_t aperture_start; /* First address that can be mapped
> */
> > 	dma_addr_t aperture_end;   /* Last address that can be mapped
> */
> > 	bool force_aperture;       /* DMA only allowed in mappable range?
> */
> > +
> > +	/* The subwindows field indicates number of DMA subwindows
> supported
> > +	 * by the geometry. Following is the interpretation of
> > +	 * values for this field:
> > +	 * 0 : This implies that the supported geometry size is 1 MB
> > +         * with each subwindow size being 4KB. Thus number of
> subwindows
> > +	 * being =3D 1MB/4KB =3D 256.
> > +	 * 1 : Only one DMA window i.e. no subwindows.
> > +	 * value other than 0 or 1 would indicate actual number of
> subwindows.
> > +	 */
> > +	u32 subwindows;
> > +};
> > +
> > +/* cache stash targets */
> > +#define L1_CACHE 1
> > +#define L2_CACHE 2
> > +#define L3_CACHE 3
>=20
> These names are way to generic for being exposed to user space
Will fix naming to IOMMU_ATTR_CACHE_L1 etc.

-Varun
