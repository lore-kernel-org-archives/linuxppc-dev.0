Return-Path: <dgibson@ozlabs.org>
Date: Tue, 21 Aug 2007 13:16:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 17/20] bootwrapper: Add PlanetCore firmware support.
Message-ID: <20070821031658.GQ15469@localhost.localdomain>
References: <20070820173920.GA30546@ld0162-tx32.am.freescale.net>
	<20070820174008.GP30562@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070820174008.GP30562@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 20, 2007 at 12:40:08PM -0500, Scott Wood wrote:
> This is a library that board code can use to extract information from the
> PlanetCore configuration keys.  PlanetCore is used on various boards from
> Embedded Planet.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>

[snip]
;5B;5B;5B> diff --git a/arch/powerpc/boot/planetcore.c b/arch/powerpc/boot/planetcore.c
> new file mode 100644
> index 0000000..e0f85e6
> --- /dev/null
> +++ b/arch/powerpc/boot/planetcore.c
> @@ -0,0 +1,160 @@
> +/*
> + * PlanetCore configuration data support functions
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
> +#include "stdio.h"
> +#include "stdlib.h"
> +#include "ops.h"
> +#include "planetcore.h"
> +#include "io.h"

Some comments describing the Planetcore table format wouldn't go
astray.  I vaguely recall it from when I worked with an EP405 years
and years ago, but...

> +void planetcore_prepare_table(char *table)
> +{
> +	int last_was_newline = 0;
> +
> +	while (*table != 10 || !last_was_newline) {
> +		if (*table == 10) {
> +			*table = 0;
> +			last_was_newline = 1;
> +		} else {
> +			last_was_newline = 0;
> +		}
> +
> +		table++;
> +	}

Hrm.. this loop makes my brain hurt.  It's correct as far as I can
determine what it's supposed to be doing, but I think there's got to
be a way to make what it's doing a little more obvious.

> +	*table = 0;
> +}

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
