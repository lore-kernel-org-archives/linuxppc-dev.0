Return-Path: <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/85xx:Add BSC9131 RDB Support
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1331789851-19213-1-git-send-email-prabhakar@freescale.com>
Date: Fri, 16 Mar 2012 15:12:51 -0500
Message-Id: <F0619813-5CAC-4D15-9D9E-827A609DD573@kernel.crashing.org>
References: <1331789851-19213-1-git-send-email-prabhakar@freescale.com>
To: Prabhakar Kushwaha <prabhakar@freescale.com>
Cc: Poonam Aggrwal <poonam.aggrwal@freescale.com>,
 Priyanka Jain <Priyanka.Jain@freescale.com>,
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

>=20
>=20
> diff --git a/arch/powerpc/boot/dts/bsc9131rdb.dtsi =
b/arch/powerpc/boot/dts/bsc9131rdb.dtsi
> new file mode 100644
> index 0000000..d274c014
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/bsc9131rdb.dtsi
> @@ -0,0 +1,179 @@
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
> +		};
> +	};
> +};
> +
> +&board_soc {
> +	i2c@3000 {
> +		gpio3: gpio@21 {
> +			compatible =3D "nxp,pca9555";

Is there any binding spec for nxp,

> +			reg =3D <0x21>;
> +			#gpio-cells =3D <2>;
> +			gpio-controller;
> +			polarity =3D <0x00>;
> +		};
> +		gpio4: gpio@23 {
> +			compatible =3D "nxp,pca9555";
> +			reg =3D <0x23>;
> +			#gpio-cells =3D <2>;
> +			gpio-controller;
> +			polarity =3D <0x00>;
> +		};
> +		gpio5: gpio@27 {
> +			compatible =3D "nxp,pca9555";
> +			reg =3D <0x27>;
> +			#gpio-cells =3D <2>;
> +			gpio-controller;
> +			polarity =3D <0x00>;
> +		};
> +		hwmon@4c {
> +			compatible =3D "adi,adt7461";
> +			reg =3D <0x4c>;
> +		};
> +		eeprom@52 {
> +			compatible =3D "st-micro,24c02";

should this have a compatible with atmel,24c02?

> +			reg =3D <0x52>;
> +		};
> +	};
> +
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
> +			/* 4MB for Compressed RFS Image */
> +			partition@500000 {
> +				reg =3D <0x00500000 0x00400000>;
> +				label =3D "SPI Flash Compressed RFS =
Image";
> +			};
> +
> +			/* 7MB for JFFS2 based RFS */
> +			partition@900000 {
> +				reg =3D <0x00900000 0x00700000>;
> +				label =3D "SPI Flash JFFS2 RFS Image";
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


> diff --git a/arch/powerpc/platforms/85xx/bsc913x_board.c =
b/arch/powerpc/platforms/85xx/bsc913x_board.c

should be bsc913x_rdb.c

> new file mode 100644
> index 0000000..934c3b5
> --- /dev/null
> +++ b/arch/powerpc/platforms/85xx/bsc913x_board.c
> @@ -0,0 +1,96 @@
> +/*
> + * BSC9131RDB Board Setup
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
> +void __init bsc913x_board_pic_init(void)
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


Please update to match current board code

> +}
> +
> +/*
> + * Setup the architecture
> + */
> +static void __init bsc913x_board_setup_arch(void)
> +{
> +	if (ppc_md.progress)
> +		ppc_md.progress("bsc913x_board_setup_arch()", 0);
> +
> +	pr_info("bsc913x board from Freescale Semiconductor\n");
> +}
> +
> +static struct of_device_id __initdata bsc913x_board_ids[] =3D {
> +	{ .type =3D "soc", },
> +	{ .type =3D "dsp", },

remove dsp, doesn't show up anywhere else

> +	{ .compatible =3D "soc", },
> +	{ .compatible =3D "simple-bus", },
> +	{ .compatible =3D "gianfar", },
> +	{},
> +};
> +
> +static int __init bsc913x_board_publish_devices(void)
> +{
> +	return of_platform_bus_probe(NULL, bsc913x_board_ids, NULL);
> +}
> +machine_device_initcall(bsc9131_rdb, bsc913x_board_publish_devices);
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
> +	.setup_arch		=3D bsc913x_board_setup_arch,
> +	.init_IRQ		=3D bsc913x_board_pic_init,
> +	.get_irq		=3D mpic_get_irq,
> +	.restart		=3D fsl_rstcr_restart,
> +	.calibrate_decr		=3D generic_calibrate_decr,
> +	.progress		=3D udbg_progress,
> +};
> --=20
> 1.7.5.4
>=20
>=20
