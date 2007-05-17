Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 51B10DDEC9
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 12:50:27 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l4H2oLjA013778
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 19:50:22 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l4H2oKYL020565
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 21:50:21 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 5/5] PCI fixes for the MPC8641 Rev 2.0 silicon and Rev
	1.02hardware
Date: Thu, 17 May 2007 10:50:18 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C23441B@zch01exm26.fsl.freescale.net>
In-Reply-To: <1179247809.8132.138.camel@rhino>
References: <1179245829.8132.100.camel@rhino> <1179247809.8132.138.camel@rhino>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Wade Farnsworth" <wfarnsworth@mvista.com>,
	"linuxppc-dev" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,=20

If you add below sector to pci@8000, please remove the interrupt-map
sector from pci@8000.
> @@ -286,6 +286,125 @@
>  				f800 0 0 4 &i8259 0 0
>  				>;
> =20
> +			pci@00 {
> +				device_type =3D "pci";
> +				#interrupt-cells =3D <1>;
> +				#size-cells =3D <2>;
> +				#address-cells =3D <3>;
> +				reg =3D <0000 0 0 0 0>;
> +				bus-range =3D <0 fe>;
> +				ranges =3D <02000000 0 80000000 80000000 0
> +					  20000000
> +					  01000000 0 00000000 00000000 0
> +					  00100000>;
> +
> +				pci@00 {
> +					device_type =3D "pci";
> +					#interrupt-cells =3D <1>;
> +					#size-cells =3D <2>;
> +					#address-cells =3D <3>;
> +					reg =3D <0000 0 0 0 0>;
> +					bus-range =3D <1 fe>;
> +					ranges =3D <02000000 0=20
> 80000000 80000000
> +						  0 20000000
> +						  01000000 0=20
> 00000000 00000000
> +						  0 00100000>;
> +					interrupt-map-mask =3D=20
> <3f800 0 0 7>;
> +					interrupt-map =3D <
> +						/* IDSEL 0x11 */
> +						28800 0 0 1 &i8259 3 2
> +						28800 0 0 2 &i8259 4 2
> +						28800 0 0 3 &i8259 5 2
> +						28800 0 0 4 &i8259 6 2
> +
> +						/* IDSEL 0x12 */
> +						29000 0 0 1 &i8259 4 2
> +						29000 0 0 2 &i8259 5 2
> +						29000 0 0 3 &i8259 6 2
> +						29000 0 0 4 &i8259 3 2
> +
> +						/* IDSEL 0x13 */
> +						29800 0 0 1 &i8259 0 0
> +						29800 0 0 2 &i8259 0 0
> +						29800 0 0 3 &i8259 0 0
> +						29800 0 0 4 &i8259 0 0
> +
> +						/* IDSEL 0x14 */
> +						2a000 0 0 1 &i8259 0 0
> +						2a000 0 0 2 &i8259 0 0
> +						2a000 0 0 3 &i8259 0 0
> +						2a000 0 0 4 &i8259 0 0
> +
> +						/* IDSEL 0x15 */
> +						2a800 0 0 1 &i8259 0 0
> +						2a800 0 0 2 &i8259 0 0
> +						2a800 0 0 3 &i8259 0 0
> +						2a800 0 0 4 &i8259 0 0
> +
> +						/* IDSEL 0x16 */
> +						2b000 0 0 1 &i8259 0 0
> +						2b000 0 0 2 &i8259 0 0
> +						2b000 0 0 3 &i8259 0 0
> +						2b000 0 0 4 &i8259 0 0
> +
> +						/* IDSEL 0x17 */
> +						2b800 0 0 1 &i8259 0 0
> +						2b800 0 0 2 &i8259 0 0
> +						2b800 0 0 3 &i8259 0 0
> +						2b800 0 0 4 &i8259 0 0
> +
> +						/* IDSEL 0x18 */
> +						2c000 0 0 1 &i8259 0 0
> +						2c000 0 0 2 &i8259 0 0
> +						2c000 0 0 3 &i8259 0 0
> +						2c000 0 0 4 &i8259 0 0
> +
> +						/* IDSEL 0x19 */
> +						2c800 0 0 1 &i8259 0 0
> +						2c800 0 0 2 &i8259 0 0
> +						2c800 0 0 3 &i8259 0 0
> +						2c800 0 0 4 &i8259 0 0
> +
> +						/* IDSEL 0x1a */
> +						2d000 0 0 1 &i8259 6 2
> +						2d000 0 0 2 &i8259 3 2
> +						2d000 0 0 3 &i8259 4 2
> +						2d000 0 0 4 &i8259 5 2
> +
> +						/* IDSEL 0x1b */
> +						2d800 0 0 1 &i8259 5 2
> +						2d800 0 0 2 &i8259 0 0
> +						2d800 0 0 3 &i8259 0 0
> +						2d800 0 0 4 &i8259 0 0
> +
> +						/* IDSEL 0x1c */
> +						2e000 0 0 1 &i8259 9 2
> +						2e000 0 0 2 &i8259 a 2
> +						2e000 0 0 3 &i8259 b 2
> +						2e000 0 0 4 &i8259 7 2
> +
> +						/* IDSEL 0x1d */
> +						2e800 0 0 1 &i8259 9 2
> +						2e800 0 0 2 &i8259 a 2
> +						2e800 0 0 3 &i8259 b 2
> +						2e800 0 0 4 &i8259 0 0
> +
> +						/* IDSEL 0x1e */
> +						2f000 0 0 1 &i8259 b 2
> +						2f000 0 0 2 &i8259 0 0
> +						2f000 0 0 3 &i8259 0 0
> +						2f000 0 0 4 &i8259 0 0
> +
> +						/* IDSEL 0x1f */
> +						2f800 0 0 1 &i8259 6 2
> +						2f800 0 0 2 &i8259 0 0
> +						2f800 0 0 3 &i8259 0 0
> +						2f800 0 0 4 &i8259 0 0
> +						>;
> +					};
> +				};
> +
> +
>  			isa@f0 {
>  				device_type =3D "isa";
>  				#interrupt-cells =3D <2>;
> @@ -335,7 +454,7 @@
>  			#size-cells =3D <2>;
>  			#address-cells =3D <3>;
>  			reg =3D <9000 1000>;
> -			bus-range =3D <0 ff>;
> +			bus-range =3D <3 ff>;
>  			ranges =3D <02000000 0 a0000000 a0000000=20
> 0 20000000
>  				  01000000 0 00000000 e3000000=20
> 0 00100000>;
>  			clock-frequency =3D <1fca055>;

Best Regards,
Zhang Wei
