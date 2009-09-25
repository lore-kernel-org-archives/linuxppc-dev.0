Return-Path: <Poonam.Aggrwal@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 880AEB7B94
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Sep 2009 14:18:29 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n8P4IQw9009413
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2009 21:18:26 -0700 (MST)
Received: from zin33exm24.fsl.freescale.net (zin33exm24.ap.freescale.net
	[10.232.192.24])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n8P4IOmR019110
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2009 23:18:25 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH][powerpc/85xx] P2020RDB Platform Support Added
Date: Fri, 25 Sep 2009 09:48:20 +0530
Message-ID: <1BD5CFC378ED0946B688E0C9BA2EF09525A376@zin33exm24.fsl.freescale.net>
In-Reply-To: <87B3AA50-1B12-43D6-9F92-37AA9E5BC142@kernel.crashing.org>
References: <1249532639-20070-1-git-send-email-poonam.aggrwal@freescale.com><4A7A776D.7080400@embedded-sol.com>
	<87B3AA50-1B12-43D6-9F92-37AA9E5BC142@kernel.crashing.org>
From: "Aggrwal Poonam-B10812" <Poonam.Aggrwal@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Felix Radensky <felix@embedded-sol.com>,
	linuxppc-release@webnode01-prod1.am.freescale.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From:=20
> linuxppc-dev-bounces+poonam.aggrwal=3Dfreescale.com@lists.ozlabs
> .org=20
> [mailto:linuxppc-dev-bounces+poonam.aggrwal=3Dfreescale.com@list
> s.ozlabs.org] On Behalf Of Kumar Gala
> Sent: Thursday, September 24, 2009 11:42 PM
> To: Aggrwal Poonam-B10812
> Cc: linuxppc-dev list; Felix Radensky;=20
> linuxppc-release@webnode01-prod1.am.freescale.net
> Subject: Re: [PATCH][powerpc/85xx] P2020RDB Platform Support Added
>=20
>=20
> On Aug 5, 2009, at 11:25 PM, Felix Radensky wrote:
>=20
> > Hi, Poonam
> >
> > Poonam Aggrwal wrote:
> >> Adds P2020RDB basic support in linux.
> >> Overview of P2020RDB platform
> >> 	- DDR
> >> 	  DDR2 1G
> >> 	- NOR Flash
> >> 	  16MByte
> >> 	- NAND Flash
> >> 	  32MByte
> >> 	- 3 Ethernet interfaces
> >> 	  1) etSEC1
> >> 		- RGMII
> >> 		- connected to a 5 port Vitesse Switch(VSC7385)
> >> 		- Switch is memory mapped through eLBC interface(CS#2)
> >> 		- IRQ1
> >> 	  2) etSEC2
> >> 		- SGMII
> >> 		- connected to VSC8221
> >> 		- IRQ2
> >> 	  3) etSEC3
> >> 		- RGMII
> >> 		- connected to VSC8641
> >> 		- IRQ3
> >> 	- 2 1X PCIe interfaces
> >> 	- SD/MMC ,USB
> >> 	- SPI EEPROM
> >> 	- Serial I2C EEPROM
> >>
> >> Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
> >> ---
> >> based on=20
> http://www.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git
> >> arch/powerpc/boot/dts/p2020rdb.dts        |  586=20
> +++++++++++++++++++=20
> >> ++++++++++
> >> arch/powerpc/configs/mpc85xx_defconfig    |    1 +
> >> arch/powerpc/platforms/85xx/Kconfig       |    9 +
> >> arch/powerpc/platforms/85xx/Makefile      |    3 +-
> >> arch/powerpc/platforms/85xx/mpc85xx_rdb.c |  141 +++++++
> >> 5 files changed, 739 insertions(+), 1 deletions(-) create=20
> mode 100644=20
> >> arch/powerpc/boot/dts/p2020rdb.dts
> >> create mode 100644 arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> >>
> >> diff --git a/arch/powerpc/boot/dts/p2020rdb.dts=20
> b/arch/powerpc/boot/=20
> >> dts/p2020rdb.dts new file mode 100644 index 0000000..d6d8131
> >> --- /dev/null
> >> +++ b/arch/powerpc/boot/dts/p2020rdb.dts
> >> @@ -0,0 +1,586 @@
> >> +/*
> >> + * P2020 RDB Device Tree Source
> >> + *
> >> + * Copyright 2009 Freescale Semiconductor Inc.
> >> + *
> >> + * This program is free software; you can redistribute  it and/or
> >> modify it
> >> + * under  the terms of  the GNU General  Public License as
> >> published by the
> >> + * Free Software Foundation;  either version 2 of the  License, or
> >> (at your
> >> + * option) any later version.
> >> + */
> >> +
> >> +/dts-v1/;
> >> +/ {
> >> +	model =3D "fsl,P2020";
> >> +	compatible =3D "fsl,P2020RDB";
> >> +	#address-cells =3D <2>;
> >> +	#size-cells =3D <2>;
> >> +
> >> +	aliases {
> >> +		ethernet0 =3D &enet0;
> >> +		ethernet1 =3D &enet1;
> >> +		ethernet2 =3D &enet2;
> >> +		serial0 =3D &serial0;
> >> +		serial1 =3D &serial1;
> >> +		pci0 =3D &pci0;
> >> +		pci1 =3D &pci1;
> >> +	};
> >> +
> >> +	cpus {
> >> +		#address-cells =3D <1>;
> >> +		#size-cells =3D <0>;
> >> +
> >> +		PowerPC,P2020@0 {
> >> +			device_type =3D "cpu";
> >> +			reg =3D <0x0>;
> >> +			next-level-cache =3D <&L2>;
> >> +		};
> >> +
> >> +		PowerPC,P2020@1 {
> >> +			device_type =3D "cpu";
> >> +			reg =3D <0x1>;
> >> +			next-level-cache =3D <&L2>;
> >> +		};
> >> +	};
> >> +
> >> +	memory {
> >> +		device_type =3D "memory";
> >> +	};
> >> +
> >> +	localbus@ffe05000 {
> >> +		#address-cells =3D <2>;
> >> +		#size-cells =3D <1>;
> >> +		compatible =3D "fsl,p2020-elbc", "fsl,elbc", "simple-bus";
> >> +		reg =3D <0 0xffe05000 0 0x1000>;
> >> +		interrupts =3D <19 2>;
> >> +		interrupt-parent =3D <&mpic>;
> >> +
> >> +		/* NOR and NAND Flashes */
> >> +		ranges =3D <0x0 0x0 0x0 0xef000000 0x01000000
> >> +			  0x1 0x0 0x0 0xffa00000 0x00040000
> >> +			  0x2 0x0 0x0 0xffb00000 0x08000000>;
> >>
> >
> > The comment is a bit misleading, CS2 is L2 switch. Also,=20
> are you sure=20
> > the CS2 range shouldn't look like
> >     0x2 0x0 0x0 0xffb00000 0x00020000
> >
> > That's what L2switch reg property suggests.
>=20
> Did you plan on making this change?
I already fixed it in v3 version of the patch, although please consider
the v4 version just sent recently. V4 also makes the comment proper as
suggested by Felix.

Regards
Poonam
>=20
> >> +		nor@0,0 {
> >> +			#address-cells =3D <1>;
> >> +			#size-cells =3D <1>;
> >> +			compatible =3D "cfi-flash";
> >> +			reg =3D <0x0 0x0 0x1000000>;
> >> +			bank-width =3D <2>;
> >> +			device-width =3D <1>;
> >> +
> >> +			vitesse-7385-fw@0 {
> >> +				/* This location must not be altered  */
> >> +				/* 256KB for Vitesse 7385=20
> Switch firmware */
> >> +				reg =3D <0x0 0x00040000>;
> >> +				label =3D "NOR (RO) Vitesse-7385=20
> Firmware";
> >> +				read-only;
> >> +			};
> >>
> > Partitions should be declared as
> >
> >      partition@0 {
> >                  reg =3D ...
> >                  label =3D ...
> >                  ...
> >       }
> > Felix.
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>=20
>=20
