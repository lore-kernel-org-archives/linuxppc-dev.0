Return-Path: <zch@az84smr01.freescale.net>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3637C2C01E5
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jul 2012 20:09:44 +1000 (EST)
Received: from mail263-va3 (localhost [127.0.0.1])	by
 mail263-va3-R.bigfish.com (Postfix) with ESMTP id C403F3C01B2	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jul 2012 10:07:42 +0000 (UTC)
Received: from VA3EHSMHS012.bigfish.com (unknown [10.7.14.244])	by
 mail263-va3.bigfish.com (Postfix) with ESMTP id 25548640043	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jul 2012 10:07:40 +0000 (UTC)
Received: from localhost.localdomain ([10.213.130.145])	by
 az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id q62A9XVq020034	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Jul 2012 03:09:33 -0700
Date: Mon, 2 Jul 2012 18:10:48 +0800
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH v6 1/5] powerpc/85xx: implement hardware timebase sync
Message-ID: <20120702101048.GA22108@localhost.localdomain>
References: <1340706359-9455-1-git-send-email-chenhui.zhao@freescale.com>
 <CAOZdJXWiGOCtP1iJYR2S48XwR2Wpry8+VswctctdVfY9Z+QTiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <CAOZdJXWiGOCtP1iJYR2S48XwR2Wpry8+VswctctdVfY9Z+QTiQ@mail.gmail.com>
Sender: <zch@az84smr01.freescale.net>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Li Yang-R58472 <r58472@freescale.com>,
 Zhao Chenhui-B35336 <B35336@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 29, 2012 at 10:39:24AM -0500, Tabi Timur-B04825 wrote:
> On Tue, Jun 26, 2012 at 5:25 AM, Zhao Chenhui
> <chenhui.zhao@freescale.com> wrote:
> > Do hardware timebase sync. Firstly, stop all timebases, and transfer
> > the timebase value of the boot core to the other core. Finally,
> > start all timebases.
> >
> > Only apply to dual-core chips, such as MPC8572, P2020, etc.
> >
> > Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > ---
> > Changes for v6:
> > =A0* added 85xx_TB_SYNC
> > =A0* added isync() after set_tb()
> > =A0* removed extra entries from mpc85xx_smp_guts_ids
> >
> > =A0arch/powerpc/include/asm/fsl_guts.h | =A0 =A02 +
> > =A0arch/powerpc/platforms/85xx/Kconfig | =A0 =A05 ++
> > =A0arch/powerpc/platforms/85xx/smp.c =A0 | =A0 84 +++++++++++++++++++=
++++++++++++++++
> > =A03 files changed, 91 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platfor=
ms/85xx/smp.c
> > index ff42490..edb0cad 100644
> > --- a/arch/powerpc/platforms/85xx/smp.c
> > +++ b/arch/powerpc/platforms/85xx/smp.c
> > @@ -24,6 +24,7 @@
> > =A0#include <asm/mpic.h>
> > =A0#include <asm/cacheflush.h>
> > =A0#include <asm/dbell.h>
> > +#include <asm/fsl_guts.h>
> >
> > =A0#include <sysdev/fsl_soc.h>
> > =A0#include <sysdev/mpic.h>
> > @@ -42,6 +43,69 @@ extern void __early_start(void);
> > =A0#define NUM_BOOT_ENTRY =A0 =A0 =A0 =A0 8
> > =A0#define SIZE_BOOT_ENTRY =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(NUM_BOOT_E=
NTRY * sizeof(u32))
> >
> > +#ifdef CONFIG_85xx_TB_SYNC
> > +static struct ccsr_guts __iomem *guts;
> > +static u64 timebase;
> > +static int tb_req;
> > +static int tb_valid;
> > +
> > +static void mpc85xx_timebase_freeze(int freeze)
> > +{
> > + =A0 =A0 =A0 unsigned int mask;
>=20
> 'mask' should be uint32_t

OK.

>=20
> > +
> > + =A0 =A0 =A0 if (!guts)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>=20
> This function should never be called if guts is NULL, so this check
> should be unnecessary.

OK.

>=20
> > +
> > + =A0 =A0 =A0 mask =3D CCSR_GUTS_DEVDISR_TB0 | CCSR_GUTS_DEVDISR_TB1;
> > + =A0 =A0 =A0 if (freeze)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 setbits32(&guts->devdisr, mask);
> > + =A0 =A0 =A0 else
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clrbits32(&guts->devdisr, mask);
> > +
> > + =A0 =A0 =A0 in_be32(&guts->devdisr);
> > +}
> > +
> > @@ -249,6 +323,16 @@ void __init mpc85xx_smp_init(void)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0smp_85xx_ops.cause_ipi =3D doorbell_ca=
use_ipi;
> > =A0 =A0 =A0 =A0}
> >
> > + =A0 =A0 =A0 np =3D of_find_matching_node(NULL, mpc85xx_smp_guts_ids=
);
> > + =A0 =A0 =A0 if (np) {
> > +#ifdef CONFIG_85xx_TB_SYNC
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 guts =3D of_iomap(np, 0);
>=20
> You need to test the return value of of_iomap().  smp_85xx_ops should
> be set only if guts is not NULL.

Yes. Thanks.

>=20
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 smp_85xx_ops.give_timebase =3D mpc85xx_=
give_timebase;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 smp_85xx_ops.take_timebase =3D mpc85xx_=
take_timebase;
> > +#endif
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(np);
> > + =A0 =A0 =A0 }
> > +
> > =A0 =A0 =A0 =A0smp_ops =3D &smp_85xx_ops;
> >
> > =A0#ifdef CONFIG_KEXEC
> > --
> > 1.6.4.1
