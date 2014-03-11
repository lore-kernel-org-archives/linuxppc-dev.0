Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0209.outbound.protection.outlook.com [207.46.163.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4E1B22C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Mar 2014 10:51:39 +1100 (EST)
Message-ID: <1394581880.13761.69.camel@snotra.buserror.net>
Subject: Re: [PATCH 5/9] powerpc/85xx: disable irq by hardware when suspend
 for 64-bit
From: Scott Wood <scottwood@freescale.com>
To: Chenhui Zhao <chenhui.zhao@freescale.com>
Date: Tue, 11 Mar 2014 18:51:20 -0500
In-Reply-To: <1394168285-32275-5-git-send-email-chenhui.zhao@freescale.com>
References: <1394168285-32275-1-git-send-email-chenhui.zhao@freescale.com>
 <1394168285-32275-5-git-send-email-chenhui.zhao@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Jason.Jin@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-03-07 at 12:58 +0800, Chenhui Zhao wrote:
> In 64-bit mode, kernel just clears the irq soft-enable flag
> in struct paca_struct to disable external irqs. But, in
> the case of suspend, irqs should be disabled by hardware.
> Therefore, hook a function to ppc_md.suspend_disable_irqs
> to really disable irqs.
> 
> Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
> ---
>  arch/powerpc/platforms/85xx/corenet_generic.c |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
> index 3fdf9f3..983d81f 100644
> --- a/arch/powerpc/platforms/85xx/corenet_generic.c
> +++ b/arch/powerpc/platforms/85xx/corenet_generic.c
> @@ -32,6 +32,13 @@
>  #include <sysdev/fsl_pci.h>
>  #include "smp.h"
>  
> +#if defined(CONFIG_PPC64) && defined(CONFIG_SUSPEND)
> +static void fsl_suspend_disable_irqs(void)
> +{
> +	__hard_irq_disable();
> +}
> +#endif

Why the underscore version?  Don't you want PACA_IRQ_HARD_DIS to be set?

If hard disabling is appropriate here, shouldn't we do it in
generic_suspend_disable_irqs()?

Are there any existing platforms that supply a
ppc_md.suspend_disable_irqs()?  I don't see any when grepping.

-Scott
