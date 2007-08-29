Return-Path: <dgibson@ozlabs.org>
Date: Wed, 29 Aug 2007 15:45:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/3] Add early debug console for CPM serial ports.
Message-ID: <20070829054540.GD3206@localhost.localdomain>
References: <20070828201127.GA24068@ld0162-tx32.am.freescale.net>
	<20070828201621.GC24210@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070828201621.GC24210@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 28, 2007 at 03:16:21PM -0500, Scott Wood wrote:
> This code assumes that the ports have been previously set up, with
> buffers in DPRAM, and the descriptor address defined by platform code.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/Kconfig.debug       |    9 +++++++
>  arch/powerpc/kernel/head_32.S    |   16 +++++++++++++
>  arch/powerpc/kernel/udbg.c       |    2 +
>  arch/powerpc/sysdev/Makefile     |    1 +
>  arch/powerpc/sysdev/cpm_common.c |   44 ++++++++++++++++++++++++++++++++++++++
>  arch/powerpc/sysdev/cpm_common.h |   16 +++++++++++++
>  include/asm-powerpc/udbg.h       |    1 +
>  7 files changed, 89 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/sysdev/cpm_common.c
>  create mode 100644 arch/powerpc/sysdev/cpm_common.h
> 
> diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
> index 22acece..d471154 100644
> --- a/arch/powerpc/Kconfig.debug
> +++ b/arch/powerpc/Kconfig.debug
> @@ -211,6 +211,15 @@ config PPC_EARLY_DEBUG_44x
>  	  Select this to enable early debugging for IBM 44x chips via the
>  	  inbuilt serial port.
>  
> +config PPC_EARLY_DEBUG_CPM
> +	bool "Early serial debugging for Freescale CPM-based serial ports"
> +	depends on SERIAL_CPM
> +	select PIN_TLB if PPC_8xx

I see this Kconfig line, but I don't see any code below that would set
up a suitable TLB on 8xx for the CPM...?

[snip]
> diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
> index 08ce31e..5063e74 100644
> --- a/arch/powerpc/sysdev/Makefile
> +++ b/arch/powerpc/sysdev/Makefile
> @@ -34,6 +34,7 @@ endif
>  
>  # Temporary hack until we have migrated to asm-powerpc
>  ifeq ($(ARCH),powerpc)
> +obj-$(CONFIG_CPM1)$(CONFIG_CPM2) += cpm_common.o

Uh.. I don't think this will work properly.  If CONFIG_CPM1 and
CONFIG_CPM2 are both enabled, it will set obj-yy rather than obj-y.

>  obj-$(CONFIG_CPM2)		+= cpm2_common.o cpm2_pic.o
>  obj-$(CONFIG_8xx)		+= mpc8xx_pic.o commproc.o
>  obj-$(CONFIG_UCODE_PATCH)	+= micropatch.o
> diff --git a/arch/powerpc/sysdev/cpm_common.c b/arch/powerpc/sysdev/cpm_common.c
> new file mode 100644
> index 0000000..1972a8f
> --- /dev/null
> +++ b/arch/powerpc/sysdev/cpm_common.c
> @@ -0,0 +1,44 @@
> +/*
> + * Common CPM code
> + *
> + * Author: Scott Wood <scottwood@freescale.com>
> + *
> + * Copyright 2007 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/init.h>
> +#include <asm/udbg.h>
> +#include <asm/io.h>
> +#include <asm/system.h>
> +#include <mm/mmu_decl.h>
> +#include "cpm_common.h"
> +
> +#ifdef CONFIG_PPC_EARLY_DEBUG_CPM
> +static void udbg_putc_cpm(char c)
> +{
> +	u8 __iomem *txbuf = (u8 __iomem __force *)in_be32(&cpm_udbg_txdesc[1]);
> +
> +	if (c == '\n')
> +		udbg_putc('\r');
> +
> +	while (in_be32(&cpm_udbg_txdesc[0]) & 0x80000000)
> +		;
> +
> +	out_8(txbuf, c);
> +	out_be32(&cpm_udbg_txdesc[0], 0xa0000001);
> +}
> +
> +void __init udbg_init_cpm(void)
> +{
> +	if (cpm_udbg_txdesc) {
> +#ifdef CONFIG_CPM2
> +		setbat(1, 0xf0000000, 0xf0000000, 1024*1024, _PAGE_IO);
> +#endif
> +		udbg_putc = udbg_putc_cpm;
> +	}
> +}
> +#endif

Since this is all udbg related, it could go (within an ifdef) into
udbg.c rather than creating a new file for it.

> diff --git a/arch/powerpc/sysdev/cpm_common.h b/arch/powerpc/sysdev/cpm_common.h
> new file mode 100644
> index 0000000..f42343f
> --- /dev/null
> +++ b/arch/powerpc/sysdev/cpm_common.h
> @@ -0,0 +1,16 @@
> +#ifndef _POWERPC_SYSDEV_CPM_COMMON_H
> +#define _POWERPC_SYSDEV_CPM_COMMON_H
> +
> +#include <linux/types.h>
> +
> +/*
> + * Board code must define this address if the early console is used.
> + *
> + * Note that this is not multi-platform safe, and thus the CPM
> + * UDBG console must only be enabled when only a single platform
> + * is selected.  It is done this way because udbg init runs before
> + * platform probing.
> + */
> +extern u32 __iomem *cpm_udbg_txdesc;

Urg... this is ugly, because it looks like it can be muti-platform,
but actually isn't.  I think a better approach is to set the magic
address as a Kconfig variable, as we do on 44x.  This approach can
also be useful for hacking up early debug for new chips during the
process of creating platform code for them.

> +
> +#endif
> diff --git a/include/asm-powerpc/udbg.h b/include/asm-powerpc/udbg.h
> index ce9d82f..a9e0b0e 100644
> --- a/include/asm-powerpc/udbg.h
> +++ b/include/asm-powerpc/udbg.h
> @@ -48,6 +48,7 @@ extern void __init udbg_init_rtas_console(void);
>  extern void __init udbg_init_debug_beat(void);
>  extern void __init udbg_init_btext(void);
>  extern void __init udbg_init_44x_as1(void);
> +extern void __init udbg_init_cpm(void);
>  
>  #endif /* __KERNEL__ */
>  #endif /* _ASM_POWERPC_UDBG_H */

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
