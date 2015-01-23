Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BFB281A0C6B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2015 14:02:56 +1100 (AEDT)
Message-ID: <1421982176.24984.6.camel@ellerman.id.au>
Subject: Re: [PATCH resend] powernv/iommu: disable IOMMU bypass with param
 iommu=nobypass
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
Date: Fri, 23 Jan 2015 14:02:56 +1100
In-Reply-To: <1421853832-32533-1-git-send-email-cascardo@linux.vnet.ibm.com>
References: <1421853832-32533-1-git-send-email-cascardo@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, gwshan@linux.vnet.ibm.com,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-01-21 at 13:23 -0200, Thadeu Lima de Souza Cascardo wrote:
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index fac88ed..f942a19 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -75,6 +75,27 @@ static void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
>  #define pe_info(pe, fmt, ...)					\
>  	pe_level_printk(pe, KERN_INFO, fmt, ##__VA_ARGS__)
>  
> +static bool pnv_iommu_bypass_disabled __read_mostly;
> +
> +static int __init iommu_setup(char *str)
> +{
> +	if (!str)
> +		return -EINVAL;
> +	while (*str) {
> +		if (!strncmp(str, "nobypass", 8)) {
> +			pnv_iommu_bypass_disabled = true;
> +			pr_info("PowerNV: IOMMU bypass window disabled.\n");

I added a break here.

> +		}
> +		str += strcspn(str, ",");
> +		if (*str == ',')
> +			str++;
> +	}
> +
> +	return 0;
> +}
> +
> +early_param("iommu", iommu_setup);

cheers
