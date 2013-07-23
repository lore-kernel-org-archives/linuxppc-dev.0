Return-Path: <B43644@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5FDAD2C00A8
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Jul 2013 17:47:25 +1000 (EST)
Received: from mail10-co1 (localhost [127.0.0.1])	by mail10-co1-R.bigfish.com
 (Postfix) with ESMTP id 91D495A0091	for <linuxppc-dev@ozlabs.org>;
 Tue, 23 Jul 2013 07:47:21 +0000 (UTC)
Received: from CO1EHSMHS017.bigfish.com (unknown [10.243.78.243])	by
 mail10-co1.bigfish.com (Postfix) with ESMTP id 58FEC900047	for
 <linuxppc-dev@ozlabs.org>; Tue, 23 Jul 2013 07:47:20 +0000 (UTC)
From: Liu Po-B43644 <B43644@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [3/4] powerpc/85xx: Add C293PCIE board support
Date: Tue, 23 Jul 2013 07:47:18 +0000
Message-ID: <D473A0D087F4EA47A30C37E4637E25E609DAD260@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1366854857-22791-3-git-send-email-Po.Liu@freescale.com>
 <20130722225835.GA26484@home.buserror.net>
In-Reply-To: <20130722225835.GA26484@home.buserror.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Hu Mingkai-B21284 <B21284@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>  -----Original Message-----
>  From: Wood Scott-B07421
>  Sent: Tuesday, July 23, 2013 6:59 AM
>  To: Liu Po-B43644
>  Cc: linuxppc-dev@ozlabs.org; Hu Mingkai-B21284
>  Subject: Re: [3/4] powerpc/85xx: Add C293PCIE board support
> =20
>  On Thu, Apr 25, 2013 at 09:54:16AM +0800, Po Liu wrote:
>  > From: Mingkai Hu <Mingkai.Hu@freescale.com>
>  >
>  > C293PCIE board is a series of Freescale PCIe add-in cards to perform
>  > as public key crypto accelerator or secure key management module.
>  >
>  >  - 512KB platform SRAM in addition to 512K L2 Cache/SRAM
>  >  - 512MB soldered DDR3 32bit memory
>  >  - CPLD System Logic
>  >  - 64MB x16 NOR flash and 4GB x8 NAND flash
>  >  - 16MB SPI flash
>  >
>  > Signed-off-by: Mingkai Hu <Mingkai.Hu@freescale.com>
>  > Singed-off-by: Po Liu <Po.Liu@freescale.com>
> =20
>  Signed
> =20
>  > +		partition@900000 {
>  > +			/* 33MB for rootfs */
>  > +			reg =3D <0x00900000 0x02100000>;
>  > +			label =3D "NOR Rootfs Image";
>  > +		};
>  > +
>  > +		partition@2a00000 {
>  > +			/* 20MB for JFFS2 based Root file System */
>  > +			reg =3D <0x02a00000 0x01400000>;
>  > +			label =3D "NOR JFFS2 Root File System";
>  > +		};
> =20
>  Don't specify JFFS2.  Combine these two partitions into one.
Ok, I'll merge up two partition.
> =20
>  > +		partition@600000 {
>  > +			/* 4MB for Compressed Root file System Image */
>  > +			reg =3D <0x00600000 0x00400000>;
>  > +			label =3D "NAND Compressed RFS Image";
>  > +		};
>  > +
>  > +		partition@a00000 {
>  > +			/* 15MB for JFFS2 based Root file System */
>  > +			reg =3D <0x00a00000 0x00f00000>;
>  > +			label =3D "NAND JFFS2 Root File System";
>  > +		};
> =20
>  Likewise.
> =20
>  > +		partition@1900000 {
>  > +			/* 7MB for User Area */
>  > +			reg =3D <0x01900000 0x00700000>;
>  > +			label =3D "NAND User area";
>  > +		};
> =20
>  Above you say there's 4 GiB of NAND, but here you define partitions that
>  only cover 32 MiB.
Can I set one partion include all other space(4GB- 32MB) with label name "O=
thers"?
> =20
>  > +	};
>  > +
>  > +	cpld@2,0 {
>  > +		#address-cells =3D <1>;
>  > +		#size-cells =3D <1>;
>  > +		compatible =3D "fsl,c293pcie-cpld";
>  > +		reg =3D <0x2 0x0 0x0000020>;
>  > +		bank-width =3D <1>;
>  > +		device-width =3D <1>;
>  > +	};
> =20
>  What do bank-width and device-width mean here?
I will remove these two lines? I thought I copy from other platform.
> =20
>  Why all the leading zeroes in 0x0000020?
I'll change to 0x20 from 0x0000020.
> =20
>  > +			partition@580000 {
>  > +				/* 4MB for Compressed RFS Image */
>  > +				reg =3D <0x00580000 0x00400000>;
>  > +				label =3D "SPI Flash Compressed RFSImage";
>  > +			};
>  > +
>  > +			partition@980000 {
>  > +				/* 6.5MB for JFFS2 based RFS */
>  > +				reg =3D <0x00980000 0x00680000>;
>  > +				label =3D "SPI Flash JFFS2 RFS";
>  > +			};
> =20
>  Again, merge these two and don't specify JFFS2.
Ok, thanks
> =20
>  > diff --git a/arch/powerpc/platforms/85xx/Kconfig
>  > b/arch/powerpc/platforms/85xx/Kconfig
>  > index a0dcd57..df26b21 100644
>  > --- a/arch/powerpc/platforms/85xx/Kconfig
>  > +++ b/arch/powerpc/platforms/85xx/Kconfig
>  > @@ -32,6 +32,13 @@ config BSC9131_RDB
>  >  	  StarCore SC3850 DSP
>  >  	  Manufacturer : Freescale Semiconductor, Inc
>  >
>  > +config C293_PCIE
>  > +	  bool "Freescale C293PCIE"
>  > +	  select DEFAULT_UIMAGE
>  > +	  select SWIOTLB
>  > +	  help
>  > +	  This option enables support for the C293PCIE board
> =20
>  Why do you need SWIOTLB if the board has 512 MiB soldered RAM?
I'll remove it.
> =20
>  > diff --git a/arch/powerpc/platforms/85xx/c293pcie.c
>  > b/arch/powerpc/platforms/85xx/c293pcie.c
>  > new file mode 100644
>  > index 0000000..75dda12
>  > --- /dev/null
>  > +++ b/arch/powerpc/platforms/85xx/c293pcie.c
>  > @@ -0,0 +1,82 @@
>  > +/*
>  > + * C293PCIE Board Setup
>  > + *
>  > + * Copyright 2013 Freescale Semiconductor Inc.
>  > + *
>  > + * This program is free software; you can redistribute  it and/or
>  > +modify it
>  > + * under  the terms of  the GNU General  Public License as published
>  > +by the
>  > + * Free Software Foundation;  either version 2 of the  License, or
>  > +(at your
>  > + * option) any later version.
>  > + */
>  > +
>  > +#include <linux/stddef.h>
>  > +#include <linux/kernel.h>
>  > +#include <linux/pci.h>
>  > +#include <linux/delay.h>
>  > +#include <linux/interrupt.h>
>  > +#include <linux/of_platform.h>
>  > +
>  > +#include <asm/time.h>
>  > +#include <asm/machdep.h>
>  > +#include <asm/pci-bridge.h>
>  > +#include <mm/mmu_decl.h>
>  > +#include <asm/prom.h>
>  > +#include <asm/udbg.h>
>  > +#include <asm/mpic.h>
>  > +
>  > +#include <sysdev/fsl_soc.h>
>  > +#include <sysdev/fsl_pci.h>
>  > +
>  > +#include "mpc85xx.h"
> =20
>  Are you sure you need all of these?  I don't see any delays, for example=
.
Thanks, I'll test and remove redundant includes.
> =20
>  -Scott
