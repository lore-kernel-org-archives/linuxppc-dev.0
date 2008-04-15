Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 7E036DE4D2
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 23:22:41 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC] GPIO-based flow control in the cpm_uart driver
Date: Tue, 15 Apr 2008 15:22:33 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1250411.JUmcemZJOo";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200804151522.36884.laurentp@cse-semaphore.com>
Cc: David Brownell <david-b@pacbell.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1250411.JUmcemZJOo
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi everybody,

I'm implementing flow control and modem control lines support in the cpm_ua=
rt=20
driver.

The implementation is based on the GPIO lib. Modem control lines are descri=
bed=20
in the device tree as GPIO resources and accessed through the OF GPIO=20
bindings. The I/O ports have to be initialized as GPIOs in the=20
platform-specific code.

Reading and writing the modem control lines isn't an issue, but activating=
=20
hardware flow control is more complex. The driver needs to turn dedicated=20
functions on and off for the RTS and CTS signals, and the GPIO API doesn't=
=20
provide a way to access the PPAR* registers (which does make sense - althou=
gh=20
arguably - as PPAR* control specific functions, not GPIOs).

Hardcoding RTS and CTS lines control in the driver is not an option I want =
to=20
consider. Extending the GPIO API to handled special functions has been nack=
ed=20
in the past (see=20
http://ozlabs.org/pipermail/linuxppc-dev/2008-February/051241.html). An=20
option would be to export gpio_to_chip from drivers/gpio/gpiolib.c and use=
=20
cpm1/2_set_pin in the cpm_uart driver.

Can anyone think of a better solution ?

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1250411.JUmcemZJOo
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBIBKwc8y9gWxC9vpcRAq8oAJ4sQbqf7hJ6YWPqOc4/c9l62iGzlQCg0sNN
XcItBYxHIoy00AsnGtKyttE=
=CJnX
-----END PGP SIGNATURE-----

--nextPart1250411.JUmcemZJOo--
