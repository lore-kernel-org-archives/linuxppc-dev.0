Return-Path: <B29983@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7B0202C03AB
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Mar 2013 13:57:11 +1100 (EST)
From: Tang Yuantian-B29983 <B29983@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH][V2] powerpc: remove the PPC_CLOCK dependency
Date: Fri, 8 Mar 2013 02:57:06 +0000
Message-ID: <D07C73A334FF604B95B3CBD2A545D07B0B0F85F8@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1362561364-16073-1-git-send-email-Yuantian.Tang@freescale.com>
 <BED928B9-2212-413F-8C96-BCDFCE57C76A@kernel.crashing.org>
In-Reply-To: <BED928B9-2212-413F-8C96-BCDFCE57C76A@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Subject: Re: [PATCH][V2] powerpc: remove the PPC_CLOCK dependency
>=20
>=20
> On Mar 6, 2013, at 3:16 AM, <Yuantian.Tang@freescale.com>
> <Yuantian.Tang@freescale.com> wrote:
>=20
> > From: Tang Yuantian <Yuantian.Tang@freescale.com>
> >
> > config FSL_SOC and CPM do not really depend on PPC_CLOCK. So remove it.
> > PPC_CLOCK also keeps powerpc archtecture from supporting COMMON_CLK.
> >
> > Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> > ---
> > v2: correct the title
> >
> > arch/powerpc/Kconfig           |    1 -
> > arch/powerpc/platforms/Kconfig |    1 -
> > 2 files changed, 0 insertions(+), 2 deletions(-)
>=20
> Does the Flexcan driver use this?
>=20

In SDK, Flexcan did select the PPC_CLOCK, in upstream, it didn't.
Whatever it selects PPC_CLOCK or not, it doesn't use it.

Added the patch author to this loop.

- Yuantian

> - k
>=20
> >
> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig index
> > 352f416..383485b 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -655,7 +655,6 @@ config SBUS
> > config FSL_SOC
> > 	bool
> > 	select HAVE_CAN_FLEXCAN if NET && CAN
> > -	select PPC_CLOCK
> >
> > config FSL_PCI
> >  	bool
> > diff --git a/arch/powerpc/platforms/Kconfig
> > b/arch/powerpc/platforms/Kconfig index e7a896a..aba81cd 100644
> > --- a/arch/powerpc/platforms/Kconfig
> > +++ b/arch/powerpc/platforms/Kconfig
> > @@ -343,7 +343,6 @@ config FSL_ULI1575
> >
> > config CPM
> > 	bool
> > -	select PPC_CLOCK
> >
> > config OF_RTC
> > 	bool
> > --
> > 1.7.0.4
> >
>=20
