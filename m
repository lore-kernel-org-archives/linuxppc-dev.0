Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id BF6A9DDF45
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 19:15:42 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org,
 avorontsov@ru.mvista.com
Subject: Re: [RFC POWERPC] booting-without-of: bindings for FHCI USB, GPIO LEDs,
	MCU, and NAND on UPM
Date: Wed, 23 Apr 2008 11:15:35 +0200
References: <20080422194135.GA27822@polina.dev.rtsoft.ru>
In-Reply-To: <20080422194135.GA27822@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1247358.4FznQWRhra";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200804231115.39126.laurentp@cse-semaphore.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1247358.4FznQWRhra
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Anton,

On Tuesday 22 April 2008 21:41, Anton Vorontsov wrote:
> Hi all,
>=20
> Here is purposed bindings draft for the new drivers that I would like to
> send for this or next merge window, depending on results of this RFC. ;-)
> (The new bindings needs to be in-tree or at least Acked before I could
> send the drivers.)
>=20
> Comments and suggestions are highly appreciated.
>=20
> Thanks.
>=20
> diff --git a/Documentation/powerpc/booting-without-of.txt=20
b/Documentation/powerpc/booting-without-of.txt
> index c350623..38fe3e9 100644
> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
> @@ -59,6 +59,11 @@ Table of Contents
>        p) Freescale Synchronous Serial Interface
>        q) USB EHCI controllers
>        r) Freescale General-purpose Timers Module
> +      s) Freescale USB Parameter RAM:
> +      t) Freescale QUICC Engine USB Controller
> +      u) LEDs on GPIOs
> +      v) Freescale MCU with MPC8349E-mITX compatible firmware
> +      w) NAND on UPM-driven Freescale Localbus
> =20
>    VII - Marvell Discovery mv64[345]6x System Controller chips
>      1) The /system-controller node
> @@ -2866,6 +2871,139 @@ platforms are moved over to use the=20
flattened-device-tree model.
>      	clock-frequency =3D <0>;
>      };
> =20
> +    s) Freescale USB Parameter RAM:
> +
> +    Required properties:
> +      - compatible : should be "fsl,<chip>-qe-muram-usb-pram",
> +        "fsl,qe-muram-usb-pram", "fsl,cpm-muram-usb-pram".
> +      - reg : should contain USB PRAM location and length.
> +
> +    Example:
> +
> +	usb-pram@8b00 {
> +		compatible =3D "fsl,mpc8360-qe-muram-usb-pram",
> +			     "fsl,qe-muram-usb-pram",
> +			     "fsl,cpm-muram-usb-pram";
> +		reg =3D <0x8b00 0x100>;
> +	};
> +
> +    t) Freescale QUICC Engine USB Controller
> +
> +    Required properties:
> +      - compatible : should be "fsl,<chip>-qe-usb", "fsl,qe-usb",
> +        "fsl,usb-fhci"
> +      - reg : should contain gtm registers location and length.
> +      - interrupts : should contain USB interrupt.
> +      - interrupt-parent : interrupt source phandle.
> +      - fsl,fullspeed-clock : specifies the full speed USB clock source.
> +      - fsl,lowspeed-clock : specifies the low speed USB clock source.
> +      - fsl,usb-mode : should be "host".
> +      - linux,hub-power-budget : optional, USB power budget for the root=
=20
hub
> +        in mA.
> +      - gpios : should specify GPIOs in this order: USBOE, USBTP, USBTN,=
=20
USBRP,
> +        USBRN, SPEED (optional), and SUSPEND (optional).

Suspend should in my opinion be renamed power (or bus power or anything=20
similar), as it controls the USB power and not USB PHY sleep mode.

> +    Example:
> +
> +	usb@6c0 {
> +		compatible =3D "fsl,mpc8360-qe-usb", "fsl,qe-usb",
> +			     "fsl,usb-fhci";
> +		reg =3D <0x6c0 0x40>;
> +		interrupts =3D <11>;
> +		interrupt-parent =3D <&qeic>;
> +		fsl,fullspeed-clock =3D "clk21";
> +		fsl,usb-mode =3D "host";
> +		gpios =3D <&qe_pio_b  2 0 /* USBOE */
> +			 &qe_pio_b  3 0 /* USBTP */
> +			 &qe_pio_b  8 0 /* USBTN */
> +			 &qe_pio_b  9 0 /* USBRP */
> +			 &qe_pio_b 11 0 /* USBRN */
> +			 &qe_pio_e 20 0 /* SPEED */
> +			 &qe_pio_e 21 0 /* SUSPN */>;
> +	};
> +
> +    u) LEDs on GPIOs
> +
> +    Required properties:
> +      - compatible : should be "linux,gpio-led".
> +      - linux,name : LED name.
> +      - linux,active-low : property should be present if LED wired as
> +        active-low.

Just thinking out loud, wasn't the third GPIO cell supposed to be used to=20
encode such properties ?

> +      - linux,default-trigger : Linux default trigger for this LED.
> +      - linux,brightness : default brightness.
> +      - gpios : should specify LED GPIO.
> +
> +    Example:
> +
> +	led@0 {
> +		compatible =3D "linux,gpio-led";
> +		linux,name =3D "pwr";
> +		linux,brightness =3D <1>;
> +		linux,active-low;
> +		gpios =3D <&mcu_pio 0>;
> +	};
> +
> +	led@1 {
> +	        compatible =3D "linux,gpio-led";
> +	        linux,name =3D "hdd";
> +	        linux,default-trigger =3D "ide-disk";
> +		linux,active-low;
> +		gpios =3D <&mcu_pio 1>;
> +	};

[snip]

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1247358.4FznQWRhra
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBIDv478y9gWxC9vpcRArWiAKCFQF5iXEd/bA/KUSRnXMpYb/1g7wCfTLOe
hxaO0s2NTCVcTERSm9Sfwy0=
=gkHz
-----END PGP SIGNATURE-----

--nextPart1247358.4FznQWRhra--
