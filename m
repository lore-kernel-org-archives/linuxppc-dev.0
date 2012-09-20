Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 325962C0092
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2012 10:12:35 +1000 (EST)
Date: Wed, 19 Sep 2012 19:12:16 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC][PATCH 2/3] iommu/fsl: Add iommu domain attributes
 required by fsl PAMU driver.
To: Kumar Gala <galak@kernel.crashing.org>
References: <1348060632-12997-1-git-send-email-b16395@freescale.com>
 <1348060632-12997-3-git-send-email-b16395@freescale.com>
 <6B8A3365-C97E-4742-A0DD-D8FD6BA358EB@kernel.crashing.org>
In-Reply-To: <6B8A3365-C97E-4742-A0DD-D8FD6BA358EB@kernel.crashing.org>
 (from galak@kernel.crashing.org on Wed Sep 19 08:52:27 2012)
Message-ID: <1348099936.22800.21@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: joerg.roedel@amd.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org,
 "<b16395@freescale.com>" <b16395@freescale.com>,
 Varun Sethi <Varun.Sethi@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/19/2012 08:52:27 AM, Kumar Gala wrote:
>=20
> On Sep 19, 2012, at 8:17 AM, <b16395@freescale.com> =20
> <b16395@freescale.com> wrote:
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
> > include/linux/iommu.h |   30 ++++++++++++++++++++++++++++++
> > 1 files changed, 30 insertions(+), 0 deletions(-)
> >
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 7e83370..eaa40c6 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -44,6 +44,28 @@ struct iommu_domain_geometry {
> > 	dma_addr_t aperture_start; /* First address that can be =20
> mapped    */
> > 	dma_addr_t aperture_end;   /* Last address that can be =20
> mapped     */
> > 	bool force_aperture;       /* DMA only allowed in mappable =20
> range? */
> > +
> > +	/* The subwindows field indicates number of DMA subwindows =20
> supported
> > +	 * by the geometry. Following is the interpretation of
> > +	 * values for this field:
> > +	 * 0 : This implies that the supported geometry size is 1 MB
> > +         * with each subwindow size being 4KB. Thus number of =20
> subwindows
> > +	 * being =3D 1MB/4KB =3D 256.
> > +	 * 1 : Only one DMA window i.e. no subwindows.
> > +	 * value other than 0 or 1 would indicate actual number of =20
> subwindows.
> > +	 */
> > +	u32 subwindows;
> > +};
> > +
> > +/* This attribute corresponds to IOMMUs capable of generating
> > + * a stash transaction. A stash transaction is typically a
> > + * hardware initiated prefetch of data from memory to cache.
> > + * This attribute allows configuring stashig specific parameters
> > + * in the IOMMU hardware.
> > + */
> > +struct iommu_stash_attribute {
> > +	u32 	cpu;	/* cpu number */
> > +	u32 	cache;	/* cache to stash to: L1,L2,L3 */
>=20
> seems like this should be enum instead of u32 for cache
>=20
> With enum being something like:
>=20
> enum iommu_attr_stash_cache {
> 	IOMMU_ATTR_CACHE_L1,
> 	IOMMU_ATTR_CACHE_L2,
> 	IOMMU_ATTR_CACHE_L3,
> };

Don't we want these structs to be usable via some VFIO ioctl?  In that =20
case they need to use fixed size types.

-Scott=
