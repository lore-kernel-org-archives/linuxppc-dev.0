Return-Path: <qiang.zhao@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0081.outbound.protection.outlook.com [104.47.2.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkPCw1kwQzDqps
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 23:01:46 +1000 (AEST)
From: Qiang Zhao <qiang.zhao@nxp.com>
To: Jason Cooper <jason@lakedaemon.net>
CC: "oss@buserror.net" <oss@buserror.net>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Xiaobo Xie
 <xiaobo.xie@nxp.com>
Subject: RE: [PATCH 1/2] qe/ic: move qe_ic_init from platforms to irqchip
Date: Tue, 5 Jul 2016 07:27:21 +0000
Message-ID: <AM3PR04MB1185048AB3BBC592F105E8C391390@AM3PR04MB1185.eurprd04.prod.outlook.com>
References: <1467683219-29326-1-git-send-email-qiang.zhao@nxp.com>
 <20160705031836.GA3348@io.lakedaemon.net>
In-Reply-To: <20160705031836.GA3348@io.lakedaemon.net>
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

On 07/05/2016 11:19 AM, Jason Cooper <jason@lakedaemon.net> wrote:
> -----Original Message-----
> From: Jason Cooper [mailto:jason@lakedaemon.net]
> Sent: Tuesday, July 05, 2016 11:19 AM
> To: Qiang Zhao <qiang.zhao@nxp.com>
> Cc: oss@buserror.net; tglx@linutronix.de; marc.zyngier@arm.com; linuxppc-
> dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; Xiaobo Xie
> <xiaobo.xie@nxp.com>
> Subject: Re: [PATCH 1/2] qe/ic: move qe_ic_init from platforms to irqchip
>=20
> Hi Zhao Qiang,
>=20
> Please reword your subject line to conform to the standard in irqchip (si=
nce
> that's where the code is added).  Also, please adjust the subject line to=
 express
> *why* the change is being made.
>=20
> On Tue, Jul 05, 2016 at 09:46:58AM +0800, Zhao Qiang wrote:
> > The codes of qe_ic_init in platforms are redundant, move them to qe_ic
> > under irqchip
>=20
> This needs to be a lot more clear.  How is backwards compatibility preser=
ved?
> Why is lookup by type "qeic" dropped?  In short, please explain everythin=
g that
> looks funny so we don't have to guess.

Thank you for your review and feedback.

>=20
> > Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> > ---
> >  arch/powerpc/platforms/83xx/misc.c            | 15 ---------------
> >  arch/powerpc/platforms/85xx/corenet_generic.c |  9 ---------
> >  arch/powerpc/platforms/85xx/mpc85xx_mds.c     | 14 --------------
> >  arch/powerpc/platforms/85xx/mpc85xx_rdb.c     | 16 ----------------
> >  arch/powerpc/platforms/85xx/twr_p102x.c       | 14 --------------
> >  drivers/irqchip/qe_ic.c                       | 14 ++++++++++++++
> >  6 files changed, 14 insertions(+), 68 deletions(-)
> >
> > diff --git a/arch/powerpc/platforms/83xx/misc.c
> > b/arch/powerpc/platforms/83xx/misc.c
> > index 7e923ca..9431fc7 100644
> > --- a/arch/powerpc/platforms/83xx/misc.c
> > +++ b/arch/powerpc/platforms/83xx/misc.c
> > @@ -93,24 +93,9 @@ void __init mpc83xx_ipic_init_IRQ(void)  }
> >
> >  #ifdef CONFIG_QUICC_ENGINE
> > -void __init mpc83xx_qe_init_IRQ(void) -{
> > -	struct device_node *np;
> > -
> > -	np =3D of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
> > -	if (!np) {
> > -		np =3D of_find_node_by_type(NULL, "qeic");
> > -		if (!np)
> > -			return;
> > -	}
>=20
> This block isn't preserved in the irqchip driver.  Why not?

I grep qeic in arch/powerpc/boot/dts/*, doesn't find which board use qeic a=
s type.

>=20
> > -	qe_ic_init(np, 0, qe_ic_cascade_low_ipic, qe_ic_cascade_high_ipic);
> > -	of_node_put(np);
> > -}
> > -
> >  void __init mpc83xx_ipic_and_qe_init_IRQ(void)
> >  {
> >  	mpc83xx_ipic_init_IRQ();
> > -	mpc83xx_qe_init_IRQ();
> >  }
> >  #endif /* CONFIG_QUICC_ENGINE */
> >
> > diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c
> > b/arch/powerpc/platforms/85xx/corenet_generic.c
> > index a2b0bc8..526fc2b 100644
> > --- a/arch/powerpc/platforms/85xx/corenet_generic.c
> > +++ b/arch/powerpc/platforms/85xx/corenet_generic.c
> > @@ -41,8 +41,6 @@ void __init corenet_gen_pic_init(void)
> >  	unsigned int flags =3D MPIC_BIG_ENDIAN | MPIC_SINGLE_DEST_CPU |
> >  		MPIC_NO_RESET;
> >
> > -	struct device_node *np;
> > -
> >  	if (ppc_md.get_irq =3D=3D mpic_get_coreint_irq)
> >  		flags |=3D MPIC_ENABLE_COREINT;
> >
> > @@ -50,13 +48,6 @@ void __init corenet_gen_pic_init(void)
> >  	BUG_ON(mpic =3D=3D NULL);
> >
> >  	mpic_init(mpic);
> > -
> > -	np =3D of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
> > -	if (np) {
> > -		qe_ic_init(np, 0, qe_ic_cascade_low_mpic,
> > -				qe_ic_cascade_high_mpic);
> > -		of_node_put(np);
> > -	}
> >  }
> >
> >  /*
> > diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
> > b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
> > index f61cbe2..7ae4901 100644
> > --- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
> > +++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
> > @@ -279,20 +279,6 @@ static void __init mpc85xx_mds_qeic_init(void)
> >  		of_node_put(np);
> >  		return;
> >  	}
> > -
> > -	np =3D of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
> > -	if (!np) {
> > -		np =3D of_find_node_by_type(NULL, "qeic");
> > -		if (!np)
> > -			return;
> > -	}
> > -
> > -	if (machine_is(p1021_mds))
> > -		qe_ic_init(np, 0, qe_ic_cascade_low_mpic,
> > -				qe_ic_cascade_high_mpic);
> > -	else
> > -		qe_ic_init(np, 0, qe_ic_cascade_muxed_mpic, NULL);
>=20
> This block is also not preserved.  Nor explained in the commit log.  Is i=
t really ok
> to drop it?  If so, why?

on non-p1021_mds mpc85xx_mds boards(mpc8568 and mpc8569).
The qeic has the same interrupt number for low and high. So use qe_ic_casca=
de_muxed_mpic for this situation.

        qeic: interrupt-controller@80 {
                interrupt-controller;
                compatible =3D "fsl,qe-ic";
                #address-cells =3D <0>;
                #interrupt-cells =3D <1>;
                reg =3D <0x80 0x80>;
                interrupts =3D <46 2 0 0 46 2 0 0>; //high:30 low:30
                interrupt-parent =3D <&mpic>;
        };

In qe_ic_init, the code(as below) can handle this situation.
If " qe_ic->virq_high !=3D qe_ic->virq_low ", then set chaned handler for h=
igh handler.

        if (qe_ic->virq_high !=3D NO_IRQ &&
                        qe_ic->virq_high !=3D qe_ic->virq_low) {
                irq_set_handler_data(qe_ic->virq_high, qe_ic);
                irq_set_chained_handler(qe_ic->virq_high, high_handler);
        }=20

>=20
> > -	of_node_put(np);
> >  }
> >  #else
> >  static void __init mpc85xx_mds_qe_init(void) { } diff --git
> > a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> > b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> > index 3f4dad1..779f54f 100644
> > --- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> > +++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> > @@ -49,10 +49,6 @@ void __init mpc85xx_rdb_pic_init(void)
> >  	struct mpic *mpic;
> >  	unsigned long root =3D of_get_flat_dt_root();
> >
> > -#ifdef CONFIG_QUICC_ENGINE
> > -	struct device_node *np;
> > -#endif
> > -
> >  	if (of_flat_dt_is_compatible(root, "fsl,MPC85XXRDB-CAMP")) {
> >  		mpic =3D mpic_alloc(NULL, 0, MPIC_NO_RESET |
> >  			MPIC_BIG_ENDIAN |
> > @@ -67,18 +63,6 @@ void __init mpc85xx_rdb_pic_init(void)
> >
> >  	BUG_ON(mpic =3D=3D NULL);
> >  	mpic_init(mpic);
> > -
> > -#ifdef CONFIG_QUICC_ENGINE
> > -	np =3D of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
> > -	if (np) {
> > -		qe_ic_init(np, 0, qe_ic_cascade_low_mpic,
> > -				qe_ic_cascade_high_mpic);
> > -		of_node_put(np);
> > -
> > -	} else
> > -		pr_err("%s: Could not find qe-ic node\n", __func__);
> > -#endif
> > -
> >  }
> >
> >  /*
> > diff --git a/arch/powerpc/platforms/85xx/twr_p102x.c
> > b/arch/powerpc/platforms/85xx/twr_p102x.c
> > index 71bc255..603e244 100644
> > --- a/arch/powerpc/platforms/85xx/twr_p102x.c
> > +++ b/arch/powerpc/platforms/85xx/twr_p102x.c
> > @@ -35,26 +35,12 @@ static void __init twr_p1025_pic_init(void)  {
> >  	struct mpic *mpic;
> >
> > -#ifdef CONFIG_QUICC_ENGINE
> > -	struct device_node *np;
> > -#endif
> > -
> >  	mpic =3D mpic_alloc(NULL, 0, MPIC_BIG_ENDIAN |
> >  			MPIC_SINGLE_DEST_CPU,
> >  			0, 256, " OpenPIC  ");
> >
> >  	BUG_ON(mpic =3D=3D NULL);
> >  	mpic_init(mpic);
> > -
> > -#ifdef CONFIG_QUICC_ENGINE
> > -	np =3D of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
> > -	if (np) {
> > -		qe_ic_init(np, 0, qe_ic_cascade_low_mpic,
> > -				qe_ic_cascade_high_mpic);
> > -		of_node_put(np);
> > -	} else
> > -		pr_err("Could not find qe-ic node\n");
> > -#endif
> >  }
> >
> >  /*
> >
> ************************************************************
> **********
> > ** diff --git a/drivers/irqchip/qe_ic.c b/drivers/irqchip/qe_ic.c
> > index ec2ca86..f7f9a81 100644
> > --- a/drivers/irqchip/qe_ic.c
> > +++ b/drivers/irqchip/qe_ic.c
> > @@ -509,4 +509,18 @@ static int __init init_qe_ic_sysfs(void)
> >  	return 0;
> >  }
> >
> > +static int __init qeic_of_init(void)
> > +{
> > +	struct device_node *np;
> > +
> > +	np =3D of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
> > +	if (np) {
> > +		qe_ic_init(np, 0, qe_ic_cascade_low_mpic,
> > +			   qe_ic_cascade_high_mpic);
> > +		of_node_put(np);
> > +	}
> > +	return 0;
> > +}
> > +
> > +subsys_initcall(qeic_of_init);
> >  subsys_initcall(init_qe_ic_sysfs);
>=20
> Was this tested on systems with dtbs containing type "qeic" but missing "=
fsl,qe-
> ic"?  What about non-p1021_mds mpc85xx_mds boards?

In kernel, there are no boards containing type "qeic" in dtb.

-Zhao Qiang
BR
