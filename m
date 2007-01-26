Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0E84EDE04F
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 13:54:48 +1100 (EST)
Date: Fri, 26 Jan 2007 03:54:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Krafft <krafft@de.ibm.com>
Subject: Re: [patch 1/1] updated version, fixed the compiler warning
Message-ID: <20070126025431.GC18537@lst.de>
References: <20061218163846.337fed65@localhost> <45882913.2000609@acm.org>
	<20061220154517.6341fce6@localhost>
	<200612210111.28186.arnd@arndb.de>
	<20070125104540.65a1f557@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070125104540.65a1f557@localhost>
Cc: Christian@ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	openipmi-developer@lists.sourceforge.net,
	Krafft <krafft@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 25, 2007 at 10:45:40AM +1100, Christian Krafft wrote:
> This patch adds support for of_platform_driver to the ipmi_si module.
> When loading the module, the driver will be registered to of_platform.
> The driver will be probed for all devices with the type ipmi. It's supporting
> devices with compatible settings ipmi-kcs, ipmi-smic and ipmi-bt.
> Only ipmi-kcs could be tested.
> 
> Signed-off-by: Christian Krafft <krafft@de.ibm.com>
> Acked-by: Heiko J Schick <schihei@de.ibm.com>
> 
> Index: linux/drivers/char/ipmi/ipmi_si_intf.c
> ===================================================================
> --- linux.orig/drivers/char/ipmi/ipmi_si_intf.c
> +++ linux/drivers/char/ipmi/ipmi_si_intf.c
> @@ -9,6 +9,7 @@
>   *         source@mvista.com
>   *
>   * Copyright 2002 MontaVista Software Inc.
> + * Copyright 2006 IBM Corp., Christian Krafft <krafft@de.ibm.com>
>   *
>   *  This program is free software; you can redistribute it and/or modify it
>   *  under the terms of the GNU General Public License as published by the
> @@ -64,6 +65,11 @@
>  #include <linux/string.h>
>  #include <linux/ctype.h>
>  
> +#ifdef CONFIG_PPC_OF
> +#include <asm/of_device.h>
> +#include <asm/of_platform.h>
> +#endif

Adding this OF-specific code to the generic file doesn't look exactly
nice.  Is it possible to separate the code out to a separate ipmi_of.c
file?

> +static int __devexit ipmi_of_remove(struct of_device *dev)
> +{
> +	/* should call
> +	 * cleanup_one_si(dev->dev.driver_data); */

Wo why doesn't it do that currently? :-)
