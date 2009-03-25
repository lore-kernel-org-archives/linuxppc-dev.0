Return-Path: <Joakim.Tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3ABBBDDD1B
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2009 08:55:11 +1100 (EST)
In-Reply-To: <20090325.144041.128558998.davem@davemloft.net>
References: <1237987849.2194.9.camel@gentoo-jocke.transmode.se>	<49CA39EA.6020208@cosmosbay.com>
	<20090325.144041.128558998.davem@davemloft.net>
To: David Miller <davem@davemloft.net>
MIME-Version: 1.0
Subject: Re: [PATCH] ucc_geth: Move freeing of TX packets to NAPI context.
Message-ID: <OF2B9DF8FC.AFC932DD-ONC1257584.00783408-C1257584.007866EA@transmode.se>
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date: Wed, 25 Mar 2009 22:55:07 +0100
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, leoli@freescale.com,
	dada1@cosmosbay.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Miller <davem@davemloft.net> wrote on 25/03/2009 22:40:41:
>=20
> From: Eric Dumazet <dada1@cosmosbay.com>
> Date: Wed, 25 Mar 2009 15:04:26 +0100
>=20
> > Joakim Tjernlund a =E9crit :
> > > +   /* Tx event processing */
> > > +   spin=5Flock(&ugeth->lock);
> > > +   for (i =3D 0; i < ug=5Finfo->numQueuesTx; i++) {
> > > +      ucc=5Fgeth=5Ftx(ugeth->dev, i);
> > > +   }
> > > +   spin=5Funlock(&ugeth->lock);
> > > +
> >=20
> > Why tx completions dont change "howmany" ?
> > It seems strange you changed UCC=5FGETH=5FDEV=5FWEIGHT if not taking in=
to=20
account tx event above...
>=20
> He should leave howmany alone for TX work and use a weight
> value of 64 just like most other drivers in the tree do.

OK, will change this to 64.

>=20
> Due to the abuse and random ignorant fiddling of the
> weight value, I am going to make it something the core
> rather than drivers choose.

Good, I had a hard time finding info how one should use it anyway.=20
