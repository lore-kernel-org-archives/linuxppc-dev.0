Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9ABC72C00BF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2012 09:21:28 +1100 (EST)
Date: Mon, 5 Nov 2012 16:21:14 -0600
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/4 v4] iommu/fsl: Add iommu domain attributes required
 by fsl PAMU driver.
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <50983966.4080805@freescale.com> (from timur@freescale.com on
 Mon Nov  5 16:10:46 2012)
Message-ID: <1352154074.28279.9@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Varun Sethi <Varun.Sethi@freescale.com>, iommu@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 joerg.roedel@amd.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/05/2012 04:10:46 PM, Timur Tabi wrote:
> Varun Sethi wrote:
> > Added the following domain attributes required by FSL PAMU driver:
> > 1. Subwindows field added to the iommu domain geometry attribute.
> > 2. Added new iommu stash attribute, which allows setting of the
> >    LIODN specific stash id parameter through IOMMU API.
> > 3. Added an attribute for enabling/disabling DMA to a particular
> >    memory window.
> >
> >
> > Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> > ---
> > changes in v4:
> > - Updated comment explaining subwindows(as mentioned by Scott).
> > change in v3:
> > -renamed the stash attribute targets
> >  include/linux/iommu.h |   36 ++++++++++++++++++++++++++++++++++++
> >  1 files changed, 36 insertions(+), 0 deletions(-)
> >
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index f3b99e1..e72f5e5 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -44,6 +44,34 @@ struct iommu_domain_geometry {
> >  	dma_addr_t aperture_start; /* First address that can be =20
> mapped    */
> >  	dma_addr_t aperture_end;   /* Last address that can be =20
> mapped     */
> >  	bool force_aperture;       /* DMA only allowed in mappable =20
> range? */
> > +
> > +	/**
>=20
> /** is used by kerneldoc to indicate a kerneldoc-style comment.  =20
> Normal
> comments should start with just "/*".
>=20
> > +	 * There could be a single contiguous window tha maps the entire
> > +	 * geometry or it could be split in to multiple subwindows.
> > +	 * Subwindows allow for supporting physically discontiguous =20
> mappings.
> > +	 * This attribute indicates number of DMA subwindows supported =20
> by
> > +	 * the geometry. If there is a single window that maps the =20
> entire
> > +	 * geometry, attribute must be set to "1". A value of "0" =20
> implies
> > +	 * that there are 256 subwindows each of size 4K. Value other =20
> than
> > +	 * "0" or "1" indicates the actual number of subwindows.
> > +	 */
> > +	u32 subwindows;
>=20
> Why is this a sized integer?

The whole struct should be fixed size integers, if we're going to =20
eventually expose this via VFIO.

> > +/* cache stash targets */
> > +#define IOMMU_ATTR_CACHE_L1 1
> > +#define IOMMU_ATTR_CACHE_L2 2
> > +#define IOMMU_ATTR_CACHE_L3 3
>=20
> This seems kinda silly.  The value of the enum is in the enum name.

There might be less obvious members of this enum in the future -- this =20
is a generic API and should make as few assumptions about the hardware =20
as possible.

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
> >  };
> >
> >  struct iommu_domain {
> > @@ -60,6 +88,14 @@ struct iommu_domain {
> >  enum iommu_attr {
> >  	DOMAIN_ATTR_MAX,
> >  	DOMAIN_ATTR_GEOMETRY,
> > +	/* Set the IOMMU hardware stashing
> > +	 * parameters.
> > +	 */
> > +	DOMAIN_ATTR_STASH,
> > +	/* Explicity enable/disable DMA for a
> > +         * particular memory window.
> > +         */
> > +	DOMAIN_ATTR_ENABLE,

Whitespace and comment style.

-Scott=
