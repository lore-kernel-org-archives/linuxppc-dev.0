Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zBH9D1BHhzF0Py
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jan 2018 14:53:51 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 w033rlQd096060
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Jan 2018 22:53:49 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2f8p2htjf7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jan 2018 22:53:48 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 3 Jan 2018 03:53:44 -0000
Subject: Re: [PATCH 01/13] powerpc/powernv: Introduce new PHB type for
 opencapi links
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, mpe@ellerman.id.au,
 alastair@au1.ibm.com
References: <cover.1513608243.git.fbarrat@linux.vnet.ibm.com>
 <6870a754d346e7d8a47325e5ba4327853aea9226.1513608243.git.fbarrat@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 3 Jan 2018 14:53:38 +1100
MIME-Version: 1.0
In-Reply-To: <6870a754d346e7d8a47325e5ba4327853aea9226.1513608243.git.fbarrat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <c4cfdd4c-6baa-f62f-886a-b548ed6cb243@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 19/12/17 02:21, Frederic Barrat wrote:
> The NPU was already abstracted by opal as a virtual PHB for nvlink,
> but it helps to be able to differentiate between a nvlink or opencapi
> PHB, as it's not completely transparent to linux. In particular, PE
> assignment differs and we'll also need the information in later
> patches.
> 
> So rename existing PNV_PHB_NPU type to PNV_PHB_NPU_NVLINK and add a
> new type PNV_PHB_NPU_OCAPI.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> ---
>   arch/powerpc/platforms/powernv/npu-dma.c  |  2 +-
>   arch/powerpc/platforms/powernv/pci-ioda.c | 46 +++++++++++++++++++++++--------
>   arch/powerpc/platforms/powernv/pci.c      |  4 +++
>   arch/powerpc/platforms/powernv/pci.h      |  8 ++++--
>   4 files changed, 45 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
> index f6cbc1a71472..c5899c107d59 100644
> --- a/arch/powerpc/platforms/powernv/npu-dma.c
> +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> @@ -277,7 +277,7 @@ static int pnv_npu_dma_set_bypass(struct pnv_ioda_pe *npe)
>   	int64_t rc = 0;
>   	phys_addr_t top = memblock_end_of_DRAM();
> 
> -	if (phb->type != PNV_PHB_NPU || !npe->pdev)
> +	if (phb->type != PNV_PHB_NPU_NVLINK || !npe->pdev)
>   		return -EINVAL;
> 
>   	rc = pnv_npu_unset_window(npe, 0);
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 749055553064..c37b5d288f9c 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -54,7 +54,8 @@
>   #define POWERNV_IOMMU_DEFAULT_LEVELS	1
>   #define POWERNV_IOMMU_MAX_LEVELS	5
> 
> -static const char * const pnv_phb_names[] = { "IODA1", "IODA2", "NPU" };
> +static const char * const pnv_phb_names[] = { "IODA1", "IODA2", "NPU_NVLINK",
> +					      "NPU_OCAPI" };
>   static void pnv_pci_ioda2_table_free_pages(struct iommu_table *tbl);
> 
>   void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
> @@ -924,7 +925,7 @@ static int pnv_ioda_configure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
>   	 * Configure PELTV. NPUs don't have a PELTV table so skip
>   	 * configuration on them.
>   	 */
> -	if (phb->type != PNV_PHB_NPU)
> +	if (phb->type != PNV_PHB_NPU_NVLINK && phb->type != PNV_PHB_NPU_OCAPI)
>   		pnv_ioda_set_peltv(phb, pe, true);
> 
>   	/* Setup reverse map */
> @@ -1260,12 +1261,13 @@ static struct pnv_ioda_pe *pnv_ioda_setup_npu_PE(struct pci_dev *npu_pdev)
>   		return pe;
>   }
> 
> -static void pnv_ioda_setup_npu_PEs(struct pci_bus *bus)
> +static void pnv_ioda_setup_npu_PEs(struct pci_bus *bus,
> +			    struct pnv_ioda_pe *fn(struct pci_dev *npu_pdev))
>   {
>   	struct pci_dev *pdev;
> 
>   	list_for_each_entry(pdev, &bus->devices, bus_list)
> -		pnv_ioda_setup_npu_PE(pdev);
> +		fn(pdev);
>   }

I think adding a function pointer here is rather ugly, at this point you 
might as well just do this directly in pnv_pci_ioda_setup_PEs()

> 
>   static void pnv_pci_ioda_setup_PEs(void)
> @@ -1275,13 +1277,18 @@ static void pnv_pci_ioda_setup_PEs(void)
> 
>   	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
>   		phb = hose->private_data;
> -		if (phb->type == PNV_PHB_NPU) {
> +		if (phb->type == PNV_PHB_NPU_NVLINK) {
>   			/* PE#0 is needed for error reporting */
>   			pnv_ioda_reserve_pe(phb, 0);
> -			pnv_ioda_setup_npu_PEs(hose->bus);
> +			pnv_ioda_setup_npu_PEs(hose->bus,
> +					pnv_ioda_setup_npu_PE);
>   			if (phb->model == PNV_PHB_MODEL_NPU2)
>   				pnv_npu2_init(phb);
>   		}
> +		if (phb->type == PNV_PHB_NPU_OCAPI) {
> +			pnv_ioda_setup_npu_PEs(hose->bus,
> +					pnv_ioda_setup_dev_PE);
> +		}
>   	}
>   }
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
