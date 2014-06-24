Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0185.outbound.protection.outlook.com [207.46.163.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B090A1A085D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 03:35:14 +1000 (EST)
Message-ID: <1403631298.26908.1.camel@snotra.buserror.net>
Subject: Re: [PATCH v2 1/2] flexcan: add err_irq handler for flexcan
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang-B45475 <qiang.zhao@freescale.com>
Date: Tue, 24 Jun 2014 12:34:58 -0500
In-Reply-To: <fc0a7150924249768aee8e4361c654a1@BLUPR03MB341.namprd03.prod.outlook.com>
References: <1403229664-33912-1-git-send-email-B45475@freescale.com>
 <1403281165.12851.186.camel@snotra.buserror.net>
 <fc0a7150924249768aee8e4361c654a1@BLUPR03MB341.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 2014-06-23 at 01:20 -0500, Zhao Qiang-B45475 wrote:
> On Sat, 2014-06-21 at 12:19, Wood Scott wrote:
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Saturday, June 21, 2014 12:19 AM
> > To: Zhao Qiang-B45475
> > Cc: linuxppc-dev@lists.ozlabs.org; linux-can@vger.kernel.org;
> > wg@grandegger.com; mkl@pengutronix.de; Wood Scott-B07421
> > Subject: Re: [PATCH v2 1/2] flexcan: add err_irq handler for flexcan
> > 
> > On Fri, 2014-06-20 at 10:01 +0800, Zhao Qiang wrote:
> > > when flexcan is not physically linked, command 'cantest' will trigger
> > > an err_irq, add err_irq handler for it.
> > >
> > > Signed-off-by: Zhao Qiang <B45475@freescale.com>
> > > ---
> > > Changes for v2:
> > > 	- use a space instead of tab
> > > 	- use flexcan_poll_state instead of print
> > >
> > >  drivers/net/can/flexcan.c | 31 ++++++++++++++++++++++++++++++-
> > >  1 file changed, 30 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> > > index f425ec2..7432ba4 100644
> > > --- a/drivers/net/can/flexcan.c
> > > +++ b/drivers/net/can/flexcan.c
> > > @@ -208,6 +208,7 @@ struct flexcan_priv {
> > >  	void __iomem *base;
> > >  	u32 reg_esr;
> > >  	u32 reg_ctrl_default;
> > > +	unsigned int err_irq;
> > 
> > Why unsigned?
> Err_irq is from 0.

So?  irqs are plain "int" almost everywhere in the kernel.

-Scott
