Return-Path: <jason@lakedaemon.net>
Received: from pmta2.delivery5.ore.mailhop.org
 (pmta2.delivery5.ore.mailhop.org [54.186.218.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkR1P5dHtzDrPY
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 00:22:49 +1000 (AEST)
Date: Tue, 5 Jul 2016 14:21:43 +0000
From: Jason Cooper <jason@lakedaemon.net>
To: Qiang Zhao <qiang.zhao@nxp.com>
Cc: "oss@buserror.net" <oss@buserror.net>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Xiaobo Xie <xiaobo.xie@nxp.com>
Subject: Re: [PATCH 1/2] qe/ic: move qe_ic_init from platforms to irqchip
Message-ID: <20160705142143.GD3348@io.lakedaemon.net>
References: <1467683219-29326-1-git-send-email-qiang.zhao@nxp.com>
 <20160705031836.GA3348@io.lakedaemon.net>
 <AM3PR04MB1185048AB3BBC592F105E8C391390@AM3PR04MB1185.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AM3PR04MB1185048AB3BBC592F105E8C391390@AM3PR04MB1185.eurprd04.prod.outlook.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 05, 2016 at 07:27:21AM +0000, Qiang Zhao wrote:
> On 07/05/2016 11:19 AM, Jason Cooper <jason@lakedaemon.net> wrote:
> > -----Original Message-----
> > From: Jason Cooper [mailto:jason@lakedaemon.net]
> > Sent: Tuesday, July 05, 2016 11:19 AM
> > To: Qiang Zhao <qiang.zhao@nxp.com>
> > Cc: oss@buserror.net; tglx@linutronix.de; marc.zyngier@arm.com; linuxppc-
> > dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; Xiaobo Xie
> > <xiaobo.xie@nxp.com>
> > Subject: Re: [PATCH 1/2] qe/ic: move qe_ic_init from platforms to irqchip
> > 
> > Hi Zhao Qiang,
> > 
> > Please reword your subject line to conform to the standard in irqchip (since
> > that's where the code is added).  Also, please adjust the subject line to express
> > *why* the change is being made.
> > 
> > On Tue, Jul 05, 2016 at 09:46:58AM +0800, Zhao Qiang wrote:
> > > The codes of qe_ic_init in platforms are redundant, move them to qe_ic
> > > under irqchip
> > 
> > This needs to be a lot more clear.  How is backwards compatibility preserved?
> > Why is lookup by type "qeic" dropped?  In short, please explain everything that
> > looks funny so we don't have to guess.
> 
> Thank you for your review and feedback.
> 
> > 
> > > Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> > > ---
> > >  arch/powerpc/platforms/83xx/misc.c            | 15 ---------------
> > >  arch/powerpc/platforms/85xx/corenet_generic.c |  9 ---------
> > >  arch/powerpc/platforms/85xx/mpc85xx_mds.c     | 14 --------------
> > >  arch/powerpc/platforms/85xx/mpc85xx_rdb.c     | 16 ----------------
> > >  arch/powerpc/platforms/85xx/twr_p102x.c       | 14 --------------
> > >  drivers/irqchip/qe_ic.c                       | 14 ++++++++++++++
> > >  6 files changed, 14 insertions(+), 68 deletions(-)
> > >
> > > diff --git a/arch/powerpc/platforms/83xx/misc.c
> > > b/arch/powerpc/platforms/83xx/misc.c
> > > index 7e923ca..9431fc7 100644
> > > --- a/arch/powerpc/platforms/83xx/misc.c
> > > +++ b/arch/powerpc/platforms/83xx/misc.c
> > > @@ -93,24 +93,9 @@ void __init mpc83xx_ipic_init_IRQ(void)  }
> > >
> > >  #ifdef CONFIG_QUICC_ENGINE
> > > -void __init mpc83xx_qe_init_IRQ(void) -{
> > > -	struct device_node *np;
> > > -
> > > -	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
> > > -	if (!np) {
> > > -		np = of_find_node_by_type(NULL, "qeic");
> > > -		if (!np)
> > > -			return;
> > > -	}
> > 
> > This block isn't preserved in the irqchip driver.  Why not?
> 
> I grep qeic in arch/powerpc/boot/dts/*, doesn't find which board use qeic as type.

Unfortunately, checking powerpc/boot/dts/* isn't sufficient for
confirming we aren't going to break backwards compatibility with boards
*in the field*.

Please take a look at:

  d4fb5ebd83c70 powerpc/83xx: consolidate init_IRQ functions
  8159df72d43e2 83xx: add support for the kmeter1 board.

Perhaps one or two of the authors is still around and can say why that
check is there and if it's ok to remove it.

Or, we could just play it safe and keep the check.

...
> > > diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
> > > b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
> > > index f61cbe2..7ae4901 100644
> > > --- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
> > > +++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
> > > @@ -279,20 +279,6 @@ static void __init mpc85xx_mds_qeic_init(void)
> > >  		of_node_put(np);
> > >  		return;
> > >  	}
> > > -
> > > -	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
> > > -	if (!np) {
> > > -		np = of_find_node_by_type(NULL, "qeic");
> > > -		if (!np)
> > > -			return;
> > > -	}
> > > -
> > > -	if (machine_is(p1021_mds))
> > > -		qe_ic_init(np, 0, qe_ic_cascade_low_mpic,
> > > -				qe_ic_cascade_high_mpic);
> > > -	else
> > > -		qe_ic_init(np, 0, qe_ic_cascade_muxed_mpic, NULL);
> > 
> > This block is also not preserved.  Nor explained in the commit log.  Is it really ok
> > to drop it?  If so, why?
> 
> on non-p1021_mds mpc85xx_mds boards(mpc8568 and mpc8569).
> The qeic has the same interrupt number for low and high. So use qe_ic_cascade_muxed_mpic for this situation.
> 
>         qeic: interrupt-controller@80 {
>                 interrupt-controller;
>                 compatible = "fsl,qe-ic";
>                 #address-cells = <0>;
>                 #interrupt-cells = <1>;
>                 reg = <0x80 0x80>;
>                 interrupts = <46 2 0 0 46 2 0 0>; //high:30 low:30
>                 interrupt-parent = <&mpic>;
>         };
> 
> In qe_ic_init, the code(as below) can handle this situation.
> If " qe_ic->virq_high != qe_ic->virq_low ", then set chaned handler for high handler.
> 
>         if (qe_ic->virq_high != NO_IRQ &&
>                         qe_ic->virq_high != qe_ic->virq_low) {
>                 irq_set_handler_data(qe_ic->virq_high, qe_ic);
>                 irq_set_chained_handler(qe_ic->virq_high, high_handler);
>         } 
> 

Ok, thanks.  Please clarify that in the commit log on your next version.

thx,

Jason.
