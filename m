Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 30E40B70A3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  5 Dec 2010 08:16:51 +1100 (EST)
Date: Sat, 4 Dec 2010 22:16:44 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH 1/2] powerpc, 5200: add support for charon board
Message-ID: <20101204211644.GC671@pengutronix.de>
References: <1291450906-22445-1-git-send-email-hs@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dkEUBIird37B8yKS"
In-Reply-To: <1291450906-22445-1-git-send-email-hs@denx.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--dkEUBIird37B8yKS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 04, 2010 at 09:21:46AM +0100, Heiko Schocher wrote:
> - MPC5200
> - serielle console on PSC 1

serial

> - 128MiB RAM
> - 32MiB NOR Flash
> - FEC Ethernet
> - 2 I2C Busses
> - FPGA on CS3 accessed through mtd-ram
> - ATA

although I am not sure we need those details in the commit log

>=20
> Signed-off-by: Heiko Schocher <hs@denx.de>
> ---
> based against 2.6.37-rc4
>=20
> ./scripts/checkpatch.pl 0001-powerpc-5200-add-support-for-charon-board.pa=
tch
> total: 0 errors, 0 warnings, 233 lines checked
>=20
> 0001-powerpc-5200-add-support-for-charon-board.patch has no obvious style=
 problems and is ready for submission.
>=20
>  arch/powerpc/boot/dts/charon.dts             |  226 ++++++++++++++++++++=
++++++
>  arch/powerpc/platforms/52xx/mpc5200_simple.c |    1 +
>  2 files changed, 227 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/charon.dts
>=20
> diff --git a/arch/powerpc/boot/dts/charon.dts b/arch/powerpc/boot/dts/cha=
ron.dts
> new file mode 100644
> index 0000000..768f0cc
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/charon.dts
> @@ -0,0 +1,226 @@
> +/*
> + * TQM5200 board Device Tree Source

Ooops ;) Your board name here, maybe "based on TQM"

> + *
> + * Copyright (C) 2007 Semihalf
> + * Marian Balakowicz <m8@semihalf.com>
> + *
> + * Copyright (C) 2010 DENX Software Engineering GmbH
> + * Heiko Schocher <hs@denx.de>
> + *
> + * This program is free software; you can redistribute  it and/or modify=
 it
> + * under  the terms of  the GNU General  Public License as published by =
the
> + * Free Software Foundation;  either version 2 of the  License, or (at y=
our
> + * option) any later version.
> + */
> +
> +/dts-v1/;
> +
> +/ {
> +	model =3D "anon,charon";
> +	compatible =3D "anon,charon";
> +	#address-cells =3D <1>;
> +	#size-cells =3D <1>;
> +	interrupt-parent =3D <&mpc5200_pic>;
> +
> +	cpus {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		PowerPC,5200@0 {
> +			device_type =3D "cpu";
> +			reg =3D <0>;
> +			d-cache-line-size =3D <32>;
> +			i-cache-line-size =3D <32>;
> +			d-cache-size =3D <0x4000>;	// L1, 16K
> +			i-cache-size =3D <0x4000>;	// L1, 16K
> +			timebase-frequency =3D <0>;	// from bootloader
> +			bus-frequency =3D <0>;		// from bootloader
> +			clock-frequency =3D <0>;		// from bootloader
> +		};
> +	};
> +
> +	memory {
> +		device_type =3D "memory";
> +		reg =3D <0x00000000 0x08000000>;	// 128MB
> +	};
> +
> +	soc5200@f0000000 {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		compatible =3D "fsl,mpc5200-immr";
> +		ranges =3D <0 0xf0000000 0x0000c000>;
> +		reg =3D <0xf0000000 0x00000100>;
> +		bus-frequency =3D <0>;		// from bootloader
> +		system-frequency =3D <0>;		// from bootloader
> +
> +		cdm@200 {
> +			compatible =3D "fsl,mpc5200-cdm";
> +			reg =3D <0x200 0x38>;
> +		};
> +
> +		mpc5200_pic: interrupt-controller@500 {
> +			// 5200 interrupts are encoded into two levels;
> +			interrupt-controller;
> +			#interrupt-cells =3D <3>;
> +			compatible =3D "fsl,mpc5200-pic";
> +			reg =3D <0x500 0x80>;
> +		};
> +
> +		timer@600 {	// General Purpose Timer
> +			compatible =3D "fsl,mpc5200-gpt";
> +			reg =3D <0x600 0x10>;
> +			interrupts =3D <1 9 0>;
> +			fsl,has-wdt;
> +		};
> +
> +		can@900 {
> +			compatible =3D "fsl,mpc5200-mscan";
> +			interrupts =3D <2 17 0>;
> +			reg =3D <0x900 0x80>;
> +		};
> +
> +		can@980 {
> +			compatible =3D "fsl,mpc5200-mscan";
> +			interrupts =3D <2 18 0>;
> +			reg =3D <0x980 0x80>;
> +		};
> +
> +		gpio_simple: gpio@b00 {
> +			compatible =3D "fsl,mpc5200-gpio";
> +			reg =3D <0xb00 0x40>;
> +			interrupts =3D <1 7 0>;
> +			gpio-controller;
> +			#gpio-cells =3D <2>;
> +		};
> +
> +		usb@1000 {
> +			compatible =3D "fsl,mpc5200-ohci","ohci-be";
> +			reg =3D <0x1000 0xff>;
> +			interrupts =3D <2 6 0>;
> +		};
> +
> +		dma-controller@1200 {
> +			device_type =3D "dma-controller";
> +			compatible =3D "fsl,mpc5200-bestcomm";
> +			reg =3D <0x1200 0x80>;
> +			interrupts =3D <3 0 0  3 1 0  3 2 0  3 3 0
> +			              3 4 0  3 5 0  3 6 0  3 7 0
> +			              3 8 0  3 9 0  3 10 0  3 11 0
> +			              3 12 0  3 13 0  3 14 0  3 15 0>;
> +		};
> +
> +		xlb@1f00 {
> +			compatible =3D "fsl,mpc5200-xlb";
> +			reg =3D <0x1f00 0x100>;
> +		};
> +
> +		serial@2000 {		// PSC1
> +			compatible =3D "fsl,mpc5200-psc-uart";
> +			reg =3D <0x2000 0x100>;
> +			interrupts =3D <2 1 0>;
> +		};
> +
> +		serial@2400 {		// PSC3
> +			compatible =3D "fsl,mpc5200-psc-uart";
> +			reg =3D <0x2400 0x100>;
> +			interrupts =3D <2 3 0>;
> +		};
> +
> +		ethernet@3000 {
> +			compatible =3D "fsl,mpc5200-fec";
> +			reg =3D <0x3000 0x400>;
> +			local-mac-address =3D [ 00 00 00 00 00 00 ];
> +			interrupts =3D <2 5 0>;
> +			fixed-link =3D <1 1 100 0 0>;
> +		};
> +
> +		mdio@3000 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			compatible =3D "fsl,mpc5200-mdio";
> +			reg =3D <0x3000 0x400>;       // fec range, since we need to setup fe=
c interrupts
> +			interrupts =3D <2 5 0>;   // these are for "mii command finished", no=
t link changes & co.
> +		};
> +
> +		ata@3a00 {
> +			compatible =3D "fsl,mpc5200-ata";
> +			reg =3D <0x3a00 0x100>;
> +			interrupts =3D <2 7 0>;
> +		};
> +
> +		i2c@3d00 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			compatible =3D "fsl,mpc5200-i2c","fsl-i2c";
> +			reg =3D <0x3d00 0x40>;
> +			interrupts =3D <2 15 0>;
> +		};
> +
> +
> +		i2c@3d40 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			compatible =3D "fsl,mpc5200-i2c","fsl-i2c";
> +			reg =3D <0x3d40 0x40>;
> +			interrupts =3D <2 16 0>;
> +
> +			dtt@28 {
> +				compatible =3D "national,lm80";
> +				reg =3D <0x28>;
> +			};
> +
> +			rtc@68 {
> +				compatible =3D "dallas,ds1374";
> +				reg =3D <0x68>;
> +			};
> +		};
> +
> +		sram@8000 {
> +			compatible =3D "fsl,mpc5200-sram";
> +			reg =3D <0x8000 0x4000>;
> +		};
> +	};
> +
> +	localbus {
> +		compatible =3D "fsl,mpc5200-lpb","simple-bus";
> +		#address-cells =3D <2>;
> +		#size-cells =3D <1>;
> +		ranges =3D <	0 0 0xfc000000 0x02000000
> +				3 0 0xe8000000 0x00080000>;
> +
> +		flash@0,0 {
> +			compatible =3D "cfi-flash";
> +			reg =3D <0 0 0x02000000>;
> +			bank-width =3D <4>;
> +			device-width =3D <2>;
> +			#size-cells =3D <1>;
> +			#address-cells =3D <1>;
> +		};
> +
> +		mram0@3,0 {
> +			compatible =3D "mtd-ram";
> +			reg =3D <3 0x00000 0x80000>;
> +			bank-width =3D <1>;
> +		};
> +	};
> +
> +	pci@f0000d00 {
> +		#interrupt-cells =3D <1>;
> +		#size-cells =3D <2>;
> +		#address-cells =3D <3>;
> +		device_type =3D "pci";
> +		compatible =3D "fsl,mpc5200-pci";
> +		reg =3D <0xf0000d00 0x100>;
> +		interrupt-map-mask =3D <0xf800 0 0 7>;
> +		interrupt-map =3D <0xc000 0 0 1 &mpc5200_pic 0 0 3
> +				 0xc000 0 0 2 &mpc5200_pic 0 0 3
> +				 0xc000 0 0 3 &mpc5200_pic 0 0 3
> +				 0xc000 0 0 4 &mpc5200_pic 0 0 3>;
> +		clock-frequency =3D <0>; // From boot loader
> +		interrupts =3D <2 8 0 2 9 0 2 10 0>;
> +		bus-range =3D <0 0>;
> +		ranges =3D <0x42000000 0 0x80000000 0x80000000 0 0x10000000
> +			  0x02000000 0 0x90000000 0x90000000 0 0x10000000
> +			  0x01000000 0 0x00000000 0xa0000000 0 0x01000000>;
> +	};
> +};
> diff --git a/arch/powerpc/platforms/52xx/mpc5200_simple.c b/arch/powerpc/=
platforms/52xx/mpc5200_simple.c
> index d45be5b..d2e0096 100644
> --- a/arch/powerpc/platforms/52xx/mpc5200_simple.c
> +++ b/arch/powerpc/platforms/52xx/mpc5200_simple.c
> @@ -58,6 +58,7 @@ static char *board[] __initdata =3D {
>  	"promess,motionpro",
>  	"schindler,cm5200",
>  	"tqc,tqm5200",
> +	"anon,charon",

Those are sorted alphabetically

>  	NULL
>  };
> =20
> --=20
> 1.7.2.3
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--dkEUBIird37B8yKS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkz6r7wACgkQD27XaX1/VRtX3wCfe4i7XDMF5+r1HkDXiWvLbxTp
pjIAniYYPg3aDe3QqPmrx/ly8TIv1r3K
=7S/8
-----END PGP SIGNATURE-----

--dkEUBIird37B8yKS--
