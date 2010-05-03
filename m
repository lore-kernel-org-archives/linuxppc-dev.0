Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 7402AB6EFF
	for <linuxppc-dev@ozlabs.org>; Mon,  3 May 2010 19:22:16 +1000 (EST)
Date: Mon, 3 May 2010 11:22:08 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] powerpc/mpc5121: add initial support for PDM360NG
	board
Message-ID: <20100503112208.1945893f@wker>
In-Reply-To: <g2tfa686aa41005020754t46934f13hbd5c75a6b7668a54@mail.gmail.com>
References: <1272659448-23302-1-git-send-email-agust@denx.de>
	<1272659448-23302-2-git-send-email-agust@denx.de>
	<g2tfa686aa41005020754t46934f13hbd5c75a6b7668a54@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Detlev Zundel <dzu@denx.de>, Markus Fischer <markus.fischer.ec@ifm.com>,
	devicetree-discuss@lists.ozlabs.org,
	Michael Weiss <michael.weiss@ifm.com>, linuxppc-dev@ozlabs.org,
	Wolfgang Grandegger <wg@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Grant,

On Sun, 2 May 2010 08:54:26 -0600
Grant Likely <grant.likely@secretlab.ca> wrote:

> Hi Anatolij,
>=20
> Comments below.
>=20
> On Fri, Apr 30, 2010 at 2:30 PM, Anatolij Gustschin <agust@denx.de> wrote:
> > Adds IFM PDM360NG device tree, and platform code.

...
> > + =A0 =A0 =A0 nfc@40000000 {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121-nfc";
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x40000000 0x100000>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <0x6 0x8>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <0x1>;
>=20
> This looks wrong.  Shouldn't this be interrupt-parent =3D <&ipic>?  In
> fact, if the root node has interrupt-parent =3D <&ipic> then the
> interrupt-parent property can be omitted from all other nodes unless
> they need to override it.

Yes, it should be interrupt-parent =3D <&ipic>. I will fix it, thanks.

...
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 // IPIC
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 // interrupts cell =3D <intr #, sense>
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 // sense values match linux IORESOURCE_IR=
Q_* defines:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 // sense =3D=3D 8: Level, low assertion
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 // sense =3D=3D 2: Edge, high-to-low chan=
ge
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 //
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ipic: interrupt-controller@c00 {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc51=
21-ipic", "fsl,ipic";
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-controller;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <0>;
>=20
> Don't need #address-cells here

Ok, will remove.

...
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdio@2800 {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc51=
21-fec-mdio";
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x2800 0x200>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 phy: ethernet-phy@0 {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <=
0x1f>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_ty=
pe =3D "ethernet-phy";
>=20
> Remove device_type

Ok.

> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ethernet@2800 {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "network";
>=20
> Ditto

Removing this property results in not functional ethernet,
in particular, the MAC address won't be set by U-Boot. I need
to add aliases node for ethernet0 to fix this. Ok, will remove
this device_type, too.

Thanks,
Anatolij
