Return-Path: <B42677@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0249.outbound.messaging.microsoft.com [213.199.154.249])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0C6332C0085
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 13:16:34 +1000 (EST)
From: Zhang Haijun-B42677 <B42677@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH 2/2 V3] powerpc/85xx: add the P1020RDB-PD DTS support
Date: Wed, 10 Jul 2013 03:18:35 +0000
Message-ID: <99E897753B6F7048BD8CCDB4661D02E139BDF4@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1373358943-30433-1-git-send-email-Haijun.Zhang@freescale.com>
 (from Haijun.Zhang@freescale.com on Tue Jul  9 03:35:43 2013)
 <1373386496.8183.190@snotra>
In-Reply-To: <1373386496.8183.190@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Fleming Andy-AFLEMING <afleming@freescale.com>,
 Huang Changming-R66093 <r66093@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Xie Xiaobo-R63061 <r63061@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, scott

Patch V4 had send, Pls review.

Thanks.

Regards=20
Haijun.

> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Wednesday, July 10, 2013 12:15 AM
> To: Zhang Haijun-B42677
> Cc: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org; Fleming
> Andy-AFLEMING; Zhang Haijun-B42677; Huang Changming-R66093; Xie Xiaobo-
> R63061
> Subject: Re: [PATCH 2/2 V3] powerpc/85xx: add the P1020RDB-PD DTS support
>=20
> On 07/09/2013 03:35:43 AM, Haijun Zhang wrote:
> > Overview of P1020RDB-PD device:
> > - DDR3 2GB
> > - NOR flash 64MB
> > - NAND flash 128MB
> > - SPI flash 16MB
> > - I2C EEPROM 256Kb
> > - eTSEC1 (RGMII PHY) connected to VSC7385 L2 switch
> > - eTSEC2 (SGMII PHY)
> > - eTSEC3 (RGMII PHY)
> > - SDHC
> > - 2 USB ports
> > - 4 TDM ports
> > - PCIe
> >
> > Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
> > Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > Signed-off-by: Xie Xiaobo-R63061 <X.Xie@freescale.com>
> > CC: Scott Wood <scottwood@freescale.com>
> > ---
> > changes for v3:
> > 	- Remove some blank and changed the usb node
> > 	- Renamed the dts file
> > 	- change the cpld name of pd board
> >
> >  arch/powerpc/boot/dts/p1020rdb-pd.dts  |  90 ++++++++++++
> > arch/powerpc/boot/dts/p1020rdb-pd.dtsi | 257
> > +++++++++++++++++++++++++++++++++
> >  2 files changed, 347 insertions(+)
> >  create mode 100644 arch/powerpc/boot/dts/p1020rdb-pd.dts
> >  create mode 100644 arch/powerpc/boot/dts/p1020rdb-pd.dtsi
>=20
> Again, why do you need a separate .dtsi?  If this isn't for a 32/36-bit
> split, what is the criteria for what goes in the .dts versus what goes in
> the .dtsi?
>=20
> > +		partition@600000 {
> > +			/* 4MB for Compressed Root file System Image */
> > +			reg =3D <0x00600000 0x00400000>;
> > +			label =3D "NAND Compressed RFS Image";
> > +		};
> > +
> > +		partition@a00000 {
> > +			/* 22MB for JFFS2 based Root file System */
> > +			reg =3D <0x00a00000 0x01600000>;
> > +			label =3D "NAND JFFS2 Root File System";
> > +		};
>=20
> Don't refer to JFFS2.  It's bad enough that we specify partition layout
> here -- no need to specify the filesystem type, especially when it's a fs
> type that is no longer recommended.
>=20
> > +		partition@2000000 {
> > +			/* 96MB for RAMDISK based Root file System */
> > +			reg =3D <0x02000000 0x06000000>;
> > +			label =3D "NAND Writable User area";
> > +		};
>=20
> Wouldn't it be better to combine these last three partitions?  Why do you
> need three root filesystems?
>=20
> > +	cpld@2,0 {
> > +		compatible =3D "fsl,p1020rdb-pd-cpld";
> > +		reg =3D <0x2 0x0 0x20000>;
> > +		read-only;
> > +	};
>=20
> Remove read-only.
>=20
> > +	spi@7000 {
> > +		flash@0 {
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <1>;
> > +			compatible =3D "spansion,s25sl12801";
> > +			reg =3D <0>;
> > +			spi-max-frequency =3D <40000000>; /* input clock
> > */
> > +
> > +			partition@u-boot {
> > +				/* 512KB for u-boot Bootloader Image */
> > +				reg =3D <0x0 0x00080000>;
> > +				label =3D "u-boot";
> > +				read-only;
> > +			};
> > +
> > +			partition@dtb {
> > +				/* 512KB for DTB Image*/
> > +				reg =3D <0x00080000 0x00080000>;
> > +				label =3D "dtb";
> > +			};
> > +
> > +			partition@kernel {
> > +				/* 4MB for Linux Kernel Image */
> > +				reg =3D <0x00100000 0x00400000>;
> > +				label =3D "kernel";
> > +			};
>=20
> These unit addresses are not appropriate.  They should match reg, not
> label.
>=20
> > +			partition@fs {
> > +				/* 4MB for Compressed RFS Image */
> > +				reg =3D <0x00500000 0x00400000>;
> > +				label =3D "file system";
> > +			};
> > +
> > +			partition@jffs-fs {
> > +				/* 7MB for JFFS2 based RFS */
> > +				reg =3D <0x00900000 0x00700000>;
> > +				label =3D "file system jffs2";
> > +			};
>=20
> As with NAND flash, please combine these and don't reference JFFS2.
>=20
> > +		};
> > +
> > +		slic@0 {
> > +			compatible =3D "zarlink,le88266";
> > +			reg =3D <1>;
> > +			spi-max-frequency =3D <8000000>;
> > +		};
> > +
> > +		slic@1 {
> > +			compatible =3D "zarlink,le88266";
> > +			reg =3D <2>;
> > +			spi-max-frequency =3D <8000000>;
> > +		};
> > +	};
> > +
> > +	mdio@24000 {
> > +		phy0: ethernet-phy@0 {
> > +			interrupts =3D <3 1 0 0>;
> > +			reg =3D <0x0>;
> > +		};
> > +		phy1: ethernet-phy@1 {
> > +			interrupts =3D <2 1 0 0>;
> > +			reg =3D <0x1>;
> > +		};
> > +	};
>=20
> Again, leave a blank line between nodes.  If I comment about a style
> issue in one place, you should also fix the same issue in other places
> where it occurs.
>=20
> > +	/*
> > +	 * USB2 is shared with localbus, so it must be disabled
> > +	 * by default. We can't put 'status =3D "disabled";' here
> > +	 * since U-Boot doesn't clear the status property when
> > +	 * it enables USB2. OTOH, U-Boot does create a new node
> > +	 * when there isn't any. So, just comment it out.
> > +	 * usb@23000 {
> > +	 * 	status =3D "disabled";
> > +	 * 	phy_type =3D "ulpi";
> > +	 * };
> > +	 */
>=20
> No.  Fix U-Boot to do whatever updating it needs to do based on runtime
> configuration.  Do not add commented out nodes to the tree.
>=20
> -Scott
