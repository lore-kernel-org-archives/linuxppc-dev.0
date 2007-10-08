Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E2B44DDF86
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 01:04:39 +1000 (EST)
Date: Mon, 8 Oct 2007 10:04:49 -0500
From: Scott Wood <scottwood@freescale.com>
To: Marian Balakowicz <m8@semihalf.com>
Subject: Re: [POWERPC 03/15] [POWERPC] TQM5200 board support
Message-ID: <20071008150449.GB4289@loki.buserror.net>
References: <47075FA7.3030108@semihalf.com> <4708C0DA.2040606@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4708C0DA.2040606@semihalf.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Oct 07, 2007 at 01:19:54PM +0200, Marian Balakowicz wrote:
> +	np = of_find_node_by_type(NULL, "cpu");
> +	if (np) {
> +		unsigned int *fp =
> +		    (int *)of_get_property(np, "clock-frequency", NULL);
> +		if (fp != 0)
> +			loops_per_jiffy = *fp / HZ;
> +		else
> +			loops_per_jiffy = 50000000 / HZ;
> +		of_node_put(np);
> +	}

This is unnecessary legacy cruft.

> +#ifdef CONFIG_PCI
> +	np = of_find_node_by_type(NULL, "pci");
> +	if (np) {
> +		mpc52xx_add_bridge(np);
> +		of_node_put(np);
> +	}
> +#endif

You should check for a specific compatible, so that you don't match
PCI-to-PCI bridges.

> +#ifdef CONFIG_BLK_DEV_INITRD
> +	if (initrd_start)
> +		/*
> +		 * We want the proper initrd behavior, i.e., launching of
> +		 * /linuxrc from the initial root file system, and not only
> +		 * mounting it as the normal root file system.
> +		 */
> +		ROOT_DEV = 0x0;
> +	else
> +#endif
> +#ifdef  CONFIG_ROOT_NFS
> +		ROOT_DEV = Root_NFS;
> +#else
> +		ROOT_DEV = Root_HDA1;
> +#endif

More legacy cruft.

> +void tqm5200_show_cpuinfo(struct seq_file *m)
> +{
> +	struct device_node* np = of_find_all_nodes(NULL);
> +	const char *model = NULL;
> +
> +	if (np)
> +		model = of_get_property(np, "model", NULL);
> +
> +	seq_printf(m, "vendor\t\t:	Freescale Semiconductor\n");
> +	seq_printf(m, "machine\t\t:	%s\n", model ? model : "unknown");
> +
> +	of_node_put(np);
> +}

Get rid of this.

-Scott
