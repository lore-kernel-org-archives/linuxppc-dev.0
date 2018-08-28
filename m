Return-Path: <peda@axentia.se>
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr50126.outbound.protection.outlook.com [40.107.5.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41zzTt2wLGzDqC3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 16:33:15 +1000 (AEST)
Subject: Re: [PATCH] i2c: Convert to using %pOFn instead of device_node.name
To: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-i2c@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-21-robh@kernel.org>
From: Peter Rosin <peda@axentia.se>
Message-ID: <3fa33583-f748-1708-2274-0a6f4e81004b@axentia.se>
Date: Tue, 28 Aug 2018 08:33:03 +0200
MIME-Version: 1.0
In-Reply-To: <20180828015252.28511-21-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2018-08-28 03:52, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Peter Rosin <peda@axentia.se>
> Cc: linux-i2c@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/i2c/busses/i2c-powermac.c | 15 ++++++++-------
>  drivers/i2c/muxes/i2c-mux-gpmux.c |  4 ++--
>  2 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c-powermac.c
> index f2a2067525ef..b706fd136ca5 100644
> --- a/drivers/i2c/busses/i2c-powermac.c
> +++ b/drivers/i2c/busses/i2c-powermac.c
> @@ -390,7 +390,6 @@ static int i2c_powermac_probe(struct platform_device *dev)
>  	struct pmac_i2c_bus *bus = dev_get_platdata(&dev->dev);
>  	struct device_node *parent = NULL;

Lose the initializer...

>  	struct i2c_adapter *adapter;
> -	const char *basename;
>  	int rc;
>  
>  	if (bus == NULL)
> @@ -407,23 +406,25 @@ static int i2c_powermac_probe(struct platform_device *dev)
>  		parent = of_get_parent(pmac_i2c_get_controller(bus));
>  		if (parent == NULL)
>  			return -EINVAL;
> -		basename = parent->name;
> +		snprintf(adapter->name, sizeof(adapter->name), "%pOFn %d", 
> +			 parent,
> +			 pmac_i2c_get_channel(bus));

...and I would have written "parent, pmac_i2c_get_channel(bus));" on one line,
but maybe that's just me.

Anyway, with the initializer fix,

Reviewed-by: Peter Rosin <peda@axentia.se>

(Wolfram, no need to split this, just take it in full.)

Cheers,
Peter

> +		of_node_put(parent);
>  		break;
>  	case pmac_i2c_bus_pmu:
> -		basename = "pmu";
> +		snprintf(adapter->name, sizeof(adapter->name), "pmu %d",
> +			 pmac_i2c_get_channel(bus));
>  		break;
>  	case pmac_i2c_bus_smu:
>  		/* This is not what we used to do but I'm fixing drivers at
>  		 * the same time as this change
>  		 */
> -		basename = "smu";
> +		snprintf(adapter->name, sizeof(adapter->name), "smu %d",
> +			 pmac_i2c_get_channel(bus));
>  		break;
>  	default:
>  		return -EINVAL;
>  	}
> -	snprintf(adapter->name, sizeof(adapter->name), "%s %d", basename,
> -		 pmac_i2c_get_channel(bus));
> -	of_node_put(parent);
>  
>  	platform_set_drvdata(dev, adapter);
>  	adapter->algo = &i2c_powermac_algorithm;
> diff --git a/drivers/i2c/muxes/i2c-mux-gpmux.c b/drivers/i2c/muxes/i2c-mux-gpmux.c
> index 92cf5f48afe6..f60b670deff7 100644
> --- a/drivers/i2c/muxes/i2c-mux-gpmux.c
> +++ b/drivers/i2c/muxes/i2c-mux-gpmux.c
> @@ -120,8 +120,8 @@ static int i2c_mux_probe(struct platform_device *pdev)
>  
>  		ret = of_property_read_u32(child, "reg", &chan);
>  		if (ret < 0) {
> -			dev_err(dev, "no reg property for node '%s'\n",
> -				child->name);
> +			dev_err(dev, "no reg property for node '%pOFn'\n",
> +				child);
>  			goto err_children;
>  		}
>  
> 
