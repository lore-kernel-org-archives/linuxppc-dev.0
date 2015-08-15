Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9B9D11A009B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2015 20:27:12 +1000 (AEST)
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
 [209.85.220.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 231961401AD
 for <linuxppc-dev@ozlabs.org>; Sat, 15 Aug 2015 20:27:11 +1000 (AEST)
Received: by paccq16 with SMTP id cq16so31756049pac.1
 for <linuxppc-dev@ozlabs.org>; Sat, 15 Aug 2015 03:27:09 -0700 (PDT)
Subject: Re: [PATCH v3 4/6] powerpc/powernv: replace the hard coded boundary
 with gate
To: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
 benh@kernel.crashing.org
References: <1439475071-7001-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1439475071-7001-5-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <55CF13F8.2070906@ozlabs.ru>
Date: Sat, 15 Aug 2015 20:27:04 +1000
MIME-Version: 1.0
In-Reply-To: <1439475071-7001-5-git-send-email-weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/14/2015 12:11 AM, Wei Yang wrote:
> At the moment 64bit-prefetchable window can be maximum 64GB, which is
> currently got from device tree. This means that in shared mode the maximum
> supported VF BAR size is 64GB/256=256MB. While this size could exhaust the
> whole 64bit-prefetchable window. This is a design decision to set a
> boundary to 64MB of the VF BAR size. Since VF BAR size with 64MB would
> occupy a quarter of the 64bit-prefetchable window, this is affordable.
>
> This patch replaces magic limit of 64MB with (m64_segsize >> 1) and adds
> comment to explain the reason for it.


Having m64_segsize divided in _halves_ is also magic (or is it a "design 
decision"?).


>
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> ---
>   arch/powerpc/platforms/powernv/pci-ioda.c |   22 +++++++++++++++++-----
>   1 file changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 4da0f50..3e8c0b4 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2688,7 +2688,7 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>   	struct pnv_phb *phb;
>   	struct resource *res;
>   	int i;
> -	resource_size_t size;
> +	resource_size_t size, gate;

It should be:
const resource_size_t gate = phb->ioda.m64_segsize >> 1;

as it never changes in the function.


>   	struct pci_dn *pdn;
>   	int mul, total_vfs;
>
> @@ -2704,6 +2704,17 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>
>   	total_vfs = pci_sriov_get_totalvfs(pdev);
>   	mul = phb->ioda.total_pe;
> +	/*
> +	 * If bigger than or equal to half of M64 segment size, just round up
> +	 * power of two.
> +	 *
> +	 * Generally, one M64 BAR maps one IOV BAR. To avoid conflict with
> +	 * other devices, IOV BAR size is expanded to be (total_pe *
> +	 * VF_BAR_size).  When VF_BAR_size is half of M64 segment size , the
> +	 * expanded size would equal to half of the whole M64 Space size,
> +	 * which will exhaust the M64 Space and limit the system flexibility.
> +	 */
> +	gate = phb->ioda.m64_segsize >> 1;
>
>   	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
>   		res = &pdev->resource[i + PCI_IOV_RESOURCES];
> @@ -2718,10 +2729,11 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>
>   		size = pci_iov_resource_size(pdev, i + PCI_IOV_RESOURCES);
>
> -		/* bigger than 64M */
> -		if (size > (1 << 26)) {
> -			dev_info(&pdev->dev, "PowerNV: VF BAR%d: %pR IOV size is bigger than 64M, roundup power2\n",
> -				 i, res);
> +		/* bigger than or equal to gate */


That multiline comment is better to be here, I think.


> +		if (size >= gate) {
> +			dev_info(&pdev->dev, "PowerNV: VF BAR%d: %pR IOV size "
> +				"is bigger than %lld, roundup power2\n",
> +				 i, res, gate);
>   			mul = roundup_pow_of_two(total_vfs);
>   			pdn->m64_single_mode = true;
>   			break;
>


-- 
Alexey
