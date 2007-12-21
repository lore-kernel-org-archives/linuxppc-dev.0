Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 1AA2BDDFE4
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 08:16:51 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/4] [POWERPC] CPM2: implement GPIO API
Date: Fri, 21 Dec 2007 22:16:32 +0100
References: <20071221202824.GA4607@localhost.localdomain>
	<20071221203123.GC4633@localhost.localdomain>
In-Reply-To: <20071221203123.GC4633@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712212216.32922.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 21 December 2007, Anton Vorontsov wrote:
>  
> +static spinlock_t cpm2_port_lock = __SPIN_LOCK_UNLOCKED(cpm2_port_lock);

This needs to be

static DEFINE_SPINLOCK(cpm2_port_lock);

I think at least lockdep doesn't work the way you do it here.

> +int cpm2_init_par_io(void)
> +{
> +	struct device_node *np;
> +	const u32 *num_ports;
> +
> +	np = of_find_compatible_node(NULL, NULL, "fsl,cpm2-pario");
> +	if (!np)
> +		return -ENOENT;
> +
> +	num_ports = of_get_property(np, "num-ports", NULL);
> +	if (!num_ports) {
> +		of_node_put(np);
> +		return -ENOENT;
> +	}
> +	cpm2_num_ports = *num_ports;
> +
> +	np->data = &of_gpio_chip;
> +
> +	return 0;
> +}

This function should also do the call to of_iomap, so you don't
need to pull the address out of the cpm2_immr, which I believe
we're trying to get rid of.

	Arnd <><
