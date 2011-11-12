Return-Path: <B34182@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
 [65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 45A661007D8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Nov 2011 16:42:49 +1100 (EST)
From: Liu Gang-B34182 <B34182@freescale.com>
To: 'Paul Gortmaker' <paul.gortmaker@windriver.com>
Subject: RE: [PATCH] fsl-rio: fix compile error
Date: Sat, 12 Nov 2011 05:42:41 +0000
Message-ID: <9A1C2A9ACC704641BC472A1588CE164713E5E2@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1321019308-7785-1-git-send-email-Gang.Liu@freescale.com>
 <4EBD43BB.8090903@windriver.com>
In-Reply-To: <4EBD43BB.8090903@windriver.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Li Yang-R58472 <r58472@freescale.com>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
 Zang Roy-R61911 <r61911@freescale.com>,
 "'Alexandre.Bounine@idt.com'" <Alexandre.Bounine@idt.com>,
 "'akpm@linux-foundation.org'" <akpm@linux-foundation.org>,
 "'linuxppc-dev@lists.ozlabs.org'" <linuxppc-dev@lists.ozlabs.org>,
 Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Yes, I'm afraid srio was not enabled when you compiled.

Regards,

Liu Gang
-----Original Message-----
From: Paul Gortmaker [mailto:paul.gortmaker@windriver.com]=20
Sent: Friday, November 11, 2011 11:48 PM
To: Liu Gang-B34182
Cc: linuxppc-dev@lists.ozlabs.org; Alexandre.Bounine@idt.com; akpm@linux-fo=
undation.org; linux-kernel@vger.kernel.org; Li Yang-R58472; Gala Kumar-B117=
80; Zang Roy-R61911
Subject: Re: [PATCH] fsl-rio: fix compile error

On 11-11-11 08:48 AM, Liu Gang wrote:
> The "#include <linux/module.h>" was replaced by "#include <linux/export.h=
>"
> in the patch "powerpc: various straight conversions from module.h --> exp=
ort.h".
> This will cause the following compile problem:
> arch/powerpc/sysdev/fsl_rio.c: In function 'fsl_rio_mcheck_exception':
> arch/powerpc/sysdev/fsl_rio.c:296: error: implicit declaration of functio=
n 'search_exception_tables'.
>=20
> The file fsl_rio.c needs the declaration of function "search_exception_ta=
bles"
> in the header file "linux/module.h".

Thanks -- not sure why this never showed up in my builds of all the powerpc=
 configs, _or_ the linux-next builds.  Maybe srio isn't enabled in any of t=
hem?=20

In any case it looks fine to me.  Having the search_exception_tables live i=
n module.h seems odd, but that is an independent issue for later.

I can queue this unless someone else has already done so.

Paul.

>=20
> Signed-off-by: Liu Gang <Gang.Liu@freescale.com>
> ---
>  arch/powerpc/sysdev/fsl_rio.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/powerpc/sysdev/fsl_rio.c=20
> b/arch/powerpc/sysdev/fsl_rio.c index de170fd..22ffccd 100644
> --- a/arch/powerpc/sysdev/fsl_rio.c
> +++ b/arch/powerpc/sysdev/fsl_rio.c
> @@ -23,7 +23,7 @@
>   */
> =20
>  #include <linux/init.h>
> -#include <linux/export.h>
> +#include <linux/module.h>
>  #include <linux/types.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/interrupt.h>
