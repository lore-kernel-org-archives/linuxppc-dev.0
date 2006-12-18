Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (147.175.241.83.in-addr.dgcsystems.net
	[83.241.175.147]) by ozlabs.org (Postfix) with ESMTP id 6EC6E679E9
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 01:44:16 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] powerpc: consolidate mpc83xx platform files
Date: Mon, 18 Dec 2006 15:44:14 +0100
Message-ID: <F6AD7E21CDF4E145A44F61F43EE6D939BA72A0@tmnt04.transmode.se>
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "Olof Johansson" <olof@lixom.net>, "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[SNIP]

> Something like this should work just as well. Seems to work fine on my
> system here (that has a DS1338, i.e. ds1307 driver).
>=20
> Let me know if it works on 83xx and I'll post it with a=20
> signed-off-line.
>=20
>=20
>=20
> -Olof
>=20
>=20
>=20
>=20
> Index: linux-2.6/arch/powerpc/Kconfig
> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/arch/powerpc/Kconfig
> +++ linux-2.6/arch/powerpc/Kconfig
> @@ -600,6 +600,12 @@ config PPC_TODC
>  	---help---
>  	  This adds support for many TODC/RTC chips.
> =20
> +config PPC_GENRTC
> +	bool "Generic RTC support"
> +	help
> +	  This adds support for using regular RTC registered=20
> with the RTC
> +	  framework as the main clock on powerpc.
> +
>  endmenu
> =20
>  source arch/powerpc/platforms/embedded6xx/Kconfig
> Index: linux-2.6/arch/powerpc/sysdev/Makefile
> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/arch/powerpc/sysdev/Makefile
> +++ linux-2.6/arch/powerpc/sysdev/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_40x)		+=3D dcr.o
>  obj-$(CONFIG_U3_DART)		+=3D dart_iommu.o
>  obj-$(CONFIG_MMIO_NVRAM)	+=3D mmio_nvram.o
>  obj-$(CONFIG_FSL_SOC)		+=3D fsl_soc.o
> +obj-$(CONFIG_PPC_GENRTC)	+=3D genrtc.o
>  obj-$(CONFIG_PPC_TODC)		+=3D todc.o
>  obj-$(CONFIG_TSI108_BRIDGE)	+=3D tsi108_pci.o tsi108_dev.o
>  obj-$(CONFIG_QUICC_ENGINE)	+=3D qe_lib/
> Index: linux-2.6/arch/powerpc/sysdev/genrtc.c
> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- /dev/null
> +++ linux-2.6/arch/powerpc/sysdev/genrtc.c
> @@ -0,0 +1,77 @@
> +/*
> + * Copyright (C) Olof Johansson <olof@lixom.net>
> + *
> + * This program is free software; you can redistribute it=20
> and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA =20
> 02111-1307 USA
> + */
> +
> +#include <linux/time.h>
> +#include <linux/device.h>
> +#include <linux/rtc.h>
> +
> +#include <asm/machdep.h>
> +#include <asm/time.h>
> +
> +static struct class_device *rtc_dev;
> +
> +static void genrtc_set_rtc_time_work(void *arg);
> +
> +static struct rtc_time delayed_tm;
> +static struct workqueue_struct *rtc_workqueue;
> +static DECLARE_WORK(rtc_work, genrtc_set_rtc_time_work, &delayed_tm);

The workqueue stuff has changed and needs to be adapted. Don't know how
yet though. If you figure it out, drop a line.

 Jocke
[SNIP]
