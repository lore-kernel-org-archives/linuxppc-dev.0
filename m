Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0179EB7D2B
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Mar 2010 19:29:03 +1100 (EST)
Date: Tue, 2 Mar 2010 09:28:58 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Albrecht =?utf-8?B?RHJl77+9?= <albrecht.dress@arcor.de>
Subject: Re: [Patch] mpc5200b: improve baud rate calculation (reach high
	baud rates, better accuracy)
Message-ID: <20100302082858.GA4087@pengutronix.de>
References: <14429243.1267517383754.JavaMail.ngmail@webmail14.arcor-online.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
In-Reply-To: <14429243.1267517383754.JavaMail.ngmail@webmail14.arcor-online.net>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> [snip]
> > > +	if (is_mpc5200b =3D=3D 1)
> > > +		return mpc5xxx_get_bus_frequency(p) * 4;
> > > +	else
> > > +		return mpc5xxx_get_bus_frequency(p) / 2;
> >=20
> > Isn't this wrong? You can also have /32 on the 5200B (the fallback).
>=20
> Yes, but I do all /calculations/ with the /4 prescaler for higher accurac=
y.
> If the divisor exceeds the available 16 bits of the counter reg, I round
> (divisor / 8) to use the /32 prescaler.  Think of a 19-bit counter value,
> where I can choose to use either the lower or the higher 16 bits for the
> counter reg.

Okay, now I got it. (Maybe this is an indication for another comment above =
the
set divisor function?)

> Remember also that using the higher 16 bits (/32 prescaler) is
> probably the exceptional case - with an IPB frequency of 132 MHz this will
> happen only for standard baud rates B300 and slower.

Even the rare cases have to be correct ;)

> [snip]
> > > +	/* Check only once if we are running on a mpc5200b or not */
> > > +	if (is_mpc5200b =3D=3D -1) {
> > > +		struct device_node *np;
> > > +
> > > +		np =3D of_find_compatible_node(NULL, NULL, "fsl,mpc5200b-immr");
> >=20
> > This should be handled using a new compatible-entry
> > "fsl,mpc5200b-psc-uart".
>=20

> I agree that this would be a lot cleaner, but it's also a lot more intrus=
ive.
> CC'ing the device tree discussion list here... comments, please!!

Why intrusive? Maybe I miss something?

> > You could also have a set_divisor-function for 5200 and 5200B and set it
> > here in the function struct (one reason less for the static ;))
>=20
> Hmmm, but then I would need a 'static struct psc_ops mpc5200b_psc_ops', w=
here
> only two functions differ from the generic 52xx struct as it is implement=
ed
> now.  Using the static int needs less space.  However, in combination with
> the new compatible entry, it would of course make sense.

Leave those two function pointers empty and fill them during probe (probe h=
as
access to the compatible-property it was matched against, see its arguments=
).
So it should be a matter of:

if (matched_property =3D=3D 5200b)
	ops->func =3D this_one;
else
	ops->func =3D that_one;

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkuMzEoACgkQD27XaX1/VRujoQCaAhQJPBwyb5ztRdlE77yuL3CG
zW0An17wFYpzEXjygA3zUuSQw+NnwAqx
=pPK0
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
