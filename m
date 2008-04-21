Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BE4A5DDE25
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 04:24:13 +1000 (EST)
Date: Mon, 21 Apr 2008 11:23:57 -0700
From: Dale Farnsworth <dale@farnsworth.org>
To: Remi Machet <rmachet@slac.stanford.edu>
Message-ID: <20080421182357.GB12468@farnsworth.org>
References: <1208799434.5789.53.camel@pcds-ts102.slac.stanford.edu>
MIME-Version: 1.0
In-Reply-To: <1208799434.5789.53.camel@pcds-ts102.slac.stanford.edu>
Subject: Re: [PATCH 2/2 v2] sysdev,mv64x60: initialization of mv64x60
	ethernet, serial and I2C
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 21, 2008 at 10:37:14AM -0700, Remi Machet wrote:
> If one of the devices of the mv64x60 init fails, the remaining 
> devices are not initialized => This patch change the code to 
> display an error and continue the initialization.
> 
> Signed-off-by: Remi Machet (rmachet@slac.stanford.edu)
> ---
> This is the second part of the re-submission of my patch of 4/17/2008
> titled "[PATCH] sysdev,mv64x60: initialization of mv64x60 ethernet, 
> serial and I2C"
> 
> --- a/arch/powerpc/sysdev/mv64x60_dev.c
> +++ b/arch/powerpc/sysdev/mv64x60_dev.c
> @@ -431,9 +431,14 @@ static int __init mv64x60_device_setup(void)
>  	int err;
>  
>  	id = 0;
> -	for_each_compatible_node(np, "serial", "marvell,mv64360-mpsc")
> -		if ((err = mv64x60_mpsc_device_setup(np, id++)))
> -			goto error;
> +	for_each_compatible_node(np, "serial", "marvell,mv64360-mpsc") {
> +		err = mv64x60_mpsc_device_setup(np, id++);
> +		if (err) {
> +			printk(KERN_ERR "Failed to initialize MV64x60 " \

No need for the backslash continuation above.  Also below.

> +					"serial device %s: error %d.\n",
> +					np->full_name, err);
> +		};

You don't need the braces around the single printk statement.

> +	};

No need for the semi-colon following closing brace, also below.

>  
>  	id = 0;
>  	id2 = 0;
> @@ -441,38 +446,46 @@ static int __init mv64x60_device_setup(void)
>  		pdev = mv64x60_eth_register_shared_pdev(np, id++);
>  		if (IS_ERR(pdev)) {
>  			err = PTR_ERR(pdev);
> -			goto error;
> -		}
> +			printk(KERN_ERR "Failed to initialize MV64x60 " \
> +					"network block %s: error %d.\n",
> +					np->full_name, err);
> +			continue;
> +		};
>  		for_each_child_of_node(np, np2) {
>  			if (!of_device_is_compatible(np2,
>  					"marvell,mv64360-eth"))
>  				continue;
>  			err = mv64x60_eth_device_setup(np2, id2++, pdev);
>  			if (err) {
> -				of_node_put(np2);
> -				goto error;
> +				printk(KERN_ERR "Failed to initialize " \
> +						"MV64x60 network device %s: " \
> +						"error %d.\n",
> +						np2->full_name, err);
>  			}
>  		}
>  	}
>  
>  	id = 0;
> -	for_each_compatible_node(np, "i2c", "marvell,mv64360-i2c")
> -		if ((err = mv64x60_i2c_device_setup(np, id++)))
> -			goto error;
> +	for_each_compatible_node(np, "i2c", "marvell,mv64360-i2c") {
> +		err = mv64x60_i2c_device_setup(np, id++);
> +		if (err) {
> +			printk(KERN_ERR "Failed to initialize MV64x60 I2C " \
> +					"bus %s: error %d.\n",
> +					np->full_name, err);
> +		};
> +	};
>  
>  	/* support up to one watchdog timer */
>  	np = of_find_compatible_node(np, NULL, "marvell,mv64360-wdt");
>  	if (np) {
>  		if ((err = mv64x60_wdt_device_setup(np, id)))
> -			goto error;
> +			printk(KERN_ERR "Failed to initialize MV64x60 " \
> +					"Watchdog %s: error %d.\n",
> +					np->full_name, err);
>  		of_node_put(np);
>  	}
>  
>  	return 0;
> -
> -error:
> -	of_node_put(np);
> -	return err;
>  }
>  arch_initcall(mv64x60_device_setup);
