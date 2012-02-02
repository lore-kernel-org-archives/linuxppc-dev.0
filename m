Return-Path: <paul.gortmaker@gmail.com>
Received: from mail-bk0-f42.google.com (mail-bk0-f42.google.com
 [209.85.214.42]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6DEE41007D1
 for <linuxppc-dev@ozlabs.org>; Thu,  2 Feb 2012 13:34:58 +1100 (EST)
Received: by bkat2 with SMTP id t2so1697209bka.15
 for <linuxppc-dev@ozlabs.org>; Wed, 01 Feb 2012 18:34:55 -0800 (PST)
MIME-Version: 1.0
Sender: paul.gortmaker@gmail.com
In-Reply-To: <1328115915-16172-1-git-send-email-claudiu.manoil@freescale.com>
References: <1328115915-16172-1-git-send-email-claudiu.manoil@freescale.com>
Date: Wed, 1 Feb 2012 21:34:53 -0500
Message-ID: <CAP=VYLpR2=OwdX3BruRq47HQKgTEnjD_OQizvJz7Zng50RZ_jA@mail.gmail.com>
Subject: Re: [PATCH][v2] powerpc/85xx: Fix compiler error with THIS_MODULE and
 related
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Claudiu Manoil <claudiu.manoil@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 1, 2012 at 12:05 PM, Claudiu Manoil
<claudiu.manoil@freescale.com> wrote:
> CC =A0 =A0 =A0arch/powerpc/sysdev/fsl_85xx_l2ctlr.o
> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:209:13: error: 'THIS_MODULE' undecl=
ared here (not in a function)

Looks OK to me -- must be the 1st time this code has been
merged into the 3.2 baseline, since the export.h change was
news in the last release, and not anything new for 3.3.

Acked-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Paul.


> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:229:20: error: expected declaration=
 specifiers or '...' before string constant
> cc1: warnings being treated as errors
> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:229:1: error: data definition has n=
o type or storage class
> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:229:1: error: type defaults to 'int=
' in declaration of 'MODULE_DESCRIPTION'
> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:229:20: error: function declaration=
 isn't a prototype
> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:230:16: error: expected declaration=
 specifiers or '...' before string constant
> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:230:1: error: data definition has n=
o type or storage class
> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:230:1: error: type defaults to 'int=
' in declaration of 'MODULE_LICENSE'
> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:230:16: error: function declaration=
 isn't a prototype
> make[1]: *** [arch/powerpc/sysdev/fsl_85xx_l2ctlr.o] Error 1
>
> ...
>
> =A0CC =A0 =A0 =A0arch/powerpc/sysdev/fsl_85xx_cache_sram.o
> cc1: warnings being treated as errors
> arch/powerpc/sysdev/fsl_85xx_cache_sram.c:69:1: error: data definition ha=
s no type or storage class
> arch/powerpc/sysdev/fsl_85xx_cache_sram.c:69:1: error: type defaults to '=
int' in declaration of 'EXPORT_SYMBOL'
> arch/powerpc/sysdev/fsl_85xx_cache_sram.c:69:1: error: parameter names (w=
ithout types) in function declaration
> arch/powerpc/sysdev/fsl_85xx_cache_sram.c:80:1: error: data definition ha=
s no type or storage class
> arch/powerpc/sysdev/fsl_85xx_cache_sram.c:80:1: error: type defaults to '=
int' in declaration of 'EXPORT_SYMBOL'
> arch/powerpc/sysdev/fsl_85xx_cache_sram.c:80:1: error: parameter names (w=
ithout types) in function declaration
> make[1]: *** [arch/powerpc/sysdev/fsl_85xx_cache_sram.o] Error 1
>
> Signed-off-by: Claudiu Manoil <claudiu.manoil@freescale.com>
> ---
> Replaced <linux/module.h> with <linux/export.h> for fsl_85xx_cache_sram.c=
.
>
> =A0arch/powerpc/sysdev/fsl_85xx_cache_sram.c | =A0 =A01 +
> =A0arch/powerpc/sysdev/fsl_85xx_l2ctlr.c =A0 =A0 | =A0 =A01 +
> =A02 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/sysdev/fsl_85xx_cache_sram.c b/arch/powerpc/sys=
dev/fsl_85xx_cache_sram.c
> index 1164158..37a6909 100644
> --- a/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
> +++ b/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
> @@ -24,6 +24,7 @@
> =A0*/
>
> =A0#include <linux/kernel.h>
> +#include <linux/export.h>
> =A0#include <linux/slab.h>
> =A0#include <linux/err.h>
> =A0#include <linux/of_platform.h>
> diff --git a/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c b/arch/powerpc/sysdev/=
fsl_85xx_l2ctlr.c
> index 5f88797..1957e53 100644
> --- a/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
> +++ b/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
> @@ -21,6 +21,7 @@
> =A0*/
>
> =A0#include <linux/kernel.h>
> +#include <linux/module.h>
> =A0#include <linux/of_platform.h>
> =A0#include <asm/io.h>
>
> --
> 1.6.6
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
