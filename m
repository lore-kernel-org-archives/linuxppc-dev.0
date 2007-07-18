Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 19017DDFCB
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 04:51:39 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6e26faa3f30dddc5fcf6294a1ecb3a78@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [patch 14/14] Bamboo zImage wrapper
Date: Wed, 18 Jul 2007 12:21:51 -0500
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sorry for the broken reply but the list is broken.

On Wed Jul 18 04:16:01 EST 2007, Josh Boyer wrote:
> Add a bootwrapper for Bamboo

bamboo is what, an evaluation board? for which processor?

> Signed-off-by: Josh Boyer <jwboyer at linux.vnet.ibm.com>
>
> ---
>  arch/powerpc/boot/44x.h             |    1
>  arch/powerpc/boot/Makefile          |    5 -
>  arch/powerpc/boot/bamboo.c          |  126 
> ++++++++++++++++++++++++++++++++++++
>  arch/powerpc/boot/dcr.h             |   11 +++
>  arch/powerpc/boot/treeboot-bamboo.c |   27 +++++++
>  5 files changed, 168 insertions(+), 2 deletions(-)
>
> --- linux-2.6.orig/arch/powerpc/boot/Makefile
> +++ linux-2.6/arch/powerpc/boot/Makefile
> @@ -143,6 +143,7 @@ image-$(CONFIG_PPC_83xx)            += cuImage.83x
>  image-$(CONFIG_PPC_85xx)               += cuImage.85xx
>  image-$(CONFIG_EBONY)                  += treeImage.ebony 
> cuImage.ebony
>  image-$(CONFIG_WALNUT)                 += treeImage.walnut
> +image-$(CONFIG_BAMBOO)                 += treeImage.bamboo
>  endif

You are only making one target.

> +
> +static void bamboo_fixups(void)
> +{
> +       unsigned long sysclk = 33333333;
> +       ibm440ep_fixup_clocks(sysclk, 11059200);
> +       ibm4xx_fixup_memsize();
> +       ibm4xx_reset_eth((u32 *)0xef600e00, (u32 *)0xef600f00);
> +}

This seems to have board specific information ..

> +
> +void bamboo_init(void)
> +{
> +       platform_ops.fixups = bamboo_fixups;
> +       platform_ops.exit = ibm44x_dbcr_reset;
> +       ft_init(_dtb_start, 0, 32);
> +       serial_console_init();
> +}

and so is this (by transitivity).

> --- /dev/null
> +++ linux-2.6/arch/powerpc/boot/treeboot-bamboo.c
> @@ -0,0 +1,27 @@
... [copyright header]
> +#include "ops.h"
> +#include "stdio.h"
> +#include "44x.h"
> +
> +extern char _end[];
> +
> +BSS_STACK(4096);
> +
> +void platform_init(void)
> +{
> +       unsigned long end_of_ram = 0x8000000;
> +       unsigned long avail_ram = end_of_ram - (unsigned long)_end;
> +
> +       simple_alloc_init(_end, avail_ram, 32, 64);
> +       bamboo_init();
> +}

Is there some reason they should not all be merged into this one 
platform file?

I can understand wanting the dcr fixups as a library, but lets wait to 
do the file splits until there are actually users.  Its also easier to 
see what's going to called when all the platform ops are filled in at 
one spot, not spread over multiple files.

milton
