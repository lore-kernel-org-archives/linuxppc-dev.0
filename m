Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 2/2] Use of_get_pci_dev_node() in axon_msi.c
From: Michael Ellerman <michael@ellerman.id.au>
To: benh@kernel.crashing.org
In-Reply-To: <1192620990.11899.168.camel@pasglop>
References: <8f76815cbbaf5fbab82c843d87bc0dafab038c80.1192605144.git.michael@ellerman.id.au>
	<dadd2b9540369b9e2c6773b2a60021dadafa58e2.1192605144.git.michael@ellerman.id.au>
	<20071017.042229.95059231.davem@davemloft.net>
	<1192620990.11899.168.camel@pasglop>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-qVfGuUczvUzJNshmSk5F"
Date: Thu, 18 Oct 2007 11:30:04 +1000
Message-Id: <1192671004.6681.12.camel@concordia>
Mime-Version: 1.0
Cc: sparclinux@vger.kernel.org, sfr@canb.auug.org.au, paulus@samba.org,
	David Miller <davem@davemloft.net>, linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-qVfGuUczvUzJNshmSk5F
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-10-17 at 21:36 +1000, Benjamin Herrenschmidt wrote:
> > I find it ironic that you add of_get_pci_dev_node() as a function
> > which gets the node and grabs a reference to it, and then the very
> > first usage you make of it doesn't drop the reference at all.
> >=20
> > That reference grabbing aspect of the new interface is obviously very
> > useful! :-)
> >=20
> > Kidding aside (I realize that in this case probably the driver never
> > unregisters and therefore the reference never needs to be released)
> > it's really much nicer to add facilities when you have patches in hand
> > that actually use them.
>=20
> I think in this case, it's mostly a matter of consistency... pretty much
> everything that returns a device_node grabs a reference... except
> pci_device_to_OF_node :-)

Yeah, it's a matter of the API being error-prone in that most routines
take a reference for you, but this one doesn't.

> I think Michael is trying to address that, and axon-msi happens to be
> something he wrote so a good candidate for an initial conversion :-)

Yep, I wanted at least one user in tree with the patch. I plan to
convert other pci_device_to_OF_node() users to use the refcounted
version over time.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-qVfGuUczvUzJNshmSk5F
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHFrccdSjSd0sB4dIRAjQ4AJwJ+es+FSw3tUvjxaXnJ0WURUj4jgCghbRT
POh80vZyaDEWmYAJZbyebKc=
=et5A
-----END PGP SIGNATURE-----

--=-qVfGuUczvUzJNshmSk5F--
