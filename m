Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C58F9DDECA
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 16:45:33 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m846jB7g029871
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Sep 2008 23:45:16 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m846j6mS025727
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Sep 2008 01:45:07 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="windows-1251"
Subject: RE: [RFC PATCH 2/2 v2] powerpc/83xx: mpc836x_mds: add support for
	USBHost
Date: Thu, 4 Sep 2008 14:45:05 +0800
Message-ID: <0C69E0CDED15E4469A445DE244C1B9F708D19A@zch01exm26.fsl.freescale.net>
In-Reply-To: <20080901133442.GA32632@oksana.dev.rtsoft.ru>
References: <20080825152736.GB25178@oksana.dev.rtsoft.ru>
	<20080901133442.GA32632@oksana.dev.rtsoft.ru>
From: "Li Yang-R58472" <LeoLi@freescale.com>
To: <avorontsov@ru.mvista.com>, "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Anton Vorontsov [mailto:avorontsov@ru.mvista.com]=20
> Sent: Monday, September 01, 2008 9:35 PM
> To: Kumar Gala
> Cc: linuxppc-dev@ozlabs.org; Li Yang-R58472
> Subject: [RFC PATCH 2/2 v2] powerpc/83xx: mpc836x_mds: add=20
> support for USBHost
>=20
> Various changes to support QE USB Host on a MPC8360E-MDS board:
>=20
> - Update the device tree per QE USB bindings;
> - Configure QE Par IO;
> - Set up BCSR for both USB Host and Peripheral modes;
> - Add timer (GTM) node;
> - Add gpio-controller node for BCSR13 bank;
> - Select FSL_GTM, QE_GPIO and OF_SIMPLE_GPIO.
>=20
> The work is loosely based on Li Yang's patch[1], which is=20
> used to support peripheral mode only.
>=20
> [1] http://ozlabs.org/pipermail/linuxppc-dev/2008-August/061357.html
>=20
> The s-o-b line of the original patch preserved here.
>=20
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

{snip}
> @@ -297,11 +328,20 @@
>  		};
> =20
>  		usb@6c0 {
> -			compatible =3D "qe_udc";
> +			compatible =3D "fsl,mpc8360-qe-usb",
> +				     "fsl,mpc8323-qe-usb";
>  			reg =3D <0x6c0 0x40 0x8b00 0x100>;
>  			interrupts =3D <11>;
>  			interrupt-parent =3D <&qeic>;
> -			mode =3D "slave";
> +			fsl,fullspeed-clock =3D "clk21";
> +			fsl,lowspeed-clock =3D "brg9";
> +			gpios =3D <&qe_pio_b  2 0   /* USBOE */
> +				 &qe_pio_b  3 0   /* USBTP */
> +				 &qe_pio_b  8 0   /* USBTN */
> +				 &qe_pio_b  9 0   /* USBRP */
> +				 &qe_pio_b 11 0   /* USBRN */
> +				 &bcsr13    5 0   /* SPEED */
> +				 &bcsr13    4 1>; /* POWER */


Nothing against this node.  But I don't think gpio nodes can replaces =
par_io nodes.  Gpios are focusing on the pins which are directly =
manipulated by the core, but par_io are for pins used by internal SoCs.

- Leo
