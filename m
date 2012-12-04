Return-Path: <B07421@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe002.messaging.microsoft.com [213.199.154.140])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4146A2C008A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Dec 2012 05:23:08 +1100 (EST)
Date: Tue, 4 Dec 2012 12:22:51 -0600
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/4 v5] iommu/fsl: Add iommu domain attributes required
 by fsl PAMU driver.
To: Sethi Varun-B16395 <B16395@freescale.com>
In-Reply-To: <C5ECD7A89D1DC44195F34B25E172658D2B70EE@039-SN2MPN1-013.039d.mgd.msft.net>
 (from B16395@freescale.com on Tue Dec  4 05:53:33 2012)
Message-ID: <1354645371.16710.15@snotra>
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

On 12/04/2012 05:53:33 AM, Sethi Varun-B16395 wrote:
>=20
>=20
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Monday, December 03, 2012 10:34 PM
> > To: Sethi Varun-B16395
> > Cc: Joerg Roedel; linux-kernel@vger.kernel.org; iommu@lists.linux-
> > foundation.org; Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org; =20
> Tabi
> > Timur-B04825
> > Subject: Re: [PATCH 3/4 v5] iommu/fsl: Add iommu domain attributes
> > required by fsl PAMU driver.
> >
> > On 12/03/2012 10:57:29 AM, Sethi Varun-B16395 wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: iommu-bounces@lists.linux-foundation.org [mailto:iommu-
> > > > bounces@lists.linux-foundation.org] On Behalf Of Joerg Roedel
> > > > Sent: Sunday, December 02, 2012 7:33 PM
> > > > To: Sethi Varun-B16395
> > > > Cc: linux-kernel@vger.kernel.org; =20
> iommu@lists.linux-foundation.org;
> > > Wood
> > > > Scott-B07421; linuxppc-dev@lists.ozlabs.org; Tabi Timur-B04825
> > > > Subject: Re: [PATCH 3/4 v5] iommu/fsl: Add iommu domain =20
> attributes
> > > > required by fsl PAMU driver.
> > > >
> > > > Hmm, we need to work out a good abstraction for this.
> > > >
> > > > On Tue, Nov 20, 2012 at 07:24:56PM +0530, Varun Sethi wrote:
> > > > > Added the following domain attributes required by FSL PAMU =20
> driver:
> > > > > 1. Subwindows field added to the iommu domain geometry =20
> attribute.
> > > >
> > > > Are the Subwindows mapped with full size or do you map only =20
> parts
> > > of the
> > > > subwindows?
> > > >
> > > [Sethi Varun-B16395] It's possible to map a part of the subwindow =20
> i.e.
> > > size of the mapping can be less than the sub window size.
> > >
> > > > > +	 * This attribute indicates number of DMA subwindows
> > supported
> > > by
> > > > > +	 * the geometry. If there is a single window that maps =20
> the
> > > entire
> > > > > +	 * geometry, attribute must be set to "1". A value of =20
> "0"
> > > implies
> > > > > +	 * that this mechanism is not used at all(normal paging =20
> is
> > > used).
> > > > > +	 * Value other than* "0" or "1" indicates the actual =20
> number
> > of
> > > > > +	 * subwindows.
> > > > > +	 */
> > > >
> > > > This semantic is ugly, how about a feature detection mechanism?
> > > >
> > > [Sethi Varun-B16395] A feature mechanism to query the type of =20
> IOMMU?
> >
> > A feature mechanism to determine whether this subwindow mechanism is
> > available, and what the limits are.
> >
> So, we use the IOMMU capability interface to find out if IOMMU =20
> supports sub windows or not, right? But still number of sub windows =20
> would be specified as a part of the geometry and the valid value for =20
> sub windows would  0,1 or actual number of sub windows.

How does a user of the interface find out what values are possible for =20
the "actual number of subwindows"?  How does a user of the interface =20
find out whether there are any limitations on specifying a value of =20
zero (in the case of PAMU, that would be a maximum 1 MiB =20
naturally-aligned aperture to support arbitrary 4KiB mappings)?

-Scott=
