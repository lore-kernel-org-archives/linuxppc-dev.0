Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7DCA22C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Mar 2013 09:32:46 +1100 (EST)
Date: Sat, 30 Mar 2013 23:32:41 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
Subject: Re: [PATCH 3/3] powerpc/mpc512x: add platform code for MPC5125.
Message-ID: <20130330233241.25846714@crub>
In-Reply-To: <1363801314-16967-4-git-send-email-matteo.facchinetti@sirius-es.it>
References: <1363801314-16967-1-git-send-email-matteo.facchinetti@sirius-es.it>
 <1363801314-16967-4-git-send-email-matteo.facchinetti@sirius-es.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: gregkh@linuxfoundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 20 Mar 2013 18:41:54 +0100
Matteo Facchinetti <matteo.facchinetti@sirius-es.it> wrote:
...
> diff --git a/arch/powerpc/boot/dts/mpc5125twr.dts b/arch/powerpc/boot/dts/mpc5125twr.dts
> new file mode 100644
> index 0000000..afcad7a
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/mpc5125twr.dts
...
> +
> +		diu@2100 {
> +			device_type = "display";

device_type is deprecated (for nodes other than cpu and memory).

...
> +		serial@11100 {
> +			device_type = "serial";
> +			compatible = "fsl,mpc5125-psc-uart", "fsl,mpc5125-psc";
> +			port-number = <0>;

port-number property is not used anywhere, please remove.
Remove device_type property, too.

...
> +		// PSC9 uart1 aka ttyPSC1
> +		serial@11900 {
> +			device_type = "serial";
> +			compatible = "fsl,mpc5125-psc-uart", "fsl,mpc5125-psc";
> +			port-number = <1>;

drop device_type and port-number properties.


> diff --git a/arch/powerpc/platforms/512x/clock.c b/arch/powerpc/platforms/512x/clock.c
> index 52d57d2..a8987dc2 100644
> --- a/arch/powerpc/platforms/512x/clock.c
> +++ b/arch/powerpc/platforms/512x/clock.c
> @@ -29,6 +29,8 @@
>  #include <asm/mpc5121.h>
>  #include <asm/clk_interface.h>
>  
> +#include "mpc512x.h"
> +
>  #undef CLK_DEBUG
>  
>  static int clocks_initialized;
> @@ -683,8 +685,13 @@ static void psc_clks_init(void)
>  	struct device_node *np;
>  	struct platform_device *ofdev;
>  	u32 reg;
> +	char *psc_compat;

it should be const char *.

...
> diff --git a/arch/powerpc/platforms/512x/mpc512x.h b/arch/powerpc/platforms/512x/mpc512x.h
> index c32b399..2b97622 100644
> --- a/arch/powerpc/platforms/512x/mpc512x.h
> +++ b/arch/powerpc/platforms/512x/mpc512x.h
> @@ -15,6 +15,7 @@ extern void __init mpc512x_init_IRQ(void);
>  extern void __init mpc512x_init(void);
>  extern int __init mpc5121_clk_init(void);
>  void __init mpc512x_declare_of_platform_devices(void);
> +extern char *mpc512x_select_psc_compat(void);

const char *.

...
> diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
> index d30235b..fbf67e9 100644
> --- a/arch/powerpc/platforms/512x/mpc512x_shared.c
> +++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
> @@ -350,6 +350,21 @@ void __init mpc512x_declare_of_platform_devices(void)
>  
>  #define DEFAULT_FIFO_SIZE 16
>  
> +char *mpc512x_select_psc_compat(void)

const char *.

> +{
> +	char *psc_compats[] = {
> +		"fsl,mpc5121-psc",
> +		"fsl,mpc5125-psc"
> +	};
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(psc_compats); i++)
> +		if (of_find_compatible_node(NULL, NULL, psc_compats[i]))
> +			return psc_compats[i];

I don't like this, better would be to use something like:

        if (of_machine_is_compatible("fsl,mpc5121"))
                return "fsl,mpc5121-psc";

        if (of_machine_is_compatible("fsl,mpc5125"))
                return "fsl,mpc5125-psc";

but note that it will only work if we add these compatibles
to the compatible list of the root nodes in 5121 and 5125
device trees.

Thanks,

Anatolij
