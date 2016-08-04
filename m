Return-Path: <cyrilbur@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4hPR31XpzDqQs
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 17:28:27 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id i6so16928670pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Aug 2016 00:28:27 -0700 (PDT)
Date: Thu, 4 Aug 2016 17:27:27 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: Jack Miller <jack@codezen.org>, linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, stewart@linux.vnet.ibm.com, jk@ozlabs.org
Subject: Re: [PATCH v2] powernv: Simplify searching for compatible device nodes
Message-ID: <20160804172727.55e81056@camb691>
In-Reply-To: <20160803171800.8999-1-jack@codezen.org>
References: <20160803164412.7039-1-jack@codezen.org>
 <20160803171800.8999-1-jack@codezen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed,  3 Aug 2016 12:18:00 -0500
Jack Miller <jack@codezen.org> wrote:

> (rebased on powerpc/next)
> 
> This condenses the opal node searching into a single function that finds
> all compatible nodes, instead of just searching the ibm,opal children,
> for ipmi, flash, and prd similar to how opal-i2c nodes are found.
> 
> Signed-off-by: Jack Miller <jack@codezen.org>

Using a version of the related skiboot patch that may not be the final one:
Tested-by: Cyril Bur <cyrilbur@gmail.com>

> ---
>  arch/powerpc/platforms/powernv/opal.c | 24 +++++++-----------------
>  1 file changed, 7 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 8b4fc68..9db12ce 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -631,21 +631,11 @@ static void __init opal_dump_region_init(void)
>  			"rc = %d\n", rc);
>  }
>  
> -static void opal_pdev_init(struct device_node *opal_node,
> -		const char *compatible)
> +static void opal_pdev_init(const char *compatible)
>  {
>  	struct device_node *np;
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
>  		of_platform_device_create(np, NULL, NULL);
>  }
>  
> @@ -717,7 +707,7 @@ static int __init opal_init(void)
>  	opal_hmi_handler_init();
>  
>  	/* Create i2c platform devices */
> -	opal_i2c_create_devs();
> +	opal_pdev_init("ibm,opal-i2c");
>  
>  	/* Setup a heatbeat thread if requested by OPAL */
>  	opal_init_heartbeat();
> @@ -752,12 +742,12 @@ static int __init opal_init(void)
>  	}
>  
>  	/* Initialize platform devices: IPMI backend, PRD & flash interface */
> -	opal_pdev_init(opal_node, "ibm,opal-ipmi");
> -	opal_pdev_init(opal_node, "ibm,opal-flash");
> -	opal_pdev_init(opal_node, "ibm,opal-prd");
> +	opal_pdev_init("ibm,opal-ipmi");
> +	opal_pdev_init("ibm,opal-flash");
> +	opal_pdev_init("ibm,opal-prd");
>  
>  	/* Initialise platform device: oppanel interface */
> -	opal_pdev_init(opal_node, "ibm,opal-oppanel");
> +	opal_pdev_init("ibm,opal-oppanel");
>  
>  	/* Initialise OPAL kmsg dumper for flushing console on panic */
>  	opal_kmsg_init();
