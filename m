Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 677931007D4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Nov 2011 03:51:43 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH] fsl-rio: fix compile error
Date: Fri, 11 Nov 2011 08:49:45 -0800
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E55202490DDA@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <1321019308-7785-1-git-send-email-Gang.Liu@freescale.com>
References: <1321019308-7785-1-git-send-email-Gang.Liu@freescale.com>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: Liu Gang <Gang.Liu@freescale.com>, <linuxppc-dev@lists.ozlabs.org>
Cc: r58472@freescale.com, linux-kernel@vger.kernel.org, r61911@freescale.com,
 paul.gortmaker@windriver.com, akpm@linux-foundation.org, B11780@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 11, 2011 at 8:48 AM Liu Gang <Gang.Liu@freescale.com> wrote:

> Sent: Friday, November 11, 2011 8:48 AM
> To: linuxppc-dev@lists.ozlabs.org; Bounine, Alexandre
> Cc: akpm@linux-foundation.org; linux-kernel@vger.kernel.org;
> paul.gortmaker@windriver.com; r58472@freescale.com;
> B11780@freescale.com; r61911@freescale.com; Liu Gang
> Subject: [PATCH] fsl-rio: fix compile error
>=20
> The "#include <linux/module.h>" was replaced by "#include
> <linux/export.h>"
> in the patch "powerpc: various straight conversions from module.h -->
> export.h".
> This will cause the following compile problem:
> arch/powerpc/sysdev/fsl_rio.c: In function 'fsl_rio_mcheck_exception':
> arch/powerpc/sysdev/fsl_rio.c:296: error: implicit declaration of
> function 'search_exception_tables'.
>=20
> The file fsl_rio.c needs the declaration of function
> "search_exception_tables"
> in the header file "linux/module.h".
>=20
> Signed-off-by: Liu Gang <Gang.Liu@freescale.com>
> ---
>  arch/powerpc/sysdev/fsl_rio.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/powerpc/sysdev/fsl_rio.c
> b/arch/powerpc/sysdev/fsl_rio.c
> index de170fd..22ffccd 100644
> --- a/arch/powerpc/sysdev/fsl_rio.c
> +++ b/arch/powerpc/sysdev/fsl_rio.c
> @@ -23,7 +23,7 @@
>   */
>=20
>  #include <linux/init.h>
> -#include <linux/export.h>
> +#include <linux/module.h>
>  #include <linux/types.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/interrupt.h>
> --
> 1.7.3.1
>=20


Acked-by: Alexandre Bounine <alexandre.bounine@idt.com>
