Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 223341A0D6D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 19:51:26 +1000 (AEST)
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
 [209.85.220.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 93DAC140273
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Oct 2015 19:51:23 +1000 (AEST)
Received: by pacfv12 with SMTP id fv12so104993124pac.2
 for <linuxppc-dev@ozlabs.org>; Fri, 02 Oct 2015 02:51:22 -0700 (PDT)
Subject: Re: [PATCH V4 5/6] powerpc/powernv: boundary the total VF BAR size
 instead of the individual one
To: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
 benh@kernel.crashing.org
References: <1439949704-8023-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1439949704-8023-6-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <560E5395.7080601@ozlabs.ru>
Date: Fri, 2 Oct 2015 19:51:17 +1000
MIME-Version: 1.0
In-Reply-To: <1439949704-8023-6-git-send-email-weiyang@linux.vnet.ibm.com>
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
> Each VF could have 6 BARs at most. When the total BAR size exceeds the
> gate, after expanding it will also exhaust the M64 Window.
>
> This patch limits the boundary by checking the total VF BAR size instead of
> the individual BAR.

The gate is the biggest segment size in PE in shared mode, right? And this 
is 64MB. Also, BARs with the same number of all VFs of the same physical 
adapter will be mapper contiguously (as one huge IOV BAR), for example, 2 
VFs, 2 BARs each, mapping will look like:
VF0-BAR0, VF1-BAR0, VF0-BAR1, VF1-BAR1
but not like this:
VF0-BAR0, VF0-BAR1, VF1-BAR0, VF1-BAR1
Is this correct?



>
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>   arch/powerpc/platforms/powernv/pci-ioda.c |   14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index b8bc51f..4bc83b8 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2701,7 +2701,7 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>   	const resource_size_t gate = phb->ioda.m64_segsize >> 2;
>   	struct resource *res;
>   	int i;
> -	resource_size_t size;
> +	resource_size_t size, total_vf_bar_sz;
>   	struct pci_dn *pdn;
>   	int mul, total_vfs;
>
> @@ -2714,6 +2714,7 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>
>   	total_vfs = pci_sriov_get_totalvfs(pdev);
>   	mul = phb->ioda.total_pe;
> +	total_vf_bar_sz = 0;
>
>   	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
>   		res = &pdev->resource[i + PCI_IOV_RESOURCES];
> @@ -2726,7 +2727,8 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>   			return;
>   		}
>
> -		size = pci_iov_resource_size(pdev, i + PCI_IOV_RESOURCES);
> +		total_vf_bar_sz += pci_iov_resource_size(pdev,
> +				i + PCI_IOV_RESOURCES);


Is @pdev a physical device in this context? I assume it is so 
pci_iov_resource_size() returns the entire IOV BAR size.
For example, I have a Mellanox card with 16 VFs, each has a single 32MB BAR 
so total_vf_bar_sz will be 16*32=512MB and this will exceed the @gate size 
and we end up having m64_single_mode = true. What do I miss here?


>
>   		/*
>   		 * If bigger than quarter of M64 segment size, just round up
> @@ -2740,11 +2742,11 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>   		 * limit the system flexibility.  This is a design decision to
>   		 * set the boundary to quarter of the M64 segment size.
>   		 */
> -		if (size > gate) {
> -			dev_info(&pdev->dev, "PowerNV: VF BAR%d: %pR IOV size "
> -				"is bigger than %lld, roundup power2\n",
> -				 i, res, gate);
> +		if (total_vf_bar_sz > gate) {
>   			mul = roundup_pow_of_two(total_vfs);
> +			dev_info(&pdev->dev,
> +				"VF BAR Total IOV size %llx > %llx, roundup to %d VFs\n",
> +				total_vf_bar_sz, gate, mul);
>   			pdn->m64_single_mode = true;
>   			break;
>   		}
>


-- 
Alexey
