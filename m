Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5A2F41007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 Nov 2009 09:17:43 +1100 (EST)
In-Reply-To: <1258927311-4340-19-git-send-email-albert_herranz@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-13-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-14-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-15-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-16-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-17-git-se! nd-email-albert_herranz@yahoo.es>
	<1258927311-4340-18-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-19-git-send-email-albert_herranz@yahoo.es>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <89DF2875-BF4F-4DE1-AB18-C09DFFABCA00@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 18/19] powerpc: wii: platform support
Date: Tue, 24 Nov 2009 23:24:27 +0100
To: Albert Herranz <albert_herranz@yahoo.es>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/ 
> powerpc/platforms/embedded6xx/wii.c

> +#define DRV_MODULE_NAME "rvl"

Should this be "wii"?

> +static enum starlet_ipc_flavour starlet_ipc_flavour;
> +
> +enum starlet_ipc_flavour starlet_get_ipc_flavour(void)
> +{
> +	return starlet_ipc_flavour;
> +}

This can go I think, unless you plan on supporting something else  
than mini?

> +#ifdef CONFIG_STARLET_MINI
> +
> +#define HW_RESETS_OF_COMPATIBLE	"nintendo,hollywood-resets"
> +#define HW_GPIO_ALIAS		"hw_gpio

This should be unconditional now I think?  You access the hardware  
directly.

> +	np = of_find_node_by_name(NULL, "aliases");
> +	if (!np) {
> +		pr_err("unable to find node %s\n", "aliases");
> +		goto out;
> +	}
> +
> +	path = of_get_property(np, HW_GPIO_ALIAS, NULL);
> +	of_node_put(np);
> +	if (!path) {
> +		pr_err("alias %s unknown\n", HW_GPIO_ALIAS);
> +		goto out;
> +	}

Don't use an alias here, search for e.g. a matching "compatible"  
instead.

> +static struct of_device_id wii_of_bus[] = {
> +	{ .compatible = "nintendo,hollywood", },

Like with Flipper, why a platform bus?

> +#ifdef CONFIG_STARLET_MINI
> +	{ .compatible = "twiizers,starlet-mini-ipc", },
> +#endif

This one should go completely, I will have more to say about it when  
I get
to review the device trees (saving those for last :-) ).


Segher
