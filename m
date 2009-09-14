Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 36F4CB7B88
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Sep 2009 23:43:40 +1000 (EST)
Received: from mail-yw0-f180.google.com (mail-yw0-f180.google.com
	[209.85.211.180]) by ozlabs.org (Postfix) with ESMTP id 9490EDDD0B
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2009 23:43:39 +1000 (EST)
Received: by ywh10 with SMTP id 10so645449ywh.1
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2009 06:43:37 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4AADF93C.3030604@denx.de>
References: <4AADF93C.3030604@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 14 Sep 2009 07:43:16 -0600
Message-ID: <fa686aa40909140643j3183e181x49be002941ae5c36@mail.gmail.com>
Subject: Re: [PATCH] mpc5200: support for the MAN mpc5200 based board mucmc52
To: hs@denx.de
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Heiko.

Comments below.

On Mon, Sep 14, 2009 at 2:05 AM, Heiko Schocher <hs@denx.de> wrote:
> - serial Console on PSC1
> - 64MB SDRAM
> - MTD CFI Flash
> - Ethernet FEC
> - I2C with PCF8563 and Temp. Sensor ADM9240
> - IDE support
>
> Signed-off-by: Heiko Schocher <hs@denx.de>
>
> =A0arch/powerpc/boot/dts/mucmc52.dts =A0 =A0 =A0 =A0 =A0 =A0| =A0231 ++++
> =A0arch/powerpc/configs/52xx/mucmc52_defconfig =A0| 1476 ++++++++++++++++=
++++++++++

Same comment as on your other patch.  Drop the defconfig and add the
needed bits to mpc5200_defconfig (in a separate patch, and add drivers
as modules).

> diff --git a/arch/powerpc/boot/dts/mucmc52.dts b/arch/powerpc/boot/dts/mu=
cmc52.dts
> new file mode 100644
> index 0000000..a4a7a20
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/mucmc52.dts
> @@ -0,0 +1,231 @@
> +/*
> + * mucmc52 board Device Tree Source
> + *
> + * Copyright (C) 2009 DENX Software Engineering GmbH
> + * Heiko Schocher <hs@denx.de>
> + *
> + * This program is free software; you can redistribute =A0it and/or modi=
fy it
> + * under =A0the terms of =A0the GNU General =A0Public License as publish=
ed by the
> + * Free Software Foundation; =A0either version 2 of the =A0License, or (=
at your
> + * option) any later version.
> + */
> +
> +/dts-v1/;
> +
> +/ {
> + =A0 =A0 =A0 model =3D "man,mucmc52";
> + =A0 =A0 =A0 compatible =3D "man,mucmc52";
> + =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 #size-cells =3D <1>;
> + =A0 =A0 =A0 interrupt-parent =3D <&mpc5200_pic>;
> +
> + =A0 =A0 =A0 cpus {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0>;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PowerPC,5200@0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "cpu";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d-cache-line-size =3D <32>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i-cache-line-size =3D <32>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d-cache-size =3D <0x4000>; =
=A0 =A0 =A0 =A0// L1, 16K
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i-cache-size =3D <0x4000>; =
=A0 =A0 =A0 =A0// L1, 16K
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timebase-frequency =3D <0>;=
 =A0 =A0 =A0 // from bootloader
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus-frequency =3D <0>; =A0 =
=A0 =A0 =A0 =A0 =A0// from bootloader
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock-frequency =3D <0>; =
=A0 =A0 =A0 =A0 =A0// from bootloader
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 memory {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "memory";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x00000000 0x04000000>; =A0// 64MB
> + =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 soc5200@f0000000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5200-immr";

Does this board use the older and rarer non-'B' mpc5200 part?  If not,
then fsl,mpc5200b-immr also needs to be in this list.

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
