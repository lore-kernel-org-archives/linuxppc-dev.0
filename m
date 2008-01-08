Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by ozlabs.org (Postfix) with ESMTP id AFD29DDE3E
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 04:19:21 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1624447anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 08 Jan 2008 09:19:20 -0800 (PST)
Message-ID: <fa686aa40801080919y7c426007vd031bb79e8f9a03d@mail.gmail.com>
Date: Tue, 8 Jan 2008 10:19:20 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "John Rigby" <jrigby@freescale.com>
Subject: Re: [PATCH 3/7] Basic Freescale MPC512x support
In-Reply-To: <1199808093-15929-4-git-send-email-jrigby@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1199808093-15929-1-git-send-email-jrigby@freescale.com>
	<1199808093-15929-2-git-send-email-jrigby@freescale.com>
	<1199808093-15929-3-git-send-email-jrigby@freescale.com>
	<1199808093-15929-4-git-send-email-jrigby@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Looks pretty good; major comment is that it should be multiplatform enabled.

Cheers,
g.

On 1/8/08, John Rigby <jrigby@freescale.com> wrote:
> 512x is very similar to 83xx and most
> of this is patterned after code from 83xx
>
> New platform:
>     changed:
>         arch/powerpc/Kconfig
>         arch/powerpc/platforms/Kconfig
>         arch/powerpc/platforms/Kconfig.cputype
>         arch/powerpc/platforms/Makefile
>     new:
>         arch/powerpc/platforms/512x/*
>
> Signed-off-by: John Rigby <jrigby@freescale.com>
> ---
>  arch/powerpc/Kconfig                      |    2 +-
>  arch/powerpc/platforms/512x/Kconfig       |   20 ++++++
>  arch/powerpc/platforms/512x/Makefile      |    4 +
>  arch/powerpc/platforms/512x/mpc5121_ads.c |   90 +++++++++++++++++++++++++++++
>  arch/powerpc/platforms/Kconfig            |    8 +++
>  arch/powerpc/platforms/Kconfig.cputype    |    6 +-
>  arch/powerpc/platforms/Makefile           |    1 +
>  7 files changed, 127 insertions(+), 4 deletions(-)
>  create mode 100644 arch/powerpc/platforms/512x/Kconfig
>  create mode 100644 arch/powerpc/platforms/512x/Makefile
>  create mode 100644 arch/powerpc/platforms/512x/mpc5121_ads.c
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 66a3d8c..81c3f05 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -470,7 +470,7 @@ config PCI
>         bool "PCI support" if 40x || CPM2 || PPC_83xx || PPC_85xx || PPC_86xx \
>                 || PPC_MPC52xx || (EMBEDDED && (PPC_PSERIES || PPC_ISERIES)) \
>                 || PPC_PS3
> -       default y if !40x && !CPM2 && !8xx && !PPC_83xx \
> +       default y if !40x && !CPM2 && !8xx && !PPC_512x && !PPC_83xx \
>                 && !PPC_85xx && !PPC_86xx
>         default PCI_PERMEDIA if !4xx && !CPM2 && !8xx
>         default PCI_QSPAN if !4xx && !CPM2 && 8xx
> diff --git a/arch/powerpc/platforms/512x/Kconfig b/arch/powerpc/platforms/512x/Kconfig
> new file mode 100644
> index 0000000..399d279
> --- /dev/null
> +++ b/arch/powerpc/platforms/512x/Kconfig
> @@ -0,0 +1,20 @@
> +menu "Platform support"
> +       depends on PPC_512x
> +
> +choice
> +       prompt "Machine Type"
> +       default MPC5121_ADS

You should drop this choice and make mpc512x support multiplatform instead.

You might also want to consider renaming platforms/52xx to
platforms/5xxx and putting the 512x boards there instead.

> +
> +config MPC5121_ADS
> +       bool "Freescale MPC5121E ADS"
> +       select DEFAULT_UIMAGE
> +       help
> +         This option enables support for the MPC5121E ADS board.

Make this depend on PPC_MULTIPLATFORM and PPC32

> +
> +endchoice
> +
> +config MPC5121
> +       bool
> +       default y if MPC5121_ADS

Drop the default and make the MPC5121_ADS select MPC5121.

Also I recommend change this to PPC_MPC5121 instead of MPC5121 (better
namespace)

> +
> +endmenu
> diff --git a/arch/powerpc/platforms/512x/Makefile b/arch/powerpc/platforms/512x/Makefile
> new file mode 100644
> index 0000000..232c89f
> --- /dev/null
> +++ b/arch/powerpc/platforms/512x/Makefile
> @@ -0,0 +1,4 @@
> +#
> +# Makefile for the Freescale PowerPC 512x linux kernel.
> +#
> +obj-$(CONFIG_MPC5121_ADS)      += mpc5121_ads.o
> diff --git a/arch/powerpc/platforms/512x/mpc5121_ads.c b/arch/powerpc/platforms/512x/mpc5121_ads.c
> new file mode 100644
> index 0000000..a860bf0
> --- /dev/null
> +++ b/arch/powerpc/platforms/512x/mpc5121_ads.c
> @@ -0,0 +1,90 @@
> +/*
> + * Copyright (C) 2007 Freescale Semiconductor, Inc. All rights reserved.
> + *
> + * Author: John Rigby, <jrigby@freescale.com>, Thur Mar 29 2007
> + *
> + * Description:
> + * MPC5121 ADS board setup
> + *
> + * This is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + */
> +
> +#include <linux/stddef.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/errno.h>
> +#include <linux/reboot.h>
> +#include <linux/kdev_t.h>
> +#include <linux/major.h>
> +#include <linux/console.h>
> +#include <linux/delay.h>
> +#include <linux/seq_file.h>
> +#include <linux/root_dev.h>
> +#include <linux/time.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +
> +#include <asm/system.h>
> +#include <asm/atomic.h>
> +#include <asm/machdep.h>
> +#include <asm/ipic.h>
> +#include <asm/prom.h>
> +#include <asm/time.h>
> +#include <asm/of_platform.h>
> +
> +static void __init mpc5121_ads_setup_arch(void)
> +{
> +       if (ppc_md.progress)
> +               ppc_md.progress("mpc5121_ads_setup_arch()", 0);
> +
> +       printk(KERN_INFO "MPC5121 ADS board from Freescale Semiconductor\n");
> +}

This function doesn't do anything; just drop it

> +
> +static void __init mpc5121_ads_declare_of_platform_devices(void)
> +{
> +       /* Find every child of the SOC node and add it to of_platform */
> +       if (of_platform_bus_probe(NULL, NULL, NULL))
> +               printk(KERN_ERR __FILE__ ": "
> +                       "Error while probing of_platform bus\n");
> +}
> +
> +static void __init mpc5121_ads_init_IRQ(void)
> +{
> +       struct device_node *np;
> +
> +       np = of_find_node_by_type(NULL, "ipic");
> +       if (!np)
> +               return;
> +
> +       ipic_init(np, 0);
> +
> +       /*
> +        * Initialize the default interrupt mapping priorities,
> +        * in case the boot rom changed something on us.
> +        */
> +       ipic_set_default_priority();
> +}
> +
> +/*
> + * Called very early, MMU is off, device-tree isn't unflattened
> + */
> +static int __init mpc5121_ads_probe(void)
> +{
> +       unsigned long root = of_get_flat_dt_root();
> +
> +       return of_flat_dt_is_compatible(root, "MPC5121ADS");

Use "fsl,mpc5121ads" instead.

> +}
> +
> +define_machine(mpc5121_ads) {
> +       .name                   = "MPC5121 ADS",
> +       .probe                  = mpc5121_ads_probe,
> +       .setup_arch             = mpc5121_ads_setup_arch,
> +       .init                   = mpc5121_ads_declare_of_platform_devices,
> +       .init_IRQ               = mpc5121_ads_init_IRQ,
> +       .get_irq                = ipic_get_irq,
> +       .calibrate_decr         = generic_calibrate_decr,
> +};
> diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
> index ad9b1c0..1daf47f 100644
> --- a/arch/powerpc/platforms/Kconfig
> +++ b/arch/powerpc/platforms/Kconfig
> @@ -25,6 +25,13 @@ config PPC_83xx
>         select IPIC
>         select WANT_DEVICE_TREE
>
> +config PPC_512x
> +       bool "Freescale 512x"
> +       depends on 6xx
> +       select FSL_SOC
> +       select IPIC
> +       select WANT_DEVICE_TREE
> +

Drop this entry so that 512x can be multiplatform instead.

>  config PPC_86xx
>         bool "Freescale 86xx"
>         depends on 6xx
> @@ -41,6 +48,7 @@ config CLASSIC32
>  source "arch/powerpc/platforms/pseries/Kconfig"
>  source "arch/powerpc/platforms/iseries/Kconfig"
>  source "arch/powerpc/platforms/chrp/Kconfig"
> +source "arch/powerpc/platforms/512x/Kconfig"
>  source "arch/powerpc/platforms/52xx/Kconfig"
>  source "arch/powerpc/platforms/powermac/Kconfig"
>  source "arch/powerpc/platforms/prep/Kconfig"
> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
> index c3ee0b5..e21ffa5 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -14,7 +14,7 @@ choice
>           There are five families of 32 bit PowerPC chips supported.
>           The most common ones are the desktop and server CPUs (601, 603,
>           604, 740, 750, 74xx) CPUs from Freescale and IBM, with their
> -         embedded 52xx/82xx/83xx/86xx counterparts.
> +         embedded 512x/52xx/82xx/83xx/86xx counterparts.
>           The other embeeded parts, namely 4xx, 8xx, e200 (55xx) and e500
>           (85xx) each form a family of their own that is not compatible
>           with the others.
> @@ -22,7 +22,7 @@ choice
>           If unsure, select 52xx/6xx/7xx/74xx/82xx/83xx/86xx.
>
>  config 6xx
> -       bool "52xx/6xx/7xx/74xx/82xx/83xx/86xx"
> +       bool "512x/52xx/6xx/7xx/74xx/82xx/83xx/86xx"

5xxx maybe?

>         select PPC_FPU
>
>  config PPC_85xx
> @@ -229,7 +229,7 @@ config NR_CPUS
>
>  config NOT_COHERENT_CACHE
>         bool
> -       depends on 4xx || 8xx || E200
> +       depends on 4xx || 8xx || E200 || PPC_512x
>         default y
>
>  config CHECK_CACHE_COHERENCY
> diff --git a/arch/powerpc/platforms/Makefile b/arch/powerpc/platforms/Makefile
> index 6d9079d..633a599 100644
> --- a/arch/powerpc/platforms/Makefile
> +++ b/arch/powerpc/platforms/Makefile
> @@ -11,6 +11,7 @@ endif
>  obj-$(CONFIG_PPC_CHRP)         += chrp/
>  obj-$(CONFIG_40x)              += 40x/
>  obj-$(CONFIG_44x)              += 44x/
> +obj-$(CONFIG_PPC_512x)         += 512x/
>  obj-$(CONFIG_PPC_MPC52xx)      += 52xx/
>  obj-$(CONFIG_PPC_8xx)          += 8xx/
>  obj-$(CONFIG_PPC_82xx)         += 82xx/
> --
> 1.5.3.5.726.g41a7a
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
