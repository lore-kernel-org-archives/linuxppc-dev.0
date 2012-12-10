Return-Path: <B16395@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7435D2C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2012 21:10:16 +1100 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH 3/4 v5] iommu/fsl: Add iommu domain attributes required
 by fsl PAMU driver.
Date: Mon, 10 Dec 2012 10:10:06 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D2C09A4@039-SN2MPN1-013.039d.mgd.msft.net>
References: <C5ECD7A89D1DC44195F34B25E172658D2B70EE@039-SN2MPN1-013.039d.mgd.msft.net>
 (from B16395@freescale.com on Tue Dec  4 05:53:33 2012)
 <1354645371.16710.15@snotra>
In-Reply-To: <1354645371.16710.15@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Tabi Timur-B04825 <B04825@freescale.com>, Joerg Roedel <joro@8bytes.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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
> Sent: Tuesday, December 04, 2012 11:53 PM
> To: Sethi Varun-B16395
> Cc: Wood Scott-B07421; Joerg Roedel; linux-kernel@vger.kernel.org;
> iommu@lists.linux-foundation.org; linuxppc-dev@lists.ozlabs.org; Tabi
> Timur-B04825
> Subject: Re: [PATCH 3/4 v5] iommu/fsl: Add iommu domain attributes
> required by fsl PAMU driver.
>=20
> On 12/04/2012 05:53:33 AM, Sethi Varun-B16395 wrote:
> >
> >
> > > -----Original Message-----
> > > From: Wood Scott-B07421
> > > Sent: Monday, December 03, 2012 10:34 PM
> > > To: Sethi Varun-B16395
> > > Cc: Joerg Roedel; linux-kernel@vger.kernel.org; iommu@lists.linux-
> > > foundation.org; Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org;
> > Tabi
> > > Timur-B04825
> > > Subject: Re: [PATCH 3/4 v5] iommu/fsl: Add iommu domain attributes
> > > required by fsl PAMU driver.
> > >
> > > On 12/03/2012 10:57:29 AM, Sethi Varun-B16395 wrote:
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: iommu-bounces@lists.linux-foundation.org [mailto:iommu-
> > > > > bounces@lists.linux-foundation.org] On Behalf Of Joerg Roedel
> > > > > Sent: Sunday, December 02, 2012 7:33 PM
> > > > > To: Sethi Varun-B16395
> > > > > Cc: linux-kernel@vger.kernel.org;
> > iommu@lists.linux-foundation.org;
> > > > Wood
> > > > > Scott-B07421; linuxppc-dev@lists.ozlabs.org; Tabi Timur-B04825
> > > > > Subject: Re: [PATCH 3/4 v5] iommu/fsl: Add iommu domain
> > attributes
> > > > > required by fsl PAMU driver.
> > > > >
> > > > > Hmm, we need to work out a good abstraction for this.
> > > > >
> > > > > On Tue, Nov 20, 2012 at 07:24:56PM +0530, Varun Sethi wrote:
> > > > > > Added the following domain attributes required by FSL PAMU
> > driver:
> > > > > > 1. Subwindows field added to the iommu domain geometry
> > attribute.
> > > > >
> > > > > Are the Subwindows mapped with full size or do you map only
> > parts
> > > > of the
> > > > > subwindows?
> > > > >
> > > > [Sethi Varun-B16395] It's possible to map a part of the subwindow
> > i.e.
> > > > size of the mapping can be less than the sub window size.
> > > >
> > > > > > +	 * This attribute indicates number of DMA subwindows
> > > supported
> > > > by
> > > > > > +	 * the geometry. If there is a single window that maps
> > the
> > > > entire
> > > > > > +	 * geometry, attribute must be set to "1". A value of
> > "0"
> > > > implies
> > > > > > +	 * that this mechanism is not used at all(normal paging
> > is
> > > > used).
> > > > > > +	 * Value other than* "0" or "1" indicates the actual
> > number
> > > of
> > > > > > +	 * subwindows.
> > > > > > +	 */
> > > > >
> > > > > This semantic is ugly, how about a feature detection mechanism?
> > > > >
> > > > [Sethi Varun-B16395] A feature mechanism to query the type of
> > IOMMU?
> > >
> > > A feature mechanism to determine whether this subwindow mechanism is
> > > available, and what the limits are.
> > >
> > So, we use the IOMMU capability interface to find out if IOMMU
> > supports sub windows or not, right? But still number of sub windows
> > would be specified as a part of the geometry and the valid value for
> > sub windows would  0,1 or actual number of sub windows.
>=20
> How does a user of the interface find out what values are possible for
> the "actual number of subwindows"?  How does a user of the interface find
> out whether there are any limitations on specifying a value of zero (in
> the case of PAMU, that would be a maximum 1 MiB naturally-aligned
> aperture to support arbitrary 4KiB mappings)?
How about if we say that the default value for subwindows is zero and this =
what you get when you read the geometry (iommu_get_attr) after initializing=
 the domain? In that case the user would know that implication of setting s=
ubwindows to zero with respect to the aperture size. Also, should we introd=
uce an additional API like "iommu_check_attr", which the user can use to va=
lidate the attribute value. For example in case of geometry, the user can f=
ill up the structure and pass it to the iommu driver in order to verify the=
 aperture and subwindows field.

-Varun
