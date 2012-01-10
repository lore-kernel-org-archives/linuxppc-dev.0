Return-Path: <B37781@freescale.com>
Received: from TX2EHSOBE009.bigfish.com (tx2ehsobe004.messaging.microsoft.com
 [65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 30974B7004
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2012 18:18:49 +1100 (EST)
Subject: Re: [SDK v1.2][PATCH 1/2 v3] powerpc/85xx: Add dts for P1021RDB-PC
 board
From: Xu Jiucheng <B37781@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>
In-Reply-To: <1326092022-10085-1-git-send-email-B37781@freescale.com>
References: <1326092022-10085-1-git-send-email-B37781@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 10 Jan 2012 15:22:30 +0800
Message-ID: <1326180150.1895.11.camel@xujc-desktop>
MIME-Version: 1.0
Cc: Matthew McClintock <msm@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm sorry, please ignore this email.

Thanks & Best Regards
Jiucheng

=E5=9C=A8 2012-01-09Mon=E7=9A=84 14:53 +0800=EF=BC=8CXu Jiucheng=E5=86=99=
=E9=81=93=EF=BC=9A
> P1021RDB-PC Overview
> -----------------
> 1Gbyte DDR3 (on board DDR)
> 16Mbyte NOR flash
> 32Mbyte eSLC NAND Flash
> 256 Kbit M24256 I2C EEPROM
> 128 Mbit SPI Flash memory
> Real-time clock on I2C bus
> SD/MMC connector to interface with the SD memory card
> PCIex
>     - x1 PCIe slot or x1 PCIe to dual SATA controller
>     - x1 mini-PCIe slot
> USB 2.0
>     - ULPI PHY interface: SMSC USB3300 USB PHY and Genesys Logic=E2=80=99=
s GL850A
>     - Two USB2.0 Type A receptacles
>     - One USB2.0 signal to Mini PCIe slot
> eTSEC1: Connected to RGMII PHY VSC7385
> eTSEC2: Connected to SGMII PHY VSC8221
> eTSEC3: Connected to SGMII PHY AR8021
> DUART interface: supports two UARTs up to 115200 bps for console displa=
y
>=20
> Signed-off-by: Matthew McClintock <msm@freescale.com>
> Signed-off-by: Xu Jiucheng <B37781@freescale.com>
> ---
>  arch/powerpc/boot/dts/fsl/p1021si-post.dtsi |    4 +
>  arch/powerpc/boot/dts/p1021rdb.dts          |   96 +++++++++++
>  arch/powerpc/boot/dts/p1021rdb.dtsi         |  236 +++++++++++++++++++=
++++++++
>  arch/powerpc/boot/dts/p1021rdb_36b.dts      |   96 +++++++++++
>  4 files changed, 432 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/p1021rdb.dts
>  create mode 100644 arch/powerpc/boot/dts/p1021rdb.dtsi
>  create mode 100644 arch/powerpc/boot/dts/p1021rdb_36b.dts
>=20
> diff --git a/arch/powerpc/boot/dts/fsl/p1021si-post.dtsi b/arch/powerpc=
/boot/dts/fsl/p1021si-post.dtsi
> index 38ba54d..b7929c9 100644
> --- a/arch/powerpc/boot/dts/fsl/p1021si-post.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/p1021si-post.dtsi
> @@ -144,6 +144,10 @@
>  /include/ "pq3-usb2-dr-0.dtsi"
> =20
>  /include/ "pq3-esdhc-0.dtsi"
> +	sdhc@2e000 {
> +		sdhci,auto-cmd12;
> +	};
> +
>  /include/ "pq3-sec3.3-0.dtsi"
> =20
>  /include/ "pq3-mpic.dtsi"
> diff --git a/arch/powerpc/boot/dts/p1021rdb.dts b/arch/powerpc/boot/dts=
/p1021rdb.dts
> new file mode 100644
> index 0000000..90b6b4c
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/p1021rdb.dts
> @@ -0,0 +1,96 @@
> +/*
> + * P1021 RDB Device Tree Source
> + *
> + * Copyright 2011 Freescale Semiconductor Inc.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions =
are met:
> + *     * Redistributions of source code must retain the above copyrigh=
t
> + *       notice, this list of conditions and the following disclaimer.
> + *     * Redistributions in binary form must reproduce the above copyr=
ight
> + *       notice, this list of conditions and the following disclaimer =
in the
> + *       documentation and/or other materials provided with the distri=
bution.
> + *     * Neither the name of Freescale Semiconductor nor the
> + *       names of its contributors may be used to endorse or promote p=
roducts
> + *       derived from this software without specific prior written per=
mission.
> + *
> + *
> + * ALTERNATIVELY, this software may be distributed under the terms of =
the
> + * GNU General Public License ("GPL") as published by the Free Softwar=
e
> + * Foundation, either version 2 of that License or (at your option) an=
y
> + * later version.
> + *
> + * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor "AS IS" AND AN=
Y
> + * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE I=
MPLIED
> + * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE =
ARE
> + * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR=
 ANY
> + * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL =
DAMAGES
> + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR =
SERVICES;
> + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CA=
USED AND
> + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, =
OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE U=
SE OF THIS
> + * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + */
> +
> +/include/ "fsl/p1021si-pre.dtsi"
> +/ {
> +	model =3D "fsl,P1021RDB";
> +	compatible =3D "fsl,P1021RDB-PC";
> +
> +	memory {
> +		device_type =3D "memory";
> +	};
> +
> +	lbc: localbus@ffe05000 {
> +		reg =3D <0 0xffe05000 0 0x1000>;
> +
> +		/* NOR, NAND Flashes and Vitesse 5 port L2 switch */
> +		ranges =3D <0x0 0x0 0x0 0xef000000 0x01000000
> +			  0x1 0x0 0x0 0xff800000 0x00040000
> +			  0x2 0x0 0x0 0xffb00000 0x00020000>;
> +	};
> +
> +	soc: soc@ffe00000 {
> +		ranges =3D <0x0 0x0 0xffe00000 0x100000>;
> +	};
> +
> +	pci0: pcie@ffe09000 {
> +		ranges =3D <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
> +			  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x10000>;
> +		reg =3D <0 0xffe09000 0 0x1000>;
> +		pcie@0 {
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
> +		reg =3D <0 0xffe0a000 0 0x1000>;
> +		ranges =3D <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x20000000
> +			  0x1000000 0x0 0x00000000 0 0xffc00000 0x0 0x10000>;
> +		pcie@0 {
> +			ranges =3D <0x2000000 0x0 0x80000000
> +				  0x2000000 0x0 0x80000000
> +				  0x0 0x20000000
> +
> +				  0x1000000 0x0 0x0
> +				  0x1000000 0x0 0x0
> +				  0x0 0x100000>;
> +		};
> +	};
> +
> +	qe: qe@ffe80000 {
> +                ranges =3D <0x0 0x0 0xffe80000 0x40000>;
> +                reg =3D <0 0xffe80000 0 0x480>;
> +                brg-frequency =3D <0>;
> +                bus-frequency =3D <0>;
> +        };
> +};
> +
> +/include/ "p1021rdb.dtsi"
> +/include/ "fsl/p1021si-post.dtsi"
> diff --git a/arch/powerpc/boot/dts/p1021rdb.dtsi b/arch/powerpc/boot/dt=
s/p1021rdb.dtsi
> new file mode 100644
> index 0000000..22ecb6e
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/p1021rdb.dtsi
> @@ -0,0 +1,236 @@
> +/*
> + * P1021 RDB Device Tree Source stub (no addresses or top-level ranges=
)
> + *
> + * Copyright 2011 Freescale Semiconductor Inc.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions =
are met:
> + *     * Redistributions of source code must retain the above copyrigh=
t
> + *       notice, this list of conditions and the following disclaimer.
> + *     * Redistributions in binary form must reproduce the above copyr=
ight
> + *       notice, this list of conditions and the following disclaimer =
in the
> + *       documentation and/or other materials provided with the distri=
bution.
> + *     * Neither the name of Freescale Semiconductor nor the
> + *       names of its contributors may be used to endorse or promote p=
roducts
> + *       derived from this software without specific prior written per=
mission.
> + *
> + *
> + * ALTERNATIVELY, this software may be distributed under the terms of =
the
> + * GNU General Public License ("GPL") as published by the Free Softwar=
e
> + * Foundation, either version 2 of that License or (at your option) an=
y
> + * later version.
> + *
> + * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND =
ANY
> + * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE I=
MPLIED
> + * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE =
ARE
> + * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR=
 ANY
> + * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL =
DAMAGES
> + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR =
SERVICES;
> + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CA=
USED AND
> + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, =
OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE U=
SE OF THIS
> + * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + */
> +
> +&lbc {
> +	nor@0,0 {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		compatible =3D "cfi-flash";
> +		reg =3D <0x0 0x0 0x1000000>;
> +		bank-width =3D <2>;
> +		device-width =3D <1>;
> +
> +		partition@0 {
> +			/* This location must not be altered  */
> +			/* 256KB for Vitesse 7385 Switch firmware */
> +			reg =3D <0x0 0x00040000>;
> +			label =3D "NOR Vitesse-7385 Firmware";
> +			read-only;
> +		};
> +
> +		partition@40000 {
> +			/* 256KB for DTB Image */
> +			reg =3D <0x00040000 0x00040000>;
> +			label =3D "NOR DTB Image";
> +		};
> +
> +		partition@80000 {
> +			/* 3.5 MB for Linux Kernel Image */
> +			reg =3D <0x00080000 0x00380000>;
> +			label =3D "NOR Linux Kernel Image";
> +		};
> +
> +		partition@400000 {
> +			/* 11MB for JFFS2 based Root file System */
> +			reg =3D <0x00400000 0x00b00000>;
> +			label =3D "NOR JFFS2 Root File System";
> +		};
> +
> +		partition@f00000 {
> +			/* This location must not be altered  */
> +			/* 512KB for u-boot Bootloader Image */
> +			/* 512KB for u-boot Environment Variables */
> +			reg =3D <0x00f00000 0x00100000>;
> +			label =3D "NOR U-Boot Image";
> +		};
> +	};
> +
> +	nand@1,0 {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		compatible =3D "fsl,p1020-fcm-nand",
> +			     "fsl,elbc-fcm-nand";
> +		reg =3D <0x1 0x0 0x40000>;
> +
> +		partition@0 {
> +			/* This location must not be altered  */
> +			/* 1MB for u-boot Bootloader Image */
> +			reg =3D <0x0 0x00100000>;
> +			label =3D "NAND U-Boot Image";
> +			read-only;
> +		};
> +
> +		partition@100000 {
> +			/* 1MB for DTB Image */
> +			reg =3D <0x00100000 0x00100000>;
> +			label =3D "NAND DTB Image";
> +		};
> +
> +		partition@200000 {
> +			/* 4MB for Linux Kernel Image */
> +			reg =3D <0x00200000 0x00400000>;
> +			label =3D "NAND Linux Kernel Image";
> +		};
> +
> +		partition@600000 {
> +			/* 4MB for Compressed Root file System Image */
> +			reg =3D <0x00600000 0x00400000>;
> +			label =3D "NAND Compressed RFS Image";
> +		};
> +
> +		partition@a00000 {
> +			/* 7MB for JFFS2 based Root file System */
> +			reg =3D <0x00a00000 0x00700000>;
> +			label =3D "NAND JFFS2 Root File System";
> +		};
> +
> +		partition@1100000 {
> +			/* 15MB for User Writable Area  */
> +			reg =3D <0x01100000 0x00f00000>;
> +			label =3D "NAND Writable User area";
> +		};
> +	};
> +
> +	L2switch@2,0 {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		compatible =3D "vitesse-7385";
> +		reg =3D <0x2 0x0 0x20000>;
> +	};
> +};
> +
> +&soc {
> +	i2c@3000 {
> +		rtc@68 {
> +			compatible =3D "pericom,pt7c4338";
> +			reg =3D <0x68>;
> +		};
> +	};
> +
> +	spi@7000 {
> +		flash@0 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +			compatible =3D "spansion,s25sl12801";
> +			reg =3D <0>;
> +			spi-max-frequency =3D <40000000>; /* input clock */
> +
> +			partition@u-boot {
> +				/* 512KB for u-boot Bootloader Image */
> +				reg =3D <0x0 0x00080000>;
> +				label =3D "SPI Flash U-Boot Image";
> +				read-only;
> +			};
> +
> +			partition@dtb {
> +				/* 512KB for DTB Image */
> +				reg =3D <0x00080000 0x00080000>;
> +				label =3D "SPI Flash DTB Image";
> +			};
> +
> +			partition@kernel {
> +				/* 4MB for Linux Kernel Image */
> +				reg =3D <0x00100000 0x00400000>;
> +				label =3D "SPI Flash Linux Kernel Image";
> +			};
> +
> +			partition@fs {
> +				/* 4MB for Compressed RFS Image */
> +				reg =3D <0x00500000 0x00400000>;
> +				label =3D "SPI Flash Compressed RFSImage";
> +			};
> +
> +			partition@jffs-fs {
> +				/* 7MB for JFFS2 based RFS */
> +				reg =3D <0x00900000 0x00700000>;
> +				label =3D "SPI Flash JFFS2 RFS";
> +			};
> +		};
> +	};
> +
> +	usb@22000 {
> +		phy_type =3D "ulpi";
> +	};
> +
> +	mdio@24000 {
> +		phy0: ethernet-phy@0 {
> +			interrupt-parent =3D <&mpic>;
> +			interrupts =3D <3 1>;
> +			reg =3D <0x0>;
> +		};
> +
> +		phy1: ethernet-phy@1 {
> +			interrupt-parent =3D <&mpic>;
> +			interrupts =3D <2 1>;
> +			reg =3D <0x1>;
> +		};
> +
> +		tbi0: tbi-phy@11 {
> +			reg =3D <0x11>;
> +			device_type =3D "tbi-phy";
> +		};
> +	};
> +
> +	mdio@25000 {
> +		tbi1: tbi-phy@11 {
> +			reg =3D <0x11>;
> +			device_type =3D "tbi-phy";
> +		};
> +	};
> +
> +	mdio@26000 {
> +		tbi2: tbi-phy@11 {
> +			reg =3D <0x11>;
> +			device_type =3D "tbi-phy";
> +		};
> +	};
> +
> +	enet0: ethernet@b0000 {
> +		fixed-link =3D <1 1 1000 0 0>;
> +		phy-connection-type =3D "rgmii-id";
> +
> +	};
> +
> +	enet1: ethernet@b1000 {
> +		phy-handle =3D <&phy0>;
> +		tbi-handle =3D <&tbi1>;
> +		phy-connection-type =3D "sgmii";
> +	};
> +
> +	enet2: ethernet@b2000 {
> +		phy-handle =3D <&phy1>;
> +		tbi-handle =3D <&tbi2>;
> +		phy-connection-type =3D "rgmii-id";
> +	};
> +};
> diff --git a/arch/powerpc/boot/dts/p1021rdb_36b.dts b/arch/powerpc/boot=
/dts/p1021rdb_36b.dts
> new file mode 100644
> index 0000000..ea6d8b5
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/p1021rdb_36b.dts
> @@ -0,0 +1,96 @@
> +/*
> + * P1021 RDB Device Tree Source (36-bit address map)
> + *
> + * Copyright 2011 Freescale Semiconductor Inc.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions =
are met:
> + *     * Redistributions of source code must retain the above copyrigh=
t
> + *       notice, this list of conditions and the following disclaimer.
> + *     * Redistributions in binary form must reproduce the above copyr=
ight
> + *       notice, this list of conditions and the following disclaimer =
in the
> + *       documentation and/or other materials provided with the distri=
bution.
> + *     * Neither the name of Freescale Semiconductor nor the
> + *       names of its contributors may be used to endorse or promote p=
roducts
> + *       derived from this software without specific prior written per=
mission.
> + *
> + *
> + * ALTERNATIVELY, this software may be distributed under the terms of =
the
> + * GNU General Public License ("GPL") as published by the Free Softwar=
e
> + * Foundation, either version 2 of that License or (at your option) an=
y
> + * later version.
> + *
> + * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor "AS IS" AND AN=
Y
> + * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE I=
MPLIED
> + * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE =
ARE
> + * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR=
 ANY
> + * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL =
DAMAGES
> + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR =
SERVICES;
> + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CA=
USED AND
> + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, =
OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE U=
SE OF THIS
> + * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + */
> +
> +/include/ "fsl/p1021si-pre.dtsi"
> +/ {
> +	model =3D "fsl,P1021RDB";
> +	compatible =3D "fsl,P1021RDB-PC";
> +
> +	memory {
> +		device_type =3D "memory";
> +	};
> +
> +	lbc: localbus@fffe05000 {
> +		reg =3D <0xf 0xffe05000 0 0x1000>;
> +
> +		/* NOR, NAND Flashes and Vitesse 5 port L2 switch */
> +		ranges =3D <0x0 0x0 0xf 0xef000000 0x01000000
> +			  0x1 0x0 0xf 0xff800000 0x00040000
> +			  0x2 0x0 0xf 0xffb00000 0x00020000>;
> +	};
> +
> +	soc: soc@fffe00000 {
> +		ranges =3D <0x0 0xf 0xffe00000 0x100000>;
> +	};
> +
> +	pci0: pcie@fffe09000 {
> +		ranges =3D <0x2000000 0x0 0xc0000000 0xc 0x20000000 0x0 0x20000000
> +			  0x1000000 0x0 0x00000000 0xf 0xffc10000 0x0 0x10000>;
> +		reg =3D <0xf 0xffe09000 0 0x1000>;
> +		pcie@0 {
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
> +	pci1: pcie@fffe0a000 {
> +		reg =3D <0xf 0xffe0a000 0 0x1000>;
> +		ranges =3D <0x2000000 0x0 0x80000000 0xc 0x00000000 0x0 0x20000000
> +			  0x1000000 0x0 0x00000000 0xf 0xffc00000 0x0 0x10000>;
> +		pcie@0 {
> +			ranges =3D <0x2000000 0x0 0xc0000000
> +				  0x2000000 0x0 0xc0000000
> +				  0x0 0x20000000
> +
> +				  0x1000000 0x0 0x0
> +				  0x1000000 0x0 0x0
> +				  0x0 0x100000>;
> +		};
> +	};
> +
> +	qe: qe@fffe80000 {
> +                ranges =3D <0x0 0xf 0xffe80000 0x40000>;
> +                reg =3D <0xf 0xffe80000 0 0x480>;
> +                brg-frequency =3D <0>;
> +                bus-frequency =3D <0>;
> +        };
> +};
> +
> +/include/ "p1021rdb.dtsi"
> +/include/ "fsl/p1021si-post.dtsi"
