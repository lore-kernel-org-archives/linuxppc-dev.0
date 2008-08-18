Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 8E5A4DDE23
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Aug 2008 23:58:53 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 1/3] gpiolib: make gpio_to_chip() public
Date: Mon, 18 Aug 2008 15:58:46 +0200
References: <20080808161717.GA19095@polina.dev.rtsoft.ru>
	<200808141645.56418.laurentp@cse-semaphore.com>
	<20080814151022.GA9885@oksana.dev.rtsoft.ru>
In-Reply-To: <20080814151022.GA9885@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3105426.osWGJr2e3v";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200808181558.50182.laurentp@cse-semaphore.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Greg Kroah-Hartman <greg@kroah.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Li Yang <leoli@freescale.com>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart3105426.osWGJr2e3v
Content-Type: text/plain;
  charset="windows-1251"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 14 August 2008, Anton Vorontsov wrote:
> On Thu, Aug 14, 2008 at 04:45:52PM +0200, Laurent Pinchart wrote:
> > On Thursday 14 August 2008, Anton Vorontsov wrote:
> > > On Thu, Aug 14, 2008 at 04:04:18PM +0200, Laurent Pinchart wrote:
> > > > On Friday 08 August 2008, Anton Vorontsov wrote:
> > > > > We'll need this function to write platform-specific hooks to deal
> > > > > with pin's dedicated functions. Quite obviously this will work on=
ly
> > > > > for the platforms with 1-to-1 GPIO to PIN mapping.
> > > > >=20
> > > > > This is stopgap solution till we think out and implement a proper
> > > > > api (pinlib?).
> > > >=20
> > > > How do you support reverting the GPIO mode to non-dedicated ?
> > >=20
> > > As we always do with the GPIO API: gpio_direction_*() calls.
> >=20
> > So the proper sequence to configure a pin in dedicated mode is to set
> > the direction first (which will unset the dedicated mode bit) and
> > then set dedicated mode (which will not touch the direction bit) ?
>=20
> Not exactly. But you can do this way, if you need to preserve
> a direction. What I did is a bit different though.
>=20
> qe_gpio_set_dedicated() actually just restores a mode that
> firmware had set up, including direction (since direction could
> be a part of dedicated configuration).
>=20
> That is, upon GPIO controller registration, we save all registers,
> then driver can set up a pin to a GPIO mode via standard API, and
> then it can _revert_ a pin to a dedicated function via
> qe_gpio_set_dedicated() call. Dedicated function is specified by
> the firmware (or board file), we're just restoring it.

The semantic of the set_dedicated() operation needs to be clearly defined t=
hen. I can live with this behaviour, but it might not be acceptable for eve=
rybody.

Your patch requires the firmware to set a pin in dedicated mode at bootup i=
n order to be used later in dedicated mode. If, for some reason (driver not=
 loaded, ...), no GPIO user shows up for that pin, it will stay configured =
in dedicated mode.

It might be better to set the PAR bit unconditionally in qe_gpio_set_dedica=
ted() instead of restoring its value. That way the board initialization cod=
e could just set the DIR, DAT and ODR bits for dedicated mode but still con=
figure the pin in GPIO mode.

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart3105426.osWGJr2e3v
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkipgBoACgkQ8y9gWxC9vpfmpgCgjNoAGz/p1jHRy6lH0yrkZ5yv
uEMAoJiZTrd8YuNdarcqL1eZHQ4m1QUT
=zCu0
-----END PGP SIGNATURE-----

--nextPart3105426.osWGJr2e3v--
