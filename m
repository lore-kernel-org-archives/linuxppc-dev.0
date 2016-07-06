Return-Path: <qiang.zhao@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0071.outbound.protection.outlook.com [104.47.2.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkjtQ3GWkzDqsm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 11:32:45 +1000 (AEST)
From: Qiang Zhao <qiang.zhao@nxp.com>
To: Jason Cooper <jason@lakedaemon.net>
CC: "oss@buserror.net" <oss@buserror.net>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Xiaobo Xie
 <xiaobo.xie@nxp.com>
Subject: RE: [PATCH 1/2] qe/ic: move qe_ic_init from platforms to irqchip
Date: Wed, 6 Jul 2016 01:18:19 +0000
Message-ID: <AM3PR04MB11856C2FE266ABB99F3A99E0913A0@AM3PR04MB1185.eurprd04.prod.outlook.com>
References: <1467683219-29326-1-git-send-email-qiang.zhao@nxp.com>
 <20160705031836.GA3348@io.lakedaemon.net>
 <AM3PR04MB1185048AB3BBC592F105E8C391390@AM3PR04MB1185.eurprd04.prod.outlook.com>
 <20160705142143.GD3348@io.lakedaemon.net>
In-Reply-To: <20160705142143.GD3348@io.lakedaemon.net>
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
> Sent: Tuesday, July 05, 2016 10:22 PM
> To: Qiang Zhao <qiang.zhao@nxp.com>
> Cc: oss@buserror.net; tglx@linutronix.de; marc.zyngier@arm.com; linuxppc-
> dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; Xiaobo Xie
> <xiaobo.xie@nxp.com>
> Subject: Re: [PATCH 1/2] qe/ic: move qe_ic_init from platforms to irqchip
>=20
> On Tue, Jul 05, 2016 at 07:27:21AM +0000, Qiang Zhao wrote:
> > On 07/05/2016 11:19 AM, Jason Cooper <jason@lakedaemon.net> wrote:
> > > -----Original Message-----
> > > From: Jason Cooper [mailto:jason@lakedaemon.net]
> > > Sent: Tuesday, July 05, 2016 11:19 AM
> > > To: Qiang Zhao <qiang.zhao@nxp.com>
> > > Cc: oss@buserror.net; tglx@linutronix.de; marc.zyngier@arm.com;
> > > linuxppc- dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; Xiaobo
> > > Xie <xiaobo.xie@nxp.com>
> > > Subject: Re: [PATCH 1/2] qe/ic: move qe_ic_init from platforms to
> > > > diff --git a/arch/powerpc/platforms/83xx/misc.c
> > > > b/arch/powerpc/platforms/83xx/misc.c
> > > > index 7e923ca..9431fc7 100644
> > > > --- a/arch/powerpc/platforms/83xx/misc.c
> > > > +++ b/arch/powerpc/platforms/83xx/misc.c
> > > > @@ -93,24 +93,9 @@ void __init mpc83xx_ipic_init_IRQ(void)  }
> > > >
> > > >  #ifdef CONFIG_QUICC_ENGINE
> > > > -void __init mpc83xx_qe_init_IRQ(void) -{
> > > > -	struct device_node *np;
> > > > -
> > > > -	np =3D of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
> > > > -	if (!np) {
> > > > -		np =3D of_find_node_by_type(NULL, "qeic");
> > > > -		if (!np)
> > > > -			return;
> > > > -	}
> > >
> > > This block isn't preserved in the irqchip driver.  Why not?
> >
> > I grep qeic in arch/powerpc/boot/dts/*, doesn't find which board use qe=
ic as
> type.
>=20
> Unfortunately, checking powerpc/boot/dts/* isn't sufficient for confirmin=
g we
> aren't going to break backwards compatibility with boards *in the field*.
>=20
> Please take a look at:
>=20
>   d4fb5ebd83c70 powerpc/83xx: consolidate init_IRQ functions
>   8159df72d43e2 83xx: add support for the kmeter1 board.
>=20
> Perhaps one or two of the authors is still around and can say why that ch=
eck is
> there and if it's ok to remove it.
>=20
> Or, we could just play it safe and keep the check.
>=20

Ok, I will add this check in next version.

Thanks
-Zhao Qiang
