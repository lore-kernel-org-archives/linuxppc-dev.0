Return-Path: <B16395@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9BD702C008E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2012 22:53:41 +1100 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH 3/4 v5] iommu/fsl: Add iommu domain attributes required
 by fsl PAMU driver.
Date: Tue, 4 Dec 2012 11:53:33 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D2B70EE@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1353419697-31269-1-git-send-email-Varun.Sethi@freescale.com>
 <1353419697-31269-4-git-send-email-Varun.Sethi@freescale.com>
 <20121202140323.GO30633@8bytes.org>
 <C5ECD7A89D1DC44195F34B25E172658D2B2A51@039-SN2MPN1-013.039d.mgd.msft.net>
 <1354554223.2960.7@snotra>
In-Reply-To: <1354554223.2960.7@snotra>
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
> Sent: Monday, December 03, 2012 10:34 PM
> To: Sethi Varun-B16395
> Cc: Joerg Roedel; linux-kernel@vger.kernel.org; iommu@lists.linux-
> foundation.org; Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org; Tabi
> Timur-B04825
> Subject: Re: [PATCH 3/4 v5] iommu/fsl: Add iommu domain attributes
> required by fsl PAMU driver.
>=20
> On 12/03/2012 10:57:29 AM, Sethi Varun-B16395 wrote:
> >
> >
> > > -----Original Message-----
> > > From: iommu-bounces@lists.linux-foundation.org [mailto:iommu-
> > > bounces@lists.linux-foundation.org] On Behalf Of Joerg Roedel
> > > Sent: Sunday, December 02, 2012 7:33 PM
> > > To: Sethi Varun-B16395
> > > Cc: linux-kernel@vger.kernel.org; iommu@lists.linux-foundation.org;
> > Wood
> > > Scott-B07421; linuxppc-dev@lists.ozlabs.org; Tabi Timur-B04825
> > > Subject: Re: [PATCH 3/4 v5] iommu/fsl: Add iommu domain attributes
> > > required by fsl PAMU driver.
> > >
> > > Hmm, we need to work out a good abstraction for this.
> > >
> > > On Tue, Nov 20, 2012 at 07:24:56PM +0530, Varun Sethi wrote:
> > > > Added the following domain attributes required by FSL PAMU driver:
> > > > 1. Subwindows field added to the iommu domain geometry attribute.
> > >
> > > Are the Subwindows mapped with full size or do you map only parts
> > of the
> > > subwindows?
> > >
> > [Sethi Varun-B16395] It's possible to map a part of the subwindow i.e.
> > size of the mapping can be less than the sub window size.
> >
> > > > +	 * This attribute indicates number of DMA subwindows
> supported
> > by
> > > > +	 * the geometry. If there is a single window that maps the
> > entire
> > > > +	 * geometry, attribute must be set to "1". A value of "0"
> > implies
> > > > +	 * that this mechanism is not used at all(normal paging is
> > used).
> > > > +	 * Value other than* "0" or "1" indicates the actual number
> of
> > > > +	 * subwindows.
> > > > +	 */
> > >
> > > This semantic is ugly, how about a feature detection mechanism?
> > >
> > [Sethi Varun-B16395] A feature mechanism to query the type of IOMMU?
>=20
> A feature mechanism to determine whether this subwindow mechanism is
> available, and what the limits are.
>=20
So, we use the IOMMU capability interface to find out if IOMMU supports sub=
 windows or not, right? But still number of sub windows would be specified =
as a part of the geometry and the valid value for sub windows would  0,1 or=
 actual number of sub windows.

-Varun
=20
