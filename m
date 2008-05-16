Return-Path: <cbouatmailru@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.188])
	by ozlabs.org (Postfix) with ESMTP id 8AA18DDE2A
	for <linuxppc-dev@ozlabs.org>; Sat, 17 May 2008 08:03:45 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id e27so432944nfd.9
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 15:03:43 -0700 (PDT)
Date: Sat, 17 May 2008 02:03:38 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/4] spi: Add OF binding support for SPI busses
Message-ID: <20080516220338.GA3255@zarina>
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
	<20080516193613.28030.13950.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080516193613.28030.13950.stgit@trillian.secretlab.ca>
Cc: fabrizio.garetto@gmail.com, linuxppc-dev@ozlabs.org,
	dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
Reply-To: cbouatmailru@gmail.com
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
> +			continue;
> +		}
> +		spi->chip_select = *prop;
> +
> +		/* Mode (clock phase/polarity/etc. */
> +		if (of_find_property(nc, "spi,cpha", NULL))
> +			spi->mode |= SPI_CPHA;
> +		if (of_find_property(nc, "spi,cpol", NULL))
> +			spi->mode |= SPI_CPOL;
> +
> +		/* Device speed */
> +		prop = of_get_property(nc, "max-speed", &len);
> +		if (prop && len >= sizeof(*prop))
> +			spi->max_speed_hz = *prop;
> +		else
> +			spi->max_speed_hz = 100000;
> +
> +		/* IRQ */
> +		spi->irq = irq_of_parse_and_map(nc, 0);
> +
> +		/* Select device driver */
> +		sprop = of_get_property(nc, "linux,modalias", &len);
> +		if (sprop && len > 0)
> +			strncpy(spi->modalias, sprop, KOBJ_NAME_LEN);
> +		else
> +			strncpy(spi->modalias, "spidev", KOBJ_NAME_LEN);
> +
> +		/* Store a pointer to the node in the device structure */
> +		of_node_get(nc);
> +		spi->dev.archdata.of_node = nc;
> +
> +		/* Register the new device */
> +		rc = spi_register_device(spi);
> +		if (rc) {
> +			dev_err(&master->dev, "spi_device register error %s\n",
> +				np->full_name);
> +			spi_device_release(spi);
> +		}

No way to pass platform data... can you suggest any idea to use
this for things like
"[POWERPC] 86xx: mpc8610_hpcd: add support for SPI and MMC-over-SPI"
I've sent just recently...?

Maybe this code could do something like
spi->dev.platform_data = nc->data;
and board code would fill nc->data at early stages? This needs to be a
convention, not just random use though.. Maybe we can expand the struct
device_node to explicitly include .platform_data for such cases?

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
