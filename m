Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.237])
	by ozlabs.org (Postfix) with ESMTP id CC3EEDDE33
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Oct 2007 00:03:38 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so190695nzh
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 07:03:37 -0700 (PDT)
Message-ID: <fa686aa40710240703u6432d946r56832f84952e3ec@mail.gmail.com>
Date: Wed, 24 Oct 2007 08:03:36 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Marian Balakowicz" <m8@semihalf.com>
Subject: Re: [PATCH 04/11] [POWERPC] Add generic support for MPC5200 based
	boards
In-Reply-To: <20071023231327.29359.28666.stgit@hekate.izotz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071023231302.29359.27417.stgit@hekate.izotz.org>
	<20071023231327.29359.28666.stgit@hekate.izotz.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/23/07, Marian Balakowicz <m8@semihalf.com> wrote:
> This patch adds support for 'generic-mpc5200' compatible
> boards which do not need a platform specific setup.
>
> Signed-off-by: Marian Balakowicz <m8@semihalf.com>

I like this patch and I think it will make it easier to support
multiple 5200 based boards.  However, we must be very clear here what
'generic-mpc5200' is (in fact, my suggestion of the name
"generic-mpc5200" might be a bad one.  "mpc5200-simple-platform" might
be a better name).

Please add documentation to both the Kconfig and the generic_mpc5200.c
files describing exactly the assumptions which are made for this
platform.  For example:
- port_config and clocking are setup correctly by firmware,
- if the fsl,has-wdt property is present in one of the gpt nodes, then
it is safe to use it to reset the board
etc.

Cheers,
g.

> ---
>
>  arch/powerpc/platforms/52xx/Kconfig           |    8 ++-
>  arch/powerpc/platforms/52xx/Makefile          |    1
>  arch/powerpc/platforms/52xx/generic_mpc5200.c |   63 +++++++++++++++++++++++++
>  3 files changed, 70 insertions(+), 2 deletions(-)
>  create mode 100644 arch/powerpc/platforms/52xx/generic_mpc5200.c
>
>
> diff --git a/arch/powerpc/platforms/52xx/Kconfig b/arch/powerpc/platforms/52xx/Kconfig
> index 2938d49..59c67b5 100644
> --- a/arch/powerpc/platforms/52xx/Kconfig
> +++ b/arch/powerpc/platforms/52xx/Kconfig
> @@ -19,6 +19,12 @@ config PPC_MPC5200_BUGFIX
>
>           It is safe to say 'Y' here
>
> +config PPC_GENERIC_MPC5200
> +       bool "Generic support for MPC5200 based boards"
> +       depends on PPC_MULTIPLATFORM && PPC32
> +       select PPC_MPC5200
> +       default n
> +
>  config PPC_EFIKA
>         bool "bPlan Efika 5k2. MPC5200B based computer"
>         depends on PPC_MULTIPLATFORM && PPC32
> @@ -34,5 +40,3 @@ config PPC_LITE5200
>         select WANT_DEVICE_TREE
>         select PPC_MPC5200
>         default n
> -
> -
> diff --git a/arch/powerpc/platforms/52xx/Makefile b/arch/powerpc/platforms/52xx/Makefile
> index 307dbc1..bea05df 100644
> --- a/arch/powerpc/platforms/52xx/Makefile
> +++ b/arch/powerpc/platforms/52xx/Makefile
> @@ -6,6 +6,7 @@ obj-y                           += mpc52xx_pic.o mpc52xx_common.o
>  obj-$(CONFIG_PCI)              += mpc52xx_pci.o
>  endif
>
> +obj-$(CONFIG_PPC_GENERIC_MPC5200) += generic_mpc5200.o
>  obj-$(CONFIG_PPC_EFIKA)                += efika.o
>  obj-$(CONFIG_PPC_LITE5200)     += lite5200.o
>
> diff --git a/arch/powerpc/platforms/52xx/generic_mpc5200.c b/arch/powerpc/platforms/52xx/generic_mpc5200.c
> new file mode 100644
> index 0000000..a4ec899
> --- /dev/null
> +++ b/arch/powerpc/platforms/52xx/generic_mpc5200.c
> @@ -0,0 +1,63 @@
> +/*
> + * Support for 'generic-mpc5200' compatible platforms.
> + *
> + * Written by Marian Balakowicz <m8@semihalf.com>
> + * Copyright (C) 2007 Semihalf
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#undef DEBUG
> +#include <linux/init.h>
> +#include <linux/pci.h>
> +#include <linux/of.h>
> +#include <asm/time.h>
> +#include <asm/io.h>
> +#include <asm/machdep.h>
> +#include <asm/prom.h>
> +#include <asm/mpc52xx.h>
> +
> +/*
> + * Setup the architecture
> + */
> +static void __init generic_mpc5200_setup_arch(void)
> +{
> +       if (ppc_md.progress)
> +               ppc_md.progress("generic_mpc5200_setup_arch()", 0);
> +
> +       /* Some mpc5200 & mpc5200b related configuration */
> +       mpc5200_setup_xlb_arbiter();
> +
> +       /* Map wdt for mpc52xx_restart() */
> +       mpc52xx_map_wdt();
> +
> +#ifdef CONFIG_PCI
> +       mpc52xx_setup_pci();
> +#endif
> +}
> +
> +/*
> + * Called very early, MMU is off, device-tree isn't unflattened
> + */
> +static int __init generic_mpc5200_probe(void)
> +{
> +       unsigned long node = of_get_flat_dt_root();
> +
> +       if (!of_flat_dt_is_compatible(node, "generic-mpc5200"))
> +               return 0;
> +       return 1;
> +}
> +
> +define_machine(generic_mpc5200) {
> +       .name           = "generic-mpc5200",
> +       .probe          = generic_mpc5200_probe,
> +       .setup_arch     = generic_mpc5200_setup_arch,
> +       .init           = mpc52xx_declare_of_platform_devices,
> +       .init_IRQ       = mpc52xx_init_irq,
> +       .get_irq        = mpc52xx_get_irq,
> +       .restart        = mpc52xx_restart,
> +       .calibrate_decr = generic_calibrate_decr,
> +};
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
