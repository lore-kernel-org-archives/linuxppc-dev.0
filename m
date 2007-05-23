Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 12E15DDE44
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 23:27:08 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l4NDR2En020844
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 06:27:03 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l4NDR1tp019444
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 08:27:02 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Porting RapidIO from ppc arch to powerpc arch in support of
	MPC8641D
Date: Wed, 23 May 2007 21:26:59 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C234AE6@zch01exm26.fsl.freescale.net>
In-Reply-To: <1179862732.25914.40.camel@pterry-fc6.micromemory.com>
References: <1179862732.25914.40.camel@pterry-fc6.micromemory.com>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: <pterry@micromemory.com>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> So I'm taking the boot/dts/mpc8641_hpcn.dts and producing a new
> mpc8641D_umem.dts with the following addition to the soc.
>=20
> srio@c0000 {
>                 device_type =3D "srio";
>                 compatible =3D "86xx,85xx";
> 		reg =3D <c0000 20000>;
> 		law =3D <400000000 e00000000>;

Please use range =3D <0 address_start size>

> 		dbells =3D <0 ffff>;
> 		mboxs =3D <0 4>;

The dbells and mboxs can be removed. The default setting in rio is okay.

>                 interrupt-parent =3D <&mpic>;
>                 interrupts =3D <30 1 31 1 32 1 35 1 36 1 37 1 38 1>;
>               };
>=20
Do you really use all of this interrupts? In my test, three <32 2 35 2
36 2> are okay, and the sense is 2.

I've finished the porting RIO from ppc to powerpc, do you need some
helps?

Best Regards,
Zhang Wei
