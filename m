Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id A424DDDF82
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 02:11:24 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] Freescale QUICC Engine USB Host Controller
Date: Mon, 7 Apr 2008 18:11:15 +0200
References: <20080311191744.GA10518@localhost.localdomain>
	<200804031545.51834.laurentp@cse-semaphore.com>
	<20080403143052.GA5955@polina.dev.rtsoft.ru>
In-Reply-To: <20080403143052.GA5955@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1859770.p1ORIJgooO";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200804071811.19671.laurentp@cse-semaphore.com>
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

--nextPart1859770.p1ORIJgooO
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Anton,

On Thursday 03 April 2008 16:30, Anton Vorontsov wrote:
> On Thu, Apr 03, 2008 at 03:45:47PM +0200, Laurent Pinchart wrote:
> > Hi Anton,
> >=20
> > On Tuesday 11 March 2008 20:17, Anton Vorontsov wrote:
> > > This is patch adds support for the FHCI USB controller, as found in t=
he
> > > Freescale MPC836x and MPC832x processors. It can support Full or Low
> > > speed modes.=20
> > >=20
> > > Quite a lot hardware is doing by itself (SOF generation, CRC generati=
on
> > > and checking), though scheduling and retransmission is on the software
> > > shoulders.
> > >=20
> > > This controller does not integrate the root hub, so this driver also
> > > fakes an one-port hub. External hub is required to support more than
> > > one device.
> >=20
> > Would it be possible to use the driver for CPM2-based devices ?
>=20
> Probably. But no one had tried this yet.
>=20
> > The only difference I found between the CPM2 and QE USB controllers is =
the
> > SOF handling. The QE USB controller increments the frame number itself,
> > while the CPM USB controller requires the host to increment the frame
> > number.=20
> >=20
> > At first sight the driver depends on qe_lib for:
> >=20
> > - muram allocation (qe_muram_alloc/free, qe_muram_offset/addr)
>=20
> Yeah, I already posted a patch to deal with it, see
> http://ozlabs.org/pipermail/linuxppc-dev/2008-March/053249.html
> (btw... Scott, Timur did you have a chance to look into this?)

Hope this will get into 2.6.26. I replaced all occurences of qe_muram_* by=
=20
cpm_muram_* in the driver for now.

> > - GPIO access (qe_gpio_set_dedicated)
>=20
> This is because of David Brownell. ;-) Specifically, unwillingness to
> accept that set_dedicated is portable for some scope of GPIO controllers,
> as well as GPIO users.

Both sides have their arguments. As the FHCI driver is tied to CPM2/QE=20
platforms anyway, a quick-and-dirty workaround is possible. I currently use=
=20
hardcoded cpm2_set_pin calls.

> > - clock routing (qe_clock_source, qe_usb_clock_set)
>=20
> Well, there is Linux CLK API (somewhat similar to GPIO API), but PowerPC
> doesn't use it yet. Neither I can tell if CLK API is suitable for our
> needs, or if it needs to be extended. Quick&dirty workarounds are
> still possible though, but clk api is the right way to go.

The current clock API doesn't seem to handle clock routing, so I'm not sure=
=20
what the best way to handle that is.

> > - QE commands execution (qe_issue_cmd)
>=20
> No proper solution yet.
>=20
> > It shouldn't be too difficult to abstract those operation in a fashion
> > similar to the cpm_uart driver.
>=20
> Yup, but we still have ucc_serial (QE) and cpm_uart (CPM1/2) drivers as
> separate matters though. ;-) I didn't look for the reasons of this split
> but I assume there are and they're strong enough.
>=20
> > Have you already worked on CPM2 support,
>=20
> Nope, I don't have CPM2 board to work on.

I had a first go at hacking the FHCI driver to make it run on a CPM2 platfo=
rm.=20
Results so far are quite good. After getting rid of qe-specific APIs as=20
explained above, and adding SOF token generation support, I've been able to=
=20
access a mass storage device. The driver hasn't been stress-tested yet=20
though.

I ran into an issue with IDLE and RESET interrupts. When the device is firs=
t=20
plugged into the USB port, the idle interrupt kicks in and the driver detec=
ts=20
the device properly. When the device is then removed, the reset interrupt i=
s=20
generated and the driver handles device removal properly. Right after the=20
reset interrupt, idle interrupts are generated every milliseconds for aroun=
d=20
175ms. The status register always reports a non-idle condition when read in=
=20
the interrupt handler. The flow of idle interrupts then stops, and no idle=
=20
interrupt is generated when I replug the device. I've checked the interrupt=
s=20
mask register to make sure idle interrupts were enabled.

Have you noticed a similar behaviour when you tested the driver on your=20
QE-based platform ? I suspected a debouncing issue, but I should then get=20
idle conditions once every other time when reading the status register.

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1859770.p1ORIJgooO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH+ken8y9gWxC9vpcRArihAJ47n41Y8VWtV/RVMqTqvCTQZZqz4QCfWTS7
aN3M1v1Df1HUCnBECimc/+w=
=Dv+k
-----END PGP SIGNATURE-----

--nextPart1859770.p1ORIJgooO--
