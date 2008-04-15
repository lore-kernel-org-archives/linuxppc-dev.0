Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 2BF04DE70C
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 23:47:47 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: avorontsov@ru.mvista.com
Subject: Re: [RFC] GPIO-based flow control in the cpm_uart driver
Date: Tue, 15 Apr 2008 15:47:41 +0200
References: <200804151522.36884.laurentp@cse-semaphore.com>
	<20080415134007.GA17096@polina.dev.rtsoft.ru>
In-Reply-To: <20080415134007.GA17096@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1426267.NO3xMiibEg";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200804151547.44052.laurentp@cse-semaphore.com>
Cc: David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1426267.NO3xMiibEg
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 15 April 2008 15:40, Anton Vorontsov wrote:
> On Tue, Apr 15, 2008 at 03:22:33PM +0200, Laurent Pinchart wrote:
> > Hi everybody,
> >=20
> > I'm implementing flow control and modem control lines support in the
> > cpm_uart driver.
> >=20
> > The implementation is based on the GPIO lib. Modem control lines are
> > described in the device tree as GPIO resources and accessed through the=
 OF
> > GPIO bindings. The I/O ports have to be initialized as GPIOs in the=20
> > platform-specific code.
> >=20
> > Reading and writing the modem control lines isn't an issue, but activat=
ing=20
> > hardware flow control is more complex. The driver needs to turn dedicat=
ed=20
> > functions on and off for the RTS and CTS signals, and the GPIO API does=
n't=20
> > provide a way to access the PPAR* registers (which does make sense -
> > although arguably - as PPAR* control specific functions, not GPIOs).
> >=20
> > Hardcoding RTS and CTS lines control in the driver is not an option I w=
ant
> > to consider. Extending the GPIO API to handled special functions has be=
en
> > nacked in the past (see=20
> > http://ozlabs.org/pipermail/linuxppc-dev/2008-February/051241.html). An=
=20
> > option would be to export gpio_to_chip from drivers/gpio/gpiolib.c and =
use=20
> > cpm1/2_set_pin in the cpm_uart driver.
>=20
> Since you have successfuly ported QE USB controller onto CPM USB
> hardware, now it's obvious that we will need generic gpio_set_dedicated()
> function. So I would rather beg David to accept gpio_set_dedicated()
> approach instead of exporting gpio_to_chip(). That way we'll kill two
> birds with one stone.

Or maybe some kind of gpio_set_option() with flags specific to the=20
controller ? This could be used to enable open-drain outputs or internal=20
pull-ups for instance.

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1426267.NO3xMiibEg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBIBLIA8y9gWxC9vpcRAty8AJsFTgW1Bz/XXsHeyjbNfsGgOTCWCQCgr/Nh
mU3s+kIF8uf10BAvlubfYRY=
=xlAf
-----END PGP SIGNATURE-----

--nextPart1426267.NO3xMiibEg--
