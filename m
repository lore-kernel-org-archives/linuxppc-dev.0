Return-Path: <qiang.zhao@nxp.com>
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr50088.outbound.protection.outlook.com [40.107.5.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRwPB3kN6zDqvG
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 12:35:58 +1000 (AEST)
From: Qiang Zhao <qiang.zhao@nxp.com>
To: Michael Ellerman <mpe@ellerman.id.au>, "tglx@linutronix.de"
 <tglx@linutronix.de>
CC: "oss@buserror.net" <oss@buserror.net>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, Xiaobo Xie <xiaobo.xie@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v10 4/4] irqchip/qeic: remove PPCisms for QEIC
Date: Wed, 9 Aug 2017 02:35:51 +0000
Message-ID: <AM3PR04MB1185B031156ECC7FA92C6A9C918B0@AM3PR04MB1185.eurprd04.prod.outlook.com>
References: <1502075236-24078-1-git-send-email-qiang.zhao@nxp.com>
 <1502075236-24078-5-git-send-email-qiang.zhao@nxp.com>
 <87h8xjq2rw.fsf@concordia.ellerman.id.au>
 <AM3PR04MB1185747366C53DCC51A8A88F918A0@AM3PR04MB1185.eurprd04.prod.outlook.com>
 <878tiunznb.fsf@concordia.ellerman.id.au>
In-Reply-To: <878tiunznb.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue 8/8/2017 6:05 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:

> -----Original Message-----
> From: Michael Ellerman [mailto:mpe@ellerman.id.au]
> Sent: Tuesday, August 08, 2017 6:05 PM
> To: Qiang Zhao <qiang.zhao@nxp.com>; tglx@linutronix.de
> Cc: oss@buserror.net; linuxppc-dev@lists.ozlabs.org; Xiaobo Xie
> <xiaobo.xie@nxp.com>; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH v10 4/4] irqchip/qeic: remove PPCisms for QEIC
>=20
> Qiang Zhao <qiang.zhao@nxp.com> writes:
>=20
> > On Mon 8/7/2017 3:02 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> >
> >> -----Original Message-----
> >> From: Michael Ellerman [mailto:mpe@ellerman.id.au]
> >> Sent: Monday, August 07, 2017 3:02 PM
> >> To: Qiang Zhao <qiang.zhao@nxp.com>; tglx@linutronix.de
> >> Cc: oss@buserror.net; Qiang Zhao <qiang.zhao@nxp.com>; linuxppc-
> >> dev@lists.ozlabs.org; Xiaobo Xie <xiaobo.xie@nxp.com>; linux-
> >> kernel@vger.kernel.org
> >> Subject: Re: [PATCH v10 4/4] irqchip/qeic: remove PPCisms for QEIC
> >>
> >> Zhao Qiang <qiang.zhao@nxp.com> writes:
> >>
> >> > QEIC was supported on PowerPC, and dependent on PPC, Now it is
> >> > supported on other platforms, so remove PPCisms.
> >> >
> >> > Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> >> > ---
> >> >  arch/powerpc/platforms/83xx/km83xx.c          |   1 -
> >> >  arch/powerpc/platforms/83xx/misc.c            |   1 -
> >> >  arch/powerpc/platforms/83xx/mpc832x_mds.c     |   1 -
> >> >  arch/powerpc/platforms/83xx/mpc832x_rdb.c     |   1 -
> >> >  arch/powerpc/platforms/83xx/mpc836x_mds.c     |   1 -
> >> >  arch/powerpc/platforms/83xx/mpc836x_rdk.c     |   1 -
> >> >  arch/powerpc/platforms/85xx/corenet_generic.c |   1 -
> >> >  arch/powerpc/platforms/85xx/mpc85xx_mds.c     |   1 -
> >> >  arch/powerpc/platforms/85xx/mpc85xx_rdb.c     |   1 -
> >> >  arch/powerpc/platforms/85xx/twr_p102x.c       |   1 -
> >> >  drivers/irqchip/irq-qeic.c                    | 188 +++++++++++----=
-----------
> >> >  include/soc/fsl/qe/qe_ic.h                    | 132 ---------------=
---
> >> >  12 files changed, 80 insertions(+), 250 deletions(-)  delete mode
> >> > 100644 include/soc/fsl/qe/qe_ic.h
> >> >
> >> > diff --git a/arch/powerpc/platforms/83xx/km83xx.c
> >> > b/arch/powerpc/platforms/83xx/km83xx.c
> >> > index d8642a4..b1cef0a 100644
> >> > --- a/arch/powerpc/platforms/83xx/km83xx.c
> >> > +++ b/arch/powerpc/platforms/83xx/km83xx.c
> >> > @@ -38,7 +38,6 @@
> >> >  #include <sysdev/fsl_soc.h>
> >> >  #include <sysdev/fsl_pci.h>
> >> >  #include <soc/fsl/qe/qe.h>
> >> > -#include <soc/fsl/qe/qe_ic.h>
> >>
> >> You deleted that file in patch 2. So didn't you just break the build
> >> for the last two commits?
> >
> > Sorry, I am not sure what you said. Could you explain?
>=20
> Don't worry about it. I was confused by the fact that we have both:
>=20
>   drivers/soc/fsl/qe/qe_ic.h
>=20
> and:
>=20
>   include/soc/fsl/qe/qe_ic.h
>=20
> cheers

I think this is a issue left over by history.
In patch with commit id 7aa1aa6ecec2af19d9aa85430ce3e56119e21626, I just mo=
ve them out from arch/powerpc. =20
Maybe need to ask the original author why there are 2 qe_ic.h.

Best Regards
Qiang Zhao
