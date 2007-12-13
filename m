Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D2140DDE2D
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 03:55:42 +1100 (EST)
Date: Thu, 13 Dec 2007 10:55:30 -0600
From: Scott Wood <scottwood@freescale.com>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH/RFC] CPM1: implement GPIO API
Message-ID: <20071213165530.GB4347@loki.buserror.net>
References: <47600F5E.8060907@scram.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47600F5E.8060907@scram.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 12, 2007 at 05:42:06PM +0100, Jochen Friedrich wrote:
> +int cpm_init_par_io(void)
> +{
> +	int ret;
> +	struct device_node *np;
> +	const u32 *num_ports;
> +	int i;
> +
> +	np = of_find_node_by_name(NULL, "par_io");
> +	if (!np) {
> +		ret = -ENOENT;
> +		goto err0;
> +	}

Shouldn't this lookup be by compatible (something like fsl,cpm1-gpio would
be good)?

> +int gpio_request(unsigned int gpio, const char *label)
> +{
> +	if (!cpm1_port_locks)
> +		return -ENODEV;
> +
> +	if (gpio / 32 > cpm1_num_ports)
> +		return -EINVAL;

Shouldn't this be ">="?

> +	return 0;

No already-requested check?

> +}
> +EXPORT_SYMBOL_GPL(gpio_request);

This is an API, not internals; can we stick with plain EXPORT_SYMBOL()?

-Scott
