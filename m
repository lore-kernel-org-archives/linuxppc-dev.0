Return-Path: <B16395@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 686FF2C06FE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 14:45:46 +1000 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH 2/3 v13] iommu/fsl: Add additional iommu attributes
 required by the PAMU driver.
Date: Tue, 23 Apr 2013 04:45:39 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D4B3708@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1366608716-1704-2-git-send-email-Varun.Sethi@freescale.com>
 (from Varun.Sethi@freescale.com on Mon Apr 22 00:31:55 2013)
 <1366674609.10399.12@snotra>
In-Reply-To: <1366674609.10399.12@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "joro@8bytes.org" <joro@8bytes.org>,
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



> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Tuesday, April 23, 2013 5:20 AM
> To: Sethi Varun-B16395
> Cc: joro@8bytes.org; iommu@lists.linux-foundation.org; linuxppc-
> dev@lists.ozlabs.org; linux-kernel@vger.kernel.org;
> galak@kernel.crashing.org; benh@kernel.crashing.org; Yoder Stuart-B08248;
> Sethi Varun-B16395
> Subject: Re: [PATCH 2/3 v13] iommu/fsl: Add additional iommu attributes
> required by the PAMU driver.
>=20
> On 04/22/2013 12:31:55 AM, Varun Sethi wrote:
> > Added the following domain attributes for the FSL PAMU driver:
> > 1. Added new iommu stash attribute, which allows setting of the
> >    LIODN specific stash id parameter through IOMMU API.
> > 2. Added an attribute for enabling/disabling DMA to a particular
> >    memory window.
> > 3. Added domain attribute to check for PAMUV1 specific constraints.
> >
> > Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> > ---
> > v13 changes:
> > - created a new file include/linux/fsl_pamu_stash.h for stash
> > attributes.
> > v12 changes:
> > - Moved PAMU specifc stash ids and structures to PAMU header file.
> > - no change in v11.
> > - no change in v10.
> >  include/linux/fsl_pamu_stash.h |   39
> > +++++++++++++++++++++++++++++++++++++++
> >  include/linux/iommu.h          |   16 ++++++++++++++++
> >  2 files changed, 55 insertions(+), 0 deletions(-)  create mode 100644
> > include/linux/fsl_pamu_stash.h
> >
> > diff --git a/include/linux/fsl_pamu_stash.h
> > b/include/linux/fsl_pamu_stash.h new file mode 100644 index
> > 0000000..caa1b21
> > --- /dev/null
> > +++ b/include/linux/fsl_pamu_stash.h
> > @@ -0,0 +1,39 @@
> > +/*
> > + * This program is free software; you can redistribute it and/or
> > modify
> > + * it under the terms of the GNU General Public License, version 2,
> > as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, write to the Free Software
> > + * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA
> > 02110-1301, USA.
> > + *
> > + * Copyright (C) 2013 Freescale Semiconductor, Inc.
> > + *
> > + */
> > +
> > +#ifndef __FSL_PAMU_STASH_H
> > +#define __FSL_PAMU_STASH_H
> > +
> > +/* cache stash targets */
> > +enum pamu_stash_target {
> > +	PAMU_ATTR_CACHE_L1 =3D 1,
> > +	PAMU_ATTR_CACHE_L2,
> > +	PAMU_ATTR_CACHE_L3,
> > +};
> > +
> > +/*
> > + * This attribute allows configuring stashig specific parameters
> > + * in the PAMU hardware.
> > + */
> > +
> > +struct pamu_stash_attribute {
> > +	u32 	cpu;	/* cpu number */
> > +	u32 	cache;	/* cache to stash to: L1,L2,L3 */
> > +};
> > +
> > +#endif  /* __FSL_PAMU_STASH_H */
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h index
> > 2727810..c5dc2b9 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -57,10 +57,26 @@ struct iommu_domain {
> >  #define IOMMU_CAP_CACHE_COHERENCY	0x1
> >  #define IOMMU_CAP_INTR_REMAP		0x2	/* isolates device
> > intrs */
> >
> > +/*
> > + * Following constraints are specifc to PAMUV1:
>=20
> FSL_PAMUV1
>=20
> > + *  -aperture must be power of 2, and naturally aligned
> > + *  -number of windows must be power of 2, and address space size
> > + *   of each window is determined by aperture size / # of windows
> > + *  -the actual size of the mapped region of a window must be power
> > + *   of 2 starting with 4KB and physical address must be naturally
> > + *   aligned.
> > + * DOMAIN_ATTR_FSL_PAMUV1 corresponds to the above mentioned
> > contraints.
> > + * The caller can invoke iommu_domain_get_attr to check if the
> > underlying
> > + * iommu implementation supports these constraints.
> > + */
> > +
> >  enum iommu_attr {
> >  	DOMAIN_ATTR_GEOMETRY,
> >  	DOMAIN_ATTR_PAGING,
> >  	DOMAIN_ATTR_WINDOWS,
> > +	DOMAIN_ATTR_PAMU_STASH,
> > +	DOMAIN_ATTR_PAMU_ENABLE,
> > +	DOMAIN_ATTR_FSL_PAMUV1,
> >  	DOMAIN_ATTR_MAX,
>=20
> Please be consistent on whether "PAMU" gets an "FSL_" namespace prefix
> (I'd prefer that it does).
Submitted new version(v14) of the patch with updated attribute names.

-Varun
