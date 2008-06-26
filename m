Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 33075DDE1F
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 19:38:08 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: matvejchikov@gmail.com
Subject: Re: [PATCH] fs_enet: restore promiscuous and multicast settings in
	restart()
Date: Thu, 26 Jun 2008 11:38:03 +0200
References: <200806181707.17739.laurentp@cse-semaphore.com>
	<200806201025.28768.laurentp@cse-semaphore.com>
	<8496f91a0806200155hcb1f440ld7b5f678d95fdb85@mail.gmail.com>
In-Reply-To: <8496f91a0806200155hcb1f440ld7b5f678d95fdb85@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart14464927.ITozZ45xa8";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200806261138.04192.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org, Bill Fink <billfink@mindspring.com>,
	vbordug@ru.mvista.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart14464927.ITozZ45xa8
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Friday 20 June 2008 10:55, Matvejchikov Ilya wrote:
> >> > diff --git a/drivers/net/fs_enet/mac-fcc.c=20
b/drivers/net/fs_enet/mac-fcc.c
> >> > index ce40cf9..1a95cf1 100644
> >> > --- a/drivers/net/fs_enet/mac-fcc.c
> >> > +++ b/drivers/net/fs_enet/mac-fcc.c
> >> > @@ -464,6 +464,9 @@ static void restart(struct net_device *dev)
> >> >             C32(fccp, fcc_fpsmr, FCC_PSMR_FDE | FCC_PSMR_LPB);
> >> >
> >> >     S32(fccp, fcc_gfmr, FCC_GFMR_ENR | FCC_GFMR_ENT);
> >> > +
> >> > +   /* Restore multicast and promiscous settings */
> >> > +   set_multicast_list(dev);
> >> >  }
>=20
> Is it right to call set_multicast_list() after turning on transmitter
> and receiver? May be swap this lines around?

I'm not sure if that will make a difference, but you're right, restoring th=
e=20
multicast and promiscuous settings is better done before turning the receiv=
er=20
and transmitter on.

I'll send a new patch.

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart14464927.ITozZ45xa8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBIY2N88y9gWxC9vpcRAuljAKDD41t9uE4oXuG1MrkOpDgsxRXV2gCfRXeH
cGP4eVG5ixNwDAQpQfE6ozI=
=8Y7q
-----END PGP SIGNATURE-----

--nextPart14464927.ITozZ45xa8--
