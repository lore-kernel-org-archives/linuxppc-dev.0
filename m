Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id B372ADDF1C
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 08:21:59 +1100 (EST)
Date: Thu, 29 Jan 2009 22:21:31 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/8] powerpc/5200: Trim cruft from device trees
Message-ID: <20090129212131.GC1406@pengutronix.de>
References: <20090121205506.31232.27908.stgit@localhost.localdomain>
	<20090121205518.31232.58846.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6zdv2QT/q3FMhpsV"
In-Reply-To: <20090121205518.31232.58846.stgit@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Marian Balakowicz <m8@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2009 at 01:55:18PM -0700, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
>=20
> Trim out obsolete/extraneous properties and tighten up some usage
> conventions.  Changes include:
> - removal of device_type properties
> - removal of cell-index properties
> - Addition of gpio-controller and #gpio-cells properties to gpio
>   nodes
> - Move common interrupt-parent property out of device nodes and
>   into top level parent node.
>=20
> This patch also include what looks to be just trivial editorial
> whitespace/format changes, but there is real method in this
> madness.  Editorial changes were made to keep the all the
> mpc5200 board device trees as similar as possible so that diffs
> between them only show the real differences between the boards.
> The pcm030 device tree was most affected by this because many
> of the comments had been changed from // to /* */ style and
> some cell values where changed from decimal to hex format when
> it was cloned from one of the other 5200 device trees.

Thanks for this and especially for fixing the wrong interrupt in one of
the pcm030 PSCs! My phyCORE-MPC5200B-tiny still works fine with the new
dts. The other changes were only audited, not tested on real hardware.

> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

> CC: Wolfram Sang <w.sang@pengutronix.de>
> CC: Wolfgang Grandegger <wg@grandegger.com>
> CC: Sascha Hauer <s.hauer@pengutronix.de>
> CC: Marian Balakowicz <m8@semihalf.com>
> ---
>=20
>  arch/powerpc/boot/dts/cm5200.dts    |   45 ++-------
>  arch/powerpc/boot/dts/lite5200.dts  |   52 ----------
>  arch/powerpc/boot/dts/lite5200b.dts |   63 ++----------
>  arch/powerpc/boot/dts/motionpro.dts |   42 ++------
>  arch/powerpc/boot/dts/pcm030.dts    |  182 +++++++++++++----------------=
------
>  arch/powerpc/boot/dts/tqm5200.dts   |   32 +-----
>  6 files changed, 104 insertions(+), 312 deletions(-)
>=20
>=20
> diff --git a/arch/powerpc/boot/dts/cm5200.dts b/arch/powerpc/boot/dts/cm5=
200.dts
> index 2f74cc4..11ada32 100644
> --- a/arch/powerpc/boot/dts/cm5200.dts
> +++ b/arch/powerpc/boot/dts/cm5200.dts
> @@ -17,6 +17,7 @@
>  	compatible =3D "schindler,cm5200";
>  	#address-cells =3D <1>;
>  	#size-cells =3D <1>;
> +	interrupt-parent =3D <&mpc5200_pic>;
> =20
>  	cpus {
>  		#address-cells =3D <1>;
> @@ -66,7 +67,6 @@
>  			compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
>  			reg =3D <0x600 0x10>;
>  			interrupts =3D <1 9 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  			fsl,has-wdt;
>  		};
> =20
> @@ -74,84 +74,76 @@
>  			compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
>  			reg =3D <0x610 0x10>;
>  			interrupts =3D <1 10 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		timer@620 {	// General Purpose Timer
>  			compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
>  			reg =3D <0x620 0x10>;
>  			interrupts =3D <1 11 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		timer@630 {	// General Purpose Timer
>  			compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
>  			reg =3D <0x630 0x10>;
>  			interrupts =3D <1 12 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		timer@640 {	// General Purpose Timer
>  			compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
>  			reg =3D <0x640 0x10>;
>  			interrupts =3D <1 13 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		timer@650 {	// General Purpose Timer
>  			compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
>  			reg =3D <0x650 0x10>;
>  			interrupts =3D <1 14 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		timer@660 {	// General Purpose Timer
>  			compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
>  			reg =3D <0x660 0x10>;
>  			interrupts =3D <1 15 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		timer@670 {	// General Purpose Timer
>  			compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
>  			reg =3D <0x670 0x10>;
>  			interrupts =3D <1 16 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		rtc@800 {	// Real time clock
>  			compatible =3D "fsl,mpc5200b-rtc","fsl,mpc5200-rtc";
>  			reg =3D <0x800 0x100>;
>  			interrupts =3D <1 5 0 1 6 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
> -		gpio@b00 {
> +		gpio_simple: gpio@b00 {
>  			compatible =3D "fsl,mpc5200b-gpio","fsl,mpc5200-gpio";
>  			reg =3D <0xb00 0x40>;
>  			interrupts =3D <1 7 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
> +			gpio-controller;
> +			#gpio-cells =3D <2>;
>  		};
> =20
> -		gpio@c00 {
> +		gpio_wkup: gpio@c00 {
>  			compatible =3D "fsl,mpc5200b-gpio-wkup","fsl,mpc5200-gpio-wkup";
>  			reg =3D <0xc00 0x40>;
>  			interrupts =3D <1 8 0 0 3 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
> +			gpio-controller;
> +			#gpio-cells =3D <2>;
>  		};
> =20
>  		spi@f00 {
>  			compatible =3D "fsl,mpc5200b-spi","fsl,mpc5200-spi";
>  			reg =3D <0xf00 0x20>;
>  			interrupts =3D <2 13 0 2 14 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		usb@1000 {
>  			compatible =3D "fsl,mpc5200b-ohci","fsl,mpc5200-ohci","ohci-be";
>  			reg =3D <0x1000 0xff>;
>  			interrupts =3D <2 6 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		dma-controller@1200 {
> @@ -161,7 +153,6 @@
>  			              3 4 0  3 5 0  3 6 0  3 7 0
>  			              3 8 0  3 9 0  3 10 0  3 11 0
>  			              3 12 0  3 13 0  3 14 0  3 15 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		xlb@1f00 {
> @@ -170,48 +161,34 @@
>  		};
> =20
>  		serial@2000 {		// PSC1
> -			device_type =3D "serial";
>  			compatible =3D "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
> -			port-number =3D <0>;  // Logical port assignment
>  			reg =3D <0x2000 0x100>;
>  			interrupts =3D <2 1 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		serial@2200 {		// PSC2
> -			device_type =3D "serial";
>  			compatible =3D "fsl,mpc5200-psc-uart";
> -			port-number =3D <1>;  // Logical port assignment
>  			reg =3D <0x2200 0x100>;
>  			interrupts =3D <2 2 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		serial@2400 {		// PSC3
> -			device_type =3D "serial";
>  			compatible =3D "fsl,mpc5200-psc-uart";
> -			port-number =3D <2>;  // Logical port assignment
>  			reg =3D <0x2400 0x100>;
>  			interrupts =3D <2 3 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		serial@2c00 {		// PSC6
> -			device_type =3D "serial";
>  			compatible =3D "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
> -			port-number =3D <5>;  // Logical port assignment
>  			reg =3D <0x2c00 0x100>;
>  			interrupts =3D <2 4 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		ethernet@3000 {
> -			device_type =3D "network";
>  			compatible =3D "fsl,mpc5200b-fec","fsl,mpc5200-fec";
>  			reg =3D <0x3000 0x400>;
>  			local-mac-address =3D [ 00 00 00 00 00 00 ];
>  			interrupts =3D <2 5 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  			phy-handle =3D <&phy0>;
>  		};
> =20
> @@ -221,10 +198,8 @@
>  			compatible =3D "fsl,mpc5200b-mdio","fsl,mpc5200-mdio";
>  			reg =3D <0x3000 0x400>;       // fec range, since we need to setup fe=
c interrupts
>  			interrupts =3D <2 5 0>;   // these are for "mii command finished", no=
t link changes & co.
> -			interrupt-parent =3D <&mpc5200_pic>;
> =20
>  			phy0: ethernet-phy@0 {
> -				device_type =3D "ethernet-phy";
>  				reg =3D <0>;
>  			};
>  		};
> @@ -235,7 +210,6 @@
>  			compatible =3D "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
>  			reg =3D <0x3d40 0x40>;
>  			interrupts =3D <2 16 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  			fsl5200-clocking;
>  		};
> =20
> @@ -245,9 +219,8 @@
>  		};
>  	};
> =20
> -	lpb {
> -		model =3D "fsl,lpb";
> -		compatible =3D "fsl,lpb";
> +	localbus {
> +		compatible =3D "fsl,mpc5200b-lpb","simple-bus";
>  		#address-cells =3D <2>;
>  		#size-cells =3D <1>;
>  		ranges =3D <0 0 0xfc000000 0x2000000>;
> diff --git a/arch/powerpc/boot/dts/lite5200.dts b/arch/powerpc/boot/dts/l=
ite5200.dts
> index 3f7a5dc..de30b3f 100644
> --- a/arch/powerpc/boot/dts/lite5200.dts
> +++ b/arch/powerpc/boot/dts/lite5200.dts
> @@ -17,6 +17,7 @@
>  	compatible =3D "fsl,lite5200";
>  	#address-cells =3D <1>;
>  	#size-cells =3D <1>;
> +	interrupt-parent =3D <&mpc5200_pic>;
> =20
>  	cpus {
>  		#address-cells =3D <1>;
> @@ -58,96 +59,74 @@
>  			// 5200 interrupts are encoded into two levels;
>  			interrupt-controller;
>  			#interrupt-cells =3D <3>;
> -			device_type =3D "interrupt-controller";
>  			compatible =3D "fsl,mpc5200-pic";
>  			reg =3D <0x500 0x80>;
>  		};
> =20
>  		timer@600 {	// General Purpose Timer
>  			compatible =3D "fsl,mpc5200-gpt";
> -			cell-index =3D <0>;
>  			reg =3D <0x600 0x10>;
>  			interrupts =3D <1 9 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  			fsl,has-wdt;
>  		};
> =20
>  		timer@610 {	// General Purpose Timer
>  			compatible =3D "fsl,mpc5200-gpt";
> -			cell-index =3D <1>;
>  			reg =3D <0x610 0x10>;
>  			interrupts =3D <1 10 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		timer@620 {	// General Purpose Timer
>  			compatible =3D "fsl,mpc5200-gpt";
> -			cell-index =3D <2>;
>  			reg =3D <0x620 0x10>;
>  			interrupts =3D <1 11 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		timer@630 {	// General Purpose Timer
>  			compatible =3D "fsl,mpc5200-gpt";
> -			cell-index =3D <3>;
>  			reg =3D <0x630 0x10>;
>  			interrupts =3D <1 12 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		timer@640 {	// General Purpose Timer
>  			compatible =3D "fsl,mpc5200-gpt";
> -			cell-index =3D <4>;
>  			reg =3D <0x640 0x10>;
>  			interrupts =3D <1 13 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		timer@650 {	// General Purpose Timer
>  			compatible =3D "fsl,mpc5200-gpt";
> -			cell-index =3D <5>;
>  			reg =3D <0x650 0x10>;
>  			interrupts =3D <1 14 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		timer@660 {	// General Purpose Timer
>  			compatible =3D "fsl,mpc5200-gpt";
> -			cell-index =3D <6>;
>  			reg =3D <0x660 0x10>;
>  			interrupts =3D <1 15 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		timer@670 {	// General Purpose Timer
>  			compatible =3D "fsl,mpc5200-gpt";
> -			cell-index =3D <7>;
>  			reg =3D <0x670 0x10>;
>  			interrupts =3D <1 16 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		rtc@800 {	// Real time clock
>  			compatible =3D "fsl,mpc5200-rtc";
>  			reg =3D <0x800 0x100>;
>  			interrupts =3D <1 5 0 1 6 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		can@900 {
>  			compatible =3D "fsl,mpc5200-mscan";
> -			cell-index =3D <0>;
>  			interrupts =3D <2 17 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  			reg =3D <0x900 0x80>;
>  		};
> =20
>  		can@980 {
>  			compatible =3D "fsl,mpc5200-mscan";
> -			cell-index =3D <1>;
>  			interrupts =3D <2 18 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  			reg =3D <0x980 0x80>;
>  		};
> =20
> @@ -155,39 +134,33 @@
>  			compatible =3D "fsl,mpc5200-gpio";
>  			reg =3D <0xb00 0x40>;
>  			interrupts =3D <1 7 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		gpio@c00 {
>  			compatible =3D "fsl,mpc5200-gpio-wkup";
>  			reg =3D <0xc00 0x40>;
>  			interrupts =3D <1 8 0 0 3 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		spi@f00 {
>  			compatible =3D "fsl,mpc5200-spi";
>  			reg =3D <0xf00 0x20>;
>  			interrupts =3D <2 13 0 2 14 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		usb@1000 {
>  			compatible =3D "fsl,mpc5200-ohci","ohci-be";
>  			reg =3D <0x1000 0xff>;
>  			interrupts =3D <2 6 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		dma-controller@1200 {
> -			device_type =3D "dma-controller";
>  			compatible =3D "fsl,mpc5200-bestcomm";
>  			reg =3D <0x1200 0x80>;
>  			interrupts =3D <3 0 0  3 1 0  3 2 0  3 3 0
>  			              3 4 0  3 5 0  3 6 0  3 7 0
>  			              3 8 0  3 9 0  3 10 0  3 11 0
>  			              3 12 0  3 13 0  3 14 0  3 15 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		xlb@1f00 {
> @@ -196,13 +169,10 @@
>  		};
> =20
>  		serial@2000 {		// PSC1
> -			device_type =3D "serial";
>  			compatible =3D "fsl,mpc5200-psc-uart";
> -			port-number =3D <0>;  // Logical port assignment
>  			cell-index =3D <0>;
>  			reg =3D <0x2000 0x100>;
>  			interrupts =3D <2 1 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		// PSC2 in ac97 mode example
> @@ -211,7 +181,6 @@
>  		//	cell-index =3D <1>;
>  		//	reg =3D <0x2200 0x100>;
>  		//	interrupts =3D <2 2 0>;
> -		//	interrupt-parent =3D <&mpc5200_pic>;
>  		//};
> =20
>  		// PSC3 in CODEC mode example
> @@ -220,27 +189,22 @@
>  		//	cell-index =3D <2>;
>  		//	reg =3D <0x2400 0x100>;
>  		//	interrupts =3D <2 3 0>;
> -		//	interrupt-parent =3D <&mpc5200_pic>;
>  		//};
> =20
>  		// PSC4 in uart mode example
>  		//serial@2600 {		// PSC4
> -		//	device_type =3D "serial";
>  		//	compatible =3D "fsl,mpc5200-psc-uart";
>  		//	cell-index =3D <3>;
>  		//	reg =3D <0x2600 0x100>;
>  		//	interrupts =3D <2 11 0>;
> -		//	interrupt-parent =3D <&mpc5200_pic>;
>  		//};
> =20
>  		// PSC5 in uart mode example
>  		//serial@2800 {		// PSC5
> -		//	device_type =3D "serial";
>  		//	compatible =3D "fsl,mpc5200-psc-uart";
>  		//	cell-index =3D <4>;
>  		//	reg =3D <0x2800 0x100>;
>  		//	interrupts =3D <2 12 0>;
> -		//	interrupt-parent =3D <&mpc5200_pic>;
>  		//};
> =20
>  		// PSC6 in spi mode example
> @@ -249,16 +213,13 @@
>  		//	cell-index =3D <5>;
>  		//	reg =3D <0x2c00 0x100>;
>  		//	interrupts =3D <2 4 0>;
> -		//	interrupt-parent =3D <&mpc5200_pic>;
>  		//};
> =20
>  		ethernet@3000 {
> -			device_type =3D "network";
>  			compatible =3D "fsl,mpc5200-fec";
>  			reg =3D <0x3000 0x400>;
>  			local-mac-address =3D [ 00 00 00 00 00 00 ];
>  			interrupts =3D <2 5 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  			phy-handle =3D <&phy0>;
>  		};
> =20
> @@ -268,30 +229,24 @@
>  			compatible =3D "fsl,mpc5200-mdio";
>  			reg =3D <0x3000 0x400>;	// fec range, since we need to setup fec inte=
rrupts
>  			interrupts =3D <2 5 0>;	// these are for "mii command finished", not =
link changes & co.
> -			interrupt-parent =3D <&mpc5200_pic>;
> =20
>  			phy0: ethernet-phy@1 {
> -				device_type =3D "ethernet-phy";
>  				reg =3D <1>;
>  			};
>  		};
> =20
>  		ata@3a00 {
> -			device_type =3D "ata";
>  			compatible =3D "fsl,mpc5200-ata";
>  			reg =3D <0x3a00 0x100>;
>  			interrupts =3D <2 7 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		i2c@3d00 {
>  			#address-cells =3D <1>;
>  			#size-cells =3D <0>;
>  			compatible =3D "fsl,mpc5200-i2c","fsl-i2c";
> -			cell-index =3D <0>;
>  			reg =3D <0x3d00 0x40>;
>  			interrupts =3D <2 15 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  			fsl5200-clocking;
>  		};
> =20
> @@ -299,14 +254,12 @@
>  			#address-cells =3D <1>;
>  			#size-cells =3D <0>;
>  			compatible =3D "fsl,mpc5200-i2c","fsl-i2c";
> -			cell-index =3D <1>;
>  			reg =3D <0x3d40 0x40>;
>  			interrupts =3D <2 16 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  			fsl5200-clocking;
>  		};
>  		sram@8000 {
> -			compatible =3D "fsl,mpc5200-sram","sram";
> +			compatible =3D "fsl,mpc5200-sram";
>  			reg =3D <0x8000 0x4000>;
>  		};
>  	};
> @@ -325,7 +278,6 @@
>  				 0xc000 0 0 4 &mpc5200_pic 0 0 3>;
>  		clock-frequency =3D <0>; // From boot loader
>  		interrupts =3D <2 8 0 2 9 0 2 10 0>;
> -		interrupt-parent =3D <&mpc5200_pic>;
>  		bus-range =3D <0 0>;
>  		ranges =3D <0x42000000 0 0x80000000 0x80000000 0 0x20000000
>  			  0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
> diff --git a/arch/powerpc/boot/dts/lite5200b.dts b/arch/powerpc/boot/dts/=
lite5200b.dts
> index 63e3bb4..c63e356 100644
> --- a/arch/powerpc/boot/dts/lite5200b.dts
> +++ b/arch/powerpc/boot/dts/lite5200b.dts
> @@ -17,6 +17,7 @@
>  	compatible =3D "fsl,lite5200b";
>  	#address-cells =3D <1>;
>  	#size-cells =3D <1>;
> +	interrupt-parent =3D <&mpc5200_pic>;
> =20
>  	cpus {
>  		#address-cells =3D <1>;
> @@ -58,136 +59,112 @@
>  			// 5200 interrupts are encoded into two levels;
>  			interrupt-controller;
>  			#interrupt-cells =3D <3>;
> -			device_type =3D "interrupt-controller";
>  			compatible =3D "fsl,mpc5200b-pic","fsl,mpc5200-pic";
>  			reg =3D <0x500 0x80>;
>  		};
> =20
>  		timer@600 {	// General Purpose Timer
>  			compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
> -			cell-index =3D <0>;
>  			reg =3D <0x600 0x10>;
>  			interrupts =3D <1 9 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  			fsl,has-wdt;
>  		};
> =20
>  		timer@610 {	// General Purpose Timer
>  			compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
> -			cell-index =3D <1>;
>  			reg =3D <0x610 0x10>;
>  			interrupts =3D <1 10 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		timer@620 {	// General Purpose Timer
>  			compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
> -			cell-index =3D <2>;
>  			reg =3D <0x620 0x10>;
>  			interrupts =3D <1 11 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		timer@630 {	// General Purpose Timer
>  			compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
> -			cell-index =3D <3>;
>  			reg =3D <0x630 0x10>;
>  			interrupts =3D <1 12 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		timer@640 {	// General Purpose Timer
>  			compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
> -			cell-index =3D <4>;
>  			reg =3D <0x640 0x10>;
>  			interrupts =3D <1 13 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		timer@650 {	// General Purpose Timer
>  			compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
> -			cell-index =3D <5>;
>  			reg =3D <0x650 0x10>;
>  			interrupts =3D <1 14 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		timer@660 {	// General Purpose Timer
>  			compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
> -			cell-index =3D <6>;
>  			reg =3D <0x660 0x10>;
>  			interrupts =3D <1 15 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		timer@670 {	// General Purpose Timer
>  			compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
> -			cell-index =3D <7>;
>  			reg =3D <0x670 0x10>;
>  			interrupts =3D <1 16 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		rtc@800 {	// Real time clock
>  			compatible =3D "fsl,mpc5200b-rtc","fsl,mpc5200-rtc";
>  			reg =3D <0x800 0x100>;
>  			interrupts =3D <1 5 0 1 6 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		can@900 {
>  			compatible =3D "fsl,mpc5200b-mscan","fsl,mpc5200-mscan";
> -			cell-index =3D <0>;
>  			interrupts =3D <2 17 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  			reg =3D <0x900 0x80>;
>  		};
> =20
>  		can@980 {
>  			compatible =3D "fsl,mpc5200b-mscan","fsl,mpc5200-mscan";
> -			cell-index =3D <1>;
>  			interrupts =3D <2 18 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  			reg =3D <0x980 0x80>;
>  		};
> =20
> -		gpio@b00 {
> +		gpio_simple: gpio@b00 {
>  			compatible =3D "fsl,mpc5200b-gpio","fsl,mpc5200-gpio";
>  			reg =3D <0xb00 0x40>;
>  			interrupts =3D <1 7 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
> +			gpio-controller;
> +			#gpio-cells =3D <2>;
>  		};
> =20
> -		gpio@c00 {
> +		gpio_wkup: gpio@c00 {
>  			compatible =3D "fsl,mpc5200b-gpio-wkup","fsl,mpc5200-gpio-wkup";
>  			reg =3D <0xc00 0x40>;
>  			interrupts =3D <1 8 0 0 3 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
> +			gpio-controller;
> +			#gpio-cells =3D <2>;
>  		};
> =20
>  		spi@f00 {
>  			compatible =3D "fsl,mpc5200b-spi","fsl,mpc5200-spi";
>  			reg =3D <0xf00 0x20>;
>  			interrupts =3D <2 13 0 2 14 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		usb@1000 {
>  			compatible =3D "fsl,mpc5200b-ohci","fsl,mpc5200-ohci","ohci-be";
>  			reg =3D <0x1000 0xff>;
>  			interrupts =3D <2 6 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		dma-controller@1200 {
> -			device_type =3D "dma-controller";
>  			compatible =3D "fsl,mpc5200b-bestcomm","fsl,mpc5200-bestcomm";
>  			reg =3D <0x1200 0x80>;
>  			interrupts =3D <3 0 0  3 1 0  3 2 0  3 3 0
>  			              3 4 0  3 5 0  3 6 0  3 7 0
>  			              3 8 0  3 9 0  3 10 0  3 11 0
>  			              3 12 0  3 13 0  3 14 0  3 15 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		xlb@1f00 {
> @@ -196,13 +173,10 @@
>  		};
> =20
>  		serial@2000 {		// PSC1
> -			device_type =3D "serial";
>  			compatible =3D "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
> -			port-number =3D <0>;  // Logical port assignment
>  			cell-index =3D <0>;
>  			reg =3D <0x2000 0x100>;
>  			interrupts =3D <2 1 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		// PSC2 in ac97 mode example
> @@ -211,7 +185,6 @@
>  		//	cell-index =3D <1>;
>  		//	reg =3D <0x2200 0x100>;
>  		//	interrupts =3D <2 2 0>;
> -		//	interrupt-parent =3D <&mpc5200_pic>;
>  		//};
> =20
>  		// PSC3 in CODEC mode example
> @@ -220,27 +193,22 @@
>  		//	cell-index =3D <2>;
>  		//	reg =3D <0x2400 0x100>;
>  		//	interrupts =3D <2 3 0>;
> -		//	interrupt-parent =3D <&mpc5200_pic>;
>  		//};
> =20
>  		// PSC4 in uart mode example
>  		//serial@2600 {		// PSC4
> -		//	device_type =3D "serial";
>  		//	compatible =3D "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
>  		//	cell-index =3D <3>;
>  		//	reg =3D <0x2600 0x100>;
>  		//	interrupts =3D <2 11 0>;
> -		//	interrupt-parent =3D <&mpc5200_pic>;
>  		//};
> =20
>  		// PSC5 in uart mode example
>  		//serial@2800 {		// PSC5
> -		//	device_type =3D "serial";
>  		//	compatible =3D "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
>  		//	cell-index =3D <4>;
>  		//	reg =3D <0x2800 0x100>;
>  		//	interrupts =3D <2 12 0>;
> -		//	interrupt-parent =3D <&mpc5200_pic>;
>  		//};
> =20
>  		// PSC6 in spi mode example
> @@ -249,49 +217,40 @@
>  		//	cell-index =3D <5>;
>  		//	reg =3D <0x2c00 0x100>;
>  		//	interrupts =3D <2 4 0>;
> -		//	interrupt-parent =3D <&mpc5200_pic>;
>  		//};
> =20
>  		ethernet@3000 {
> -			device_type =3D "network";
>  			compatible =3D "fsl,mpc5200b-fec","fsl,mpc5200-fec";
>  			reg =3D <0x3000 0x400>;
>  			local-mac-address =3D [ 00 00 00 00 00 00 ];
>  			interrupts =3D <2 5 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  			phy-handle =3D <&phy0>;
>  		};
> =20
>  		mdio@3000 {
>  			#address-cells =3D <1>;
>  			#size-cells =3D <0>;
> -			compatible =3D "fsl,mpc5200b-mdio", "fsl,mpc5200-mdio";
> +			compatible =3D "fsl,mpc5200b-mdio","fsl,mpc5200-mdio";
>  			reg =3D <0x3000 0x400>;	// fec range, since we need to setup fec inte=
rrupts
>  			interrupts =3D <2 5 0>;	// these are for "mii command finished", not =
link changes & co.
> -			interrupt-parent =3D <&mpc5200_pic>;
> =20
>  			phy0: ethernet-phy@0 {
> -				device_type =3D "ethernet-phy";
>  				reg =3D <0>;
>  			};
>  		};
> =20
>  		ata@3a00 {
> -			device_type =3D "ata";
>  			compatible =3D "fsl,mpc5200b-ata","fsl,mpc5200-ata";
>  			reg =3D <0x3a00 0x100>;
>  			interrupts =3D <2 7 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		i2c@3d00 {
>  			#address-cells =3D <1>;
>  			#size-cells =3D <0>;
>  			compatible =3D "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
> -			cell-index =3D <0>;
>  			reg =3D <0x3d00 0x40>;
>  			interrupts =3D <2 15 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  			fsl5200-clocking;
>  		};
> =20
> @@ -299,14 +258,13 @@
>  			#address-cells =3D <1>;
>  			#size-cells =3D <0>;
>  			compatible =3D "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
> -			cell-index =3D <1>;
>  			reg =3D <0x3d40 0x40>;
>  			interrupts =3D <2 16 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  			fsl5200-clocking;
>  		};
> +
>  		sram@8000 {
> -			compatible =3D "fsl,mpc5200b-sram","fsl,mpc5200-sram","sram";
> +			compatible =3D "fsl,mpc5200b-sram","fsl,mpc5200-sram";
>  			reg =3D <0x8000 0x4000>;
>  		};
>  	};
> @@ -330,7 +288,6 @@
>  				 0xc800 0 0 4 &mpc5200_pic 0 0 3>;
>  		clock-frequency =3D <0>; // From boot loader
>  		interrupts =3D <2 8 0 2 9 0 2 10 0>;
> -		interrupt-parent =3D <&mpc5200_pic>;
>  		bus-range =3D <0 0>;
>  		ranges =3D <0x42000000 0 0x80000000 0x80000000 0 0x20000000
>  			  0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
> diff --git a/arch/powerpc/boot/dts/motionpro.dts b/arch/powerpc/boot/dts/=
motionpro.dts
> index 52ba6f9..7be8ca0 100644
> --- a/arch/powerpc/boot/dts/motionpro.dts
> +++ b/arch/powerpc/boot/dts/motionpro.dts
> @@ -17,6 +17,7 @@
>  	compatible =3D "promess,motionpro";
>  	#address-cells =3D <1>;
>  	#size-cells =3D <1>;
> +	interrupt-parent =3D <&mpc5200_pic>;
> =20
>  	cpus {
>  		#address-cells =3D <1>;
> @@ -66,7 +67,6 @@
>  			compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
>  			reg =3D <0x600 0x10>;
>  			interrupts =3D <1 9 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  			fsl,has-wdt;
>  		};
> =20
> @@ -74,35 +74,30 @@
>  			compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
>  			reg =3D <0x610 0x10>;
>  			interrupts =3D <1 10 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		timer@620 {	// General Purpose Timer
>  			compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
>  			reg =3D <0x620 0x10>;
>  			interrupts =3D <1 11 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		timer@630 {	// General Purpose Timer
>  			compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
>  			reg =3D <0x630 0x10>;
>  			interrupts =3D <1 12 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		timer@640 {	// General Purpose Timer
>  			compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
>  			reg =3D <0x640 0x10>;
>  			interrupts =3D <1 13 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		timer@650 {	// General Purpose Timer
>  			compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
>  			reg =3D <0x650 0x10>;
>  			interrupts =3D <1 14 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		motionpro-led@660 {	// Motion-PRO status LED
> @@ -110,7 +105,6 @@
>  			label =3D "motionpro-statusled";
>  			reg =3D <0x660 0x10>;
>  			interrupts =3D <1 15 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  			blink-delay =3D <100>; // 100 msec
>  		};
> =20
> @@ -119,49 +113,46 @@
>  			label =3D "motionpro-readyled";
>  			reg =3D <0x670 0x10>;
>  			interrupts =3D <1 16 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		rtc@800 {	// Real time clock
>  			compatible =3D "fsl,mpc5200b-rtc","fsl,mpc5200-rtc";
>  			reg =3D <0x800 0x100>;
>  			interrupts =3D <1 5 0 1 6 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		can@980 {
>  			compatible =3D "fsl,mpc5200b-mscan","fsl,mpc5200-mscan";
>  			interrupts =3D <2 18 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  			reg =3D <0x980 0x80>;
>  		};
> =20
> -		gpio@b00 {
> +		gpio_simple: gpio@b00 {
>  			compatible =3D "fsl,mpc5200b-gpio","fsl,mpc5200-gpio";
>  			reg =3D <0xb00 0x40>;
>  			interrupts =3D <1 7 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
> +			gpio-controller;
> +			#gpio-cells =3D <2>;
>  		};
> =20
> -		gpio@c00 {
> +		gpio_wkup: gpio@c00 {
>  			compatible =3D "fsl,mpc5200b-gpio-wkup","fsl,mpc5200-gpio-wkup";
>  			reg =3D <0xc00 0x40>;
>  			interrupts =3D <1 8 0 0 3 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
> +			gpio-controller;
> +			#gpio-cells =3D <2>;
>  		};
> =20
>  		spi@f00 {
>  			compatible =3D "fsl,mpc5200b-spi","fsl,mpc5200-spi";
>  			reg =3D <0xf00 0x20>;
>  			interrupts =3D <2 13 0 2 14 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		usb@1000 {
>  			compatible =3D "fsl,mpc5200b-ohci","fsl,mpc5200-ohci","ohci-be";
>  			reg =3D <0x1000 0xff>;
>  			interrupts =3D <2 6 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		dma-controller@1200 {
> @@ -171,7 +162,6 @@
>  			              3 4 0  3 5 0  3 6 0  3 7 0
>  			              3 8 0  3 9 0  3 10 0  3 11 0
>  			              3 12 0  3 13 0  3 14 0  3 15 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		xlb@1f00 {
> @@ -180,12 +170,9 @@
>  		};
> =20
>  		serial@2000 {		// PSC1
> -			device_type =3D "serial";
>  			compatible =3D "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
> -			port-number =3D <0>;  // Logical port assignment
>  			reg =3D <0x2000 0x100>;
>  			interrupts =3D <2 1 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		// PSC2 in spi master mode=20
> @@ -194,26 +181,20 @@
>  			cell-index =3D <1>;
>  			reg =3D <0x2200 0x100>;
>  			interrupts =3D <2 2 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		// PSC5 in uart mode
>  		serial@2800 {		// PSC5
> -			device_type =3D "serial";
>  			compatible =3D "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
> -			port-number =3D <4>;  // Logical port assignment
>  			reg =3D <0x2800 0x100>;
>  			interrupts =3D <2 12 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		ethernet@3000 {
> -			device_type =3D "network";
>  			compatible =3D "fsl,mpc5200b-fec","fsl,mpc5200-fec";
>  			reg =3D <0x3000 0x400>;
>  			local-mac-address =3D [ 00 00 00 00 00 00 ];
>  			interrupts =3D <2 5 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  			phy-handle =3D <&phy0>;
>  		};
> =20
> @@ -223,10 +204,8 @@
>  			compatible =3D "fsl,mpc5200b-mdio","fsl,mpc5200-mdio";
>  			reg =3D <0x3000 0x400>;       // fec range, since we need to setup fe=
c interrupts
>  			interrupts =3D <2 5 0>;   // these are for "mii command finished", no=
t link changes & co.
> -			interrupt-parent =3D <&mpc5200_pic>;
> =20
>  			phy0: ethernet-phy@2 {
> -				device_type =3D "ethernet-phy";
>  				reg =3D <2>;
>  			};
>  		};
> @@ -235,7 +214,6 @@
>  			compatible =3D "fsl,mpc5200b-ata","fsl,mpc5200-ata";
>  			reg =3D <0x3a00 0x100>;
>  			interrupts =3D <2 7 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		i2c@3d40 {
> @@ -244,7 +222,6 @@
>  			compatible =3D "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
>  			reg =3D <0x3d40 0x40>;
>  			interrupts =3D <2 16 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  			fsl5200-clocking;
> =20
>  			rtc@68 {
> @@ -259,8 +236,8 @@
>  		};
>  	};
> =20
> -	lpb {
> -		compatible =3D "fsl,lpb";
> +	localbus {
> +		compatible =3D "fsl,mpc5200b-lpb","simple-bus";
>  		#address-cells =3D <2>;
>  		#size-cells =3D <1>;
>  		ranges =3D <0 0 0xff000000 0x01000000
> @@ -273,7 +250,6 @@
>  			compatible =3D "promess,motionpro-kollmorgen";
>  			reg =3D <1 0 0x10000>;
>  			interrupts =3D <1 1 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		// 8-bit board CPLD on LocalPlus Bus CS2
> diff --git a/arch/powerpc/boot/dts/pcm030.dts b/arch/powerpc/boot/dts/pcm=
030.dts
> index be2c11c..8958347 100644
> --- a/arch/powerpc/boot/dts/pcm030.dts
> +++ b/arch/powerpc/boot/dts/pcm030.dts
> @@ -19,6 +19,7 @@
>  	compatible =3D "phytec,pcm030";
>  	#address-cells =3D <1>;
>  	#size-cells =3D <1>;
> +	interrupt-parent =3D <&mpc5200_pic>;
> =20
>  	cpus {
>  		#address-cells =3D <1>;
> @@ -29,26 +30,26 @@
>  			reg =3D <0>;
>  			d-cache-line-size =3D <32>;
>  			i-cache-line-size =3D <32>;
> -			d-cache-size =3D <0x4000>;	/* L1, 16K          */
> -			i-cache-size =3D <0x4000>;	/* L1, 16K          */
> -			timebase-frequency =3D <0>;	/* From Bootloader  */
> -			bus-frequency =3D <0>;		/* From Bootloader  */
> -			clock-frequency =3D <0>;		/* From Bootloader  */
> +			d-cache-size =3D <0x4000>;	// L1, 16K
> +			i-cache-size =3D <0x4000>;	// L1, 16K
> +			timebase-frequency =3D <0>;	// from bootloader
> +			bus-frequency =3D <0>;		// from bootloader
> +			clock-frequency =3D <0>;		// from bootloader
>  		};
>  	};
> =20
>  	memory {
>  		device_type =3D "memory";
> -		reg =3D <0x00000000 0x04000000>;	/* 64MB */
> +		reg =3D <0x00000000 0x04000000>;	// 64MB
>  	};
> =20
>  	soc5200@f0000000 {
>  		#address-cells =3D <1>;
>  		#size-cells =3D <1>;
>  		compatible =3D "fsl,mpc5200b-immr";
> -		ranges =3D <0x0 0xf0000000 0x0000c000>;
> -		bus-frequency =3D <0>;		/* From bootloader */
> -		system-frequency =3D <0>;		/* From bootloader */
> +		ranges =3D <0 0xf0000000 0x0000c000>;
> +		bus-frequency =3D <0>;		// from bootloader
> +		system-frequency =3D <0>;		// from bootloader
> =20
>  		cdm@200 {
>  			compatible =3D "fsl,mpc5200b-cdm","fsl,mpc5200-cdm";
> @@ -56,87 +57,70 @@
>  		};
> =20
>  		mpc5200_pic: interrupt-controller@500 {
> -			/* 5200 interrupts are encoded into two levels; */
> +			// 5200 interrupts are encoded into two levels;
>  			interrupt-controller;
>  			#interrupt-cells =3D <3>;
> -			device_type =3D "interrupt-controller";
>  			compatible =3D "fsl,mpc5200b-pic","fsl,mpc5200-pic";
>  			reg =3D <0x500 0x80>;
>  		};
> =20
> -		timer@600 {	/* General Purpose Timer */
> +		timer@600 {	// General Purpose Timer
>  			compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
> -			cell-index =3D <0>;
>  			reg =3D <0x600 0x10>;
> -			interrupts =3D <0x1 0x9 0x0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
> +			interrupts =3D <1 9 0>;
>  			fsl,has-wdt;
>  		};
> =20
> -		timer@610 {	/* General Purpose Timer */
> +		timer@610 {	// General Purpose Timer
>  			compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
> -			cell-index =3D <1>;
>  			reg =3D <0x610 0x10>;
> -			interrupts =3D <0x1 0xa 0x0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
> +			interrupts =3D <1 10 0>;
>  		};
> =20
> -		gpt2: timer@620 { /* General Purpose Timer in GPIO mode */
> +		gpt2: timer@620 {	// General Purpose Timer in GPIO mode
>  			compatible =3D "fsl,mpc5200b-gpt-gpio","fsl,mpc5200-gpt-gpio";
> -			cell-index =3D <2>;
>  			reg =3D <0x620 0x10>;
> -			interrupts =3D <0x1 0xb 0x0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
> +			interrupts =3D <1 11 0>;
>  			gpio-controller;
>  			#gpio-cells =3D <2>;
>  		};
> =20
> -		gpt3: timer@630 { /* General Purpose Timer in GPIO mode */
> +		gpt3: timer@630 {	// General Purpose Timer in GPIO mode
>  			compatible =3D "fsl,mpc5200b-gpt-gpio","fsl,mpc5200-gpt-gpio";
> -			cell-index =3D <3>;
>  			reg =3D <0x630 0x10>;
> -			interrupts =3D <0x1 0xc 0x0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
> +			interrupts =3D <1 12 0>;
>  			gpio-controller;
>  			#gpio-cells =3D <2>;
>  		};
> =20
> -		gpt4: timer@640 { /* General Purpose Timer in GPIO mode */
> +		gpt4: timer@640 {	// General Purpose Timer in GPIO mode
>  			compatible =3D "fsl,mpc5200b-gpt-gpio","fsl,mpc5200-gpt-gpio";
> -			cell-index =3D <4>;
>  			reg =3D <0x640 0x10>;
> -			interrupts =3D <0x1 0xd 0x0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
> +			interrupts =3D <1 13 0>;
>  			gpio-controller;
>  			#gpio-cells =3D <2>;
>  		};
> =20
> -		gpt5: timer@650 { /* General Purpose Timer in GPIO mode */
> +		gpt5: timer@650 {	// General Purpose Timer in GPIO mode
>  			compatible =3D "fsl,mpc5200b-gpt-gpio","fsl,mpc5200-gpt-gpio";
> -			cell-index =3D <5>;
>  			reg =3D <0x650 0x10>;
> -			interrupts =3D <0x1 0xe 0x0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
> +			interrupts =3D <1 14 0>;
>  			gpio-controller;
>  			#gpio-cells =3D <2>;
>  		};
> =20
> -		gpt6: timer@660 { /* General Purpose Timer in GPIO mode */
> +		gpt6: timer@660 {	// General Purpose Timer in GPIO mode
>  			compatible =3D "fsl,mpc5200b-gpt-gpio","fsl,mpc5200-gpt-gpio";
> -			cell-index =3D <6>;
>  			reg =3D <0x660 0x10>;
> -			interrupts =3D <0x1 0xf 0x0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
> +			interrupts =3D <1 15 0>;
>  			gpio-controller;
>  			#gpio-cells =3D <2>;
>  		};
> =20
> -		gpt7: timer@670 { /* General Purpose Timer in GPIO mode */
> +		gpt7: timer@670 {	// General Purpose Timer in GPIO mode
>  			compatible =3D "fsl,mpc5200b-gpt-gpio","fsl,mpc5200-gpt-gpio";
> -			cell-index =3D <7>;
>  			reg =3D <0x670 0x10>;
> -			interrupts =3D <0x1 0x10 0x0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
> +			interrupts =3D <1 16 0>;
>  			gpio-controller;
>  			#gpio-cells =3D <2>;
>  		};
> @@ -144,40 +128,33 @@
>  		rtc@800 {	// Real time clock
>  			compatible =3D "fsl,mpc5200b-rtc","fsl,mpc5200-rtc";
>  			reg =3D <0x800 0x100>;
> -			interrupts =3D <0x1 0x5 0x0 0x1 0x6 0x0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
> +			interrupts =3D <1 5 0 1 6 0>;
>  		};
> =20
>  		can@900 {
>  			compatible =3D "fsl,mpc5200b-mscan","fsl,mpc5200-mscan";
> -			cell-index =3D <0>;
> -			interrupts =3D <0x2 0x11 0x0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
> +			interrupts =3D <2 17 0>;
>  			reg =3D <0x900 0x80>;
>  		};
> =20
>  		can@980 {
>  			compatible =3D "fsl,mpc5200b-mscan","fsl,mpc5200-mscan";
> -			cell-index =3D <1>;
> -			interrupts =3D <0x2 0x12 0x0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
> +			interrupts =3D <2 18 0>;
>  			reg =3D <0x980 0x80>;
>  		};
> =20
>  		gpio_simple: gpio@b00 {
>  			compatible =3D "fsl,mpc5200b-gpio","fsl,mpc5200-gpio";
>  			reg =3D <0xb00 0x40>;
> -			interrupts =3D <0x1 0x7 0x0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
> +			interrupts =3D <1 7 0>;
>  			gpio-controller;
>  			#gpio-cells =3D <2>;
>  		};
> =20
> -		gpio_wkup: gpio-wkup@c00 {
> +		gpio_wkup: gpio@c00 {
>  			compatible =3D "fsl,mpc5200b-gpio-wkup","fsl,mpc5200-gpio-wkup";
>  			reg =3D <0xc00 0x40>;
> -			interrupts =3D <0x1 0x8 0x0 0x0 0x3 0x0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
> +			interrupts =3D <1 8 0 0 3 0>;
>  			gpio-controller;
>  			#gpio-cells =3D <2>;
>  		};
> @@ -185,26 +162,22 @@
>  		spi@f00 {
>  			compatible =3D "fsl,mpc5200b-spi","fsl,mpc5200-spi";
>  			reg =3D <0xf00 0x20>;
> -			interrupts =3D <0x2 0xd 0x0 0x2 0xe 0x0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
> +			interrupts =3D <2 13 0 2 14 0>;
>  		};
> =20
>  		usb@1000 {
>  			compatible =3D "fsl,mpc5200b-ohci","fsl,mpc5200-ohci","ohci-be";
>  			reg =3D <0x1000 0xff>;
> -			interrupts =3D <0x2 0x6 0x0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
> +			interrupts =3D <2 6 0>;
>  		};
> =20
>  		dma-controller@1200 {
> -			device_type =3D "dma-controller";
>  			compatible =3D "fsl,mpc5200b-bestcomm","fsl,mpc5200-bestcomm";
>  			reg =3D <0x1200 0x80>;
> -			interrupts =3D <0x3 0x0 0x0  0x3 0x1 0x0  0x3 0x2 0x0  0x3 0x3 0x0
> -			              0x3 0x4 0x0  0x3 0x5 0x0  0x3 0x6 0x0  0x3 0x7 0x0
> -			              0x3 0x8 0x0  0x3 0x9 0x0  0x3 0xa 0x0  0x3 0xb 0x0
> -			              0x3 0xc 0x0  0x3 0xd 0x0  0x3 0xe 0x0  0x3 0xf 0x0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
> +			interrupts =3D <3 0 0  3 1 0  3 2 0  3 3 0
> +			              3 4 0  3 5 0  3 6 0  3 7 0
> +			              3 8 0  3 9 0  3 10 0  3 11 0
> +			              3 12 0  3 13 0  3 14 0  3 15 0>;
>  		};
> =20
>  		xlb@1f00 {
> @@ -213,24 +186,19 @@
>  		};
> =20
>  		ac97@2000 { /* PSC1 in ac97 mode */
> -			device_type =3D "sound";
>  			compatible =3D "mpc5200b-psc-ac97","fsl,mpc5200b-psc-ac97";
>  			cell-index =3D <0>;
>  			reg =3D <0x2000 0x100>;
> -			interrupts =3D <0x2 0x2 0x0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
> +			interrupts =3D <2 1 0>;
>  		};
> =20
>  		/* PSC2 port is used by CAN1/2 */
> =20
>  		serial@2400 { /* PSC3 in UART mode */
> -			device_type =3D "serial";
>  			compatible =3D "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
> -			port-number =3D <0>;
>  			cell-index =3D <2>;
>  			reg =3D <0x2400 0x100>;
> -			interrupts =3D <0x2 0x3 0x0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
> +			interrupts =3D <2 3 0>;
>  		};
> =20
>  		/* PSC4 is ??? */
> @@ -238,55 +206,44 @@
>  		/* PSC5 is ??? */
> =20
>  		serial@2c00 { /* PSC6 in UART mode */
> -			device_type =3D "serial";
>  			compatible =3D "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
> -			port-number =3D <1>;
>  			cell-index =3D <5>;
>  			reg =3D <0x2c00 0x100>;
> -			interrupts =3D <0x2 0x4 0x0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
> +			interrupts =3D <2 4 0>;
>  		};
> =20
>  		ethernet@3000 {
> -			device_type =3D "network";
>  			compatible =3D "fsl,mpc5200b-fec","fsl,mpc5200-fec";
>  			reg =3D <0x3000 0x400>;
> -			local-mac-address =3D [00 00 00 00 00 00];
> -			interrupts =3D <0x2 0x5 0x0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
> +			local-mac-address =3D [ 00 00 00 00 00 00 ];
> +			interrupts =3D <2 5 0>;
>  			phy-handle =3D <&phy0>;
>  		};
> =20
>  		mdio@3000 {
>  			#address-cells =3D <1>;
>  			#size-cells =3D <0>;
> -			compatible =3D "fsl,mpc5200b-mdio", "fsl,mpc5200-mdio";
> -			reg =3D <0x3000 0x400>;	/* fec range, since we need to setup fec inte=
rrupts */
> -			interrupts =3D <0x2 0x5 0x0>;	/* these are for "mii command finished"=
, not link changes & co. */
> -			interrupt-parent =3D <&mpc5200_pic>;
> -
> -			phy0:ethernet-phy@0 {
> -				device_type =3D "ethernet-phy";
> -				reg =3D <0x0>;
> +			compatible =3D "fsl,mpc5200b-mdio","fsl,mpc5200-mdio";
> +			reg =3D <0x3000 0x400>;	// fec range, since we need to setup fec inte=
rrupts
> +			interrupts =3D <2 5 0>;	// these are for "mii command finished", not =
link changes & co.
> +
> +			phy0: ethernet-phy@0 {
> +				reg =3D <0>;
>  			};
>  		};
> =20
>  		ata@3a00 {
> -			device_type =3D "ata";
>  			compatible =3D "fsl,mpc5200b-ata","fsl,mpc5200-ata";
>  			reg =3D <0x3a00 0x100>;
> -			interrupts =3D <0x2 0x7 0x0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
> +			interrupts =3D <2 7 0>;
>  		};
> =20
>  		i2c@3d00 {
>  			#address-cells =3D <1>;
>  			#size-cells =3D <0>;
>  			compatible =3D "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
> -			cell-index =3D <0>;
>  			reg =3D <0x3d00 0x40>;
> -			interrupts =3D <0x2 0xf 0x0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
> +			interrupts =3D <2 15 0>;
>  			fsl5200-clocking;
>  		};
> =20
> @@ -294,10 +251,8 @@
>  			#address-cells =3D <1>;
>  			#size-cells =3D <0>;
>  			compatible =3D "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
> -			cell-index =3D <1>;
>  			reg =3D <0x3d40 0x40>;
> -			interrupts =3D <0x2 0x10 0x0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
> +			interrupts =3D <2 16 0>;
>  			fsl5200-clocking;
>  			rtc@51 {
>  				compatible =3D "nxp,pcf8563";
> @@ -307,7 +262,7 @@
>  		};
> =20
>  		sram@8000 {
> -			compatible =3D "fsl,mpc5200b-sram","fsl,mpc5200-sram","sram";
> +			compatible =3D "fsl,mpc5200b-sram","fsl,mpc5200-sram";
>  			reg =3D <0x8000 0x4000>;
>  		};
> =20
> @@ -340,22 +295,21 @@
>  		device_type =3D "pci";
>  		compatible =3D "fsl,mpc5200b-pci","fsl,mpc5200-pci";
>  		reg =3D <0xf0000d00 0x100>;
> -		interrupt-map-mask =3D <0xf800 0x0 0x0 0x7>;
> -		interrupt-map =3D <0xc000 0x0 0x0 0x1 &mpc5200_pic 0x0 0x0 0x3 /* 1st =
slot */
> -				 0xc000 0x0 0x0 0x2 &mpc5200_pic 0x1 0x1 0x3
> -				 0xc000 0x0 0x0 0x3 &mpc5200_pic 0x1 0x2 0x3
> -				 0xc000 0x0 0x0 0x4 &mpc5200_pic 0x1 0x3 0x3
> -
> -				 0xc800 0x0 0x0 0x1 &mpc5200_pic 0x1 0x1 0x3 /* 2nd slot */
> -				 0xc800 0x0 0x0 0x2 &mpc5200_pic 0x1 0x2 0x3
> -				 0xc800 0x0 0x0 0x3 &mpc5200_pic 0x1 0x3 0x3
> -				 0xc800 0x0 0x0 0x4 &mpc5200_pic 0x0 0x0 0x3>;
> +		interrupt-map-mask =3D <0xf800 0 0 7>;
> +		interrupt-map =3D <0xc000 0 0 1 &mpc5200_pic 0 0 3 // 1st slot
> +				 0xc000 0 0 2 &mpc5200_pic 1 1 3
> +				 0xc000 0 0 3 &mpc5200_pic 1 2 3
> +				 0xc000 0 0 4 &mpc5200_pic 1 3 3
> +
> +				 0xc800 0 0 1 &mpc5200_pic 1 1 3 // 2nd slot
> +				 0xc800 0 0 2 &mpc5200_pic 1 2 3
> +				 0xc800 0 0 3 &mpc5200_pic 1 3 3
> +				 0xc800 0 0 4 &mpc5200_pic 0 0 3>;
>  		clock-frequency =3D <0>; // From boot loader
> -		interrupts =3D <0x2 0x8 0x0 0x2 0x9 0x0 0x2 0xa 0x0>;
> -		interrupt-parent =3D <&mpc5200_pic>;
> +		interrupts =3D <2 8 0 2 9 0 2 10 0>;
>  		bus-range =3D <0 0>;
> -		ranges =3D <0x42000000 0x0 0x80000000 0x80000000 0x0 0x20000000
> -			  0x02000000 0x0 0xa0000000 0xa0000000 0x0 0x10000000
> -			  0x01000000 0x0 0x00000000 0xb0000000 0x0 0x01000000>;
> +		ranges =3D <0x42000000 0 0x80000000 0x80000000 0 0x20000000
> +			  0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
> +			  0x01000000 0 0x00000000 0xb0000000 0 0x01000000>;
>  	};
>  };
> diff --git a/arch/powerpc/boot/dts/tqm5200.dts b/arch/powerpc/boot/dts/tq=
m5200.dts
> index 906302e..c9590b5 100644
> --- a/arch/powerpc/boot/dts/tqm5200.dts
> +++ b/arch/powerpc/boot/dts/tqm5200.dts
> @@ -17,6 +17,7 @@
>  	compatible =3D "tqc,tqm5200";
>  	#address-cells =3D <1>;
>  	#size-cells =3D <1>;
> +	interrupt-parent =3D <&mpc5200_pic>;
> =20
>  	cpus {
>  		#address-cells =3D <1>;
> @@ -66,36 +67,33 @@
>  			compatible =3D "fsl,mpc5200-gpt";
>  			reg =3D <0x600 0x10>;
>  			interrupts =3D <1 9 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  			fsl,has-wdt;
>  		};
> =20
>  		can@900 {
>  			compatible =3D "fsl,mpc5200-mscan";
>  			interrupts =3D <2 17 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  			reg =3D <0x900 0x80>;
>  		};
> =20
>  		can@980 {
>  			compatible =3D "fsl,mpc5200-mscan";
>  			interrupts =3D <2 18 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  			reg =3D <0x980 0x80>;
>  		};
> =20
> -		gpio@b00 {
> +		gpio_simple: gpio@b00 {
>  			compatible =3D "fsl,mpc5200-gpio";
>  			reg =3D <0xb00 0x40>;
>  			interrupts =3D <1 7 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
> +			gpio-controller;
> +			#gpio-cells =3D <2>;
>  		};
> =20
>  		usb@1000 {
>  			compatible =3D "fsl,mpc5200-ohci","ohci-be";
>  			reg =3D <0x1000 0xff>;
>  			interrupts =3D <2 6 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		dma-controller@1200 {
> @@ -105,7 +103,6 @@
>  			              3 4 0  3 5 0  3 6 0  3 7 0
>  			              3 8 0  3 9 0  3 10 0  3 11 0
>  			              3 12 0  3 13 0  3 14 0  3 15 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		xlb@1f00 {
> @@ -114,39 +111,28 @@
>  		};
> =20
>  		serial@2000 {		// PSC1
> -			device_type =3D "serial";
>  			compatible =3D "fsl,mpc5200-psc-uart";
> -			port-number =3D <0>;  // Logical port assignment
>  			reg =3D <0x2000 0x100>;
>  			interrupts =3D <2 1 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		serial@2200 {		// PSC2
> -			device_type =3D "serial";
>  			compatible =3D "fsl,mpc5200-psc-uart";
> -			port-number =3D <1>;  // Logical port assignment
>  			reg =3D <0x2200 0x100>;
>  			interrupts =3D <2 2 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		serial@2400 {		// PSC3
> -			device_type =3D "serial";
>  			compatible =3D "fsl,mpc5200-psc-uart";
> -			port-number =3D <2>;  // Logical port assignment
>  			reg =3D <0x2400 0x100>;
>  			interrupts =3D <2 3 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		ethernet@3000 {
> -			device_type =3D "network";
>  			compatible =3D "fsl,mpc5200-fec";
>  			reg =3D <0x3000 0x400>;
>  			local-mac-address =3D [ 00 00 00 00 00 00 ];
>  			interrupts =3D <2 5 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  			phy-handle =3D <&phy0>;
>  		};
> =20
> @@ -156,10 +142,8 @@
>  			compatible =3D "fsl,mpc5200-mdio";
>  			reg =3D <0x3000 0x400>;       // fec range, since we need to setup fe=
c interrupts
>  			interrupts =3D <2 5 0>;   // these are for "mii command finished", no=
t link changes & co.
> -			interrupt-parent =3D <&mpc5200_pic>;
> =20
>  			phy0: ethernet-phy@0 {
> -				device_type =3D "ethernet-phy";
>  				reg =3D <0>;
>  			};
>  		};
> @@ -168,7 +152,6 @@
>  			compatible =3D "fsl,mpc5200-ata";
>  			reg =3D <0x3a00 0x100>;
>  			interrupts =3D <2 7 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  		};
> =20
>  		i2c@3d40 {
> @@ -177,7 +160,6 @@
>  			compatible =3D "fsl,mpc5200-i2c","fsl-i2c";
>  			reg =3D <0x3d40 0x40>;
>  			interrupts =3D <2 16 0>;
> -			interrupt-parent =3D <&mpc5200_pic>;
>  			fsl5200-clocking;
> =20
>  			 rtc@68 {
> @@ -192,9 +174,8 @@
>  		};
>  	};
> =20
> -	lpb {
> -		model =3D "fsl,lpb";
> -		compatible =3D "fsl,lpb";
> +	localbus {
> +		compatible =3D "fsl,mpc5200-lpb","simple-bus";
>  		#address-cells =3D <2>;
>  		#size-cells =3D <1>;
>  		ranges =3D <0 0 0xfc000000 0x02000000>;
> @@ -223,7 +204,6 @@
>  				 0xc000 0 0 4 &mpc5200_pic 0 0 3>;
>  		clock-frequency =3D <0>; // From boot loader
>  		interrupts =3D <2 8 0 2 9 0 2 10 0>;
> -		interrupt-parent =3D <&mpc5200_pic>;
>  		bus-range =3D <0 0>;
>  		ranges =3D <0x42000000 0 0x80000000 0x80000000 0 0x10000000
>  			  0x02000000 0 0x90000000 0x90000000 0 0x10000000
>=20

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmCHdsACgkQD27XaX1/VRsDLgCgm1+eNi8SYJRw6YnfiVz9vbbF
FhEAoLhXvaEq/4lElqUKbea2dD0Z8Ojt
=VI4N
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--
