Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 471BA67B73
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Aug 2006 07:49:04 +1000 (EST)
In-Reply-To: <1154640338.26770.34.camel@cashmere.sps.mot.com>
References: <1154640338.26770.34.camel@cashmere.sps.mot.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0D9BEF4A-F8A5-42C5-9962-8C88322C9F50@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Convert to mac-address for ethernet MAC address data.
Date: Thu, 3 Aug 2006 16:49:05 -0500
To: Jon Loeliger <jdl@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 3, 2006, at 4:25 PM, Jon Loeliger wrote:

> onvert to mac-address for ethernet MAC address data.
>
> Also accept "local-mac-address".  However the old "address"
> is now obsolete, but accepted for backwards compatibility.
> It should be removed after all device trees have been
> converted to use "mac-address".
>
> Signed-off-by: Jon Loeliger <jdl@freescale.com>
> ---
>  Documentation/powerpc/booting-without-of.txt |   10 +++++-----
>  arch/powerpc/sysdev/fsl_soc.c                |   12 ++++++++++--
>  2 files changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/powerpc/booting-without-of.txt b/ 
> Documentation/powerpc/booting-without-of.txt
> index 3c62e66..8c48b8a 100644
> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
> @@ -1196,7 +1196,7 @@ platforms are moved over to use the flat
>      - model : Model of the device.  Can be "TSEC", "eTSEC", or "FEC"
>      - compatible : Should be "gianfar"
>      - reg : Offset and length of the register set for the device
> -    - address : List of bytes representing the ethernet address of
> +    - mac-address : List of bytes representing the ethernet  
> address of
>        this controller
>      - interrupts : <a b> where a is the interrupt number and b is a
>        field that represents an encoding of the sense and level
> @@ -1216,7 +1216,7 @@ platforms are moved over to use the flat
>  		model = "TSEC";
>  		compatible = "gianfar";
>  		reg = <24000 1000>;
> -		address = [ 00 E0 0C 00 73 00 ];
> +		mac-address = [ 00 E0 0C 00 73 00 ];
>  		interrupts = <d 3 e 3 12 3>;
>  		interrupt-parent = <40000>;
>  		phy-handle = <2452000>
> @@ -1498,7 +1498,7 @@ not necessary as they are usually the sa
>  			model = "TSEC";
>  			compatible = "gianfar";
>  			reg = <24000 1000>;
> -			address = [ 00 E0 0C 00 73 00 ];
> +			mac-address = [ 00 E0 0C 00 73 00 ];
>  			interrupts = <d 3 e 3 12 3>;
>  			interrupt-parent = <40000>;
>  			phy-handle = <2452000>;
> @@ -1511,7 +1511,7 @@ not necessary as they are usually the sa
>  			model = "TSEC";
>  			compatible = "gianfar";
>  			reg = <25000 1000>;
> -			address = [ 00 E0 0C 00 73 01 ];
> +			mac-address = [ 00 E0 0C 00 73 01 ];
>  			interrupts = <13 3 14 3 18 3>;
>  			interrupt-parent = <40000>;
>  			phy-handle = <2452001>;
> @@ -1524,7 +1524,7 @@ not necessary as they are usually the sa
>  			model = "FEC";
>  			compatible = "gianfar";
>  			reg = <26000 1000>;
> -			address = [ 00 E0 0C 00 73 02 ];
> +			mac-address = [ 00 E0 0C 00 73 02 ];
>  			interrupts = <19 3>;
>  			interrupt-parent = <40000>;
>  			phy-handle = <2452002>;
> diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/ 
> fsl_soc.c
> index 4a6aa64..92ba378 100644
> --- a/arch/powerpc/sysdev/fsl_soc.c
> +++ b/arch/powerpc/sysdev/fsl_soc.c
> @@ -166,8 +166,16 @@ static int __init gfar_of_init(void)
>  			goto err;
>  		}
>
> -		mac_addr = get_property(np, "address", NULL);
> -		memcpy(gfar_data.mac_addr, mac_addr, 6);
> +		mac_addr = get_property(np, "local-mac-address", NULL);

If "mac-address" the preferred mechanism, why dont we check for it  
first?

> +		if (mac_addr == NULL)
> +			mac_addr = get_property(np, "mac-address", NULL);
> +		if (mac_addr == NULL) {
> +			/* Obsolete */
> +			mac_addr = get_property(np, "address", NULL);
> +		}
> +
> +		if (mac_addr)
> +			memcpy(gfar_data.mac_addr, mac_addr, 6);
>
>  		if (model && !strcasecmp(model, "TSEC"))
>  			gfar_data.device_flags =
> -- 
> 2006_06_07.01.gittree_pull-dirty
>
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
