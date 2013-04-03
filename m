Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CAFC42C015C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2013 12:52:45 +1100 (EST)
Date: Tue, 2 Apr 2013 20:52:30 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 5/5 v11] iommu/fsl: Freescale PAMU driver and iommu
 implementation.
To: Timur Tabi <timur@tabi.org>
In-Reply-To: <CAOZdJXWS50mpgMYu8o8K11yQFU6y-vNwxd9zPkqSd7euGt7XQg@mail.gmail.com>
 (from timur@tabi.org on Tue Apr  2 20:35:54 2013)
Message-ID: <1364953950.8690.4@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Joerg Roedel <joro@8bytes.org>, stuart.yoder@freescale.com,
 lkml <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Varun Sethi <Varun.Sethi@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/02/2013 08:35:54 PM, Timur Tabi wrote:
> On Tue, Apr 2, 2013 at 11:18 AM, Joerg Roedel <joro@8bytes.org> wrote:
>=20
> > > +     panic("\n");
> >
> > A kernel panic seems like an over-reaction to an access violation.
>=20
> We have no way to determining what code caused the violation, so we
> can't just kill the process.  I agree it seems like overkill, but what
> else should we do?  Does the IOMMU layer have a way for the IOMMU
> driver to stop the device that caused the problem?

At a minimum, log a message and continue.  Probably turn off the LIODN, =20
at least if it continues to be noisy (otherwise we could get stuck in =20
an interrupt storm as you note).  Possibly let the user know somehow, =20
especially if it's a VFIO domain.

Don't take down the whole kernel.  It's not just overkill; it =20
undermines VFIO's efforts to make it safe for users to control devices.

> > Besides the device that caused the violation the system should still
> > work, no?
>=20
> Not really.  The PAMU was designed to add IOMMU support to legacy
> devices, which have no concept of an MMU.  If the PAMU detects an
> access violation, there's no way for the device to recover, because it
> has no idea that a violation has occurred.  It's going to keep on
> writing to bad data.

I think that's only the case for posted writes (or devices which fail =20
to take a hint and stop even after they see an I/O error).

-Scott=
