Return-Path: <Joakim.Tjernlund@infinera.com>
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam03on0074.outbound.protection.outlook.com [104.47.40.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tfZq70ncSzDw3P
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 01:01:06 +1100 (AEDT)
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "oss@buserror.net" <oss@buserror.net>, "valentin.longchamp@keymile.com"
 <valentin.longchamp@keymile.com>
Subject: Re: [PATCH 3/3] powerpc/corenet: add support for the kmcent2 board
Date: Thu, 15 Dec 2016 14:00:58 +0000
Message-ID: <1481810456.3878.18.camel@infinera.com>
References: <1481808148-16840-1-git-send-email-valentin.longchamp@keymile.com>
 <1481808148-16840-4-git-send-email-valentin.longchamp@keymile.com>
In-Reply-To: <1481808148-16840-4-git-send-email-valentin.longchamp@keymile.com>
Content-Type: text/plain; charset="iso-8859-15"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-12-15 at 14:22 +0100, Valentin Longchamp wrote:
> This board is built around Freescale's T1040 SoC.
>=20
> The peripherals used by this design are:
> - DDR3 RAM with SPD support
> - parallel NOR Flash as boot medium
> - 1 PCIe bus (PCIe1 x1)
> - 3 FMAN Ethernet devices (FMAN1 DTSEC1/2/5)
> - 4 IFC bus devices:
> =A0 - NOR flash
> =A0 - NAND flash
> =A0 - QRIO reset/power mgmt CPLD
> =A0 - BFTIC chassis management CPLD
> - 2 I2C buses
> - 1 SPI bus
> - HDLC bus with the QE's UCC1
> - last but not least, the mandatory serial port
>=20
> The board can be used with the corenet32_smp_defconfig.
>=20
> Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>
> ---
> =A0arch/powerpc/boot/dts/fsl/kmcent2.dts=A0=A0=A0=A0=A0=A0=A0=A0=A0| 303 =
++++++++++++++++++++++++++
> =A0arch/powerpc/platforms/85xx/corenet_generic.c |=A0=A0=A01 +
> =A02 files changed, 304 insertions(+)
> =A0create mode 100644 arch/powerpc/boot/dts/fsl/kmcent2.dts
>=20
> diff --git a/arch/powerpc/boot/dts/fsl/kmcent2.dts b/arch/powerpc/boot/dt=
s/fsl/kmcent2.dts
> new file mode 100644
> index 0000000..47afa43
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/fsl/kmcent2.dts
> @@ -0,0 +1,303 @@
> +/*
> + * Keymile kmcent2 Device Tree Source, based on T1040RDB DTS
> + *
> + * (C) Copyright 2016
> + * Valentin Longchamp, Keymile AG, valentin.longchamp@keymile.com
> + *
> + * Copyright 2014 - 2015 Freescale Semiconductor Inc.
> + *
> + * This program is free software; you can redistribute=A0=A0it and/or mo=
dify it
> + * under=A0=A0the terms of=A0=A0the GNU General=A0=A0Public License as p=
ublished by the
> + * Free Software Foundation;=A0=A0either version 2 of the=A0=A0License, =
or (at your
> + * option) any later version.
> + */
> +

[SNIP]

> +
> +		ucc_hdlc: ucc@2000 {
> +			device_type =3D "hdlc";
> +			compatible =3D "fsl,ucc-hdlc";
> +			rx-clock-name =3D "clk9";
> +			tx-clock-name =3D "clk9";

Should it be clk9 on both tx and rx clock?

 Jocke=
