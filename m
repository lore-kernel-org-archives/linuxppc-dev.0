Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B8E421007D4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Nov 2011 02:48:34 +1100 (EST)
Message-ID: <4EBD43BB.8090903@windriver.com>
Date: Fri, 11 Nov 2011 10:48:11 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
MIME-Version: 1.0
To: Liu Gang <Gang.Liu@freescale.com>
Subject: Re: [PATCH] fsl-rio: fix compile error
References: <1321019308-7785-1-git-send-email-Gang.Liu@freescale.com>
In-Reply-To: <1321019308-7785-1-git-send-email-Gang.Liu@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: r58472@freescale.com, linux-kernel@vger.kernel.org, r61911@freescale.com,
 Alexandre.Bounine@idt.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, B11780@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11-11-11 08:48 AM, Liu Gang wrote:
> The "#include <linux/module.h>" was replaced by "#include <linux/export.h>"
> in the patch "powerpc: various straight conversions from module.h --> export.h".
> This will cause the following compile problem:
> arch/powerpc/sysdev/fsl_rio.c: In function 'fsl_rio_mcheck_exception':
> arch/powerpc/sysdev/fsl_rio.c:296: error: implicit declaration of function 'search_exception_tables'.
> 
> The file fsl_rio.c needs the declaration of function "search_exception_tables"
> in the header file "linux/module.h".

Thanks -- not sure why this never showed up in my builds of all the
powerpc configs, _or_ the linux-next builds.  Maybe srio isn't enabled
in any of them? 

In any case it looks fine to me.  Having the search_exception_tables
live in module.h seems odd, but that is an independent issue for later.

I can queue this unless someone else has already done so.

Paul.

> 
> Signed-off-by: Liu Gang <Gang.Liu@freescale.com>
> ---
>  arch/powerpc/sysdev/fsl_rio.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
> index de170fd..22ffccd 100644
> --- a/arch/powerpc/sysdev/fsl_rio.c
> +++ b/arch/powerpc/sysdev/fsl_rio.c
> @@ -23,7 +23,7 @@
>   */
>  
>  #include <linux/init.h>
> -#include <linux/export.h>
> +#include <linux/module.h>
>  #include <linux/types.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/interrupt.h>
