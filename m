Return-Path: <cyrilbur@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3szLpR0rNnzDvHC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 16:58:23 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id i85so1474454pfa.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2016 22:58:23 -0700 (PDT)
Message-ID: <1476856695.860.2.camel@gmail.com>
Subject: Re: [PATCH v2] powernv: Simplify searching for compatible device nodes
From: Cyril Bur <cyrilbur@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: stable@vger.kernel.org, Jack Miller <jack@codezen.org>,
 stewart@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Date: Wed, 19 Oct 2016 16:58:15 +1100
In-Reply-To: <20160811003240.19748-1-jack@codezen.org>
References: <20160811003240.19748-1-jack@codezen.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-08-10 at 19:32 -0500, Jack Miller wrote:
> This condenses the opal node searching into a single function that
> finds
> all compatible nodes, instead of just searching the ibm,opal
> children,
> for ipmi, flash, and prd similar to how opal-i2c nodes are found.
> 

Hi Michael,

It seems this patch hasn't made it in. Without it linux cannot find the
flash on p9 as skiboot has moved the node to a more appropriate place.

Thanks,

Cyril

Cc: stable@vger.kernel.org # v4.6+

> Signed-off-by: Jack Miller <jack@codezen.org>
> ---
>  arch/powerpc/platforms/powernv/opal.c | 24 +++++++-----------------
>  1 file changed, 7 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/opal.c
> b/arch/powerpc/platforms/powernv/opal.c
> index 8b4fc68..9db12ce 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -631,21 +631,11 @@ static void __init opal_dump_region_init(void)
>  			"rc = %d\n", rc);
>  }
>  
> -static void opal_pdev_init(struct device_node *opal_node,
> -		const char *compatible)
> +static void opal_pdev_init(const char *compatible)
>  {
>  	struct device_node *np;
>  
> -	for_each_child_of_node(opal_node, np)
> -		if (of_device_is_compatible(np, compatible))
> -			of_platform_device_create(np, NULL, NULL);
> -}
> -
> -static void opal_i2c_create_devs(void)
> -{
> -	struct device_node *np;
> -
> -	for_each_compatible_node(np, NULL, "ibm,opal-i2c")
> +	for_each_compatible_node(np, NULL, compatible)
>  		of_platform_device_create(np, NULL, NULL);
>  }
>  
> @@ -717,7 +707,7 @@ static int __init opal_init(void)
>  	opal_hmi_handler_init();
>  
>  	/* Create i2c platform devices */
> -	opal_i2c_create_devs();
> +	opal_pdev_init("ibm,opal-i2c");
>  
>  	/* Setup a heatbeat thread if requested by OPAL */
>  	opal_init_heartbeat();
> @@ -752,12 +742,12 @@ static int __init opal_init(void)
>  	}
>  
>  	/* Initialize platform devices: IPMI backend, PRD & flash
> interface */
> -	opal_pdev_init(opal_node, "ibm,opal-ipmi");
> -	opal_pdev_init(opal_node, "ibm,opal-flash");
> -	opal_pdev_init(opal_node, "ibm,opal-prd");
> +	opal_pdev_init("ibm,opal-ipmi");
> +	opal_pdev_init("ibm,opal-flash");
> +	opal_pdev_init("ibm,opal-prd");
>  
>  	/* Initialise platform device: oppanel interface */
> -	opal_pdev_init(opal_node, "ibm,opal-oppanel");
> +	opal_pdev_init("ibm,opal-oppanel");
>  
>  	/* Initialise OPAL kmsg dumper for flushing console on panic
> */
>  	opal_kmsg_init();
