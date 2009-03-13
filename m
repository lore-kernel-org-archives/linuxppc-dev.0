Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay009.isp.belgacom.be (mailrelay009.isp.belgacom.be
	[195.238.6.176]) by ozlabs.org (Postfix) with ESMTP id 51688DE0A6
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Mar 2009 01:38:28 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: "Jean-Michel Hautbois" <jhautbois@gmail.com>
Subject: Re: [MPC8272ADS]Can not configure the ttyCPM0
Date: Fri, 13 Mar 2009 15:38:21 +0100
References: <8cad0aa0903130638w6fab6299kcd23d92d4c2d0a8@mail.gmail.com>
	<200903131500.51446.laurentp@cse-semaphore.com>
	<8cad0aa0903130720r25e8b7c1u3f762d9560535f5e@mail.gmail.com>
In-Reply-To: <8cad0aa0903130720r25e8b7c1u3f762d9560535f5e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart95156517.r4b3C41ECo";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200903131538.24235.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart95156517.r4b3C41ECo
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Jean-Michel,

On Friday 13 March 2009 15:20:24 Jean-Michel Hautbois wrote:
> 2009/3/13 Laurent Pinchart <laurentp@cse-semaphore.com>:
> > Support for the modem control lines has been added in v2.6.27-rc2. You
> > will need to declare the modem control lines in your device tree. See
> > Documentation/powerpc/dts-bindings/fsl/cpm_qe/serial.txt for more
> > information.
> >
> > Please note that hardware flow control is not supported by the CPM UART
> > driver yet.
>
> OK, this is not easy, to modify...
> My DTS already contains a configuration for the CPM1 port...
>
> 			serial@11a00 {
> 				device_type =3D "serial";
> 				compatible =3D "fsl,mpc8272-scc-uart",
> 				             "fsl,cpm2-scc-uart";
> 				reg =3D <0x11a00 0x20 0x8000 0x100>;
> 				interrupts =3D <40 8>;
> 				interrupt-parent =3D <&PIC>;
> 				fsl,cpm-brg =3D <1>;
> 				fsl,cpm-command =3D <0x800000>;
> 			};
>
> 			serial@11a60 {
> 				device_type =3D "serial";
> 				compatible =3D "fsl,mpc8272-scc-uart",
> 				             "fsl,cpm2-scc-uart";
> 				reg =3D <0x11a60 0x20 0x8300 0x100>;
> 				interrupts =3D <43 8>;
> 				interrupt-parent =3D <&PIC>;
> 				fsl,cpm-brg =3D <4>;
> 				fsl,cpm-command =3D <0xce0000>;
> 			};
>
> I can't see what I have to do...
> This is not obvious ;).

Here are excerpts of my device tree for an MPC8248 based platform.

You need to declare GPIO controllers for the pins used by modem control lin=
es

        cpm2_pio_c: gpio_controller@10d40 {
                compatible =3D "fsl,mpc8248-pario-bank",
                             "fsl,cpm2-pario-bank";
                reg =3D <0x10d40 0x14>;
                #gpio-cells =3D <2>;
                gpio-controller;
        };

        cpm2_pio_d: gpio_controller@10d60 {
                compatible =3D "fsl,mpc8248-pario-bank",
                             "fsl,cpm2-pario-bank";
                reg =3D <0x10d60 0x14>;
                #gpio-cells =3D <2>;
                gpio-controller;
        };

and add the GPIO mapping in your serial port controller nodes

        gpios =3D <&cpm2_pio_c 15 0       /* CTS */
                 &cpm2_pio_d 29 0       /* RTS */
                 &cpm2_pio_c 14 0       /* DCD */
                 0                      /* DSR */
                 &cpm2_pio_d 20 0       /* DTR */
                 &cpm2_pio_c 8 0        /* RI */
                >;

Don't forget to configure the pins (direction, special purpose, ...) in you=
r=20
board-specific code.

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Waterloo Office Park
Building M
Dreve Richelle, 161
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart95156517.r4b3C41ECo
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkm6b90ACgkQlyYWY4YEWhVXpACfbmQxHvI4S4PiUF8I8t3Lzlwy
95MAnRl4lT3Mtmes8IjNgPXA4FGHGYXj
=gfK+
-----END PGP SIGNATURE-----

--nextPart95156517.r4b3C41ECo--
