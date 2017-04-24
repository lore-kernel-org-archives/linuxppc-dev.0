Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wB8P30QTPzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 11:47:51 +1000 (AEST)
Message-ID: <1492998461.25397.16.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: roy.pledge@nxp.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 robin.murphy@arm.com
Cc: madalin.bucur@nxp.com
Date: Sun, 23 Apr 2017 20:47:41 -0500
In-Reply-To: <1492634930-10765-8-git-send-email-roy.pledge@nxp.com>
References: <1492634930-10765-1-git-send-email-roy.pledge@nxp.com>
 <1492634930-10765-8-git-send-email-roy.pledge@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH v2 07/11] soc/fsl/qbman: Rework ioremap() calls for ARM/PPC
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-04-19 at 16:48 -0400, Roy Pledge wrote:
> Rework ioremap() for PPC and ARM. The PPC devices require a
> non-coherent mapping while ARM will work with a non-cachable/write
> combine mapping.
> 
> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
> ---
>  drivers/soc/fsl/qbman/bman_portal.c | 16 +++++++++++++---
>  drivers/soc/fsl/qbman/qman_portal.c | 16 +++++++++++++---
>  2 files changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qbman/bman_portal.c
> b/drivers/soc/fsl/qbman/bman_portal.c
> index 8354d4d..a661f30 100644
> --- a/drivers/soc/fsl/qbman/bman_portal.c
> +++ b/drivers/soc/fsl/qbman/bman_portal.c
> @@ -125,7 +125,18 @@ static int bman_portal_probe(struct platform_device
> *pdev)
>  	}
>  	pcfg->irq = irq;
>  
> -	va = ioremap_prot(addr_phys[0]->start, resource_size(addr_phys[0]),
> 0);
> +#ifdef CONFIG_PPC
> +	/* PPC requires a cacheable/non-coherent mapping of the portal */
> +	va = ioremap_prot(addr_phys[0]->start, resource_size(addr_phys[0]),
> +			  (pgprot_val(PAGE_KERNEL) & ~_PAGE_COHERENT));
> +#else
> +	/*
> +	 * For ARM we can use write combine mapping.  A cacheable/non
> shareable
> +	 * mapping will perform better but equires additional platform
> +	 * support which is not currently available
> +	 */

s/equires/requires/

Would be nice to describe the platform support that is required.

-Scott
