Return-Path: <r66093@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2D9A9B6EE7
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Feb 2012 17:25:52 +1100 (EST)
From: Huang Changming-R66093 <r66093@freescale.com>
To: Tabi Timur-B04825 <B04825@freescale.com>, "galak@kernel.crashing.org"
 <galak@kernel.crashing.org>, "benh@kernel.crashing.org"
 <benh@kernel.crashing.org>, Wood Scott-B07421 <B07421@freescale.com>, Li
 Yang-R58472 <r58472@freescale.com>, "linuxppc-dev@ozlabs.org"
 <linuxppc-dev@ozlabs.org>
Subject: RE: [PATCH] powerpc/85xx: allow CONFIG_PHYS_64BIT to be selectable
Date: Thu, 23 Feb 2012 06:25:45 +0000
Message-ID: <110EED8CC96DFC488B7E717A2027A27C02C5E8@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1329853995-7533-1-git-send-email-timur@freescale.com>
In-Reply-To: <1329853995-7533-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I have one similar patch to remove the "select PHYS_64BIT".
http://patchwork.ozlabs.org/patch/132351/


Thanks
Jerry Huang


> -----Original Message-----
> From: linuxppc-dev-bounces+r66093=3Dfreescale.com@lists.ozlabs.org
> [mailto:linuxppc-dev-bounces+r66093=3Dfreescale.com@lists.ozlabs.org] On
> Behalf Of Timur Tabi
> Sent: Wednesday, February 22, 2012 3:53 AM
> To: galak@kernel.crashing.org; benh@kernel.crashing.org; Wood Scott-
> B07421; Li Yang-R58472; linuxppc-dev@ozlabs.org
> Subject: [PATCH] powerpc/85xx: allow CONFIG_PHYS_64BIT to be selectable
>=20
> Remove the "select PHYS_64BIT" from the Kconfig entry for the P1022DS, so
> that large physical address support is a selectable option for non-
> CoreNet reference boards.
>=20
> The option is enabled in mpc85xx_[smp_]defconfig so that the default is
> unchanged.  However, now it can be deselected.
>=20
> The P1022DS had this option defined because the default device tree for
> this board uses 36-bit addresses.  This had the side-effect of forcing
> this option on for all boards that use mpc85xx_[smp_]defconfig.  Some
> users may want to disable this feature to create an optimized
> configuration for boards with <=3D 2GB of RAM.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>  arch/powerpc/configs/mpc85xx_defconfig     |    1 +
>  arch/powerpc/configs/mpc85xx_smp_defconfig |    1 +
>  arch/powerpc/platforms/85xx/Kconfig        |    1 -
>  3 files changed, 2 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/powerpc/configs/mpc85xx_defconfig
> b/arch/powerpc/configs/mpc85xx_defconfig
> index f37a2ab..5fb0c8a 100644
> --- a/arch/powerpc/configs/mpc85xx_defconfig
> +++ b/arch/powerpc/configs/mpc85xx_defconfig
> @@ -1,4 +1,5 @@
>  CONFIG_PPC_85xx=3Dy
> +CONFIG_PHYS_64BIT=3Dy
>  CONFIG_EXPERIMENTAL=3Dy
>  CONFIG_SYSVIPC=3Dy
>  CONFIG_POSIX_MQUEUE=3Dy
> diff --git a/arch/powerpc/configs/mpc85xx_smp_defconfig
> b/arch/powerpc/configs/mpc85xx_smp_defconfig
> index abdcd31..fb51bc9 100644
> --- a/arch/powerpc/configs/mpc85xx_smp_defconfig
> +++ b/arch/powerpc/configs/mpc85xx_smp_defconfig
> @@ -1,4 +1,5 @@
>  CONFIG_PPC_85xx=3Dy
> +CONFIG_PHYS_64BIT=3Dy
>  CONFIG_SMP=3Dy
>  CONFIG_NR_CPUS=3D8
>  CONFIG_EXPERIMENTAL=3Dy
> diff --git a/arch/powerpc/platforms/85xx/Kconfig
> b/arch/powerpc/platforms/85xx/Kconfig
> index d7946be..93d27e2 100644
> --- a/arch/powerpc/platforms/85xx/Kconfig
> +++ b/arch/powerpc/platforms/85xx/Kconfig
> @@ -80,7 +80,6 @@ config P1010_RDB
>  config P1022_DS
>  	bool "Freescale P1022 DS"
>  	select DEFAULT_UIMAGE
> -	select PHYS_64BIT	# The DTS has 36-bit addresses
>  	select SWIOTLB
>  	help
>  	  This option enables support for the Freescale P1022DS reference
> board.
> --
> 1.7.3.4
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
