Return-Path: <Joakim.Tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 340A1DDDF6
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Mar 2009 03:55:06 +1100 (EST)
In-Reply-To: <49CB8DFD.2050504@cosmosbay.com>
References: <1238072077-27044-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<49CB8DFD.2050504@cosmosbay.com>
To: Eric Dumazet <dada1@cosmosbay.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] ucc_geth: Move freeing of TX packets to NAPI context.
Message-ID: <OFD735615D.FB673D0A-ONC1257585.005CB13B-C1257585.005CED95@transmode.se>
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date: Thu, 26 Mar 2009 17:55:02 +0100
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org, leoli@freescale.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Eric Dumazet <dada1@cosmosbay.com> wrote on 26/03/2009 15:15:25:
>=20
> Joakim Tjernlund a =E9crit :
> > Also set NAPI weight to 64 as this is a common value.
> > This will make the system alot more responsive while
> > ping flooding the ucc=5Fgeth ethernet interaface.
> >=20
> > Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> > ---
> >  drivers/net/ucc=5Fgeth.c |   32 ++++++++++++--------------------
> >  drivers/net/ucc=5Fgeth.h |    1 -
> >  2 files changed, 12 insertions(+), 21 deletions(-)
> >=20
> > diff --git a/drivers/net/ucc=5Fgeth.c b/drivers/net/ucc=5Fgeth.c
> > index 097aed8..7fc91aa 100644
> > --- a/drivers/net/ucc=5Fgeth.c
> > +++ b/drivers/net/ucc=5Fgeth.c
> > @@ -3214,7 +3214,7 @@ static int ucc=5Fgeth=5Ftx(struct net=5Fdevice *d=
ev,=20
u8 txQ)
> >        dev->stats.tx=5Fpackets++;
> >=20
> >        /* Free the sk buffer associated with this TxBD */
> > -      dev=5Fkfree=5Fskb=5Firq(ugeth->
> > +      dev=5Fkfree=5Fskb(ugeth->
> >                tx=5Fskbuff[txQ][ugeth->skb=5Fdirtytx[txQ]]);
> >        ugeth->tx=5Fskbuff[txQ][ugeth->skb=5Fdirtytx[txQ]] =3D NULL;
> >        ugeth->skb=5Fdirtytx[txQ] =3D
> > @@ -3248,9 +3248,16 @@ static int ucc=5Fgeth=5Fpoll(struct napi=5Fstruc=
t=20
*napi, int budget)
>=20
> >     for (i =3D 0; i < ug=5Finfo->numQueuesRx; i++)
> >        howmany +=3D ucc=5Fgeth=5Frx(ugeth, i, budget - howmany);
>=20
> Not related to your patch, but seeing above code, I can understand
> you might have a problem in flood situation : Only first queue(s) are
> depleted, and last one cannot be because howmany >=3D budget.
>=20
> This driver might have to remember last queue it handled at previous
> call ucc=5Fgeth=5Fpoll(), so that all rxqueues have same probability to b=
e=20
scanned.
>=20
> j =3D ug->lastslot;
> for (i =3D 0; ug=5Finfo->numQueuesRx; i++) {
>    if (++j >=3D ug=5Finfo->numQueuesRx)
>       j =3D 0;
>    howmany +=3D ucc=5Fgeth=5Frx(ugeth, j, budget - howmany);
>    if (howmany >=3D budget)
>       break;
> }
> ug->lastslot =3D j;

yes, or scan the RX queues in prio order. However ATM there is only
one queue so it won't be a problem until one extends the driver with
several queues.

Thanks,
        Jocke
