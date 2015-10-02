Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EBDEE1A0FE0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 18:55:18 +1000 (AEST)
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
 [209.85.220.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6F4F91402D5
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Oct 2015 18:55:17 +1000 (AEST)
Received: by pacfv12 with SMTP id fv12so103699645pac.2
 for <linuxppc-dev@ozlabs.org>; Fri, 02 Oct 2015 01:55:15 -0700 (PDT)
Subject: Re: [PATCH V4 1/6] powerpc/powernv: don't enable SRIOV when VF BAR
 has non 64bit-prefetchable BAR
To: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
 benh@kernel.crashing.org
References: <1439949704-8023-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1439949704-8023-2-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <560E466E.9080901@ozlabs.ru>
Date: Fri, 2 Oct 2015 18:55:10 +1000
MIME-Version: 1.0
In-Reply-To: <1439949704-8023-2-git-send-email-weiyang@linux.vnet.ibm.com>
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
> On PHB_IODA2, we enable SRIOV devices by mapping IOV BAR with M64 BARs. If
> a SRIOV device's IOV BAR is not 64bit-prefetchable, this is not assigned
> from 64bit prefetchable window, which means M64 BAR can't work on it.


Please change the commit log to explain what limit came from where.
Something like:

PCI bridges support only 2 windows and the kernel code programs bridges in 
the way that one window is 32bit-nonprefetchable and another one is 
64bit-prefetchable. So if devices' IOV BAR is 64bit and non-prefetchable, 
it will be mapped into 32bit space and therefore M64 cannot be used for it.


>
> This patch makes this explicit.
>
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>   arch/powerpc/platforms/powernv/pci-ioda.c |   25 +++++++++----------------
>   1 file changed, 9 insertions(+), 16 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 85cbc96..8c031b5 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -908,9 +908,6 @@ static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
>   		if (!res->flags || !res->parent)
>   			continue;
>
> -		if (!pnv_pci_is_mem_pref_64(res->flags))
> -			continue;
> -
>   		/*
>   		 * The actual IOV BAR range is determined by the start address
>   		 * and the actual size for num_vfs VFs BAR.  This check is to
> @@ -939,9 +936,6 @@ static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
>   		if (!res->flags || !res->parent)
>   			continue;
>
> -		if (!pnv_pci_is_mem_pref_64(res->flags))
> -			continue;
> -
>   		size = pci_iov_resource_size(dev, i + PCI_IOV_RESOURCES);
>   		res2 = *res;
>   		res->start += size * offset;
> @@ -1221,9 +1215,6 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev, u16 num_vfs)
>   		if (!res->flags || !res->parent)
>   			continue;
>
> -		if (!pnv_pci_is_mem_pref_64(res->flags))
> -			continue;
> -
>   		for (j = 0; j < vf_groups; j++) {
>   			do {
>   				win = find_next_zero_bit(&phb->ioda.m64_bar_alloc,
> @@ -1510,6 +1501,12 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
>   	pdn = pci_get_pdn(pdev);
>
>   	if (phb->type == PNV_PHB_IODA2) {
> +		if (!pdn->vfs_expanded) {

The patch claims it does make the limitation explicit but it is not clear 
at all how to trace from vfs_expanded==0 to "non 64bit-prefetchable IOV BAR".


> +			dev_info(&pdev->dev, "don't support this SRIOV device"
> +				" with non 64bit-prefetchable IOV BAR\n");
> +			return -ENOSPC;
> +		}
> +
>   		/* Calculate available PE for required VFs */
>   		mutex_lock(&phb->ioda.pe_alloc_mutex);
>   		pdn->offset = bitmap_find_next_zero_area(
> @@ -2775,9 +2772,10 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>   		if (!res->flags || res->parent)
>   			continue;
>   		if (!pnv_pci_is_mem_pref_64(res->flags)) {
> -			dev_warn(&pdev->dev, " non M64 VF BAR%d: %pR\n",
> +			dev_warn(&pdev->dev, "Don't support SR-IOV with"
> +					" non M64 VF BAR%d: %pR. \n",
>   				 i, res);
> -			continue;
> +			return;
>   		}
>
>   		size = pci_iov_resource_size(pdev, i + PCI_IOV_RESOURCES);
> @@ -2796,11 +2794,6 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>   		res = &pdev->resource[i + PCI_IOV_RESOURCES];
>   		if (!res->flags || res->parent)
>   			continue;
> -		if (!pnv_pci_is_mem_pref_64(res->flags)) {


And this check was quite clear. I'd keep this one.


> -			dev_warn(&pdev->dev, "Skipping expanding VF BAR%d: %pR\n",
> -				 i, res);
> -			continue;
> -		}
>
>   		dev_dbg(&pdev->dev, " Fixing VF BAR%d: %pR to\n", i, res);
>   		size = pci_iov_resource_size(pdev, i + PCI_IOV_RESOURCES);
>


-- 
Alexey
