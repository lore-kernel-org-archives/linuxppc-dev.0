Return-Path: <galak@kernel.crashing.org>
Subject: Re: [PATCH][v2] powerpc/85xx:Add BSC9131 RDB Support
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1331973588-29896-1-git-send-email-prabhakar@freescale.com>
Date: Wed, 21 Mar 2012 12:20:30 -0500
Message-Id: <6E492C67-B422-46B2-9A8E-C1E9B6C534E7@kernel.crashing.org>
References: <1331973588-29896-1-git-send-email-prabhakar@freescale.com>
To: Prabhakar Kushwaha <prabhakar@freescale.com>
Cc: Priyanka Jain <Priyanka.Jain@freescale.com>,
 devicetree-discuss@lists.ozlabs.org,
 Ramneek Mehresh <ramneek.mehresh@freescale.com>,
 Rajan Srivastava <rajan.srivastava@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, Akhil Goyal <Akhil.Goyal@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 17, 2012, at 3:39 AM, Prabhakar Kushwaha wrote:

> BSC9131RDB is a Freescale reference design board for BSC9131 SoC.The =
BSC9131 is
> integrated SoC that targets Femto base station market. It combines =
Power
> Architecture e500v2 and DSP StarCore SC3850 core technologies with =
MAPLE-B2F
> baseband acceleration processing elements.
>=20
> The BSC9131 SoC includes the following function and features:
>    . Power Architecture subsystem including a e500 processor with =
256-Kbyte shared
>      L2 cache
>    . StarCore SC3850 DSP subsystem with a 512-Kbyte private L2 cache
>    . The Multi Accelerator Platform Engine for Femto BaseStation =
Baseband
>      Processing (MAPLE-B2F)
>    . A multi-standard baseband algorithm accelerator for Channel =
Decoding/Encoding,
>      Fourier Transforms, UMTS chip rate processing, LTE UP/DL Channel =
processing,
>      and CRC algorithms
>    . Consists of accelerators for Convolution, Filtering, Turbo =
Encoding,
>      Turbo Decoding, Viterbi decoding, Chiprate processing, and Matrix =
Inversion
>      operations
>    . DDR3/3L memory interface with 32-bit data width without ECC and =
16-bit with
>      ECC, up to 400-MHz clock/800 MHz data rate
>    . Dedicated security engine featuring trusted boot
>    . DMA controller
>    . OCNDMA with four bidirectional channels
>    . Interfaces
>    . Two triple-speed Gigabit Ethernet controllers featuring network =
acceleration
>      including IEEE 1588. v2 hardware support and virtualization =
(eTSEC)
>    . eTSEC 1 supports RGMII/RMII
>    . eTSEC 2 supports RGMII
>    . High-speed USB 2.0 host and device controller with ULPI interface
>    . Enhanced secure digital (SD/MMC) host controller (eSDHC)
>    . Antenna interface controller (AIC), supporting three industry =
standard
>      JESD207/three custom ADI RF interfaces (two dual port and one =
single port)
>      and three MAXIM's MaxPHY serial interfaces
>    . ADI lanes support both full duplex FDD support and half duplex =
TDD support
>    . Universal Subscriber Identity Module (USIM) interface that =
facilitates
>      communication to SIM cards or Eurochip pre-paid phone cards
>    . TDM with one TDM port
>    . Two DUART, four eSPI, and two I2C controllers
>    . Integrated Flash memory controller (IFC)
>    . TDM with 256 channels
>    . GPIO
>    . Sixteen 32-bit timers
>=20
> The DSP portion of the SoC consists of DSP core (SC3850) and various
> accelerators pertaining to DSP operations.
>=20
> BSC9131RDB Overview
> ----------------------
>     BSC9131 SoC
>     1Gbyte DDR3 (on board DDR)
>     128Mbyte 2K page size NAND Flash
>     256 Kbit M24256 I2C EEPROM
>     128 Mbit SPI Flash memory
>     USB-ULPI
>     eTSEC1: Connected to RGMII PHY
>     eTSEC2: Connected to RGMII PHY
>     DUART interface: supports one UARTs up to 115200 bps for console =
display
>=20
> Linux runs on e500v2 core and access some DSP peripherals like AIC
>=20
> Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
> Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
> Signed-off-by: Akhil Goyal <Akhil.Goyal@freescale.com>
> Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
> Signed-off-by: Rajan Srivastava <rajan.srivastava@freescale.com>
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> ---
> Note:   Name of PSC9131 has been changed to BSC9131 because of new =
nomenclature
> 	Please reject earlier patch"powerpc/85xx:Add PSC9131 RDB =
Support"
> 	  http://patchwork.ozlabs.org/patch/146349/
>=20
> Beased on =
http://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git
> 	    branch master
>=20
> Changes for v2:=20
> 	- Change board file name as bsc913x_rdb.c
> 	- Removed all I2C's board device. A separate patch will be send.
> 	- Combined SPI's 2 RFS partition into single RFS parition
> 	- Added SEC/crypto node in dts
>=20
> arch/powerpc/boot/dts/bsc9131rdb.dts          |   34 +++++
> arch/powerpc/boot/dts/bsc9131rdb.dtsi         |  142 =
++++++++++++++++++
> arch/powerpc/boot/dts/fsl/bsc9131si-post.dtsi |  193 =
+++++++++++++++++++++++++
> arch/powerpc/boot/dts/fsl/bsc9131si-pre.dtsi  |   59 ++++++++
> arch/powerpc/platforms/85xx/Kconfig           |    9 ++
> arch/powerpc/platforms/85xx/Makefile          |    1 +
> arch/powerpc/platforms/85xx/bsc913x_rdb.c     |   95 ++++++++++++
> 7 files changed, 533 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/bsc9131rdb.dts
> create mode 100644 arch/powerpc/boot/dts/bsc9131rdb.dtsi
> create mode 100644 arch/powerpc/boot/dts/fsl/bsc9131si-post.dtsi
> create mode 100644 arch/powerpc/boot/dts/fsl/bsc9131si-pre.dtsi
> create mode 100644 arch/powerpc/platforms/85xx/bsc913x_rdb.c

[ Fix commit message so it wraps at 76 char columns=20


> diff --git a/arch/powerpc/boot/dts/bsc9131rdb.dtsi =
b/arch/powerpc/boot/dts/bsc9131rdb.dtsi
> new file mode 100644
> index 0000000..8906562
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/bsc9131rdb.dtsi
> @@ -0,0 +1,142 @@
> +/*
> + * BSC9131 RDB Device Tree Source stub (no addresses or top-level =
ranges)
> + *
> + * Copyright 2011-2012 Freescale Semiconductor Inc.
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
> +&board_ifc {
> +
> +	nand@0,0 {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		compatible =3D "fsl,ifc-nand";
> +		reg =3D <0x0 0x0 0x4000>;
> +
> +		partition@0 {
> +			/* This location must not be altered  */
> +			/* 3MB for u-boot Bootloader Image */
> +			reg =3D <0x0 0x00300000>;
> +			label =3D "NAND U-Boot Image";
> +			read-only;
> +		};
> +
> +		partition@300000 {
> +			/* 1MB for DTB Image */
> +			reg =3D <0x00300000 0x00100000>;
> +			label =3D "NAND DTB Image";
> +		};
> +
> +		partition@400000 {
> +			/* 8MB for Linux Kernel Image */
> +			reg =3D <0x00400000 0x00800000>;
> +			label =3D "NAND Linux Kernel Image";
> +		};
> +
> +		partition@c00000 {
> +			/* Rest space for Root file System Image */
> +			reg =3D <0x00c00000 0x07400000>;
> +			label =3D " NAND RFS Image";

extra white space on label string

> +		};
> +	};
> +};
> +
> +&board_soc {
> +	/* BSC9131RDB does not have any device on i2c@3100 */
> +	i2c@3100 {
> +		status =3D "disabled";
> +	};
> +
> +	spi@7000 {
> +		flash@0 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +			compatible =3D "spansion,s25sl12801";
> +			reg =3D <0>;
> +			spi-max-frequency =3D <50000000>;
> +
> +			/* 512KB for u-boot Bootloader Image */
> +			partition@0 {
> +				reg =3D <0x0 0x00080000>;
> +				label =3D "SPI Flash U-Boot Image";
> +				read-only;
> +			};
> +
> +			/* 512KB for DTB Image */
> +			partition@80000 {
> +				reg =3D <0x00080000 0x00080000>;
> +				label =3D "SPI Flash DTB Image";
> +			};
> +
> +			/* 4MB for Linux Kernel Image */
> +			partition@100000 {
> +				reg =3D <0x00100000 0x00400000>;
> +				label =3D "SPI Flash Kernel Image";
> +			};
> +
> +			/*11MB for RFS Image */
> +			partition@500000 {
> +				reg =3D <0x00500000 0x00B00000>;
> +				label =3D "SPI Flash RFS Image";
> +			};
> +
> +		};
> +	};
> +
> +	usb@22000 {
> +		phy_type =3D "ulpi";
> +	};
> +
> +	mdio@24000 {
> +		phy0: ethernet-phy@0 {
> +			interrupts =3D <3 1 0 0>;
> +			reg =3D <0x0>;
> +		};
> +
> +		phy1: ethernet-phy@1 {
> +			interrupts =3D <2 1 0 0>;
> +			reg =3D <0x3>;
> +		};
> +	};
> +
> +	sdhci@2e000 {
> +		status =3D "disabled";
> +	};
> +
> +	enet0: ethernet@b0000 {
> +		phy-handle =3D <&phy0>;
> +		phy-connection-type =3D "rgmii-id";
> +	};
> +
> +	enet1: ethernet@b1000 {
> +		phy-handle =3D <&phy1>;
> +		phy-connection-type =3D "rgmii-id";
> +	};
> +};

[snip]

> diff --git a/arch/powerpc/platforms/85xx/bsc913x_rdb.c =
b/arch/powerpc/platforms/85xx/bsc913x_rdb.c
> new file mode 100644
> index 0000000..611c289
> --- /dev/null
> +++ b/arch/powerpc/platforms/85xx/bsc913x_rdb.c
> @@ -0,0 +1,95 @@
> +/*
> + * BSC913xRDB Board Setup
> + *
> + * Author: Priyanka Jain <Priyanka.Jain@freescale.com>
> + *
> + * Copyright 2011-2012 Freescale Semiconductor Inc.
> + *
> + * This program is free software; you can redistribute  it and/or =
modify it
> + * under  the terms of  the GNU General  Public License as published =
by the
> + * Free Software Foundation;  either version 2 of the  License, or =
(at your
> + * option) any later version.
> + */
> +
> +#include <linux/of_platform.h>
> +#include <linux/pci.h>
> +#include <asm/mpic.h>
> +#include <sysdev/fsl_soc.h>
> +#include <asm/udbg.h>
> +
> +void __init bsc913x_rdb_pic_init(void)
> +{
> +	struct mpic *mpic;
> +	struct resource r;
> +	struct device_node *np;
> +
> +	np =3D of_find_node_by_type(NULL, "open-pic");
> +	if (!np) {
> +		pr_err("bsc913x: Could not find open-pic node\n");
> +		return;
> +	}
> +
> +	if (of_address_to_resource(np, 0, &r)) {
> +		pr_err("bsc913x: Failed to map mpic register space\n");
> +		of_node_put(np);
> +		return;
> +	}
> +
> +	mpic =3D mpic_alloc(np, r.start, MPIC_WANTS_RESET |
> +	  MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS | =
MPIC_SINGLE_DEST_CPU,
> +	  0, 256, " OpenPIC  ");
> +
> +	of_node_put(np);
> +
> +	if (!mpic)
> +		pr_err("bsc913x: Failed to allocate MPIC structure\n");
> +	else
> +		mpic_init(mpic);
> +}
> +

This code is still out of date w/other board ports.  Have you tried =
building this against upstream??

> +/*
> + * Setup the architecture
> + */
> +static void __init bsc913x_rdb_setup_arch(void)
> +{
> +	if (ppc_md.progress)
> +		ppc_md.progress("bsc913x_rdb_setup_arch()", 0);
> +
> +	pr_info("bsc913x board from Freescale Semiconductor\n");
> +}
> +
> +static struct of_device_id __initdata bsc913x_rdb_ids[] =3D {
> +	{ .type =3D "soc", },
> +	{ .compatible =3D "soc", },
> +	{ .compatible =3D "simple-bus", },
> +	{ .compatible =3D "gianfar", },
> +	{},
> +};
> +
> +static int __init bsc913x_rdb_publish_devices(void)
> +{
> +	return of_platform_bus_probe(NULL, bsc913x_rdb_ids, NULL);
> +}
> +machine_device_initcall(bsc9131_rdb, bsc913x_rdb_publish_devices);
> +
> +/*
> + * Called very early, device-tree isn't unflattened
> + */
> +
> +static int __init bsc9131_rdb_probe(void)
> +{
> +	unsigned long root =3D of_get_flat_dt_root();
> +
> +	return of_flat_dt_is_compatible(root, "fsl,bsc9131rdb");
> +}
> +
> +define_machine(bsc9131_rdb) {
> +	.name			=3D "BSC9131 RDB",
> +	.probe			=3D bsc9131_rdb_probe,
> +	.setup_arch		=3D bsc913x_rdb_setup_arch,
> +	.init_IRQ		=3D bsc913x_rdb_pic_init,
> +	.get_irq		=3D mpic_get_irq,
> +	.restart		=3D fsl_rstcr_restart,
> +	.calibrate_decr		=3D generic_calibrate_decr,
> +	.progress		=3D udbg_progress,
> +};
> --=20
> 1.7.5.4
>=20
>=20
>=20
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
