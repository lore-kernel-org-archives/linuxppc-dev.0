Return-Path: <B16395@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 08A832C0148
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2013 16:12:25 +1100 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>, Timur Tabi <timur@tabi.org>
Subject: RE: [PATCH 5/5 v11] iommu/fsl: Freescale PAMU driver and iommu
 implementation.
Date: Wed, 3 Apr 2013 05:12:16 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D45040D@039-SN2MPN1-013.039d.mgd.msft.net>
References: <CAOZdJXWS50mpgMYu8o8K11yQFU6y-vNwxd9zPkqSd7euGt7XQg@mail.gmail.com>	(from
 timur@tabi.org on Tue Apr  2 20:35:54 2013) <1364953950.8690.4@snotra>
In-Reply-To: <1364953950.8690.4@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Joerg Roedel <joro@8bytes.org>, lkml <linux-kernel@vger.kernel.org>,
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
> Sent: Wednesday, April 03, 2013 7:23 AM
> To: Timur Tabi
> Cc: Joerg Roedel; Sethi Varun-B16395; lkml; Kumar Gala; Yoder Stuart-
> B08248; iommu@lists.linux-foundation.org; Benjamin Herrenschmidt;
> linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH 5/5 v11] iommu/fsl: Freescale PAMU driver and iommu
> implementation.
>=20
> On 04/02/2013 08:35:54 PM, Timur Tabi wrote:
> > On Tue, Apr 2, 2013 at 11:18 AM, Joerg Roedel <joro@8bytes.org> wrote:
> >
> > > > +     panic("\n");
> > >
> > > A kernel panic seems like an over-reaction to an access violation.
> >
> > We have no way to determining what code caused the violation, so we
> > can't just kill the process.  I agree it seems like overkill, but what
> > else should we do?  Does the IOMMU layer have a way for the IOMMU
> > driver to stop the device that caused the problem?
>=20
> At a minimum, log a message and continue.  Probably turn off the LIODN,
> at least if it continues to be noisy (otherwise we could get stuck in an
> interrupt storm as you note).  Possibly let the user know somehow,
> especially if it's a VFIO domain.
[Sethi Varun-B16395] Can definitely log the message and disable the LIODN (=
to avoid an interrupt storm), but
we definitely need a mechanism to inform vfio subsystem about the error. Al=
so, disabling LIODN may not be a viable
option with the new LIODN allocation scheme (where LIODN would be associate=
d with a domain).

>=20
> Don't take down the whole kernel.  It's not just overkill; it undermines
> VFIO's efforts to make it safe for users to control devices.
>=20
> > > Besides the device that caused the violation the system should still
> > > work, no?
> >
> > Not really.  The PAMU was designed to add IOMMU support to legacy
> > devices, which have no concept of an MMU.  If the PAMU detects an
> > access violation, there's no way for the device to recover, because it
> > has no idea that a violation has occurred.  It's going to keep on
> > writing to bad data.
>=20
> I think that's only the case for posted writes (or devices which fail to
> take a hint and stop even after they see an I/O error).
>=20
[Sethi Varun-B16395] Even in the case where the guest driver detects a fail=
ure, it may not be able to fix the problem without intervention from the VF=
IO subsystem.

-Varun
