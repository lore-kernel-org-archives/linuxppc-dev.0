Return-Path: <B38951@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0253.outbound.messaging.microsoft.com [213.199.154.253])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DF27F2C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Sep 2013 13:38:56 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: "Yang,Wei" <Wei.Yang@windriver.com>
Subject: RE: [PATCH] powerpc: Add I2C bus multiplexer node for B4 and T4240QDS
Date: Wed, 4 Sep 2013 03:37:39 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01D32795@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1378194704-29909-1-git-send-email-hongtao.jia@freescale.com>
 <52268C7E.4040209@windriver.com>
In-Reply-To: <52268C7E.4040209@windriver.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Wei,

I totally agree that the i2c nodes topology should end up like you said.

But I think adding sub-nodes should step by step.
Actually the hardware i2c topology are huge like on T4.
So I'd like to adding nodes when we needed.
If you think the sub-nodes are needed please send another patch based on mi=
ne.
I think this is the more reasonable way.

Thanks.

-Hongtao


> -----Original Message-----
> From: Yang,Wei [mailto:Wei.Yang@windriver.com]
> Sent: Wednesday, September 04, 2013 9:27 AM
> To: Jia Hongtao-B38951
> Cc: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421; Jia Hongtao-B38951
> Subject: Re: [PATCH] powerpc: Add I2C bus multiplexer node for B4 and
> T4240QDS
>=20
> On 09/03/2013 03:51 PM, Jia Hongtao wrote:
> > In both B4 and T4240QDS platform PCA9547 I2C bus multiplexer is used.
>=20
> Hi Hongtao,
>=20
> If you want to support I2C bus multiplexer, for T4 and B4QDS platform,
> since some eeprom devices is connected to PCA9574 I2C bus multiplexer, so
> these devices should be connected to pca9547 node. Just like the
> following, what do you think of it?
>=20
> +                       pca9547@77 {
> +                               compatible =3D "philips,pca9547";
> +                               reg =3D <0x77>;
> +                               #address-cells =3D <1>;
> +                               #size-cells =3D <0>;
> +                               channel@0 {
> +                                       #address-cells =3D <1>;
> +                                       #size-cells =3D <0>;
> +                                       reg =3D <0>;
> +                                               eeprom@51 {
> +                                                       compatible =3D
> "at24,24c256";
> +                                                       reg =3D <0x51>;
> +                                               };
> +                                               eeprom@52 {
> +                                                       compatible =3D
> "at24,24c256";
> +                                                       reg =3D <0x52>;
> +                                               };
> +                                               eeprom@53 {
> +                                                       compatible =3D
> "at24,24c256";
> +                                                       reg =3D <0x53>;
> +                                               };
> +                                               eeprom@54 {
> +                                                       compatible =3D
> "at24,24c256";
> +                                                       reg =3D <0x54>;
> +                                               };
> +                                               eeprom@55 {
> +                                                       compatible =3D
> "at24,24c256";
> +                                                       reg =3D <0x55>;
> +                                               };
> +                                               eeprom@56 {
> +                                                       compatible =3D
> "at24,24c256";
> +                                                       reg =3D <0x56>;
> +                                               };
> +                                               rtc@68 {
> +                                                       compatible =3D
> "dallas,ds3232";
> +                                                       reg =3D <0x68>;
> +                                                       interrupts =3D
> <0x1 0x1 0 0>;
> +                                               };
> +                                       };
>=20
> Wei
> >
> > Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
> > ---
> >   arch/powerpc/boot/dts/b4qds.dtsi   | 4 ++++
> >   arch/powerpc/boot/dts/t4240qds.dts | 4 ++++
> >   2 files changed, 8 insertions(+)
> >
> > diff --git a/arch/powerpc/boot/dts/b4qds.dtsi
> > b/arch/powerpc/boot/dts/b4qds.dtsi
> > index e6d2f8f..2aa3399 100644
> > --- a/arch/powerpc/boot/dts/b4qds.dtsi
> > +++ b/arch/powerpc/boot/dts/b4qds.dtsi
> > @@ -120,6 +120,10 @@
> >   		};
> >
> >   		i2c@118000 {
> > +			pca9547@77 {
> > +				compatible =3D "philips,pca9547";
> > +				reg =3D <0x77>;
> > +			};
> >   			eeprom@50 {
> >   				compatible =3D "at24,24c64";
> >   				reg =3D <0x50>;
> > diff --git a/arch/powerpc/boot/dts/t4240qds.dts
> > b/arch/powerpc/boot/dts/t4240qds.dts
> > index 0555976..084db57 100644
> > --- a/arch/powerpc/boot/dts/t4240qds.dts
> > +++ b/arch/powerpc/boot/dts/t4240qds.dts
> > @@ -118,6 +118,10 @@
> >   		};
> >
> >   		i2c@118000 {
> > +			pca9547@77 {
> > +				compatible =3D "philips,pca9547";
> > +				reg =3D <0x77>;
> > +			};
> >   			eeprom@51 {
> >   				compatible =3D "at24,24c256";
> >   				reg =3D <0x51>;
>=20
