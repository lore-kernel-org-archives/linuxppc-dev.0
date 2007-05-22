Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 36391DDE17
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 07:08:28 +1000 (EST)
Date: Tue, 22 May 2007 23:08:25 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 10/13] mpc83xx: Power Management support
In-Reply-To: <20070507182955.GI26920@ld0162-tx32.am.freescale.net>
Message-ID: <Pine.LNX.4.60.0705222301070.4243@poirot.grange>
References: <20070507182955.GI26920@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 7 May 2007, Scott Wood wrote:

> diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
> index 3b99433..1fd9f51 100644
> --- a/arch/powerpc/sysdev/fsl_soc.c
> +++ b/arch/powerpc/sysdev/fsl_soc.c
> @@ -138,6 +138,33 @@ u32 get_baudrate(void)
>  EXPORT_SYMBOL(get_baudrate);
>  #endif /* CONFIG_CPM2 */
>  
> +int fsl_sleep_init(struct fsl_sleep_platform_data *sleep,
> +                   struct device_node *node)
> +{
> +	int proplen, ret = -ENODEV;
> +	const u32 *sleepdata = of_get_property(node, "sleep", &proplen);
> +	struct device_node *sleep_controller;
> +
> +	if (!sleepdata || proplen != 8)
> +		return -ENODEV;
> +
> +	sleep_controller = of_find_node_by_phandle(sleepdata[0]);
> +	if (!sleep_controller)
> +		return -ENODEV;
> +
> +	/* There can only be one fsl,mpc83xx-pmc device in the system;
> +	 * it is assumed that it is the one that the pmc driver matches.
> +	 */
> +	if (of_device_is_compatible(sleep_controller, "fsl,mpc83xx-pmc")) {
> +		sleep->sccr_mask = sleepdata[1];
> +		ret = 0;
> +	}

Just wondering - do we really want to special-case 83xx-pmc here? What 
when / if further "sleep controllers" get implemented? Shouldn't this be 
some callback?

BTW, do we have an interface similar to platform-driver/device for of? 
Like of_driver/device. This would be a use case for it. Just register a 
of_driver, which would trigger a dt-scan (just a find_compatible), calling 
driver's probe()... Would it make sense?

Thanks
Guennadi
---
Guennadi Liakhovetski
