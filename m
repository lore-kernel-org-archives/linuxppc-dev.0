Return-Path: <Poonam.Aggrwal@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 684EAB6F20
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Sep 2009 01:18:52 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E6021DDD0C
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 01:18:51 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n8AFIlEt013575
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 08:18:47 -0700 (MST)
Received: from zin33exm24.fsl.freescale.net (zin33exm24.ap.freescale.net
	[10.232.192.24])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n8AFKDgZ025068
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 10:20:14 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH][v1] powerpc/85xx: Create dts for each core in CAMPmode
	for P2020RDB
Date: Thu, 10 Sep 2009 20:48:38 +0530
Message-ID: <1BD5CFC378ED0946B688E0C9BA2EF0951FD268@zin33exm24.fsl.freescale.net>
In-Reply-To: <20090910093307.GA17117@iram.es>
References: <1252573031-4157-1-git-send-email-poonam.aggrwal@freescale.com>
	<20090910093307.GA17117@iram.es>
From: "Aggrwal Poonam-B10812" <Poonam.Aggrwal@freescale.com>
To: "Gabriel Paubert" <paubert@iram.es>
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
> From: Gabriel Paubert [mailto:paubert@iram.es]=20
> Sent: Thursday, September 10, 2009 3:03 PM
> To: Aggrwal Poonam-B10812
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH][v1] powerpc/85xx: Create dts for each=20
> core in CAMPmode for P2020RDB
>=20
> On Thu, Sep 10, 2009 at 02:27:11PM +0530, Poonam Aggrwal wrote:
> > This patch creates the dts files for each core and splits=20
> the devices=20
> > between the two cores for P2020RDB.
> >=20
> > core0 has memory, L2, i2c, spi, dma1, usb, eth0, eth1, crypto,=20
> > global-util, pci0
> > core1 has L2, dma2, eth0, pci1, msi.
>=20
> Surely you mean eth1 and eth2 for core0, no?
Yes you are right , I'll fix this.
>=20
> At least it's what I gather from the code.
>=20
> Also both cores have a node called serial0, at different=20
> addresses but with the same interrupt!
Yes both the UARTS use the same int line in shared mode.=20
>=20
> But in the mpic comment line there is "serial1", and=20
> interrupt 42 is the only number which appears in both lists=20
> of mpic protected interrupts.
I am not sure how to handle the shared interrupts in AMP scenario,
although this has been tested and both serials are working one on each
core.
>=20
Regards
Poonam
> 	Gabriel
>=20
> > ---
> > - based on=20
> > http://www.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git
> > - branch->next
> >  arch/powerpc/boot/dts/p2020rdb_camp_core0.dts |  365=20
> > +++++++++++++++++++++++++ =20
> arch/powerpc/boot/dts/p2020rdb_camp_core1.dts |  186 +++++++++++++
> >  arch/powerpc/platforms/85xx/mpc85xx_rdb.c     |   10 +-
> >  3 files changed, 560 insertions(+), 1 deletions(-)  create mode=20
> > 100644 arch/powerpc/boot/dts/p2020rdb_camp_core0.dts
> >  create mode 100644 arch/powerpc/boot/dts/p2020rdb_camp_core1.dts
> >=20
> > diff --git a/arch/powerpc/boot/dts/p2020rdb_camp_core0.dts=20
> > b/arch/powerpc/boot/dts/p2020rdb_camp_core0.dts
> > new file mode 100644
> > index 0000000..ca072da
> > --- /dev/null
> > +++ b/arch/powerpc/boot/dts/p2020rdb_camp_core0.dts
> > @@ -0,0 +1,365 @@
> > +/*
> > + * P2020 RDB  Core0 Device Tree Source in CAMP mode.
> > + *
> > + * In CAMP mode, each core needs to have its own dts. Only=20
> mpic and=20
> > +L2 cache
> > + * can be shared, all the other devices must be assigned=20
> to one core only.
> > + * This dts file allows core0 to have memory, l2, i2c, spi, gpio,=20
> > +dma1, usb,
> > + * eth1, eth2, sdhc, crypto, global-util, pci0.
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
> > +	compatible =3D "fsl,P2020RDB", "fsl,MPC85XXRDB-CAMP";
> > +	#address-cells =3D <2>;
> > +	#size-cells =3D <2>;
> > +
> > +	aliases {
> > +		ethernet1 =3D &enet1;
> > +		ethernet2 =3D &enet2;
> > +		serial0 =3D &serial0;
> > +		pci0 =3D &pci0;
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
> > +	};
> > +
> > +	memory {
> > +		device_type =3D "memory";
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
> > +		mdio@24520 {
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +			compatible =3D "fsl,gianfar-mdio";
> > +			reg =3D <0x24520 0x20>;
> > +
> > +			phy0: ethernet-phy@0 {
> > +				interrupt-parent =3D <&mpic>;
> > +				interrupts =3D <3 1>;
> > +				reg =3D <0x0>;
> > +			};
> > +			phy1: ethernet-phy@1 {
> > +				interrupt-parent =3D <&mpic>;
> > +				interrupts =3D <3 1>;
> > +				reg =3D <0x1>;
> > +			};
> > +		};
> > +
> > +		mdio@25520 {
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +			compatible =3D "fsl,gianfar-tbi";
> > +			reg =3D <0x26520 0x20>;
> > +
> > +			tbi0: tbi-phy@11 {
> > +				reg =3D <0x11>;
> > +				device_type =3D "tbi-phy";
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
> > +			protected-sources =3D <
> > +			42 76 77 78 79 /* serial1 , dma2 */
> > +			29 30 34 26 /* enet0, pci1 */
> > +			0xe0 0xe1 0xe2 0xe3 /* msi */
> > +			0xe4 0xe5 0xe6 0xe7
> > +			>;
> > +		};
> > +
> > +		global-utilities@e0000 {
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
> > +};
> > diff --git a/arch/powerpc/boot/dts/p2020rdb_camp_core1.dts=20
> > b/arch/powerpc/boot/dts/p2020rdb_camp_core1.dts
> > new file mode 100644
> > index 0000000..c3c9da6
> > --- /dev/null
> > +++ b/arch/powerpc/boot/dts/p2020rdb_camp_core1.dts
> > @@ -0,0 +1,186 @@
> > +/*
> > + * P2020 RDB Core1 Device Tree Source in CAMP mode.
> > + *
> > + * In CAMP mode, each core needs to have its own dts. Only=20
> mpic and=20
> > +L2 cache
> > + * can be shared, all the other devices must be assigned=20
> to one core only.
> > + * This dts allows core1 to have l2, dma2, eth0, pci1, msi.
> > + *
> > + * Please note to add "-b 1" for core1's dts compiling.
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
> > +	compatible =3D "fsl,P2020RDB", "fsl,MPC85XXRDB-CAMP";
> > +	#address-cells =3D <2>;
> > +	#size-cells =3D <2>;
> > +
> > +	aliases {
> > +		ethernet0 =3D &enet0;
> > +		serial0 =3D &serial0;
> > +		pci1 =3D &pci1;
> > +	};
> > +
> > +	cpus {
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <0>;
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
> > +	soc@ffe00000 {
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <1>;
> > +		device_type =3D "soc";
> > +		compatible =3D "fsl,p2020-immr", "simple-bus";
> > +		ranges =3D <0x0  0x0 0xffe00000 0x100000>;
> > +		bus-frequency =3D <0>;		// Filled out by uboot.
> > +
> > +		serial0: serial@4600 {
> > +			cell-index =3D <1>;
> > +			device_type =3D "serial";
> > +			compatible =3D "ns16550";
> > +			reg =3D <0x4600 0x100>;
> > +			clock-frequency =3D <0>;
> > +			interrupts =3D <42 2>;
> > +			interrupt-parent =3D <&mpic>;
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
> > +		L2: l2-cache-controller@20000 {
> > +			compatible =3D "fsl,p2020-l2-cache-controller";
> > +			reg =3D <0x20000 0x1000>;
> > +			cache-line-size =3D <32>;	// 32 bytes
> > +			cache-size =3D <0x80000>; // L2,512K
> > +			interrupt-parent =3D <&mpic>;
> > +		};
> > +
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
> > +		};
> > +
> > +		mpic: pic@40000 {
> > +			interrupt-controller;
> > +			#address-cells =3D <0>;
> > +			#interrupt-cells =3D <2>;
> > +			reg =3D <0x40000 0x40000>;
> > +			compatible =3D "chrp,open-pic";
> > +			device_type =3D "open-pic";
> > +			protected-sources =3D <
> > +			17 18 43 42 59 47 /*ecm, mem, i2c,=20
> serial0, spi,gpio */
> > +			16 20 21 22 23 28 	/* L2, dma1, USB */
> > +			03 35 36 40 31 32 33 	/* mdio, enet1, enet2 */
> > +			72 45 58 25 		/* sdhci,=20
> crypto , pci */
> > +			>;
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
> > diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c=20
> > b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> > index 495bd8b..088f30b 100644
> > --- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> > +++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> > @@ -44,6 +44,7 @@ void __init mpc85xx_rdb_pic_init(void)
> >  	struct mpic *mpic;
> >  	struct resource r;
> >  	struct device_node *np;
> > +	unsigned long root =3D of_get_flat_dt_root();
> > =20
> >  	np =3D of_find_node_by_type(NULL, "open-pic");
> >  	if (np =3D=3D NULL) {
> > @@ -57,11 +58,18 @@ void __init mpc85xx_rdb_pic_init(void)
> >  		return;
> >  	}
> > =20
> > -	mpic =3D mpic_alloc(np, r.start,
> > +	if (of_flat_dt_is_compatible(root, "fsl,85XXRDB-CAMP")) {
> > +		mpic =3D mpic_alloc(np, r.start,
> > +			MPIC_PRIMARY |
> > +			MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS,
> > +			0, 256, " OpenPIC  ");
> > +	} else {
> > +		mpic =3D mpic_alloc(np, r.start,
> >  		  MPIC_PRIMARY | MPIC_WANTS_RESET |
> >  		  MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS |
> >  		  MPIC_SINGLE_DEST_CPU,
> >  		  0, 256, " OpenPIC  ");
> > +	}
> > =20
> >  	BUG_ON(mpic =3D=3D NULL);
> >  	of_node_put(np);
> > --
> > 1.5.6.5
> >=20
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
>=20
>=20
