Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0136.outbound.protection.outlook.com [207.46.100.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A8F751A00E9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2015 10:16:43 +1000 (AEST)
Date: Tue, 4 Aug 2015 19:16:26 -0500
From: Scott Wood <scottwood@freescale.com>
To: chenhui zhao <chenhui.zhao@freescale.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <Jason.Jin@freescale.com>
Subject: Re: powerpc/corenet: use the mixed mode of MPIC when enabling CPU
 hotplug
Message-ID: <20150805001626.GA2704@home.buserror.net>
References: <1437623745-21259-1-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1437623745-21259-1-git-send-email-chenhui.zhao@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 23, 2015 at 11:55:45AM +0800, chenhui zhao wrote:
> Core reset may cause issue if using the proxy mode of MPIC.
> Use the mixed mode of MPIC if enabling CPU hotplug.
> 
> Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
> ---
>  arch/powerpc/platforms/85xx/corenet_generic.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
> index bd839dc..0119224 100644
> --- a/arch/powerpc/platforms/85xx/corenet_generic.c
> +++ b/arch/powerpc/platforms/85xx/corenet_generic.c
> @@ -212,7 +212,15 @@ define_machine(corenet_generic) {
>  	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
>  	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
>  #endif
> +/*
> + * Core reset may cause issue if using the proxy mode of MPIC.
> + * So, use the mixed mode of MPIC if enabling CPU hotplug.
> + */
> +#ifdef CONFIG_HOTPLUG_CPU
> +	.get_irq		= mpic_get_irq,
> +#else
>  	.get_irq		= mpic_get_coreint_irq,
> +#endif

Between this and kexec needing the same thing, I'm wondering if we should
just drop support for coreint.  Do you have any benchmarks for the
performance impact of this patch?

Is there an erratum for the hardware problem?

-Scott
