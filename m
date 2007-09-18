Return-Path: <dgibson@ozlabs.org>
Date: Tue, 18 Sep 2007 16:11:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 01/28] CPM: Change from fsl,
	brg-frequency to brg/clock-frequency
Message-ID: <20070918061141.GE30766@localhost.localdomain>
References: <20070917165643.GA6545@loki.buserror.net>
	<20070917165728.GA6563@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070917165728.GA6563@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 17, 2007 at 11:57:28AM -0500, Scott Wood wrote:
> As suggested by David Gibson, now that we have a separate node
> for the baud rate generators, it's better to use the standard
> clock-frequency property than a cpm-node-level fsl,brg-frequency
> property.
> 
> This patch updates existing places where fsl,brg-frequency is
> used.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>

[snip]
> diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
> index d028e8d..3052366 100644
> --- a/arch/powerpc/sysdev/fsl_soc.c
> +++ b/arch/powerpc/sysdev/fsl_soc.c
> @@ -73,22 +73,26 @@ static u32 brgfreq = -1;
>  u32 get_brgfreq(void)
>  {
>  	struct device_node *node;
> +	const unsigned int *prop;
> +	int size;
>  
>  	if (brgfreq != -1)
>  		return brgfreq;
>  
> -	node = of_find_compatible_node(NULL, NULL, "fsl,cpm1");
> -	if (!node)
> -		node = of_find_compatible_node(NULL, NULL, "fsl,cpm2");
> -	if (!node)
> -		node = of_find_node_by_type(NULL, "cpm");
> +	node = of_find_compatible_node(NULL, NULL, "fsl,cpm-brg");
>  	if (node) {
> -		int size;
> -		const unsigned int *prop;
> +		prop = of_get_property(node, "clock-frequency", &size);
> +		if (prop && size == 4)
> +			brgfreq = *prop;
>  
> -		prop = of_get_property(node, "fsl,brg-frequency", &size);
> -		if (!prop)
> -			prop = of_get_property(node, "brg-frequency", &size);
> +		of_node_put(node);
> +		return brgfreq;
> +	}
> +
> +	/* Legacy device binding -- will go away when no users are left. */
> +	node = of_find_node_by_type(NULL, "cpm");
> +	if (node) {
> +		prop = of_get_property(node, "brg-frequency", &size);

Shouldn't you check for "fsl,brg-frequency" here, in case of old
device trees?

>  		if (prop && size == 4)
>  			brgfreq = *prop;
>  

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
