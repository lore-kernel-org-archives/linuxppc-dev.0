Return-Path: <michael@ellerman.id.au>
Subject: Re: of_serial and device trees
From: Michael Ellerman <michael@ellerman.id.au>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <49CA5E45.9070300@freescale.com>
References: <20090324094959.447a3a31@seasc0532.dyn.rnd.as.sw.ericsson.se>
	<20090324155545.GA24778@ld0162-tx32.am.freescale.net>
	<20090325155113.52048fe0@seasc0532.dyn.rnd.as.sw.ericsson.se>
	<49CA5E45.9070300@freescale.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-fsPoyQMlGlrliEZyl03H"
Date: Thu, 26 Mar 2009 11:53:39 +1100
Message-Id: <1238028819.20679.25.camel@localhost>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Simon Kagstrom <simon.kagstrom@ericsson.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-fsPoyQMlGlrliEZyl03H
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-03-25 at 11:39 -0500, Scott Wood wrote:
> Simon Kagstrom wrote:
> > There are no other versions yet, but I suppose there will be (it's
> > implemented in a FPGA after all!). So what is the general handling of
> > versions, should it be something like
> >=20
> >   compatible =3D "ericsson,isf-pic", "ericsson,isf-pic-v2"
> >=20
> > etc if we'd make new revisions of the device?
>=20
> Looks good.
>=20
> >> I'm guessing that your FPGA PIC driver isn't getting its register addr=
ess
> >> from the device tree, given that it works without the ranges property?
> >=20
> > It is, but I didn't check it for correctness yet, so I suppose I might
> > have mapped the wrong thing. The code looks like this:
> >=20
> >         struct resource phys_addr;
> >=20
> >         if (of_address_to_resource(np, 0, &phys_addr) !=3D 0) {
> >                  printk(KERN_ERR": Could not get ISF PIC memory resourc=
e\n");
> >                  return NULL;
> >          }
> >=20
> > 	spin_lock_init(&isf->lock);
> > 	isf->ioaddr =3D ioremap(phys_addr.start,
> > 	                phys_addr.end - phys_addr.start);
>=20
> That looks good -- I'd have expected of_address_to_resource to fail,=20
> though, when the ranges property was missing.  The kernel's device tree=20
> parsing code can sometimes be overly tolerant of broken device trees,=20
> which is probably what happened.

It assumes a missing ranges =3D=3D empty ranges, which means 1:1. See the
comment in of_translate_one(). And thank Apple ;)

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-fsPoyQMlGlrliEZyl03H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAknK0hMACgkQdSjSd0sB4dL1TgCdHBHbEIOAYEnPm2krg5jobZWK
Ds0AoKhCJORuv6clTxuuE1JX5AxBu79O
=Z5b1
-----END PGP SIGNATURE-----

--=-fsPoyQMlGlrliEZyl03H--
