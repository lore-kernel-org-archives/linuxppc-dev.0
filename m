Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5F2C22C0086
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2012 04:04:32 +1100 (EST)
Date: Mon, 3 Dec 2012 11:03:43 -0600
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/4 v5] iommu/fsl: Add iommu domain attributes required
 by fsl PAMU driver.
To: Sethi Varun-B16395 <B16395@freescale.com>
References: <1353419697-31269-1-git-send-email-Varun.Sethi@freescale.com>
 <1353419697-31269-4-git-send-email-Varun.Sethi@freescale.com>
 <20121202140323.GO30633@8bytes.org>
 <C5ECD7A89D1DC44195F34B25E172658D2B2A51@039-SN2MPN1-013.039d.mgd.msft.net>
In-Reply-To: <C5ECD7A89D1DC44195F34B25E172658D2B2A51@039-SN2MPN1-013.039d.mgd.msft.net>
 (from B16395@freescale.com on Mon Dec  3 10:57:29 2012)
Message-ID: <1354554223.2960.7@snotra>
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

On 12/03/2012 10:57:29 AM, Sethi Varun-B16395 wrote:
>=20
>=20
> > -----Original Message-----
> > From: iommu-bounces@lists.linux-foundation.org [mailto:iommu-
> > bounces@lists.linux-foundation.org] On Behalf Of Joerg Roedel
> > Sent: Sunday, December 02, 2012 7:33 PM
> > To: Sethi Varun-B16395
> > Cc: linux-kernel@vger.kernel.org; iommu@lists.linux-foundation.org; =20
> Wood
> > Scott-B07421; linuxppc-dev@lists.ozlabs.org; Tabi Timur-B04825
> > Subject: Re: [PATCH 3/4 v5] iommu/fsl: Add iommu domain attributes
> > required by fsl PAMU driver.
> >
> > Hmm, we need to work out a good abstraction for this.
> >
> > On Tue, Nov 20, 2012 at 07:24:56PM +0530, Varun Sethi wrote:
> > > Added the following domain attributes required by FSL PAMU driver:
> > > 1. Subwindows field added to the iommu domain geometry attribute.
> >
> > Are the Subwindows mapped with full size or do you map only parts =20
> of the
> > subwindows?
> >
> [Sethi Varun-B16395] It's possible to map a part of the subwindow =20
> i.e. size of the mapping can be less than the sub window size.
>=20
> > > +	 * This attribute indicates number of DMA subwindows supported =20
> by
> > > +	 * the geometry. If there is a single window that maps the =20
> entire
> > > +	 * geometry, attribute must be set to "1". A value of "0" =20
> implies
> > > +	 * that this mechanism is not used at all(normal paging is =20
> used).
> > > +	 * Value other than* "0" or "1" indicates the actual number of
> > > +	 * subwindows.
> > > +	 */
> >
> > This semantic is ugly, how about a feature detection mechanism?
> >
> [Sethi Varun-B16395] A feature mechanism to query the type of IOMMU?

A feature mechanism to determine whether this subwindow mechanism is =20
available, and what the limits are.

-Scott=
