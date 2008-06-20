Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 6D795DDFC8
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 18:25:32 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Bill Fink <billfink@mindspring.com>
Subject: Re: [PATCH] fs_enet: restore promiscuous and multicast settings in
	restart()
Date: Fri, 20 Jun 2008 10:25:25 +0200
References: <200806181707.17739.laurentp@cse-semaphore.com>
	<20080619230128.def96ee0.billfink@mindspring.com>
In-Reply-To: <20080619230128.def96ee0.billfink@mindspring.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2399608.UDlM2X5gCk";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200806201025.28768.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org, vbordug@ru.mvista.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart2399608.UDlM2X5gCk
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 20 June 2008 05:01, Bill Fink wrote:
> On Wed, 18 Jun 2008, Laurent Pinchart wrote:
>=20
> > The restart() function is called when the link state changes and resets
> > multicast and promiscous settings. This patch restores those settings a=
t=20
the
> > end of restart().
> >=20
> > Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
> > ---
> >  drivers/net/fs_enet/mac-fcc.c     |    3 +++
> >  2 files changed, 4 insertions(+), 1 deletions(-)
>=20
> Is the whole patch here?  The above says 2 files changed and 5 lines
> changed, but what's included here is only 1 file and 3 line changes.

Yes it is. I've hand-removed a completely unrelated change that I had=20
committed to my git tree in the same go (back when I wasn't very familiar=20
with git). Do I need to resubmit ?

> > diff --git a/drivers/net/fs_enet/mac-fcc.c b/drivers/net/fs_enet/mac-fc=
c.c
> > index ce40cf9..1a95cf1 100644
> > --- a/drivers/net/fs_enet/mac-fcc.c
> > +++ b/drivers/net/fs_enet/mac-fcc.c
> > @@ -464,6 +464,9 @@ static void restart(struct net_device *dev)
> >  		C32(fccp, fcc_fpsmr, FCC_PSMR_FDE | FCC_PSMR_LPB);
> > =20
> >  	S32(fccp, fcc_gfmr, FCC_GFMR_ENR | FCC_GFMR_ENT);
> > +
> > +	/* Restore multicast and promiscous settings */
> > +	set_multicast_list(dev);
> >  }
> > =20
> >  static void stop(struct net_device *dev)

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart2399608.UDlM2X5gCk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBIW2l48y9gWxC9vpcRAgP5AJ0UKGFmdW8M6qOdnx2Unu8DuAOWFACeK6Gy
BnGWksXkaYUHv7VU4Nt+YFo=
=P46o
-----END PGP SIGNATURE-----

--nextPart2399608.UDlM2X5gCk--
