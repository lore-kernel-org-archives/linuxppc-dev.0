Return-Path: <qiang.zhao@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0241.outbound.protection.outlook.com [207.46.163.241])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 11C871A000D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 12:04:15 +1000 (EST)
From: "qiang.zhao@freescale.com" <qiang.zhao@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH v2 1/2] flexcan: add err_irq handler for flexcan
Date: Wed, 25 Jun 2014 02:04:08 +0000
Message-ID: <1403661847384.93009@freescale.com>
References: <1403229664-33912-1-git-send-email-B45475@freescale.com>
 <1403281165.12851.186.camel@snotra.buserror.net>
 <fc0a7150924249768aee8e4361c654a1@BLUPR03MB341.namprd03.prod.outlook.com>,
 <1403631298.26908.1.camel@snotra.buserror.net>
In-Reply-To: <1403631298.26908.1.camel@snotra.buserror.net>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "mkl@pengutronix.de" <mkl@pengutronix.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "wg@grandegger.com" <wg@grandegger.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=0A=
________________________________________=0A=
From: Wood Scott-B07421=0A=
Sent: Wednesday, June 25, 2014 1:34 AM=0A=
To: Zhao Qiang-B45475=0A=
Cc: linuxppc-dev@lists.ozlabs.org; linux-can@vger.kernel.org; wg@grandegger=
.com; mkl@pengutronix.de=0A=
Subject: Re: [PATCH v2 1/2] flexcan: add err_irq handler for flexcan=0A=
=0A=
On Mon, 2014-06-23 at 01:20 -0500, Zhao Qiang-B45475 wrote:=0A=
> On Sat, 2014-06-21 at 12:19, Wood Scott wrote:=0A=
>=0A=
> > -----Original Message-----=0A=
> > From: Wood Scott-B07421=0A=
> > Sent: Saturday, June 21, 2014 12:19 AM=0A=
> > To: Zhao Qiang-B45475=0A=
> > Cc: linuxppc-dev@lists.ozlabs.org; linux-can@vger.kernel.org;=0A=
> > wg@grandegger.com; mkl@pengutronix.de; Wood Scott-B07421=0A=
> > Subject: Re: [PATCH v2 1/2] flexcan: add err_irq handler for flexcan=0A=
> >=0A=
> > On Fri, 2014-06-20 at 10:01 +0800, Zhao Qiang wrote:=0A=
> > > when flexcan is not physically linked, command 'cantest' will trigger=
=0A=
> > > an err_irq, add err_irq handler for it.=0A=
> > >=0A=
> > > Signed-off-by: Zhao Qiang <B45475@freescale.com>=0A=
> > > ---=0A=
> > > Changes for v2:=0A=
> > >   - use a space instead of tab=0A=
> > >   - use flexcan_poll_state instead of print=0A=
> > >=0A=
> > >  drivers/net/can/flexcan.c | 31 ++++++++++++++++++++++++++++++-=0A=
> > >  1 file changed, 30 insertions(+), 1 deletion(-)=0A=
> > >=0A=
> > > diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c=0A=
> > > index f425ec2..7432ba4 100644=0A=
> > > --- a/drivers/net/can/flexcan.c=0A=
> > > +++ b/drivers/net/can/flexcan.c=0A=
> > > @@ -208,6 +208,7 @@ struct flexcan_priv {=0A=
> > >   void __iomem *base;=0A=
> > >   u32 reg_esr;=0A=
> > >   u32 reg_ctrl_default;=0A=
> > > + unsigned int err_irq;=0A=
> >=0A=
> > Why unsigned?=0A=
> Err_irq is from 0.=0A=
=0A=
So?  irqs are plain "int" almost everywhere in the kernel.=0A=
=0A=
OK, I will change it.=0A=
=0A=
-Zhao =0A=
=0A=
