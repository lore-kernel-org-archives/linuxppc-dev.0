Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4ED66DDDEA
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 15:28:14 +1000 (EST)
In-Reply-To: <20070718013538.GB15238@ld0162-tx32.am.freescale.net>
References: <20070718013538.GB15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8DC2DA02-3D10-4D14-AC91-E34AEA68E04F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 30/61] fsl_soc: Update the way get_brgfreq() finds things
	in the device tree.
Date: Wed, 18 Jul 2007 00:28:41 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 17, 2007, at 8:35 PM, Scott Wood wrote:

> It now uses names that are less namespace polluting.
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/boot/dts/mpc8272ads.dts |    5 ++---
>  arch/powerpc/boot/dts/mpc8560ads.dts |    5 ++---
>  arch/powerpc/boot/dts/mpc866ads.dts  |    5 ++---
>  arch/powerpc/boot/dts/mpc885ads.dts  |    5 ++---
>  arch/powerpc/sysdev/fsl_soc.c        |   10 +++++-----
>  5 files changed, 13 insertions(+), 17 deletions(-)
>
> diff --git a/arch/powerpc/boot/dts/mpc8272ads.dts b/arch/powerpc/ 
> boot/dts/mpc8272ads.dts
> index 4d09dca..16a77f4 100644
> --- a/arch/powerpc/boot/dts/mpc8272ads.dts
> +++ b/arch/powerpc/boot/dts/mpc8272ads.dts
> @@ -119,12 +119,11 @@
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			#interrupt-cells = <2>;
> -			device_type = "cpm";
> -			model = "CPM2";
> +			compatible = "fsl,mpc8272-cpm", "fsl,cpm2", "fsl,cpm";

Does 'fsl,cpm' really mean anything useful?

>  			ranges = <00000000 00000000 20000>;
>  			reg = <0 20000>;
>  			command-proc = <119c0>;
> -			brg-frequency = <17D7840>;
> +			fsl,brg-frequency = <d#25000000>;

Leave brg-frequency, and make a note about it being deprecated.

>  			cpm_clk = <BEBC200>;
>
>  			scc@11a00 {


> diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/ 
> fsl_soc.c
> index a837742..ff70d62 100644
> --- a/arch/powerpc/sysdev/fsl_soc.c
> +++ b/arch/powerpc/sysdev/fsl_soc.c
> @@ -84,16 +84,16 @@ u32 get_brgfreq(void)
>  	if (brgfreq != -1)
>  		return brgfreq;
>
> -	node = of_find_node_by_type(NULL, "cpm");
> +	node = of_find_compatible_node(NULL, NULL, "fsl,cpm");
>  	if (node) {
>  		unsigned int size;
> -		const unsigned int *prop = of_get_property(node,
> -					"brg-frequency", &size);
> +		const unsigned int *prop =
> +			of_get_property(node, "fsl,brg-frequency", &size);

We need to support both "brg-frequency" and "fsl,brg-frequency" for  
some period of time.

Also, take a look at QE it has a similar concept.

>
> -		if (prop)
> +		if (prop && size == 4)
>  			brgfreq = *prop;
>  		of_node_put(node);
> -	};
> +	}
>
>  	return brgfreq;
>  }
> -- 
> 1.5.0.3
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
