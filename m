Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CE1672C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Mar 2013 07:26:37 +1100 (EST)
Subject: Re: [PATCH 2/6] powerpc/fsl-booke: Add initial B4860QDS board device
 tree
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1363334109-21922-2-git-send-email-shaveta@freescale.com>
Date: Fri, 15 Mar 2013 15:26:36 -0500
Message-Id: <7EB2D4A9-A5BC-4958-9AD8-51B254666356@kernel.crashing.org>
References: <1363334109-21922-1-git-send-email-shaveta@freescale.com>
 <1363334109-21922-2-git-send-email-shaveta@freescale.com>
To: Shaveta Leekha <shaveta@freescale.com>
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Andy Fleming <afleming@freescale.com>,
 Poonam Aggrwal <poonam.aggrwal@freescale.com>,
 Ramneek Mehresh <ramneek.mehresh@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 15, 2013, at 2:55 AM, Shaveta Leekha wrote:

> Signed-off-by: Shaveta Leekha <shaveta@freescale.com>
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> Signed-off-by: Andy Fleming <afleming@freescale.com>
> Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
> Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/boot/dts/b4860qds.dts |  178 =
++++++++++++++++++++++++++++++++++++
> 1 files changed, 178 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/b4860qds.dts
>=20
> diff --git a/arch/powerpc/boot/dts/b4860qds.dts =
b/arch/powerpc/boot/dts/b4860qds.dts
> new file mode 100644
> index 0000000..ae6ac05
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/b4860qds.dts
> @@ -0,0 +1,178 @@
> +/*
> + * B4860DS Device Tree Source
> + *
> + * Copyright 2012 Freescale Semiconductor Inc.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions =
are met:
> + *     * Redistributions of source code must retain the above =
copyright
> + *       notice, this list of conditions and the following =
disclaimer.
> + *     * Redistributions in binary form must reproduce the above =
copyright
> + *       notice, this list of conditions and the following disclaimer =
in the
> + *       documentation and/or other materials provided with the =
distribution.
> + *     * Neither the name of Freescale Semiconductor nor the
> + *       names of its contributors may be used to endorse or promote =
products
> + *       derived from this software without specific prior written =
permission.
> + *
> + *
> + * ALTERNATIVELY, this software may be distributed under the terms of =
the
> + * GNU General Public License ("GPL") as published by the Free =
Software
> + * Foundation, either version 2 of that License or (at your option) =
any
> + * later version.
> + *
> + * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND =
ANY
> + * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE =
IMPLIED
> + * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE =
ARE
> + * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE =
FOR ANY
> + * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL =
DAMAGES
> + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR =
SERVICES;
> + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER =
CAUSED AND
> + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, =
OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF THIS
> + * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + */
> +
> +/include/ "fsl/b4860si-pre.dtsi"
> +
> +/ {
> +	model =3D "fsl,B4860QDS";
> +	compatible =3D "fsl,B4860QDS";
> +	#address-cells =3D <2>;
> +	#size-cells =3D <2>;
> +	interrupt-parent =3D <&mpic>;
> +
> +	ifc: localbus@ffe124000 {
> +		reg =3D <0xf 0xfe124000 0 0x2000>;
> +		ranges =3D <0 0 0xf 0xe8000000 0x08000000
> +			  2 0 0xf 0xff800000 0x00010000
> +			  3 0 0xf 0xffdf0000 0x00008000>;
> +
> +		nor@0,0 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +			compatible =3D "cfi-flash";
> +			reg =3D <0x0 0x0 0x8000000>;
> +			bank-width =3D <2>;
> +			device-width =3D <1>;
> +		};
> +
> +		nand@2,0 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +			compatible =3D "fsl,ifc-nand";
> +			reg =3D <0x2 0x0 0x10000>;
> +
> +			partition@0 {
> +				/* This location must not be altered  */
> +				/* 1MB for u-boot Bootloader Image */
> +				reg =3D <0x0 0x00100000>;
> +				label =3D "NAND U-Boot Image";
> +				read-only;
> +			};
> +
> +			partition@100000 {
> +				/* 1MB for DTB Image */
> +				reg =3D <0x00100000 0x00100000>;
> +				label =3D "NAND DTB Image";
> +			};
> +
> +			partition@200000 {
> +				/* 10MB for Linux Kernel Image */
> +				reg =3D <0x00200000 0x00A00000>;
> +				label =3D "NAND Linux Kernel Image";
> +			};
> +
> +			partition@c00000 {
> +				/* 500MB for Root file System Image */
> +				reg =3D <0x00c00000 0x1F400000>;
> +				label =3D "NAND RFS Image";
> +			};
> +		};
> +
> +		board-control@3,0 {
> +			compatible =3D "fsl,b4860qds-fpga", =
"fsl,fpga-qixis";
> +			reg =3D <3 0 0x300>;
> +		};
> +	};
> +

dscr nodes are missing and should be included


> +	memory {
> +		device_type =3D "memory";
> +	};
> +
> +	soc: soc@ffe000000 {
> +		ranges =3D <0x00000000 0xf 0xfe000000 0x1000000>;
> +		reg =3D <0xf 0xfe000000 0 0x00001000>;
> +		spi@110000 {
> +			flash@0 {
> +				#address-cells =3D <1>;
> +				#size-cells =3D <1>;
> +				compatible =3D "sst,sst25wf040";
> +				reg =3D <0>;
> +				spi-max-frequency =3D <40000000>; /* =
input clock */
> +			};
> +		};
> +
> +		sdhc@114000 {
> +			status =3D "disabled";
> +		};
> +
> +		i2c@118000 {
> +			eeprom@50 {
> +				compatible =3D "at24,24c64";
> +				reg =3D <0x50>;
> +			};
> +			eeprom@51 {
> +				compatible =3D "at24,24c256";
> +				reg =3D <0x51>;
> +			};
> +			eeprom@53 {
> +				compatible =3D "at24,24c256";
> +				reg =3D <0x53>;
> +			};
> +			eeprom@57 {
> +				compatible =3D "at24,24c256";
> +				reg =3D <0x57>;
> +			};
> +			rtc@68 {
> +				compatible =3D "dallas,ds3232";
> +				reg =3D <0x68>;
> +				interrupts =3D <0x1 0x1 0 0>;

there is no IRQ for RTC on the board.

> +			};
> +		};
> +
> +		usb@210000 {
> +			dr_mode =3D "host";
> +			phy_type =3D "ulpi";
> +		};
> +
> +	};
> +
> +	pci0: pcie@ffe200000 {
> +		reg =3D <0xf 0xfe200000 0 0x10000>;
> +		ranges =3D <0x02000000 0 0xe0000000 0xc 0x00000000 0x0 =
0x20000000
> +			  0x01000000 0 0x00000000 0xf 0xf8000000 0x0 =
0x00010000>;
> +		pcie@0 {
> +			ranges =3D <0x02000000 0 0xe0000000
> +				  0x02000000 0 0xe0000000
> +				  0 0x20000000
> +
> +				  0x01000000 0 0x00000000
> +				  0x01000000 0 0x00000000
> +				  0 0x00010000>;
> +		};
> +	};
> +
> +	rio: rapidio@ffe0c0000 {
> +		reg =3D <0xf 0xfe0c0000 0 0x11000>;
> +
> +		port1 {
> +			ranges =3D <0 0 0xc 0x20000000 0 0x10000000>;
> +		};
> +		port2 {
> +			ranges =3D <0 0 0xc 0x30000000 0 0x10000000>;
> +		};
> +	};
> +
> +};
> +
> +/include/ "fsl/b4860si-post.dtsi"
> --=20
> 1.7.6.GIT
>=20
