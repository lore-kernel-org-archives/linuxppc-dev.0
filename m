Return-Path: <glikely@secretlab.ca>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.190])
	by ozlabs.org (Postfix) with ESMTP id 22325DDEE0
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 10:12:20 +1100 (EST)
Received: by rn-out-0910.google.com with SMTP id j40so2106565rnf.15
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Feb 2008 15:12:16 -0800 (PST)
Message-ID: <fa686aa40802111512u31c13b68ma56286a0fc4a7ef6@mail.gmail.com>
Date: Mon, 11 Feb 2008 16:12:16 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Dave Jiang" <djiang@mvista.com>
Subject: Re: [PATCH 1/2] powerpc: publish 85xx soc dts entries as of_device
In-Reply-To: <20080211203243.GA5331@blade.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080211203243.GA5331@blade.az.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Feb 11, 2008 1:32 PM, Dave Jiang <djiang@mvista.com> wrote:
> Publish the devices listed in dts under SOC as of_device just like what
> mpc85xx_mds platforms do. The 85xx cds and ads platforms currently do not
> export the devices in dts as of_device.
>
> The memory controller, L2 cache-controller, and the PCI controller(s) are
> published as of_device so the mpc85xx EDAC driver can claim them for usage.
>
> Signed-off-by: Dave Jiang <djiang@mvista.com>
>
> ---
> commit 187841bf9dff25e4ac1a7174daa55bb036c724b1
> tree 3206ffbbfc5075d195345281f72f7b52f060b41b
> parent a99824f327c748b2753f4fa570eb1fefcd6a9c4d
> author Dave Jiang <djiang@mvista.com> Mon, 11 Feb 2008 12:51:33 -0700
> committer Dave Jiang <djiang@blade.(none)> Mon, 11 Feb 2008 12:51:33 -0700
>
>  arch/powerpc/platforms/85xx/mpc85xx_ads.c |   19 +++++++++++++++++++
>  arch/powerpc/platforms/85xx/mpc85xx_cds.c |   19 +++++++++++++++++++
>  2 files changed, 38 insertions(+), 0 deletions(-)
>
> mpc85xx EDAC driver is in mainline kernel now
>
> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
> index 4e03050..024393c 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
> @@ -26,6 +26,8 @@
>  #include <asm/mpic.h>
>  #include <mm/mmu_decl.h>
>  #include <asm/udbg.h>
> +#include <asm/of_device.h>
> +#include <asm/of_platform.h>
>
>  #include <sysdev/fsl_soc.h>
>  #include <sysdev/fsl_pci.h>
> @@ -249,6 +251,23 @@ static int __init mpc85xx_ads_probe(void)
>          return of_flat_dt_is_compatible(root, "MPC85xxADS");
>  }
>
> +static struct of_device_id mpc85xx_ids[] = {
> +       { .type = "soc", },
> +       { .compatible = "soc", },
> +       {},
> +};
> +
> +static int __init mpc85xx_publish_devices(void)
> +{
> +       if (!machine_is(mpc85xx_ads))
> +               return 0;
> +
> +       of_platform_bus_probe(NULL, mpc85xx_ids, NULL);
> +
> +       return 0;
> +}
> +device_initcall(mpc85xx_publish_devices);

machine_device_initcall() please.  (which lets you eliminate the
machine_is() test).

> +
> +static int __init mpc85xx_publish_devices(void)
> +{
> +       if (!machine_is(mpc85xx_cds))
> +               return 0;
> +
> +       of_platform_bus_probe(NULL, mpc85xx_ids, NULL);
> +
> +       return 0;
> +}
> +device_initcall(mpc85xx_publish_devices);
> +

ditto

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
