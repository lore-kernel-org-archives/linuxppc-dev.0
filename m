Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5EC482C00D7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Sep 2013 04:41:10 +1000 (EST)
Subject: Re: [PATCH V2] powerpc: Add I2C bus multiplexer node for B4 and
 T4240QDS
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1378348907-3137-1-git-send-email-hongtao.jia@freescale.com>
Date: Thu, 5 Sep 2013 13:41:09 -0500
Message-Id: <7BA50BB5-9A63-4EA5-91E4-D04576892AAF@kernel.crashing.org>
References: <1378348907-3137-1-git-send-email-hongtao.jia@freescale.com>
To: Jia Hongtao <hongtao.jia@freescale.com>
Cc: B07421@freescale.com, linuxppc-dev@lists.ozlabs.org, Wei.Yang@windriver.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 4, 2013, at 9:41 PM, Jia Hongtao wrote:

> In both B4 and T4240QDS platform PCA9547 I2C bus multiplexer is used.
> The sub-nodes are also reorganized according to right I2C topology.
>=20
> Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
> ---
> V2 change log:
> Reorganized the sub-nodes under I2C multiplexer to represent right =
topology.
>=20
> arch/powerpc/boot/dts/b4qds.dtsi   | 49 +++++++++++++++++-----------
> arch/powerpc/boot/dts/t4240qds.dts | 67 =
++++++++++++++++++++++----------------
> 2 files changed, 69 insertions(+), 47 deletions(-)
>=20
> diff --git a/arch/powerpc/boot/dts/b4qds.dtsi =
b/arch/powerpc/boot/dts/b4qds.dtsi
> index e6d2f8f..de8cb38 100644
> --- a/arch/powerpc/boot/dts/b4qds.dtsi
> +++ b/arch/powerpc/boot/dts/b4qds.dtsi
> @@ -120,25 +120,36 @@
> 		};
>=20
> 		i2c@118000 {
> -			eeprom@50 {
> -				compatible =3D "at24,24c64";
> -				reg =3D <0x50>;
> -			};
> -			eeprom@51 {
> -				compatible =3D "at24,24c256";
> -				reg =3D <0x51>;
> -			};
> -			eeprom@53 {
> -				compatible =3D "at24,24c256";
> -				reg =3D <0x53>;
> -			};
> -			eeprom@57 {
> -				compatible =3D "at24,24c256";
> -				reg =3D <0x57>;
> -			};
> -			rtc@68 {
> -				compatible =3D "dallas,ds3232";
> -				reg =3D <0x68>;
> +			pca9547@77 {
> +				compatible =3D "philips,pca9547";

We seem to be using nxp instead of philips now.

> +				reg =3D <0x77>;
> +				#address-cells =3D <1>;
> +				#size-cells =3D <0>;
> +				channel@0 {

channel should probably be i2c

[same comments below]

> +					#address-cells =3D <1>;
> +					#size-cells =3D <0>;
> +					reg =3D <0>;
> +					eeprom@50 {
> +						compatible =3D =
"at24,24c64";
> +						reg =3D <0x50>;
> +					};
> +					eeprom@51 {
> +						compatible =3D =
"at24,24c256";
> +						reg =3D <0x51>;
> +					};
> +					eeprom@53 {
> +						compatible =3D =
"at24,24c256";
> +						reg =3D <0x53>;
> +					};
> +					eeprom@57 {
> +						compatible =3D =
"at24,24c256";
> +						reg =3D <0x57>;
> +					};
> +					rtc@68 {
> +						compatible =3D =
"dallas,ds3232";
> +						reg =3D <0x68>;
> +					};
> +				};
> 			};
> 		};
>=20
> diff --git a/arch/powerpc/boot/dts/t4240qds.dts =
b/arch/powerpc/boot/dts/t4240qds.dts
> index 0555976..ae68595 100644
> --- a/arch/powerpc/boot/dts/t4240qds.dts
> +++ b/arch/powerpc/boot/dts/t4240qds.dts
> @@ -118,34 +118,45 @@
> 		};
>=20
> 		i2c@118000 {
> -			eeprom@51 {
> -				compatible =3D "at24,24c256";
> -				reg =3D <0x51>;
> -			};
> -			eeprom@52 {
> -				compatible =3D "at24,24c256";
> -				reg =3D <0x52>;
> -			};
> -			eeprom@53 {
> -				compatible =3D "at24,24c256";
> -				reg =3D <0x53>;
> -			};
> -			eeprom@54 {
> -				compatible =3D "at24,24c256";
> -				reg =3D <0x54>;
> -			};
> -			eeprom@55 {
> -				compatible =3D "at24,24c256";
> -				reg =3D <0x55>;
> -			};
> -			eeprom@56 {
> -				compatible =3D "at24,24c256";
> -				reg =3D <0x56>;
> -			};
> -			rtc@68 {
> -				compatible =3D "dallas,ds3232";
> -				reg =3D <0x68>;
> -				interrupts =3D <0x1 0x1 0 0>;
> +			pca9547@77 {
> +				compatible =3D "philips,pca9547";
> +				reg =3D <0x77>;
> +				#address-cells =3D <1>;
> +				#size-cells =3D <0>;
> +				channel@0 {
> +					#address-cells =3D <1>;
> +					#size-cells =3D <0>;
> +					reg =3D <0>;
> +					eeprom@51 {
> +						compatible =3D =
"at24,24c256";
> +						reg =3D <0x51>;
> +					};
> +					eeprom@52 {
> +						compatible =3D =
"at24,24c256";
> +						reg =3D <0x52>;
> +					};
> +					eeprom@53 {
> +						compatible =3D =
"at24,24c256";
> +						reg =3D <0x53>;
> +					};
> +					eeprom@54 {
> +						compatible =3D =
"at24,24c256";
> +						reg =3D <0x54>;
> +					};
> +					eeprom@55 {
> +						compatible =3D =
"at24,24c256";
> +						reg =3D <0x55>;
> +					};
> +					eeprom@56 {
> +						compatible =3D =
"at24,24c256";
> +						reg =3D <0x56>;
> +					};
> +					rtc@68 {
> +						compatible =3D =
"dallas,ds3232";
> +						reg =3D <0x68>;
> +						interrupts =3D <0x1 0x1 =
0 0>;
> +					};
> +				};
> 			};
> 		};
> 	};
> --=20
> 1.8.0
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
