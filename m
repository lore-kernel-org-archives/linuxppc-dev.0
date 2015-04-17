Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0101.outbound.protection.outlook.com [157.56.111.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DAA241A0028
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Apr 2015 07:39:32 +1000 (AEST)
Date: Fri, 17 Apr 2015 16:39:15 -0500
From: Scott Wood <scottwood@freescale.com>
To: <ying.zhang@freescale.com>
Subject: Re: [3/3] P1021RDB: Add QE TDM support
Message-ID: <20150417213915.GA4847@home.buserror.net>
References: <1427361377-4789-1-git-send-email-ying.zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1427361377-4789-1-git-send-email-ying.zhang@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, Xie Xiaobo <X.Xie@freescale.com>, Ying
 Zhang <b40530@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 26, 2015 at 05:16:17PM +0800, ying.zhang@freescale.com wrote:
> @@ -96,37 +102,63 @@ static void __init mpc85xx_rdb_setup_arch(void)
>  #ifdef CONFIG_QUICC_ENGINE
>  	mpc85xx_qe_init();
>  	mpc85xx_qe_par_io_init();
> -#if defined(CONFIG_UCC_GETH) || defined(CONFIG_SERIAL_QE)
> -	if (machine_is(p1025_rdb)) {
> -		struct device_node *np;
> -
> -		struct ccsr_guts __iomem *guts;
> -
> -		np = of_find_node_by_name(NULL, "global-utilities");
> -		if (np) {
> -			guts = of_iomap(np, 0);
> -			if (!guts) {
> -
> -				pr_err("mpc85xx-rdb: could not map global utilities register\n");
> +#ifdef CONFIG_SPI_FSL_SPI
> +	for_each_node_by_name(qe_spi, "spi")
> +			par_io_of_config(qe_spi);

Why are you assuming that any node named "spi" is a QE SPI?

> +#endif	/* CONFIG_SPI_FSL_SPI */
>  
> -			} else {
> -			/* P1025 has pins muxed for QE and other functions. To
> -			* enable QE UEC mode, we need to set bit QE0 for UCC1
> -			* in Eth mode, QE0 and QE3 for UCC5 in Eth mode, QE9
> -			* and QE12 for QE MII management singals in PMUXCR
> -			* register.
> -			*/
> +	np = of_find_node_by_name(NULL, "global-utilities");
> +	if (np) {
> +		guts = of_iomap(np, 0);
> +		if (!guts)
> +			pr_err("mpc85xx-rdb: could not map global %s\n",
> +					"utilities register");
> +		else {

Don't put a bunch of code in the else of an error check.  Factor this out
to its own function and return early if you don't find what you're
looking for.

-Scott
