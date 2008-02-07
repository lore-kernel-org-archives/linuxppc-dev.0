Return-Path: <kaloz@openwrt.org>
Received: from arrakis.dune.hu (arrakis.dune.hu [195.56.146.235])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3702BDDDEC
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2008 21:30:07 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by arrakis.dune.hu (Postfix) with ESMTP id 517707840DD
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2008 11:30:03 +0100 (CET)
Received: from arrakis.dune.hu ([127.0.0.1])
	by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6QHQ2Ts-nW6h for <linuxppc-dev@ozlabs.org>;
	Thu,  7 Feb 2008 11:29:57 +0100 (CET)
Received: from ecaz.afh.b-m.hu (firewall.ahiv.hu [195.228.168.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by arrakis.dune.hu (Postfix) with ESMTP id 277AE7840DE
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2008 11:29:56 +0100 (CET)
Date: Thu, 07 Feb 2008 11:29:55 +0100
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] MTD support for the AMCC Taishan
From: "Imre Kaloz" <kaloz@openwrt.org>
Content-Type: text/plain; format=flowed; delsp=yes; charset=us-ascii
MIME-Version: 1.0
References: <120203530465-git-send-email-kaloz@openwrt.org>
Message-ID: <op.t55gr5lb2s3iss@ecaz.afh.b-m.hu>
In-Reply-To: <120203530465-git-send-email-kaloz@openwrt.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

*bump*? :) If anything is wrong with it, please let me know.


Imre


On Sun, 03 Feb 2008 11:41:44 +0100, Imre Kaloz <kaloz@openwrt.org> wrote=
:

> Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
> ---
>  arch/powerpc/boot/dts/taishan.dts      |   33 +++++++++++-
>  arch/powerpc/configs/taishan_defconfig |   89  =

> ++++++++++++++++++++++++++++++--
>  2 files changed, 116 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/boot/dts/taishan.dts  =

> b/arch/powerpc/boot/dts/taishan.dts
> index 0706a4a..28c14dd 100644
> --- a/arch/powerpc/boot/dts/taishan.dts
> +++ b/arch/powerpc/boot/dts/taishan.dts
> @@ -174,7 +174,38 @@
>  				interrupts =3D <5 4>;
>  				interrupt-parent =3D <&UIC1>;
> -				/* TODO: Add other EBC devices */
> +				nor_flash@0,0 {
> +					compatible =3D "cfi-flash";
> +					bank-width =3D <4>;
> +					device-width =3D <2>;
> +					reg =3D <0 000000 4000000>;
> +					#address-cells =3D <1>;
> +					#size-cells =3D <1>;
> +					partition@0 {
> +						label =3D "kernel";
> +						reg =3D <0 180000>;
> +					};
> +					partition@180000 {
> +						label =3D "root";
> +						reg =3D <180000 200000>;
> +					};
> +					partition@380000 {
> +						label =3D "user";
> +						reg =3D <380000 3a80000>;
> +					};
> +					partition@3e00000 {
> +						label =3D "kozio";
> +						reg =3D <3e00000 140000>;
> +					};
> +					partition@3f40000 {
> +						label =3D "env";
> +						reg =3D <3f40000 80000>;
> +					};
> +					partition@3fc0000 {
> +						label =3D "u-boot";
> +						reg =3D <3fc0000 40000>;
> +					};
> +				};
>  			};
> diff --git a/arch/powerpc/configs/taishan_defconfig  =

> b/arch/powerpc/configs/taishan_defconfig
> index ade84b9..4d17a5d 100644
> --- a/arch/powerpc/configs/taishan_defconfig
> +++ b/arch/powerpc/configs/taishan_defconfig
> @@ -1,7 +1,7 @@
>  #
>  # Automatically generated make config: don't edit
> -# Linux kernel version: 2.6.24-rc6
> -# Mon Dec 24 11:23:39 2007
> +# Linux kernel version: 2.6.24
> +# Sun Feb  3 00:40:49 2008
>  #
>  # CONFIG_PPC64 is not set
> @@ -103,6 +103,7 @@ CONFIG_SLUB_DEBUG=3Dy
>  # CONFIG_SLAB is not set
>  CONFIG_SLUB=3Dy
>  # CONFIG_SLOB is not set
> +CONFIG_SLABINFO=3Dy
>  CONFIG_RT_MUTEXES=3Dy
>  # CONFIG_TINY_SHMEM is not set
>  CONFIG_BASE_SMALL=3D0
> @@ -146,7 +147,9 @@ CONFIG_DEFAULT_IOSCHED=3D"anticipatory"
>  CONFIG_TAISHAN=3Dy
>  # CONFIG_KATMAI is not set
>  # CONFIG_RAINIER is not set
> +# CONFIG_WARP is not set
>  CONFIG_440GX=3Dy
> +# CONFIG_IPIC is not set
>  # CONFIG_MPIC is not set
>  # CONFIG_MPIC_WEIRD is not set
>  # CONFIG_PPC_I8259 is not set
> @@ -330,7 +333,83 @@ CONFIG_FW_LOADER=3Dy
>  # CONFIG_SYS_HYPERVISOR is not set
>  CONFIG_CONNECTOR=3Dy
>  CONFIG_PROC_EVENTS=3Dy
> -# CONFIG_MTD is not set
> +CONFIG_MTD=3Dy
> +# CONFIG_MTD_DEBUG is not set
> +# CONFIG_MTD_CONCAT is not set
> +CONFIG_MTD_PARTITIONS=3Dy
> +# CONFIG_MTD_REDBOOT_PARTS is not set
> +CONFIG_MTD_CMDLINE_PARTS=3Dy
> +
> +#
> +# User Modules And Translation Layers
> +#
> +CONFIG_MTD_CHAR=3Dy
> +# CONFIG_MTD_BLKDEVS is not set
> +# CONFIG_MTD_BLOCK is not set
> +# CONFIG_MTD_BLOCK_RO is not set
> +# CONFIG_FTL is not set
> +# CONFIG_NFTL is not set
> +# CONFIG_INFTL is not set
> +# CONFIG_RFD_FTL is not set
> +# CONFIG_SSFDC is not set
> +# CONFIG_MTD_OOPS is not set
> +
> +#
> +# RAM/ROM/Flash chip drivers
> +#
> +CONFIG_MTD_CFI=3Dy
> +# CONFIG_MTD_JEDECPROBE is not set
> +CONFIG_MTD_GEN_PROBE=3Dy
> +# CONFIG_MTD_CFI_ADV_OPTIONS is not set
> +CONFIG_MTD_MAP_BANK_WIDTH_1=3Dy
> +CONFIG_MTD_MAP_BANK_WIDTH_2=3Dy
> +CONFIG_MTD_MAP_BANK_WIDTH_4=3Dy
> +# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
> +# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
> +# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
> +CONFIG_MTD_CFI_I1=3Dy
> +CONFIG_MTD_CFI_I2=3Dy
> +# CONFIG_MTD_CFI_I4 is not set
> +# CONFIG_MTD_CFI_I8 is not set
> +# CONFIG_MTD_CFI_INTELEXT is not set
> +CONFIG_MTD_CFI_AMDSTD=3Dy
> +# CONFIG_MTD_CFI_STAA is not set
> +CONFIG_MTD_CFI_UTIL=3Dy
> +# CONFIG_MTD_RAM is not set
> +# CONFIG_MTD_ROM is not set
> +# CONFIG_MTD_ABSENT is not set
> +
> +#
> +# Mapping drivers for chip access
> +#
> +# CONFIG_MTD_COMPLEX_MAPPINGS is not set
> +# CONFIG_MTD_PHYSMAP is not set
> +CONFIG_MTD_PHYSMAP_OF=3Dy
> +# CONFIG_MTD_INTEL_VR_NOR is not set
> +# CONFIG_MTD_PLATRAM is not set
> +
> +#
> +# Self-contained MTD device drivers
> +#
> +# CONFIG_MTD_PMC551 is not set
> +# CONFIG_MTD_SLRAM is not set
> +# CONFIG_MTD_PHRAM is not set
> +# CONFIG_MTD_MTDRAM is not set
> +# CONFIG_MTD_BLOCK2MTD is not set
> +
> +#
> +# Disk-On-Chip Device Drivers
> +#
> +# CONFIG_MTD_DOC2000 is not set
> +# CONFIG_MTD_DOC2001 is not set
> +# CONFIG_MTD_DOC2001PLUS is not set
> +# CONFIG_MTD_NAND is not set
> +# CONFIG_MTD_ONENAND is not set
> +
> +#
> +# UBI - Unsorted block images
> +#
> +# CONFIG_MTD_UBI is not set
>  CONFIG_OF_DEVICE=3Dy
>  # CONFIG_PARPORT is not set
>  CONFIG_BLK_DEV=3Dy
> @@ -385,7 +464,6 @@ CONFIG_NETDEVICES=3Dy
>  # CONFIG_EQUALIZER is not set
>  # CONFIG_TUN is not set
>  # CONFIG_VETH is not set
> -# CONFIG_IP1000 is not set
>  # CONFIG_ARCNET is not set
>  # CONFIG_PHYLIB is not set
>  CONFIG_NET_ETHERNET=3Dy
> @@ -414,6 +492,7 @@ CONFIG_NETDEV_1000=3Dy
>  # CONFIG_DL2K is not set
>  # CONFIG_E1000 is not set
>  # CONFIG_E1000E is not set
> +# CONFIG_IP1000 is not set
>  # CONFIG_NS83820 is not set
>  # CONFIG_HAMACHI is not set
>  # CONFIG_YELLOWFIN is not set
> @@ -641,6 +720,7 @@ CONFIG_TMPFS=3Dy
>  # CONFIG_BEFS_FS is not set
>  # CONFIG_BFS_FS is not set
>  # CONFIG_EFS_FS is not set
> +# CONFIG_JFFS2_FS is not set
>  CONFIG_CRAMFS=3Dy
>  # CONFIG_VXFS_FS is not set
>  # CONFIG_HPFS_FS is not set
> @@ -675,7 +755,6 @@ CONFIG_SUNRPC=3Dy
>  CONFIG_MSDOS_PARTITION=3Dy
>  # CONFIG_NLS is not set
>  # CONFIG_DLM is not set
> -# CONFIG_UCC_SLOW is not set
> #
>  # Library routines
