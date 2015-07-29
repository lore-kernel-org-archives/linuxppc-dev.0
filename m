Return-Path: <claudiu.manoil@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0124.outbound.protection.outlook.com [207.46.100.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B2D741A096D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2015 18:56:30 +1000 (AEST)
From: Manoil Claudiu <claudiu.manoil@freescale.com>
To: Arnd Bergmann <arnd@arndb.de>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH] gianfar: Fix warnings when built on 64-bit
Date: Wed, 29 Jul 2015 08:41:29 +0000
Message-ID: <BY2PR0301MB072721F7AD52766A864FC79E9C8C0@BY2PR0301MB0727.namprd03.prod.outlook.com>
References: <1438147477-393-1-git-send-email-scottwood@freescale.com>
 <4498062.4y369pLSmO@wuerfel>
In-Reply-To: <4498062.4y369pLSmO@wuerfel>
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

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: Wednesday, July 29, 2015 11:02 AM
> To: linuxppc-dev@lists.ozlabs.org; netdev@vger.kernel.org; Manoil Claudiu=
-
> B08782; Wood Scott-B07421
> Subject: Re: [PATCH] gianfar: Fix warnings when built on 64-bit
>=20
> On Wednesday 29 July 2015 00:24:37 Scott Wood wrote:
>=20
> > Alternatively, if there's a desire to not mess with this code (I don't
> > know how to trigger this code path to test it), this driver should be
> > given dependencies that ensure that it only builds on 32-bit.
>=20
> These are obvious fixes, they should definitely go in.

This patch conflicts with the rx s/g patch series:
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=
=3D9061cb023567abf081569d6851b0815dd18437e6

So if applied as it is on top of net.git it will give a headache when net-n=
ext.git
will be merged into net.git (or vice versa).

Since there are no 64-bit systems with gianfar/ eTSEC, I think that this pa=
tch
should target net-next.git (reworked to be applicable on net-next.git) to a=
void
the conflict.   I could do this rework and resend it on top of net-next.git

>=20
> >  drivers/net/ethernet/freescale/gianfar.c | 22 ++++++++++++++++++----
> >  1 file changed, 18 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/freescale/gianfar.c
> b/drivers/net/ethernet/freescale/gianfar.c
> > index ff87502..7c682ac 100644
> > --- a/drivers/net/ethernet/freescale/gianfar.c
> > +++ b/drivers/net/ethernet/freescale/gianfar.c
> > @@ -565,6 +565,7 @@ static void gfar_ints_enable(struct gfar_private
> *priv)
> >  	}
> >  }
> >
> > +#ifdef CONFIG_PM
> >  static void lock_tx_qs(struct gfar_private *priv)
> >  {
> >  	int i;
> > @@ -580,6 +581,7 @@ static void unlock_tx_qs(struct gfar_private *priv)
> >  	for (i =3D 0; i < priv->num_tx_queues; i++)
> >  		spin_unlock(&priv->tx_queue[i]->txlock);
> >  }
> > +#endif
> >
>=20
> This seems unrelated and should probably be a separate fix.
>=20

I'm working at a patch set to revive/ cleanup the power management code,
and lock_tx_qs() is planned to be removed (it can be shown that it's not ne=
eded).
So this change can be remove from this patch.

Thanks,
Claudiu

[...]
