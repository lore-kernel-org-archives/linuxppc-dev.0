Return-Path: <dale@farnsworth.org>
Date: 17 Aug 2007 09:32:55 -0700
Message-ID: <20070817163255.26694.qmail@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
To: galak@kernel.crashing.org, Linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] [POWERPC] Add interrupt resource for RTC CMOS driver
In-Reply-To: <Pine.LNX.4.64.0708170002400.21006@blarg.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> The RTC CMOS driver expects the interrupt to be a resource of the platform
> device.  Use a fixed interrupt value of 8 since on PPC if we are using this
> its off an i8259 which we ensure has interrupt numbers 0..15.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
>  arch/powerpc/sysdev/rtc_cmos_setup.c |   15 +++++++++++----
>  1 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/rtc_cmos_setup.c
> b/arch/powerpc/sysdev/rtc_cmos_setup.c
> index e276048..1d2be7d 100644
> --- a/arch/powerpc/sysdev/rtc_cmos_setup.c
> +++ b/arch/powerpc/sysdev/rtc_cmos_setup.c
> @@ -20,14 +20,16 @@ static int  __init add_rtc(void)
>  {
>  	struct device_node *np;
>  	struct platform_device *pd;
> -	struct resource res;
> +	struct resource res[2];
>  	int ret;
> 
> +	memset(&res, 0, sizeof(res));
> +
>  	np = of_find_compatible_node(NULL, NULL, "pnpPNP,b00");
>  	if (!np)
>  		return -ENODEV;
> 
> -	ret = of_address_to_resource(np, 0, &res);
> +	ret = of_address_to_resource(np, 0, &res[0]);
>  	of_node_put(np);
>  	if (ret)
>  		return ret;
> @@ -36,11 +38,16 @@ static int  __init add_rtc(void)
>  	 * RTC_PORT(x) is hardcoded in asm/mc146818rtc.h.  Verify that the
>  	 * address provided by the device node matches.
>  	 */
> -	if (res.start != RTC_PORT(0))
> +	if (res[0].start != RTC_PORT(0))
>  		return -EINVAL;
> 
> +	res[1].start = 8;

Please add a comment to the source code (similar to that in changelog)
explaining the reason for the 8.

-Dale Farnsworth
