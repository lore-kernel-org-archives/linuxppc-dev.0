Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 286261A0FE0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 18:58:16 +1000 (AEST)
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
 [209.85.220.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9F07B1402D5
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Oct 2015 18:58:15 +1000 (AEST)
Received: by padhy16 with SMTP id hy16so101719224pad.1
 for <linuxppc-dev@ozlabs.org>; Fri, 02 Oct 2015 01:58:13 -0700 (PDT)
Subject: Re: [PATCH V4 2/6] powerpc/powernv: simplify the calculation of iov
 resource alignment
To: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
 benh@kernel.crashing.org
References: <1439949704-8023-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1439949704-8023-3-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <560E4721.1090007@ozlabs.ru>
Date: Fri, 2 Oct 2015 18:58:09 +1000
MIME-Version: 1.0
In-Reply-To: <1439949704-8023-3-git-send-email-weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/19/2015 12:01 PM, Wei Yang wrote:
> The alignment of IOV BAR on PowerNV platform is the total size of the IOV
> BAR. No matter whether the IOV BAR is extended with number of
> roundup_pow_of_two(total_vfs) or number of max PE number (256), the total
> size could be calculated by (vfs_expanded * VF_BAR_size).
>
> This patch simplifies the pnv_pci_iov_resource_alignment() by removing the
> first case.
>
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>   arch/powerpc/platforms/powernv/pci-ioda.c |   14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 8c031b5..e3e0acb 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2988,12 +2988,16 @@ static resource_size_t pnv_pci_iov_resource_alignment(struct pci_dev *pdev,
>   						      int resno)
>   {
>   	struct pci_dn *pdn = pci_get_pdn(pdev);
> -	resource_size_t align, iov_align;
> -
> -	iov_align = resource_size(&pdev->resource[resno]);
> -	if (iov_align)
> -		return iov_align;
> +	resource_size_t align;
>
> +	/*
> +	 * On PowerNV platform, IOV BAR is mapped by M64 BAR to enable the
> +	 * SR-IOV. While from hardware perspective, the range mapped by M64
> +	 * BAR should be size aligned.


Out of curiosity - IOV BAR does NOT have to be aligned on other platforms?


> +	 *
> +	 * This function returns the total IOV BAR size if expanded or just the
> +	 * individual size if not.

Expanded vs. non-expanded means "using shared M64" (when it is split by 256 
segments) vs. "using entire M64"?


> +	 */
>   	align = pci_iov_resource_size(pdev, resno);
>   	if (pdn->vfs_expanded)
>   		return pdn->vfs_expanded * align;
>


-- 
Alexey
