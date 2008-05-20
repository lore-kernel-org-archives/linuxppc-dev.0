Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 44F63DDFC1
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 22:50:20 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] GPIO-based flow control in the cpm_uart driver
Date: Tue, 20 May 2008 14:50:14 +0200
References: <200804151522.36884.laurentp@cse-semaphore.com>
	<200805191725.16768.david-b@pacbell.net>
In-Reply-To: <200805191725.16768.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4029071.BqRF3j3TXW";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200805201450.17221.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart4029071.BqRF3j3TXW
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi David,

On Tuesday 20 May 2008 02:25, David Brownell wrote:
> On Tuesday 15 April 2008, Laurent Pinchart wrote:
> > I'm implementing flow control and modem control lines support in the
> > cpm_uart driver.
> >
> > The implementation is based on the GPIO lib. Modem control lines are
> > described in the device tree as GPIO resources and accessed through the=
 OF
> > GPIO bindings. The I/O ports have to be initialized as GPIOs in the
> > platform-specific code.
>=20
> I don't follow the "have to be" ... why couldn't the platform
> setup code know that if a given UART is being used with hardware
> handshaking, that means a particular pin mux config should be used?

=46low control and modem control lines are two different beasts (although f=
low=20
control uses a subset of the modem control lines).

The UART driver needs to get and set the modem control lines state. This is=
=20
easily handled by the GPIO library without requiring any change to GPIO lib=
=2E=20
The only requirement, as stated above, is that platform-specific code=20
initializes the corresponding pins as GPIOs. I'm not sure to understand wha=
t=20
you don't get, as my point is that the platform setup code must configure t=
he=20
pins appropriately, exactly as you mention in your comment.

> Are there maybe some on-chip routing options, so that for example
> RTS2 could come out on any of three different balls?  (In which
> case that setup code could just be told *which* config to use...)

That's possible yes, but that's not really an issue. Platform setup code is=
 by=20
definition platform-specific and has knowledge of the hardware, so it can=20
setup pins correctly.

> In this case I'm asking specifically about the normal all-works-ok
> situation ... no errata or similar complications I mention below.
>=20
> >  An option would be to export gpio_to_chip from drivers/gpio/gpiolib.c
> >  and use cpm1/2_set_pin in the cpm_uart driver.
>=20
> Help me to understand this a bit.  UARTs are a fair example of places
> where I've seen such pin reconfiguration be useful, but it's never
> seemed to be generalizable except possibly as callbacks to SOC-specific
> code (which don't imply updating generic programming interfaces).

Callbacks worked fine on ppc but are now more difficult to implement in=20
powerpc. This is why I'm looking for a generic solution based on the device=
=20
tree.

> I've seen examples where the hardware flow control normally works, so
> that board setup sets up those pins in "hardware flow control" mode
> when it's told the board has them wired up that way ... but then, some
> chip revisions have errata forcing the driver to use a particular
> port's handshake pins as GPIOs in some cases.  (Obviously troublesome
> except at low data rates, so one hopes the board designers just avoid
> using those UARTs in that mode.)

The issue is that flow control must be configurable. Userspace software can=
=20
turn it on or off. To handle that on CPM2-based platforms, the pins connect=
ed=20
to CTS and RTS must be switched between GPIO mode (no flow control) and=20
dedicated function mode (hard flow control) at runtime in the UART driver.

> I've also seen examples where the UART clock needs to be disabled in
> deeper sleep states, but the system still wants the UART to be a wake
> event source ... by having either the START bit, or maybe BREAK (it
> gives a longer latch period), kick in a gpio-based pin change IRQ on
> the UARTn.RX line.
>=20
> Now in *both* of those examples I've seen before, the solution could
> not be generic.  When the pin was used as GPIO, a particular pinmux
> configuration was needed.  (Bitfield X of register Y has value Z ...
> or maybe a couple registers needed to change.)  And when used as a
> UART signal, a different one was used.  (Same setup.  Maybe value Z
> became value W.  Or again, maybe a few registers needed changing.)
>=20
> And for different chips in the family, sometimes even different
> revisions of one chip, the W/X/Y/Z/etc values differed even for UART1.
> For other UARTs, the same was true.
>=20
> So given that ... how would knowing the GPIO chip help, when I'd
> still need to find out the W/X/Y/Z/etc values?  And if I've got a
> way to convey W/X/Y/Z/etc -- canonical example being a callback to
> the relevant SOC-specific code --  why shouldn't that obviate the
> need for any scheme to look up the gpio chip?

On Freescale PowerPC hardware (specifically CPM2-based, but CPM1 and QE are=
=20
quite similar), pins can either have a dedicated functionality or be used a=
s=20
a GPIO. This is handled through a group of registers, which are

=2D the data register, used in GPIO mode only
=2D the direction register, used in both GPIO and dedicated modes
=2D the pin assignment register, used to switch between GPIO and dedicated =
mode
=2D the open-drain register, used to switch between push-pull and open drai=
n=20
configurations

Let's take the UART CTS signal as an example, connected to port C, pin 15. =
The=20
pin is always a push-pull output, so that configuration can be set in=20
platform setup code. Let's assume that hard flow control is disabled as=20
startup, so platform setup code configures PC15 as a GPIO (pin assignment=20
register cleared).

The data register can then be used to set or clear CTS in response to the=20
TIOCMSET ioctl. The UART driver just calls gpio_set_value() and everybody i=
s=20
happy.

Now, when enabling hard flow control, the CTS pin has to be switched to=20
dedicated mode. The GPIO lib has no API for that, and abstract GPIO numbers=
=20
can't be mapped to platform-specific pins as there is no API for that.

To switch hard flow control on and off, the UART driver will need either an=
=20
extension to the GPIO API to set and clear the pin assignment register, or =
a=20
way to retrieve a reference to the GPIO chip to call platform-specific GPIO=
=20
functions, not exported through the generic GPIO API.

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart4029071.BqRF3j3TXW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBIMskJ8y9gWxC9vpcRAsWbAJ0SpH2Iv8KXePDYZznBaj4FZqFI1QCeJKMP
Jse/SoSAz63+zZqrFX/4KiA=
=OPFQ
-----END PGP SIGNATURE-----

--nextPart4029071.BqRF3j3TXW--
