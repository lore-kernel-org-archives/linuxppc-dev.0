Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AB8EBDDF0A
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 07:19:24 +1100 (EST)
Date: Thu, 24 Jan 2008 14:19:39 -0600
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] 85xx: Port STX GP3 board over from arch/ppc
Message-ID: <20080124201939.GB3926@loki.buserror.net>
References: <Pine.LNX.4.64.0801240041530.22238@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0801240041530.22238@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 24, 2008 at 12:43:38AM -0600, Kumar Gala wrote:
> +			d-cache-size = <0x8000>;	// L1, 32K
> +			i-cache-size = <0x8000>;	// L1, 32K
> +			timebase-frequency = <0x4ead9a0>;
> +			bus-frequency = <0x13ab6680>;
> +			clock-frequency = <0x312c8040>;

Decimal, please.

> +	soc8560@fdf00000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		device_type = "soc";
> +		ranges = <0 0xfdf00000 0x100000>;
> +		reg = <0xfdf00000 0x1000>;

compatible = "fsl,mpc8560-immr", "simple-bus".
Also add "simple-bus" to the CPM node.

> +		bus-frequency = <0x13ab6680>;

Decimal, please -- if it needs to exist at all.

> @@ -49,7 +57,7 @@ config MPC8540
>  config MPC8560
>  	bool
>  	select CPM2
> -	default y if MPC8560_ADS
> +	default y if MPC8560_ADS || STX_GP3

Can we select this from 8560 boards, instead of a default y list?

> +static struct of_device_id __initdata of_bus_ids[] = {
> +	{ .name = "soc", },
> +	{ .type = "soc", },
> +	{ .name = "cpm", },
> +	{ .name = "localbus", },
> +	{},
> +};

compatible = "simple-bus".

> +/*
> + * Called very early, device-tree isn't unflattened
> + */
> +static int __init stx_gp3_probe(void)
> +{
> +        unsigned long root = of_get_flat_dt_root();
> +
> +        return of_flat_dt_is_compatible(root, "stx,gp3-8560");
> +}

Tabs, not spaces.

-Scott
