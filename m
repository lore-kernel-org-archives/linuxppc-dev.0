Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0108.outbound.protection.outlook.com [157.56.111.108])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5EA6F1A04CA
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Oct 2014 04:35:07 +1100 (EST)
Message-ID: <1412962492.13320.587.camel@snotra.buserror.net>
Subject: Re: [PATCH 2/3] qe: run qe_init and qe_ic_init
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang <B45475@freescale.com>
Date: Fri, 10 Oct 2014 12:34:52 -0500
In-Reply-To: <1412923725-9611-1-git-send-email-B45475@freescale.com>
References: <1412923725-9611-1-git-send-email-B45475@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: B07421@freescale.com, R63061@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-10-10 at 14:48 +0800, Zhao Qiang wrote:
> qe and qe_ic need to be initialized before the
> qe app drivers, using subsys_initcall to run
> qe_init and qe_ic_init
> 
> Signed-off-by: Zhao Qiang <B45475@freescale.com>
> ---
>  drivers/soc/qe/qe.c    | 15 +++++++++++++++
>  drivers/soc/qe/qe_ic.c | 15 +++++++++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/drivers/soc/qe/qe.c b/drivers/soc/qe/qe.c
> index 2aaa5b2..bfea0f8 100644
> --- a/drivers/soc/qe/qe.c
> +++ b/drivers/soc/qe/qe.c
> @@ -683,6 +683,21 @@ unsigned int qe_get_num_of_snums(void)
>  }
>  EXPORT_SYMBOL(qe_get_num_of_snums);
>  
> +static int __init qe_init(void)
> +{
> +	struct device_node *np;
> +
> +	np = of_find_compatible_node(NULL, NULL, "fsl,qe");
> +	if (!np) {
> +		pr_err("%s: Could not find Quicc Engine node\n", __func__);
> +		return -ENODEV;
> +	}
> +	qe_reset();
> +	of_node_put(np);
> +	return 0;
> +}
> +subsys_initcall(qe_init);

It is not an error to enable QE support on hardware that doesn't have
QE.  Please remove the pr_err().

> +
>  #if defined(CONFIG_SUSPEND) && defined(CONFIG_PPC_85xx)
>  static int qe_resume(struct platform_device *ofdev)
>  {
> diff --git a/drivers/soc/qe/qe_ic.c b/drivers/soc/qe/qe_ic.c
> index cc1b8d5..11fe98c 100644
> --- a/drivers/soc/qe/qe_ic.c
> +++ b/drivers/soc/qe/qe_ic.c
> @@ -34,6 +34,7 @@
>  #include <linux/fsl/qe_ic.h>
>  
>  #include "qe_ic.h"
> +#include "../../irqchip/irqchip.h"

What do you need from here, and can it be moved to include/linux/...?
 
The only thing I see defined in irqchip.h is IRQCHIP_DECLARE, and you
don't use that in this patch...

-Scott

>  static DEFINE_RAW_SPINLOCK(qe_ic_lock);
>  
> @@ -501,4 +502,18 @@ static int __init init_qe_ic_sysfs(void)
>  	return 0;
>  }
>  
> +static int __init qeic_of_init(void)
> +{
> +	struct device_node *np;
> +
> +	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
> +	if (np) {
> +		qe_ic_init(np, 0, qe_ic_cascade_low_mpic,
> +			   qe_ic_cascade_high_mpic);
> +		of_node_put(np);
> +	}
> +	return 0;
> +}
> +subsys_initcall(qeic_of_init);
> +
>  subsys_initcall(init_qe_ic_sysfs);
