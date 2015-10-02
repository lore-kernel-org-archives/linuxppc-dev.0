Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 921351A08C8
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 20:05:55 +1000 (AEST)
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
 [209.85.220.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 18FC11400CB
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Oct 2015 20:05:54 +1000 (AEST)
Received: by padhy16 with SMTP id hy16so103253375pad.1
 for <linuxppc-dev@ozlabs.org>; Fri, 02 Oct 2015 03:05:52 -0700 (PDT)
Subject: Re: [PATCH V4 6/6] powerpc/powernv: allocate sparse PE# when using
 M64 BAR in Single PE mode
To: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
 benh@kernel.crashing.org
References: <1439949704-8023-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1439949704-8023-7-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <560E56FB.60208@ozlabs.ru>
Date: Fri, 2 Oct 2015 20:05:47 +1000
MIME-Version: 1.0
In-Reply-To: <1439949704-8023-7-git-send-email-weiyang@linux.vnet.ibm.com>
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
> When M64 BAR is set to Single PE mode, the PE# assigned to VF could be
> sparse.
>
> This patch restructures the patch to allocate sparse PE# for VFs when M64

This patch restructures the code ;)


> BAR is set to Single PE mode. Also it rename the offset to pe_num_map to
> reflect the content is the PE number.
>
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> ---
>   arch/powerpc/include/asm/pci-bridge.h     |    2 +-
>   arch/powerpc/platforms/powernv/pci-ioda.c |   79 ++++++++++++++++++++++-------
>   2 files changed, 61 insertions(+), 20 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
> index 8aeba4c..b3a226b 100644
> --- a/arch/powerpc/include/asm/pci-bridge.h
> +++ b/arch/powerpc/include/asm/pci-bridge.h
> @@ -213,7 +213,7 @@ struct pci_dn {
>   #ifdef CONFIG_PCI_IOV
>   	u16     vfs_expanded;		/* number of VFs IOV BAR expanded */
>   	u16     num_vfs;		/* number of VFs enabled*/
> -	int     offset;			/* PE# for the first VF PE */
> +	int     *pe_num_map;		/* PE# for the first VF PE or array */
>   	bool    m64_single_mode;	/* Use M64 BAR in Single Mode */
>   #define IODA_INVALID_M64        (-1)
>   	int     (*m64_map)[PCI_SRIOV_NUM_BARS];
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 4bc83b8..779f52a 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1243,7 +1243,7 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev, u16 num_vfs)
>
>   			/* Map the M64 here */
>   			if (pdn->m64_single_mode) {
> -				pe_num = pdn->offset + j;
> +				pe_num = pdn->pe_num_map[j];
>   				rc = opal_pci_map_pe_mmio_window(phb->opal_id,
>   						pe_num, OPAL_M64_WINDOW_TYPE,
>   						pdn->m64_map[j][i], 0);
> @@ -1347,7 +1347,7 @@ void pnv_pci_sriov_disable(struct pci_dev *pdev)
>   	struct pnv_phb        *phb;
>   	struct pci_dn         *pdn;
>   	struct pci_sriov      *iov;
> -	u16 num_vfs;
> +	u16                    num_vfs, i;
>
>   	bus = pdev->bus;
>   	hose = pci_bus_to_host(bus);
> @@ -1361,14 +1361,21 @@ void pnv_pci_sriov_disable(struct pci_dev *pdev)
>
>   	if (phb->type == PNV_PHB_IODA2) {
>   		if (!pdn->m64_single_mode)
> -			pnv_pci_vf_resource_shift(pdev, -pdn->offset);
> +			pnv_pci_vf_resource_shift(pdev, -*pdn->pe_num_map);
>
>   		/* Release M64 windows */
>   		pnv_pci_vf_release_m64(pdev, num_vfs);
>
>   		/* Release PE numbers */
> -		bitmap_clear(phb->ioda.pe_alloc, pdn->offset, num_vfs);
> -		pdn->offset = 0;
> +		if (pdn->m64_single_mode) {
> +			for (i = 0; i < num_vfs; i++) {
> +				if (pdn->pe_num_map[i] != IODA_INVALID_PE)
> +					pnv_ioda_free_pe(phb, pdn->pe_num_map[i]);
> +			}
> +		} else
> +			bitmap_clear(phb->ioda.pe_alloc, *pdn->pe_num_map, num_vfs);
> +		/* Releasing pe_num_map */
> +		kfree(pdn->pe_num_map);
>   	}
>   }
>
> @@ -1394,7 +1401,10 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
>
>   	/* Reserve PE for each VF */
>   	for (vf_index = 0; vf_index < num_vfs; vf_index++) {
> -		pe_num = pdn->offset + vf_index;
> +		if (pdn->m64_single_mode)
> +			pe_num = pdn->pe_num_map[vf_index];
> +		else
> +			pe_num = *pdn->pe_num_map + vf_index;
>
>   		pe = &phb->ioda.pe_array[pe_num];
>   		pe->pe_number = pe_num;
> @@ -1436,6 +1446,7 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
>   	struct pnv_phb        *phb;
>   	struct pci_dn         *pdn;
>   	int                    ret;
> +	u16                    i;
>
>   	bus = pdev->bus;
>   	hose = pci_bus_to_host(bus);
> @@ -1458,20 +1469,42 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
>   			return -EBUSY;
>   		}
>
> +		/* Allocating pe_num_map */
> +		if (pdn->m64_single_mode)
> +			pdn->pe_num_map = kmalloc(sizeof(*pdn->pe_num_map) * num_vfs,
> +					GFP_KERNEL);
> +		else
> +			pdn->pe_num_map = kmalloc(sizeof(*pdn->pe_num_map), GFP_KERNEL);
> +
> +		if (!pdn->pe_num_map)
> +			return -ENOMEM;

[*]

> +
>   		/* Calculate available PE for required VFs */
> -		mutex_lock(&phb->ioda.pe_alloc_mutex);
> -		pdn->offset = bitmap_find_next_zero_area(
> -			phb->ioda.pe_alloc, phb->ioda.total_pe,
> -			0, num_vfs, 0);
> -		if (pdn->offset >= phb->ioda.total_pe) {
> +		if (pdn->m64_single_mode) {
> +			for (i = 0; i < num_vfs; i++)
> +				pdn->pe_num_map[i] = IODA_INVALID_PE;

It is cleaner to do such initialization right after the check that 
kmalloc() did not fail, i.e. at [*]


> +			for (i = 0; i < num_vfs; i++) {
> +				pdn->pe_num_map[i] = pnv_ioda_alloc_pe(phb);
> +				if (pdn->pe_num_map[i] == IODA_INVALID_PE) {
> +					ret = -EBUSY;
> +					goto m64_failed;
> +				}
> +			}
> +		} else {
> +			mutex_lock(&phb->ioda.pe_alloc_mutex);
> +			*pdn->pe_num_map = bitmap_find_next_zero_area(
> +				phb->ioda.pe_alloc, phb->ioda.total_pe,
> +				0, num_vfs, 0);
> +			if (*pdn->pe_num_map >= phb->ioda.total_pe) {
> +				mutex_unlock(&phb->ioda.pe_alloc_mutex);
> +				dev_info(&pdev->dev, "Failed to enable VF%d\n", num_vfs);
> +				kfree(pdn->pe_num_map);
> +				return -EBUSY;
> +			}
> +			bitmap_set(phb->ioda.pe_alloc, *pdn->pe_num_map, num_vfs);
>   			mutex_unlock(&phb->ioda.pe_alloc_mutex);
> -			dev_info(&pdev->dev, "Failed to enable VF%d\n", num_vfs);
> -			pdn->offset = 0;
> -			return -EBUSY;
>   		}
> -		bitmap_set(phb->ioda.pe_alloc, pdn->offset, num_vfs);
>   		pdn->num_vfs = num_vfs;
> -		mutex_unlock(&phb->ioda.pe_alloc_mutex);
>
>   		/* Assign M64 window accordingly */
>   		ret = pnv_pci_vf_assign_m64(pdev, num_vfs);
> @@ -1486,7 +1519,7 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
>   		 * Otherwise, the PE# for the VF will conflict with others.
>   		 */
>   		if (!pdn->m64_single_mode) {
> -			ret = pnv_pci_vf_resource_shift(pdev, pdn->offset);
> +			ret = pnv_pci_vf_resource_shift(pdev, *pdn->pe_num_map);
>   			if (ret)
>   				goto m64_failed;
>   		}
> @@ -1498,8 +1531,16 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
>   	return 0;
>
>   m64_failed:
> -	bitmap_clear(phb->ioda.pe_alloc, pdn->offset, num_vfs);
> -	pdn->offset = 0;
> +	if (pdn->m64_single_mode) {
> +		for (i = 0; i < num_vfs; i++) {
> +			if (pdn->pe_num_map[i] != IODA_INVALID_PE)
> +				pnv_ioda_free_pe(phb, pdn->pe_num_map[i]);
> +		}
> +	} else
> +		bitmap_clear(phb->ioda.pe_alloc, *pdn->pe_num_map, num_vfs);
> +
> +	/* Releasing pe_num_map */
> +	kfree(pdn->pe_num_map);
>
>   	return ret;
>   }
>


-- 
Alexey
