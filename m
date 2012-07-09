Return-Path: <B16395@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0D2FE2C0201
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 00:41:27 +1000 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH 2/3 v2] powerpc/mpic: Use the MPIC_LARGE_VECTORS flag
 for FSL MPIC.
Date: Mon, 9 Jul 2012 14:41:18 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D139409@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1341823595-15696-1-git-send-email-Varun.Sethi@freescale.com>
 <179D14E1-CF74-4502-80B7-FC44A28175D2@kernel.crashing.org>
In-Reply-To: <179D14E1-CF74-4502-80B7-FC44A28175D2@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Monday, July 09, 2012 7:58 PM
> To: Sethi Varun-B16395
> Cc: linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH 2/3 v2] powerpc/mpic: Use the MPIC_LARGE_VECTORS flag
> for FSL MPIC.
>=20
>=20
> On Jul 9, 2012, at 3:46 AM, Varun Sethi wrote:
>=20
> > We should use the MPIC_LARG_VECTORS flag while intializing the MPIC.
> > This prevents us from eating in to hardware vector number space (MSIs)
> > while setting up internal sources.
> >
> > Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> > ---
> > arch/powerpc/sysdev/mpic.c |    2 +-
> > 1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> Can you remind me the issue here w/running into the MSIs?
Vector numbers for internal interrupt sources like timers/ipis are
taken from the hardware vector number space. Currently we specify=20
number of interrupt sources as 256 and extract 12 vectors from here
for internal interrupt sources. In process we end up eating vector numbers
meant for MSIs. With this patch we are basically expanding our vector
number space.

-Varun
