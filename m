Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 6590ADDDF3
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Apr 2008 22:13:50 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] Freescale QUICC Engine USB Host Controller
Date: Wed, 9 Apr 2008 14:13:44 +0200
References: <20080311191744.GA10518@localhost.localdomain>
	<200804071811.19671.laurentp@cse-semaphore.com>
	<20080408121630.GB26716@polina.dev.rtsoft.ru>
In-Reply-To: <20080408121630.GB26716@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3951675.EkJ9kaEU2q";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200804091413.46592.laurentp@cse-semaphore.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	linux-usb@vger.kernel.org, David Brownell <david-b@pacbell.net>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart3951675.EkJ9kaEU2q
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 08 April 2008 14:16, Anton Vorontsov wrote:
> On Mon, Apr 07, 2008 at 06:11:15PM +0200, Laurent Pinchart wrote:
> [...]
> > I had a first go at hacking the FHCI driver to make it run on a CPM2
> > platform. Results so far are quite good. After getting rid of qe-specif=
ic
> > APIs as explained above, and adding SOF token generation support, I've
> > been able to access a mass storage device. The driver hasn't been
> > stress-tested yet though.
>=20
> Wow, awesome! That's great news, really. Looking forward for the patch. :=
=2D)

The current version of the code is CPM2-specific and won't work on QE-based=
=20
platforms. Should I still post it ?

> > I ran into an issue with IDLE and RESET interrupts. When the device is
> > first plugged into the USB port, the idle interrupt kicks in and the
> > driver detects the device properly. When the device is then removed, the
> > reset interrupt is generated and the driver handles device removal
> > properly. Right after the reset interrupt, idle interrupts are generated
> > every milliseconds for around 175ms. The status register always reports=
 a
> > non-idle condition when read in the interrupt handler. The flow of idle
> > interrupts then stops, and no idle interrupt is generated when I replug
> > the device. I've checked the interrupts mask register to make sure idle
> > interrupts were enabled.=20
> >=20
> > Have you noticed a similar behaviour when you tested the driver on your=
=20
> > QE-based platform ? I suspected a debouncing issue, but I should then g=
et=20
> > idle conditions once every other time when reading the status register.
>=20
> Hm.. nope, I didn't see anything like that, at least not something that
> is affecting the driver functionality. Did out_be16(tmr->gtevr, 0xFFFF);
> help there? Or it's different problem?

No it didn't, it's a completely different problem.

The IDLE interrupts I see every millisecond for around 175ms after=20
disconnecting the device are probably due to the SOF tokens sent between=20
device disconnection and the fhci_stop_sof_timer() call. Calling=20
fhci_stop_sof_timer() in device_disconnected_interrupt() prevents spurious=
=20
idle interrupts from being generated.

After further investigation I found out why no idle interrupt were generate=
d=20
when replugging the device. Upon disconnection the FHCI driver turns bus=20
power off by setting the suspend GPIO pin high. As the signal is connected =
to=20
the suspend input of the USB phy on my hardware, setting the signal high=20
turned the phy off, disconnecting the RP and RN signals completely.

I solved the issue by referencing the bus power control GPIO instead of the=
=20
suspend GPIO in the device tree. GPIO_SUSPN should really be renamed=20
GPIO_POWER.

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart3951675.EkJ9kaEU2q
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH/LL68y9gWxC9vpcRAjHMAJwKql1tZCe5bAlfoHzKy1UU+LkipwCffuhH
DgAiT10wPANi9WU8suB9898=
=DRjY
-----END PGP SIGNATURE-----

--nextPart3951675.EkJ9kaEU2q--
