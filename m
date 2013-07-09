Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 81E692C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 02:15:14 +1000 (EST)
Date: Tue, 9 Jul 2013 11:14:56 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2 V3] powerpc/85xx: add the P1020RDB-PD DTS support
To: Haijun Zhang <Haijun.Zhang@freescale.com>
In-Reply-To: <1373358943-30433-1-git-send-email-Haijun.Zhang@freescale.com>
 (from Haijun.Zhang@freescale.com on Tue Jul  9 03:35:43 2013)
Message-ID: <1373386496.8183.190@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>, AFLEMING@freescale.com,
 Haijun Zhang <Haijun.Zhang@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Xie Xiaobo-R63061 <X.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/09/2013 03:35:43 AM, Haijun Zhang wrote:
> Overview of P1020RDB-PD device:
> - DDR3 2GB
> - NOR flash 64MB
> - NAND flash 128MB
> - SPI flash 16MB
> - I2C EEPROM 256Kb
> - eTSEC1 (RGMII PHY) connected to VSC7385 L2 switch
> - eTSEC2 (SGMII PHY)
> - eTSEC3 (RGMII PHY)
> - SDHC
> - 2 USB ports
> - 4 TDM ports
> - PCIe
>=20
> Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> Signed-off-by: Xie Xiaobo-R63061 <X.Xie@freescale.com>
> CC: Scott Wood <scottwood@freescale.com>
> ---
> changes for v3:
> 	- Remove some blank and changed the usb node
> 	- Renamed the dts file
> 	- change the cpld name of pd board
>=20
>  arch/powerpc/boot/dts/p1020rdb-pd.dts  |  90 ++++++++++++
>  arch/powerpc/boot/dts/p1020rdb-pd.dtsi | 257 =20
> +++++++++++++++++++++++++++++++++
>  2 files changed, 347 insertions(+)
>  create mode 100644 arch/powerpc/boot/dts/p1020rdb-pd.dts
>  create mode 100644 arch/powerpc/boot/dts/p1020rdb-pd.dtsi

Again, why do you need a separate .dtsi?  If this isn't for a 32/36-bit =20
split, what is the criteria for what goes in the .dts versus what goes =20
in the .dtsi?

> +		partition@600000 {
> +			/* 4MB for Compressed Root file System Image */
> +			reg =3D <0x00600000 0x00400000>;
> +			label =3D "NAND Compressed RFS Image";
> +		};
> +
> +		partition@a00000 {
> +			/* 22MB for JFFS2 based Root file System */
> +			reg =3D <0x00a00000 0x01600000>;
> +			label =3D "NAND JFFS2 Root File System";
> +		};

Don't refer to JFFS2.  It's bad enough that we specify partition layout =20
here -- no need to specify the filesystem type, especially when it's a =20
fs type that is no longer recommended.

> +		partition@2000000 {
> +			/* 96MB for RAMDISK based Root file System */
> +			reg =3D <0x02000000 0x06000000>;
> +			label =3D "NAND Writable User area";
> +		};

Wouldn't it be better to combine these last three partitions?  Why do =20
you need three root filesystems?

> +	cpld@2,0 {
> +		compatible =3D "fsl,p1020rdb-pd-cpld";
> +		reg =3D <0x2 0x0 0x20000>;
> +		read-only;
> +	};

Remove read-only.

> +	spi@7000 {
> +		flash@0 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +			compatible =3D "spansion,s25sl12801";
> +			reg =3D <0>;
> +			spi-max-frequency =3D <40000000>; /* input clock =20
> */
> +
> +			partition@u-boot {
> +				/* 512KB for u-boot Bootloader Image */
> +				reg =3D <0x0 0x00080000>;
> +				label =3D "u-boot";
> +				read-only;
> +			};
> +
> +			partition@dtb {
> +				/* 512KB for DTB Image*/
> +				reg =3D <0x00080000 0x00080000>;
> +				label =3D "dtb";
> +			};
> +
> +			partition@kernel {
> +				/* 4MB for Linux Kernel Image */
> +				reg =3D <0x00100000 0x00400000>;
> +				label =3D "kernel";
> +			};

These unit addresses are not appropriate.  They should match reg, not =20
label.

> +			partition@fs {
> +				/* 4MB for Compressed RFS Image */
> +				reg =3D <0x00500000 0x00400000>;
> +				label =3D "file system";
> +			};
> +
> +			partition@jffs-fs {
> +				/* 7MB for JFFS2 based RFS */
> +				reg =3D <0x00900000 0x00700000>;
> +				label =3D "file system jffs2";
> +			};

As with NAND flash, please combine these and don't reference JFFS2.

> +		};
> +
> +		slic@0 {
> +			compatible =3D "zarlink,le88266";
> +			reg =3D <1>;
> +			spi-max-frequency =3D <8000000>;
> +		};
> +
> +		slic@1 {
> +			compatible =3D "zarlink,le88266";
> +			reg =3D <2>;
> +			spi-max-frequency =3D <8000000>;
> +		};
> +	};
> +
> +	mdio@24000 {
> +		phy0: ethernet-phy@0 {
> +			interrupts =3D <3 1 0 0>;
> +			reg =3D <0x0>;
> +		};
> +		phy1: ethernet-phy@1 {
> +			interrupts =3D <2 1 0 0>;
> +			reg =3D <0x1>;
> +		};
> +	};

Again, leave a blank line between nodes.  If I comment about a style =20
issue in one place, you should also fix the same issue in other places =20
where it occurs.

> +	/*
> +	 * USB2 is shared with localbus, so it must be disabled
> +	 * by default. We can't put 'status =3D "disabled";' here
> +	 * since U-Boot doesn't clear the status property when
> +	 * it enables USB2. OTOH, U-Boot does create a new node
> +	 * when there isn't any. So, just comment it out.
> +	 * usb@23000 {
> +	 * 	status =3D "disabled";
> +	 * 	phy_type =3D "ulpi";
> +	 * };
> +	 */

No.  Fix U-Boot to do whatever updating it needs to do based on runtime =20
configuration.  Do not add commented out nodes to the tree.

-Scott=
