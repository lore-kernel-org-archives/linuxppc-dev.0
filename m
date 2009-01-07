Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 81EF6DE71F
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 06:07:31 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n07J7JkW002166
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jan 2009 12:07:19 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n07J7Ip9015600
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jan 2009 13:07:18 -0600 (CST)
Date: Wed, 7 Jan 2009 13:07:18 -0600
From: Scott Wood <scottwood@freescale.com>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
Subject: Re: [PATCH 1/5] powerpc: Add platform support for AmigaOne
Message-ID: <20090107190718.GA17427@ld0162-tx32.am.freescale.net>
References: <20090107135457.234150@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090107135457.234150@gmx.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 07, 2009 at 02:54:57PM +0100, Gerhard Pircher wrote:
> +void amigaone_show_cpuinfo(struct seq_file *m)
> +{
> +	struct device_node *root;
> +	const char *model = "";
> +
> +	root = of_find_node_by_path("/");
> +	if (root)
> +		model = of_get_property(root, "model", NULL);
> +	seq_printf(m, "machine\t\t: %s\n", model);
> +
> +	of_node_put(root);
> +	return;

This is already printed by the generic cpuinfo.

> +void __init amigaone_setup_arch(void)
> +{
> +	struct device_node *np;
> +
> +	/* Initialization until calibrate_delay() runs. */
> +	loops_per_jiffy = 50000000/HZ;

Is this really necessary?

> +	/* Flush and disable I/D cache. */
> +	__asm__ __volatile__ ("mfspr	3, 1008"	::: "r3");
> +	__asm__ __volatile__ ("ori	5, 5, 0xcc00"	::: "r5");
> +	__asm__ __volatile__ ("ori	4, 3, 0xc00"	::: "r4");
> +	__asm__ __volatile__ ("andc	5, 3, 5"	::: "r5");

Don't do this; instead, have one multi-line asm statement (or better yet,
just use mfspr()/mtspr()/sync()/isync()).

GCC is perfectly free to trash your registers in between statements.

-Scott
