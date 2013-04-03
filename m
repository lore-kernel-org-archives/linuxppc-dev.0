Return-Path: <B08248@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E69142C00C4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2013 02:56:06 +1100 (EST)
From: Yoder Stuart-B08248 <B08248@freescale.com>
To: Sethi Varun-B16395 <B16395@freescale.com>, Wood Scott-B07421
 <B07421@freescale.com>, Timur Tabi <timur@tabi.org>
Subject: RE: [PATCH 5/5 v11] iommu/fsl: Freescale PAMU driver and iommu
 implementation.
Date: Wed, 3 Apr 2013 15:55:36 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E15035A1B2E@039-SN1MPN1-003.039d.mgd.msft.net>
References: <CAOZdJXWS50mpgMYu8o8K11yQFU6y-vNwxd9zPkqSd7euGt7XQg@mail.gmail.com>	(from
 timur@tabi.org on Tue Apr  2 20:35:54 2013) <1364953950.8690.4@snotra>
 <C5ECD7A89D1DC44195F34B25E172658D45040D@039-SN2MPN1-013.039d.mgd.msft.net>
In-Reply-To: <C5ECD7A89D1DC44195F34B25E172658D45040D@039-SN2MPN1-013.039d.mgd.msft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Joerg Roedel <joro@8bytes.org>, lkml <linux-kernel@vger.kernel.org>,
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
> From: Sethi Varun-B16395
> Sent: Wednesday, April 03, 2013 12:12 AM
> To: Wood Scott-B07421; Timur Tabi
> Cc: Joerg Roedel; lkml; Kumar Gala; Yoder Stuart-B08248; iommu@lists.linu=
x-foundation.org; Benjamin
> Herrenschmidt; linuxppc-dev@lists.ozlabs.org
> Subject: RE: [PATCH 5/5 v11] iommu/fsl: Freescale PAMU driver and iommu i=
mplementation.
>=20
>=20
>=20
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Wednesday, April 03, 2013 7:23 AM
> > To: Timur Tabi
> > Cc: Joerg Roedel; Sethi Varun-B16395; lkml; Kumar Gala; Yoder Stuart-
> > B08248; iommu@lists.linux-foundation.org; Benjamin Herrenschmidt;
> > linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [PATCH 5/5 v11] iommu/fsl: Freescale PAMU driver and iommu
> > implementation.
> >
> > On 04/02/2013 08:35:54 PM, Timur Tabi wrote:
> > > On Tue, Apr 2, 2013 at 11:18 AM, Joerg Roedel <joro@8bytes.org> wrote=
:
> > >
> > > > > +     panic("\n");
> > > >
> > > > A kernel panic seems like an over-reaction to an access violation.
> > >
> > > We have no way to determining what code caused the violation, so we
> > > can't just kill the process.  I agree it seems like overkill, but wha=
t
> > > else should we do?  Does the IOMMU layer have a way for the IOMMU
> > > driver to stop the device that caused the problem?
> >
> > At a minimum, log a message and continue.  Probably turn off the LIODN,
> > at least if it continues to be noisy (otherwise we could get stuck in a=
n
> > interrupt storm as you note).  Possibly let the user know somehow,
> > especially if it's a VFIO domain.
> [Sethi Varun-B16395] Can definitely log the message and disable the LIODN=
 (to avoid an interrupt storm),
> but
> we definitely need a mechanism to inform vfio subsystem about the error. =
Also, disabling LIODN may not
> be a viable
> option with the new LIODN allocation scheme (where LIODN would be associa=
ted with a domain).

I think for phase 1 of this, just log the error, shut down DMA as you descr=
ibed.
We can implement more full featured error management, like notifying vfio
or the VM somehow in the future.

Stuart
