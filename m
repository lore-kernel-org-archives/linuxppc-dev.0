Return-Path: <glikely@secretlab.ca>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.229])
	by ozlabs.org (Postfix) with ESMTP id 85EDADDE1F
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Jun 2008 15:21:47 +1000 (EST)
Received: by qb-out-0506.google.com with SMTP id d8so2676168qbc.37
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 22:21:46 -0700 (PDT)
Date: Sat, 28 Jun 2008 23:21:43 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: John Rigby <jrigby@freescale.com>
Subject: Re: [PATCH 2/6] MPC5121 clock driver
Message-ID: <20080629052143.GA13876@secretlab.ca>
References: <1213981119-1979-1-git-send-email-jrigby@freescale.com>
	<1213981119-1979-2-git-send-email-jrigby@freescale.com>
	<1213981119-1979-3-git-send-email-jrigby@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1213981119-1979-3-git-send-email-jrigby@freescale.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mostly looks good, a few comments below.

On Fri, Jun 20, 2008 at 10:58:35AM -0600, John Rigby wrote:
> Implements the api defined in include/clk.h
> 
> Current only getting frequencies is supported
> not setting.

Need a more detailed commit message.  This doesn't tell me much.

> 
> Signed-off-by: John Rigby <jrigby@freescale.com>
> ---
>  arch/powerpc/platforms/512x/Makefile |    1 +
>  arch/powerpc/platforms/512x/clock.c  |  729 ++++++++++++++++++++++++++++++++++
>  2 files changed, 730 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/platforms/512x/clock.c
> 
> diff --git a/arch/powerpc/platforms/512x/Makefile b/arch/powerpc/platforms/512x/Makefile
> index 232c89f..ef6c925 100644
> --- a/arch/powerpc/platforms/512x/Makefile
> +++ b/arch/powerpc/platforms/512x/Makefile
> @@ -1,4 +1,5 @@
>  #
>  # Makefile for the Freescale PowerPC 512x linux kernel.
>  #
> +obj-y				:= clock.o

should be +=

>  obj-$(CONFIG_MPC5121_ADS)	+= mpc5121_ads.o
> diff --git a/arch/powerpc/platforms/512x/clock.c b/arch/powerpc/platforms/512x/clock.c
> new file mode 100644
> index 0000000..39db722
> --- /dev/null
> +++ b/arch/powerpc/platforms/512x/clock.c
> @@ -0,0 +1,729 @@
> +/*
> + * Copyright (C) 2007,2008 Freescale Semiconductor, Inc. All rights reserved.
> + *
> + * Author: John Rigby <jrigby@freescale.com>
> + *
> + * Implements the clk api defined in include/linux/clk.h
> + *
> + *    Original based on linux/arch/arm/mach-integrator/clock.c
> + *
> + *    Copyright (C) 2004 ARM Limited.
> + *    Written by Deep Blue Solutions Limited.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/errno.h>
> +#include <linux/err.h>
> +#include <linux/string.h>
> +#include <linux/clk.h>
> +#include <linux/mutex.h>
> +#include <linux/io.h>
> +
> +#include <linux/of_platform.h>
> +#include <asm/mpc512x.h>
> +
> +static int clocks_initialized;
> +
> +struct module;

This is already defined in linux/module.h?

> +
> +#undef CLK_DEBUG

I think this line should be at the top of the file to be easier to find
when toggling it.

> +#ifdef CLK_DEBUG
> +void dump_clocks(void)
> +{
> +	struct clk *p;
> +
> +	mutex_lock(&clocks_mutex);
> +	printk(KERN_INFO "CLOCKS:\n");
> +	list_for_each_entry(p, &clocks, node) {
> +		printk(KERN_INFO "  %s %ld", p->name, p->rate);
> +		if (p->parent)
> +			printk(KERN_INFO " %s %ld", p->parent->name,
> +			       p->parent->rate);
> +		if (p->flags & CLK_HAS_CTRL)
> +			printk(KERN_INFO " reg/bit %d/%d", p->reg, p->bit);
> +		printk("\n");
> +	}
> +	mutex_unlock(&clocks_mutex);
> +}
> +#define	DEBUG_CLK_DUMP() dump_clocks()
> +#else
> +#define	DEBUG_CLK_DUMP()
> +#endif
> +
> +static long ips_to_ref(unsigned long rate)
> +{
> +	int ips_div = (clockctl->scfr1 >> 23) & 0x7;
> +
> +	rate *= ips_div;	/* csb_clk = ips_clk * ips_div */
> +	rate *= 2;		/* sys_clk = csb_clk * 2 */
> +	return sys_to_ref(rate);
> +}
> +
> +static unsigned long devtree_getfreq(char *nodetype, char *clockname)

Why is nodetype even passed in here?  It isn't used, and besides, you
shouldn't test against device_type anyway.  Test against compatible
instead.

> +{
> +	struct device_node *node;
> +	const unsigned int *fp;
> +	unsigned int val = 0;
> +
> +	node = of_find_node_by_type(NULL, "soc");

Once again; don't look for device_type == "soc".  Use compatible.

> +	if (node) {
> +		fp = of_get_property(node, clockname, NULL);
> +		if (fp)
> +			val = of_read_ulong(fp, 1);
> +	}
> +	return val;
> +}
> +
> +static void ref_clk_calc(struct clk *clk)
> +{
> +	unsigned long rate;
> +
> +	rate = devtree_getfreq("soc", "ref-frequency");
> +	if (rate == 0) {
> +		/*
> +		 * no reference clock in device tree
> +		 * get ips clock freq and go backwards from there
> +		 */
> +		rate = devtree_getfreq("soc", "bus-frequency");
> +		if (rate == 0) {
> +			printk(KERN_WARNING
> +				"No bus-frequency in dev tree using 66MHz\n");
> +			clk->rate = 66000000;

Is it even worth trying to use a default here?  I think it should fail
loudly instead to reduce the risk of people shipping boards with badly
formed device trees.  I don't think there is any backwards compatibility
need for doing this.
