Return-Path: <B35336@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 635F8B6FAC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2012 22:20:19 +1000 (EST)
From: Zhao Chenhui-B35336 <B35336@freescale.com>
To: "galak@kernel.crashing.org" <galak@kernel.crashing.org>
Subject: RE: [linuxppc-release] [PATCH v5 1/5] powerpc/85xx: implement
 hardware	timebase sync
Date: Tue, 29 May 2012 12:20:07 +0000
Message-ID: <7AA2FF042C086D469F577FA6723434DA057B61@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1336737235-15370-1-git-send-email-chenhui.zhao@freescale.com> 
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Kumar,

There is no comment for these patches so far. Do you think these patches ca=
n be merged?
We really want these patches to be merged in this merge window.

Thanks.

Best Regards,
Chenhui


> -----Original Message-----
> From: Zhao Chenhui-B35336
> Sent: Friday, May 25, 2012 3:09 PM
> To: Wood Scott-B07421; galak@kernel.crashing.org
> Cc: Li Yang-R58472
> Subject: RE: [linuxppc-release] [PATCH v5 1/5] powerpc/85xx: implement ha=
rdware timebase sync
>=20
> Hi Scott and Kumar,
>=20
> Do you have comments for these patches?
>=20
> http://patchwork.ozlabs.org/patch/158484/
> http://patchwork.ozlabs.org/patch/158485/
> http://patchwork.ozlabs.org/patch/158487/
> http://patchwork.ozlabs.org/patch/158486/
> http://patchwork.ozlabs.org/patch/158488/
>=20
> Thanks.
>=20
> Best Regards,
> Chenhui
>=20
> > -----Original Message-----
> > From: linuxppc-release-bounces@linux.freescale.net [mailto:linuxppc-rel=
ease-
> > bounces@linux.freescale.net] On Behalf Of Zhao Chenhui-B35336
> > Sent: Friday, May 11, 2012 7:54 PM
> > To: linuxppc-dev@lists.ozlabs.org
> > Cc: Wood Scott-B07421; Li Yang-R58472; linux-kernel@vger.kernel.org; ga=
lak@kernel.crashing.org
> > Subject: [linuxppc-release] [PATCH v5 1/5] powerpc/85xx: implement hard=
ware timebase sync
> >
> > Do hardware timebase sync. Firstly, stop all timebases, and transfer
> > the timebase value of the boot core to the other core. Finally,
> > start all timebases.
> >
> > Only apply to dual-core chips, such as MPC8572, P2020, etc.
> >
> > Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > ---
> >  arch/powerpc/include/asm/fsl_guts.h |    2 +
> >  arch/powerpc/platforms/85xx/smp.c   |   93 +++++++++++++++++++++++++++=
++++++--
> >  2 files changed, 91 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/fsl_guts.h b/arch/powerpc/include=
/asm/fsl_guts.h
> > index aa4c488..dd5ba2c 100644
> > --- a/arch/powerpc/include/asm/fsl_guts.h
> > +++ b/arch/powerpc/include/asm/fsl_guts.h
> > @@ -48,6 +48,8 @@ struct ccsr_guts {
> >          __be32  dmuxcr;		/* 0x.0068 - DMA Mux Control Register */
> >          u8	res06c[0x70 - 0x6c];
> >  	__be32	devdisr;	/* 0x.0070 - Device Disable Control */
> > +#define CCSR_GUTS_DEVDISR_TB1	0x00001000
> > +#define CCSR_GUTS_DEVDISR_TB0	0x00004000
> >  	__be32	devdisr2;	/* 0x.0074 - Device Disable Control 2 */
> >  	u8	res078[0x7c - 0x78];
> >  	__be32  pmjcr;		/* 0x.007c - 4 Power Management Jog Control Register =
*/
> > diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms=
/85xx/smp.c
> > index ff42490..6862dda 100644
> > --- a/arch/powerpc/platforms/85xx/smp.c
> > +++ b/arch/powerpc/platforms/85xx/smp.c
> > @@ -24,6 +24,7 @@
> >  #include <asm/mpic.h>
> >  #include <asm/cacheflush.h>
> >  #include <asm/dbell.h>
> > +#include <asm/fsl_guts.h>
> >
> >  #include <sysdev/fsl_soc.h>
> >  #include <sysdev/mpic.h>
> > @@ -115,13 +116,70 @@ smp_85xx_kick_cpu(int nr)
> >
> >  struct smp_ops_t smp_85xx_ops =3D {
> >  	.kick_cpu =3D smp_85xx_kick_cpu,
> > -#ifdef CONFIG_KEXEC
> > -	.give_timebase	=3D smp_generic_give_timebase,
> > -	.take_timebase	=3D smp_generic_take_timebase,
> > -#endif
> >  };
> >
> >  #ifdef CONFIG_KEXEC
> > +static struct ccsr_guts __iomem *guts;
> > +static u64 timebase;
> > +static int tb_req;
> > +static int tb_valid;
> > +
> > +static void mpc85xx_timebase_freeze(int freeze)
> > +{
> > +	unsigned int mask;
> > +
> > +	if (!guts)
> > +		return;
> > +
> > +	mask =3D CCSR_GUTS_DEVDISR_TB0 | CCSR_GUTS_DEVDISR_TB1;
> > +	if (freeze)
> > +		setbits32(&guts->devdisr, mask);
> > +	else
> > +		clrbits32(&guts->devdisr, mask);
> > +
> > +	in_be32(&guts->devdisr);
> > +}
> > +
> > +static void mpc85xx_give_timebase(void)
> > +{
> > +	unsigned long flags;
> > +
> > +	local_irq_save(flags);
> > +
> > +	while (!tb_req)
> > +		barrier();
> > +	tb_req =3D 0;
> > +
> > +	mpc85xx_timebase_freeze(1);
> > +	timebase =3D get_tb();
> > +	mb();
> > +	tb_valid =3D 1;
> > +
> > +	while (tb_valid)
> > +		barrier();
> > +
> > +	mpc85xx_timebase_freeze(0);
> > +
> > +	local_irq_restore(flags);
> > +}
> > +
> > +static void mpc85xx_take_timebase(void)
> > +{
> > +	unsigned long flags;
> > +
> > +	local_irq_save(flags);
> > +
> > +	tb_req =3D 1;
> > +	while (!tb_valid)
> > +		barrier();
> > +
> > +	set_tb(timebase >> 32, timebase & 0xffffffff);
> > +	mb();
> > +	tb_valid =3D 0;
> > +
> > +	local_irq_restore(flags);
> > +}
> > +
> >  atomic_t kexec_down_cpus =3D ATOMIC_INIT(0);
> >
> >  void mpc85xx_smp_kexec_cpu_down(int crash_shutdown, int secondary)
> > @@ -228,6 +286,20 @@ smp_85xx_setup_cpu(int cpu_nr)
> >  		doorbell_setup_this_cpu();
> >  }
> >
> > +#ifdef CONFIG_KEXEC
> > +static const struct of_device_id guts_ids[] =3D {
> > +	{ .compatible =3D "fsl,mpc8572-guts", },
> > +	{ .compatible =3D "fsl,mpc8560-guts", },
> > +	{ .compatible =3D "fsl,mpc8536-guts", },
> > +	{ .compatible =3D "fsl,p1020-guts", },
> > +	{ .compatible =3D "fsl,p1021-guts", },
> > +	{ .compatible =3D "fsl,p1022-guts", },
> > +	{ .compatible =3D "fsl,p1023-guts", },
> > +	{ .compatible =3D "fsl,p2020-guts", },
> > +	{},
> > +};
> > +#endif
> > +
> >  void __init mpc85xx_smp_init(void)
> >  {
> >  	struct device_node *np;
> > @@ -249,6 +321,19 @@ void __init mpc85xx_smp_init(void)
> >  		smp_85xx_ops.cause_ipi =3D doorbell_cause_ipi;
> >  	}
> >
> > +#ifdef CONFIG_KEXEC
> > +	np =3D of_find_matching_node(NULL, guts_ids);
> > +	if (np) {
> > +		guts =3D of_iomap(np, 0);
> > +		smp_85xx_ops.give_timebase =3D mpc85xx_give_timebase;
> > +		smp_85xx_ops.take_timebase =3D mpc85xx_take_timebase;
> > +		of_node_put(np);
> > +	} else {
> > +		smp_85xx_ops.give_timebase =3D smp_generic_give_timebase;
> > +		smp_85xx_ops.take_timebase =3D smp_generic_take_timebase;
> > +	}
> > +#endif
> > +
> >  	smp_ops =3D &smp_85xx_ops;
> >
> >  #ifdef CONFIG_KEXEC
> > --
> > 1.6.4.1
> >
> > _______________________________________________
> > linuxppc-release mailing list
> > linuxppc-release@linux.freescale.net
> > http://linux.freescale.net/mailman/listinfo/linuxppc-release
