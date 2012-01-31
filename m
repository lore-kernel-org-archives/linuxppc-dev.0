Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE006.bigfish.com (am1ehsobe004.messaging.microsoft.com
 [213.199.154.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8E7E71007D2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2012 06:12:34 +1100 (EST)
Received: from mail96-am1 (localhost [127.0.0.1])	by mail96-am1-R.bigfish.com
 (Postfix) with ESMTP id A0E6E4C0199	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,
 31 Jan 2012 19:12:28 +0000 (UTC)
Received: from AM1EHSMHS011.bigfish.com (unknown [10.3.201.243])	by
 mail96-am1.bigfish.com (Postfix) with ESMTP id A1C394A0045	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2012 19:12:27 +0000 (UTC)
Message-ID: <4F283D11.4080004@freescale.com>
Date: Tue, 31 Jan 2012 13:12:17 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Claudiu Manoil <claudiu.manoil@freescale.com>
Subject: Re: [PATCH] powerpc/85xx: Fix compiler error with THIS_MODULE and
 related
References: <1328004939-29766-1-git-send-email-claudiu.manoil@freescale.com>
In-Reply-To: <1328004939-29766-1-git-send-email-claudiu.manoil@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/31/2012 04:15 AM, Claudiu Manoil wrote:
>    CC      arch/powerpc/sysdev/fsl_85xx_l2ctlr.o
> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:209:13: error: 'THIS_MODULE' undeclared here (not in a function)
> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:229:20: error: expected declaration specifiers or '...' before string constant
> cc1: warnings being treated as errors
> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:229:1: error: data definition has no type or storage class
> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:229:1: error: type defaults to 'int' in declaration of 'MODULE_DESCRIPTION'
> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:229:20: error: function declaration isn't a prototype
> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:230:16: error: expected declaration specifiers or '...' before string constant
> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:230:1: error: data definition has no type or storage class
> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:230:1: error: type defaults to 'int' in declaration of 'MODULE_LICENSE'
> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:230:16: error: function declaration isn't a prototype
> make[1]: *** [arch/powerpc/sysdev/fsl_85xx_l2ctlr.o] Error 1
> 
> ...
> 
>   CC      arch/powerpc/sysdev/fsl_85xx_cache_sram.o
> cc1: warnings being treated as errors
> arch/powerpc/sysdev/fsl_85xx_cache_sram.c:69:1: error: data definition has no type or storage class
> arch/powerpc/sysdev/fsl_85xx_cache_sram.c:69:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL'
> arch/powerpc/sysdev/fsl_85xx_cache_sram.c:69:1: error: parameter names (without types) in function declaration
> arch/powerpc/sysdev/fsl_85xx_cache_sram.c:80:1: error: data definition has no type or storage class
> arch/powerpc/sysdev/fsl_85xx_cache_sram.c:80:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL'
> arch/powerpc/sysdev/fsl_85xx_cache_sram.c:80:1: error: parameter names (without types) in function declaration
> make[1]: *** [arch/powerpc/sysdev/fsl_85xx_cache_sram.o] Error 1
> 
> Signed-off-by: Claudiu Manoil <claudiu.manoil@freescale.com>
> ---
>  arch/powerpc/sysdev/fsl_85xx_cache_sram.c |    1 +
>  arch/powerpc/sysdev/fsl_85xx_l2ctlr.c     |    1 +
>  2 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/fsl_85xx_cache_sram.c b/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
> index 1164158..92cce8d 100644
> --- a/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
> +++ b/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
> @@ -24,6 +24,7 @@
>   */
>  
>  #include <linux/kernel.h>
> +#include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/err.h>
>  #include <linux/of_platform.h>
> diff --git a/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c b/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
> index 5f88797..1957e53 100644
> --- a/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
> +++ b/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
> @@ -21,6 +21,7 @@
>   */
>  
>  #include <linux/kernel.h>
> +#include <linux/module.h>
>  #include <linux/of_platform.h>
>  #include <asm/io.h>
>  

I believe <linux/export.h> is what you're supposed to include for this
these days.

-Scott
