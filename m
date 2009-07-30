Return-Path: <solomon@linux-wlan.com>
Received: from cdptpa-omtalb.mail.rr.com (cdptpa-omtalb.mail.rr.com
	[75.180.132.121])
	by bilbo.ozlabs.org (Postfix) with ESMTP id E48C3B7BC7
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 31 Jul 2009 05:50:21 +1000 (EST)
Date: Thu, 30 Jul 2009 15:45:06 -0400
From: Solomon Peachy <solomon@linux-wlan.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] Add support for the ESTeem 195E (PPC405EP) SBC
Message-ID: <20090730194506.GA30066@linux-wlan.com>
References: <1248448916-29473-1-git-send-email-solomon@linux-wlan.com>
	<20090730140630.GD10244@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
In-Reply-To: <20090730140630.GD10244@zod.rchland.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2009 at 10:06:30AM -0400, Josh Boyer wrote:
> >+		devp =3D finddevice("/plb/opb/serial@ef600300");
> >+		if (!devp)
> >+			fatal("Can't find node for /plb/opb/serial@ef600300");
> >+		del_node(devp);
>=20
> Slightly confused here.  You delete the first serial node in the single e=
th
> case?

The board is actually single eth/serial or dual eth/serial. And strictly=20
speaking, this serial port is the second one in the devicetree...

(The PPC405EP's serial boards aren't created equally; the first is a=20
 dumb tx/rx-only port while the second has a full set of signals.
 The hotfoot is wired such that the second, full-featured port is the=20
 primary/console/boot port)

> >+
> >+		devp =3D finddevice("/plb/opb/ethernet@ef600900");
> >+		if (!devp)
> >+			fatal("Can't find node for /plb/opb/ethernet@ef600900");
> >+		del_node(devp);
> >+	}
> >+
> >+	ibm4xx_quiesce_eth((u32 *)0xef600800, (u32 *)0xef600900);
>=20
> Shouldn't you do the quiesce conditionally if the other eth port doesn't
> exist?

I don't know if this is strictly necessary with the modern ibm_emac=20
driver, but it's certainly safe to call because all 405EPs have dual=20
ethernet controllers.

=46rom the (pre-dts) driver perspecive, the only way to tell if the=20
hotfoot had one ethernet port or two was that the second PHY failed to=20
initialize.

Additionally, the production bootloader (u-boot 1.2.0.x) isn't terribly=20
smart and tries to drive the second controller if the first one doesn't=20
have a cable plugged in, so it's possible the second controller is=20
running when control is handed over to Linux, even on single ethernet=20
boards.

> >+			UART0: serial@ef600400 {
> >+				device_type =3D "serial";
> >+				compatible =3D "ns16550";
> >+				reg =3D <0xef600400 0x00000008>;
> >+				virtual-reg =3D <0xef600400>;
> >+				clock-frequency =3D <0>; /* Filled in by zImage */
> >+				current-speed =3D <0x9600>;
>=20
> Just a question, but is the baud supposed to be 38400 or 9600?  At first =
glance
> it almost seems like a typo :).

It's supposed to be 38400 baud, hence the explicit 0x in front.  (I lost=20
count of the number of times I saw '38400' listed in various dts=20
files...)
=20
> >+			gpio-leds {
> >+			     compatible =3D "gpio-leds";
> >+			     status {
> >+			     	    label =3D "Status";
> >+			     	    gpios =3D <&GPIO 1 0>;
> >+				    /* linux,default=3Dtrigger =3D ".."; */
> >+			     };
>
> What does that comment mean?

Whoops, it's supposed to read 'linux,default-trigger', but the LEDs are=20
manually twiddled for the time being.  I'd forgotten to strip that out. =20

(see linux/Documentation/powerpc/dts-bindings/gpio/led.txt)

> Ok.  So I'm not really all that thrilled with changes to ppcboot.h. =20
> We try to keep this file as much in-sync with U-Boot as we can.  Did=20
> your HOTFOOT changes get pulled into upstream U-Boot?

Yeah, I thought this may be a problem, but I didn't know a better way to=20
go about this and still maintain compatibility with the many thousands=20
of boards already in the field.  I mean, I could strip out the ppcboot.h=20
changes and maintain that as an out-of-tree patch, but without that=20
patch, the kernel won't boot on in-the-field boards, rendering the=20
upstreaming of support for this board kinda pointless.

I haven't tried to push anything to upstream u-boot, given how ancient=20
the in-production bootloader is.  The guy who originally mangled u-boot=20
for this board did so before the "standard" 405EP dual ethernet layout=20
was added, and never tried to push it upstream.  Any upstream uboot work=20
will take the form of a native dts/fdt port that probably won't use=20
ppcboot.h anyway, which brings us full circle...

 - Solomon
--=20
Solomon Peachy                        solomon@linux-wlan.com
AbsoluteValue Systems                 http://www.linux-wlan.com
721-D North Drive                     +1 (321) 259-0737  (office)
Melbourne, FL 32934                   +1 (321) 259-0286  (fax)

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFKcfhChinxHf95MjYRAtQzAJ9GijsnFqHX7sjSVZTsO+5Dg9SyTACeMtSR
QeLmjHvChAZmKQcg9Nc1tcs=
=qgdL
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
