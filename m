Return-Path: <sudeep.holla@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tJqlc6bsdzDt14
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 03:41:32 +1100 (AEDT)
Subject: Re: [PATCH 1/2] soc: fsl: make it explicitly non-modular
To: linuxppc-dev@lists.ozlabs.org
References: <1479314367-9169-1-git-send-email-sudeep.holla@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
 Scott Wood <oss@buserror.net>, Yangbo Lu <yangbo.lu@nxp.com>,
 Arnd Bergmann <arnd@arndb.de>
From: Sudeep Holla <sudeep.holla@arm.com>
Message-ID: <acb8b99f-cb71-6614-b90e-c62494746fc8@arm.com>
Date: Wed, 16 Nov 2016 16:41:29 +0000
MIME-Version: 1.0
In-Reply-To: <1479314367-9169-1-git-send-email-sudeep.holla@arm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 16/11/16 16:39, Sudeep Holla wrote:
> The Kconfig currently controlling compilation of this code is:
>
> drivers/soc/fsl/Kconfig:config FSL_GUTS
> drivers/soc/fsl/Kconfig:   bool
>
> ...meaning that it currently is not being built as a module by anyone.
>
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.
>
> Since module_init was not in use by this code, the init ordering
> remains unchanged with this commit.
>

Sorry I forgot to append -next as these are applicable only to linux-next

> Cc: Scott Wood <oss@buserror.net>
> Cc: Yangbo Lu <yangbo.lu@nxp.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/soc/fsl/guts.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
> index 0ac88263c2d7..885409d84eb2 100644
> --- a/drivers/soc/fsl/guts.c
> +++ b/drivers/soc/fsl/guts.c
> @@ -11,7 +11,6 @@
>
>  #include <linux/io.h>
>  #include <linux/slab.h>
> -#include <linux/module.h>
>  #include <linux/of_fdt.h>
>  #include <linux/sys_soc.h>
>  #include <linux/of_address.h>
> @@ -212,7 +211,6 @@ static const struct of_device_id fsl_guts_of_match[] = {
>  	{ .compatible = "fsl,ls2080a-dcfg", },
>  	{}
>  };
> -MODULE_DEVICE_TABLE(of, fsl_guts_of_match);
>
>  static struct platform_driver fsl_guts_driver = {
>  	.driver = {
> @@ -228,9 +226,3 @@ static int __init fsl_guts_init(void)
>  	return platform_driver_register(&fsl_guts_driver);
>  }
>  core_initcall(fsl_guts_init);
> -
> -static void __exit fsl_guts_exit(void)
> -{
> -	platform_driver_unregister(&fsl_guts_driver);
> -}
> -module_exit(fsl_guts_exit);
>

-- 
Regards,
Sudeep
