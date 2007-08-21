Return-Path: <dgibson@ozlabs.org>
Date: Tue, 21 Aug 2007 12:47:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 14/20] bootwrapper: Add strtoull().
Message-ID: <20070821024713.GM15469@localhost.localdomain>
References: <20070820173920.GA30546@ld0162-tx32.am.freescale.net>
	<20070820174004.GM30562@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070820174004.GM30562@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 20, 2007 at 12:40:04PM -0500, Scott Wood wrote:
> This will be needed by PlanetCore firmware support.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/boot/Makefile |    2 +-
>  arch/powerpc/boot/stdlib.c |   41 +++++++++++++++++++++++++++++++++++++++++
>  arch/powerpc/boot/stdlib.h |    6 ++++++
>  3 files changed, 48 insertions(+), 1 deletions(-)
>  create mode 100644 arch/powerpc/boot/stdlib.c
>  create mode 100644 arch/powerpc/boot/stdlib.h
> 
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index 4ab5f75..bad54ba 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -45,7 +45,7 @@ src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
>  		ns16550.c serial.c simple_alloc.c div64.S util.S \
>  		gunzip_util.c elf_util.c $(zlib) devtree.c oflib.c ofconsole.c \
>  		44x.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c cuboot.c \
> -		cpm-serial.c
> +		cpm-serial.c stdlib.c
>  src-plat := of.c cuboot-83xx.c cuboot-85xx.c holly.c \
>  		cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
>  		ps3-head.S ps3-hvcall.S ps3.c cuboot-8xx.c cuboot-pq2.c
> diff --git a/arch/powerpc/boot/stdlib.c b/arch/powerpc/boot/stdlib.c
> new file mode 100644
> index 0000000..ed6e728
> --- /dev/null
> +++ b/arch/powerpc/boot/stdlib.c
> @@ -0,0 +1,41 @@
> +/*
> + * stdlib functions
> + *
> + * Author: Scott Wood <scottwood@freescale.com>
> + *
> + * Copyright (c) 2007 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation.
> + */
> +
> +#include "stdlib.h"
> +
> +/* Not currently supported: leading whitespace, sign, 0x prefix, zero base */
> +unsigned long long int strtoull(const char *ptr, char **end, int base)
> +{
> +	unsigned long long ret = 0;
> +
> +	while (*ptr) {
> +		int digit;
> +
> +		if (*ptr >= '0' && *ptr <= '9')
> +			digit = *ptr - '0';
> +		else if (*ptr >= 'A' && *ptr <= 'Z')
> +			digit = *ptr - 'A' + 10;
> +		else if (*ptr >= 'a' && *ptr <= 'z')
> +			digit = *ptr - 'a' + 10;
> +		else
> +			break;

Hrm... I note this has no sort of error checking if the string has
digits which don't fit in the given base.

> +		ret *= base;
> +		ret += digit;
> +		ptr++;
> +	}
> +
> +	if (end)
> +		*end = (char *)ptr;
> +
> +	return ret;
> +}
> diff --git a/arch/powerpc/boot/stdlib.h b/arch/powerpc/boot/stdlib.h
> new file mode 100644
> index 0000000..1bf01ac
> --- /dev/null
> +++ b/arch/powerpc/boot/stdlib.h
> @@ -0,0 +1,6 @@
> +#ifndef _PPC_BOOT_STDLIB_H_
> +#define _PPC_BOOT_STDLIB_H_
> +
> +unsigned long long int strtoull(const char *ptr, char **end, int base);
> +
> +#endif

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
