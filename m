Return-Path: <Joakim.Tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 06A77DDDF3
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2009 02:16:28 +1100 (EST)
In-Reply-To: <49CA39EA.6020208@cosmosbay.com>
References: <1237987849.2194.9.camel@gentoo-jocke.transmode.se>
	<49CA39EA.6020208@cosmosbay.com>
To: Eric Dumazet <dada1@cosmosbay.com>
MIME-Version: 1.0
Subject: Re: [PATCH] ucc_geth: Move freeing of TX packets to NAPI context.
Message-ID: <OF73F7C45F.ACAACBF8-ONC1257584.0052EC21-C1257584.0053E5EF@transmode.se>
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date: Wed, 25 Mar 2009 16:16:24 +0100
Content-Type: text/plain; charset="ISO-8859-1"
Cc: 'linuxppc-dev Development' <linuxppc-dev@ozlabs.org>, leoli@freescale.com,
	Netdev <netdev@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Eric Dumazet <dada1@cosmosbay.com> wrote on 25/03/2009 15:04:26:
> Joakim Tjernlund a =E9crit :
> >>From 1c2f23b1f37f4818c0fd0217b93eb38ab6564840 Mon Sep 17 00:00:00 2001
> > From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> > Date: Tue, 24 Mar 2009 10:19:27 +0100
> > Subject: [PATCH] ucc=5Fgeth: Move freeing of TX packets to NAPI context.
> >  Also increase NAPI weight somewhat.
> >  This will make the system alot more responsive while
> >  ping flooding the ucc=5Fgeth ethernet interaface.
> >=20
> >=20
> > Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> > ---
> >  drivers/net/ucc=5Fgeth.c |   30 +++++++++++-------------------
> >  drivers/net/ucc=5Fgeth.h |    2 +-
> >  2 files changed, 12 insertions(+), 20 deletions(-)
> >=20
> > diff --git a/drivers/net/ucc=5Fgeth.c b/drivers/net/ucc=5Fgeth.c
> > index 097aed8..7d5d110 100644
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
> >     for (i =3D 0; i < ug=5Finfo->numQueuesRx; i++)
> >        howmany +=3D ucc=5Fgeth=5Frx(ugeth, i, budget - howmany);
> >=20
>=20
> Cant you test (ucce & UCCE=5FTX=5FEVENTS) or something here to avoid
> taking lock and checking queues if not necessary ?

Probably, but I want this patch as simple as possible. There
are lots of optimizations left to do in this driver.

>=20
> > +   /* Tx event processing */
> > +   spin=5Flock(&ugeth->lock);
> > +   for (i =3D 0; i < ug=5Finfo->numQueuesTx; i++) {
> > +      ucc=5Fgeth=5Ftx(ugeth->dev, i);
> > +   }
> > +   spin=5Funlock(&ugeth->lock);
> > +
>=20
> Why tx completions dont change "howmany" ?
> It seems strange you changed UCC=5FGETH=5FDEV=5FWEIGHT if not taking into=
=20
account tx event above...

This is unclear and last I checked not very common amongst other drivers=20
in the
tree.

UCC=5FGETH=5FDEV=5FWEIGHT needs to be a bit bigger than the number of RX HW=
=20
buffers avaliable,
otherwise one won't be able to drain the whole queue in one go. Changing
weight to something bigger made a big difference.

 Jocke
