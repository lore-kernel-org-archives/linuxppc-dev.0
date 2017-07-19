Return-Path: <k.kozlowski.k@gmail.com>
Received: from mail-io0-f193.google.com (mail-io0-f193.google.com
 [209.85.223.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xC5z53XFNzDrRs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 16:02:24 +1000 (AEST)
Received: by mail-io0-f193.google.com with SMTP id f66so3747808iof.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 23:02:24 -0700 (PDT)
Date: Wed, 19 Jul 2017 08:01:53 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: arm@kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Scott Wood <oss@buserror.net>,
 Qiang Zhao <qiang.zhao@nxp.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Simon Horman <horms@verge.net.au>,
 Magnus Damm <magnus.damm@gmail.com>, Kukjin Kim <kgene@kernel.org>,
 Javier Martinez Canillas <javier@osg.samsung.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH] soc: Convert to using %pOF instead of full_name
Message-ID: <20170719060153.GD6246@kozik-book>
References: <20170718214339.7774-49-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170718214339.7774-49-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 18, 2017 at 04:43:29PM -0500, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Scott Wood <oss@buserror.net>
> Cc: Qiang Zhao <qiang.zhao@nxp.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: linux-samsung-soc@vger.kernel.org
> ---
>  drivers/soc/fsl/qbman/bman_ccsr.c    | 10 +++++-----
>  drivers/soc/fsl/qbman/bman_portal.c  |  8 +++-----
>  drivers/soc/fsl/qbman/qman_ccsr.c    | 12 ++++++------
>  drivers/soc/fsl/qbman/qman_portal.c  | 11 ++++-------
>  drivers/soc/fsl/qe/gpio.c            |  4 ++--
>  drivers/soc/mediatek/mtk-pmic-wrap.c |  4 ++--
>  drivers/soc/renesas/rcar-rst.c       |  4 ++--
>  drivers/soc/renesas/rcar-sysc.c      |  6 +++---
>  drivers/soc/samsung/pm_domains.c     |  8 ++++----
>  9 files changed, 31 insertions(+), 36 deletions(-)
> 

(...)

> diff --git a/drivers/soc/samsung/pm_domains.c b/drivers/soc/samsung/pm_domains.c
> index a6a5d807cc2b..c630eba32066 100644
> --- a/drivers/soc/samsung/pm_domains.c
> +++ b/drivers/soc/samsung/pm_domains.c
> @@ -237,11 +237,11 @@ static __init int exynos4_pm_init_power_domain(void)
>  			continue;
> 
>  		if (of_genpd_add_subdomain(&parent, &child))
> -			pr_warn("%s failed to add subdomain: %s\n",
> -				parent.np->full_name, child.np->full_name);
> +			pr_warn("%pOF failed to add subdomain: %pOF\n",
> +				parent.np, child.np);
>  		else
> -			pr_info("%s has as child subdomain: %s.\n",
> -				parent.np->full_name, child.np->full_name);
> +			pr_info("%pOF has as child subdomain: %pOF.\n",
> +				parent.np, child.np);
>  	}
> 
>  	return 0;

I guess this will go through arm-soc?

For Samsung, looks good:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
