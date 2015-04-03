Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 241DB1A0741
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Apr 2015 12:25:42 +1100 (AEDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0112.outbound.protection.outlook.com [157.56.111.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4ACCA14016A
 for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2015 12:25:40 +1100 (AEDT)
Message-ID: <1428024328.22867.328.camel@freescale.com>
Subject: Re: [PATCH 1/4] powerpc/85xx: miscellaneous changes on
 mpc85xx_defconfig
From: Scott Wood <scottwood@freescale.com>
To: Lijun Pan <Lijun.Pan@freescale.com>
Date: Thu, 2 Apr 2015 20:25:28 -0500
In-Reply-To: <1428010674-25361-1-git-send-email-Lijun.Pan@freescale.com>
References: <1428010674-25361-1-git-send-email-Lijun.Pan@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-04-02 at 16:37 -0500, Lijun Pan wrote:
> Merge Freescale's Internal mpc85xx_defconfig with upstream's.
> Run savedefconfig to get the minimal change.

What makes the internal config preferred without any explanation of why
we want or don't want specific config items?  Especially where things
are being turned off, rather than on.

Are any of these changes due to running savedefconfig on the upstream
config (if so, make that a separate patch)?

> @@ -50,8 +50,6 @@ CONFIG_BINFMT_MISC=m
>  CONFIG_MATH_EMULATION=y
>  CONFIG_FORCE_MAX_ZONEORDER=12
>  CONFIG_PCI=y
> -CONFIG_PCIEPORTBUS=y
> -# CONFIG_PCIEASPM is not set

PCIEPORTBUS was enabled by commit 2727ed54716e60 ("powerpc/85xx: Add
support for Emerson/Artesyn MVME2500.").  Presumably that board needs
it.

>  CONFIG_PCI_MSI=y
>  CONFIG_RAPIDIO=y
>  CONFIG_NET=y
> @@ -88,21 +86,17 @@ CONFIG_FTL=y
>  CONFIG_MTD_CFI=y
>  CONFIG_MTD_CFI_INTELEXT=y
>  CONFIG_MTD_CFI_AMDSTD=y
> -CONFIG_MTD_PHYSMAP=y
>  CONFIG_MTD_PHYSMAP_OF=y
> -CONFIG_MTD_PLATRAM=y
> -CONFIG_MTD_M25P80=y
>  CONFIG_MTD_NAND=y
>  CONFIG_MTD_NAND_FSL_ELBC=y
>  CONFIG_MTD_NAND_FSL_IFC=y
> -CONFIG_MTD_SPI_NOR=y

Why?


>  CONFIG_EDAC=y
>  CONFIG_EDAC_MM_EDAC=y
> -CONFIG_EDAC_MPC85XX=y

Umm...  What other EDAC driver are you expecting to be used with this
config?

>  CONFIG_RTC_CLASS=y
> -CONFIG_RTC_DRV_DS1307=y
> -CONFIG_RTC_DRV_DS1374=y
> -CONFIG_RTC_DRV_DS3232=y

mpc8568/8569 have ds1374.  mpc8536/p1022 have ds3232.  Various tqm
boards have ds1337 which uses the ds1307 driver.

> @@ -218,9 +206,6 @@ CONFIG_ADFS_FS=m
>  CONFIG_AFFS_FS=m
>  CONFIG_HFS_FS=m
>  CONFIG_HFSPLUS_FS=m
> -CONFIG_BEFS_FS=m
> -CONFIG_BFS_FS=m
> -CONFIG_EFS_FS=m
>  CONFIG_JFFS2_FS=y
>  CONFIG_JFFS2_FS_DEBUG=1
>  CONFIG_UBIFS_FS=y

This is pretty random.  If we want to remove fringe filesystems, fine,
but why just these three?

-Scott
