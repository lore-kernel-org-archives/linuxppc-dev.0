Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7EDE22C0320
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2012 12:00:58 +1100 (EST)
Date: Mon, 10 Dec 2012 19:00:44 -0600
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/4 v5] iommu/fsl: Add iommu domain attributes required
 by fsl PAMU driver.
To: Sethi Varun-B16395 <B16395@freescale.com>
References: <C5ECD7A89D1DC44195F34B25E172658D2B70EE@039-SN2MPN1-013.039d.mgd.msft.net>
 <1354645371.16710.15@snotra>
 <C5ECD7A89D1DC44195F34B25E172658D2C09A4@039-SN2MPN1-013.039d.mgd.msft.net>
In-Reply-To: <C5ECD7A89D1DC44195F34B25E172658D2C09A4@039-SN2MPN1-013.039d.mgd.msft.net>
 (from B16395@freescale.com on Mon Dec 10 04:10:06 2012)
Message-ID: <1355187644.5334.23@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>, Joerg Roedel <joro@8bytes.org>,
 Tabi Timur-B04825 <B04825@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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

On 12/10/2012 04:10:06 AM, Sethi Varun-B16395 wrote:
>=20
>=20
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Tuesday, December 04, 2012 11:53 PM
> > To: Sethi Varun-B16395
> > Cc: Wood Scott-B07421; Joerg Roedel; linux-kernel@vger.kernel.org;
> > iommu@lists.linux-foundation.org; linuxppc-dev@lists.ozlabs.org; =20
> Tabi
> > Timur-B04825
> > Subject: Re: [PATCH 3/4 v5] iommu/fsl: Add iommu domain attributes
> > required by fsl PAMU driver.
> >
> > On 12/04/2012 05:53:33 AM, Sethi Varun-B16395 wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Wood Scott-B07421
> > > > Sent: Monday, December 03, 2012 10:34 PM
> > > > To: Sethi Varun-B16395
> > > > Cc: Joerg Roedel; linux-kernel@vger.kernel.org; =20
> iommu@lists.linux-
> > > > foundation.org; Wood Scott-B07421; =20
> linuxppc-dev@lists.ozlabs.org;
> > > Tabi
> > > > Timur-B04825
> > > > Subject: Re: [PATCH 3/4 v5] iommu/fsl: Add iommu domain =20
> attributes
> > > > required by fsl PAMU driver.
> > > >
> > > > On 12/03/2012 10:57:29 AM, Sethi Varun-B16395 wrote:
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: iommu-bounces@lists.linux-foundation.org =20
> [mailto:iommu-
> > > > > > bounces@lists.linux-foundation.org] On Behalf Of Joerg =20
> Roedel
> > > > > > Sent: Sunday, December 02, 2012 7:33 PM
> > > > > > To: Sethi Varun-B16395
> > > > > > Cc: linux-kernel@vger.kernel.org;
> > > iommu@lists.linux-foundation.org;
> > > > > Wood
> > > > > > Scott-B07421; linuxppc-dev@lists.ozlabs.org; Tabi =20
> Timur-B04825
> > > > > > Subject: Re: [PATCH 3/4 v5] iommu/fsl: Add iommu domain
> > > attributes
> > > > > > required by fsl PAMU driver.
> > > > > >
> > > > > > Hmm, we need to work out a good abstraction for this.
> > > > > >
> > > > > > On Tue, Nov 20, 2012 at 07:24:56PM +0530, Varun Sethi wrote:
> > > > > > > Added the following domain attributes required by FSL PAMU
> > > driver:
> > > > > > > 1. Subwindows field added to the iommu domain geometry
> > > attribute.
> > > > > >
> > > > > > Are the Subwindows mapped with full size or do you map only
> > > parts
> > > > > of the
> > > > > > subwindows?
> > > > > >
> > > > > [Sethi Varun-B16395] It's possible to map a part of the =20
> subwindow
> > > i.e.
> > > > > size of the mapping can be less than the sub window size.
> > > > >
> > > > > > > +	 * This attribute indicates number of DMA subwindows
> > > > supported
> > > > > by
> > > > > > > +	 * the geometry. If there is a single window that maps
> > > the
> > > > > entire
> > > > > > > +	 * geometry, attribute must be set to "1". A value of
> > > "0"
> > > > > implies
> > > > > > > +	 * that this mechanism is not used at all(normal paging
> > > is
> > > > > used).
> > > > > > > +	 * Value other than* "0" or "1" indicates the actual
> > > number
> > > > of
> > > > > > > +	 * subwindows.
> > > > > > > +	 */
> > > > > >
> > > > > > This semantic is ugly, how about a feature detection =20
> mechanism?
> > > > > >
> > > > > [Sethi Varun-B16395] A feature mechanism to query the type of
> > > IOMMU?
> > > >
> > > > A feature mechanism to determine whether this subwindow =20
> mechanism is
> > > > available, and what the limits are.
> > > >
> > > So, we use the IOMMU capability interface to find out if IOMMU
> > > supports sub windows or not, right? But still number of sub =20
> windows
> > > would be specified as a part of the geometry and the valid value =20
> for
> > > sub windows would  0,1 or actual number of sub windows.
> >
> > How does a user of the interface find out what values are possible =20
> for
> > the "actual number of subwindows"?  How does a user of the =20
> interface find
> > out whether there are any limitations on specifying a value of zero =20
> (in
> > the case of PAMU, that would be a maximum 1 MiB naturally-aligned
> > aperture to support arbitrary 4KiB mappings)?
> How about if we say that the default value for subwindows is zero and =20
> this what you get when you read the geometry (iommu_get_attr) after =20
> initializing the domain? In that case the user would know that =20
> implication of setting subwindows to zero with respect to the =20
> aperture size.

So it would default to the maximum aperture size possible with no =20
subwindows?  That might be OK, though is there a way to reset the =20
domain later on to get back to that informational state?

How about finding out the maximum number of subwindows?

> Also, should we introduce an additional API like "iommu_check_attr", =20
> which the user can use to validate the attribute value. For example =20
> in case of geometry, the user can fill up the structure and pass it =20
> to the iommu driver in order to verify the aperture and subwindows =20
> field.

Doesn't the current API raise an error if you do something =20
unsupported?  In any case I don't think making a series of guesses and =20
seeing which ones are accepted is a good substitute for being able to =20
simply read out the relevant parameters.

-Scott=
