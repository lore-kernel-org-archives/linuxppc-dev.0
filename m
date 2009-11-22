Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f223.google.com (mail-gx0-f223.google.com
	[209.85.217.223]) by ozlabs.org (Postfix) with ESMTP id AB522B6F10
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Nov 2009 10:18:28 +1100 (EST)
Received: by gxk23 with SMTP id 23so5460593gxk.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 22 Nov 2009 15:18:26 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 22 Nov 2009 16:18:06 -0700
Message-ID: <fa686aa40911221518s5d82d5b4i8402a297d52a46d1@mail.gmail.com>
Subject: Re: [RFC PATCH 04/19] powerpc: wii: device tree
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
> Add a device tree source file for the Nintendo Wii video game console.
>
> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>

Same comments apply here as for the gamecube.dts file, plus a few more belo=
w.

Cheers,
g.

> ---
> =A0arch/powerpc/boot/dts/wii.dts | =A0244 +++++++++++++++++++++++++++++++=
++++++++++
> =A01 files changed, 244 insertions(+), 0 deletions(-)
> =A0create mode 100644 arch/powerpc/boot/dts/wii.dts
>
> diff --git a/arch/powerpc/boot/dts/wii.dts b/arch/powerpc/boot/dts/wii.dt=
s
> new file mode 100644
> index 0000000..a30a804
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/wii.dts
> @@ -0,0 +1,244 @@
> +/*
> + * arch/powerpc/boot/dts/wii.dts
> + *
> + * Nintendo Wii platform device tree source
> + * Copyright (C) 2008-2009 The GameCube Linux Team
> + * Copyright (C) 2008,2009 Albert Herranz
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
> +/memreserve/ 0x01800000 0xe800000; =A0 =A0 /* memory hole (includes I/O =
area) */
> +/memreserve/ 0x10000000 0x0004000; =A0 =A0 /* DSP RAM */

This bothers me... see below.

> +
> +/ {
> + =A0 =A0 =A0 model =3D "NintendoWii";
> + =A0 =A0 =A0 compatible =3D "nintendo,wii";
> + =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 #size-cells =3D <1>;
> +
> + =A0 =A0 =A0 chosen {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* root filesystem on 2nd partition of SD c=
ard */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bootargs =3D "nobats root=3D/dev/mmcblk0p2 =
rootwait udbg-immortal";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 linux,stdout-path =3D &USBGECKO0;
> + =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 aliases {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ugecon =3D &USBGECKO0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hw_gpio =3D &gpio1;
> + =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* The Nintendo Wii has two discontiguous RAM memory area=
s called
> + =A0 =A0 =A0 =A0* MEM1 and MEM2.
> + =A0 =A0 =A0 =A0* MEM1 starts at 0x00000000 and contains 24MB of 1T-SRAM=
.
> + =A0 =A0 =A0 =A0* MEM2 starts at 0x10000000 and contains 64MB of DDR2 RA=
M.
> + =A0 =A0 =A0 =A0* Between both memory address ranges there is an address=
 space
> + =A0 =A0 =A0 =A0* where memory-mapped I/O registers are found.
> + =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0* Currently, Linux 32-bit PowerPC does not support RAM i=
n
> + =A0 =A0 =A0 =A0* discontiguous memory address spaces. Thus, in order to=
 use
> + =A0 =A0 =A0 =A0* both RAM areas, we declare as RAM the range from the s=
tart of
> + =A0 =A0 =A0 =A0* MEM1 to the end of useable MEM2 and exclude the needed=
 parts
> + =A0 =A0 =A0 =A0* with /memreserve/ statements, at the expense of wastin=
g a bit
> + =A0 =A0 =A0 =A0* of memory.

Hmmm.  It's not great practice to lie about hardware in the device
tree.  Better to describe the memory correctly here, and if you have
to work around Linux deficiencies, then do so in the platform support
code (arch/platforms/*).  I won't NAK the patch over it (feel free to
add my Acked-by line) because it doesn't impact other platforms, but
it should be fixed.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c-video {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "virtual,i2c=
-gpio";

There isn't a documented binding for this.  Is there a driver for it?

> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpios =3D <&gpio0 =A016 0 /=
* 31-15 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&gpio0 =
=A017 0 /* 31-14 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 >;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sda-is-open-drain =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sda-enforce-dir =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 scl-is-open-drain =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 scl-is-output-only =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay =3D <2>;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 audio-video-encoder {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =
=3D "nintendo,wii-ave-rvl";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x=
70>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 };
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
