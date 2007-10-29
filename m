Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D28D8DDF81
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Oct 2007 17:12:17 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l9T6CAsh026671
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Oct 2007 23:12:10 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l9T6C8fI000863
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Oct 2007 01:12:09 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] ucc_geth: add support for netpoll
Date: Mon, 29 Oct 2007 14:12:07 +0800
Message-ID: <989B956029373F45A0B8AF0297081890019B61BF@zch01exm26.fsl.freescale.net>
In-Reply-To: <20071027143731.GA2616@zarina>
References: <20071011124842.GB13963@localhost.localdomain>
	<4723389F.7010109@ru.mvista.com> <20071027143731.GA2616@zarina>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: <cbou@mail.ru>, "Sergei Shtylyov" <sshtylyov@ru.mvista.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Anton Vorontsov [mailto:cbou@mail.ru]=20
> Sent: Saturday, October 27, 2007 10:38 PM
> To: Sergei Shtylyov
> Cc: Anton Vorontsov; netdev@vger.kernel.org; Li Yang-r58472;=20
> linux-kernel@vger.kernel.org; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] ucc_geth: add support for netpoll
>=20
> On Sat, Oct 27, 2007 at 05:09:51PM +0400, Sergei Shtylyov wrote:
> > Hello.
> >=20
> > Anton Vorontsov wrote:
> >=20
> > > This patch adds netpoll support for the QE UCC Gigabit Ethernet=20
> > > driver. The approach is very similar to the gianfar driver.
> >=20
> >     It's rather contrarywise -- this is standard approach=20
> and gianfar=20
> > with its
> > 3 TSEC IRQs has a quite non-standard poll_controller()=20
> implementation.
>=20
> Oh.. well, right -- gianfar a bit more comlex in that regard.
>=20
> >=20
> > > Tested using netconsole.
> >=20
> >     KGDBoE is considered a better test (I hope you've also=20
> tested with it).
>=20
> At the time of posting it was tested using netconsole only, a=20
> few days later it's was tested using KGDBoE also. So, it works indeed.
>=20
> > > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>=20
> diff --git=20
> > > a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c index=20
> > > 18a6f48..06807ce 100644
> > > --- a/drivers/net/ucc_geth.c
> > > +++ b/drivers/net/ucc_geth.c
> > > @@ -3691,6 +3691,22 @@ static irqreturn_t=20
> ucc_geth_irq_handler(int irq, void *info)
> > >  	return IRQ_HANDLED;
> > >  }
> > > =20
> > > +#ifdef CONFIG_NET_POLL_CONTROLLER
> > > +/*
> > > + * Polling 'interrupt' - used by things like netconsole to send=20
> > > +skbs
> > > + * without having to re-enable interrupts. It's not called while
> > > + * the interrupt routine is executing.
> > > + */
> > > +static void ucc_netpoll(struct net_device *dev) {
> > > +	struct ucc_geth_private *ugeth =3D netdev_priv(dev);
> > > +
> > > +	disable_irq(ugeth->ug_info->uf_info.irq);
> > > +	ucc_geth_irq_handler(ugeth->ug_info->uf_info.irq, dev);
> > > +	enable_irq(ugeth->ug_info->uf_info.irq);
> >=20
> >     Why not make it less complex (for a reader and gcc too :-) ?
>=20
> Yup, I'm agree here but it's too late. Again. ;-)
>=20
> This patch already accepted into the -mm (a week or so after=20
> the silence), so.. now I'd rather not bother Andrew with such=20
> really cosmetic changes. But if Jeff would directly apply=20
> modfied patch, I'll send it. ;-)

Oops.  The original patch happened to hit the Junk mail box. :(  I think
the patch is good to merge after the cosmetic change.  I can do it in
next pull request to Jeff.

Thanks
- Leo
