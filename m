Return-Path: <Poonam.Aggrwal@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 850D1B7B70
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Sep 2009 20:23:00 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n8MAMuju002741
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Sep 2009 03:22:57 -0700 (MST)
Received: from zin33exm24.fsl.freescale.net (zin33exm24.ap.freescale.net
	[10.232.192.24])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n8MAP0XQ021692
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Sep 2009 05:25:01 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH][v3] powerpc/85xx: P1020RDB Support Added
Date: Tue, 22 Sep 2009 15:52:50 +0530
Message-ID: <1BD5CFC378ED0946B688E0C9BA2EF09525A122@zin33exm24.fsl.freescale.net>
In-Reply-To: <1251719528-13265-1-git-send-email-poonam.aggrwal@freescale.com>
References: <1251719528-13265-1-git-send-email-poonam.aggrwal@freescale.com>
From: "Aggrwal Poonam-B10812" <Poonam.Aggrwal@freescale.com>
To: "Aggrwal Poonam-B10812" <Poonam.Aggrwal@freescale.com>,
	<linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Kumar

Could you please accept this patch if it is okay.

Regards
POonam=20

> -----Original Message-----
> From: Aggrwal Poonam-B10812=20
> Sent: Monday, August 31, 2009 5:22 PM
> To: linuxppc-dev@ozlabs.org
> Cc: Aggrwal Poonam-B10812
> Subject: [PATCH][v3] powerpc/85xx: P1020RDB Support Added
>=20
> P1020 is another member of Freescale QorIQ series of processors.
> It is an e500 based dual core SOC.
> Being a scaled down version of P2020 it has following=20
> differences from P2020:
> - 533MHz - 800MHz core frequency.
> - 256Kbyte L2 cache
> - Ethernet controllers with classification capabilities(new=20
> controller).
> From board perspective P1020RDB is same as P2020RDB.
>=20
> * This code adds the basic basic platform support for P1020RDB.
>=20
> Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
> ---
> - based on=20
> http://www.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git
> - branch->next
> - The patch does not contain ethernet support because P1020=20
> contains new eTSEC
>   controller. The support will be added in the later patches.
>  arch/powerpc/boot/dts/p1020rdb.dts        |  477=20
> +++++++++++++++++++++++++++++
>  arch/powerpc/platforms/85xx/mpc85xx_rdb.c |   24 ++
>  2 files changed, 501 insertions(+), 0 deletions(-)  create=20
> mode 100644 arch/powerpc/boot/dts/p1020rdb.dts
>=20
> diff --git a/arch/powerpc/boot/dts/p1020rdb.dts=20
> b/arch/powerpc/boot/dts/p1020rdb.dts
> new file mode 100644
> index 0000000..de5672c
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/p1020rdb.dts
> @@ -0,0 +1,477 @@
> +/*
> + * P1020 RDB Device Tree Source
> + *
> + * Copyright 2009 Freescale Semiconductor Inc.
> + *
> + * This program is free software; you can redistribute  it and/or=20
> +modify it
> + * under  the terms of  the GNU General  Public License as=20
> published by=20
> +the
> + * Free Software Foundation;  either version 2 of the =20
> License, or (at=20
> +your
> + * option) any later version.
> + */
> +
> +/dts-v1/;
> +/ {
> +	model =3D "fsl,P1020";
> +	compatible =3D "fsl,P1020RDB";
> +	#address-cells =3D <2>;
> +	#size-cells =3D <2>;
> +
> +	aliases {
> +		serial0 =3D &serial0;
> +		serial1 =3D &serial1;
> +		pci0 =3D &pci0;
> +		pci1 =3D &pci1;
> +	};
> +
> +	cpus {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		PowerPC,P1020@0 {
> +			device_type =3D "cpu";
> +			reg =3D <0x0>;
> +			next-level-cache =3D <&L2>;
> +		};
> +
> +		PowerPC,P1020@1 {
> +			device_type =3D "cpu";
> +			reg =3D <0x1>;
> +			next-level-cache =3D <&L2>;
> +		};
> +	};
> +
> +	memory {
> +		device_type =3D "memory";
> +	};
> +
> +	localbus@ffe05000 {
> +		#address-cells =3D <2>;
> +		#size-cells =3D <1>;
> +		compatible =3D "fsl,p1020-elbc", "fsl,elbc", "simple-bus";
> +		reg =3D <0 0xffe05000 0 0x1000>;
> +		interrupts =3D <19 2>;
> +		interrupt-parent =3D <&mpic>;
> +
> +		/* NOR and NAND Flashes */
> +		ranges =3D <0x0 0x0 0x0 0xef000000 0x01000000
> +			  0x1 0x0 0x0 0xffa00000 0x00040000
> +			  0x2 0x0 0x0 0xffb00000 0x00020000>;
> +
> +		nor@0,0 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +			compatible =3D "cfi-flash";
> +			reg =3D <0x0 0x0 0x1000000>;
> +			bank-width =3D <2>;
> +			device-width =3D <1>;
> +
> +			partition@0 {
> +				/* This location must not be altered  */
> +				/* 256KB for Vitesse 7385=20
> Switch firmware */
> +				reg =3D <0x0 0x00040000>;
> +				label =3D "NOR (RO) Vitesse-7385=20
> Firmware";
> +				read-only;
> +			};
> +
> +			partition@40000 {
> +				/* 256KB for DTB Image */
> +				reg =3D <0x00040000 0x00040000>;
> +				label =3D "NOR (RO) DTB Image";
> +				read-only;
> +			};
> +
> +			partition@80000 {
> +				/* 3.5 MB for Linux Kernel Image */
> +				reg =3D <0x00080000 0x00380000>;
> +				label =3D "NOR (RO) Linux Kernel Image";
> +				read-only;
> +			};
> +
> +			partition@400000 {
> +				/* 11MB for JFFS2 based Root=20
> file System */
> +				reg =3D <0x00400000 0x00b00000>;
> +				label =3D "NOR (RW) JFFS2 Root=20
> File System";
> +			};
> +
> +			partition@f00000 {
> +				/* This location must not be altered  */
> +				/* 512KB for u-boot Bootloader Image */
> +				/* 512KB for u-boot Environment=20
> Variables */
> +				reg =3D <0x00f00000 0x00100000>;
> +				label =3D "NOR (RO) U-Boot Image";
> +				read-only;
> +			};
> +		};
> +
> +		nand@1,0 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +			compatible =3D "fsl,p1020-fcm-nand",
> +				     "fsl,elbc-fcm-nand";
> +			reg =3D <0x1 0x0 0x40000>;
> +
> +			partition@0 {
> +				/* This location must not be altered  */
> +				/* 1MB for u-boot Bootloader Image */
> +				reg =3D <0x0 0x00100000>;
> +				label =3D "NAND (RO) U-Boot Image";
> +				read-only;
> +			};
> +
> +			partition@100000 {
> +				/* 1MB for DTB Image */
> +				reg =3D <0x00100000 0x00100000>;
> +				label =3D "NAND (RO) DTB Image";
> +				read-only;
> +			};
> +
> +			partition@200000 {
> +				/* 4MB for Linux Kernel Image */
> +				reg =3D <0x00200000 0x00400000>;
> +				label =3D "NAND (RO) Linux Kernel Image";
> +				read-only;
> +			};
> +
> +			partition@600000 {
> +				/* 4MB for Compressed Root file=20
> System Image */
> +				reg =3D <0x00600000 0x00400000>;
> +				label =3D "NAND (RO) Compressed=20
> RFS Image";
> +				read-only;
> +			};
> +
> +			partition@a00000 {
> +				/* 7MB for JFFS2 based Root=20
> file System */
> +				reg =3D <0x00a00000 0x00700000>;
> +				label =3D "NAND (RW) JFFS2 Root=20
> File System";
> +			};
> +
> +			partition@1100000 {
> +				/* 15MB for JFFS2 based Root=20
> file System */
> +				reg =3D <0x01100000 0x00f00000>;
> +				label =3D "NAND (RW) Writable User area";
> +			};
> +		};
> +
> +		L2switch@2,0 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +			compatible =3D "vitesse-7385";
> +			reg =3D <0x2 0x0 0x20000>;
> +		};
> +
> +	};
> +
> +	soc@ffe00000 {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		device_type =3D "soc";
> +		compatible =3D "fsl,p1020-immr", "simple-bus";
> +		ranges =3D <0x0  0x0 0xffe00000 0x100000>;
> +		bus-frequency =3D <0>;		// Filled out by uboot.
> +
> +		ecm-law@0 {
> +			compatible =3D "fsl,ecm-law";
> +			reg =3D <0x0 0x1000>;
> +			fsl,num-laws =3D <12>;
> +		};
> +
> +		ecm@1000 {
> +			compatible =3D "fsl,p1020-ecm", "fsl,ecm";
> +			reg =3D <0x1000 0x1000>;
> +			interrupts =3D <16 2>;
> +			interrupt-parent =3D <&mpic>;
> +		};
> +
> +		memory-controller@2000 {
> +			compatible =3D "fsl,p1020-memory-controller";
> +			reg =3D <0x2000 0x1000>;
> +			interrupt-parent =3D <&mpic>;
> +			interrupts =3D <16 2>;
> +		};
> +
> +		i2c@3000 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			cell-index =3D <0>;
> +			compatible =3D "fsl-i2c";
> +			reg =3D <0x3000 0x100>;
> +			interrupts =3D <43 2>;
> +			interrupt-parent =3D <&mpic>;
> +			dfsrr;
> +			rtc@68 {
> +				compatible =3D "dallas,ds1339";
> +				reg =3D <0x68>;
> +			};
> +		};
> +
> +		i2c@3100 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			cell-index =3D <1>;
> +			compatible =3D "fsl-i2c";
> +			reg =3D <0x3100 0x100>;
> +			interrupts =3D <43 2>;
> +			interrupt-parent =3D <&mpic>;
> +			dfsrr;
> +		};
> +
> +		serial0: serial@4500 {
> +			cell-index =3D <0>;
> +			device_type =3D "serial";
> +			compatible =3D "ns16550";
> +			reg =3D <0x4500 0x100>;
> +			clock-frequency =3D <0>;
> +			interrupts =3D <42 2>;
> +			interrupt-parent =3D <&mpic>;
> +		};
> +
> +		serial1: serial@4600 {
> +			cell-index =3D <1>;
> +			device_type =3D "serial";
> +			compatible =3D "ns16550";
> +			reg =3D <0x4600 0x100>;
> +			clock-frequency =3D <0>;
> +			interrupts =3D <42 2>;
> +			interrupt-parent =3D <&mpic>;
> +		};
> +
> +		spi@7000 {
> +			cell-index =3D <0>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			compatible =3D "fsl,espi";
> +			reg =3D <0x7000 0x1000>;
> +			interrupts =3D <59 0x2>;
> +			interrupt-parent =3D <&mpic>;
> +			mode =3D "cpu";
> +
> +			fsl_m25p80@0 {
> +				#address-cells =3D <1>;
> +				#size-cells =3D <1>;
> +				compatible =3D "fsl,espi-flash";
> +				reg =3D <0>;
> +				linux,modalias =3D "fsl_m25p80";
> +				modal =3D "s25sl128b";
> +				spi-max-frequency =3D <50000000>;
> +				mode =3D <0>;
> +
> +				partition@0 {
> +					/* 512KB for u-boot=20
> Bootloader Image */
> +					reg =3D <0x0 0x00080000>;
> +					label =3D "SPI (RO) U-Boot Image";
> +					read-only;
> +				};
> +
> +				partition@80000 {
> +					/* 512KB for DTB Image */
> +					reg =3D <0x00080000 0x00080000>;
> +					label =3D "SPI (RO) DTB Image";
> +					read-only;
> +				};
> +
> +				partition@100000 {
> +					/* 4MB for Linux Kernel Image */
> +					reg =3D <0x00100000 0x00400000>;
> +					label =3D "SPI (RO) Linux=20
> Kernel Image";
> +					read-only;
> +				};
> +
> +				partition@500000 {
> +					/* 4MB for Compressed=20
> RFS Image */
> +					reg =3D <0x00500000 0x00400000>;
> +					label =3D "SPI (RO)=20
> Compressed RFS Image";
> +					read-only;
> +				};
> +
> +				partition@900000 {
> +					/* 7MB for JFFS2 based RFS */
> +					reg =3D <0x00900000 0x00700000>;
> +					label =3D "SPI (RW) JFFS2 RFS";
> +				};
> +			};
> +		};
> +
> +		gpio: gpio-controller@f000 {
> +			#gpio-cells =3D <2>;
> +			compatible =3D "fsl,mpc8572-gpio";
> +			reg =3D <0xf000 0x100>;
> +			interrupts =3D <47 0x2>;
> +			interrupt-parent =3D <&mpic>;
> +			gpio-controller;
> +		};
> +
> +		L2: l2-cache-controller@20000 {
> +			compatible =3D "fsl,p1020-l2-cache-controller";
> +			reg =3D <0x20000 0x1000>;
> +			cache-line-size =3D <32>;	// 32 bytes
> +			cache-size =3D <0x40000>; // L2,256K
> +			interrupt-parent =3D <&mpic>;
> +			interrupts =3D <16 2>;
> +		};
> +
> +		dma@21300 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +			compatible =3D "fsl,eloplus-dma";
> +			reg =3D <0x21300 0x4>;
> +			ranges =3D <0x0 0x21100 0x200>;
> +			cell-index =3D <0>;
> +			dma-channel@0 {
> +				compatible =3D "fsl,eloplus-dma-channel";
> +				reg =3D <0x0 0x80>;
> +				cell-index =3D <0>;
> +				interrupt-parent =3D <&mpic>;
> +				interrupts =3D <20 2>;
> +			};
> +			dma-channel@80 {
> +				compatible =3D "fsl,eloplus-dma-channel";
> +				reg =3D <0x80 0x80>;
> +				cell-index =3D <1>;
> +				interrupt-parent =3D <&mpic>;
> +				interrupts =3D <21 2>;
> +			};
> +			dma-channel@100 {
> +				compatible =3D "fsl,eloplus-dma-channel";
> +				reg =3D <0x100 0x80>;
> +				cell-index =3D <2>;
> +				interrupt-parent =3D <&mpic>;
> +				interrupts =3D <22 2>;
> +			};
> +			dma-channel@180 {
> +				compatible =3D "fsl,eloplus-dma-channel";
> +				reg =3D <0x180 0x80>;
> +				cell-index =3D <3>;
> +				interrupt-parent =3D <&mpic>;
> +				interrupts =3D <23 2>;
> +			};
> +		};
> +
> +		usb@22000 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			compatible =3D "fsl-usb2-dr";
> +			reg =3D <0x22000 0x1000>;
> +			interrupt-parent =3D <&mpic>;
> +			interrupts =3D <28 0x2>;
> +			phy_type =3D "ulpi";
> +		};
> +
> +		usb@23000 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			compatible =3D "fsl-usb2-dr";
> +			reg =3D <0x23000 0x1000>;
> +			interrupt-parent =3D <&mpic>;
> +			interrupts =3D <46 0x2>;
> +			phy_type =3D "ulpi";
> +		};
> +
> +		sdhci@2e000 {
> +			compatible =3D "fsl,p1020-esdhc", "fsl,esdhc";
> +			reg =3D <0x2e000 0x1000>;
> +			interrupts =3D <72 0x2>;
> +			interrupt-parent =3D <&mpic>;
> +			/* Filled in by U-Boot */
> +			clock-frequency =3D <0>;
> +		};
> +
> +		crypto@30000 {
> +			compatible =3D "fsl,sec3.1",=20
> "fsl,sec3.0", "fsl,sec2.4",
> +				     "fsl,sec2.2",=20
> "fsl,sec2.1", "fsl,sec2.0";
> +			reg =3D <0x30000 0x10000>;
> +			interrupts =3D <45 2 58 2>;
> +			interrupt-parent =3D <&mpic>;
> +			fsl,num-channels =3D <4>;
> +			fsl,channel-fifo-len =3D <24>;
> +			fsl,exec-units-mask =3D <0xbfe>;
> +			fsl,descriptor-types-mask =3D <0x3ab0ebf>;
> +		};
> +
> +		mpic: pic@40000 {
> +			interrupt-controller;
> +			#address-cells =3D <0>;
> +			#interrupt-cells =3D <2>;
> +			reg =3D <0x40000 0x40000>;
> +			compatible =3D "chrp,open-pic";
> +			device_type =3D "open-pic";
> +		};
> +
> +		msi@41600 {
> +			compatible =3D "fsl,p1020-msi", "fsl,mpic-msi";
> +			reg =3D <0x41600 0x80>;
> +			msi-available-ranges =3D <0 0x100>;
> +			interrupts =3D <
> +				0xe0 0
> +				0xe1 0
> +				0xe2 0
> +				0xe3 0
> +				0xe4 0
> +				0xe5 0
> +				0xe6 0
> +				0xe7 0>;
> +			interrupt-parent =3D <&mpic>;
> +		};
> +
> +		global-utilities@e0000 {	//global utilities block
> +			compatible =3D "fsl,p1020-guts";
> +			reg =3D <0xe0000 0x1000>;
> +			fsl,has-rstcr;
> +		};
> +	};
> +
> +	pci0: pcie@ffe09000 {
> +		compatible =3D "fsl,mpc8548-pcie";
> +		device_type =3D "pci";
> +		#interrupt-cells =3D <1>;
> +		#size-cells =3D <2>;
> +		#address-cells =3D <3>;
> +		reg =3D <0 0xffe09000 0 0x1000>;
> +		bus-range =3D <0 255>;
> +		ranges =3D <0x2000000 0x0 0xa0000000 0 0xa0000000=20
> 0x0 0x20000000
> +			  0x1000000 0x0 0x00000000 0 0xffc30000=20
> 0x0 0x10000>;
> +		clock-frequency =3D <33333333>;
> +		interrupt-parent =3D <&mpic>;
> +		interrupts =3D <16 2>;
> +		pcie@0 {
> +			reg =3D <0x0 0x0 0x0 0x0 0x0>;
> +			#size-cells =3D <2>;
> +			#address-cells =3D <3>;
> +			device_type =3D "pci";
> +			ranges =3D <0x2000000 0x0 0xa0000000
> +				  0x2000000 0x0 0xa0000000
> +				  0x0 0x20000000
> +
> +				  0x1000000 0x0 0x0
> +				  0x1000000 0x0 0x0
> +				  0x0 0x100000>;
> +		};
> +	};
> +
> +	pci1: pcie@ffe0a000 {
> +		compatible =3D "fsl,mpc8548-pcie";
> +		device_type =3D "pci";
> +		#interrupt-cells =3D <1>;
> +		#size-cells =3D <2>;
> +		#address-cells =3D <3>;
> +		reg =3D <0 0xffe0a000 0 0x1000>;
> +		bus-range =3D <0 255>;
> +		ranges =3D <0x2000000 0x0 0xc0000000 0 0xc0000000=20
> 0x0 0x20000000
> +			  0x1000000 0x0 0x00000000 0 0xffc20000=20
> 0x0 0x10000>;
> +		clock-frequency =3D <33333333>;
> +		interrupt-parent =3D <&mpic>;
> +		interrupts =3D <16 2>;
> +		pcie@0 {
> +			reg =3D <0x0 0x0 0x0 0x0 0x0>;
> +			#size-cells =3D <2>;
> +			#address-cells =3D <3>;
> +			device_type =3D "pci";
> +			ranges =3D <0x2000000 0x0 0xc0000000
> +				  0x2000000 0x0 0xc0000000
> +				  0x0 0x20000000
> +
> +				  0x1000000 0x0 0x0
> +				  0x1000000 0x0 0x0
> +				  0x0 0x100000>;
> +		};
> +	};
> +};
> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c=20
> b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> index c8468de..495bd8b 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> @@ -113,6 +113,7 @@ static int __init mpc85xxrdb_publish_devices(void)
>  	return of_platform_bus_probe(NULL, mpc85xxrdb_ids,=20
> NULL);  }  machine_device_initcall(p2020_rdb,=20
> mpc85xxrdb_publish_devices);
> +machine_device_initcall(p1020_rdb, mpc85xxrdb_publish_devices);
> =20
>  /*
>   * Called very early, device-tree isn't unflattened @@=20
> -126,6 +127,15 @@ static int __init p2020_rdb_probe(void)
>  	return 0;
>  }
> =20
> +static int __init p1020_rdb_probe(void) {
> +	unsigned long root =3D of_get_flat_dt_root();
> +
> +	if (of_flat_dt_is_compatible(root, "fsl,P1020RDB"))
> +		return 1;
> +	return 0;
> +}
> +
>  define_machine(p2020_rdb) {
>  	.name			=3D "P2020 RDB",
>  	.probe			=3D p2020_rdb_probe,
> @@ -139,3 +149,17 @@ define_machine(p2020_rdb) {
>  	.calibrate_decr		=3D generic_calibrate_decr,
>  	.progress		=3D udbg_progress,
>  };
> +
> +define_machine(p1020_rdb) {
> +	.name			=3D "P1020 RDB",
> +	.probe			=3D p1020_rdb_probe,
> +	.setup_arch		=3D mpc85xx_rdb_setup_arch,
> +	.init_IRQ		=3D mpc85xx_rdb_pic_init,
> +#ifdef CONFIG_PCI
> +	.pcibios_fixup_bus	=3D fsl_pcibios_fixup_bus,
> +#endif
> +	.get_irq		=3D mpic_get_irq,
> +	.restart		=3D fsl_rstcr_restart,
> +	.calibrate_decr		=3D generic_calibrate_decr,
> +	.progress		=3D udbg_progress,
> +};
> --
> 1.5.6.5
>=20
>=20
