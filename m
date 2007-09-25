Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id A0E67DDEBD
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 00:47:23 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/5] ibmebus: Add device creation and bus probing based on
	of_device
Date: Tue, 25 Sep 2007 16:39:05 +0200
References: <200709251410.29780.fenkes@de.ibm.com>
	<200709251412.27896.fenkes@de.ibm.com>
In-Reply-To: <200709251412.27896.fenkes@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709251639.06414.arnd@arndb.de>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	Paul Mackerras <pmac@au1.ibm.com>, Joachim Fenkes <fenkes@de.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>, Christoph Raisch <raisch@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 25 September 2007, Joachim Fenkes wrote:
> The devtree root is now searched for devices matching a built-in whitelist
> during boot, so these devices appear on the bus from the beginning. It is
> still possible to manually add/remove devices to/from the bus by using the
> probe/remove sysfs interface. Also, when a device driver registers itself,
> the devtree is matched against its matchlist.
> 
> Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
> ---
>  arch/powerpc/kernel/ibmebus.c |   97 ++++++++++++++++++++++++++++++++++-------
>  1 files changed, 81 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/ibmebus.c b/arch/powerpc/kernel/ibmebus.c
> index cc80f84..c506e0d 100644
> --- a/arch/powerpc/kernel/ibmebus.c
> +++ b/arch/powerpc/kernel/ibmebus.c
> @@ -51,6 +51,15 @@ static struct device ibmebus_bus_device = { /* fake "parent" device */
>  
>  struct bus_type ibmebus_bus_type;
>  
> +/* These devices will automatically be added to the bus during init */
> +static struct of_device_id builtin_matches[] = {
> +	{ .name = "lhca" },
> +	{ .compatible = "IBM,lhca" },
> +	{ .name = "lhea" },
> +	{ .compatible = "IBM,lhea" },
> +	{},
> +};
> +

Hmm, do you have devices that only have the matching name property
but not the compatible property? If not, I'd suggest only looking
for compatible, so you have less chance of false positives.

> +static int ibmebus_create_device(struct device_node *dn)
> +{
> +	struct of_device *dev;
> +	int ret;
> +
> +	dev = of_device_alloc(dn, NULL, &ibmebus_bus_device);
> +	if (!dev)
> +		return -ENOMEM;
> +
> +	dev->dev.bus = &ibmebus_bus_type;
> +	dev->dev.archdata.dma_ops = &ibmebus_dma_ops;
> +
> +	ret = of_device_register(dev);
> +	if (ret) {
> +		of_device_free(dev);
> +		return ret;
> +	}
> +
> +	return 0;
> +}

nice!

> @@ -219,9 +276,9 @@ static ssize_t ibmebus_store_probe(struct bus_type *bus,
>  	}
>  
>  	if ((dn = of_find_node_by_path(path))) {
> -/*		dev = ibmebus_register_device_node(dn); */
> +		rc = ibmebus_create_device(dn);
>  		of_node_put(dn);
> -		rc = IS_ERR(dev) ? PTR_ERR(dev) : count;
> +		rc = rc ? rc : count;

the last line looks a bit silly. Maybe instead do

		rc = ibmebus_create_device(dn);
  		of_node_put(dn);
	}

	kfree(path);
	if (rc)
		return rc;
	return count;
}
