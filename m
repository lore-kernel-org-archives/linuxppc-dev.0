Return-Path: <B29397@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 14E4CB7005
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2012 11:11:17 +1000 (EST)
From: Chen Peter-B29397 <B29397@freescale.com>
To: Christoph Fritz <chf.fritz@googlemail.com>, Fabio Estevam
 <festevam@gmail.com>, Neil Zhang <zhangwm@marvell.com>, Li Yang-R58472
 <r58472@freescale.com>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org"
 <linux-usb@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "Hans J. Koch" <hjk@hansjkoch.de>, Daniel
 Mack <daniel@caiaq.de>
Subject: RE: [RFC] [PATCH] usb: gadget: fix dtd dma confusion
Date: Mon, 14 May 2012 01:11:10 +0000
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803BA8168@039-SN2MPN1-023.039d.mgd.msft.net>
References: <F281D0F91ED19E4D8E63A7504E8A64980AFFE3@039-SN2MPN1-022.039d.mgd.msft.net>
 <CAOMZO5AjQsNw7_4ETkB38mmuBXj4pnCwJwAsi4zC4b_83=Enfw@mail.gmail.com>
 <20120409200656.GD2640@local>
 <CAOMZO5BTrA8G6wwQZ3e6bydJX7UtG7jj2c29Ln7u_3_jyUGB+w@mail.gmail.com>
 <20120410001017.GF2640@local>
 <CAOMZO5A=sHeyoQ0PCd=09qGGKb0NjXi-kF5qyG+3U-GhD7rhzg@mail.gmail.com>
 <20120410021151.GB23044@lovely.krouter>
 <20120411073918.GA9180@lovely.krouter>
 <CAOMZO5C729Ki0Bequ+s1nnrgt4NZWvwg3Wnjk4kHp=d9BtkeXw@mail.gmail.com>
 <20120509000221.GA19525@lovely.krouter>
 <20120513225126.GA3683@lovely.krouter>
In-Reply-To: <20120513225126.GA3683@lovely.krouter>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Oliver Neukum <oneukum@suse.de>, Kukjin Kim <kgene.kim@samsung.com>,
 Eric Miao <eric.y.miao@gmail.com>, Estevam Fabio-R49496 <r49496@freescale.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Nicolas Ferre <nicolas.ferre@atmel.com>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Ido Shayevitz <idos@codeaurora.org>,
 Ben Dooks <ben-linux@fluff.org>, Thomas Dahlmann <dahlmann.thomas@arcor.de>,
 Russell King <linux@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20


=20
> > See here:
> > daec765da767e4a6a30e1298862b28f2cae9a73f
> > usb: gadget: mv_udc: fix dtd dma confusion
> >
> > So hereby I'm CC-ing all *udc.c maintainers to point out that this
> > issue maybe affects you too.
> >
> >
> > ---
> > Subject: [PATCH] usb: gadget: fsl_udc: fix dtd dma confusion
> >
> > The controller will hang when doing testings with g_ether and iperf
> > (tool for measuring maximum TCP and UDP bandwidth).  This patch adds a
> > delay to wait for controller to release dtd dma before freeing it.
> >
> > Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
> > ---
> >  drivers/usb/gadget/fsl_udc_core.c |    9 +++++++++
> >  1 files changed, 9 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/usb/gadget/fsl_udc_core.c
> b/drivers/usb/gadget/fsl_udc_core.c
> > index 55abfb6..fc86108 100644
> > --- a/drivers/usb/gadget/fsl_udc_core.c
> > +++ b/drivers/usb/gadget/fsl_udc_core.c
> > @@ -1638,6 +1638,15 @@ static int process_ep_req(struct fsl_udc *udc,
> int pipe,
> >  			status =3D REQ_UNCOMPLETE;
> >  			return status;
> >  		} else if (remaining_length) {
> > +			/* wait controller release dtd dma */
> > +			while ((curr_qh->curr_dtd_ptr =3D=3D curr_td->td_dma)) {
> > +				if (curr_td->next_td_ptr =3D=3D
> > +						EP_QUEUE_HEAD_NEXT_TERMINATE) {
> > +					udelay(100);
> > +					break;
> > +				}
> > +				udelay(1);
> > +			}
> >  			if (direction) {
> >  				VDBG("Transmit dTD remaining length not zero");
> >  				status =3D -EPROTO;
> > --
> > 1.7.2.5
>=20
>  ping  -  what about this patch? Will it be applied?
>=20
Christoph, it is better use errata suggests workaround (postpone free dtd m=
emory),
and you can find related code at:=20

http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/
drivers/usb/gadget/arcotg_udc.c?h=3Dimx_3.0.15

The code is defined with POSTPONE_FREE_LAST_DTD

> Thanks,
>  -- Christoph
>=20
