Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9D8AE2C009E
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Jul 2013 08:58:43 +1000 (EST)
Received: from mail22-co9 (localhost [127.0.0.1])	by mail22-co9-R.bigfish.com
 (Postfix) with ESMTP id E20A0E0207	for <linuxppc-dev@ozlabs.org>;
 Mon, 22 Jul 2013 22:58:39 +0000 (UTC)
Received: from CO9EHSMHS023.bigfish.com (unknown [10.236.132.245])	by
 mail22-co9.bigfish.com (Postfix) with ESMTP id B4F1320047	for
 <linuxppc-dev@ozlabs.org>; Mon, 22 Jul 2013 22:58:37 +0000 (UTC)
Date: Mon, 22 Jul 2013 17:58:35 -0500
From: Scott Wood <scottwood@freescale.com>
To: Po Liu <po.liu@freescale.com>
Subject: Re: [3/4] powerpc/85xx: Add C293PCIE board support
Message-ID: <20130722225835.GA26484@home.buserror.net>
References: <1366854857-22791-3-git-send-email-Po.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1366854857-22791-3-git-send-email-Po.Liu@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Mingkai Hu <Mingkai.Hu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 25, 2013 at 09:54:16AM +0800, Po Liu wrote:
> From: Mingkai Hu <Mingkai.Hu@freescale.com>
> 
> C293PCIE board is a series of Freescale PCIe add-in cards to perform
> as public key crypto accelerator or secure key management module.
> 
>  - 512KB platform SRAM in addition to 512K L2 Cache/SRAM
>  - 512MB soldered DDR3 32bit memory
>  - CPLD System Logic
>  - 64MB x16 NOR flash and 4GB x8 NAND flash
>  - 16MB SPI flash
> 
> Signed-off-by: Mingkai Hu <Mingkai.Hu@freescale.com>
> Singed-off-by: Po Liu <Po.Liu@freescale.com>

Signed

> +		partition@900000 {
> +			/* 33MB for rootfs */
> +			reg = <0x00900000 0x02100000>;
> +			label = "NOR Rootfs Image";
> +		};
> +
> +		partition@2a00000 {
> +			/* 20MB for JFFS2 based Root file System */
> +			reg = <0x02a00000 0x01400000>;
> +			label = "NOR JFFS2 Root File System";
> +		};

Don't specify JFFS2.  Combine these two partitions into one.

> +		partition@600000 {
> +			/* 4MB for Compressed Root file System Image */
> +			reg = <0x00600000 0x00400000>;
> +			label = "NAND Compressed RFS Image";
> +		};
> +
> +		partition@a00000 {
> +			/* 15MB for JFFS2 based Root file System */
> +			reg = <0x00a00000 0x00f00000>;
> +			label = "NAND JFFS2 Root File System";
> +		};

Likewise.

> +		partition@1900000 {
> +			/* 7MB for User Area */
> +			reg = <0x01900000 0x00700000>;
> +			label = "NAND User area";
> +		};

Above you say there's 4 GiB of NAND, but here you define partitions that
only cover 32 MiB.

> +	};
> +
> +	cpld@2,0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "fsl,c293pcie-cpld";
> +		reg = <0x2 0x0 0x0000020>;
> +		bank-width = <1>;
> +		device-width = <1>;
> +	};

What do bank-width and device-width mean here?

Why all the leading zeroes in 0x0000020?

> +			partition@580000 {
> +				/* 4MB for Compressed RFS Image */
> +				reg = <0x00580000 0x00400000>;
> +				label = "SPI Flash Compressed RFSImage";
> +			};
> +
> +			partition@980000 {
> +				/* 6.5MB for JFFS2 based RFS */
> +				reg = <0x00980000 0x00680000>;
> +				label = "SPI Flash JFFS2 RFS";
> +			};

Again, merge these two and don't specify JFFS2.

> diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
> index a0dcd57..df26b21 100644
> --- a/arch/powerpc/platforms/85xx/Kconfig
> +++ b/arch/powerpc/platforms/85xx/Kconfig
> @@ -32,6 +32,13 @@ config BSC9131_RDB
>  	  StarCore SC3850 DSP
>  	  Manufacturer : Freescale Semiconductor, Inc
>  
> +config C293_PCIE
> +	  bool "Freescale C293PCIE"
> +	  select DEFAULT_UIMAGE
> +	  select SWIOTLB
> +	  help
> +	  This option enables support for the C293PCIE board

Why do you need SWIOTLB if the board has 512 MiB soldered RAM?

> diff --git a/arch/powerpc/platforms/85xx/c293pcie.c b/arch/powerpc/platforms/85xx/c293pcie.c
> new file mode 100644
> index 0000000..75dda12
> --- /dev/null
> +++ b/arch/powerpc/platforms/85xx/c293pcie.c
> @@ -0,0 +1,82 @@
> +/*
> + * C293PCIE Board Setup
> + *
> + * Copyright 2013 Freescale Semiconductor Inc.
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/stddef.h>
> +#include <linux/kernel.h>
> +#include <linux/pci.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/of_platform.h>
> +
> +#include <asm/time.h>
> +#include <asm/machdep.h>
> +#include <asm/pci-bridge.h>
> +#include <mm/mmu_decl.h>
> +#include <asm/prom.h>
> +#include <asm/udbg.h>
> +#include <asm/mpic.h>
> +
> +#include <sysdev/fsl_soc.h>
> +#include <sysdev/fsl_pci.h>
> +
> +#include "mpc85xx.h"

Are you sure you need all of these?  I don't see any delays, for example.

-Scott
