Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0241.outbound.protection.outlook.com [207.46.163.241])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EC64E2C0092
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jan 2014 09:56:44 +1100 (EST)
Message-ID: <1389740192.24905.134.camel@snotra.buserror.net>
Subject: Re: [PATCH 3/4] powerpc: use subsys_initcall for Freescale Local Bus
From: Scott Wood <scottwood@freescale.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Tue, 14 Jan 2014 16:56:32 -0600
In-Reply-To: <1389630113-7919-4-git-send-email-paul.gortmaker@windriver.com>
References: <1389630113-7919-1-git-send-email-paul.gortmaker@windriver.com>
 <1389630113-7919-4-git-send-email-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-01-13 at 11:21 -0500, Paul Gortmaker wrote:
> The FSL_SOC option is bool, and hence this code is either
> present or absent.  It will never be modular, so using
> module_init as an alias for __initcall is rather misleading.
> 
> Fix this up now, so that we can relocate module_init from
> init.h into module.h in the future.  If we don't do this, we'd
> have to add module.h to obviously non-modular code, and that
> would be a worse thing.
> 
> Note that direct use of __initcall is discouraged, vs. one
> of the priority categorized subgroups.  As __initcall gets
> mapped onto device_initcall, our use of subsys_initcall (which
> makes sense for bus code) will thus change this registration
> from level 6-device to level 4-subsys (i.e. slightly earlier).
> However no observable impact of that small difference has
> been observed during testing, or is expected.
> 
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  arch/powerpc/sysdev/fsl_lbc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/sysdev/fsl_lbc.c b/arch/powerpc/sysdev/fsl_lbc.c
> index 6bc5a546d49f..9f00e5f84abe 100644
> --- a/arch/powerpc/sysdev/fsl_lbc.c
> +++ b/arch/powerpc/sysdev/fsl_lbc.c
> @@ -388,4 +388,4 @@ static int __init fsl_lbc_init(void)
>  {
>  	return platform_driver_register(&fsl_lbc_ctrl_driver);
>  }
> -module_init(fsl_lbc_init);
> +subsys_initcall(fsl_lbc_init);

Acked-by: Scott Wood <scottwood@freescale.com>

-Scott
