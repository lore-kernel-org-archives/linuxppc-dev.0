Return-Path: <Poonam.Aggrwal@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 62C02B6F20
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  8 Aug 2009 00:35:36 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D87D3DDD0B
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Aug 2009 00:35:34 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n77EZD1H027356
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Aug 2009 07:35:24 -0700 (MST)
Received: from zin33exm24.fsl.freescale.net (zin33exm24.ap.freescale.net
	[10.232.192.24])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n77EZiEL014898
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Aug 2009 09:35:45 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH][v2][powerpc/85xx] P2020RDB Platform Support Added
Date: Fri, 7 Aug 2009 20:05:04 +0530
Message-ID: <1BD5CFC378ED0946B688E0C9BA2EF0951932F1@zin33exm24.fsl.freescale.net>
In-Reply-To: <4A7C0BF5.8010503@embedded-sol.com>
References: <1249633286-21663-1-git-send-email-poonam.aggrwal@freescale.com>
	<4A7C0BF5.8010503@embedded-sol.com>
From: "Aggrwal Poonam-B10812" <Poonam.Aggrwal@freescale.com>
To: "Felix Radensky" <felix@embedded-sol.com>
Cc: linuxppc-dev@ozlabs.org
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
> From: Felix Radensky [mailto:felix@embedded-sol.com]=20
> Sent: Friday, August 07, 2009 4:42 PM
> To: Aggrwal Poonam-B10812
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH][v2][powerpc/85xx] P2020RDB Platform Support Added
>=20
> Hi, Poonam
>=20
> See some more comments below.
>=20
> Poonam Aggrwal wrote:
> > Adds P2020RDB basic support in linux.
> > Overview of P2020RDB platform
> > 	- DDR
> > 	  DDR2 1G
> > 	- NOR Flash
> > 	  16MByte
> > 	- NAND Flash
> > 	  32MByte
> > 	- 3 Ethernet interfaces
> > 	  1) etSEC1
> > 		- RGMII
> > 		- connected to a 5 port Vitesse Switch(VSC7385)
> > 		- Switch is memory mapped through eLBC interface(CS#2)
> > 		- IRQ1
> > 	  2) etSEC2
> > 		- SGMII
> > 		- connected to VSC8221
> > 		- IRQ2
> > 	  3) etSEC3
> > 		- RGMII
> > 		- connected to VSC8641
> > 		- IRQ3
> > 	- 2 1X PCIe interfaces
> > 	- SD/MMC ,USB
> > 	- SPI EEPROM
> > 	- Serial I2C EEPROM
> >=20
> > Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
> > ---
> > based on=20
> > http://www.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git
> > incorporated Felix feedback regarding the partition names.
> > fixed the vitesse switch ranges entry in device tree.
> >  arch/powerpc/boot/dts/p2020rdb.dts        |  586=20
> +++++++++++++++++++++++++++++
> >  arch/powerpc/configs/mpc85xx_defconfig    |    1 +
> >  arch/powerpc/platforms/85xx/Kconfig       |    9 +
> >  arch/powerpc/platforms/85xx/Makefile      |    3 +-
> >  arch/powerpc/platforms/85xx/mpc85xx_rdb.c |  141 +++++++
> >  5 files changed, 739 insertions(+), 1 deletions(-)  create mode=20
> > 100644 arch/powerpc/boot/dts/p2020rdb.dts
> >  create mode 100644 arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> >=20
> > diff --git a/arch/powerpc/boot/dts/p2020rdb.dts=20
> > b/arch/powerpc/boot/dts/p2020rdb.dts
> > new file mode 100644
> > index 0000000..617029f
> > --- /dev/null
> > +++ b/arch/powerpc/boot/dts/p2020rdb.dts
> > @@ -0,0 +1,586 @@
> > +/*
> > + * P2020 RDB Device Tree Source
> > + *
> > + * Copyright 2009 Freescale Semiconductor Inc.
> > + *
> > + * This program is free software; you can redistribute  it and/or=20
> > +modify it
> > + * under  the terms of  the GNU General  Public License as=20
> published=20
> > +by the
> > + * Free Software Foundation;  either version 2 of the  License, or=20
> > +(at your
> > + * option) any later version.
> > + */
> > +
> > +/dts-v1/;
> > +/ {
> > +	model =3D "fsl,P2020";
> > +	compatible =3D "fsl,P2020RDB";
> > +	#address-cells =3D <2>;
> > +	#size-cells =3D <2>;
> > +
> > +	aliases {
> > +		ethernet0 =3D &enet0;
> > +		ethernet1 =3D &enet1;
> > +		ethernet2 =3D &enet2;
> > +		serial0 =3D &serial0;
> > +		serial1 =3D &serial1;
> > +		pci0 =3D &pci0;
> > +		pci1 =3D &pci1;
> > +	};
> > +
> > +	cpus {
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <0>;
> > +
> > +		PowerPC,P2020@0 {
> > +			device_type =3D "cpu";
> > +			reg =3D <0x0>;
> > +			next-level-cache =3D <&L2>;
> > +		};
> > +
> > +		PowerPC,P2020@1 {
> > +			device_type =3D "cpu";
> > +			reg =3D <0x1>;
> > +			next-level-cache =3D <&L2>;
> > +		};
> > +	};
> > +
> > +	memory {
> > +		device_type =3D "memory";
> > +	};
> > +
> > +	localbus@ffe05000 {
> > +		#address-cells =3D <2>;
> > +		#size-cells =3D <1>;
> > +		compatible =3D "fsl,p2020-elbc", "fsl,elbc", "simple-bus";
> > +		reg =3D <0 0xffe05000 0 0x1000>;
> > +		interrupts =3D <19 2>;
> > +		interrupt-parent =3D <&mpic>;
> > +
> > +		/* NOR and NAND Flashes */
> > +		ranges =3D <0x0 0x0 0x0 0xef000000 0x01000000
> > +			  0x1 0x0 0x0 0xffa00000 0x00040000
> > +			  0x2 0x0 0x0 0xffb00000 0x00020000>;
> > +
> > +		nor@0,0 {
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <1>;
> > +			compatible =3D "cfi-flash";
> > +			reg =3D <0x0 0x0 0x1000000>;
> > +			bank-width =3D <2>;
> > +			device-width =3D <1>;
> > +
> > +			partition@0 {
> > +				/* This location must not be altered  */
> > +				/* 256KB for Vitesse 7385=20
> Switch firmware */
> > +				reg =3D <0x0 0x00040000>;
> > +				label =3D "NOR (RO) Vitesse-7385=20
> Firmware";
> > +				read-only;
> > +			};
> > +
> > +			partition@40000 {
> > +				/* 256KB for DTB Image */
> > +				reg =3D <0x00040000 0x00040000>;
> > +				label =3D "NOR (RO) DTB Image";
> > +				read-only;
> > +			};
> > +
> > +			partition@80000 {
> > +				/* 3.5 MB for Linux Kernel Image */
> > +				reg =3D <0x00080000 0x00380000>;
> > +				label =3D "NOR (RO) Linux Kernel Image";
> > +				read-only;
> > +			};
> > +
> > +			partition@400000 {
> > +				/* 11MB for JFFS2 based Root=20
> file System */
> > +				reg =3D <0x00400000 0x00b00000>;
> > +				label =3D "NOR (RW) JFFS2 Root=20
> File System";
> > +			};
> > +
> > +			partition@f00000 {
> > +				/* This location must not be altered  */
> > +				/* 512KB for u-boot Bootloader Image */
> > +				/* 512KB for u-boot Environment=20
> Variables */
> > +				reg =3D <0x00f00000 0x00100000>;
> > +				label =3D "NOR (RO) U-Boot Image";
> > +				read-only;
> > +			};
> > +		};
> > +
> > +		nand@1,0 {
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <1>;
> > +			compatible =3D "fsl,p2020-fcm-nand",
> > +				     "fsl,elbc-fcm-nand";
> > +			reg =3D <0x1 0x0 0x40000>;
> > +
> > +			u-boot@0 {
> > +				/* This location must not be altered  */
> > +				/* 1MB for u-boot Bootloader Image */
> > +				reg =3D <0x0 0x00100000>;
> > +				label =3D "NAND (RO) U-Boot Image";
> > +				read-only;
> > +			};
> > +
> > +			dtb@100000 {
> > +				/* 1MB for DTB Image */
> > +				reg =3D <0x00100000 0x00100000>;
> > +				label =3D "NAND (RO) DTB Image";
> > +				read-only;
> > +			};
> > +
> > +			uImage@200000 {
> > +				/* 4MB for Linux Kernel Image */
> > +				reg =3D <0x00200000 0x00400000>;
> > +				label =3D "NAND (RO) Linux Kernel Image";
> > +				read-only;
> > +			};
> > +
> > +			rfs@600000 {
> > +				/* 4MB for Compressed Root file=20
> System Image */
> > +				reg =3D <0x00600000 0x00400000>;
> > +				label =3D "NAND (RO) Compressed=20
> RFS Image";
> > +				read-only;
> > +			};
> > +
> > +			jffs2@a00000 {
> > +				/* 7MB for JFFS2 based Root=20
> file System */
> > +				reg =3D <0x00a00000 0x00700000>;
> > +				label =3D "NAND (RW) JFFS2 Root=20
> File System";
> > +			};
> > +
> > +			user@1100000 {
> > +				/* 15MB for JFFS2 based Root=20
> file System */
> > +				reg =3D <0x01100000 0x00f00000>;
> > +				label =3D "NAND (RW) Writable User area";
> > +			};
> > +		};
>=20
> NAND partitions should also be declared using new syntax.
Of course, some goof up happened while sending.
>=20
>=20
> > +
> > +		L2switch@2,0 {
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <1>;
> > +			compatible =3D "vitesse-7385";
> > +			reg =3D <0x2 0x0 0x20000>;
> > +		};
> > +
> > +	};
> > +
> > +	soc@ffe00000 {
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <1>;
> > +		device_type =3D "soc";
> > +		compatible =3D "fsl,p2020-immr", "simple-bus";
> > +		ranges =3D <0x0  0x0 0xffe00000 0x100000>;
> > +		bus-frequency =3D <0>;		// Filled out by uboot.
> > +
> > +		ecm-law@0 {
> > +			compatible =3D "fsl,ecm-law";
> > +			reg =3D <0x0 0x1000>;
> > +			fsl,num-laws =3D <12>;
> > +		};
> > +
> > +		ecm@1000 {
> > +			compatible =3D "fsl,p2020-ecm", "fsl,ecm";
> > +			reg =3D <0x1000 0x1000>;
> > +			interrupts =3D <17 2>;
> > +			interrupt-parent =3D <&mpic>;
> > +		};
> > +
> > +		memory-controller@2000 {
> > +			compatible =3D "fsl,p2020-memory-controller";
> > +			reg =3D <0x2000 0x1000>;
> > +			interrupt-parent =3D <&mpic>;
> > +			interrupts =3D <18 2>;
> > +		};
> > +
> > +		i2c@3000 {
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +			cell-index =3D <0>;
> > +			compatible =3D "fsl-i2c";
> > +			reg =3D <0x3000 0x100>;
> > +			interrupts =3D <43 2>;
> > +			interrupt-parent =3D <&mpic>;
> > +			dfsrr;
> > +			rtc@68 {
> > +				compatible =3D "dallas,ds1339";
> > +				reg =3D <0x68>;
> > +			};
> > +		};
> > +
> > +		i2c@3100 {
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +			cell-index =3D <1>;
> > +			compatible =3D "fsl-i2c";
> > +			reg =3D <0x3100 0x100>;
> > +			interrupts =3D <43 2>;
> > +			interrupt-parent =3D <&mpic>;
> > +			dfsrr;
> > +		};
> > +
> > +		serial0: serial@4500 {
> > +			cell-index =3D <0>;
> > +			device_type =3D "serial";
> > +			compatible =3D "ns16550";
> > +			reg =3D <0x4500 0x100>;
> > +			clock-frequency =3D <0>;
> > +			interrupts =3D <42 2>;
> > +			interrupt-parent =3D <&mpic>;
> > +		};
> > +
> > +		serial1: serial@4600 {
> > +			cell-index =3D <1>;
> > +			device_type =3D "serial";
> > +			compatible =3D "ns16550";
> > +			reg =3D <0x4600 0x100>;
> > +			clock-frequency =3D <0>;
> > +			interrupts =3D <42 2>;
> > +			interrupt-parent =3D <&mpic>;
> > +		};
> > +
> > +		spi@7000 {
> > +			cell-index =3D <0>;
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +			compatible =3D "fsl,espi";
> > +			reg =3D <0x7000 0x1000>;
> > +			interrupts =3D <59 0x2>;
> > +			interrupt-parent =3D <&mpic>;
> > +			mode =3D "cpu";
> > +
> > +			fsl_m25p80@0 {
> > +				#address-cells =3D <1>;
> > +				#size-cells =3D <1>;
> > +				compatible =3D "fsl,espi-flash";
> > +				reg =3D <0>;
> > +				linux,modalias =3D "fsl_m25p80";
> > +				modal =3D "s25sl128b";
> > +				spi-max-frequency =3D <50000000>;
> > +				mode =3D <0>;
> > +
> > +				partition@0 {
> > +					/* 512KB for u-boot=20
> Bootloader Image */
> > +					reg =3D <0x0 0x00080000>;
> > +					label =3D "SPI (RO) U-Boot Image";
> > +					read-only;
> > +				};
> > +
> > +				partition@80000 {
> > +					/* 512KB for DTB Image */
> > +					reg =3D <0x00080000 0x00080000>;
> > +					label =3D "SPI (RO) DTB Image";
> > +					read-only;
> > +				};
> > +
> > +				partition@100000 {
> > +					/* 4MB for Linux Kernel Image */
> > +					reg =3D <0x00100000 0x00400000>;
> > +					label =3D "SPI (RO) Linux=20
> Kernel Image";
> > +					read-only;
> > +				};
> > +
> > +				partition@500000 {
> > +					/* 4MB for Compressed=20
> RFS Image */
> > +					reg =3D <0x00500000 0x00400000>;
> > +					label =3D "SPI (RO)=20
> Compressed RFS Image";
> > +					read-only;
> > +				};
> > +
> > +				partition@900000 {
> > +					/* 7MB for JFFS2 based RFS */
> > +					reg =3D <0x00900000 0x00700000>;
> > +					label =3D "SPI (RW) JFFS2 RFS";
> > +				};
> > +			};
> > +		};
> > +
> > +		dma@c300 {
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <1>;
> > +			compatible =3D "fsl,eloplus-dma";
> > +			reg =3D <0xc300 0x4>;
> > +			ranges =3D <0x0 0xc100 0x200>;
> > +			cell-index =3D <1>;
> > +			dma-channel@0 {
> > +				compatible =3D "fsl,eloplus-dma-channel";
> > +				reg =3D <0x0 0x80>;
> > +				cell-index =3D <0>;
> > +				interrupt-parent =3D <&mpic>;
> > +				interrupts =3D <76 2>;
> > +			};
> > +			dma-channel@80 {
> > +				compatible =3D "fsl,eloplus-dma-channel";
> > +				reg =3D <0x80 0x80>;
> > +				cell-index =3D <1>;
> > +				interrupt-parent =3D <&mpic>;
> > +				interrupts =3D <77 2>;
> > +			};
> > +			dma-channel@100 {
> > +				compatible =3D "fsl,eloplus-dma-channel";
> > +				reg =3D <0x100 0x80>;
> > +				cell-index =3D <2>;
> > +				interrupt-parent =3D <&mpic>;
> > +				interrupts =3D <78 2>;
> > +			};
> > +			dma-channel@180 {
> > +				compatible =3D "fsl,eloplus-dma-channel";
> > +				reg =3D <0x180 0x80>;
> > +				cell-index =3D <3>;
> > +				interrupt-parent =3D <&mpic>;
> > +				interrupts =3D <79 2>;
> > +			};
> > +		};
> > +
> > +		gpio: gpio-controller@f000 {
> > +			#gpio-cells =3D <2>;
> > +			compatible =3D "fsl,mpc8572-gpio";
> > +			reg =3D <0xf000 0x100>;
> > +			interrupts =3D <47 0x2>;
> > +			interrupt-parent =3D <&mpic>;
> > +			gpio-controller;
> > +		};
> > +
> > +		L2: l2-cache-controller@20000 {
> > +			compatible =3D "fsl,p2020-l2-cache-controller";
> > +			reg =3D <0x20000 0x1000>;
> > +			cache-line-size =3D <32>;	// 32 bytes
> > +			cache-size =3D <0x80000>; // L2,512K
> > +			interrupt-parent =3D <&mpic>;
> > +			interrupts =3D <16 2>;
> > +		};
> > +
> > +		dma@21300 {
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <1>;
> > +			compatible =3D "fsl,eloplus-dma";
> > +			reg =3D <0x21300 0x4>;
> > +			ranges =3D <0x0 0x21100 0x200>;
> > +			cell-index =3D <0>;
> > +			dma-channel@0 {
> > +				compatible =3D "fsl,eloplus-dma-channel";
> > +				reg =3D <0x0 0x80>;
> > +				cell-index =3D <0>;
> > +				interrupt-parent =3D <&mpic>;
> > +				interrupts =3D <20 2>;
> > +			};
> > +			dma-channel@80 {
> > +				compatible =3D "fsl,eloplus-dma-channel";
> > +				reg =3D <0x80 0x80>;
> > +				cell-index =3D <1>;
> > +				interrupt-parent =3D <&mpic>;
> > +				interrupts =3D <21 2>;
> > +			};
> > +			dma-channel@100 {
> > +				compatible =3D "fsl,eloplus-dma-channel";
> > +				reg =3D <0x100 0x80>;
> > +				cell-index =3D <2>;
> > +				interrupt-parent =3D <&mpic>;
> > +				interrupts =3D <22 2>;
> > +			};
> > +			dma-channel@180 {
> > +				compatible =3D "fsl,eloplus-dma-channel";
> > +				reg =3D <0x180 0x80>;
> > +				cell-index =3D <3>;
> > +				interrupt-parent =3D <&mpic>;
> > +				interrupts =3D <23 2>;
> > +			};
> > +		};
> > +
> > +		usb@22000 {
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +			compatible =3D "fsl-usb2-dr";
> > +			reg =3D <0x22000 0x1000>;
> > +			interrupt-parent =3D <&mpic>;
> > +			interrupts =3D <28 0x2>;
> > +			phy_type =3D "ulpi";
> > +		};
> > +
> > +		enet0: ethernet@24000 {
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <1>;
> > +			cell-index =3D <0>;
> > +			device_type =3D "network";
> > +			model =3D "eTSEC";
> > +			compatible =3D "gianfar";
> > +			reg =3D <0x24000 0x1000>;
> > +			ranges =3D <0x0 0x24000 0x1000>;
> > +			local-mac-address =3D [ 00 00 00 00 00 00 ];
> > +			interrupts =3D <29 2 30 2 34 2>;
> > +			interrupt-parent =3D <&mpic>;
> > +			fixed-link =3D <1 1 1000 0 0>;
> > +			phy-connection-type =3D "rgmii-id";
> > +
> > +			mdio@520 {
> > +				#address-cells =3D <1>;
> > +				#size-cells =3D <0>;
> > +				compatible =3D "fsl,gianfar-mdio";
> > +				reg =3D <0x520 0x20>;
> > +
> > +				phy0: ethernet-phy@0 {
> > +					interrupt-parent =3D <&mpic>;
> > +					interrupts =3D <3 1>;
> > +					reg =3D <0x0>;
> > +				};
> > +				phy1: ethernet-phy@1 {
> > +					interrupt-parent =3D <&mpic>;
> > +					interrupts =3D <3 1>;
> > +					reg =3D <0x1>;
> > +				};
> > +			};
> > +		};
> > +
> > +		enet1: ethernet@25000 {
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <1>;
> > +			cell-index =3D <1>;
> > +			device_type =3D "network";
> > +			model =3D "eTSEC";
> > +			compatible =3D "gianfar";
> > +			reg =3D <0x25000 0x1000>;
> > +			ranges =3D <0x0 0x25000 0x1000>;
> > +			local-mac-address =3D [ 00 00 00 00 00 00 ];
> > +			interrupts =3D <35 2 36 2 40 2>;
> > +			interrupt-parent =3D <&mpic>;
> > +			tbi-handle =3D <&tbi0>;
> > +			phy-handle =3D <&phy0>;
> > +			phy-connection-type =3D "sgmii";
> > +
> > +			mdio@520 {
> > +				#address-cells =3D <1>;
> > +				#size-cells =3D <0>;
> > +				compatible =3D "fsl,gianfar-tbi";
> > +				reg =3D <0x520 0x20>;
> > +
> > +				tbi0: tbi-phy@11 {
> > +					reg =3D <0x11>;
> > +					device_type =3D "tbi-phy";
> > +				};
> > +			};
> > +		};
> > +
> > +		enet2: ethernet@26000 {
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <1>;
> > +			cell-index =3D <2>;
> > +			device_type =3D "network";
> > +			model =3D "eTSEC";
> > +			compatible =3D "gianfar";
> > +			reg =3D <0x26000 0x1000>;
> > +			ranges =3D <0x0 0x26000 0x1000>;
> > +			local-mac-address =3D [ 00 00 00 00 00 00 ];
> > +			interrupts =3D <31 2 32 2 33 2>;
> > +			interrupt-parent =3D <&mpic>;
> > +			phy-handle =3D <&phy1>;
> > +			phy-connection-type =3D "rgmii-id";
> > +		};
> > +
>=20
> Shouldn't mdio node be associated with enet2 ?
On the P2020 SOC mdio signals for enet1 are coming out and connected to
the PHYs on the board. All PHYs are supposed to use this as MDIO bus.
>=20
>=20
> > +		sdhci@2e000 {
> > +			compatible =3D "fsl,p2020-esdhc", "fsl,esdhc";
> > +			reg =3D <0x2e000 0x1000>;
> > +			interrupts =3D <72 0x2>;
> > +			interrupt-parent =3D <&mpic>;
> > +			/* Filled in by U-Boot */
> > +			clock-frequency =3D <0>;
> > +		};
> > +
> > +		crypto@30000 {
> > +			compatible =3D "fsl,sec3.1",=20
> "fsl,sec3.0", "fsl,sec2.4",
> > +				     "fsl,sec2.2",=20
> "fsl,sec2.1", "fsl,sec2.0";
> > +			reg =3D <0x30000 0x10000>;
> > +			interrupts =3D <45 2 58 2>;
> > +			interrupt-parent =3D <&mpic>;
> > +			fsl,num-channels =3D <4>;
> > +			fsl,channel-fifo-len =3D <24>;
> > +			fsl,exec-units-mask =3D <0xbfe>;
> > +			fsl,descriptor-types-mask =3D <0x3ab0ebf>;
> > +		};
> > +
> > +		mpic: pic@40000 {
> > +			interrupt-controller;
> > +			#address-cells =3D <0>;
> > +			#interrupt-cells =3D <2>;
> > +			reg =3D <0x40000 0x40000>;
> > +			compatible =3D "chrp,open-pic";
> > +			device_type =3D "open-pic";
> > +		};
> > +
> > +		msi@41600 {
> > +			compatible =3D "fsl,p2020-msi", "fsl,mpic-msi";
> > +			reg =3D <0x41600 0x80>;
> > +			msi-available-ranges =3D <0 0x100>;
> > +			interrupts =3D <
> > +				0xe0 0
> > +				0xe1 0
> > +				0xe2 0
> > +				0xe3 0
> > +				0xe4 0
> > +				0xe5 0
> > +				0xe6 0
> > +				0xe7 0>;
> > +			interrupt-parent =3D <&mpic>;
> > +		};
> > +
> > +		global-utilities@e0000 {	//global utilities block
> > +			compatible =3D "fsl,p2020-guts";
> > +			reg =3D <0xe0000 0x1000>;
> > +			fsl,has-rstcr;
> > +		};
> > +	};
> > +
> > +	pci0: pcie@ffe09000 {
> > +		compatible =3D "fsl,mpc8548-pcie";
> > +		device_type =3D "pci";
> > +		#interrupt-cells =3D <1>;
> > +		#size-cells =3D <2>;
> > +		#address-cells =3D <3>;
> > +		reg =3D <0 0xffe09000 0 0x1000>;
> > +		bus-range =3D <0 255>;
> > +		ranges =3D <0x2000000 0x0 0xa0000000 0 0xa0000000=20
> 0x0 0x20000000
> > +			  0x1000000 0x0 0x00000000 0 0xffc30000=20
> 0x0 0x10000>;
> > +		clock-frequency =3D <33333333>;
> > +		interrupt-parent =3D <&mpic>;
> > +		interrupts =3D <25 2>;
> > +		pcie@0 {
> > +			reg =3D <0x0 0x0 0x0 0x0 0x0>;
> > +			#size-cells =3D <2>;
> > +			#address-cells =3D <3>;
> > +			device_type =3D "pci";
> > +			ranges =3D <0x2000000 0x0 0xa0000000
> > +				  0x2000000 0x0 0xa0000000
> > +				  0x0 0x20000000
> > +
> > +				  0x1000000 0x0 0x0
> > +				  0x1000000 0x0 0x0
> > +				  0x0 0x100000>;
> > +		};
> > +	};
> > +
> > +	pci1: pcie@ffe0a000 {
> > +		compatible =3D "fsl,mpc8548-pcie";
> > +		device_type =3D "pci";
> > +		#interrupt-cells =3D <1>;
> > +		#size-cells =3D <2>;
> > +		#address-cells =3D <3>;
> > +		reg =3D <0 0xffe0a000 0 0x1000>;
> > +		bus-range =3D <0 255>;
> > +		ranges =3D <0x2000000 0x0 0xc0000000 0 0xc0000000=20
> 0x0 0x20000000
> > +			  0x1000000 0x0 0x00000000 0 0xffc20000=20
> 0x0 0x10000>;
> > +		clock-frequency =3D <33333333>;
> > +		interrupt-parent =3D <&mpic>;
> > +		interrupts =3D <26 2>;
> > +		pcie@0 {
> > +			reg =3D <0x0 0x0 0x0 0x0 0x0>;
> > +			#size-cells =3D <2>;
> > +			#address-cells =3D <3>;
> > +			device_type =3D "pci";
> > +			ranges =3D <0x2000000 0x0 0xc0000000
> > +				  0x2000000 0x0 0xc0000000
> > +				  0x0 0x20000000
> > +
> > +				  0x1000000 0x0 0x0
> > +				  0x1000000 0x0 0x0
> > +				  0x0 0x100000>;
> > +		};
> > +	};
> > +};
> > diff --git a/arch/powerpc/configs/mpc85xx_defconfig=20
> b/arch/powerpc/configs/mpc85xx_defconfig
> > index c162724..dc4819c 100644
> > --- a/arch/powerpc/configs/mpc85xx_defconfig
> > +++ b/arch/powerpc/configs/mpc85xx_defconfig
> > @@ -189,6 +189,7 @@ CONFIG_MPC85xx_CDS=3Dy
> >  CONFIG_MPC85xx_MDS=3Dy
> >  CONFIG_MPC8536_DS=3Dy
> >  CONFIG_MPC85xx_DS=3Dy
> > +CONFIG_MPC85xx_RDB=3Dy
> >  CONFIG_SOCRATES=3Dy
> >  CONFIG_KSI8560=3Dy
> >  CONFIG_STX_GP3=3Dy
> > diff --git a/arch/powerpc/platforms/85xx/Kconfig=20
> b/arch/powerpc/platforms/85xx/Kconfig
> > index a9b4166..d3a975e 100644
> > --- a/arch/powerpc/platforms/85xx/Kconfig
> > +++ b/arch/powerpc/platforms/85xx/Kconfig
> > @@ -55,6 +55,15 @@ config MPC85xx_DS
> >  	help
> >  	  This option enables support for the MPC85xx DS=20
> (MPC8544 DS) board
> > =20
> > +config MPC85xx_RDB
> > +	bool "Freescale MPC85xx RDB"
> > +	select PPC_I8259
> > +	select DEFAULT_UIMAGE
> > +	select FSL_ULI1575
> > +	select SWIOTLB
> > +	help
> > +	  This option enables support for the MPC85xx RDB=20
> (P2020 RDB) board
> > +
> >  config SOCRATES
> >  	bool "Socrates"
> >  	select DEFAULT_UIMAGE
> > diff --git a/arch/powerpc/platforms/85xx/Makefile=20
> b/arch/powerpc/platforms/85xx/Makefile
> > index 835733f..4efcc63 100644
> > --- a/arch/powerpc/platforms/85xx/Makefile
> > +++ b/arch/powerpc/platforms/85xx/Makefile
> > @@ -9,10 +9,11 @@ obj-$(CONFIG_MPC85xx_CDS) +=3D mpc85xx_cds.o
> >  obj-$(CONFIG_MPC8536_DS)  +=3D mpc8536_ds.o
> >  obj-$(CONFIG_MPC85xx_DS)  +=3D mpc85xx_ds.o
> >  obj-$(CONFIG_MPC85xx_MDS) +=3D mpc85xx_mds.o
> > +obj-$(CONFIG_MPC85xx_RDB)  +=3D mpc85xx_rdb.o
> >  obj-$(CONFIG_STX_GP3)	  +=3D stx_gp3.o
> >  obj-$(CONFIG_TQM85xx)	  +=3D tqm85xx.o
> >  obj-$(CONFIG_SBC8560)     +=3D sbc8560.o
> >  obj-$(CONFIG_SBC8548)     +=3D sbc8548.o
> >  obj-$(CONFIG_SOCRATES)    +=3D socrates.o socrates_fpga_pic.o
> >  obj-$(CONFIG_KSI8560)	  +=3D ksi8560.o
> > -obj-$(CONFIG_XES_MPC85xx) +=3D xes_mpc85xx.o
> > \ No newline at end of file
> > +obj-$(CONFIG_XES_MPC85xx) +=3D xes_mpc85xx.o
> > diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c=20
> b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> > new file mode 100644
> > index 0000000..c8468de
> > --- /dev/null
> > +++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> > @@ -0,0 +1,141 @@
> > +/*
> > + * MPC85xx RDB Board Setup
> > + *
> > + * Copyright 2009 Freescale Semiconductor Inc.
> > + *
> > + * This program is free software; you can redistribute  it=20
> and/or modify it
> > + * under  the terms of  the GNU General  Public License as=20
> published by the
> > + * Free Software Foundation;  either version 2 of the =20
> License, or (at your
> > + * option) any later version.
> > + */
> > +
> > +#include <linux/stddef.h>
> > +#include <linux/kernel.h>
> > +#include <linux/pci.h>
> > +#include <linux/kdev_t.h>
> > +#include <linux/delay.h>
> > +#include <linux/seq_file.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/of_platform.h>
> > +
> > +#include <asm/system.h>
> > +#include <asm/time.h>
> > +#include <asm/machdep.h>
> > +#include <asm/pci-bridge.h>
> > +#include <mm/mmu_decl.h>
> > +#include <asm/prom.h>
> > +#include <asm/udbg.h>
> > +#include <asm/mpic.h>
> > +
> > +#include <sysdev/fsl_soc.h>
> > +#include <sysdev/fsl_pci.h>
> > +
> > +#undef DEBUG
> > +
> > +#ifdef DEBUG
> > +#define DBG(fmt, args...) printk(KERN_ERR "%s: " fmt,=20
> __func__, ## args)
> > +#else
> > +#define DBG(fmt, args...)
> > +#endif
> > +
> > +
> > +void __init mpc85xx_rdb_pic_init(void)
> > +{
> > +	struct mpic *mpic;
> > +	struct resource r;
> > +	struct device_node *np;
> > +
> > +	np =3D of_find_node_by_type(NULL, "open-pic");
> > +	if (np =3D=3D NULL) {
> > +		printk(KERN_ERR "Could not find open-pic node\n");
> > +		return;
> > +	}
> > +
> > +	if (of_address_to_resource(np, 0, &r)) {
> > +		printk(KERN_ERR "Failed to map mpic register space\n");
> > +		of_node_put(np);
> > +		return;
> > +	}
> > +
> > +	mpic =3D mpic_alloc(np, r.start,
> > +		  MPIC_PRIMARY | MPIC_WANTS_RESET |
> > +		  MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS |
> > +		  MPIC_SINGLE_DEST_CPU,
> > +		  0, 256, " OpenPIC  ");
> > +
> > +	BUG_ON(mpic =3D=3D NULL);
> > +	of_node_put(np);
> > +
> > +	mpic_init(mpic);
> > +
> > +}
> > +
> > +/*
> > + * Setup the architecture
> > + */
> > +#ifdef CONFIG_SMP
> > +extern void __init mpc85xx_smp_init(void);
> > +#endif
> > +static void __init mpc85xx_rdb_setup_arch(void)
> > +{
> > +#ifdef CONFIG_PCI
> > +	struct device_node *np;
> > +#endif
> > +
> > +	if (ppc_md.progress)
> > +		ppc_md.progress("mpc85xx_rdb_setup_arch()", 0);
> > +
> > +#ifdef CONFIG_PCI
> > +	for_each_node_by_type(np, "pci") {
> > +		if (of_device_is_compatible(np, "fsl,mpc8548-pcie"))
> > +			fsl_add_bridge(np, 0);
> > +	}
> > +
> > +#endif
> > +
> > +#ifdef CONFIG_SMP
> > +	mpc85xx_smp_init();
> > +#endif
> > +
> > +	printk(KERN_INFO "MPC85xx RDB board from Freescale=20
> Semiconductor\n");
> > +}
> > +
> > +static struct of_device_id __initdata mpc85xxrdb_ids[] =3D {
> > +	{ .type =3D "soc", },
> > +	{ .compatible =3D "soc", },
> > +	{ .compatible =3D "simple-bus", },
> > +	{ .compatible =3D "gianfar", },
> > +	{},
> > +};
> > +
> > +static int __init mpc85xxrdb_publish_devices(void)
> > +{
> > +	return of_platform_bus_probe(NULL, mpc85xxrdb_ids, NULL);
> > +}
> > +machine_device_initcall(p2020_rdb, mpc85xxrdb_publish_devices);
> > +
> > +/*
> > + * Called very early, device-tree isn't unflattened
> > + */
> > +static int __init p2020_rdb_probe(void)
> > +{
> > +	unsigned long root =3D of_get_flat_dt_root();
> > +
> > +	if (of_flat_dt_is_compatible(root, "fsl,P2020RDB"))
> > +		return 1;
> > +	return 0;
> > +}
> > +
> > +define_machine(p2020_rdb) {
> > +	.name			=3D "P2020 RDB",
> > +	.probe			=3D p2020_rdb_probe,
> > +	.setup_arch		=3D mpc85xx_rdb_setup_arch,
> > +	.init_IRQ		=3D mpc85xx_rdb_pic_init,
> > +#ifdef CONFIG_PCI
> > +	.pcibios_fixup_bus	=3D fsl_pcibios_fixup_bus,
> > +#endif
> > +	.get_irq		=3D mpic_get_irq,
> > +	.restart		=3D fsl_rstcr_restart,
> > +	.calibrate_decr		=3D generic_calibrate_decr,
> > +	.progress		=3D udbg_progress,
> > +};
>=20
