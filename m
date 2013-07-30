Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E0D7C2C00C1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 04:57:17 +1000 (EST)
Received: from mail129-co9 (localhost [127.0.0.1])	by
 mail129-co9-R.bigfish.com (Postfix) with ESMTP id AAD5AA80103	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 18:57:13 +0000 (UTC)
Received: from CO9EHSMHS031.bigfish.com (unknown [10.236.132.242])	by
 mail129-co9.bigfish.com (Postfix) with ESMTP id 64977D40048	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 18:57:11 +0000 (UTC)
Date: Tue, 30 Jul 2013 13:57:08 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2] powerpc/85xx: Add P1023RDB board support
To: Chunhe Lan <Chunhe.Lan@freescale.com>
In-Reply-To: <1375184429-22145-1-git-send-email-Chunhe.Lan@freescale.com>
 (from Chunhe.Lan@freescale.com on Tue Jul 30 06:40:29 2013)
Message-ID: <1375210628.30721.78@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org, Chunhe Lan <Chunhe.Lan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/30/2013 06:40:29 AM, Chunhe Lan wrote:
> P1023RDB Specification:
> -----------------------
> Memory subsystem:
>    512MB DDR3 (Fixed DDR on board)
>    64MB NOR flash
>    128MB NAND flash
>=20
> Ethernet:
>    eTSEC1: Connected to Atheros AR8035 GETH PHY
>    eTSEC2: Connected to Atheros AR8035 GETH PHY
>=20
> PCIe:
>    Three mini-PCIe slots
>=20
> USB:
>    Two USB2.0 Type A ports
>=20
> I2C:
>    AT24C08 8K Board EEPROM (8 bit address)
>=20
> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
> Cc: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/boot/dts/p1023rdb.dts           |  237 =20
> ++++++++++++++++++++++++++
>  arch/powerpc/configs/85xx/p1023_defconfig    |  183 =20
> ++++++++++++++++++++
>  arch/powerpc/configs/85xx/p1023rds_defconfig |  169 =20
> ------------------
>  arch/powerpc/platforms/85xx/Kconfig          |    4 +-
>  arch/powerpc/platforms/85xx/p1023_rds.c      |   24 +++-
>  5 files changed, 445 insertions(+), 172 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/p1023rdb.dts
>  create mode 100644 arch/powerpc/configs/85xx/p1023_defconfig
>  delete mode 100644 arch/powerpc/configs/85xx/p1023rds_defconfig

Please indicate changes from the previous version under the ---

>=20
> diff --git a/arch/powerpc/boot/dts/p1023rdb.dts =20
> b/arch/powerpc/boot/dts/p1023rdb.dts
> new file mode 100644
> index 0000000..107c676
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/p1023rdb.dts
> @@ -0,0 +1,237 @@
> +/*
> + * P1023 RDB Device Tree Source
> + *
> + *    Copyright 2013 Freescale Semiconductor Inc.
> + *
> + * Author: Chunhe Lan <Chunhe.Lan@freescale.com>
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following =20
> conditions are met:
> + *     * Redistributions of source code must retain the above =20
> copyright
> + *       notice, this list of conditions and the following =20
> disclaimer.
> + *     * Redistributions in binary form must reproduce the above =20
> copyright
> + *       notice, this list of conditions and the following =20
> disclaimer in the
> + *       documentation and/or other materials provided with the =20
> distribution.
> + *     * Neither the name of Freescale Semiconductor nor the
> + *       names of its contributors may be used to endorse or promote =20
> products
> + *       derived from this software without specific prior written =20
> permission.
> + *
> + *
> + * ALTERNATIVELY, this software may be distributed under the terms =20
> of the
> + * GNU General Public License ("GPL") as published by the Free =20
> Software
> + * Foundation, either version 2 of that License or (at your option) =20
> any
> + * later version.
> + *
> + * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' =20
> AND ANY
> + * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE =20
> IMPLIED
> + * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR =20
> PURPOSE ARE
> + * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE =20
> FOR ANY
> + * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR =20
> CONSEQUENTIAL DAMAGES
> + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS =20
> OR SERVICES;
> + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER =20
> CAUSED AND
> + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT =20
> LIABILITY, OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =20
> USE OF THIS
> + * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + */
> +
> +/include/ "fsl/p1023si-pre.dtsi"
> +
> +/ {
> +	model =3D "fsl,P1023";
> +	compatible =3D "fsl,P1023RDB";
> +	#address-cells =3D <2>;
> +	#size-cells =3D <2>;
> +	interrupt-parent =3D <&mpic>;
> +
> +	memory {
> +		device_type =3D "memory";
> +	};
> +
> +	soc: soc@ff600000 {
> +		ranges =3D <0x0 0x0 0xff600000 0x200000>;
> +
> +		i2c@3000 {
> +			eeprom@53 {
> +				compatible =3D "at24,24c04";
> +				reg =3D <0x53>;
> +			};
> +
> +			rtc@6f {
> +				compatible =3D "microchip,mcp7941x";
> +				reg =3D <0x6f>;
> +			};
> +		};
> +
> +		usb@22000 {
> +			dr_mode =3D "host";
> +			phy_type =3D "ulpi";
> +		};
> +	};
> +
> +	lbc: localbus@ff605000 {
> +		reg =3D <0 0xff605000 0 0x1000>;
> +
> +		/* NOR, NAND Flashes */
> +		ranges =3D <0x0 0x0 0x0 0xec000000 0x04000000
> +			  0x1 0x0 0x0 0xffa00000 0x08000000>;

Is there no FPGA attached to eLBC?

> +		nor@0,0 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +			compatible =3D "cfi-flash";
> +			reg =3D <0x0 0x0 0x04000000>;
> +			bank-width =3D <2>;
> +			device-width =3D <1>;
> +
> +			partition@0 {
> +				/* 48MB for JFFS2 based Root file =20
> System */
> +				reg =3D <0x00000000 0x03000000>;
> +				label =3D "NOR JFFS2 Root File System";
> +			};

Don't specify JFFS2.

> +			partition@1000000 {
> +				/* 32MB for Compressed Root file System =20
> Image */
> +				reg =3D <0x01000000 0x02000000>;
> +				label =3D "NAND Compressed RFS Image";
> +			};
> +
> +			partition@3000000 {
> +				/* 64MB for JFFS2 based Root file =20
> System */
> +				reg =3D <0x03000000 0x04000000>;
> +				label =3D "NAND JFFS2 Root File System";
> +			};
> +
> +			partition@7000000 {
> +				/* 16MB for User Writable Area */
> +				reg =3D <0x07000000 0x01000000>;
> +				label =3D "NAND Writable User area";
> +			};

Don't specify JFFS2.  Is there a good reason to have three separate =20
partitions here?

> diff --git a/arch/powerpc/configs/85xx/p1023_defconfig =20
> b/arch/powerpc/configs/85xx/p1023_defconfig
> new file mode 100644
> index 0000000..ac29fb8
> --- /dev/null
> +++ b/arch/powerpc/configs/85xx/p1023_defconfig
> @@ -0,0 +1,183 @@
> +CONFIG_PPC_85xx=3Dy
> +CONFIG_SMP=3Dy
> +CONFIG_NR_CPUS=3D2
> +CONFIG_EXPERIMENTAL=3Dy

CONFIG_EXPERIMENTAL doesn't exist anymore.  Please only use "make =20
savedefconfig" output, not the direct results of hand-editing an old =20
config file.

Also please pass -M -C to git format-patch.

> diff --git a/arch/powerpc/platforms/85xx/Kconfig =20
> b/arch/powerpc/platforms/85xx/Kconfig
> index efdd37c..d6424e9 100644
> --- a/arch/powerpc/platforms/85xx/Kconfig
> +++ b/arch/powerpc/platforms/85xx/Kconfig
> @@ -112,10 +112,10 @@ config P1022_RDK
>  	  reference board.
>=20
>  config P1023_RDS
> -	bool "Freescale P1023 RDS"
> +	bool "Freescale P1023 RDS (P1023 RDB)"

bool "Freescale P1024 RDS/RDB"

>  	select DEFAULT_UIMAGE
>  	help
> -	  This option enables support for the P1023 RDS board
> +	  This option enables support for the P1023 RDS (P1023 RDB) =20
> board

"for the P1023 RDS and RDB boards"

-Scott=
