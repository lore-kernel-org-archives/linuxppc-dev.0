Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id D6670DE031
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2008 00:48:47 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] fs_enet: MDIO on GPIO support
Date: Wed, 18 Jun 2008 16:48:38 +0200
References: <200805261152.37636.laurentp@cse-semaphore.com>
	<200806161057.03158.laurentp@cse-semaphore.com>
	<20080616163400.GA13996@loki.buserror.net>
In-Reply-To: <20080616163400.GA13996@loki.buserror.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart15768872.T64x67KeTE";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200806181648.40874.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com, vbordug@ru.mvista.com,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart15768872.T64x67KeTE
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Scott,

On Monday 16 June 2008 18:34, Scott Wood wrote:
> On Mon, Jun 16, 2008 at 10:57:02AM +0200, Laurent Pinchart wrote:
> > On Monday 26 May 2008 11:53, Laurent Pinchart wrote:
> > > Port the fs_enet driver to support the MDIO on GPIO driver for PHY
> > > access in addition to the mii-bitbang driver.
> >=20
> > Now that 1/2 has been applied by Jeff, could this one make it to=20
> > powerpc-next ?
>=20
> This patch should probably go through Jeff as well...

Jeff, what's your opinion on this ?

> Acked-by: Scott Wood <scottwood@freescale.com>
>=20
> > > -	data =3D of_get_property(phynode, "reg", &len);
> > > -	if (!data || len !=3D 4)
> > > -		goto out_put_mdio;
> > > +	bus_id =3D of_get_gpio(mdionode, 0);
> > > +	if (bus_id < 0) {
> > > +		struct resource res;
> > > +		ret =3D of_address_to_resource(mdionode, 0, &res);
> > > +		if (ret)
> > > +			goto out_put_mdio;
> > > +		bus_id =3D res.start;
> > > +	}
> > > =20
> > > -	snprintf(fpi->bus_id, 16, "%x:%02x", res.start, *data);
> > > +	snprintf(fpi->bus_id, 16, "%x:%02x", bus_id, *data);
>=20
> It'd be nice if this sort of thing could be moved to phylib, so the latter
> could simply be passed a device node (in addition to current mechanisms f=
or
> the benefit of unfortunate device-tree-less architectures).

Adding a phy_connect_of that would move the above logic to phy_device.c=20
shouldn't be too difficult. Would that be enough ? The mdio bus code would=
=20
still use the bus id to identify phy devices in mdiobus_register.

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart15768872.T64x67KeTE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD4DBQBIWSBI8y9gWxC9vpcRAjJjAJYj2A6iRgUP6xEnBSRgUzgkrrwnAJ9yPftV
sB/8c1haLgkl4Z+vFSrimQ==
=3RPN
-----END PGP SIGNATURE-----

--nextPart15768872.T64x67KeTE--
