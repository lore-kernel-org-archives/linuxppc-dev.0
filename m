Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 0AB39DDF4E
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 01:19:31 +1000 (EST)
Date: Wed, 21 May 2008 19:19:29 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/4] spi: Add OF binding support for SPI busses
Message-ID: <20080521151928.GA28857@polina.dev.rtsoft.ru>
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
	<20080516193613.28030.13950.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080516193613.28030.13950.stgit@trillian.secretlab.ca>
Cc: fabrizio.garetto@gmail.com, linuxppc-dev@ozlabs.org,
	dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 16, 2008 at 01:36:13PM -0600, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> This patch adds support for populating an SPI bus based on data in the
> OF device tree.  This is useful for powerpc platforms which use the
> device tree instead of discrete code for describing platform layout.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
[...]
> diff --git a/drivers/spi/spi_of.c b/drivers/spi/spi_of.c
> new file mode 100644
> index 0000000..b5ae434
> --- /dev/null
> +++ b/drivers/spi/spi_of.c
> @@ -0,0 +1,86 @@
> +/*

I think better placement for this is drivers/of, no?

> + * SPI OF support routines
> + * Copyright (C) 2008 Secret Lab Technologies Ltd.
> + *
> + * Support routines for deriving SPI device attachments from the device
> + * tree.
> + */
> +
> +#include <linux/of.h>
> +#include <linux/device.h>
> +#include <linux/spi/spi.h>
> +#include <linux/spi/spi_of.h>
> +
> +/**
> + * spi_of_register_devices - Register child devices onto the SPI bus
> + * @master:	Pointer to spi_master device
> + * @np:		parent node of SPI device nodes
> + *
> + * Registers an spi_device for each child node of 'np' which has a 'reg'
> + * property.
> + */
> +void spi_of_register_devices(struct spi_master *master, struct device_node *np)
> +{
> +	struct spi_device *spi;
> +	struct device_node *nc;
> +	const u32 *prop;
> +	const char *sprop;
> +	int rc;
> +	int len;
> +
> +	for_each_child_of_node(np, nc) {
> +		/* Alloc an spi_device */
> +		spi = spi_alloc_device(master);
> +		if (!spi) {
> +			dev_err(&master->dev, "spi_device alloc error for %s\n",
> +				np->full_name);
> +			continue;
> +		}
> +
> +		/* Device address */
> +		prop = of_get_property(nc, "reg", &len);
> +		if (!prop || len < sizeof(*prop)) {
> +			dev_err(&master->dev, "%s has no 'reg' property\n",
> +				np->full_name);

Should be nc->full_name.

> +			continue;
> +		}
[...]

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
