Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f187.google.com (mail-yw0-f187.google.com
	[209.85.211.187]) by ozlabs.org (Postfix) with ESMTP id 93ED1B7C0D
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Nov 2009 10:03:19 +1100 (EST)
Received: by ywh17 with SMTP id 17so4633272ywh.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 22 Nov 2009 15:03:18 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 22 Nov 2009 16:02:58 -0700
Message-ID: <fa686aa40911221502g2de254d2o4341d9abed0cdf41@mail.gmail.com>
Subject: Re: [RFC PATCH 02/19] powerpc: gamecube: device tree
To: Albert Herranz <albert_herranz@yahoo.es>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Nov 22, 2009 at 3:01 PM, Albert Herranz <albert_herranz@yahoo.es> w=
rote:
> Add a device tree source file for the Nintendo GameCube video game consol=
e.
>
> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>

Mostly looks good.  A few comments below.  Biggest comment is you need
to add a brief blurb for every new "compatible" property value that
you've added to Documentation/powerpc/dts-bindings.  General agreement
is that we don't merge drivers with new OF tree bindings unless the
binding is also documented.  It doesn't need to be long, it just needs
to state what the device is, and what properties are expected.  If you
define new properties, then you need to state what they are used for.

Once the comments below are addressed...

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> =A0arch/powerpc/boot/dts/gamecube.dts | =A0135 ++++++++++++++++++++++++++=
++++++++++
> =A01 files changed, 135 insertions(+), 0 deletions(-)
> =A0create mode 100644 arch/powerpc/boot/dts/gamecube.dts
>
> diff --git a/arch/powerpc/boot/dts/gamecube.dts b/arch/powerpc/boot/dts/g=
amecube.dts
> new file mode 100644
> index 0000000..941a2c4
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/gamecube.dts
> @@ -0,0 +1,135 @@
> +/*
> + * arch/powerpc/boot/dts/gamecube.dts
> + *
> + * Nintendo GameCube platform device tree source
> + * Copyright (C) 2007-2009 The GameCube Linux Team
> + * Copyright (C) 2007,2008,2009 Albert Herranz
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + */
> +
> +/dts-v1/;
> +
> +/ {
> + =A0 =A0 =A0 model =3D "NintendoGameCube";
> + =A0 =A0 =A0 compatible =3D "nintendo,gamecube";

To date, we've been using the same form for both the model and
compatible properties.  Specifically the <vendor>,<model> form to
maintain the namespace.

> + =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 #size-cells =3D <1>;
> +
> + =A0 =A0 =A0 chosen {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bootargs =3D "root=3D/dev/gcnsda2 rootwait =
udbg-immortal";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 linux,stdout-path =3D &USBGECKO0;
> + =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 aliases {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ugecon =3D &USBGECKO0;
> + =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 memory {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "memory";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* 24M minus framebuffer memory area (640*5=
76*2*2) */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x00000000 0x01698000>;
> + =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 cpus {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0>;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PowerPC,gekko@0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "cpu";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock-frequency =3D <486000=
000>; /* 486MHz */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus-frequency =3D <16200000=
0>; /* 162MHz core-to-bus 3x */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timebase-frequency =3D <405=
00000>; /* 162MHz / 4 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i-cache-line-size =3D <32>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d-cache-line-size =3D <32>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i-cache-size =3D <32768>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d-cache-size =3D <32768>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 /* devices contained int the flipper chipset */
> + =A0 =A0 =A0 soc {

It would be better to rename this as IMMR or the bus type.  This node
doesn't actually describe the entire chip, but describes the internal
memory mapped registers.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #interrupt-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 model =3D "flipper";

Drop the model property

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "nintendo,flipper";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock-frequency =3D <162000000>; /* 162MHz =
*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ranges =3D <0x0c000000 0x0c000000 0x0001000=
0>;

Since you're only doing 1:1 mappings; you could replace this with an
empty "ranges;" property instead.

> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 video@0c002000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "nintendo,fl=
ipper-video";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x0c002000 0x100>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <8>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&pic>=
;

Hint:  If you move the interrupt-parent property up to the root node,
then you don't need to specify it in every single device node; it will
just inherit from the parent.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* XFB is the eXternal Fram=
eBuffer */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xfb-start =3D <0x01698000>;=
 /* end-of-ram - xfb-size */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xfb-size =3D <0x168000>;

Can 'xfb' be made a second tuple to the 'reg' property so that all the
address mapping code works on it?  ie:

reg =3D <0x0c002000 0x100
       0x01698000 0x168000>;

At the very least, it is wise to adopt the same form as the reg
property when describing address ranges instead of splitting it into
multiple properties.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pic: pic@0c003000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #interrupt-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "nintendo,fl=
ipper-pic";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x0c003000 0x8>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-controller;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 resetswitch@0c003000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "nintendo,fl=
ipper-resetswitch";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x0c003000 0x4>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&pic>=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 auxram@0c005000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "nintendo,fl=
ipper-auxram";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x0c005000 0x200>;=
 =A0 =A0 =A0 /* DSP */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <6>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&pic>=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 audio@0c005000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "nintendo,fl=
ipper-audio";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x0c005000 0x200 =
=A0 =A0 =A0 =A0 /* DSP */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0c006c00 0=
x20>; =A0 =A0 =A0 =A0/* AI */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <6>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&pic>=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 disk@0c006000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "nintendo,fl=
ipper-disk";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x0c006000 0x40>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <2>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&pic>=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial@0c006400 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "nintendo,fl=
ipper-serial";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x0c006400 0x100>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <3>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&pic>=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* External Interface bus */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 exi@0c006800 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "nintendo,fl=
ipper-exi";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x0c006800 0x40>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <4>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&pic>=
;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USBGECKO0: usbgecko@0c00681=
4 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =
=3D "usbgecko,usbgecko";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x=
0c006814 0x14>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 virtual-reg=
 =3D <0xcc006814>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 =A0};
> +};
> +
> --
> 1.6.3.3
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
