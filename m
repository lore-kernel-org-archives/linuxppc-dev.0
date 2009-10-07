Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 818A2B7B84
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Oct 2009 20:49:57 +1100 (EST)
Date: Wed, 7 Oct 2009 11:49:36 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH v3] mpc5200: support for the MAN mpc5200 based board
	mucmc52
Message-ID: <20091007094936.GE3177@pengutronix.de>
References: <4AADF93C.3030604@denx.de> <20090914080322.GA3164@pengutronix.de>
	<fa686aa40909140745u2cf1dba7q8ae2af53c87bd216@mail.gmail.com>
	<4AC9A463.1080903@denx.de> <20091005095340.GA3890@pengutronix.de>
	<4AC9C6AA.6060009@denx.de>
	<fa686aa40910050646p168c2bbfi4b432778827102c9@mail.gmail.com>
	<4ACC37E5.4040804@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h22Fi9ANawrtbNPX"
In-Reply-To: <4ACC37E5.4040804@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--h22Fi9ANawrtbNPX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 07, 2009 at 08:40:37AM +0200, Heiko Schocher wrote:
> - serial Console on PSC1
> - 64MB SDRAM
> - MTD CFI Flash
> - Ethernet FEC
> - IDE support
>=20
> Signed-off-by: Heiko Schocher <hs@denx.de>

Sorry for finding things incrementally, but I think there is still one issue
left. Once this is sorted out, you could add my:

Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

> ---
>=20
> - based on:
>   git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git next
>=20
> - checked with:
> $ ./scripts/checkpatch.pl 0002-mpc5200-support-for-the-MAN-mpc5200-based-=
board-muc.patch
> total: 0 errors, 0 warnings, 361 lines checked
>=20
> 0002-mpc5200-support-for-the-MAN-mpc5200-based-board-muc.patch has no obv=
ious style problems and is ready for submission.
> $
>=20
> changes since v1:
>=20
> - add comments from Grant Likely <grant.likely@secretlab.ca>
>   use mpc5200_defconfig as default configuration, therefore added
>   SIMPLE_GPIO support in it, because this is not selectable as a
>   module.
> - add comments from Wolfram Sang <w.sang@pengutronix.de>
> - rebase against current next
>=20
> changes since v2:
> - add comment from Wolfram Sang
>   remove unofficial binding
>=20
>  arch/powerpc/boot/dts/mucmc52.dts            |  346 ++++++++++++++++++++=
++++++
>  arch/powerpc/configs/mpc5200_defconfig       |    2 +-
>  arch/powerpc/platforms/52xx/mpc5200_simple.c |    1 +
>  3 files changed, 348 insertions(+), 1 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/mucmc52.dts
>=20
> diff --git a/arch/powerpc/boot/dts/mucmc52.dts b/arch/powerpc/boot/dts/mu=
cmc52.dts
> new file mode 100644
> index 0000000..3924811
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/mucmc52.dts
> @@ -0,0 +1,346 @@
> +/*
> + * mucmc52 board Device Tree Source
> + *
> + * Copyright (C) 2009 DENX Software Engineering GmbH
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
> +	model =3D "manroland,mucmc52";
> +	compatible =3D "manroland,mucmc52";
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
> +		reg =3D <0x00000000 0x04000000>;	// 64MB
> +	};
> +
> +	soc5200@f0000000 {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		compatible =3D "fsl,mpc5200-immr",
> +				"fsl,mpc5200b-immr";

You should decide on the latter one only here.

> +		ranges =3D <0 0xf0000000 0x0000c000>;
> +		reg =3D <0xf0000000 0x00000100>;
> +		bus-frequency =3D <0>;		// from bootloader
> +		system-frequency =3D <0>;		// from bootloader
> +
> +		cdm@200 {
> +			compatible =3D "fsl,mpc5200b-cdm","fsl,mpc5200-cdm";
> +			reg =3D <0x200 0x38>;
> +		};
> +
> +		mpc5200_pic: interrupt-controller@500 {
> +			// 5200 interrupts are encoded into two levels;
> +			interrupt-controller;
> +			#interrupt-cells =3D <3>;
> +			compatible =3D "fsl,mpc5200b-pic","fsl,mpc5200-pic";
> +			reg =3D <0x500 0x80>;
> +			interrupts =3D <0 0 3>;
> +		};
> +
> +		gpt0: timer@600 {	// GPT 0 in GPIO mode
> +			compatible =3D "fsl,mpc5200b-gpt-gpio",
> +					"fsl,mpc5200-gpt-gpio";
> +			#gpio-cells =3D <2>;
> +			reg =3D <0x600 0x10>;
> +			interrupts =3D <1 9 0>;
> +			gpio-controller;
> +		};
> +
> +		gpt1: timer@610 {	// GPT 1 in GPIO mode
> +			compatible =3D "fsl,mpc5200b-gpt-gpio",
> +					"fsl,mpc5200-gpt-gpio";
> +			#gpio-cells =3D <2>;
> +			reg =3D <0x610 0x10>;
> +			interrupts =3D <1 10 0>;
> +			gpio-controller;
> +		};
> +
> +		gpt2: timer@620 {	// GPT 2 in GPIO mode
> +			compatible =3D "fsl,mpc5200b-gpt-gpio",
> +					"fsl,mpc5200-gpt-gpio";
> +			#gpio-cells =3D <2>;
> +			reg =3D <0x620 0x10>;
> +			interrupts =3D <1 11 0>;
> +			gpio-controller;
> +		};
> +
> +		gpt3: timer@630 {	// GPT 3 in GPIO mode
> +			compatible =3D "fsl,mpc5200b-gpt-gpio",
> +					"fsl,mpc5200-gpt-gpio";
> +			#gpio-cells =3D <2>;
> +			reg =3D <0x630 0x10>;
> +			interrupts =3D <1 12 0>;
> +			gpio-controller;
> +		};
> +
> +		gpio_simple: gpio@b00 {
> +			compatible =3D "fsl,mpc5200b-gpio","fsl,mpc5200-gpio";
> +			#gpio-cells =3D <2>;
> +			reg =3D <0xb00 0x40>;
> +			interrupts =3D <1 7 0>;
> +			gpio-controller;
> +		};
> +
> +		gpio_wkup: gpio@c00 {
> +			compatible =3D "fsl,mpc5200b-gpio-wkup",
> +					"fsl,mpc5200-gpio-wkup";
> +			#gpio-cells =3D <2>;
> +			reg =3D <0xc00 0x40>;
> +			interrupts =3D <1 8 0 0 3 0>;
> +			gpio-controller;
> +		};
> +
> +		dma-controller@1200 {
> +			device_type =3D "dma-controller";
> +			compatible =3D "fsl,mpc5200b-bestcomm",
> +					"fsl,mpc5200-bestcomm";
> +			reg =3D <0x1200 0x80>;
> +			interrupts =3D <3 0 0  3 1 0  3 2 0  3 3 0
> +			              3 4 0  3 5 0  3 6 0  3 7 0
> +			              3 8 0  3 9 0  3 10 0  3 11 0
> +			              3 12 0  3 13 0  3 14 0  3 15 0>;
> +		};
> +
> +		xlb@1f00 {
> +			compatible =3D "fsl,mpc5200b-xlb","fsl,mpc5200-xlb";
> +			reg =3D <0x1f00 0x100>;
> +		};
> +
> +		serial@2000 {		// PSC1
> +			compatible =3D "fsl,mpc5200b-psc-uart",
> +					"fsl,mpc5200-psc-uart";
> +			reg =3D <0x2000 0x100>;
> +			interrupts =3D <2 1 0>;
> +		};
> +
> +		serial@2200 {		// PSC2
> +			compatible =3D "fsl,mpc5200b-psc-uart",
> +					"fsl,mpc5200-psc-uart";
> +			reg =3D <0x2200 0x100>;
> +			interrupts =3D <2 2 0>;
> +		};
> +
> +		serial@2c00 {		// PSC6
> +			compatible =3D "fsl,mpc5200b-psc-uart",
> +					"fsl,mpc5200-psc-uart";
> +			reg =3D <0x2c00 0x100>;
> +			interrupts =3D <2 6 0>;
> +		};
> +
> +		ethernet@3000 {
> +			compatible =3D "fsl,mpc5200b-fec","fsl,mpc5200-fec";
> +			reg =3D <0x3000 0x400>;
> +			local-mac-address =3D [ 00 00 00 00 00 00 ];
> +			interrupts =3D <2 5 0>;
> +			phy-handle =3D <&phy0>;
> +		};
> +
> +		mdio@3000 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			compatible =3D "fsl,mpc5200b-mdio","fsl,mpc5200-mdio";
> +			reg =3D <0x3000 0x400>; 	// fec range, since we need to
> +						// setup fec interrupts
> +			interrupts =3D <2 5 0>; 	// these are for "mii command
> +						// finished", not link changes
> +						//  & co.
> +
> +			phy0: ethernet-phy@0 {
> +				compatible =3D "intel,lxt971";
> +				reg =3D <0>;
> +			};
> +		};
> +
> +		ata@3a00 {
> +			compatible =3D "fsl,mpc5200b-ata","fsl,mpc5200-ata";
> +			reg =3D <0x3a00 0x100>;
> +			interrupts =3D <2 7 0>;
> +		};
> +
> +		i2c@3d40 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			compatible =3D "fsl,mpc5200b-i2c","fsl,mpc5200-i2c",
> +					"fsl-i2c";
> +			reg =3D <0x3d40 0x40>;
> +			interrupts =3D <2 16 0>;
> +
> +			hwmon@2c {
> +				compatible =3D "ad,adm9240";
> +				reg =3D <0x2c>;
> +			};
> +			rtc@51 {
> +				compatible =3D "nxp,pcf8563";
> +				reg =3D <0x51>;
> +			};
> +		};
> +
> +		sram@8000 {
> +			compatible =3D "fsl,mpc5200b-sram","fsl,mpc5200-sram";
> +			reg =3D <0x8000 0x4000>;
> +		};
> +	};
> +
> +	localbus {
> +		compatible =3D "fsl,mpc5200b-lpb","simple-bus";
> +		#address-cells =3D <2>;
> +		#size-cells =3D <1>;
> +		ranges =3D <0 0 0xff800000 0x00800000
> +			  1 0 0x80000000 0x00800000
> +			  3 0 0x80000000 0x00800000>;
> +
> +		flash@0,0 {
> +			compatible =3D "cfi-flash";
> +			reg =3D <0 0 0x00800000>;
> +			bank-width =3D <4>;
> +			device-width =3D <2>;
> +			#size-cells =3D <1>;
> +			#address-cells =3D <1>;
> +			partition@0 {
> +				label =3D "DTS";
> +				reg =3D <0x0 0x00100000>;
> +			};
> +			partition@100000 {
> +				label =3D "Kernel";
> +				reg =3D <0x100000 0x00200000>;
> +			};
> +			partition@300000 {
> +				label =3D "RootFS";
> +				reg =3D <0x00300000 0x00200000>;
> +			};
> +			partition@500000 {
> +				label =3D "user";
> +				reg =3D <0x00500000 0x00200000>;
> +			};
> +			partition@700000 {
> +				label =3D "U-Boot";
> +				reg =3D <0x00700000 0x00040000>;
> +			};
> +			partition@740000 {
> +				label =3D "Env";
> +				reg =3D <0x00740000 0x00020000>;
> +			};
> +			partition@760000 {
> +				label =3D "red. Env";
> +				reg =3D <0x00760000 0x00020000>;
> +			};
> +			partition@780000 {
> +				label =3D "reserve";
> +				reg =3D <0x00780000 0x00080000>;
> +			};
> +		};
> +
> +		simple100: gpio-controller-100@3,600100 {
> +				#gpio-cells =3D <2>;
> +				compatible =3D "manroland,mucmc52-aux-gpio";
> +				reg =3D <3 0x00600100 0x1>;
> +				gpio-controller;
> +		};
> +		simple104: gpio-controller-104@3,600104 {
> +				#gpio-cells =3D <2>;
> +				compatible =3D "manroland,mucmc52-aux-gpio";
> +				reg =3D <3 0x00600104 0x1>;
> +				gpio-controller;
> +		};
> +		simple200: gpio-controller-200@3,600200 {
> +				#gpio-cells =3D <2>;
> +				compatible =3D "manroland,mucmc52-aux-gpio";
> +				reg =3D <3 0x00600200 0x1>;
> +				gpio-controller;
> +		};
> +		simple201: gpio-controller-201@3,600201 {
> +				#gpio-cells =3D <2>;
> +				compatible =3D "manroland,mucmc52-aux-gpio";
> +				reg =3D <3 0x00600201 0x1>;
> +				gpio-controller;
> +		};
> +		simple202: gpio-controller-202@3,600202 {
> +				#gpio-cells =3D <2>;
> +				compatible =3D "manroland,mucmc52-aux-gpio";
> +				reg =3D <3 0x00600202 0x1>;
> +				gpio-controller;
> +		};
> +		simple203: gpio-controller-203@3,600203 {
> +				#gpio-cells =3D <2>;
> +				compatible =3D "manroland,mucmc52-aux-gpio";
> +				reg =3D <3 0x00600203 0x1>;
> +				gpio-controller;
> +		};
> +		simple204: gpio-controller-204@3,600204 {
> +				#gpio-cells =3D <2>;
> +				compatible =3D "manroland,mucmc52-aux-gpio";
> +				reg =3D <3 0x00600204 0x1>;
> +				gpio-controller;
> +		};
> +		simple206: gpio-controller-206@3,600206 {
> +				#gpio-cells =3D <2>;
> +				compatible =3D "manroland,mucmc52-aux-gpio";
> +				reg =3D <3 0x00600206 0x1>;
> +				gpio-controller;
> +		};
> +		simple207: gpio-controller-207@3,600207 {
> +				#gpio-cells =3D <2>;
> +				compatible =3D "manroland,mucmc52-aux-gpio";
> +				reg =3D <3 0x00600207 0x1>;
> +				gpio-controller;
> +		};
> +		simple20f: gpio-controller-20f@3,60020f {
> +				#gpio-cells =3D <2>;
> +				compatible =3D "manroland,mucmc52-aux-gpio";
> +				reg =3D <3 0x0060020f 0x1>;
> +				gpio-controller;
> +		};
> +
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
> +		interrupt-map =3D <
> +				/* IDSEL 0x10 */
> +				0x8000 0 0 1 &mpc5200_pic 0 3 3
> +				0x8000 0 0 2 &mpc5200_pic 0 3 3
> +				0x8000 0 0 3 &mpc5200_pic 0 2 3
> +				0x8000 0 0 4 &mpc5200_pic 0 1 3
> +				>;
> +		clock-frequency =3D <0>; // From boot loader
> +		interrupts =3D <2 8 0 2 9 0 2 10 0>;
> +		bus-range =3D <0 0>;
> +		ranges =3D <0x42000000 0 0x60000000 0x60000000 0 0x10000000
> +			  0x02000000 0 0x90000000 0x90000000 0 0x10000000
> +			  0x01000000 0 0x00000000 0xa0000000 0 0x01000000>;
> +	};
> +};
> diff --git a/arch/powerpc/configs/mpc5200_defconfig b/arch/powerpc/config=
s/mpc5200_defconfig
> index aaa4416..d035421 100644
> --- a/arch/powerpc/configs/mpc5200_defconfig
> +++ b/arch/powerpc/configs/mpc5200_defconfig
> @@ -205,7 +205,7 @@ CONFIG_RTAS_PROC=3Dy
>  CONFIG_PPC_BESTCOMM=3Dy
>  CONFIG_PPC_BESTCOMM_ATA=3Dy
>  CONFIG_PPC_BESTCOMM_FEC=3Dy
> -# CONFIG_SIMPLE_GPIO is not set
> +CONFIG_SIMPLE_GPIO=3Dy
>=20
>  #
>  # Kernel options
> diff --git a/arch/powerpc/platforms/52xx/mpc5200_simple.c b/arch/powerpc/=
platforms/52xx/mpc5200_simple.c
> index caf6d92..d45be5b 100644
> --- a/arch/powerpc/platforms/52xx/mpc5200_simple.c
> +++ b/arch/powerpc/platforms/52xx/mpc5200_simple.c
> @@ -51,6 +51,7 @@ static void __init mpc5200_simple_setup_arch(void)
>  /* list of the supported boards */
>  static char *board[] __initdata =3D {
>  	"intercontrol,digsy-mtc",
> +	"manroland,mucmc52",
>  	"manroland,uc101",
>  	"phytec,pcm030",
>  	"phytec,pcm032",
> --=20
> 1.6.0.6
>=20
> --=20
> DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--h22Fi9ANawrtbNPX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrMZDAACgkQD27XaX1/VRvbUACfaIWJUEvJnsX2et7rQKdQiVLe
9NgAoLjs8njlISdWqHKArzxR9dgclQrn
=FTWQ
-----END PGP SIGNATURE-----

--h22Fi9ANawrtbNPX--
