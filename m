Return-Path: <dgibson@ozlabs.org>
Date: Fri, 23 Mar 2007 16:54:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 6/6] bootwrapper: cuboot for 83xx
Message-ID: <20070323055442.GB27940@localhost.localdomain>
References: <20070322194627.GA31926@ld0162-tx32.am.freescale.net>
	<20070322194930.GF31965@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070322194930.GF31965@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 22, 2007 at 02:49:30PM -0500, Scott Wood wrote:
> This adds cuboot support for MPC83xx platforms.
> 
> A device tree used with this must have linux,stdout-path in /chosen and
> linux,network-index in any network device nodes that need mac addresses
> assigned.

[snip]
> +++ b/arch/powerpc/boot/cuboot-83xx.c
> @@ -0,0 +1,70 @@
> +/*
> + * Old U-boot compatibility for 83xx
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
> +#include "ops.h"
> +#include "stdio.h"
> +
> +#define TARGET_83xx
> +#include "ppcboot.h"
> +
> +static bd_t bd;
> +extern char _end[];
> +extern char _dtb_start[], _dtb_end[];
> +
> +static void *vmlinux_alloc(unsigned long size)
> +{
> +	void *p = malloc(size);
> +
> +	if (!p)
> +		fatal("Can't allocate memory for kernel image!\n\r");
> +
> +	return p;
> +}

I don't think you should need a vmlinux_alloc for this platform.

> +void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
> +                   unsigned long r6, unsigned long r7)
> +{
> +	unsigned long end_of_ram = bd.bi_memstart + bd.bi_memsize;
> +	unsigned long avail_ram = end_of_ram - (unsigned long)_end;
> +	void *soc;
> +
> +	memcpy(&bd, (bd_t *)r3, sizeof(bd));
> +	loader_info.initrd_addr = r4;
> +	loader_info.initrd_size = r4 ? r5 : 0;
> +	loader_info.cmdline = (char *)r6;
> +	loader_info.cmdline_len = r7 - r6;
> +
> +	simple_alloc_init(_end, avail_ram, 32, 64);
> +	ft_init(_dtb_start, _dtb_end - _dtb_start, 32);
> +	serial_console_init();
> +	platform_ops.vmlinux_alloc = vmlinux_alloc;


I think this should be the end of platform_init.  The actual device
tree mangling should instead be done from the .fixups hook function.
The simple reason is that in general we want to defer as much as
possible until after the console_open so that we can get error
messages.  The more complicated reason is that looking ahead to when
we're using libfdt instead of flatdevtree.c, we may need an extra step
that prepares the device tree for read/write access (with libfdt, an
fdt_open_into()).  That won't happen until after platform_init(), but
will be before .fixups().

> +	dt_fixup_memory(bd.bi_memstart, bd.bi_memsize);
> +	dt_fixup_mac_addresses(bd.bi_enetaddr, bd.bi_enet1addr);
> +	dt_fixup_cpu_clocks(bd.bi_intfreq, bd.bi_busfreq / 4, bd.bi_busfreq);
> +
> +	soc = find_node_by_devtype(NULL, "soc");

Hrm... more-or-less by definition, cuboot will be using the device
trees included in the kernel tree.  So why can't we just fix the mpc
device trees so the soc node is just called "/soc" instead of having to
use this find by type stuff.

> +	if (soc) {
> +		void *serial = NULL;
> +
> +		setprop(soc, "bus-frequency", &bd.bi_busfreq,
> +		        sizeof(bd.bi_busfreq));

This should probably just be 'clock-frequency' on the soc node (since
the soc node represents the on-chip bus).  But to fix that I guess
we'd need parallel changes to the kernel proper.

> +		while ((serial = find_node_by_devtype(serial, "serial"))) {
> +			if (get_parent(serial) != soc)
> +				continue;
> +
> +			setprop(serial, "clock-frequency", &bd.bi_busfreq,
> +			        sizeof(bd.bi_busfreq));
> +		}
> +	}
> +}

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
