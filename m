Return-Path: <B38951@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DBD622C00F0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Sep 2013 13:33:44 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, Wood Scott-B07421
 <B07421@freescale.com>
Subject: RE: [PATCH V2] powerpc: Add I2C bus multiplexer node for B4 and
 T4240QDS
Date: Fri, 6 Sep 2013 03:33:36 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01D4824D@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1378348907-3137-1-git-send-email-hongtao.jia@freescale.com>
 <7BA50BB5-9A63-4EA5-91E4-D04576892AAF@kernel.crashing.org>
In-Reply-To: <7BA50BB5-9A63-4EA5-91E4-D04576892AAF@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "Wei.Yang@windriver.com" <Wei.Yang@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Friday, September 06, 2013 2:41 AM
> To: Jia Hongtao-B38951
> Cc: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421;
> Wei.Yang@windriver.com
> Subject: Re: [PATCH V2] powerpc: Add I2C bus multiplexer node for B4 and
> T4240QDS
>=20
>=20
> On Sep 4, 2013, at 9:41 PM, Jia Hongtao wrote:
>=20
> > In both B4 and T4240QDS platform PCA9547 I2C bus multiplexer is used.
> > The sub-nodes are also reorganized according to right I2C topology.
> >
> > Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
> > ---
> > V2 change log:
> > Reorganized the sub-nodes under I2C multiplexer to represent right
> topology.
> >
> > arch/powerpc/boot/dts/b4qds.dtsi   | 49 +++++++++++++++++-----------
> > arch/powerpc/boot/dts/t4240qds.dts | 67 ++++++++++++++++++++++---------
> -------
> > 2 files changed, 69 insertions(+), 47 deletions(-)
> >
> > diff --git a/arch/powerpc/boot/dts/b4qds.dtsi
> b/arch/powerpc/boot/dts/b4qds.dtsi
> > index e6d2f8f..de8cb38 100644
> > --- a/arch/powerpc/boot/dts/b4qds.dtsi
> > +++ b/arch/powerpc/boot/dts/b4qds.dtsi
> > @@ -120,25 +120,36 @@
> > 		};
> >
> > 		i2c@118000 {
> > -			eeprom@50 {
> > -				compatible =3D "at24,24c64";
> > -				reg =3D <0x50>;
> > -			};
> > -			eeprom@51 {
> > -				compatible =3D "at24,24c256";
> > -				reg =3D <0x51>;
> > -			};
> > -			eeprom@53 {
> > -				compatible =3D "at24,24c256";
> > -				reg =3D <0x53>;
> > -			};
> > -			eeprom@57 {
> > -				compatible =3D "at24,24c256";
> > -				reg =3D <0x57>;
> > -			};
> > -			rtc@68 {
> > -				compatible =3D "dallas,ds3232";
> > -				reg =3D <0x68>;
> > +			pca9547@77 {
> > +				compatible =3D "philips,pca9547";
>=20
> We seem to be using nxp instead of philips now.
>=20
> > +				reg =3D <0x77>;
> > +				#address-cells =3D <1>;
> > +				#size-cells =3D <0>;
> > +				channel@0 {
>=20
> channel should probably be i2c


Is there any standard for the name?
i2c is ok but I think channel is more intuitional.

Hi Scott,
What do you think of it.

Thanks.
-Hongtao


>=20
> [same comments below]
>=20
> > +					#address-cells =3D <1>;
> > +					#size-cells =3D <0>;
> > +					reg =3D <0>;
> > +					eeprom@50 {
> > +						compatible =3D "at24,24c64";
> > +						reg =3D <0x50>;
> > +					};
> > +					eeprom@51 {
> > +						compatible =3D "at24,24c256";
> > +						reg =3D <0x51>;
> > +					};
> > +					eeprom@53 {
> > +						compatible =3D "at24,24c256";
> > +						reg =3D <0x53>;
> > +					};
> > +					eeprom@57 {
> > +						compatible =3D "at24,24c256";
> > +						reg =3D <0x57>;
> > +					};
> > +					rtc@68 {
> > +						compatible =3D "dallas,ds3232";
> > +						reg =3D <0x68>;
> > +					};
> > +				};
> > 			};
> > 		};
> >
> > diff --git a/arch/powerpc/boot/dts/t4240qds.dts
> b/arch/powerpc/boot/dts/t4240qds.dts
> > index 0555976..ae68595 100644
> > --- a/arch/powerpc/boot/dts/t4240qds.dts
> > +++ b/arch/powerpc/boot/dts/t4240qds.dts
> > @@ -118,34 +118,45 @@
> > 		};
> >
> > 		i2c@118000 {
> > -			eeprom@51 {
> > -				compatible =3D "at24,24c256";
> > -				reg =3D <0x51>;
> > -			};
> > -			eeprom@52 {
> > -				compatible =3D "at24,24c256";
> > -				reg =3D <0x52>;
> > -			};
> > -			eeprom@53 {
> > -				compatible =3D "at24,24c256";
> > -				reg =3D <0x53>;
> > -			};
> > -			eeprom@54 {
> > -				compatible =3D "at24,24c256";
> > -				reg =3D <0x54>;
> > -			};
> > -			eeprom@55 {
> > -				compatible =3D "at24,24c256";
> > -				reg =3D <0x55>;
> > -			};
> > -			eeprom@56 {
> > -				compatible =3D "at24,24c256";
> > -				reg =3D <0x56>;
> > -			};
> > -			rtc@68 {
> > -				compatible =3D "dallas,ds3232";
> > -				reg =3D <0x68>;
> > -				interrupts =3D <0x1 0x1 0 0>;
> > +			pca9547@77 {
> > +				compatible =3D "philips,pca9547";
> > +				reg =3D <0x77>;
> > +				#address-cells =3D <1>;
> > +				#size-cells =3D <0>;
> > +				channel@0 {
> > +					#address-cells =3D <1>;
> > +					#size-cells =3D <0>;
> > +					reg =3D <0>;
> > +					eeprom@51 {
> > +						compatible =3D "at24,24c256";
> > +						reg =3D <0x51>;
> > +					};
> > +					eeprom@52 {
> > +						compatible =3D "at24,24c256";
> > +						reg =3D <0x52>;
> > +					};
> > +					eeprom@53 {
> > +						compatible =3D "at24,24c256";
> > +						reg =3D <0x53>;
> > +					};
> > +					eeprom@54 {
> > +						compatible =3D "at24,24c256";
> > +						reg =3D <0x54>;
> > +					};
> > +					eeprom@55 {
> > +						compatible =3D "at24,24c256";
> > +						reg =3D <0x55>;
> > +					};
> > +					eeprom@56 {
> > +						compatible =3D "at24,24c256";
> > +						reg =3D <0x56>;
> > +					};
> > +					rtc@68 {
> > +						compatible =3D "dallas,ds3232";
> > +						reg =3D <0x68>;
> > +						interrupts =3D <0x1 0x1 0 0>;
> > +					};
> > +				};
> > 			};
> > 		};
> > 	};
> > --
> > 1.8.0
> >
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
>=20
